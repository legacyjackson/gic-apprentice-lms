-- ============================================================================
-- GIC APPRENTICE LMS — MASTER SETUP  (PART 1 of 2)
-- Sections 1–8: Base schema, sessions, modules 1–18
-- Run Part 1 first, then run Part 2.
-- ============================================================================


-- ── session1_base_schema.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — SESSION 1 BASE SCHEMA
-- Rebuild the foundation: enum, profiles, modules, triggers, auth hook.
-- Fully idempotent — safe to run on empty DB or partial schema.
--
-- Run BEFORE: session2_setup.sql, any module*_content.sql, final_exam_setup.sql
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 0. Extensions
-- ----------------------------------------------------------------------------
create extension if not exists "pgcrypto";  -- for gen_random_uuid()

-- ----------------------------------------------------------------------------
-- 1. user_role enum
-- ----------------------------------------------------------------------------
do $$
begin
  if not exists (select 1 from pg_type where typname = 'user_role') then
    create type public.user_role as enum (
      'apprentice', 'mentor', 'admin', 'approver'
    );
    raise notice 'Created user_role enum';
  else
    raise notice 'user_role enum already exists';
  end if;
end$$;

alter type public.user_role add value if not exists 'apprentice';
alter type public.user_role add value if not exists 'mentor';
alter type public.user_role add value if not exists 'admin';
alter type public.user_role add value if not exists 'approver';

-- ----------------------------------------------------------------------------
-- 2. updated_at trigger function (used by every table with updated_at)
-- ----------------------------------------------------------------------------
create or replace function public.tg_set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- ----------------------------------------------------------------------------
-- 3. profiles table — maps to auth.users
-- ----------------------------------------------------------------------------
create table if not exists public.profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  email         text unique not null,
  full_name     text,
  role          public.user_role not null default 'apprentice',
  metadata      jsonb not null default '{}'::jsonb,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

create index if not exists profiles_role_idx on public.profiles(role);
create index if not exists profiles_email_idx on public.profiles(email);

-- updated_at trigger
drop trigger if exists profiles_set_updated_at on public.profiles;
create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function public.tg_set_updated_at();

-- ----------------------------------------------------------------------------
-- 4a. Role helper — SECURITY DEFINER bypasses RLS so policies can safely
--     read the caller's own profile row without triggering recursion.
-- ----------------------------------------------------------------------------
create or replace function public.get_my_role()
returns text
language sql
security definer
stable
set search_path = public
as $$
  select role::text from public.profiles where id = auth.uid();
$$;

-- ----------------------------------------------------------------------------
-- 4b. profiles RLS
-- ----------------------------------------------------------------------------
alter table public.profiles enable row level security;

drop policy if exists "profiles_self_read" on public.profiles;
create policy "profiles_self_read"
  on public.profiles for select
  using (auth.uid() = id);

drop policy if exists "profiles_admin_read_all" on public.profiles;
create policy "profiles_admin_read_all"
  on public.profiles for select
  using (
    public.get_my_role() in ('admin', 'approver', 'mentor')
  );

drop policy if exists "profiles_self_update" on public.profiles;
create policy "profiles_self_update"
  on public.profiles for update
  using (auth.uid() = id);

drop policy if exists "profiles_admin_update" on public.profiles;
create policy "profiles_admin_update"
  on public.profiles for update
  using (
    public.get_my_role() in ('admin', 'approver')
  );

-- ----------------------------------------------------------------------------
-- 5. Auto-create profile when a new user signs up via Supabase auth.
--     Auto-promote cathy → approver, julius → admin by email.
-- ----------------------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, role, full_name)
  values (
    new.id,
    new.email,
    case lower(new.email)
      when 'cathy@globalinvestmentcompanies.com' then 'approver'::public.user_role
      when 'julius@globalinvestmentcompanies.com' then 'admin'::public.user_role
      else 'apprentice'::public.user_role
    end,
    coalesce(
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name',
      split_part(new.email, '@', 1)
    )
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ----------------------------------------------------------------------------
-- 6. modules table
-- ----------------------------------------------------------------------------
create table if not exists public.modules (
  id                    uuid primary key default gen_random_uuid(),
  module_number         integer unique not null,
  title                 text not null default '',
  competency_id         text,
  ri_hours              integer not null default 0,
  ojl_hours             integer not null default 0,
  short_description     text not null default '',
  learning_objectives   text[] not null default array[]::text[],
  content               jsonb not null default '{}'::jsonb,
  is_published          boolean not null default true,
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now()
);

create index if not exists modules_module_number_idx on public.modules(module_number);

drop trigger if exists modules_set_updated_at on public.modules;
create trigger modules_set_updated_at
  before update on public.modules
  for each row execute function public.tg_set_updated_at();

-- ----------------------------------------------------------------------------
-- 7. modules RLS
-- ----------------------------------------------------------------------------
alter table public.modules enable row level security;

drop policy if exists "modules_authenticated_read" on public.modules;
create policy "modules_authenticated_read"
  on public.modules for select
  using (auth.role() = 'authenticated');

drop policy if exists "modules_admin_write" on public.modules;
create policy "modules_admin_write"
  on public.modules for all
  using (
    public.get_my_role() in ('admin', 'approver')
  );

-- ----------------------------------------------------------------------------
-- 8. Seed 30 module rows so subsequent UPDATE statements work
-- ----------------------------------------------------------------------------
insert into public.modules (module_number, title)
select n, 'Module ' || n || ' — pending content'
from generate_series(1, 30) n
on conflict (module_number) do nothing;

-- ----------------------------------------------------------------------------
-- 9. module_progress — tracks per-user lesson + quiz completion
-- ----------------------------------------------------------------------------
create table if not exists public.module_progress (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references auth.users(id) on delete cascade,
  module_number   integer not null,
  lessons_completed text[] not null default array[]::text[],
  status          text not null default 'not_started'
                    check (status in ('not_started', 'in_progress', 'completed')),
  quiz_score      integer,
  quiz_attempts   integer not null default 0,
  quiz_passed     boolean not null default false,
  started_at      timestamptz,
  completed_at    timestamptz,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  unique(user_id, module_number)
);

create index if not exists module_progress_user_idx on public.module_progress(user_id);
create index if not exists module_progress_module_idx on public.module_progress(module_number);

drop trigger if exists module_progress_set_updated_at on public.module_progress;
create trigger module_progress_set_updated_at
  before update on public.module_progress
  for each row execute function public.tg_set_updated_at();

alter table public.module_progress enable row level security;

drop policy if exists "progress_own_read" on public.module_progress;
create policy "progress_own_read"
  on public.module_progress for select
  using (
    user_id = auth.uid()
    or public.get_my_role() in ('admin', 'approver', 'mentor')
  );

drop policy if exists "progress_own_write" on public.module_progress;
create policy "progress_own_write"
  on public.module_progress for all
  using (user_id = auth.uid());

-- ----------------------------------------------------------------------------
-- 10. Verification — run these manually after to confirm setup
-- ----------------------------------------------------------------------------
-- select unnest(enum_range(null::public.user_role))::text as role_values;
-- select count(*) as profile_count from public.profiles;
-- select count(*) as module_count from public.modules;  -- should be 30
-- select module_number, title from public.modules order by module_number limit 5;

-- ============================================================================
-- DONE. Now run:
--   1) session2_setup.sql      (will succeed — user_role and profiles exist)
--   2) module1_content.sql  through  module30_content.sql
--   3) final_exam_setup.sql
-- ============================================================================

-- ── fix_user_role_enum.sql ──

-- ============================================================================
-- FIX: Create user_role enum if missing
-- Run this BEFORE session2_setup.sql if you hit:
--   ERROR: 42704: type "user_role" does not exist
-- Idempotent — safe to run more than once.
-- ============================================================================

-- Step 1: Create the enum type if it doesn't exist at all
do $$
begin
  if not exists (select 1 from pg_type where typname = 'user_role') then
    create type public.user_role as enum (
      'apprentice',
      'mentor',
      'admin',
      'approver'
    );
    raise notice 'Created user_role enum with all four values';
  else
    raise notice 'user_role enum already exists — will add any missing values';
  end if;
end$$;

-- Step 2: Ensure all required values exist (no-op if already present)
-- These ALTER TYPE statements must run outside a DO block in older Postgres,
-- but in PG12+ (Supabase runs PG15+) they're fine here as standalone statements.
alter type public.user_role add value if not exists 'apprentice';
alter type public.user_role add value if not exists 'mentor';
alter type public.user_role add value if not exists 'admin';
alter type public.user_role add value if not exists 'approver';

-- Step 3: Verify — should show all four roles
select unnest(enum_range(null::public.user_role))::text as role_values
order by 1;

-- ── fix_rls_recursion.sql ──

-- ============================================================================
-- HOTFIX: Eliminate infinite recursion in profiles RLS policies
--
-- Root cause: policies on public.profiles queried public.profiles to check
-- the caller's role, creating an infinite loop.
--
-- Fix: replace those subqueries with a SECURITY DEFINER helper function
-- (get_my_role) that bypasses RLS when reading the caller's own row.
--
-- Safe to run on a live database. Idempotent.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Helper: get the current user's role without triggering RLS
-- ----------------------------------------------------------------------------
create or replace function public.get_my_role()
returns text
language sql
security definer          -- runs as the function owner (postgres), bypasses RLS
stable
set search_path = public
as $$
  select role::text from public.profiles where id = auth.uid();
$$;

-- ----------------------------------------------------------------------------
-- 2. Fix profiles policies — drop recursive ones, recreate cleanly
-- ----------------------------------------------------------------------------
drop policy if exists "profiles_admin_read_all"  on public.profiles;
drop policy if exists "profiles_admin_update"    on public.profiles;

-- Admins/approvers/mentors can read every profile
create policy "profiles_admin_read_all"
  on public.profiles for select
  using (
    public.get_my_role() in ('admin', 'approver', 'mentor')
  );

-- Admins/approvers can update any profile
create policy "profiles_admin_update"
  on public.profiles for update
  using (
    public.get_my_role() in ('admin', 'approver')
  );

-- ----------------------------------------------------------------------------
-- 3. Fix modules policy
-- ----------------------------------------------------------------------------
drop policy if exists "modules_admin_write" on public.modules;

create policy "modules_admin_write"
  on public.modules for all
  using (
    public.get_my_role() in ('admin', 'approver')
  );

-- ----------------------------------------------------------------------------
-- 4. Fix module_progress policy
-- ----------------------------------------------------------------------------
drop policy if exists "progress_own_read" on public.module_progress;

create policy "progress_own_read"
  on public.module_progress for select
  using (
    user_id = auth.uid()
    or public.get_my_role() in ('admin', 'approver', 'mentor')
  );

-- ----------------------------------------------------------------------------
-- 5. Verify — should return your role, not error
-- ----------------------------------------------------------------------------
select public.get_my_role() as my_role;
-- ============================================================================

-- ── session2_setup.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — SESSION 2 SCHEMA MIGRATION
-- ============================================================================
-- Adds:
--   1. 'mentor' role + mentor assignment on profiles
--   2. Employer sponsors + sponsorship tokens (apprentice enrollment via code)
--   3. Competency submissions (apprentice video uploads + mentor sign-off)
--   4. RPCs called by Netlify Functions
--   5. RLS policies + realtime
--
-- Run this AFTER supabase_setup.sql.
-- Safe to re-run; uses `if not exists` / `do nothing` / `or replace` throughout.
-- ============================================================================

-- ============================================================================
-- 1. EXTEND user_role ENUM WITH 'mentor'
-- ============================================================================
do $$
begin
  if not exists (
    select 1 from pg_enum
    where enumlabel = 'mentor'
      and enumtypid = (select oid from pg_type where typname = 'user_role')
  ) then
    alter type user_role add value 'mentor';
  end if;
end$$;

-- ============================================================================
-- 2. EMPLOYER SPONSORS
-- ============================================================================
create table if not exists employer_sponsors (
  id              uuid primary key default gen_random_uuid(),
  name            text not null,
  contact_name    text,
  contact_email   text,
  contact_phone   text,
  address         text,
  notes           text,
  active          boolean not null default true,
  created_by      uuid references profiles(id) on delete set null,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

create index if not exists idx_employer_sponsors_active on employer_sponsors(active);

-- ============================================================================
-- 3. SPONSORSHIP TOKENS
-- ============================================================================
-- Tokens are one-or-multi-use codes that link a new apprentice to a sponsor.
-- Format: 8-char base32 (e.g. "GIC-K3X9-A7BM"). Stored uppercased.
create table if not exists sponsorship_tokens (
  id                uuid primary key default gen_random_uuid(),
  token             text unique not null,
  employer_sponsor_id uuid not null references employer_sponsors(id) on delete cascade,
  max_uses          int not null default 1,
  uses              int not null default 0,
  expires_at        timestamptz,
  created_by        uuid references profiles(id) on delete set null,
  created_at        timestamptz not null default now()
);

create index if not exists idx_sponsorship_tokens_token on sponsorship_tokens(token);
create index if not exists idx_sponsorship_tokens_employer on sponsorship_tokens(employer_sponsor_id);

-- ============================================================================
-- 4. EXTEND profiles: mentor_id + employer_sponsor_id
-- ============================================================================
alter table profiles
  add column if not exists mentor_id           uuid references profiles(id) on delete set null;
alter table profiles
  add column if not exists employer_sponsor_id uuid references employer_sponsors(id) on delete set null;
alter table profiles
  add column if not exists enrolled_via_token  text;

create index if not exists idx_profiles_mentor on profiles(mentor_id);
create index if not exists idx_profiles_sponsor on profiles(employer_sponsor_id);

-- ============================================================================
-- 5. COMPETENCY SUBMISSIONS — apprentice video uploads + mentor review
-- ============================================================================
do $$
begin
  if not exists (select 1 from pg_type where typname = 'submission_status') then
    create type submission_status as enum (
      'submitted',
      'under_review',
      'approved',
      'needs_revision'
    );
  end if;
end$$;

create table if not exists competency_submissions (
  id                  uuid primary key default gen_random_uuid(),
  apprentice_id       uuid not null references profiles(id) on delete cascade,
  module_id           uuid not null references modules(id) on delete cascade,
  video_path          text not null,                       -- DO Spaces object key
  video_mime          text,
  duration_seconds    int,
  size_bytes          bigint,
  apprentice_notes    text,
  status              submission_status not null default 'submitted',
  mentor_id           uuid references profiles(id) on delete set null,
  mentor_feedback     text,
  ojl_hours_credited  numeric(5,2) default 0,
  submitted_at        timestamptz not null default now(),
  reviewed_at         timestamptz,
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);

create index if not exists idx_submissions_apprentice on competency_submissions(apprentice_id);
create index if not exists idx_submissions_mentor on competency_submissions(mentor_id);
create index if not exists idx_submissions_module on competency_submissions(module_id);
create index if not exists idx_submissions_status on competency_submissions(status);

-- Auto-update updated_at trigger (reuses existing trigger fn from setup)
drop trigger if exists tr_submissions_updated_at on competency_submissions;
create trigger tr_submissions_updated_at
  before update on competency_submissions
  for each row execute function tg_set_updated_at();

drop trigger if exists tr_sponsors_updated_at on employer_sponsors;
create trigger tr_sponsors_updated_at
  before update on employer_sponsors
  for each row execute function tg_set_updated_at();

-- ============================================================================
-- 6. RPC: redeem_sponsorship_token
-- ============================================================================
-- Called by the enroll Netlify Function (server-side, with service-role key).
-- Validates token, increments use count, returns sponsor_id if valid.
-- Returns NULL if token is invalid/expired/exhausted.
create or replace function redeem_sponsorship_token(p_token text)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_row sponsorship_tokens%rowtype;
begin
  select * into v_row
    from sponsorship_tokens
   where token = upper(trim(p_token));

  if not found                                       then return null; end if;
  if v_row.expires_at is not null
     and v_row.expires_at < now()                    then return null; end if;
  if v_row.uses >= v_row.max_uses                    then return null; end if;

  update sponsorship_tokens
     set uses = uses + 1
   where id = v_row.id;

  return v_row.employer_sponsor_id;
end;
$$;

-- ============================================================================
-- 7. RPC: peek_token_validity (no side effects, used for client preview)
-- ============================================================================
create or replace function peek_token_validity(p_token text)
returns table(
  valid boolean,
  sponsor_name text,
  reason text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_row sponsorship_tokens%rowtype;
  v_sponsor employer_sponsors%rowtype;
begin
  select * into v_row
    from sponsorship_tokens
   where token = upper(trim(p_token));

  if not found then
    return query select false, null::text, 'Token not recognized.'::text;
    return;
  end if;

  if v_row.expires_at is not null and v_row.expires_at < now() then
    return query select false, null::text, 'Token has expired.'::text;
    return;
  end if;

  if v_row.uses >= v_row.max_uses then
    return query select false, null::text, 'Token has reached its usage limit.'::text;
    return;
  end if;

  select * into v_sponsor from employer_sponsors where id = v_row.employer_sponsor_id;
  return query select true, v_sponsor.name, null::text;
end;
$$;

grant execute on function peek_token_validity(text) to anon, authenticated;
-- redeem_sponsorship_token is only called by the service role via Netlify Function
revoke all on function redeem_sponsorship_token(text) from public, anon, authenticated;

-- ============================================================================
-- 8. ENABLE RLS ON NEW TABLES
-- ============================================================================
alter table employer_sponsors       enable row level security;
alter table sponsorship_tokens      enable row level security;
alter table competency_submissions  enable row level security;

-- ============================================================================
-- 9. RLS POLICIES — employer_sponsors
-- ============================================================================
-- Admins and approvers manage. Apprentices read their own sponsor.
drop policy if exists "sponsors_admin_all"      on employer_sponsors;
drop policy if exists "sponsors_apprentice_own" on employer_sponsors;

create policy "sponsors_admin_all" on employer_sponsors
  for all using (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.role in ('admin','approver')
    )
  ) with check (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.role in ('admin','approver')
    )
  );

create policy "sponsors_apprentice_own" on employer_sponsors
  for select using (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.employer_sponsor_id = employer_sponsors.id
    )
  );

-- ============================================================================
-- 10. RLS POLICIES — sponsorship_tokens (admin/approver only)
-- ============================================================================
drop policy if exists "tokens_admin_all" on sponsorship_tokens;

create policy "tokens_admin_all" on sponsorship_tokens
  for all using (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.role in ('admin','approver')
    )
  ) with check (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.role in ('admin','approver')
    )
  );

-- ============================================================================
-- 11. RLS POLICIES — competency_submissions
-- ============================================================================
drop policy if exists "submissions_apprentice_select" on competency_submissions;
drop policy if exists "submissions_apprentice_insert" on competency_submissions;
drop policy if exists "submissions_apprentice_update" on competency_submissions;
drop policy if exists "submissions_mentor_select"     on competency_submissions;
drop policy if exists "submissions_mentor_update"     on competency_submissions;
drop policy if exists "submissions_admin_all"         on competency_submissions;

-- Apprentices read & insert their own; can update only if status = needs_revision
create policy "submissions_apprentice_select" on competency_submissions
  for select using (apprentice_id = auth.uid());

create policy "submissions_apprentice_insert" on competency_submissions
  for insert with check (apprentice_id = auth.uid());

create policy "submissions_apprentice_update" on competency_submissions
  for update using (
    apprentice_id = auth.uid()
    and status = 'needs_revision'
  ) with check (
    apprentice_id = auth.uid()
  );

-- Mentors see submissions from their assigned apprentices; can update status/feedback
create policy "submissions_mentor_select" on competency_submissions
  for select using (
    exists (
      select 1 from profiles p
       where p.id = auth.uid()
         and p.role = 'mentor'
         and (p.id = competency_submissions.mentor_id
              or exists (
                 select 1 from profiles ap
                  where ap.id = competency_submissions.apprentice_id
                    and ap.mentor_id = auth.uid()
              ))
    )
  );

create policy "submissions_mentor_update" on competency_submissions
  for update using (
    exists (
      select 1 from profiles p
       where p.id = auth.uid()
         and p.role = 'mentor'
         and exists (
            select 1 from profiles ap
             where ap.id = competency_submissions.apprentice_id
               and ap.mentor_id = auth.uid()
         )
    )
  );

-- Admins & approvers see and manage all
create policy "submissions_admin_all" on competency_submissions
  for all using (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.role in ('admin','approver')
    )
  ) with check (
    exists (
      select 1 from profiles
       where profiles.id = auth.uid()
         and profiles.role in ('admin','approver')
    )
  );

-- ============================================================================
-- 12. EXTEND profiles RLS — mentors can see their assigned apprentices
-- ============================================================================
drop policy if exists "profiles_mentor_view_mentees" on profiles;
create policy "profiles_mentor_view_mentees" on profiles
  for select using (
    mentor_id = auth.uid()
  );

-- ============================================================================
-- 13. REALTIME
-- ============================================================================
do $$
begin
  perform 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'competency_submissions';
  if not found then
    alter publication supabase_realtime add table competency_submissions;
  end if;

  perform 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'employer_sponsors';
  if not found then
    alter publication supabase_realtime add table employer_sponsors;
  end if;
end$$;

-- ============================================================================
-- DONE.
-- Next: paste Netlify env vars (DO_SPACES_*, OPENAI_API_KEY, SUPABASE_SERVICE_ROLE_KEY)
-- ============================================================================

-- ── session4_admin_questions.sql ──

-- ============================================================
-- SESSION 4: Admin users, questions table, question_answers,
--            Module 1 metadata update
-- ============================================================

-- ============================================================
-- 1. Update handle_new_user trigger to make ricky@ an admin
-- ============================================================
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
    CASE
      WHEN NEW.email ILIKE 'ricky@%'  THEN 'admin'
      WHEN NEW.email ILIKE 'julius@%' THEN 'admin'
      WHEN NEW.email ILIKE 'cathy@%'  THEN 'approver'
      ELSE 'apprentice'
    END
  )
  ON CONFLICT (id) DO UPDATE SET
    email     = EXCLUDED.email,
    full_name = COALESCE(EXCLUDED.full_name, profiles.full_name),
    role      = EXCLUDED.role;
  RETURN NEW;
END;
$$;

-- ============================================================
-- 2. Upsert ricky's profile as admin if they already exist
-- ============================================================
UPDATE public.profiles
SET role = 'admin'
WHERE email ILIKE 'ricky@%';

-- If ricky exists in auth.users but not profiles, insert them.
-- (Safe to run multiple times — ON CONFLICT handles it.)
INSERT INTO public.profiles (id, email, full_name, role)
SELECT
  au.id,
  au.email,
  COALESCE(au.raw_user_meta_data->>'full_name', split_part(au.email, '@', 1)),
  'admin'
FROM auth.users au
WHERE au.email ILIKE 'ricky@%'
ON CONFLICT (id) DO UPDATE SET role = 'admin';

-- ============================================================
-- 3. Update julius@ profile to admin (not just trusting trigger)
-- ============================================================
UPDATE public.profiles
SET role = 'admin'
WHERE email ILIKE 'julius@%';

INSERT INTO public.profiles (id, email, full_name, role)
SELECT
  au.id,
  au.email,
  COALESCE(au.raw_user_meta_data->>'full_name', split_part(au.email, '@', 1)),
  'admin'
FROM auth.users au
WHERE au.email ILIKE 'julius@%'
ON CONFLICT (id) DO UPDATE SET role = 'admin';

-- ============================================================
-- 4. Create questions table
-- ============================================================
CREATE TABLE IF NOT EXISTS public.questions (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  asker_id       UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_number  INT,
  lesson_index   INT,
  lesson_title   TEXT,
  question_text  TEXT NOT NULL,
  status         TEXT NOT NULL DEFAULT 'open'
                   CHECK (status IN ('open', 'resolved')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS questions_updated_at ON public.questions;
CREATE TRIGGER questions_updated_at
  BEFORE UPDATE ON public.questions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ============================================================
-- 5. Create question_answers table
-- ============================================================
CREATE TABLE IF NOT EXISTS public.question_answers (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id    UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  responder_id   UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  responder_name TEXT,
  answer_text    TEXT NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ============================================================
-- 6. RLS policies for questions and question_answers
-- ============================================================

ALTER TABLE public.questions        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_answers ENABLE ROW LEVEL SECURITY;

-- ---- questions policies ----

-- Apprentices can insert their own questions
DROP POLICY IF EXISTS "questions_insert_own" ON public.questions;
CREATE POLICY "questions_insert_own" ON public.questions
  FOR INSERT TO authenticated
  WITH CHECK (asker_id = auth.uid());

-- Apprentices can read their own questions
DROP POLICY IF EXISTS "questions_select_own" ON public.questions;
CREATE POLICY "questions_select_own" ON public.questions
  FOR SELECT TO authenticated
  USING (
    asker_id = auth.uid()
    OR get_my_role() IN ('mentor', 'admin', 'approver')
  );

-- Apprentices can update their own open questions; mentors/admins can update status
DROP POLICY IF EXISTS "questions_update_own" ON public.questions;
CREATE POLICY "questions_update_own" ON public.questions
  FOR UPDATE TO authenticated
  USING (
    asker_id = auth.uid()
    OR get_my_role() IN ('mentor', 'admin', 'approver')
  );

-- ---- question_answers policies ----

-- Mentors, admins, and approvers can insert answers
DROP POLICY IF EXISTS "question_answers_insert_mentor" ON public.question_answers;
CREATE POLICY "question_answers_insert_mentor" ON public.question_answers
  FOR INSERT TO authenticated
  WITH CHECK (
    get_my_role() IN ('mentor', 'admin', 'approver')
  );

-- Anyone can read answers to their own questions; mentors/admins can read all
DROP POLICY IF EXISTS "question_answers_select" ON public.question_answers;
CREATE POLICY "question_answers_select" ON public.question_answers
  FOR SELECT TO authenticated
  USING (
    get_my_role() IN ('mentor', 'admin', 'approver')
    OR EXISTS (
      SELECT 1 FROM public.questions q
      WHERE q.id = question_answers.question_id
        AND q.asker_id = auth.uid()
    )
  );

-- ============================================================
-- 7. Update Module 1: short_description and learning_objectives
-- ============================================================
UPDATE public.modules
SET
  short_description = 'Financial literacy is the foundation of everything we do as Wealth Solutions Counselors. This module builds your fluency with the core vocabulary, frameworks, and ratios that every advisor uses to understand a client''s full financial picture and guide them toward sustainable wealth.',
  learning_objectives = ARRAY[
    'Distinguish between gross income and net income, and explain how each affects take-home pay, budgeting decisions, and long-term wealth accumulation.',
    'Categorize personal expenses as fixed, variable, or periodic, and construct a complete monthly budget that accounts for all three expense types.',
    'Define assets, liabilities, and net worth, and calculate a client''s net worth from a simplified balance sheet.',
    'Explain equity and liquidity as financial concepts, and identify why liquidity matters in emergency planning and short-term cash flow management.',
    'Calculate the debt-to-income (DTI) ratio and interpret what different DTI levels signal about a client''s financial health and borrowing capacity.',
    'Perform a basic cash flow analysis — mapping income sources against all expense categories — to identify surplus, deficit, and opportunities for wealth-building.',
    'Describe the core principles of wealth-building (spending less than you earn, reducing liabilities, growing assets) and connect each principle to the budgeting and planning frameworks covered in this module.'
  ],
  updated_at = now()
WHERE module_number = 1;

-- ── session5_branding_profile.sql ──

-- ============================================================
-- SESSION 5: BRANDING & PROFILE ENHANCEMENTS
-- ============================================================
-- Run this against your Supabase project (SQL Editor → New Query)
-- ============================================================

-- ============================================================
-- 1. Add new columns to profiles
-- ============================================================
alter table public.profiles
  add column if not exists avatar_url    text,
  add column if not exists sponsor_id    uuid references public.employer_sponsors(id);

-- ============================================================
-- 2. Add brand columns to employer_sponsors
-- ============================================================
alter table public.employer_sponsors
  add column if not exists brand_primary    text,
  add column if not exists brand_secondary  text,
  add column if not exists brand_logo_url   text;

-- ============================================================
-- 3. Create site_config table (single-row global settings)
-- ============================================================
create table if not exists public.site_config (
  id              integer primary key default 1,
  primary_color   text default '#2D1FB1',
  secondary_color text default '#1A1080',
  logo_url        text,
  org_name        text default 'Global Investment Company',
  updated_by      uuid references auth.users(id),
  updated_at      timestamptz default now(),
  constraint one_row check (id = 1)
);

-- Seed the single row if it doesn't exist yet
insert into public.site_config (id) values (1) on conflict do nothing;

-- ============================================================
-- 4. RLS for site_config
-- ============================================================
alter table public.site_config enable row level security;

-- Any authenticated user can read global site config
drop policy if exists "site_config_select_authenticated" on public.site_config;
create policy "site_config_select_authenticated"
  on public.site_config for select
  to authenticated
  using (true);

-- Only admins and approvers can update
drop policy if exists "site_config_update_admin" on public.site_config;
create policy "site_config_update_admin"
  on public.site_config for update
  to authenticated
  using   (get_my_role() in ('admin', 'approver'))
  with check (get_my_role() in ('admin', 'approver'));

-- Only admins and approvers can upsert (needed for upsert() calls)
drop policy if exists "site_config_insert_admin" on public.site_config;
create policy "site_config_insert_admin"
  on public.site_config for insert
  to authenticated
  with check (get_my_role() in ('admin', 'approver'));

-- ============================================================
-- 5. profiles self-update policy check
--    The existing "Users can update own profile" policy in
--    session1_base_schema.sql covers all columns (UPDATE ... SET
--    is unrestricted at the column level by default in PG RLS).
--    No additional policy is needed for avatar_url or sponsor_id
--    as long as the policy exists.  The query below verifies it:
-- ============================================================
-- SELECT policyname FROM pg_policies
--   WHERE tablename = 'profiles' AND cmd = 'UPDATE';
-- Expected output should include something like:
--   "Users can update their own profile"

-- ============================================================
-- 6. STORAGE NOTE
-- ============================================================
-- An admin must manually create a PUBLIC storage bucket named
-- "avatars" in the Supabase dashboard → Storage → New bucket.
-- Set it to Public (Allow public access). This bucket is used
-- by the ProfileModal component to store and serve avatar images.
-- ============================================================

-- ── session6_new_modules.sql ──

-- ============================================================================
-- SESSION 6: Insert two new competency modules
--
-- 1. Insurance Planning  → inserted between original 18 and 19  (becomes 19)
-- 2. AI for Reporting, Automation, and Client Relationships
--                        → inserted between original 28 and 29  (becomes 30
--                          after the Insurance Planning shift)
--
-- Uses a +1000 offset strategy to avoid UNIQUE constraint conflicts during
-- the renumber. Safe to run once on a live database.
-- ============================================================================

-- ── STEP 1: Shift original modules 19–30 → 20–31  (make room for Insurance) ──

-- Move up by +1000 to clear the constraint, then settle at +1
UPDATE public.modules SET module_number = module_number + 1000 WHERE module_number >= 19;
UPDATE public.modules SET module_number = module_number - 999  WHERE module_number >= 1019;

-- Insert Insurance Planning as module 19
INSERT INTO public.modules (module_number, title, short_description, learning_objectives, content, is_published)
VALUES (
  19,
  'Insurance Planning',
  'Build a complete safety net for your clients. This module covers the major insurance types every financial counselor must understand — from life and disability to property and liability — so you can identify gaps, explain options, and protect everything your clients are working to build.',
  ARRAY[
    'Explain how insurance fits into a comprehensive financial plan as a risk-management tool',
    'Identify and distinguish the major personal insurance categories: life, health, disability, property/casualty, and liability',
    'Calculate a client''s life insurance need using the income-replacement and DIME methods',
    'Compare term and permanent life insurance structures and explain when each is appropriate',
    'Describe how disability insurance protects earned income, including key policy provisions such as elimination period, benefit period, and own-occupation definitions',
    'Conduct a basic insurance needs analysis to identify coverage gaps in a client''s current plan',
    'Explain how annuities function as insurance products and their role in retirement income planning'
  ],
  '{"lessons":[]}'::jsonb,
  true
);

-- ── STEP 2: Shift original 29–31 (now 30–32 after step 1) → 31–33
--           to make room for the AI module at position 30 ──

-- After step 1: original 28 → 29, original 29 → 30, original 30 → 31
-- We want AI at slot 30, so shift everything >= 30 up by 1
UPDATE public.modules SET module_number = module_number + 1000 WHERE module_number >= 30;
UPDATE public.modules SET module_number = module_number - 999  WHERE module_number >= 1030;

-- Insert AI module as module 30
INSERT INTO public.modules (module_number, title, short_description, learning_objectives, content, is_published)
VALUES (
  30,
  'AI for Reporting, Automation, and Client Relationships',
  'AI is reshaping how financial advisors work. This module prepares Wealth Solutions Counselors to use AI tools for client reporting, workflow automation, and relationship management — while understanding the ethical guardrails and accuracy standards every practitioner must maintain before sharing AI-generated content with clients.',
  ARRAY[
    'Explain how AI tools are currently being used in financial planning, reporting, and client communication',
    'Use an AI assistant to draft client reports, meeting summaries, and financial education content',
    'Identify the limitations and ethical considerations when using AI tools with client data',
    'Demonstrate a repeatable workflow for using AI to automate routine administrative tasks',
    'Apply AI tools to improve client relationship management, follow-up cadence, and personalized outreach',
    'Evaluate AI-generated financial content for accuracy and compliance before sharing with clients',
    'Describe emerging AI applications in portfolio analysis, compliance monitoring, and client onboarding'
  ],
  '{"lessons":[]}'::jsonb,
  true
);

-- ── VERIFICATION ──
-- Run these to confirm the final module order:
-- SELECT module_number, title FROM public.modules ORDER BY module_number;
-- Expected: 32 total modules, with 19 = Insurance Planning, 30 = AI module

-- ============================================================================
-- DONE. The two new modules appear in the LMS as empty drafts.
-- Use the Admin → Module Editor to add lesson content.
-- ============================================================================

-- ── module1_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 1 CONTENT
-- Financial Literacy & Planning
-- ============================================================================
-- Loads substantive lesson content + assessment quiz into module 1.
-- Status remains 'draft' until Cathy Jackson-Gent approves via the admin UI.
--
-- Run this AFTER supabase_setup.sql.
-- Safe to re-run; uses UPDATE.
-- ============================================================================

update public.modules set
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Money Language",
      "summary": "The vocabulary every advisor must speak fluently.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Before you can build a plan, you have to be able to <strong>name what you're looking at</strong>. Money has its own working vocabulary, and a Wealth Solutions Counselor uses these words with the same precision a physician uses anatomical terms. Get the words wrong, and the plan will be wrong." },
        { "type": "paragraph", "text": "This lesson covers the terms you'll use in your first client conversation and every one after. Pay close attention: many sound similar but carry very different meaning when a client is making a real decision with real money." },

        { "type": "heading", "text": "Income: gross vs. net" },
        { "type": "paragraph", "text": "<strong>Gross income</strong> is what someone earns before any deductions. <strong>Net income</strong> — sometimes called take-home pay — is what actually lands in the bank account after taxes, retirement contributions, health insurance, and other withholdings." },
        { "type": "callout", "kind": "key", "title": "Why this matters", "text": "Clients almost always quote you their gross figure when asked what they earn. Almost every budgeting and cash-flow conversation must happen in net terms. Always confirm which number you're working with — and write it down." },

        { "type": "heading", "text": "Expenses: fixed vs. variable" },
        { "type": "paragraph", "text": "<strong>Fixed expenses</strong> are roughly the same amount every month — rent or mortgage, car payment, insurance premiums, subscriptions. <strong>Variable expenses</strong> move from month to month — groceries, gas, eating out, entertainment, gifts." },
        { "type": "paragraph", "text": "There's a third category worth naming early: <strong>periodic</strong> or <strong>irregular</strong> expenses. These are real expenses that don't show up monthly — annual insurance premiums, property taxes, car registration, holiday gifts, back-to-school costs. Most household budgeting failures trace back to ignoring these." },

        { "type": "heading", "text": "The balance sheet vocabulary" },
        { "type": "glossary", "terms": [
          { "term": "Asset", "definition": "Anything of economic value that the client owns. Examples: cash, retirement accounts, the home, a paid-off car, a business stake." },
          { "term": "Liability", "definition": "A debt the client owes. Examples: mortgage balance, auto loan, credit card balance, student loans." },
          { "term": "Net worth", "definition": "Total assets minus total liabilities. The single most useful long-term scorecard in personal finance." },
          { "term": "Equity", "definition": "The portion of an asset the client actually owns free of debt. Home value minus mortgage balance equals home equity." },
          { "term": "Liquidity", "definition": "How quickly an asset can be turned into spendable cash without significant loss. Checking accounts are highly liquid; a home or retirement account is not." }
        ]},

        { "type": "heading", "text": "Debt and capacity" },
        { "type": "glossary", "terms": [
          { "term": "Debt-to-income ratio (DTI)", "definition": "Total monthly debt payments divided by gross monthly income, expressed as a percentage. Lenders use it to judge borrowing capacity; advisors use it as an early-warning indicator of household stress." },
          { "term": "Front-end DTI", "definition": "Housing-related debt payments only (mortgage or rent + taxes + insurance) divided by gross monthly income. Conventional lending generally prefers this below 28%." },
          { "term": "Back-end DTI", "definition": "All monthly debt payments divided by gross monthly income. Conventional lending generally prefers this below 36% — though loan programs vary. Above 43% becomes a structural concern." },
          { "term": "Revolving debt", "definition": "Debt with a flexible balance and minimum payments — credit cards, lines of credit. Interest typically accrues monthly on the unpaid balance." },
          { "term": "Installment debt", "definition": "Debt with a fixed payment schedule and end date — auto loans, mortgages, most student loans. Predictable but rigid." }
        ]},

        { "type": "callout", "kind": "warn", "title": "Two words clients confuse", "text": "<strong>Solvent</strong> and <strong>liquid</strong> are not the same. A client can be solvent (positive net worth) but illiquid (everything tied up in the house and 401(k)) and still face a real crisis when the water heater breaks. Make sure you can explain the difference simply." },

        { "type": "divider" },

        { "type": "heading", "text": "Practice your fluency" },
        { "type": "activity", "title": "Translate gross to net", "prompt": "A client tells you, \"I make $90,000 a year.\" Before you can do anything useful, you need to estimate their actual take-home pay. Walk through this exercise:", "steps": [
          "Assume the client is single, lives in California, and contributes 6% of salary to a traditional 401(k).",
          "Roughly: federal income tax (22% marginal bracket effective ~15%), Social Security (6.2%), Medicare (1.45%), California state income tax (~6% effective).",
          "Don't forget the 401(k) contribution comes off the top of gross — that's $5,400/year reducing both taxable income and take-home.",
          "Estimate the net monthly figure. Compare to your first instinct.",
          "Note: this is a rough exercise. Real net pay depends on health premiums, HSA, dental, life insurance, garnishments, and many other factors. Always work from real pay stubs when planning."
        ] },

        { "type": "callout", "kind": "do", "title": "Habit to build now", "text": "When a client states an income figure, your next question is almost always, \"Is that gross or net?\" Train your reflex on this — it's the single fastest tell that you know what you're doing." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Net Worth Snapshot",
      "summary": "The first real picture every plan needs.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every plan begins with two pictures: what the client owes and what the client owns. The difference is <strong>net worth</strong> — and it is the most useful single number in personal finance." },
        { "type": "callout", "kind": "key", "title": "The formula", "text": "<strong>Net Worth = Total Assets − Total Liabilities</strong>" },

        { "type": "heading", "text": "Why this number matters" },
        { "type": "paragraph", "text": "Income and spending tell you about flow. Net worth tells you about <em>position</em>. A client earning $250,000 with a -$80,000 net worth is in a different situation than a client earning $65,000 with a $200,000 net worth. The plan must respond to position, not just income." },
        { "type": "paragraph", "text": "Tracked over time, net worth becomes the most honest scorecard a household has. Markets move, salaries change, surprises happen — but year over year, net worth answers a single question: are we building, or are we slipping?" },

        { "type": "heading", "text": "Categorizing assets" },
        { "type": "paragraph", "text": "When building a net worth statement, group assets by liquidity:" },
        { "type": "list", "items": [
          "<strong>Cash & cash equivalents</strong> — checking, savings, money market, CDs, short-term Treasuries. Use the current balance.",
          "<strong>Investment accounts (non-retirement)</strong> — taxable brokerage, individual stocks, mutual funds, ETFs. Use the most recent statement value.",
          "<strong>Retirement accounts</strong> — 401(k), 403(b), IRA, Roth IRA, SEP, Solo 401(k). Use current market value, not contributions.",
          "<strong>Real estate</strong> — primary home, rental property, land. Use a defensible market value (recent comps, Zillow as a starting point, formal appraisal for high-stakes situations).",
          "<strong>Business interests</strong> — ownership in a private business. This is the hardest to value. Use the most recent qualified valuation or annotate \"value uncertain.\"",
          "<strong>Personal property</strong> — vehicles, jewelry, collectibles. Use replacement value cautiously; many advisors omit minor personal property entirely to keep the statement honest."
        ]},

        { "type": "callout", "kind": "warn", "title": "Common mistake", "text": "Some advisors list the home at its <em>purchase price</em>. Others list it at the <em>Zestimate</em>. Both can mislead. Use a defensible recent comparable, and always note the source and date in the working papers." },

        { "type": "heading", "text": "Categorizing liabilities" },
        { "type": "list", "items": [
          "<strong>Mortgage(s)</strong> — current principal balance, not original loan amount.",
          "<strong>Auto loans</strong> — current payoff balance.",
          "<strong>Student loans</strong> — split federal vs. private; both go on the statement.",
          "<strong>Credit cards</strong> — total balances carried, regardless of whether the client \"pays them off every month.\" If a balance is on the statement, list it.",
          "<strong>Home equity lines of credit (HELOCs)</strong> — current drawn balance, not the credit limit.",
          "<strong>Personal loans, medical debt, tax debt</strong> — all included."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Worked example: Naomi" },
        { "type": "case_study",
          "title": "Net worth at age 34",
          "scenario": "Naomi is 34, single, an analyst at a Bay Area firm. She's earned consistently for 11 years and feels like she should be \"farther along.\" She's hired your firm for a second opinion.",
          "discussion": "<p><strong>Assets</strong></p><ul><li>Checking: $4,200</li><li>High-yield savings: $18,000</li><li>Roth IRA: $42,000</li><li>401(k) (employer plan): $112,000</li><li>Taxable brokerage: $9,500</li><li>2019 Honda Civic (paid off): $14,000</li><li><strong>Total assets: $199,700</strong></li></ul><p><strong>Liabilities</strong></p><ul><li>Credit card (carrying balance): $3,400</li><li>Federal student loans: $26,800</li><li><strong>Total liabilities: $30,200</strong></li></ul><p><strong>Net worth: $169,500</strong></p><p>Notice what this picture tells you that a salary figure alone cannot: Naomi has built real position. She is not behind. The conversation moving forward isn't \"how do we save more\" — it's \"what are we building toward?\" That reframe is the whole reason we compute net worth before anything else.</p>"
        },

        { "type": "activity", "title": "Build your own net worth statement", "prompt": "Before you can guide clients through this, do it for yourself. Apprentices who skip this step describe the exercise to clients abstractly; the ones who've done it speak with quiet authority.", "steps": [
          "Open a spreadsheet. Create two columns: Assets, Liabilities.",
          "List every account, by name and current balance, in the correct column. Don't estimate — pull the most recent statement.",
          "Add it up. Calculate net worth.",
          "Save the file. Date it. You'll do this again in 6 months and learn more from comparing the two snapshots than from any market commentary.",
          "Optional: note one observation about your own position that surprised you. Apprentices who can name surprise in themselves can recognize it in clients."
        ]},

        { "type": "callout", "kind": "note", "title": "Working papers reminder", "text": "When you build a net worth statement for a client, save the source documents alongside the spreadsheet — pay stubs, statements, valuations. The statement is the summary; the working papers are the audit trail. Always keep both." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "The Cash Flow Statement",
      "summary": "Money in, money out, and the gap that decides everything.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "If net worth tells you the client's <em>position</em>, the cash flow statement tells you the client's <em>direction</em>. It is the most action-oriented document in personal finance because almost every recommendation you'll ever make changes a line item on it." },
        { "type": "callout", "kind": "key", "text": "<strong>Monthly Cash Flow = Monthly Income − Monthly Expenses</strong><br/>A positive figure is <em>surplus</em>. A negative figure is <em>deficit</em>. The surplus is the fuel for every plan." },

        { "type": "heading", "text": "Building the income side" },
        { "type": "list", "items": [
          "<strong>Earned income</strong> — wages, salary, self-employment income, bonuses, commissions. Use <strong>net</strong> figures (take-home pay), not gross.",
          "<strong>Investment income</strong> — dividends, interest, rental income (after expenses).",
          "<strong>Other reliable income</strong> — child support received, alimony, Social Security, pension payments, disability benefits.",
          "<strong>Irregular income</strong> — RSU vests, annual bonuses, side income. List these separately and consider averaging across the year."
        ]},
        { "type": "callout", "kind": "warn", "title": "On bonuses and commissions", "text": "If a client's compensation includes significant variable comp, you have two options: (1) build a base-only cash flow and treat variable comp as a separate windfall plan, or (2) build an average-monthly cash flow using a 12-month rolling figure. Option 1 is more conservative and is the default for most planning work." },

        { "type": "heading", "text": "Building the expense side" },
        { "type": "subheading", "text": "Fixed expenses (predictable, monthly)" },
        { "type": "list", "items": [
          "Housing: rent or mortgage payment, property taxes (escrowed or not), HOA dues, homeowners or renters insurance.",
          "Transportation: auto loan payment, auto insurance, registration averaged monthly.",
          "Insurance: health insurance premiums (if not pre-tax through payroll), disability, life, umbrella.",
          "Debt service: minimum payments on credit cards, student loans, personal loans.",
          "Subscriptions and recurring services."
        ]},
        { "type": "subheading", "text": "Variable expenses (changes monthly)" },
        { "type": "list", "items": [
          "Food: groceries, dining out, coffee, work lunches.",
          "Utilities: electricity, gas, water, internet, phone (some are quasi-fixed, some seasonal).",
          "Transportation: gas, parking, public transit, ride-share, maintenance.",
          "Personal: clothing, household goods, haircuts, gym, hobbies, gifts.",
          "Healthcare out-of-pocket: copays, medications, dental, vision."
        ]},
        { "type": "subheading", "text": "Periodic expenses (annualize and divide by 12)" },
        { "type": "list", "items": [
          "Annual insurance premiums not paid monthly.",
          "Property taxes if not escrowed.",
          "Holiday gifts.",
          "Travel and vacations.",
          "Back-to-school costs.",
          "Vehicle registration.",
          "Membership renewals."
        ]},

        { "type": "callout", "kind": "do", "title": "The rule of thumb", "text": "If a client's stated monthly expenses look unrealistically low, you've almost certainly missed the periodic category. Total a client's annual periodic expenses, divide by 12, and add it to monthly outflows. The picture usually shifts dramatically." },

        { "type": "heading", "text": "Surplus, deficit, and the truth" },
        { "type": "paragraph", "text": "Once you've built both sides honestly, the answer comes out:" },
        { "type": "list", "items": [
          "<strong>Surplus</strong>: income exceeds expenses. This is the raw material for every saving, investing, and debt-paydown plan you'll ever recommend.",
          "<strong>Break-even</strong>: income equals expenses. The household is treading water — any surprise becomes a crisis.",
          "<strong>Deficit</strong>: expenses exceed income. The household is sinking, usually quietly. The first job of the plan is to find the gap and close it."
        ]},

        { "type": "case_study",
          "title": "Marcus and Tasha",
          "scenario": "Marcus and Tasha are a married couple in their early 40s. Combined gross income is $148,000. They tell you confidently that they save \"$1,000 a month.\" After working through their actual cash flow with you, the picture is different: net combined income $9,200/month, fixed expenses $5,800, variable expenses $2,400, and annualized periodic expenses (taxes, insurance, vacation, gifts) averaging $1,100/month. Real monthly surplus: −$100.",
          "discussion": "Marcus and Tasha aren't lying. They are saving $1,000 each month — into a high-yield savings account. But they're also withdrawing from it intermittently to cover the surprises they didn't plan for. The net is roughly zero. The work of the plan is not to lecture them about their spending. It's to <strong>name the missing $1,100/month periodic line</strong>, build a sinking-fund habit, and let the real surplus emerge. That's a much more productive conversation than \"you should save more.\""
        },

        { "type": "activity", "title": "Build your own cash flow statement", "prompt": "Same instruction as last lesson: do it for yourself first.", "steps": [
          "Pull the last three months of bank and credit card statements.",
          "Categorize every line into fixed, variable, or periodic.",
          "Average across the three months to get a typical monthly figure.",
          "Add a row for periodic expenses (annual total / 12).",
          "Compute your real monthly surplus or deficit.",
          "Compare your real number to what you would have guessed before the exercise."
        ]}
      ]
    },

    {
      "id": "lesson-4",
      "title": "Three Budget Frameworks",
      "summary": "Zero-based, 50/30/20, and sinking funds — when each one fits.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Budgeting is the most over-mentioned and least understood topic in personal finance. The truth is there's no single \"right\" framework — there are three useful ones, and the skill is matching the right framework to the right client." },

        { "type": "heading", "text": "Framework 1 — Zero-based budgeting" },
        { "type": "paragraph", "text": "Every dollar of income gets a job before the month begins. If income is $5,000, you assign all $5,000 — to rent, food, insurance, savings, debt paydown, fun money — until nothing is unaccounted for. The total of every category equals income exactly. Hence \"zero-based.\"" },
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Clients in debt-paydown mode, clients who feel \"money disappears,\" clients who need to feel in control, clients on tight margins. High-engagement clients thrive on this. It is the gold standard for changing behavior fast." },
        { "type": "callout", "kind": "warn", "title": "Watch out for", "text": "It's labor-intensive. Some clients hate it within 30 days and quit budgeting entirely. Don't impose it on a client who tells you they want a \"set it and forget it\" approach." },

        { "type": "heading", "text": "Framework 2 — 50/30/20" },
        { "type": "paragraph", "text": "A percentage framework popularized by Senator Elizabeth Warren and her daughter in <em>All Your Worth</em>:" },
        { "type": "list", "items": [
          "<strong>50%</strong> of take-home pay to needs: housing, food, utilities, insurance, transportation, minimum debt payments.",
          "<strong>30%</strong> to wants: dining out, entertainment, hobbies, subscriptions, travel.",
          "<strong>20%</strong> to savings and debt payoff above the minimums: emergency fund, retirement, paying down credit cards faster than the minimum."
        ]},
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Middle- and higher-income clients who don't want category-level tracking. Anyone whose needs already fit comfortably in 50%. Excellent starting framework for clients who've never budgeted." },
        { "type": "callout", "kind": "warn", "title": "Watch out for", "text": "Doesn't work in high cost-of-living areas where rent alone is 40% of net pay — the math breaks. In those cases, you may need to compress \"wants\" or adjust the percentages honestly. Don't force the framework to fit; adapt it." },

        { "type": "heading", "text": "Framework 3 — Sinking funds" },
        { "type": "paragraph", "text": "Rather than budgeting only the current month, sinking funds budget across the year. For every known periodic expense — annual insurance, property taxes, holidays, vacations, vehicle registration — the client divides the annual amount by 12 and contributes monthly to a dedicated sub-account. When the bill arrives, the money is already there." },
        { "type": "callout", "kind": "key", "text": "Sinking funds are not really a complete budget framework — they're a <strong>tool</strong> that works alongside either of the others. But because most household budget failures trace back to ignoring periodic expenses, naming the sinking fund pattern explicitly is one of the highest-leverage things a counselor can teach." },

        { "type": "subheading", "text": "Common sinking fund categories" },
        { "type": "list", "items": [
          "Annual insurance premiums (homeowners, umbrella, life term)",
          "Property tax (if not escrowed by mortgage servicer)",
          "Vehicle: registration, tires, scheduled maintenance",
          "Travel and vacation",
          "Gifts: holidays, birthdays, weddings, baby showers",
          "Pet expenses (vet, boarding)",
          "Annual subscriptions (Amazon Prime, professional dues)",
          "Home maintenance reserve (typically 1% of home value/year)"
        ]},

        { "type": "divider" },

        { "type": "case_study",
          "title": "Choosing the right framework",
          "scenario": "Three different clients meet with you in one week. Naomi (analyst, single, $90k, no debt, methodical) wants to optimize her savings rate. Marcus and Tasha (married, kids, $148k combined, modest surplus, feel overwhelmed) want clarity. Devon (small business owner, irregular income $80–$160k, three kids, behind on retirement) wants control.",
          "discussion": "<p>Naomi gets <strong>50/30/20</strong>. She doesn't need a daily framework — she needs a structural target. We confirm her needs fit in 50%, set her wants budget honestly, and lock 25–30% (not 20%) for savings and investing.</p><p>Marcus and Tasha get a hybrid: <strong>50/30/20 with a sinking-fund layer</strong>. The frustration in their household isn't about discipline — it's about surprises. We name every periodic expense, build six sinking funds, and the chaos drops within two months.</p><p>Devon gets <strong>zero-based budgeting</strong>. His income volatility plus his catch-up retirement work means every dollar needs a job. We use his lowest reliable monthly income as the baseline and create a windfall plan for the higher months. It's more work — and exactly the right tool for his situation.</p>"
        },

        { "type": "callout", "kind": "key", "title": "The counselor's question", "text": "Don't ask \"which framework do you want?\" Most clients don't know. Ask: <em>\"When you think about money day-to-day, do you want to feel in control of every dollar, or do you want a structure you can mostly forget about?\"</em> Their answer points you to the right framework." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Emergency Fund",
      "summary": "How much, where, and what it really protects.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "The emergency fund is the most basic and most misunderstood building block in personal finance. Get this one piece right and almost everything downstream becomes easier." },
        { "type": "callout", "kind": "key", "title": "What it really is", "text": "An emergency fund is <strong>cash reserved to keep the household intact when income drops or an unexpected expense hits</strong>. It is not a savings account for vacations. It is not an investment account. It is structural insurance against the months you didn't plan for." },

        { "type": "heading", "text": "Sizing the fund" },
        { "type": "paragraph", "text": "The standard rule of thumb is <strong>3 to 6 months of essential expenses</strong>. Notice two important details:" },
        { "type": "list", "items": [
          "<strong>Essential expenses, not total expenses.</strong> If a household spends $7,000/month total but only $5,000/month is truly essential (housing, food, utilities, insurance, minimum debt payments, transportation), then 3-6 months is $15,000–$30,000, not $21,000–$42,000.",
          "<strong>The 3–6 month range exists because client situations differ.</strong> The right number depends on who they are."
        ]},

        { "type": "subheading", "text": "When to lean toward 3 months" },
        { "type": "list", "items": [
          "Stable W-2 employment in a steady industry",
          "Dual-income household where both incomes are stable",
          "Strong professional network, would expect quick re-employment if needed",
          "Robust disability and health insurance",
          "No dependents or low fixed obligations"
        ]},

        { "type": "subheading", "text": "When to lean toward 6 months (or more)" },
        { "type": "list", "items": [
          "Self-employed or commission-based income",
          "Single-income household",
          "Industry or role susceptible to layoffs",
          "Approaching or in retirement (consider 12+ months of expenses in cash)",
          "Significant fixed obligations: mortgage, children's tuition, family support",
          "Health conditions that could affect work capacity"
        ]},

        { "type": "heading", "text": "Where to keep it" },
        { "type": "paragraph", "text": "An emergency fund must be safe and liquid. That's it. Investment returns are not the goal — being able to reach the money fast, in full, without loss, is the goal." },
        { "type": "list", "items": [
          "<strong>High-yield savings account (HYSA)</strong> — the default choice. FDIC-insured up to limits. Same-day access via transfer. Modest interest.",
          "<strong>Money market account</strong> — similar to HYSA at most institutions. Check whether yours has check-writing or debit access, and confirm FDIC insurance.",
          "<strong>Treasury bills, short-term</strong> — for sophisticated clients with larger funds, T-bills via TreasuryDirect or a brokerage can offer competitive yields with similar safety. Less liquid (must wait for sale settlement).",
          "<strong>Checking account</strong> — only for the working capital portion (one to two months). Beyond that, the money should earn at least HYSA interest."
        ]},
        { "type": "callout", "kind": "warn", "title": "Where NOT to keep it", "text": "Not in a brokerage account invested in stocks or bond funds. Not in a Roth IRA \"because contributions can be withdrawn anytime\" — that strategy raids retirement and creates tax-reporting work, and most clients won't remember to replace it. Not in a CD beyond what you're willing to let lock up. Emergency means <em>available right now</em>." },

        { "type": "heading", "text": "When to build vs. invest" },
        { "type": "paragraph", "text": "A common dilemma: a client has $3,000 to allocate. Should it go to the emergency fund or the Roth IRA? The order most planners follow:" },
        { "type": "numbered", "items": [
          "<strong>Minimum debt payments current.</strong> Make every required payment first. Late fees and credit damage swamp any other consideration.",
          "<strong>Build a starter emergency fund: $1,000–$2,500.</strong> Just enough to absorb the standard surprises (car repair, medical copay, broken appliance).",
          "<strong>Capture employer 401(k) match.</strong> A free 50% or 100% return on contributions, up to the match cap. Almost always worth more than other priorities.",
          "<strong>High-interest debt paydown (credit cards, often anything 7%+).</strong> Mathematically beats most investing.",
          "<strong>Build emergency fund to full 3–6 months.</strong>",
          "<strong>Retirement and other tax-advantaged accounts.</strong>",
          "<strong>Taxable investing.</strong>"
        ]},

        { "type": "callout", "kind": "note", "title": "Why this order", "text": "Notice the starter fund comes before debt paydown. The reason: without any cash buffer, the first surprise puts the client back on the credit card and undoes the work. The starter fund is what makes the rest of the plan stick." },

        { "type": "case_study",
          "title": "Naomi reconsiders",
          "scenario": "Naomi has $18,000 in high-yield savings and feels she has \"too much in cash.\" She wants to invest most of it.",
          "discussion": "Naomi's essential monthly expenses are approximately $3,100 (rent $1,750 in a roommate situation, food, utilities, transportation, insurance, student loan minimum). Three months of essentials is $9,300; six months is $18,600. Her $18,000 puts her right at the upper end of the standard range. With stable W-2 employment in a strong industry, dual-income parents nearby, and good benefits, she could reasonably target the lower end. <strong>Recommendation</strong>: Move $9,000 of the $18,000 into a taxable brokerage account allocated to a low-cost diversified portfolio. Keep $9,000 in HYSA. Revisit in 12 months. Notice how the conversation moved from a feeling (\"too much cash\") to a defended number (\"three months essentials, leaning low because of your situation\")."
        }
      ]
    },

    {
      "id": "lesson-6",
      "title": "The Six-Step Planning Workflow",
      "summary": "Discovery to review: the repeatable arc of every engagement.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client engagement, no matter how complex or simple, follows the same six-step arc. The CFP Board codifies this as the standard practice of financial planning. As a counselor, internalizing it means you always know where you are in a relationship and what comes next." },

        { "type": "heading", "text": "Step 1 — Understand the client's situation" },
        { "type": "paragraph", "text": "Sometimes called <em>discovery</em>. This is where you gather quantitative data (income, expenses, balance sheet, tax returns, statements) <strong>and</strong> qualitative data (goals, values, fears, family dynamics, time horizon, risk attitude). The qualitative work is harder and matters more." },
        { "type": "callout", "kind": "do", "title": "What good discovery looks like", "text": "More listening than talking. Open questions over closed ones. Permission asked before getting personal. Notes captured in your own words so you can write them up afterward. Clear next steps documented before the meeting ends." },

        { "type": "heading", "text": "Step 2 — Identify and select goals" },
        { "type": "paragraph", "text": "Most clients arrive with a vague goal (\"I want to be okay in retirement\") and you'll need to help them surface specific, time-bound ones (\"I want to retire at 65 with $80,000/year of inflation-adjusted income that lasts through age 95\"). Clients rarely arrive with their goals pre-clarified. Helping them do that work is half of planning." },

        { "type": "heading", "text": "Step 3 — Analyze the client's current course of action" },
        { "type": "paragraph", "text": "Given everything you know about their situation and goals, does the path they're on get them there? You're running projections: retirement income vs. expected need, cash flow vs. emergency fund target, debt trajectory vs. milestones, insurance coverage vs. exposure." },
        { "type": "paragraph", "text": "This is the math step. Be honest. If the numbers say the current path isn't working, the next step exists to address that." },

        { "type": "heading", "text": "Step 4 — Develop recommendations" },
        { "type": "paragraph", "text": "Recommendations are not generic best practices. They are <em>specific actions</em> for <em>this client</em> that close the gap between their current trajectory and their goals." },
        { "type": "callout", "kind": "key", "title": "Anatomy of a recommendation", "text": "A good recommendation contains: <strong>(1)</strong> the action, <strong>(2)</strong> the rationale tied to the client's goal, <strong>(3)</strong> the trade-offs, and <strong>(4)</strong> alternatives considered. \"Increase 401(k) contribution to 12%\" is a sentence. A recommendation explains why, what it costs in current income, and what was considered instead." },

        { "type": "heading", "text": "Step 5 — Implement the recommendations" },
        { "type": "paragraph", "text": "This is where planning either becomes real or becomes a binder on the shelf. Implementation is operational: forms filed, contributions changed, accounts opened, beneficiaries updated, documents reviewed by the right professionals (attorney for estate work, CPA for tax matters)." },
        { "type": "callout", "kind": "warn", "title": "Where implementation fails", "text": "When recommendations leave the client's office and the next contact is a year later, most of them don't happen. Build implementation into the engagement: check-in calls, written next-step lists, due dates, accountability." },

        { "type": "heading", "text": "Step 6 — Monitor and review" },
        { "type": "paragraph", "text": "Plans are not events. They are living documents that respond to changes in the client's life (new job, marriage, divorce, child, inheritance, illness, retirement) and changes in the world (markets, tax law, regulation). A standard cadence: annual full review with quarterly check-ins. More often when life is moving fast." },

        { "type": "divider" },

        { "type": "activity", "title": "Map the workflow onto a real client", "prompt": "Take the Marcus and Tasha case from Lesson 3. Walk through where they are in the six-step workflow.", "steps": [
          "Step 1: What do you still need to know about them? List five qualitative questions you didn't ask.",
          "Step 2: They said \"we want to save more.\" What's the actual goal you'd help them name? Write it as a specific, time-bound statement.",
          "Step 3: Run their current numbers. Are they on track to anything?",
          "Step 4: Write one specific recommendation, with rationale and trade-off.",
          "Step 5: What needs to happen this week, this month, this quarter for that recommendation to be real?",
          "Step 6: What's the review cadence you'd propose, and why?"
        ]}
      ]
    },

    {
      "id": "lesson-7",
      "title": "Professional Standards",
      "summary": "PII, documentation, and the audit trail that protects everyone.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Counseling is a regulated profession even when it isn't licensed. You handle Social Security numbers, account statements, family secrets, and life decisions worth hundreds of thousands of dollars. The standards in this lesson are not optional and they apply on day one." },

        { "type": "heading", "text": "Personally identifiable information (PII)" },
        { "type": "paragraph", "text": "PII is any data that can identify a specific individual. The categories you'll encounter daily:" },
        { "type": "list", "items": [
          "<strong>Direct identifiers</strong> — full name, SSN, date of birth, driver's license, passport, home address, email, phone.",
          "<strong>Financial identifiers</strong> — account numbers, routing numbers, brokerage account IDs, credit card numbers.",
          "<strong>Sensitive personal data</strong> — health information, family records, beneficiary designations, immigration status."
        ]},

        { "type": "callout", "kind": "key", "title": "The minimum-necessary principle", "text": "Collect only the PII you need to do the work. Don't ask for an SSN to open a planning relationship; you need it to open accounts. Don't collect last year's full tax return when you only need the W-2. The less you handle, the less can leak." },

        { "type": "heading", "text": "Storage and handling rules" },
        { "type": "list", "items": [
          "<strong>No PII in email or chat.</strong> Use the firm's secure portal. If a client emails you a statement, you respond to the email but do not leave the document attached in your reply.",
          "<strong>No PII on personal devices.</strong> Firm laptop only, with disk encryption.",
          "<strong>No printed PII left unattended.</strong> Lock-and-shred. If you print a tax return, it does not leave your desk and it goes through the shredder before you leave for the day.",
          "<strong>Verbal disclosure.</strong> Don't read account numbers aloud in a client meeting if the spouse hasn't been disclosed, in a conference room with the door open, or anywhere the conversation can be overheard."
        ]},

        { "type": "heading", "text": "Documentation discipline" },
        { "type": "paragraph", "text": "Every client interaction generates a record. The standard:" },
        { "type": "list", "items": [
          "<strong>Capture the meeting</strong> in your own words within 24 hours: date, time, attendees, what was discussed, what was decided, what comes next.",
          "<strong>Note the source</strong> for every number that lands in a plan. \"Income: $148,000 (per 2024 W-2, dated 1/31/2025).\" Not just the number.",
          "<strong>Document recommendations and rationale.</strong> Why you recommended what you did, and what alternatives you considered. This is the file the firm's compliance team — or, in a worst case, regulators — will read.",
          "<strong>Note objections and approvals.</strong> If the client declines a recommendation, document it. If a supervisor approves an exception, document it."
        ]},

        { "type": "heading", "text": "The audit trail" },
        { "type": "paragraph", "text": "An audit trail means: someone two years from now can pick up the file and reconstruct what happened and why. Your future self will be this person, and so will compliance, and possibly so will the client's attorney or a regulator. Build the trail as you go — it cannot be reconstructed later." },

        { "type": "callout", "kind": "do", "title": "The end-of-day discipline", "text": "Five minutes at the end of each day: are my notes from today's meetings in the system? Are open items on my task list? Are physical documents secured? This habit is the difference between a counselor who looks professional and one who is." },

        { "type": "heading", "text": "When to escalate" },
        { "type": "paragraph", "text": "Some moments require immediate supervisor involvement. Memorize them:" },
        { "type": "list", "items": [
          "Client makes a request that feels outside policy or compliance.",
          "Client discloses something that suggests impairment, abuse, or coercion.",
          "Client wants to do something that doesn't fit their stated risk tolerance or suitability.",
          "Client requests a transaction in an account they don't legally control.",
          "Anything involving suspected identity theft, fraud, or unusual money movement.",
          "Any moment you don't know what to do — escalate. The cost of escalation is small; the cost of not escalating can be large."
        ]},

        { "type": "callout", "kind": "key", "title": "The frame for everything in this lesson", "text": "Compliance is not paperwork that gets in the way of helping clients. Compliance is <strong>how</strong> the help happens. The discipline that protects PII is the same discipline that protects the relationship. The audit trail that compliance wants is the same record the client wants when they ask, six months later, what we discussed and why." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A client tells you they earn $90,000 a year. Before you do anything useful with that number, what should you confirm?",
        "options": [
          "Whether they have any side income.",
          "Whether the figure is gross or net.",
          "Whether they have direct deposit.",
          "Whether they expect a raise this year."
        ],
        "correct": 1,
        "explanation": "Almost every cash flow and budgeting decision happens in net (take-home) terms. Clients almost always quote gross. Confirming which number you're working with is the first reflex of a competent counselor."
      },
      {
        "id": "q2",
        "prompt": "Which expense category is the most common reason household budgets fail?",
        "options": [
          "Fixed monthly expenses like rent.",
          "Variable expenses like groceries.",
          "Periodic (irregular) expenses like annual insurance and holiday gifts.",
          "Subscription services."
        ],
        "correct": 2,
        "explanation": "Periodic expenses don't show up monthly but are real. Households that don't annualize and budget for them are repeatedly surprised. Sinking funds exist specifically to solve this."
      },
      {
        "id": "q3",
        "prompt": "Net worth is best described as:",
        "options": [
          "Monthly income minus monthly expenses.",
          "Total assets minus total liabilities.",
          "Gross income for the year.",
          "The market value of investments."
        ],
        "correct": 1,
        "explanation": "Net worth measures position: what the household owns minus what it owes. Income and expenses measure flow, not position."
      },
      {
        "id": "q4",
        "prompt": "A client is solvent but illiquid. What does this mean in practice?",
        "options": [
          "They have positive net worth but most of it is tied up in assets that can't be quickly converted to cash.",
          "They have more debt than assets.",
          "They have plenty of cash but a low credit score.",
          "Their income exceeds their expenses but only barely."
        ],
        "correct": 0,
        "explanation": "Solvent means positive net worth; liquid means easy access to cash. A client with most of their wealth in a home and a 401(k) can be solvent but face a real crisis when the water heater breaks."
      },
      {
        "id": "q5",
        "prompt": "Under the 50/30/20 framework, what does the 30% category cover?",
        "options": [
          "Needs: housing, food, utilities, insurance.",
          "Savings and debt payoff beyond minimums.",
          "Wants: dining out, entertainment, hobbies, subscriptions.",
          "Taxes and other government obligations."
        ],
        "correct": 2,
        "explanation": "50% needs, 30% wants, 20% savings/debt-payoff above minimums. The 30% is discretionary spending — what the client would call \"the fun stuff\" or things they could cut if they had to."
      },
      {
        "id": "q6",
        "prompt": "A client has irregular self-employment income and feels overwhelmed by their finances. Which budgeting framework is generally the best fit?",
        "options": [
          "50/30/20 — it's simpler.",
          "Zero-based budgeting — every dollar gets a job.",
          "Sinking funds only.",
          "Encourage them to skip budgeting and just save what's left at month-end."
        ],
        "correct": 1,
        "explanation": "Zero-based budgeting is the gold standard for clients with income volatility or who feel out of control. Every dollar of (conservative baseline) income is assigned a purpose. Higher-income months become windfall planning."
      },
      {
        "id": "q7",
        "prompt": "The standard rule of thumb for emergency fund size is:",
        "options": [
          "1–2 months of gross income.",
          "Six weeks of total expenses.",
          "3–6 months of essential expenses.",
          "$10,000 regardless of household."
        ],
        "correct": 2,
        "explanation": "Three to six months of essential (not total) expenses. The range exists because client situations differ: stable W-2 employment leans lower; self-employment, single income, or older clients lean higher."
      },
      {
        "id": "q8",
        "prompt": "Why is a 'starter' emergency fund ($1,000–$2,500) typically built BEFORE aggressively paying down high-interest credit card debt?",
        "options": [
          "Because savings always earns more than credit cards charge.",
          "Because without any cash cushion, the next surprise forces the client back onto the credit card and undoes the paydown work.",
          "Because IRS rules require it.",
          "Because credit cards charge fees on accounts with no savings."
        ],
        "correct": 1,
        "explanation": "Without a cushion, the first surprise (car repair, medical copay) puts the client back on the card. The starter fund is the structural piece that makes the rest of the plan stick."
      },
      {
        "id": "q9",
        "prompt": "Where is the appropriate place to keep emergency fund money?",
        "options": [
          "A taxable brokerage account invested in a balanced portfolio.",
          "A Roth IRA, because contributions can be withdrawn.",
          "A high-yield savings account or similar FDIC-insured product.",
          "A long-term certificate of deposit."
        ],
        "correct": 2,
        "explanation": "An emergency fund must be safe and liquid. High-yield savings accounts are the standard: FDIC insured, same-day access, modest interest. Investment returns are explicitly not the goal."
      },
      {
        "id": "q10",
        "prompt": "Which of the following is the correct order of the CFP Board's six-step planning workflow?",
        "options": [
          "Recommend → Analyze → Implement → Monitor → Goals → Understand.",
          "Understand the situation → Identify goals → Analyze current course → Develop recommendations → Implement → Monitor.",
          "Implement → Recommend → Goals → Analyze → Monitor → Understand.",
          "Goals → Recommend → Understand → Analyze → Implement → Monitor."
        ],
        "correct": 1,
        "explanation": "The six steps are: (1) Understand the client's situation, (2) Identify and select goals, (3) Analyze the current course of action, (4) Develop recommendations, (5) Implement, (6) Monitor and review."
      },
      {
        "id": "q11",
        "prompt": "A complete recommendation, per the standard of practice, includes:",
        "options": [
          "Just the action.",
          "The action and the cost.",
          "The action, the rationale tied to the goal, the trade-offs, and alternatives considered.",
          "Whatever fits on one page."
        ],
        "correct": 2,
        "explanation": "A recommendation isn't an instruction — it's an argument. It contains the specific action, why it's the right action given the client's goal, what trade-offs it requires, and what alternatives you considered. This is also what makes a recommendation defensible later."
      },
      {
        "id": "q12",
        "prompt": "Which of the following is consistent with professional handling of personally identifiable information (PII)?",
        "options": [
          "Sending a client's tax return back to them as an email attachment.",
          "Reading account numbers aloud in an open conference room.",
          "Following the minimum-necessary principle — collecting only the PII actually required for the work.",
          "Storing client documents on a personal home laptop for convenience."
        ],
        "correct": 2,
        "explanation": "Minimum-necessary is the rule: collect only what's needed. The other three answers describe direct violations of standard PII handling: no PII over insecure email, no audible disclosure in non-private spaces, no firm data on personal devices."
      },
      {
        "id": "q13",
        "prompt": "Naomi (age 34, $90k W-2 salary, stable industry, dual-income parents nearby, 18 months in current role) has $18,000 in high-yield savings. Her essential monthly expenses are $3,100. Which is the most defensible recommendation?",
        "options": [
          "Move all $18,000 into a taxable brokerage account immediately.",
          "Increase HYSA to $30,000 before any investing.",
          "Keep roughly $9,000–$10,000 in HYSA (3 months essentials, leaning low given her stability) and invest the remainder in a diversified taxable portfolio.",
          "Use $18,000 to pay down her student loans."
        ],
        "correct": 2,
        "explanation": "Three to six months of essentials puts her range at $9,300–$18,600. Given her stable W-2 employment, strong industry, and support network, leaning toward the lower end of the range is defensible. The exercise turns a feeling (\"too much cash\") into a defended number."
      },
      {
        "id": "q14",
        "prompt": "A client asks you about a transaction that involves an account owned by their elderly parent, who is not in the meeting and hasn't been disclosed. What's the correct response?",
        "options": [
          "Help them, since they're family.",
          "Refuse and end the meeting immediately.",
          "Pause, decline to proceed without the account owner's involvement, and escalate to a supervisor.",
          "Suggest they send the parent's account credentials over email so you can review."
        ],
        "correct": 2,
        "explanation": "Pause, decline, escalate. Requests involving an account the client doesn't legally control require immediate supervisor involvement. The cost of escalation is small; the cost of doing nothing can be large, including elder financial abuse situations."
      },
      {
        "id": "q15",
        "prompt": "Which statement best captures the right relationship between compliance discipline and serving clients well?",
        "options": [
          "Compliance is paperwork that slows down real client work.",
          "Compliance is how the help happens — the same discipline that protects PII is the discipline that protects the relationship.",
          "Compliance only matters in audits.",
          "Compliance is the supervisor's job, not the counselor's."
        ],
        "correct": 1,
        "explanation": "Compliance and good client service are the same thing, not opposites. The notes that protect PII are the notes the client wants when they ask six months later what was discussed. The audit trail compliance requires is the same record that lets you serve the client well over time."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 1;

-- ============================================================================
-- DONE.
-- This module remains in 'draft' status until Cathy Jackson-Gent approves it
-- through the admin UI. Apprentices won't see it until then. Administrators
-- will see the "Drafted · Awaiting Review" badge on the module.
-- ============================================================================

-- ── module2_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 2 CONTENT
-- Time Value of Money & Compounding
-- ============================================================================
-- Updates module 2 metadata + content. Status remains 'draft' until Cathy
-- Jackson-Gent approves via the admin UI. Safe to re-run; uses UPDATE.
-- ============================================================================

update public.modules set
  title = 'Time Value of Money & Compounding',
  competency_id = 'CORE-2',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The single most important mathematical idea in personal finance: why a dollar today is not a dollar tomorrow, and how time turns small differences into life-changing ones.',
  learning_objectives = ARRAY[
    'Explain why money has time value and articulate the four drivers behind it.',
    'Compute present value and future value of single cash flows by hand and with a spreadsheet.',
    'Apply the Rule of 72 to estimate doubling times and required rates of return.',
    'Distinguish nominal from real returns and compute inflation-adjusted outcomes.',
    'Choose the right model — single sum, annuity, or growing stream — for a given client question.',
    'Explain compounding to a client in plain language using a worked example.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Money Has Time Value",
      "summary": "The single most important math idea in personal finance, in plain language.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "If a client offered you $10,000 today or $10,000 in five years, the choice is obvious. The interesting question is <em>why</em> — and the answer underwrites almost every recommendation a Wealth Solutions Counselor will ever make." },
        { "type": "paragraph", "text": "Money has <strong>time value</strong>. A dollar in hand today is worth more than a dollar promised later. Internalize this until it feels obvious; the math that follows is the formal expression of it." },

        { "type": "heading", "text": "The four drivers" },
        { "type": "numbered", "items": [
          "<strong>Opportunity cost.</strong> A dollar today can be invested. That dollar working for you is a dollar you don't have to wait for. The return you give up by waiting is the opportunity cost of delay.",
          "<strong>Inflation.</strong> Prices rise. The same dollar buys less next year than this year. Even if the nominal number is preserved, purchasing power isn't.",
          "<strong>Risk and uncertainty.</strong> A promise to pay you later carries the risk it won't be honored. The dollar in hand has resolved that risk; the dollar later has not.",
          "<strong>Preference.</strong> Humans generally prefer present consumption over future consumption. We discount the future not just because the math says we should, but because we're wired to."
        ]},

        { "type": "callout", "kind": "key", "title": "Why this matters in practice", "text": "Every retirement projection, every \"should I take the lump sum or the pension?\" question, every \"is it worth refinancing?\" calculation rests on time value of money. Without fluency here, an advisor can only repeat rules of thumb. With it, they can actually answer the question on the table." },

        { "type": "heading", "text": "The two operations" },
        { "type": "paragraph", "text": "There are really only two moves to learn:" },
        { "type": "list", "items": [
          "<strong>Compounding</strong> — moving money <em>forward</em> in time. What is $1 today worth in 30 years at 7%?",
          "<strong>Discounting</strong> — moving money <em>backward</em> in time. What is a $100,000 inheritance 20 years from now worth today at 5%?"
        ]},
        { "type": "paragraph", "text": "Every financial calculation in this module is one of those two operations, sometimes applied to a single dollar, sometimes applied to a stream of dollars. Get them in your fingertips and the rest becomes mechanical." },

        { "type": "callout", "kind": "do", "title": "The fluency reflex", "text": "When a client says \"I'll have $500,000 saved by retirement,\" your reflex should be: <em>in what year, and in today's dollars or future dollars?</em> That single question separates an advisor who can plan from one who can only recite numbers." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Present Value and Future Value",
      "summary": "The two formulas underneath every plan you'll ever build.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two formulas do nearly all the work. Memorize the structure, not just the symbols — once you can write them from memory and explain what each piece means, you've crossed the line from rule-of-thumb advisor to fluent one." },

        { "type": "heading", "text": "Future Value of a single sum" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>FV = PV × (1 + r)<sup>n</sup></strong><br/>Where PV is the present amount, r is the periodic rate, and n is the number of periods." },
        { "type": "paragraph", "text": "Example: $10,000 today, invested at 7% annually for 30 years." },
        { "type": "list", "items": [
          "FV = 10,000 × (1.07)<sup>30</sup>",
          "FV = 10,000 × 7.6123",
          "FV ≈ <strong>$76,123</strong>"
        ]},
        { "type": "paragraph", "text": "Notice what happened: the original $10,000 grew to more than seven times itself. The earning generated more earnings, which generated still more. That's compounding — and it's the engine behind every long-horizon plan." },

        { "type": "heading", "text": "Present Value of a single sum" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>PV = FV ÷ (1 + r)<sup>n</sup></strong><br/>The same equation, rearranged to ask the opposite question." },
        { "type": "paragraph", "text": "Example: A client expects to inherit $250,000 in 15 years. If you discount at 5% (the rate they could reasonably earn on safe money), what's that inheritance worth today in their plan?" },
        { "type": "list", "items": [
          "PV = 250,000 ÷ (1.05)<sup>15</sup>",
          "PV = 250,000 ÷ 2.0789",
          "PV ≈ <strong>$120,257</strong>"
        ]},
        { "type": "paragraph", "text": "The expected inheritance is real money, but it is not <em>today's</em> money. When you build a current-state net worth statement, you do not list it at $250,000 — that overstates the client's actual position. Either omit it (the conservative approach) or list it at present value with a note about discount rate and timing." },

        { "type": "callout", "kind": "warn", "title": "The most common mistake", "text": "Mixing nominal and discounted figures inside the same plan. If retirement spending is in today's dollars, future portfolio values must also be in today's dollars — or both must be in future dollars. Pick one frame and stay there. Otherwise the plan looks fine on paper and fails in reality." },

        { "type": "heading", "text": "The variables to think about" },
        { "type": "glossary", "terms": [
          { "term": "Rate (r)", "definition": "The expected return per period, expressed as a decimal. 7% per year is 0.07. Be careful: if periods are monthly, the rate must also be monthly — divide annual by 12." },
          { "term": "Periods (n)", "definition": "The number of compounding periods, not the number of years. Monthly compounding over 30 years means n = 360, not n = 30." },
          { "term": "Discount rate", "definition": "The rate used to bring future dollars back to today. Often the expected long-term return on safe assets, or the client's after-tax investment hurdle." },
          { "term": "Effective annual rate (EAR)", "definition": "The actual annualized return after accounting for compounding frequency. 6% compounded monthly is an EAR of about 6.17%." }
        ]},

        { "type": "activity", "title": "Build the spreadsheet you'll use forever", "prompt": "Open a spreadsheet. In separate cells, build a small FV/PV calculator you can reuse with clients.", "steps": [
          "Cell A1: \"Present Value\". A2: 10000.",
          "Cell B1: \"Rate (annual)\". B2: 0.07.",
          "Cell C1: \"Years\". C2: 30.",
          "Cell D1: \"Future Value\". D2: =A2*(1+B2)^C2.",
          "Confirm D2 reads approximately 76,123. Now play with B2 and C2 to feel how returns and time interact.",
          "Add a second row for PV: PV = FV/(1+r)^n. Use it on the $250,000-in-15-years example."
        ]}
      ]
    },

    {
      "id": "lesson-3",
      "title": "Compounding and the Rule of 72",
      "summary": "The engine of long-horizon wealth, and the back-of-envelope trick every advisor uses.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Compounding is what Einstein (apocryphally) called the most powerful force in the universe. Whether or not he said it, the math is real: when returns earn returns, growth accelerates non-linearly. A counselor who teaches a 25-year-old to save $300/month with confidence in this idea changes the trajectory of a life." },

        { "type": "heading", "text": "Simple vs. compound interest" },
        { "type": "paragraph", "text": "<strong>Simple interest</strong> pays only on the original principal. $1,000 at 7% simple yields $70 per year, every year. After 30 years: $1,000 + (30 × $70) = $3,100." },
        { "type": "paragraph", "text": "<strong>Compound interest</strong> pays on principal <em>and</em> accumulated earnings. The $70 you earned in year one earns its own return in year two. After 30 years at 7% compounded annually: $1,000 × (1.07)<sup>30</sup> ≈ <strong>$7,612</strong>. More than double the simple result, from the same starting principal and the same rate." },
        { "type": "callout", "kind": "key", "title": "Time does the heavy lifting", "text": "Compound growth is shallow early and steep late. The first decade looks modest; the last decade looks miraculous. Clients who quit early miss the part of the curve they were waiting for." },

        { "type": "heading", "text": "The Rule of 72" },
        { "type": "callout", "kind": "key", "text": "<strong>Years to double ≈ 72 ÷ rate</strong><br/>At 6% annual returns, money doubles every ~12 years. At 9%, every ~8 years. At 4%, every ~18 years." },
        { "type": "paragraph", "text": "It's an approximation, not a precise formula, but it's accurate enough to do in your head while a client is asking a question. Use it to estimate doubling times, to back into required rates, and to make compounding feel concrete in conversation." },

        { "type": "subheading", "text": "Sample uses" },
        { "type": "list", "items": [
          "Client is 35 and has $50,000 invested. At an expected 7% return, the money roughly doubles every 10 years (72 ÷ 7). By age 65 — three doublings — it's roughly $400,000, before any additional contributions.",
          "Client wants to double their money in 6 years. They'd need approximately 12% returns (72 ÷ 6). Use that to anchor a conversation about realistic expectations and risk.",
          "Client says their CD pays 4.5%. Their money doubles every ~16 years. Helpful frame when comparing to an alternative investment."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Why small differences in rate become enormous" },
        { "type": "paragraph", "text": "Take three clients, each saving $500/month from age 25 to age 65 — same amount, same length, different rates. Watch what happens:" },
        { "type": "list", "items": [
          "At <strong>4%</strong> annual return: ~$590,000 at retirement.",
          "At <strong>7%</strong> annual return: ~$1,300,000 at retirement.",
          "At <strong>10%</strong> annual return: ~$3,160,000 at retirement."
        ]},
        { "type": "paragraph", "text": "Same person. Same monthly habit. Same career. The difference is rate of return and the multiplicative power of time. That gap is why advisor choices about fees, asset allocation, and tax efficiency matter — they shift the rate slightly, and the slight shift, compounded for decades, becomes life-altering." },

        { "type": "callout", "kind": "warn", "title": "The honest caveat", "text": "These projections assume constant returns. Real markets don't deliver constant returns — they deliver sequences. A bad sequence early in accumulation hurts less than a bad sequence early in retirement, but both matter. Compounding math is a planning tool, not a prophecy." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Discounting and Decision-Making",
      "summary": "Running the math backwards: how to compare options that pay off at different times.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Discounting is compounding run backwards. It's the move that lets you compare apples to apples when one option pays now and another pays later." },

        { "type": "heading", "text": "Why discounting matters" },
        { "type": "paragraph", "text": "Clients constantly face comparison problems where the cash flows are at different times:" },
        { "type": "list", "items": [
          "Take the $50,000 lump sum bonus today or the $60,000 deferred for three years?",
          "Take Social Security at 62 or wait until 70?",
          "Pay off the mortgage now with savings or invest and pay it down on schedule?",
          "Lease or buy the car?",
          "Pay tuition out of pocket or take the loan?"
        ]},
        { "type": "paragraph", "text": "None of these questions can be answered honestly without putting all the cash flows on a common time footing. That common footing is <em>present value</em>." },

        { "type": "heading", "text": "Picking a discount rate" },
        { "type": "paragraph", "text": "The choice of discount rate is consequential. A higher rate makes future money look worth less today; a lower rate makes it look worth more. Common practice:" },
        { "type": "list", "items": [
          "<strong>For safe, near-certain flows</strong> (Social Security, pension, Treasury): use a low rate, often the long-term inflation-adjusted Treasury yield (1–3% real).",
          "<strong>For risky flows</strong> (stock returns, business earnings): use a higher rate that compensates for the risk (often 6–10% nominal).",
          "<strong>For client-specific decisions</strong> (refinance, lump-sum vs. annuity): use the client's after-tax expected portfolio return as a defensible default.",
          "<strong>For comparisons against a known alternative</strong>: use the rate of the alternative as the discount rate. If the choice is \"take the cash or invest it,\" discount future cash flows at the rate you'd actually earn investing."
        ]},
        { "type": "callout", "kind": "do", "title": "Show your work", "text": "Always document the discount rate used and the rationale. Two equally smart advisors can defensibly produce different answers using different discount rates. Documenting the choice converts the analysis from a guess into a defensible recommendation." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The pension decision",
          "scenario": "A 60-year-old client is offered a choice from her employer: take a $400,000 lump sum today, or take a single-life annuity of $24,000/year for life starting at age 65. She is in good health; life expectancy is 87. Her after-tax expected portfolio return is 5%. Which option is mathematically larger?",
          "discussion": "<p>Twenty-two annual payments of $24,000 from age 65 to age 87. Discount each back to age 60 at 5%.</p><p>Approximate present value of the annuity stream at age 60: ~<strong>$280,000</strong>. (Each payment discounted to today, then summed.)</p><p>Lump sum: <strong>$400,000</strong>.</p><p>Mathematically, the lump sum is larger — by about $120,000 in present-value terms. But the analysis isn't done. The pension is insured against longevity (it pays as long as she lives), and the lump sum is exposed to market risk and her own withdrawal discipline. A complete recommendation weighs the math <em>and</em> the structural risk. Often the right answer for a healthy, disciplined investor is the lump sum; for an unsteady investor or someone with strong longevity in the family, it's the pension. Present value gives you the floor for the conversation — not the ceiling.</p>"
        },

        { "type": "callout", "kind": "key", "title": "The frame to teach clients", "text": "<em>\"Future dollars are smaller dollars. How much smaller depends on how long you wait and what you could have done with the money in the meantime. My job is to make sure we're comparing dollars on the same time footing — that's why I'll talk about present value.\"</em>" }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Annuities, Lump Sums, and Payment Streams",
      "summary": "Single flows vs. multiple flows — recognizing which math to use.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Real client situations rarely involve a single cash flow. They involve streams — monthly contributions over a career, monthly withdrawals in retirement, recurring premium payments, mortgage installments. The math for streams is built on the math for single sums, but it has a few special-case shortcuts worth knowing." },

        { "type": "heading", "text": "Ordinary annuity vs. annuity due" },
        { "type": "list", "items": [
          "<strong>Ordinary annuity</strong> — payments at the <em>end</em> of each period. Most loans, most savings contributions, most bond coupons.",
          "<strong>Annuity due</strong> — payments at the <em>beginning</em> of each period. Most rent, most insurance premiums, most lease payments."
        ]},
        { "type": "paragraph", "text": "The difference matters: an annuity due is worth slightly more than an ordinary annuity of the same payments, because each dollar has one extra period to earn. Most calculators and spreadsheets let you specify which type; check the default before trusting the answer." },

        { "type": "heading", "text": "Future value of an annuity" },
        { "type": "paragraph", "text": "How much will regular contributions grow to? This is the question behind every retirement projection:" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>FV<sub>annuity</sub> = PMT × [((1 + r)<sup>n</sup> − 1) ÷ r]</strong>" },
        { "type": "paragraph", "text": "Example: $500/month into a retirement account, 7% annual return, 30 years." },
        { "type": "list", "items": [
          "Monthly rate: 0.07 ÷ 12 = 0.005833",
          "Periods: 30 × 12 = 360",
          "FV = 500 × [((1.005833)<sup>360</sup> − 1) ÷ 0.005833]",
          "FV ≈ <strong>$609,985</strong>"
        ]},
        { "type": "paragraph", "text": "Notice: the client contributed a total of $500 × 360 = $180,000. The remaining $430,000+ is compound growth. That ratio gets more dramatic the longer the time horizon. It's why starting young matters so much." },

        { "type": "heading", "text": "Present value of an annuity" },
        { "type": "paragraph", "text": "What is a stream of future payments worth right now? Used for pension valuations, lottery cash-vs-annuity decisions, mortgage payoff math, and bond pricing:" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>PV<sub>annuity</sub> = PMT × [(1 − (1 + r)<sup>−n</sup>) ÷ r]</strong>" },
        { "type": "paragraph", "text": "Example: A pension paying $30,000/year for 20 years, discounted at 5%." },
        { "type": "list", "items": [
          "PV = 30,000 × [(1 − (1.05)<sup>−20</sup>) ÷ 0.05]",
          "PV = 30,000 × 12.4622",
          "PV ≈ <strong>$373,866</strong>"
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "When the stream grows" },
        { "type": "paragraph", "text": "Real cash flow streams often aren't flat — retirement spending usually rises with inflation, salaries grow over a career, business revenue compounds. A <strong>growing annuity</strong> adjusts the formula:" },
        { "type": "callout", "kind": "key", "title": "Growing annuity PV", "text": "<strong>PV = PMT × [1 − ((1 + g) ÷ (1 + r))<sup>n</sup>] ÷ (r − g)</strong><br/>Where g is the growth rate of the payments. Requires r > g, otherwise the math diverges." },
        { "type": "callout", "kind": "note", "title": "When you'll really use this", "text": "Building a retirement spending plan where expenses grow with inflation, or pricing a business with growing earnings. For most client conversations, having a financial planning calculator (like the ones in MoneyGuide, RightCapital, or even a competent spreadsheet) handle the math is fine — but knowing what the model is doing under the hood lets you challenge a result that doesn't pass the smell test." },

        { "type": "case_study",
          "title": "How much will Marcus and Tasha have at 65?",
          "scenario": "Marcus and Tasha (couple from Module 1) are 42 and 41 respectively. They're contributing $1,800/month combined to retirement accounts. Expected 7% return until retirement at 65. What's their projected nest egg if they keep their current pace?",
          "discussion": "<p>Treat as ordinary annuity. Monthly contributions $1,800. Monthly rate 0.07/12 = 0.005833. Periods = 24 × 12 = 288.</p><p>FV ≈ <strong>$1,506,000</strong>.</p><p>That number is meaningless without context: <em>is it enough?</em> A common rule of thumb is the 4% safe withdrawal rule — $1.5M supports ~$60,000/year of inflation-adjusted spending. Compare to their needs (which we'd compute separately). Once you have current trajectory and projected need, you can tell whether the plan is on track or has a gap to close. <strong>That</strong> is what time value of money lets you do that intuition alone never can.</p>"
        }
      ]
    },

    {
      "id": "lesson-6",
      "title": "Inflation, Real vs. Nominal, and the Honest Plan",
      "summary": "The silent variable that turns optimistic plans into disappointing ones.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every long-term plan must answer one question honestly: <em>what will the dollars actually buy?</em> A retirement projection that says \"you'll have $2 million\" is incomplete without specifying what $2 million in 2050 will purchase compared to $2 million today. The bridge between those is inflation." },

        { "type": "heading", "text": "Nominal vs. real" },
        { "type": "list", "items": [
          "<strong>Nominal return</strong> — the raw return without adjustment. The number on the statement.",
          "<strong>Real return</strong> — the return after subtracting inflation. The actual increase in purchasing power.",
          "<strong>Real ≈ Nominal − Inflation</strong> (more precisely: (1 + nominal) / (1 + inflation) − 1, but the subtraction is a fine approximation for advisor work)."
        ]},
        { "type": "paragraph", "text": "Long-run U.S. stock returns are often quoted around 10% nominal. Long-run inflation has averaged around 3%. So the long-run <em>real</em> return on stocks is closer to 7% — and 7% is the number a retirement plan should use if expenses are stated in today's dollars." },

        { "type": "callout", "kind": "warn", "title": "The most common plan failure", "text": "Building a plan with a 10% expected return on the portfolio and a flat retirement spending number in today's dollars. The math is mixed: stocks grow at the nominal rate, but expenses also grow with inflation. Either model both in real terms (7% return, today's spending, no inflation on expenses) or both in nominal terms (10% return, growing spending). Picking one frame and staying there is the difference between a plan that works and one that quietly fails." },

        { "type": "heading", "text": "The inflation calculation" },
        { "type": "paragraph", "text": "How much will $80,000 of annual spending today cost in 30 years at 3% inflation?" },
        { "type": "list", "items": [
          "FV = 80,000 × (1.03)<sup>30</sup>",
          "FV = 80,000 × 2.4273",
          "FV ≈ <strong>$194,000</strong>"
        ]},
        { "type": "paragraph", "text": "The client doesn't need to budget $194,000 in 2055 because they're suddenly extravagant. They need to budget $194,000 because that's what $80,000 of today's lifestyle costs at that point." },

        { "type": "subheading", "text": "Categories that inflate differently" },
        { "type": "paragraph", "text": "Headline CPI is an average. Some categories run hotter:" },
        { "type": "list", "items": [
          "<strong>Healthcare</strong> — historically 4–6% per year, well above headline CPI. Material for any retiree projection.",
          "<strong>Higher education</strong> — historically 5–7% per year, though slowing recently. Critical if college costs are in the plan.",
          "<strong>Housing</strong> — varies widely by region; coastal markets have run far above CPI for decades.",
          "<strong>Technology/electronics</strong> — sometimes deflationary."
        ]},
        { "type": "callout", "kind": "do", "title": "Inflation rates worth using as defaults", "text": "Headline CPI: 3% as a long-term planning assumption. Healthcare: 5%. Higher education: 5%. Override defaults with current data when running a plan; default rates are starting points, not destinations." },

        { "type": "divider" },

        { "type": "heading", "text": "Real returns by asset class — long-run estimates" },
        { "type": "paragraph", "text": "Useful long-run real return assumptions for planning, in approximate ranges (these vary by source; always document yours):" },
        { "type": "list", "items": [
          "<strong>Cash/short Treasuries</strong>: roughly 0% to 1% real",
          "<strong>Long-term Treasuries</strong>: roughly 1% to 2% real",
          "<strong>Investment-grade bonds</strong>: roughly 1% to 3% real",
          "<strong>U.S. stocks</strong>: roughly 5% to 7% real",
          "<strong>International developed stocks</strong>: roughly 4% to 6% real",
          "<strong>Emerging markets stocks</strong>: roughly 5% to 7% real with higher volatility"
        ]},
        { "type": "callout", "kind": "note", "title": "These are not guarantees", "text": "Past performance describes a history; it doesn't promise a future. Long-run averages mask decades of underperformance and outperformance. Use these as planning anchors, not promises to clients. The standard advisor language is \"expected\" or \"long-term assumption,\" never \"will earn.\"" },

        { "type": "activity", "title": "Build the honest retirement projection", "prompt": "Pick a hypothetical client (or yourself). Build a single-page projection that handles inflation correctly.", "steps": [
          "State current age, retirement age, life expectancy.",
          "State retirement annual spending in <em>today's dollars</em>.",
          "Choose an expected portfolio real return (e.g., 5%) and a planning inflation rate (e.g., 3%).",
          "Project the future-dollar spending need at retirement age, and at age 85.",
          "Project the portfolio balance at retirement age, given current savings and ongoing contributions.",
          "Convert the portfolio balance to a sustainable real income using a 4% withdrawal rate.",
          "Compare to need. Note the gap or surplus.",
          "On a separate line, document every assumption: rates, inflation, withdrawal, life expectancy. This is the audit trail."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Why does money have time value?",
        "options": [
          "Because banks charge fees that reduce its worth over time.",
          "Because of opportunity cost, inflation, risk, and human preference for present consumption.",
          "Because the Federal Reserve adjusts interest rates each year.",
          "Because the IRS taxes future dollars at a higher rate."
        ],
        "correct": 1,
        "explanation": "The four drivers are opportunity cost (a dollar today can be invested), inflation (future dollars buy less), risk (future promises may not be kept), and preference (humans prefer present consumption)."
      },
      {
        "id": "q2",
        "prompt": "What is $5,000 today worth in 20 years at 8% annual returns?",
        "options": [
          "Approximately $13,000",
          "Approximately $19,000",
          "Approximately $23,000",
          "Approximately $33,000"
        ],
        "correct": 2,
        "explanation": "FV = 5,000 × (1.08)^20 = 5,000 × 4.661 ≈ $23,305."
      },
      {
        "id": "q3",
        "prompt": "Using the Rule of 72, approximately how long does money take to double at 6% annual returns?",
        "options": [
          "6 years",
          "9 years",
          "12 years",
          "18 years"
        ],
        "correct": 2,
        "explanation": "72 ÷ 6 = 12 years. The Rule of 72 is a quick mental approximation, accurate enough for advisor conversations."
      },
      {
        "id": "q4",
        "prompt": "A client expects to inherit $200,000 in 10 years. At a 5% discount rate, what is that inheritance worth today?",
        "options": [
          "Approximately $100,000",
          "Approximately $123,000",
          "Approximately $150,000",
          "Approximately $200,000"
        ],
        "correct": 1,
        "explanation": "PV = 200,000 ÷ (1.05)^10 = 200,000 ÷ 1.6289 ≈ $122,782."
      },
      {
        "id": "q5",
        "prompt": "Which of the following is the most common mistake when building long-term plans?",
        "options": [
          "Using too high a discount rate.",
          "Mixing nominal and real figures inside the same plan.",
          "Using monthly instead of annual compounding.",
          "Ignoring the Rule of 72."
        ],
        "correct": 1,
        "explanation": "If portfolio returns are nominal but expenses are flat in today's dollars (or vice versa), the plan is internally inconsistent and will mislead. Pick one frame — real or nominal — and stay there throughout."
      },
      {
        "id": "q6",
        "prompt": "A client saves $400/month for 35 years at 7% annual returns. Approximately what will the account be worth at the end?",
        "options": [
          "Approximately $168,000",
          "Approximately $390,000",
          "Approximately $722,000",
          "Approximately $1,050,000"
        ],
        "correct": 2,
        "explanation": "Monthly rate 0.07/12 = 0.005833, periods = 35 × 12 = 420. FV of annuity = 400 × [((1.005833)^420 − 1) / 0.005833] ≈ $722,000. The client contributed $168,000; the remaining $554,000+ is compound growth."
      },
      {
        "id": "q7",
        "prompt": "If long-term U.S. stock nominal returns average about 10% and long-term inflation averages about 3%, the real return on stocks is approximately:",
        "options": [
          "3%",
          "7%",
          "10%",
          "13%"
        ],
        "correct": 1,
        "explanation": "Real ≈ Nominal − Inflation. 10% − 3% ≈ 7%. This is the number to use if expenses in the plan are stated in today's dollars."
      },
      {
        "id": "q8",
        "prompt": "Which is the right discount rate to use when a client is choosing between a $50,000 cash bonus today and an alternative they would otherwise invest in a balanced portfolio?",
        "options": [
          "The risk-free Treasury rate.",
          "The client's expected after-tax return on the balanced portfolio.",
          "Whatever inflation is currently.",
          "10%, by default."
        ],
        "correct": 1,
        "explanation": "When the choice is between an option and a known alternative, the right discount rate is the rate of the alternative. Anything else doesn't match the decision being made."
      },
      {
        "id": "q9",
        "prompt": "Healthcare costs historically inflate at what rate relative to general CPI?",
        "options": [
          "Below CPI.",
          "Roughly the same as CPI.",
          "Above CPI, typically 4–6% per year long-run.",
          "Healthcare doesn't inflate; insurance pays for it."
        ],
        "correct": 2,
        "explanation": "Healthcare runs persistently above headline CPI — often 4–6% historically. Critical for any retiree projection where healthcare is a major line item."
      },
      {
        "id": "q10",
        "prompt": "A client's annual living expenses today are $90,000. At 3% inflation, what will those same expenses cost in 25 years?",
        "options": [
          "Approximately $115,000",
          "Approximately $135,000",
          "Approximately $188,000",
          "Approximately $270,000"
        ],
        "correct": 2,
        "explanation": "FV = 90,000 × (1.03)^25 = 90,000 × 2.0938 ≈ $188,440. The number isn't an exaggeration — it's what today's lifestyle costs 25 years from now."
      },
      {
        "id": "q11",
        "prompt": "Which of the following best describes the difference between an ordinary annuity and an annuity due?",
        "options": [
          "Ordinary annuities pay interest, annuities due pay principal.",
          "Ordinary annuities are taxable, annuities due are not.",
          "Ordinary annuities pay at the end of each period, annuities due pay at the beginning.",
          "There is no difference; the terms are interchangeable."
        ],
        "correct": 2,
        "explanation": "Ordinary annuity: end-of-period payments (loans, savings contributions, bond coupons). Annuity due: beginning-of-period payments (rent, insurance, leases). The annuity due is worth slightly more because each dollar has one extra period to earn."
      },
      {
        "id": "q12",
        "prompt": "A 60-year-old client is offered a $400,000 lump sum or $24,000/year for life starting at 65. Life expectancy is 87. Discount rate is 5%. What does the math suggest, and what's missing from the math?",
        "options": [
          "The annuity is mathematically larger; risk doesn't change that.",
          "The lump sum is mathematically larger by roughly $120,000 in present-value terms, but the annuity has longevity insurance and reduced behavioral risk that the math doesn't capture.",
          "They are identical; pensions and lump sums are designed to be equivalent.",
          "The lump sum is always wrong because clients spend lump sums irresponsibly."
        ],
        "correct": 1,
        "explanation": "PV of the annuity stream is approximately $280,000 at age 60 (22 payments of $24,000 starting in 5 years, discounted at 5%). Lump sum is $400,000. Math favors the lump sum by roughly $120,000 — but the annuity offers longevity insurance and removes withdrawal-discipline risk. The complete recommendation weighs the math and the structural risk together."
      },
      {
        "id": "q13",
        "prompt": "What is the right reflex when a client says, \"I'll have $500,000 saved by retirement\"?",
        "options": [
          "Congratulate them and move on.",
          "Ask whether the figure is in today's dollars or future dollars, and at what year.",
          "Ask whether they've considered international stocks.",
          "Ask what their spouse thinks."
        ],
        "correct": 1,
        "explanation": "Whether $500,000 is in today's dollars or future dollars matters enormously. The advisor's job is to make sure all numbers in a plan are on the same time footing — that question is the first move."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 2;

-- ============================================================================
-- DONE. Module remains 'draft' until Cathy Jackson-Gent approves via admin UI.
-- ============================================================================

-- ── module3_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 3 CONTENT
-- Credit, Debt, and Lending
-- ============================================================================
-- Updates module 3 metadata + content. Status remains 'draft' until Cathy
-- Jackson-Gent approves via the admin UI. Safe to re-run; uses UPDATE.
-- ============================================================================

update public.modules set
  title = 'Credit, Debt, and Lending',
  competency_id = 'CORE-3',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How credit works, how debt structures differ, and how an advisor distinguishes strategic borrowing from destructive borrowing.',
  learning_objectives = ARRAY[
    'Explain the five FICO score factors and how each can be improved.',
    'Distinguish revolving from installment debt and secured from unsecured debt.',
    'Read an APR disclosure correctly and compute the true cost of a loan.',
    'Compare avalanche, snowball, and consolidation strategies — and pick the right one for a given client.',
    'Identify when borrowing serves the plan and when it undermines it.',
    'Walk a client through a credit report and explain what to fix and what to leave alone.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "How Credit Actually Works",
      "summary": "Credit scores, reports, and the levers that move them.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Credit is one of the most important financial systems most clients interact with — and one of the most misunderstood. A Wealth Solutions Counselor doesn't need to be a credit repair specialist, but does need to explain credit clearly, identify what's helping and hurting a client's score, and know when to refer out." },

        { "type": "heading", "text": "The credit score" },
        { "type": "paragraph", "text": "Most U.S. credit decisions use a <strong>FICO score</strong> (300–850) or the competing <strong>VantageScore</strong>. Both predict the same thing: likelihood the borrower will pay back what's owed. Higher score = better rates, more options, lower deposits. Below ~620 = subprime, materially worse terms. Above ~740 = prime, best terms generally available." },

        { "type": "callout", "kind": "key", "title": "The five FICO factors", "text": "<strong>Payment history (35%)</strong>, <strong>amounts owed / utilization (30%)</strong>, <strong>length of credit history (15%)</strong>, <strong>credit mix (10%)</strong>, <strong>new credit (10%)</strong>. Memorize this. It explains almost every score-related question a client will ever ask." },

        { "type": "subheading", "text": "Payment history (35%)" },
        { "type": "paragraph", "text": "On-time payments build score; late payments wreck it. A single 30-day-late payment can drop a prime score by 50–100 points. Late payments hang on a credit report for seven years, though their weight fades over time." },

        { "type": "subheading", "text": "Amounts owed / credit utilization (30%)" },
        { "type": "paragraph", "text": "Specifically, <em>revolving</em> utilization — credit card balances as a percentage of credit limits. A client with $2,000 owed across cards with $10,000 in limits has 20% utilization." },
        { "type": "callout", "kind": "do", "title": "The utilization target", "text": "Keep total revolving utilization under 30%. Under 10% is better for top scores. This is the single fastest score lever a client can pull — paying down a card by a few hundred dollars can move a score within one billing cycle." },

        { "type": "subheading", "text": "Length of credit history (15%)" },
        { "type": "paragraph", "text": "Average age of accounts matters. Older accounts help; new accounts shorten the average and ding the score temporarily. This is why closing an old credit card can <em>lower</em> a score even though intuition says the opposite." },

        { "type": "subheading", "text": "Credit mix (10%)" },
        { "type": "paragraph", "text": "Having both revolving (credit cards) and installment (auto loan, mortgage, student loan) accounts demonstrates broader credit competence. Don't take on debt just to improve mix — the gain is small. But if the mix is unbalanced and other factors are clean, this is the explanation." },

        { "type": "subheading", "text": "New credit (10%)" },
        { "type": "paragraph", "text": "Hard inquiries (when a lender pulls credit for an application) lower the score slightly and stay on the report for two years. One or two are fine. Several in a short period look like financial distress and add up. Note: rate-shopping for the same loan type within ~14–45 days typically counts as a single inquiry." },

        { "type": "divider" },

        { "type": "heading", "text": "The credit report" },
        { "type": "paragraph", "text": "The score is a summary. The <strong>credit report</strong> is the underlying data, produced by three bureaus: Equifax, Experian, and TransUnion. By federal law, every consumer can pull their three reports for free weekly at <em>AnnualCreditReport.com</em>. Doing so does not affect the score (it's a soft inquiry)." },
        { "type": "paragraph", "text": "A credit report contains:" },
        { "type": "list", "items": [
          "<strong>Personal info</strong> — name, address history, employers.",
          "<strong>Accounts</strong> — every open and recently closed credit account, with balances, limits, payment status, and open dates.",
          "<strong>Public records</strong> — bankruptcies (still appear), some judgments and tax liens (mostly removed since 2017, but check).",
          "<strong>Inquiries</strong> — hard and soft pulls of the report."
        ]},

        { "type": "callout", "kind": "warn", "title": "What to check immediately", "text": "Identity theft and reporting errors are common. When you review a client's report, watch for: accounts the client doesn't recognize, addresses they've never lived at, payment lates the client disputes, balances that look wrong. The <em>fix</em> is filing a dispute with the bureau (free, online), but the <em>spotting</em> is the advisor's job." },

        { "type": "activity", "title": "Pull and read your own report", "prompt": "You cannot competently walk a client through this until you've done it yourself.", "steps": [
          "Go to AnnualCreditReport.com and request your three reports (one from each bureau — they're free).",
          "Read each one. Look for errors, unfamiliar accounts, or addresses you don't recognize.",
          "Note the differences between bureaus. They often have slightly different data.",
          "Identify which of the five FICO factors are working for you and which against. Where could you most easily improve?",
          "Save the experience. This is how the conversation feels for a client — you'll be more useful having done it."
        ]}
      ]
    },

    {
      "id": "lesson-2",
      "title": "Types of Debt and How They Differ",
      "summary": "Revolving vs. installment, secured vs. unsecured, and why the structure matters.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "All debt is not the same. Two dimensions describe most consumer debt — <em>how it's structured</em> (revolving vs. installment) and <em>what backs it</em> (secured vs. unsecured). The cross between them determines pricing, risk, and the right advisor move." },

        { "type": "heading", "text": "Revolving vs. installment" },
        { "type": "glossary", "terms": [
          { "term": "Revolving debt", "definition": "A line of credit with a limit. The borrower can draw, repay, and re-draw. Minimum monthly payments, interest accrues on the unpaid balance. Examples: credit cards, home equity lines of credit (HELOCs), some personal lines." },
          { "term": "Installment debt", "definition": "A fixed loan amount with a scheduled repayment period and (usually) fixed payments. The balance can't be re-drawn. Examples: mortgages, auto loans, most student loans, personal loans." }
        ]},
        { "type": "paragraph", "text": "Revolving debt is more flexible and more dangerous. The flexibility is what makes it useful in emergencies; the danger is that without discipline, balances grow indefinitely. Installment debt is rigid in the opposite direction — you can't borrow more without applying again, but the schedule guarantees the debt ends." },

        { "type": "heading", "text": "Secured vs. unsecured" },
        { "type": "glossary", "terms": [
          { "term": "Secured debt", "definition": "Backed by collateral the lender can seize if payments stop. Examples: mortgages (house), auto loans (car), HELOCs (house). Lower interest rates because the lender's downside is protected." },
          { "term": "Unsecured debt", "definition": "Not backed by collateral. The lender's only recourse is the borrower's promise and the credit/legal system. Examples: credit cards, most personal loans, most student loans, medical debt. Higher interest rates to compensate for the higher risk." }
        ]},
        { "type": "callout", "kind": "key", "title": "Why this matters in a plan", "text": "When a household is in distress, secured debt comes first in the payment priority — losing the house or the car is catastrophic. Unsecured debt has more flexibility in workout, settlement, or even bankruptcy. The order in which a household sacrifices and which debts get paid in a crunch follows this logic." },

        { "type": "divider" },

        { "type": "heading", "text": "Typical interest ranges (general benchmarks, vary by market)" },
        { "type": "list", "items": [
          "<strong>30-year fixed mortgage</strong> — historically 3–8%, varies enormously by rate environment. Secured, installment, lowest rates.",
          "<strong>Auto loans</strong> — 4–10% for prime credit, higher for subprime. Secured, installment.",
          "<strong>Federal student loans</strong> — set by Congress annually, often 4–8%. Mostly unsecured but with special status (extremely hard to discharge in bankruptcy).",
          "<strong>HELOCs</strong> — typically variable rate, near or slightly above prime. Secured by the home.",
          "<strong>Personal loans</strong> — 6–15% for prime credit, much higher for subprime. Unsecured installment.",
          "<strong>Credit cards</strong> — 15–30% APR is typical. Unsecured revolving. Rates are <em>not</em> set by inflation or central bank in any direct way — they are set by issuer profitability and credit risk."
        ]},

        { "type": "case_study",
          "title": "The household with five debts",
          "scenario": "A household carries: $12,000 credit card at 22% APR, $18,000 auto loan at 6.5%, $34,000 student loans at 5%, $310,000 mortgage at 4%, $8,000 medical debt at 0%. They have $400/month available beyond minimums and want to know what to do.",
          "discussion": "<p>Mathematically, the credit card at 22% is the highest-cost debt by a wide margin. Every dollar applied there earns a guaranteed 22% return on capital — far better than almost any investment. <strong>Avalanche logic says credit card first</strong>.</p><p>But notice the others: the medical debt at 0% can wait (as long as it's not being sent to collections). The mortgage at 4% probably should not be accelerated — that money outperforms a 4% mortgage rate by most reasonable definitions. The auto loan at 6.5% is borderline; depends on the client's expected portfolio return and emotional preference for being debt-free.</p><p>The full ranked recommendation is: <strong>1) Pay credit card to zero — fastest mathematical win.</strong> <strong>2) Build/restore emergency fund.</strong> <strong>3) Address auto loan or invest the surplus — depends on client preference.</strong> <strong>4) Mortgage and student loans on schedule unless rates rise.</strong> <strong>5) Medical debt — monitor, negotiate if possible, but not a priority while interest-free.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Interest Rates, APR, and the True Cost of Borrowing",
      "summary": "Reading the disclosure correctly — and finding the real number.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "When a lender quotes a rate, the client hears one number. The actual cost can be very different. A competent advisor reads the disclosure carefully and explains what the client is actually paying — not what's on the marketing page." },

        { "type": "heading", "text": "Interest rate vs. APR" },
        { "type": "glossary", "terms": [
          { "term": "Interest rate", "definition": "The cost of borrowing the principal, expressed as a percentage. The headline number on most loans." },
          { "term": "APR (Annual Percentage Rate)", "definition": "The interest rate plus most fees that are required to obtain the loan, expressed as an annual rate. APR is always equal to or higher than the interest rate. Required by the Truth in Lending Act for most consumer loans." },
          { "term": "APY (Annual Percentage Yield)", "definition": "Used for deposit accounts, not loans. Reflects compounding frequency on what the bank pays you." },
          { "term": "Points", "definition": "Fees paid at closing, expressed as a percentage of the loan. One point = 1% of loan amount. Buying points lowers the interest rate; whether it's worth it depends on how long the borrower keeps the loan." }
        ]},

        { "type": "callout", "kind": "key", "title": "The rule of thumb", "text": "<strong>Always compare loans by APR, not by quoted interest rate.</strong> The APR includes the fees. A loan with a low rate and high fees can have the same or higher APR than a loan with a higher rate and no fees." },

        { "type": "heading", "text": "Reading a mortgage disclosure" },
        { "type": "paragraph", "text": "Federal Truth in Lending and TRID rules require lenders to give borrowers a standardized <strong>Loan Estimate</strong> within three days of application and a <strong>Closing Disclosure</strong> at least three days before closing. Both spell out interest rate, APR, fees, payment, and total cost of credit." },
        { "type": "subheading", "text": "What an advisor should check" },
        { "type": "list", "items": [
          "<strong>Interest rate and APR</strong> — the gap between them tells you how much of the price is fees. A small gap (10–30 bps) is normal; a large gap (50+ bps) means meaningful closing costs.",
          "<strong>Loan term</strong> — 30-year vs. 15-year vs. 20-year. Longer terms have lower payments and higher total interest.",
          "<strong>Type</strong> — fixed-rate or ARM? If ARM, how does it adjust and when?",
          "<strong>Points</strong> — are points being purchased? Is the buydown worth it given the expected holding period?",
          "<strong>Origination fees, lender credits, third-party fees</strong> — itemized on the disclosure. Are any negotiable?",
          "<strong>PMI</strong> — required when down payment is below 20% on a conventional loan. Confirm whether and when it falls off.",
          "<strong>Escrows</strong> — taxes and insurance held in escrow. Confirm the monthly amount and that the estimate is reasonable for the property."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Credit card interest in particular" },
        { "type": "paragraph", "text": "Credit card APRs work differently from installment loan APRs. Interest accrues <em>daily</em> on the unpaid balance. There's a grace period — typically 21+ days between statement and due date — during which no interest accrues <em>if</em> the previous balance was paid in full." },
        { "type": "callout", "kind": "warn", "title": "The grace period trap", "text": "Once a balance is carried, the grace period disappears until the balance is fully paid off again, including the most recent month's purchases. New purchases start accruing interest immediately. Many clients don't realize this; they think only the carried balance is charged interest. Worth explaining clearly." },

        { "type": "subheading", "text": "Why minimum payments are toxic" },
        { "type": "paragraph", "text": "A credit card minimum payment is typically the larger of $25 or about 2% of the balance. On a $5,000 balance at 22% APR, the minimum payment is roughly $100/month. Paying only the minimum:" },
        { "type": "list", "items": [
          "Takes approximately <strong>22 years</strong> to pay off the $5,000.",
          "Total interest paid: roughly <strong>$7,000</strong>.",
          "Total amount repaid: roughly <strong>$12,000</strong> on the original $5,000 balance."
        ]},
        { "type": "callout", "kind": "key", "title": "The math that motivates clients", "text": "Walk a client through this calculation. \"Minimum payment\" sounds responsible; the math shows it isn't. The same client paying $200/month instead of $100 would clear the balance in roughly 3 years and pay less than $2,000 in interest. That's a behavior-change conversation made possible by the math, not by lecturing." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Debt Paydown Strategies",
      "summary": "Avalanche, snowball, consolidation, and refinance — when each one fits.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Once a client has multiple debts and some surplus to apply, the strategy question becomes: <em>which one first?</em> The advisor's job is to walk through the options honestly, pick the one most likely to succeed given the client, and document the rationale." },

        { "type": "heading", "text": "Strategy 1 — Avalanche" },
        { "type": "paragraph", "text": "Pay minimums on all debts. Apply every extra dollar to the <strong>highest-interest-rate</strong> debt until it's gone. Then roll that payment into the next-highest, and so on." },
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Mathematically optimal. Best for clients who are motivated by logic and willing to grind. Saves the most interest. The default recommendation when the only consideration is total cost." },
        { "type": "callout", "kind": "warn", "title": "Watch out for", "text": "Can be demoralizing if the highest-rate debt is also the largest balance — the client makes payments for months without seeing a balance disappear. Behavioral fatigue is real and breaks plans." },

        { "type": "heading", "text": "Strategy 2 — Snowball" },
        { "type": "paragraph", "text": "Pay minimums on all debts. Apply every extra dollar to the <strong>smallest-balance</strong> debt until it's gone. Then roll that payment into the next-smallest." },
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Clients who need momentum. Wiping out a debt — any debt — produces a behavioral payoff that keeps the plan moving. For clients who've tried and failed at paydown before, snowball is often the better recommendation even though it costs slightly more in total interest." },
        { "type": "callout", "kind": "note", "title": "The honest math", "text": "Research suggests the snowball method results in higher rates of follow-through and ultimate success than avalanche, despite costing slightly more in interest. The cheapest debt-paydown plan is the one the client actually completes." },

        { "type": "heading", "text": "Strategy 3 — Consolidation" },
        { "type": "paragraph", "text": "Combine multiple debts into a single new loan at a lower rate. Most commonly: rolling several credit cards into a personal loan, or using a balance transfer card with a 0% introductory rate." },
        { "type": "subheading", "text": "When consolidation makes sense" },
        { "type": "list", "items": [
          "The new rate is materially lower than the weighted average rate of the existing debts.",
          "The client has the discipline not to run up the original cards again. (This is the trap that ruins most consolidations.)",
          "The consolidation product itself doesn't carry hidden fees that erode the savings.",
          "The repayment term doesn't extend so far that total interest paid is higher despite the lower rate."
        ]},
        { "type": "callout", "kind": "warn", "title": "The most common failure mode", "text": "Client consolidates credit cards into a personal loan, then runs the cards back up over the next year. Now they have the personal loan <em>and</em> the cards. Total debt is higher than where they started. Consolidation must be paired with a credit-behavior change — sometimes literally cutting up the cards — or it makes things worse." },

        { "type": "heading", "text": "Strategy 4 — Refinance" },
        { "type": "paragraph", "text": "Replace an existing installment loan with a new one at better terms. Most common: mortgages and student loans." },
        { "type": "subheading", "text": "The refinance calculation" },
        { "type": "paragraph", "text": "Refinance is a math problem with two main inputs:" },
        { "type": "list", "items": [
          "<strong>Monthly savings</strong> = old payment − new payment.",
          "<strong>Closing costs</strong> = total cost of doing the refinance (often 2–5% of loan amount on mortgages).",
          "<strong>Break-even months</strong> = closing costs ÷ monthly savings."
        ]},
        { "type": "paragraph", "text": "If the client plans to stay in the home longer than the break-even period, the refinance pays for itself. If they're likely to move before break-even, it doesn't. Anything beyond break-even is pure savings." },
        { "type": "callout", "kind": "do", "title": "The rule of thumb", "text": "A 1% rate reduction typically justifies refinance if the client will hold the loan 3+ more years. Smaller rate reductions can still work if closing costs are low (or rolled into the loan) and the time horizon is long. Always run the actual numbers — rules of thumb aren't recommendations." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "Picking the right strategy",
          "scenario": "Devon (small business owner from Module 1) has: $14,000 in credit cards (avg 23% APR), $7,000 personal loan at 11%, $22,000 auto loan at 6.5%, and $1,500 medical debt at 0%. He has $600/month available beyond minimums.",
          "discussion": "<p>Pure avalanche says credit cards first (highest rate). Pure snowball says medical debt first (smallest balance), then personal loan, then auto, then cards. Consolidation could work if Devon qualifies for a personal loan at, say, 9% to clear the cards.</p><p>Real recommendation: <strong>hybrid</strong>. Start with the medical debt — it's small enough that the $600/month would clear it in 3 months, building momentum and removing a billing relationship. Then attack credit cards aggressively while exploring a consolidation loan or balance transfer card. If a 0% balance transfer is available with a reasonable fee, consider it — but only after Devon agrees to stop using the cards. This gets the snowball motivation AND the avalanche savings, which is often the right combination for a small business owner whose energy is more constrained than their income.</p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Strategic Debt vs. Destructive Debt",
      "summary": "Borrowing that serves the plan, and borrowing that quietly destroys it.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "\"All debt is bad\" is a slogan, not a financial philosophy. Some debt is the cheapest path to a goal a client could not otherwise reach in any reasonable timeframe. Some debt is a slow leak that compounds against the client for years. The advisor's job is knowing the difference and being able to explain it." },

        { "type": "heading", "text": "What makes debt strategic" },
        { "type": "list", "items": [
          "<strong>The asset being financed appreciates or generates cash flow.</strong> A mortgage finances a house that historically appreciates and provides shelter (saving rent). A business loan finances assets that generate revenue.",
          "<strong>The interest rate is materially below the expected return on alternatives.</strong> Borrowing at 3% to invest in something expected to return 7% is, in expectation, profitable — though risk and behavior complicate the picture.",
          "<strong>The term is appropriate to the asset.</strong> Match financing term to the useful life of what's being financed. 30-year mortgages on 30+ year assets, 5-year auto loans on cars driven 5+ years.",
          "<strong>The interest is tax-deductible</strong> (where applicable). Mortgage interest, student loan interest in certain ranges, business loan interest."
        ]},

        { "type": "heading", "text": "What makes debt destructive" },
        { "type": "list", "items": [
          "<strong>Financing depreciating consumption.</strong> Carrying credit card debt for vacations, dining, clothing. The experience is gone; the debt remains.",
          "<strong>Rates that exceed reasonable returns.</strong> 22% credit card debt is a guaranteed −22% on whatever cash isn't applied to it. No reasonable investment strategy beats paying off high-rate revolving debt.",
          "<strong>Structures that resist payoff.</strong> Payday loans, rent-to-own, certain title loans — designed to maximize rollover fees and trap borrowers.",
          "<strong>Borrowing to maintain a lifestyle that income doesn't support.</strong> If a household is going further into debt every month, the structure is broken. More borrowing makes it worse, not better."
        ]},

        { "type": "callout", "kind": "key", "title": "The advisor reframe", "text": "Don't ask \"is debt bad?\" Ask: \"<em>what is this debt accomplishing, at what cost, and is there a cheaper way to accomplish the same thing?</em>\" That question converts a moral debate into a planning conversation." },

        { "type": "divider" },

        { "type": "heading", "text": "The borrowing-to-invest question" },
        { "type": "paragraph", "text": "Wealth Solutions Counselor often encounter the question: <em>should I pay off my mortgage faster or invest the extra?</em> The math says invest if expected returns exceed mortgage rate; the behavior says pay down debt if the client sleeps better that way. Both are defensible. Document the reasoning either way." },

        { "type": "case_study",
          "title": "When the math and the behavior diverge",
          "scenario": "A 50-year-old client with $200,000 mortgage at 3.5%, 20 years remaining, has $50,000 of after-tax cash she's considering applying to the mortgage. Her expected after-tax portfolio return is 6%. She is risk-averse and disliked the 2022 market.",
          "discussion": "<p>Math says invest the $50,000. Expected return 6% vs. 3.5% borrowing cost — about 2.5 percentage points of arbitrage, compounded for 20 years. Material difference.</p><p>Behavior says know your client. If she will panic-sell in the next downturn, the 6% expected return is fictional; she'll capture a much lower realized return. If she would sleep better with the mortgage smaller, the psychological return on the mortgage paydown is real.</p><p>The honest recommendation: <strong>split it.</strong> $25,000 to the mortgage, $25,000 to a taxable brokerage. She gets meaningful debt reduction and meaningful investment exposure. Document the trade-off in writing so when she's evaluating the decision in 5 years, she remembers what we were optimizing for. <em>This is the kind of recommendation a calculator can't generate but a counselor can.</em></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which of the following is the largest factor in a FICO score?",
        "options": [
          "Length of credit history (15%)",
          "New credit (10%)",
          "Payment history (35%)",
          "Credit mix (10%)"
        ],
        "correct": 2,
        "explanation": "Payment history is 35% — the largest single factor. Amounts owed (utilization) is second at 30%. Everything else trails."
      },
      {
        "id": "q2",
        "prompt": "What is the recommended maximum revolving credit utilization for a good FICO score?",
        "options": [
          "Below 50%",
          "Below 30%, ideally below 10%",
          "Below 75%",
          "Utilization doesn't affect the score."
        ],
        "correct": 1,
        "explanation": "Keep utilization under 30%; under 10% is better for top scores. It's the single fastest lever a client can pull — paying down a card can move a score within one billing cycle."
      },
      {
        "id": "q3",
        "prompt": "A client wants to know whether closing an old, unused credit card will help or hurt their score. The correct answer is:",
        "options": [
          "Always helps; less available credit looks better to lenders.",
          "Likely hurts: it shortens average account age and reduces total available credit, which raises utilization.",
          "Doesn't matter to the score either way.",
          "Helps if the card has an annual fee, hurts otherwise."
        ],
        "correct": 1,
        "explanation": "Closing an old card shortens average credit history (length factor, 15%) and lowers total available revolving credit, which raises utilization on remaining balances (amounts owed, 30%). Both effects pull the score down — the opposite of what most clients expect."
      },
      {
        "id": "q4",
        "prompt": "Which best describes the difference between interest rate and APR?",
        "options": [
          "They are the same thing.",
          "APR is the interest rate plus most required fees, expressed annually. APR is always equal to or higher than the interest rate.",
          "APR is what the bank actually charges; interest rate is the marketing number.",
          "APR is for deposits, interest rate is for loans."
        ],
        "correct": 1,
        "explanation": "APR captures fees that are required to obtain the loan — origination, points, certain closing costs. Always compare loans by APR, not by quoted interest rate, because two loans with the same rate can have very different total cost depending on fees."
      },
      {
        "id": "q5",
        "prompt": "A client has $5,000 of credit card debt at 22% APR and is making only minimum payments (about $100/month). Approximately how long will it take to pay off the balance?",
        "options": [
          "About 5 years",
          "About 10 years",
          "About 22 years",
          "About 40 years"
        ],
        "correct": 2,
        "explanation": "Roughly 22 years, with about $7,000 in total interest paid on the original $5,000 balance. Walking a client through this calculation is one of the most behavior-changing conversations in personal finance."
      },
      {
        "id": "q6",
        "prompt": "Which debt-paydown strategy is mathematically optimal?",
        "options": [
          "Snowball — smallest balance first.",
          "Avalanche — highest interest rate first.",
          "Consolidation — combine all debts into one.",
          "Refinance — replace existing debt with a new loan."
        ],
        "correct": 1,
        "explanation": "Avalanche (highest rate first) saves the most interest mathematically. But snowball often produces better real-world results because momentum aids follow-through. The cheapest plan is the one the client actually completes."
      },
      {
        "id": "q7",
        "prompt": "When does consolidation typically make sense?",
        "options": [
          "Always — fewer payments is always better.",
          "When the new rate is materially lower, the term doesn't blow out, and the client agrees not to run up the old accounts.",
          "When the client wants to feel less stressed about debt.",
          "When the consolidation lender offers it; lenders only offer it when it's beneficial."
        ],
        "correct": 1,
        "explanation": "Consolidation works when the new rate is materially lower than the weighted average, the term doesn't extend so far that total interest paid is higher, and (critically) the client commits to not running up the original accounts. The most common failure mode is consolidating credit cards into a personal loan and then re-running the cards."
      },
      {
        "id": "q8",
        "prompt": "For a refinance, the break-even calculation is:",
        "options": [
          "New rate × loan amount",
          "Closing costs ÷ monthly savings",
          "Old rate − new rate",
          "Monthly savings × 12"
        ],
        "correct": 1,
        "explanation": "Break-even months = closing costs ÷ monthly savings. If the client plans to hold the loan longer than the break-even period, the refinance pays for itself. Beyond that, it's pure savings."
      },
      {
        "id": "q9",
        "prompt": "Which of the following is most consistent with 'strategic' borrowing?",
        "options": [
          "Carrying a balance on a credit card to maintain a credit history.",
          "A mortgage on a primary residence with a fixed rate, manageable payment, and an appropriate term.",
          "A payday loan to cover a short-term cash gap.",
          "A personal loan at 14% to take a family vacation."
        ],
        "correct": 1,
        "explanation": "A reasonable mortgage finances an asset that appreciates and provides shelter, at a relatively low rate, with tax-deductible interest. The other examples either finance depreciating consumption or come with structurally bad terms."
      },
      {
        "id": "q10",
        "prompt": "A client has $200,000 left on a 3.5% mortgage and $50,000 of cash. Her expected after-tax portfolio return is 6%. She is risk-averse. What is the most defensible advisor recommendation?",
        "options": [
          "Pay off the mortgage entirely.",
          "Invest all $50,000; math beats behavior every time.",
          "Split — apply part to the mortgage and invest the rest. Document the reasoning so the trade-off is captured.",
          "Refinance the mortgage and invest both proceeds."
        ],
        "correct": 2,
        "explanation": "Math suggests investing (6% expected vs 3.5% borrowing). Behavior suggests paying down for a risk-averse client. The honest recommendation often splits the difference and documents the trade-off, so the client (and a future reviewer) can see what was optimized for and why."
      },
      {
        "id": "q11",
        "prompt": "Where should a client pull their credit report for free?",
        "options": [
          "Through any free credit monitoring app.",
          "Through AnnualCreditReport.com — the official federally-mandated free source.",
          "Through their bank.",
          "By calling each credit bureau directly."
        ],
        "correct": 1,
        "explanation": "AnnualCreditReport.com is the official site mandated by federal law. All three bureaus' reports are available free, and pulling them does not affect the score (soft inquiry). Apps may have ulterior motives or display partial data."
      },
      {
        "id": "q12",
        "prompt": "What is the most common failure mode when consolidating credit card debt into a personal loan?",
        "options": [
          "Personal loan rates rise unexpectedly.",
          "The borrower runs up the original credit cards again, ending with more total debt than they started.",
          "Personal loans have prepayment penalties.",
          "Credit bureaus penalize consolidation."
        ],
        "correct": 1,
        "explanation": "This is the structural risk of consolidation. The personal loan clears the cards, but the cards are still open with zero balances — and very accessible. Without a behavior change (often literally cutting up the cards), the cards refill within months, and the household now has both the loan and the new card debt."
      },
      {
        "id": "q13",
        "prompt": "Why does a credit card 'grace period' disappear once a balance is carried?",
        "options": [
          "Because the issuer is being punitive.",
          "Because interest is charged daily on the outstanding balance, and once any balance is carried, new purchases also accrue interest immediately until everything is paid in full.",
          "Because federal law removes it.",
          "Because the credit bureau changes the reporting status."
        ],
        "correct": 1,
        "explanation": "Grace period only applies when the previous balance was paid in full. Once any balance is carried, new purchases accrue interest from the transaction date — no grace. Many clients don't realize this and assume only the carried balance is being charged. Worth explaining clearly when reviewing credit card statements."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 3;

-- ============================================================================
-- DONE. Module remains 'draft' until Cathy Jackson-Gent approves via admin UI.
-- ============================================================================

-- ── module4_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 4 CONTENT
-- Risk Management & Insurance
-- ============================================================================

update public.modules set
  title = 'Risk Management & Insurance',
  competency_id = 'CORE-4',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How a household identifies the risks that can destroy a plan, and how insurance transfers those risks at the right price and structure.',
  learning_objectives = ARRAY[
    'Articulate the four risk-handling strategies and when each applies.',
    'Right-size life, disability, health, and property-casualty coverage for a typical household.',
    'Distinguish term and permanent life insurance and explain when each fits.',
    'Read a policy declarations page and identify the levers — limits, deductibles, exclusions, riders.',
    'Identify catastrophic exposures that require umbrella coverage.',
    'Explain the role of insurance inside a financial plan to a client without selling product.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Risk and How to Handle It",
      "summary": "The four strategies every plan uses, and when each one fits.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A financial plan is fragile if any single bad event — a death, a disability, a fire, a lawsuit — can break it. Risk management is how the plan is built to survive the events you can't predict and can't prevent." },
        { "type": "paragraph", "text": "There are four ways to handle a risk, and every recommendation an advisor makes is one of them. Naming them explicitly is the first move." },

        { "type": "callout", "kind": "key", "title": "The four strategies", "text": "<strong>Avoid</strong> · <strong>Reduce</strong> · <strong>Retain</strong> · <strong>Transfer</strong>" },

        { "type": "subheading", "text": "Avoid" },
        { "type": "paragraph", "text": "Don't engage in the activity that creates the risk. Don't own the boat, don't keep the dog known to bite, don't take the second mortgage to invest in a single stock. Avoidance is often the cheapest strategy, when it's available." },

        { "type": "subheading", "text": "Reduce" },
        { "type": "paragraph", "text": "Engage in the activity but lower the probability or severity. Install smoke detectors. Lock the gun safe. Wear a seatbelt. Get the roof replaced before it leaks. Reduction is where loss-control measures live and where many premium discounts come from." },

        { "type": "subheading", "text": "Retain" },
        { "type": "paragraph", "text": "Accept the risk and pay any losses out of pocket. Appropriate for risks that are <strong>frequent but small</strong> — a $200 fender-bender, a $50 broken phone. Retention is essentially self-insurance. Higher deductibles formalize a decision to retain more risk in exchange for lower premiums." },

        { "type": "subheading", "text": "Transfer" },
        { "type": "paragraph", "text": "Pay someone else to bear the risk — typically an insurance company. Appropriate for risks that are <strong>low-frequency but high-severity</strong> — a house fire, a major surgery, a wrongful-death lawsuit, premature death of the breadwinner. Transfer is what people usually mean when they say \"insurance.\"" },

        { "type": "callout", "kind": "key", "title": "The grid that organizes everything", "text": "<strong>High severity + low frequency</strong> → transfer (insurance).<br/><strong>Low severity + high frequency</strong> → retain (self-insure with cash and high deductibles).<br/><strong>High severity + high frequency</strong> → avoid (the activity is too dangerous to manage).<br/><strong>Low severity + low frequency</strong> → retain (ignore; not worth managing)." },

        { "type": "divider" },

        { "type": "heading", "text": "What insurance actually is" },
        { "type": "paragraph", "text": "Insurance is the pooled-risk arrangement that lets a household pay a small, certain amount (premium) to avoid the possibility of a large, uncertain loss. It is not an investment. It is not a savings vehicle. It is a risk-transfer mechanism, priced by the insurer to be profitable on average across many policyholders." },
        { "type": "callout", "kind": "warn", "title": "What insurance is not", "text": "Insurance is not free money. Every dollar of premium is a dollar the client does not have. Buying coverage for risks they could comfortably absorb out of pocket means paying the insurer's overhead and profit margin on something they could self-handle. The advisor's job is to direct insurance dollars at the risks that <em>actually</em> require transfer — and stop them being spent on the rest." },

        { "type": "heading", "text": "The first risk-management questions to ask a client" },
        { "type": "list", "items": [
          "Who depends financially on this client, and for how long?",
          "If the client could not work tomorrow, how long could the household sustain itself?",
          "What assets — house, car, retirement savings — would be exposed in a major lawsuit?",
          "What policies are currently in force, and is anyone tracking renewals and coverage adequacy?",
          "Has there been a significant life event (marriage, birth, divorce, business start) since the policies were last reviewed?"
        ]},
        { "type": "callout", "kind": "do", "title": "The annual review reflex", "text": "Coverage that fit a household five years ago may not fit it now. New child, paid-off mortgage, business sold, kid moved out — each one shifts the insurance picture. Build an annual coverage review into the engagement cadence and you'll catch the gaps before they become disasters." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Life Insurance",
      "summary": "Term, permanent, and the question that decides which fits.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Life insurance pays a death benefit to the beneficiaries when the insured dies. It exists for one structural reason: there are people who depend financially on the insured, and they would be in trouble if the income disappeared." },

        { "type": "callout", "kind": "key", "title": "The question that decides everything", "text": "<strong>If this client died tonight, who would be financially worse off?</strong> If the answer is no one — single, no dependents, savings adequate to cover final expenses — they likely don't need life insurance. If the answer is a spouse, children, business partner, or anyone counting on the income, that's the dependency the policy exists to address." },

        { "type": "heading", "text": "Term life insurance" },
        { "type": "paragraph", "text": "Pays a death benefit if the insured dies during a specified term — commonly 10, 20, or 30 years. Premiums are level for the duration; at the end of the term, coverage ends (or renews at much higher rates)." },
        { "type": "list", "items": [
          "<strong>Low premium relative to death benefit.</strong> A healthy 35-year-old can often buy $1 million of 20-year term for under $50/month.",
          "<strong>Pure risk transfer.</strong> No cash value, no investment component. Premium pays for insurance and nothing else.",
          "<strong>Designed to cover a finite need.</strong> Most clients need insurance during working years to protect dependents; once kids are grown and assets are built, the need disappears.",
          "<strong>The default recommendation for most households.</strong> Term covers the actual risk at the lowest cost."
        ]},

        { "type": "heading", "text": "Permanent life insurance" },
        { "type": "paragraph", "text": "Coverage that lasts a lifetime, combined with a savings/investment component. Several flavors:" },
        { "type": "glossary", "terms": [
          { "term": "Whole life", "definition": "Fixed premium, fixed death benefit, cash value grows at a guaranteed rate. The most traditional permanent product." },
          { "term": "Universal life (UL)", "definition": "Flexible premiums, flexible death benefit, cash value grows at a declared rate. More customizable, more complex." },
          { "term": "Variable universal life (VUL)", "definition": "Like UL but cash value is invested in market subaccounts. Returns are not guaranteed; account can lose value." },
          { "term": "Indexed universal life (IUL)", "definition": "Cash value linked to an equity index with floors and caps. Marketed as offering upside without downside; in practice, caps and fees often limit upside meaningfully." }
        ]},
        { "type": "callout", "kind": "warn", "title": "Where permanent insurance gets oversold", "text": "Permanent life is frequently sold to clients who would be better served by term plus a separate investment. The combined product is often more expensive than the sum of the parts, returns on the cash value are typically modest, and the structure is opaque. \"Buy term and invest the difference\" is a defensible default. Permanent has legitimate uses — estate liquidity for large estates, business succession funding, certain wealth-transfer strategies — but for a typical household, it's the wrong tool." },

        { "type": "heading", "text": "Sizing the death benefit" },
        { "type": "paragraph", "text": "How much coverage is enough? Two methods are common:" },

        { "type": "subheading", "text": "Method 1 — Income replacement" },
        { "type": "paragraph", "text": "Multiply gross annual income by 10–15. A client earning $100,000 might carry $1,000,000–$1,500,000 of coverage. Simple, conservative, easy to explain. Good starting point for most." },

        { "type": "subheading", "text": "Method 2 — Needs analysis (DIME or capital needs)" },
        { "type": "paragraph", "text": "Build coverage from specific obligations:" },
        { "type": "list", "items": [
          "<strong>D</strong>ebts — pay off mortgage, auto loans, credit cards.",
          "<strong>I</strong>ncome — replace the insured's income for the years dependents need it.",
          "<strong>M</strong>ortgage — sometimes called out separately for clarity.",
          "<strong>E</strong>ducation — anticipated college costs for children.",
          "Plus a final-expense reserve and a buffer for inflation."
        ]},
        { "type": "paragraph", "text": "Needs analysis is more precise but more work. For most households, either method produces an answer in the same ballpark. Use the one that produces a number the client will actually agree to and act on." },

        { "type": "case_study",
          "title": "Sizing for Marcus and Tasha",
          "scenario": "Marcus and Tasha (couple from earlier modules), early 40s, two kids ages 10 and 13. Combined gross income $148,000, mortgage $310,000, savings $80,000, retirement $250,000. Currently no individual life insurance beyond modest group policies through employers.",
          "discussion": "<p>Both spouses contribute income, so both need coverage. Sizing each:</p><ul><li>Mortgage payoff: $310,000</li><li>Income replacement (10× each): $740,000 Marcus, $740,000 Tasha (assume equal earnings for simplicity)</li><li>College for two kids: ~$300,000 in today's dollars at private rates, less for state schools</li><li>Final expenses + buffer: $50,000</li></ul><p><strong>Recommendation:</strong> $1,500,000 of 20-year term on each. Twenty years covers the period when kids are dependents and mortgage is paid down. Combined premium for two healthy 40-year-olds: roughly $100–$150/month total. The cost is small; the protection is enormous. Note the group policies stay — they're cheap supplemental coverage — but they're not a substitute for individual policies because they end when employment ends.</p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Disability and Health Insurance",
      "summary": "The two coverages most clients underestimate, despite both being more likely to pay out than life insurance.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A healthy 35-year-old is much more likely to experience a disabling injury or illness during their working life than to die before age 65. And medical events are the leading cause of personal bankruptcy in the United States. Both disability and health coverage are non-negotiable for almost every household." },

        { "type": "heading", "text": "Disability insurance" },
        { "type": "paragraph", "text": "Replaces a portion of income when the insured cannot work due to injury or illness. Two main categories:" },
        { "type": "list", "items": [
          "<strong>Short-term disability (STD)</strong> — covers 3–6 months. Often employer-provided.",
          "<strong>Long-term disability (LTD)</strong> — covers from end of STD until retirement age or recovery. The structurally important coverage."
        ]},

        { "type": "subheading", "text": "The variables that matter" },
        { "type": "glossary", "terms": [
          { "term": "Benefit amount", "definition": "Typically 60–70% of pre-disability income. Tax treatment depends on who paid the premium — employer-paid benefits are usually taxable; individual-paid benefits are usually not." },
          { "term": "Elimination period", "definition": "The waiting period before benefits start. Common: 60, 90, 180 days. Longer waits mean lower premiums but require a larger emergency fund to bridge." },
          { "term": "Benefit period", "definition": "How long benefits pay. \"To age 65\" or \"to age 67\" is the standard for serious LTD." },
          { "term": "Definition of disability", "definition": "How the policy defines unable to work. Two main types — <strong>own occupation</strong> (can't perform the duties of your specific job) vs. <strong>any occupation</strong> (can't perform any job for which you're qualified). Own-occ is more generous and more expensive; critical for high-skill professionals." }
        ]},

        { "type": "callout", "kind": "key", "title": "What good LTD looks like", "text": "60–70% benefit, 90-day elimination period, to-age-65 benefit period, own-occupation definition at least for the first 2–5 years. For high earners or specialty professionals (physicians, lawyers, surgeons), <em>true own-occupation to age 65</em> is the standard worth paying for." },

        { "type": "callout", "kind": "warn", "title": "Group LTD is not enough on its own", "text": "Many clients have group LTD through work — usually 60% of base salary, often capped (e.g., max $10,000/month), benefits taxable, ends if employment ends, definition often shifts to \"any occupation\" after 2 years. For a client whose income is below the cap and whose career is portable, group might be sufficient. For a high earner, a specialty professional, or anyone whose income is largely bonus/commission, supplemental individual coverage usually fills a real gap." },

        { "type": "divider" },

        { "type": "heading", "text": "Health insurance" },
        { "type": "paragraph", "text": "Pays a portion of medical costs in exchange for premium. The category most clients deal with monthly. The advisor's role isn't to pick plans — most clients buy through employer or marketplace — but to make sure the client is using the coverage well and protected against worst cases." },

        { "type": "subheading", "text": "Reading a plan" },
        { "type": "glossary", "terms": [
          { "term": "Premium", "definition": "Monthly cost to maintain the plan." },
          { "term": "Deductible", "definition": "Out-of-pocket spending required before insurance starts paying (other than for covered preventive care)." },
          { "term": "Copay", "definition": "Fixed dollar amount paid per visit or prescription, regardless of total cost." },
          { "term": "Coinsurance", "definition": "Percentage of cost shared between insurer and patient after the deductible (e.g., 80/20 — insurer pays 80%, patient pays 20%)." },
          { "term": "Out-of-pocket maximum", "definition": "The annual cap on patient spending. Once hit, insurance pays 100% of covered costs for the rest of the year. <strong>The most important number on the policy.</strong>" },
          { "term": "Network", "definition": "Providers who have negotiated rates with the insurer. Out-of-network care often costs dramatically more, sometimes with no coverage at all." }
        ]},

        { "type": "callout", "kind": "do", "title": "The high-deductible + HSA combination", "text": "For a healthy household with cash flow flexibility, a high-deductible health plan (HDHP) paired with a Health Savings Account (HSA) can be the most tax-efficient health coverage available. HSAs offer triple tax advantage — contributions are deductible, growth is tax-free, withdrawals for medical are tax-free. After age 65, HSA can be used for any purpose with only income tax owed. It is, structurally, one of the best retirement accounts that exists. Cover this in detail with anyone enrolled in an HDHP and not maximizing the HSA." },

        { "type": "callout", "kind": "warn", "title": "When the HDHP is wrong", "text": "Clients with predictable high medical use (chronic conditions, planned pregnancy, medications) often pay more in the HDHP despite the lower premium. Always run the math against the client's expected utilization, not just the headline premium difference." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Property, Casualty, and Liability",
      "summary": "Protecting the assets the client has built — and the lawsuits that can take them away.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Once a household has assets — a house, savings, retirement accounts — those assets become exposures. A car accident, a guest injured at the home, a teenage driver in a fender-bender that escalates: any of these can produce a lawsuit large enough to threaten years of wealth-building. Property, casualty, and liability coverage exist to absorb that exposure." },

        { "type": "heading", "text": "Homeowners insurance (HO-3 standard)" },
        { "type": "paragraph", "text": "Standard policy structure for an owner-occupied single-family home:" },
        { "type": "list", "items": [
          "<strong>Coverage A — Dwelling</strong>: rebuilding the structure. Should be set at <em>replacement cost</em>, not market value. (A $700,000 market-value home may cost $500,000 to rebuild — or vice versa.) Many policies require coverage at 80% of replacement cost or better to avoid penalty at claim time.",
          "<strong>Coverage B — Other structures</strong>: detached garages, sheds, fences. Typically 10% of A.",
          "<strong>Coverage C — Personal property</strong>: contents inside the home. Typically 50–75% of A. Coverage is usually actual cash value (depreciated) unless replacement-cost endorsement is purchased.",
          "<strong>Coverage D — Loss of use</strong>: hotel and meal costs while the home is uninhabitable. Typically 20% of A.",
          "<strong>Coverage E — Personal liability</strong>: legal defense and judgment for incidents at the property. Often only $100K–$300K by default — usually inadequate.",
          "<strong>Coverage F — Medical payments to others</strong>: small no-fault coverage for guest injuries, typically $1K–$5K."
        ]},
        { "type": "callout", "kind": "warn", "title": "What standard policies don't cover", "text": "Floods, earthquakes, sewer backups (usually), mold (often limited), business activity in the home. These require either riders or separate policies. Flood insurance in particular: standard homeowners <strong>excludes flood</strong>, and FEMA flood maps determine eligibility for the National Flood Insurance Program. Check this on every new client review." },

        { "type": "heading", "text": "Auto insurance" },
        { "type": "paragraph", "text": "Required by law in most states. Standard parts:" },
        { "type": "list", "items": [
          "<strong>Bodily injury liability</strong>: pays for injuries to others when the insured is at fault. State minimums are usually inadequate. A common recommendation is 250/500 ($250K per person, $500K per accident) or higher.",
          "<strong>Property damage liability</strong>: pays for damage to others' property. $100K minimum is reasonable.",
          "<strong>Collision</strong>: pays for damage to the insured's vehicle in an accident. Optional but standard if the vehicle is financed.",
          "<strong>Comprehensive</strong>: pays for non-collision damage (theft, vandalism, falling objects, animal strikes). Optional but standard if the vehicle is financed.",
          "<strong>Uninsured/underinsured motorist (UM/UIM)</strong>: pays when the at-fault driver has insufficient or no insurance. <strong>Critical and frequently underbought.</strong> Match it to liability limits.",
          "<strong>Personal injury protection (PIP) / medical payments</strong>: no-fault medical coverage. Required in some states, optional in others."
        ]},

        { "type": "heading", "text": "Umbrella liability" },
        { "type": "paragraph", "text": "Sits on top of homeowners and auto liability, extending coverage by $1 million or more. Triggers when the underlying policy's liability limit is exhausted. Astonishingly cheap relative to the protection — often $200–$500/year for $1 million of additional coverage." },
        { "type": "callout", "kind": "key", "title": "Who should have umbrella", "text": "Any household with assets meaningfully above the underlying liability limits. As a rough rule, if the client has more than $300K of net worth, umbrella is a conversation. If they have more than $1M, it's a recommendation. If they have rental properties, pools, teen drivers, dogs, or any high-visibility profession, the threshold drops further. The cost is small; the protection is structural." },

        { "type": "case_study",
          "title": "The fender-bender that wasn't",
          "scenario": "A teen driver rear-ends another vehicle at 30 mph. The other driver has soft-tissue neck injuries that turn into a chronic condition with surgery. Medical costs plus lost wages plus pain-and-suffering judgment: $1.2 million. The family had auto liability of $250K and no umbrella.",
          "discussion": "<p>The auto policy pays its $250K. The remaining $950,000 is the family's exposure — coming first from any non-retirement savings, then potentially from wage garnishment for years. Retirement accounts and the primary home are usually protected by state law from creditors, but not always, and the protection varies by state.</p><p>For about $300/year, that family could have had a $1M umbrella that covered the entire judgment. The umbrella conversation isn't about fear-mongering; it's about explaining that a routine accident can produce a non-routine outcome, and the cost of the protection is small. Every client review should include the question: <em>is umbrella coverage in place, and is it the right size?</em></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Reading a Policy and the Annual Review",
      "summary": "The five things to look at on every declarations page, and how to spot what's missing.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Insurance products are dense, full of exclusions, and easy to misread. A Wealth Solutions Counselor doesn't need to sell insurance, but does need to read policies competently enough to spot gaps, mismatches, and oversold coverage. The skill is mechanical and learnable." },

        { "type": "heading", "text": "The declarations page" },
        { "type": "paragraph", "text": "The first page of every policy summarizes the contract. Always start here. Look for:" },
        { "type": "numbered", "items": [
          "<strong>Named insured(s).</strong> Does the policy cover the right people? Spouse listed? Adult children at college covered?",
          "<strong>Policy period.</strong> Is the policy current? When does it renew?",
          "<strong>Coverage limits.</strong> Each one. Match against the asset or exposure it's meant to protect.",
          "<strong>Deductibles.</strong> Per-occurrence, per-event, separate wind/hail or named-storm deductibles in coastal areas.",
          "<strong>Premium.</strong> Annual total, and what's being paid for which coverage."
        ]},

        { "type": "heading", "text": "Beyond the declarations page" },
        { "type": "list", "items": [
          "<strong>Endorsements and riders.</strong> Listed separately. Often where the most important customizations live — jewelry floaters, business activity riders, water/sewer backup riders, scheduled property.",
          "<strong>Exclusions.</strong> What the policy does NOT cover. The most-cited at claim time are flood, earthquake, intentional acts, business pursuits, motor vehicles, and certain dog breeds.",
          "<strong>Replacement cost vs. actual cash value.</strong> ACV depreciates; RC pays to replace. The same loss can produce wildly different settlements depending on which applies."
        ]},

        { "type": "callout", "kind": "do", "title": "The five-minute spot-check", "text": "On any homeowners policy: <strong>(1)</strong> Is dwelling coverage at replacement cost? <strong>(2)</strong> Is personal liability at least $300K? <strong>(3)</strong> Are flood and earthquake addressed (covered or consciously declined)? <strong>(4)</strong> Are any unusual exposures listed and covered (pool, trampoline, business in home)? <strong>(5)</strong> Is replacement cost on contents elected? These five questions catch most coverage gaps in five minutes." },

        { "type": "divider" },

        { "type": "heading", "text": "The annual insurance review" },
        { "type": "paragraph", "text": "Schedule once a year, ideally during the policy-renewal season for each major coverage. Walk through:" },
        { "type": "list", "items": [
          "Did anything change in the client's life this year? (New job, new home, new car, new child, marriage, divorce, business start.)",
          "Are premiums in line with peer benchmarks?",
          "Are deductibles set appropriately for the client's emergency fund? (Higher deductible = lower premium, but the client needs the cash to absorb it.)",
          "Are limits keeping pace with replacement costs and inflation? (Especially dwelling coverage — construction costs have risen significantly in recent years.)",
          "Are bundled discounts captured? (Same-carrier auto + home is often cheaper than two carriers.)"
        ]},

        { "type": "callout", "kind": "key", "title": "The independent agent vs. captive question", "text": "Captive agents (State Farm, Allstate, Farmers) sell one carrier. Independent agents work across many. For most clients, an independent agent who shops the market every few years produces materially better outcomes — both on price and on coverage breadth. This is one of the most concrete, immediately useful recommendations an advisor can make to a household that's been with the same carrier for two decades." },

        { "type": "activity", "title": "Audit your own coverage", "prompt": "Same instruction as previous modules: do this for yourself before you do it for a client.", "steps": [
          "Pull declarations pages for every active policy: auto, home/renters, umbrella (if any), life, disability, health.",
          "For each, run the five-minute spot-check from this lesson.",
          "Identify gaps and overlaps. Where might you be under-insured? Where might you be paying for coverage you don't actually need?",
          "Note premium dollars per category — which coverage is consuming the most of your insurance budget?",
          "Save the document. Repeat annually. The discipline that makes you a good advisor on this is the same discipline you'll teach clients."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which of the following risks should typically be TRANSFERRED via insurance rather than retained?",
        "options": [
          "A $300 cracked phone screen",
          "A $100,000 medical event",
          "A $50 parking ticket",
          "Routine vehicle maintenance costs"
        ],
        "correct": 1,
        "explanation": "Insurance is for low-frequency, high-severity risks. A major medical event qualifies. The phone, ticket, and maintenance are low-severity and should be retained (paid out of cash flow or emergency fund)."
      },
      {
        "id": "q2",
        "prompt": "A healthy 35-year-old client with a spouse and two young children, earning $90,000/year with a $250,000 mortgage, has no individual life insurance. What is the most defensible recommendation?",
        "options": [
          "Permanent (whole life) policy, $500K death benefit.",
          "Term policy, 20-year, $750K–$1M death benefit.",
          "No insurance — life insurance is overrated.",
          "Variable universal life, $1M death benefit."
        ],
        "correct": 1,
        "explanation": "Term insurance for the working/dependent years is the default for most households. Income replacement of 10–15× plus mortgage payoff suggests roughly $750K–$1.5M. A 20-year term covers until kids are independent and mortgage is significantly paid down. Premium is small."
      },
      {
        "id": "q3",
        "prompt": "What does 'own occupation' mean in a disability insurance policy?",
        "options": [
          "The insured can choose any occupation after disability.",
          "Disability is defined as inability to perform the duties of the insured's specific occupation, even if the insured could work in a different field.",
          "The policy only pays if the disability happened on the job.",
          "Premiums are tax-deductible because of self-employment."
        ],
        "correct": 1,
        "explanation": "Own-occupation is the more generous definition: a surgeon who can no longer operate but could teach is still disabled under own-occ. Any-occupation requires inability to do any job for which the insured is qualified. Own-occ is critical for high-skill professionals."
      },
      {
        "id": "q4",
        "prompt": "Which of the following is the most important number on a health insurance policy?",
        "options": [
          "Premium",
          "Deductible",
          "Out-of-pocket maximum",
          "Copay"
        ],
        "correct": 2,
        "explanation": "The out-of-pocket maximum is the cap on what the client can spend in a year. Once hit, insurance pays 100%. It's the number that defines worst-case exposure — more important than the premium, deductible, or copay in isolation."
      },
      {
        "id": "q5",
        "prompt": "Which of the following is NOT typically covered by a standard homeowners (HO-3) policy?",
        "options": [
          "Fire damage to the dwelling",
          "Theft of personal property",
          "Flood damage from a storm surge",
          "A guest's medical bills after slipping on the deck"
        ],
        "correct": 2,
        "explanation": "Flood is excluded from standard homeowners policies and requires either NFIP coverage or a private flood policy. Always confirm flood exposure and whether the client is covered."
      },
      {
        "id": "q6",
        "prompt": "A household has $500K of net worth, including a home worth $400K and savings of $100K. Auto liability limits are $100K/$300K. They have no umbrella policy. What is the structurally important exposure?",
        "options": [
          "Their auto insurance deductible is too low.",
          "Their savings yield is too low.",
          "Their auto liability limit is well below their net worth, and a serious accident could expose savings (and potentially the home) to a judgment beyond policy limits.",
          "Their home is uninsured."
        ],
        "correct": 2,
        "explanation": "Auto liability of $100K/$300K is well below their $500K net worth. A serious accident judgment could exhaust the liability limit and reach their other assets. An umbrella policy (typically $200–$500/year for $1M of coverage) closes this gap structurally and inexpensively."
      },
      {
        "id": "q7",
        "prompt": "What is the triple tax advantage of a Health Savings Account (HSA)?",
        "options": [
          "Tax-deductible contributions, tax-deferred growth, taxable withdrawals.",
          "Tax-deductible contributions, tax-free growth, tax-free withdrawals for qualified medical expenses.",
          "Tax-free contributions, taxable growth, tax-free withdrawals.",
          "All three taxes are deferred until age 59½."
        ],
        "correct": 1,
        "explanation": "HSA contributions are pre-tax (deductible), growth is tax-free, and withdrawals for qualified medical expenses are tax-free. After age 65, withdrawals for any purpose owe only income tax. It is structurally one of the best tax-advantaged accounts available."
      },
      {
        "id": "q8",
        "prompt": "Which of the following is the strongest reason to prefer term insurance over permanent insurance for a typical household?",
        "options": [
          "Term has guaranteed cash value.",
          "Term provides much lower premium for the same death benefit during the years the protection is actually needed; the insurance need typically disappears as wealth is built and dependents become independent.",
          "Permanent insurance is illegal in some states.",
          "Term builds wealth faster."
        ],
        "correct": 1,
        "explanation": "Term provides pure death-benefit protection at low cost during the working/dependent years. The insurance need typically disappears as the client builds assets and dependents grow up. Permanent insurance bundles in a savings component that is generally inferior to investing separately."
      },
      {
        "id": "q9",
        "prompt": "Which of the four risk-handling strategies applies to driving with a seatbelt and installing smoke detectors?",
        "options": [
          "Avoid",
          "Reduce",
          "Retain",
          "Transfer"
        ],
        "correct": 1,
        "explanation": "Reduction — engaging in the activity but lowering the probability or severity of loss. Loss-control measures live here and are often where insurance premium discounts come from."
      },
      {
        "id": "q10",
        "prompt": "A client says they have 'group long-term disability through work, so I'm covered.' What's the right follow-up?",
        "options": [
          "Confirm and move on.",
          "Ask about the benefit percentage, the income cap, whether the benefit is taxable, the definition of disability, and whether coverage portable if employment ends. Group LTD is often inadequate without supplement.",
          "Tell them to drop the group coverage to save money.",
          "Recommend they switch jobs to one with better LTD."
        ],
        "correct": 1,
        "explanation": "Group LTD frequently has caps that under-cover high earners, is often taxable (paid with pre-tax premiums), shifts definition to 'any occupation' after 2 years, and ends if employment ends. Confirming details — and supplementing with individual coverage when group is inadequate — is the advisor move."
      },
      {
        "id": "q11",
        "prompt": "When reviewing a homeowners policy, the dwelling coverage should be:",
        "options": [
          "Equal to the home's market value.",
          "Equal to the home's purchase price.",
          "Equal to the cost to rebuild the structure (replacement cost), which can differ significantly from market value.",
          "Equal to the outstanding mortgage balance."
        ],
        "correct": 2,
        "explanation": "Dwelling coverage protects against rebuild cost, not market value. Market value includes land (which usually survives most losses) and reflects supply/demand. Replacement cost reflects construction labor and materials. The two can differ by a lot — always verify."
      },
      {
        "id": "q12",
        "prompt": "Which is the best general description of when insurance is the wrong tool?",
        "options": [
          "When the client is young.",
          "When the risk is frequent and small enough that the household can absorb it from cash flow or emergency fund.",
          "When the client has not had a claim in the last five years.",
          "When the premium has not increased recently."
        ],
        "correct": 1,
        "explanation": "Insurance is for low-frequency, high-severity events that would meaningfully harm the household. Small, frequent losses should be retained — typically expressed as higher deductibles and absence of certain optional coverages. Buying insurance for risks the household could handle out of pocket means paying the insurer's overhead unnecessarily."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 4;

-- ============================================================================
-- DONE.
-- ============================================================================

-- ── module5_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 5 CONTENT
-- Tax Fundamentals
-- ============================================================================

update public.modules set
  title = 'Tax Fundamentals',
  competency_id = 'CORE-5',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How the U.S. tax system actually works, the levers an advisor can pull, and the lines that require referring out to a CPA.',
  learning_objectives = ARRAY[
    'Distinguish marginal from effective tax rates and explain both clearly to a client.',
    'Identify the seven federal income tax brackets and how they apply to ordinary income.',
    'Distinguish ordinary income, long-term capital gains, and qualified dividend tax treatment.',
    'Explain the difference between Traditional and Roth tax-advantaged accounts and when each fits.',
    'Apply standard vs. itemized deduction logic and identify common itemizable deductions.',
    'Recognize when a tax situation requires referral to a CPA or tax attorney.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "How the U.S. Income Tax Actually Works",
      "summary": "Marginal vs. effective rates, brackets, and the structural picture every counselor must hold.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax is the single largest line item over most working-class households' lifetimes, and one of the most misunderstood. A Wealth Solutions Counselor isn't a CPA — and shouldn't pretend to be — but does need to hold a clear structural picture of how income tax works to give competent advice on saving, investing, and retirement decisions." },

        { "type": "heading", "text": "The U.S. uses a progressive bracket system" },
        { "type": "paragraph", "text": "Federal income tax is calculated in <strong>brackets</strong>. Each layer of income is taxed at a different rate. The marginal rate is the rate on the <em>next dollar earned</em>. The effective rate is the <em>average</em> rate paid across all income." },
        { "type": "callout", "kind": "key", "title": "The most common misunderstanding", "text": "Clients frequently believe that crossing a tax bracket means all of their income is taxed at the higher rate. <strong>This is wrong.</strong> Only the income in that bracket is taxed at that rate. A single filer earning $100,000 doesn't \"jump to 24%\" on everything — only the dollars above the 24% bracket threshold are taxed at 24%." },

        { "type": "subheading", "text": "2025 federal brackets (single filer, ordinary income)" },
        { "type": "paragraph", "text": "Approximate brackets — refer to the IRS official tables for exact figures, which are inflation-adjusted yearly:" },
        { "type": "list", "items": [
          "10% — up to ~$11,925",
          "12% — ~$11,925 to ~$48,475",
          "22% — ~$48,475 to ~$103,350",
          "24% — ~$103,350 to ~$197,300",
          "32% — ~$197,300 to ~$250,525",
          "35% — ~$250,525 to ~$626,350",
          "37% — above ~$626,350"
        ]},
        { "type": "callout", "kind": "note", "title": "Married filing jointly brackets are different", "text": "Generally roughly double the single-filer thresholds (though not exactly, due to historical \"marriage penalty\" considerations). Head of household brackets sit between single and MFJ. Always verify filing status before quoting rates." },

        { "type": "heading", "text": "The marginal rate calculation" },
        { "type": "paragraph", "text": "A single filer with $75,000 taxable income:" },
        { "type": "list", "items": [
          "First ~$11,925 taxed at 10% = ~$1,193",
          "Next ~$36,550 (from $11,925 to $48,475) taxed at 12% = ~$4,386",
          "Next ~$26,525 (from $48,475 to $75,000) taxed at 22% = ~$5,836",
          "<strong>Total federal tax: ~$11,415</strong>",
          "<strong>Marginal rate (rate on next dollar): 22%</strong>",
          "<strong>Effective rate ($11,415 / $75,000): ~15.2%</strong>"
        ]},

        { "type": "callout", "kind": "key", "title": "When to use which", "text": "Use the <strong>marginal rate</strong> when evaluating decisions about additional income or deductions (\"how much will I save by contributing $10,000 to a traditional 401(k)?\"). Use the <strong>effective rate</strong> when describing overall tax burden (\"how much of my income goes to federal tax?\")." },

        { "type": "divider" },

        { "type": "heading", "text": "Other federal taxes to know" },
        { "type": "list", "items": [
          "<strong>FICA</strong> — Social Security (6.2% on wages up to ~$168,600 in 2025) + Medicare (1.45% on all wages). Self-employed pay both halves (15.3% total) but deduct half on Schedule SE.",
          "<strong>Additional Medicare tax</strong> — 0.9% on wages over $200,000 single / $250,000 MFJ.",
          "<strong>Net investment income tax (NIIT)</strong> — 3.8% on investment income for high earners (over $200K single / $250K MFJ AGI).",
          "<strong>Capital gains tax</strong> — separate rate schedule for long-term gains and qualified dividends (covered in next lesson)."
        ]},

        { "type": "heading", "text": "State and local" },
        { "type": "paragraph", "text": "Vary enormously. Nine states have no income tax (including Texas, Florida, Washington, Nevada). High-tax states like California can add 13.3% at the top bracket. Some states (like California) also tax capital gains as ordinary income. Always know the state context before quoting an effective rate." },

        { "type": "callout", "kind": "do", "title": "The fluency reflex", "text": "When a client mentions a financial decision, your reflex should include: <em>what's their marginal rate?</em> A traditional 401(k) contribution saves the marginal rate now and is taxed at the future marginal rate at withdrawal. A Roth contribution saves nothing now and is tax-free later. Whether to choose Traditional or Roth depends entirely on the comparison between current and future marginal rates." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Capital Gains, Dividends, and Investment Income",
      "summary": "How investment income is taxed differently — and why that matters for every plan.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Not all income is taxed the same. Investment income gets preferential treatment in several ways, and understanding those preferences is half the job of an advisor working with anyone who has taxable investments." },

        { "type": "heading", "text": "Capital gains: short-term vs. long-term" },
        { "type": "list", "items": [
          "<strong>Short-term capital gain</strong> — sale of an asset held for one year or less. Taxed as <em>ordinary income</em>, at the client's marginal rate.",
          "<strong>Long-term capital gain</strong> — sale of an asset held more than one year. Taxed at preferential rates: 0%, 15%, or 20% federal, depending on total taxable income."
        ]},
        { "type": "callout", "kind": "key", "title": "The 0% long-term bracket", "text": "Long-term capital gains are taxed at <strong>0%</strong> federally when total taxable income (including the gain) is below approximately $48,350 single or $96,700 MFJ in 2025. This is an enormous planning opportunity for clients in lower-income years — early retirement before Social Security, between jobs, during a sabbatical. Selling appreciated assets in a 0% bracket year is materially different from selling in a high-income year." },

        { "type": "heading", "text": "Long-term capital gains brackets (2025 approximate)" },
        { "type": "list", "items": [
          "<strong>0%</strong> — taxable income up to ~$48,350 single / ~$96,700 MFJ",
          "<strong>15%</strong> — taxable income up to ~$533,400 single / ~$600,050 MFJ",
          "<strong>20%</strong> — above those thresholds"
        ]},
        { "type": "paragraph", "text": "Plus the 3.8% Net Investment Income Tax for clients with AGI over $200K single / $250K MFJ, which stacks on top. So the practical top federal rate on long-term gains can be 23.8%." },

        { "type": "heading", "text": "Dividends: qualified vs. ordinary" },
        { "type": "list", "items": [
          "<strong>Qualified dividends</strong> — paid by U.S. corporations and certain foreign corporations on stock held more than 60 days. Taxed at long-term capital gains rates (0/15/20%).",
          "<strong>Ordinary (non-qualified) dividends</strong> — most REIT distributions, money market fund dividends, dividends on stock held under 60 days. Taxed as ordinary income at the marginal rate."
        ]},
        { "type": "callout", "kind": "note", "title": "Why REITs go in tax-advantaged accounts", "text": "REIT distributions are mostly ordinary dividends, taxed at ordinary rates — often the client's highest rate. For taxable accounts this is inefficient. The standard recommendation is to hold REITs inside an IRA or 401(k), where the distributions are sheltered. This is one of the most common asset-location moves an advisor will make." },

        { "type": "heading", "text": "Interest income" },
        { "type": "paragraph", "text": "Most interest — bank interest, CD interest, corporate bond interest — is ordinary income, taxed at the marginal rate. A few categories get preferential treatment:" },
        { "type": "list", "items": [
          "<strong>Treasury interest</strong> — federally taxable, but exempt from state and local tax. Material in high-tax states.",
          "<strong>Municipal bond interest</strong> — federally tax-exempt; often also state-exempt if issued by the client's home state.",
          "<strong>I-bond and EE-bond interest</strong> — federally taxable when redeemed (or accrued), state-exempt."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Tax-loss harvesting (introduction)" },
        { "type": "paragraph", "text": "When an investment is sold at a loss, the loss can offset capital gains and up to $3,000/year of ordinary income. Unused losses carry forward indefinitely. This creates a planning opportunity: selling losers strategically to capture tax savings while maintaining market exposure (via similar but not \"substantially identical\" replacements)." },
        { "type": "callout", "kind": "warn", "title": "The wash sale rule", "text": "If you sell at a loss and buy the same security (or a substantially identical one) within 30 days before or after, the loss is disallowed. Cost basis is adjusted. The IRS rule exists to prevent fake losses; advisors navigate it by buying a similar-but-not-identical replacement (e.g., sell VTI, buy ITOT) or by waiting 31+ days before buying back." },
        { "type": "callout", "kind": "note", "title": "Deeper treatment ahead", "text": "Module 24 covers tax-loss harvesting and tax-aware investing in depth. This module establishes the foundation; that module shows the execution." },

        { "type": "case_study",
          "title": "Why long-term matters",
          "scenario": "A client buys $50,000 of a stock at the start of the year and watches it rise to $70,000 in 11 months. They want to lock in the gain. Should they sell now, or hold one more month?",
          "discussion": "<p>Selling at 11 months: $20,000 short-term gain, taxed as ordinary income. If the client is in the 32% bracket, the federal tax is $6,400.</p><p>Selling at 12 months and 1 day: $20,000 long-term gain, taxed at 15%. Federal tax: $3,000. Possibly plus 3.8% NIIT if AGI is high enough.</p><p><strong>Difference: $3,400 in federal tax for one month of patience.</strong></p><p>The 30+ day patience is one of the highest-yield single-decision wins an advisor can flag. It doesn't apply when the market thesis genuinely demands selling now, and it doesn't apply when the gain is small enough that the bracket math doesn't matter. But for many clients in many situations, this conversation is pure value-add.</p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Tax-Advantaged Accounts and the Traditional vs. Roth Decision",
      "summary": "Where saving lives, and the trade-off every contribution decision boils down to.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax-advantaged accounts are the most powerful wealth-building tools available to ordinary households. They come in two main flavors — tax-deferred and tax-free — and choosing between them is a recurring decision throughout a working life." },

        { "type": "heading", "text": "The two flavors" },
        { "type": "glossary", "terms": [
          { "term": "Tax-deferred (Traditional)", "definition": "Contributions are deductible now. Growth is deferred. Withdrawals in retirement are taxed as ordinary income. Saves taxes today; pays taxes tomorrow. Includes Traditional 401(k), Traditional IRA, 403(b), 457(b)." },
          { "term": "Tax-free (Roth)", "definition": "Contributions are after-tax (no deduction now). Growth is tax-free. Qualified withdrawals in retirement are tax-free. Pays taxes today; saves taxes tomorrow. Includes Roth 401(k), Roth IRA, Roth 403(b)." }
        ]},

        { "type": "callout", "kind": "key", "title": "The simple framework", "text": "<strong>Higher marginal rate today than expected in retirement</strong> → favor Traditional (defer at the higher rate, pay at the lower rate).<br/><strong>Lower marginal rate today than expected in retirement</strong> → favor Roth (pay at the lower rate now, take it out tax-free at the higher rate).<br/><strong>Uncertain or roughly equal</strong> → diversify across both for tax flexibility in retirement." },

        { "type": "heading", "text": "Contribution limits (2025, approximate)" },
        { "type": "list", "items": [
          "<strong>401(k) / 403(b)</strong>: $23,500 employee contribution. Catch-up $7,500 if 50+. New 'super catch-up' of ~$11,250 for ages 60–63.",
          "<strong>IRA (Traditional or Roth)</strong>: $7,000. Catch-up $1,000 if 50+.",
          "<strong>HSA</strong>: $4,300 single / $8,550 family. Catch-up $1,000 if 55+.",
          "<strong>SEP-IRA</strong>: up to ~25% of compensation, capped at $70,000.",
          "<strong>Solo 401(k)</strong>: same employee limit as workplace 401(k) plus employer profit-sharing up to combined ~$70,000."
        ]},
        { "type": "callout", "kind": "note", "title": "Roth IRA income limits", "text": "Roth IRA contributions phase out for high earners: $150K–$165K MAGI single, $236K–$246K MFJ in 2025 (approximate). Above those limits, direct Roth contributions aren't allowed — but the 'backdoor Roth' (contribute to Traditional IRA, immediately convert to Roth) remains legal for those without other pretax IRA balances. Workplace Roth 401(k) has no income limit." },

        { "type": "heading", "text": "The employer match" },
        { "type": "paragraph", "text": "If an employer offers a 401(k) match, contributing enough to capture the full match is the universal first move. A 50% or 100% match is an immediate, guaranteed return on the contribution before any market exposure. Almost no other recommendation outranks capturing employer match." },
        { "type": "callout", "kind": "do", "title": "The order of operations", "text": "<strong>(1)</strong> Capture full employer 401(k) match. <strong>(2)</strong> Max HSA if HDHP-eligible. <strong>(3)</strong> Max Roth IRA. <strong>(4)</strong> Increase 401(k) toward the contribution limit. <strong>(5)</strong> Taxable brokerage. This order maximizes tax efficiency for most middle- and upper-middle-income households. Exceptions exist for very high earners (mega backdoor Roth) and for households still building their starter emergency fund, but the order is the default." },

        { "type": "divider" },

        { "type": "heading", "text": "Required minimum distributions (RMDs)" },
        { "type": "paragraph", "text": "Tax-deferred accounts can't grow forever untaxed. The IRS requires withdrawals starting at age 73 (rising to 75 by 2033 under SECURE 2.0). RMDs are calculated based on account balance and life expectancy tables. Missing an RMD carries severe penalties — historically 50%, reduced to 25% (or 10% if corrected quickly) under SECURE 2.0." },
        { "type": "list", "items": [
          "RMDs apply to Traditional IRAs, 401(k)s, 403(b)s, and inherited retirement accounts.",
          "Roth IRAs do NOT have RMDs during the original owner's lifetime — one of their structural advantages.",
          "Roth 401(k)s previously had RMDs but SECURE 2.0 eliminated them starting in 2024."
        ]},

        { "type": "case_study",
          "title": "Naomi reconsiders the Roth question",
          "scenario": "Naomi (analyst, $90K salary, single, 34) currently contributes $500/month to a Traditional 401(k). Her marginal federal rate is 22%, plus 9.3% California state — roughly 31% combined. She expects to retire in California or another high-tax state. Should she be contributing to Traditional or Roth?",
          "discussion": "<p>The simple rule: contribute Traditional if today's marginal rate is higher than expected retirement rate; Roth if lower.</p><p>Naomi's current combined rate: ~31%. Expected retirement rate depends on retirement income. If she retires with $1.5M and draws $60K/year, her retirement marginal rate is likely 12% federal + state — call it ~21% combined. <strong>Today's rate is higher than retirement rate → Traditional is the better default for her right now.</strong></p><p>But Naomi is 34 with rising earning potential. As her income grows, the calculus shifts. By the time her marginal rate is 35–40%, Traditional still likely wins on math. But she has a long Roth-friendly window: any year her income drops (sabbatical, transition, layoff), Roth contributions become attractive.</p><p><strong>Recommendation:</strong> Continue Traditional 401(k) for now, but open a Roth IRA on the side and contribute up to the limit ($7,000/year for 2025). This builds a tax-diversified base — half deferred, half tax-free — and gives her flexibility in retirement to manage which bucket to pull from in which year. The split tends to outperform either pure strategy over a long career.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Deductions, Credits, and the Standard Choice",
      "summary": "How the tax base is reduced — and the moves a client can plan for.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax liability is computed on <em>taxable income</em>, not gross income. Deductions and credits are the two main mechanisms that reduce what's owed. Understanding the difference, and recognizing which moves are available, is the foundation for any tax conversation." },

        { "type": "heading", "text": "Deductions reduce taxable income" },
        { "type": "paragraph", "text": "A $10,000 deduction for a client in the 24% bracket reduces tax owed by $2,400 (24% of $10,000). The benefit scales with the bracket — same deduction is worth more to a higher earner." },

        { "type": "subheading", "text": "Standard vs. itemized" },
        { "type": "paragraph", "text": "Every filer can choose the standard deduction (a flat dollar amount based on filing status) OR itemize specific deductions. Take whichever is larger." },
        { "type": "list", "items": [
          "<strong>Standard deduction (2025 approximate)</strong>: $15,000 single / $30,000 MFJ / $22,500 HoH. Plus additional amounts for age 65+ and blind filers.",
          "<strong>Itemized deductions</strong> (on Schedule A): state and local taxes (capped at $10,000), mortgage interest (on up to $750,000 of acquisition debt for post-2017 loans), charitable contributions, medical expenses above 7.5% of AGI, and a few specialty categories."
        ]},
        { "type": "callout", "kind": "note", "title": "Why most clients now take the standard", "text": "The 2017 Tax Cuts and Jobs Act roughly doubled the standard deduction and capped the state/local tax (SALT) deduction at $10,000. The combination pushed roughly 90% of filers to the standard deduction. Itemizing typically only beats the standard for high-mortgage, high-SALT, or large-charitable households." },

        { "type": "heading", "text": "Above-the-line deductions" },
        { "type": "paragraph", "text": "Some deductions are available <em>without</em> itemizing — they reduce AGI directly. The most important to a counselor:" },
        { "type": "list", "items": [
          "<strong>Traditional 401(k) and 403(b) contributions</strong> — reduce taxable wages reported on W-2.",
          "<strong>Traditional IRA contributions</strong> — deductible subject to income phaseouts if the filer is covered by a workplace plan.",
          "<strong>HSA contributions</strong> — pre-tax through payroll, or deductible if made directly.",
          "<strong>Self-employed retirement contributions</strong> — SEP, Solo 401(k), SIMPLE deducted on Schedule 1.",
          "<strong>Student loan interest</strong> — up to $2,500/year, with income phaseouts.",
          "<strong>Self-employed health insurance</strong> — premiums for self-employed and their families."
        ]},
        { "type": "callout", "kind": "do", "title": "Where the planning happens", "text": "Above-the-line moves are where advisors create the most consistent value. They reduce AGI, which cascades into eligibility for other benefits (IRA deductibility, education credits, marketplace subsidies, child tax credit). Even a small reduction in AGI can unlock substantial downstream savings. Always check eligibility for every above-the-line opportunity." },

        { "type": "heading", "text": "Credits reduce tax owed dollar-for-dollar" },
        { "type": "paragraph", "text": "A $2,000 credit is worth $2,000 of tax savings, regardless of bracket. Credits are more valuable than deductions of the same dollar amount." },
        { "type": "subheading", "text": "Major federal credits relevant to typical households" },
        { "type": "list", "items": [
          "<strong>Child Tax Credit</strong> — currently $2,000 per qualifying child under 17, phasing out at high incomes.",
          "<strong>Child and Dependent Care Credit</strong> — for daycare and similar costs, up to 35% of qualifying expenses depending on income.",
          "<strong>Earned Income Tax Credit (EITC)</strong> — refundable credit for lower-income working families. Often missed by eligible filers.",
          "<strong>Saver's Credit</strong> — up to $1,000 ($2,000 MFJ) for retirement contributions by lower-income filers.",
          "<strong>American Opportunity / Lifetime Learning</strong> — education credits.",
          "<strong>Residential energy credits</strong> — solar, electric vehicles, energy-efficient home improvements (current rules subject to legislative change).",
          "<strong>Premium Tax Credit</strong> — for ACA marketplace health insurance enrollees."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "AMT (alternative minimum tax) — briefly" },
        { "type": "paragraph", "text": "Parallel tax calculation that disallows certain deductions and applies a flat rate (26% or 28%) above an exemption threshold. Once a much bigger issue; the 2017 TCJA significantly raised the exemption, so AMT now affects relatively few filers — mostly very high earners and those exercising large amounts of incentive stock options (ISOs). Worth knowing exists; rare to actually navigate." },

        { "type": "callout", "kind": "key", "title": "The line that requires referring out", "text": "Tax planning conversation is in scope for a counselor. <em>Tax preparation and filing</em> is not. Once a client has a complex tax situation — small business, rental property, multiple states, equity compensation, significant capital gains, foreign income, partnership interests — the right move is to bring in a CPA, ideally one your firm has a referral relationship with. The advisor's role is to identify the moves and coordinate; the CPA executes the filing." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Tax-Aware Planning Through the Year",
      "summary": "The recurring moves and the once-a-year audit that turn tax from cost into lever.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax planning isn't an April activity. Most useful tax moves happen during the year — contributions adjusted in real time, harvesting executed at the right window, Roth conversions sized to fill specific brackets. The annual tax review is when the year's moves are checked and next year's are planned." },

        { "type": "heading", "text": "The recurring moves" },

        { "type": "subheading", "text": "Quarterly: estimated tax payments" },
        { "type": "paragraph", "text": "Required for anyone with substantial non-W2 income (self-employment, large capital gains, RMDs). Due April 15, June 15, September 15, and January 15. Safe harbor: pay 100% of last year's tax liability (110% if AGI over $150K), or 90% of current year's liability. Underpayment penalties are non-trivial." },

        { "type": "subheading", "text": "October: open enrollment + benefit elections" },
        { "type": "paragraph", "text": "Confirm 401(k) contribution rate, FSA/HSA elections, dependent care FSA, commuter benefits. These are pre-tax dollars locked in for the next year — the advisor's role is to make sure none are left on the table." },

        { "type": "subheading", "text": "November–December: end-of-year planning window" },
        { "type": "list", "items": [
          "Capital gain/loss harvesting before year-end",
          "Sizing Roth conversions to fill a target bracket",
          "Bunching charitable contributions if itemizing is close (Donor-Advised Funds enable this)",
          "Confirming RMDs taken if 73+",
          "Maximizing remaining 401(k) contributions if room exists",
          "Year-end gifts using annual gift exclusion ($19,000 per recipient in 2025) if estate planning is in scope"
        ]},

        { "type": "subheading", "text": "January–April: tax preparation season" },
        { "type": "paragraph", "text": "Documents arrive (W-2, 1099s, K-1s, mortgage interest statements). Filing happens by April 15 (or extension). Final IRA and HSA contributions for the prior year can be made through April 15 — last chance to deduct." },

        { "type": "divider" },

        { "type": "heading", "text": "Roth conversions" },
        { "type": "paragraph", "text": "Convert money from a Traditional IRA to a Roth IRA. The converted amount is treated as taxable income in the conversion year. Once converted, the money grows and withdraws tax-free." },
        { "type": "subheading", "text": "When conversions make sense" },
        { "type": "list", "items": [
          "<strong>Low-income year</strong> — between jobs, early retirement before RMDs and Social Security, sabbatical. Fill up brackets that would otherwise be empty.",
          "<strong>Expected future tax increase</strong> — pay tax at today's rate to lock in tomorrow's tax-free growth.",
          "<strong>Estate planning</strong> — Roth IRAs pass to heirs tax-free; Traditional IRAs are taxable income to the heir. A taxable Roth conversion paid by the original owner effectively pre-pays the heir's tax bill at the owner's lower bracket.",
          "<strong>Filling a target bracket</strong> — convert exactly enough to use the 12% or 22% bracket without spilling into 24% or higher."
        ]},
        { "type": "callout", "kind": "warn", "title": "The IRMAA and ACA cliffs", "text": "Conversions add to MAGI, which can trigger higher Medicare premiums (IRMAA) for retirees on Medicare, or push families off ACA marketplace subsidies. Always check downstream effects before sizing the conversion. The tax savings may be smaller than they look once you factor in lost benefits." },

        { "type": "heading", "text": "The annual tax review checklist" },
        { "type": "paragraph", "text": "Once a year, work through the following for every client:" },
        { "type": "numbered", "items": [
          "Look at last year's return — what's the marginal rate, effective rate, total tax paid?",
          "Are all available pre-tax contributions being maximized? (401k, HSA, IRA where deductible)",
          "Is the Traditional/Roth balance appropriate given current vs. expected future rates?",
          "Were there capital gains realized that could have been harvested earlier or deferred?",
          "Are tax-inefficient assets (REITs, taxable bonds, high-turnover funds) inside tax-advantaged accounts?",
          "Is the client maximizing employer match?",
          "Are there charitable contributions that could be bunched, donated as appreciated securities, or routed through a DAF?",
          "Are state-tax considerations being captured (residency, source of income, state-specific deductions)?",
          "Is the filing status optimal (especially relevant in years of major life events)?",
          "Are estimated tax payments on track to avoid underpayment penalty?"
        ]},

        { "type": "callout", "kind": "key", "title": "The frame", "text": "Tax is not a fixed cost. It's the line item where consistent, knowledgeable attention pays the most for the least work. A counselor who covers the items in this list each year creates value far in excess of their fee — often without the client noticing. That's the standard." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A single filer with $75,000 of taxable income is in the 22% bracket. What does that mean?",
        "options": [
          "All $75,000 of income is taxed at 22%.",
          "The next dollar earned is taxed at 22%, but income within lower brackets is taxed at lower rates. The effective rate is lower than 22%.",
          "The client pays 22% in tax to the federal government.",
          "Only state tax applies; federal is 22%."
        ],
        "correct": 1,
        "explanation": "Marginal rate is the rate on the next dollar. Effective rate is the average across all dollars. The client's effective rate is around 15%, not 22%, because lower-bracket dollars are taxed at lower rates."
      },
      {
        "id": "q2",
        "prompt": "Why does the timing of selling an appreciated asset (just before vs. just after the one-year mark) often matter so much?",
        "options": [
          "Because the asset's price will change.",
          "Because long-term capital gains (held more than one year) are taxed at preferential rates (0/15/20%) instead of ordinary income rates that can exceed 37%.",
          "Because the IRS audits short-term gains more often.",
          "Because the client's bracket changes by the calendar."
        ],
        "correct": 1,
        "explanation": "Short-term gain = ordinary income, up to 37% federal. Long-term gain = 0/15/20% federal. The difference on a large gain can be tens of thousands of dollars for one extra month of patience."
      },
      {
        "id": "q3",
        "prompt": "Which of the following is generally the right ordering for an early-career employee's retirement savings?",
        "options": [
          "Max Traditional IRA, then taxable brokerage, then 401(k) match.",
          "Capture full employer 401(k) match, max HSA if eligible, max Roth IRA, increase 401(k) toward contribution limit, then taxable brokerage.",
          "Max 401(k) regardless of match, then ignore IRA.",
          "Whole life insurance, then any of the above."
        ],
        "correct": 1,
        "explanation": "The match is the highest-priority free money. HSA is structurally one of the best accounts available. Roth IRA contributions are limited and disappear with income, so they should be captured during eligible years. Beyond that, raise 401(k) toward the limit before going to taxable."
      },
      {
        "id": "q4",
        "prompt": "A client with a $1M Traditional IRA wants to convert $50,000 to a Roth this year. What's the most important downstream consideration before sizing the conversion?",
        "options": [
          "Whether the client likes Roth IRAs.",
          "Whether the conversion will push the client past Medicare IRMAA thresholds, ACA subsidy cliffs, or into a higher marginal bracket than intended.",
          "Whether the market is currently up or down.",
          "Whether the client is married."
        ],
        "correct": 1,
        "explanation": "Roth conversions add to MAGI. That can raise Medicare premiums (IRMAA), kill ACA marketplace subsidies, and push income into higher brackets than intended. Always check downstream effects before sizing the conversion."
      },
      {
        "id": "q5",
        "prompt": "What is the wash sale rule?",
        "options": [
          "Investors can't sell a stock at a loss and buy the same (or substantially identical) security within 30 days before or after; the loss is disallowed for that year.",
          "Investors must wait 30 days between buys.",
          "All capital losses are disallowed.",
          "Only applies to mutual funds, not individual stocks."
        ],
        "correct": 0,
        "explanation": "Sell at a loss and buy back the same security within 30 days (before or after the sale) and the loss is disallowed. Cost basis is adjusted. Workaround: buy a similar but not 'substantially identical' security, or wait 31+ days."
      },
      {
        "id": "q6",
        "prompt": "Why are REITs typically held in tax-advantaged accounts rather than taxable accounts?",
        "options": [
          "They have higher fees in taxable accounts.",
          "REIT distributions are mostly ordinary dividends taxed at the client's marginal rate, which is usually higher than the capital gains rate. Sheltering them inside a tax-advantaged account avoids that ordinary-income drag.",
          "REITs are illegal in taxable accounts.",
          "REITs only pay dividends in tax-advantaged accounts."
        ],
        "correct": 1,
        "explanation": "REIT distributions don't qualify as qualified dividends — they're taxed at ordinary rates. Inside an IRA or 401(k), the ordinary-income drag disappears. This is one of the most common asset-location moves an advisor makes."
      },
      {
        "id": "q7",
        "prompt": "What is the structural difference between a deduction and a credit?",
        "options": [
          "They are the same thing.",
          "A deduction reduces taxable income (so its value depends on bracket). A credit reduces tax owed dollar-for-dollar (so its value is independent of bracket).",
          "A credit is only for low-income filers.",
          "A deduction is more valuable than a credit."
        ],
        "correct": 1,
        "explanation": "Deduction of $1,000 saves $220 in 22% bracket, $370 in 37% bracket. Credit of $1,000 saves $1,000 regardless of bracket. Credits are more valuable than deductions of the same dollar amount."
      },
      {
        "id": "q8",
        "prompt": "What does it mean that long-term capital gains have a '0% bracket'?",
        "options": [
          "All long-term gains are tax-free.",
          "Long-term capital gains are taxed at 0% federally when total taxable income (including the gain) is below approximately $48,350 single / $96,700 MFJ — a major planning opportunity in lower-income years.",
          "The first 0% of gains is tax-free.",
          "Only retirees get 0%."
        ],
        "correct": 1,
        "explanation": "The 0% LTCG bracket is one of the most underused planning windows. Early retirees, sabbatical years, transition years often offer the opportunity to realize appreciated gains entirely tax-free at the federal level."
      },
      {
        "id": "q9",
        "prompt": "When is Roth (rather than Traditional) generally the better contribution choice?",
        "options": [
          "Always — tax-free is best.",
          "When the client's current marginal tax rate is LOWER than their expected marginal rate in retirement. Pay the tax at today's lower rate; take the money out tax-free at tomorrow's higher rate.",
          "When the client is older than 50.",
          "When the client has children."
        ],
        "correct": 1,
        "explanation": "The Roth vs. Traditional decision rests on the comparison between current and expected future marginal rates. Lower today → Roth. Higher today → Traditional. Uncertain or equal → diversify."
      },
      {
        "id": "q10",
        "prompt": "A client says, 'I don't itemize because the standard deduction is bigger.' What's the right advisor move?",
        "options": [
          "Confirm and move on.",
          "Acknowledge, then check whether bunching deductions across years (especially charitable contributions via a Donor-Advised Fund) could push them over the standard deduction every other year and produce material additional savings.",
          "Tell them to itemize anyway.",
          "Recommend they buy a house to get mortgage interest."
        ],
        "correct": 1,
        "explanation": "Bunching is a real technique: stack two years' worth of charitable giving into one calendar year (via a DAF), itemize that year, take the standard in the other. Useful when itemizable totals fall just below the standard."
      },
      {
        "id": "q11",
        "prompt": "Roth IRAs differ from Traditional IRAs in which important way for retirement planning?",
        "options": [
          "Roth IRAs have higher contribution limits.",
          "Roth IRAs do not have required minimum distributions during the owner's lifetime — money can keep growing tax-free indefinitely, then pass to heirs with continued tax advantages.",
          "Roth IRAs are tax-deferred.",
          "Roth IRAs have employer matches."
        ],
        "correct": 1,
        "explanation": "No RMDs for Roth IRAs during the original owner's lifetime is a structural advantage. It enables longer compounding, lets the owner manage withdrawal timing for tax efficiency, and supports estate planning by passing the asset tax-free to heirs."
      },
      {
        "id": "q12",
        "prompt": "What is the right professional response when a client has equity compensation (ISOs, RSUs, ESPP), small business income, and rental property?",
        "options": [
          "File their return for them; the advisor knows enough.",
          "Recognize the complexity exceeds tax-planning scope and bring in a CPA. Advisor coordinates the moves; CPA executes the filing and confirms the technical positions.",
          "Tell the client to look it up online.",
          "Move all their assets to a trust to avoid tax."
        ],
        "correct": 1,
        "explanation": "Tax planning is in scope for the advisor. Tax preparation, especially for complex situations, is out of scope. The right move is referral to a CPA — ideally one in the firm's network — with the advisor staying coordinated."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 5;

-- ============================================================================
-- DONE.
-- ============================================================================

-- ── module6_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 6 CONTENT
-- Investment Vehicles & Markets
-- ============================================================================

update public.modules set
  title = 'Investment Vehicles & Markets',
  competency_id = 'CORE-6',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The asset classes, fund wrappers, and market mechanics every counselor must understand before recommending anything.',
  learning_objectives = ARRAY[
    'Distinguish the major asset classes by risk, return, and role in a portfolio.',
    'Explain the structural differences between mutual funds, ETFs, and individual securities.',
    'Compare active and passive management honestly, including evidence on persistence and cost.',
    'Read an expense ratio and convert it into dollar terms over a lifetime.',
    'Describe how a stock trade actually executes, from order to settlement.',
    'Identify common fee structures and the most material costs that erode client returns.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Asset Classes",
      "summary": "What stocks, bonds, cash, and real estate actually are — and how they behave differently.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Before talking about how to invest, an advisor must be fluent in what's being invested in. Asset classes are the categories with distinct risk and return characteristics. The portfolio is a deliberate mix of them, balanced to serve a specific client's goals." },

        { "type": "heading", "text": "Cash and cash equivalents" },
        { "type": "paragraph", "text": "Checking accounts, savings accounts, money market funds, Treasury bills, short-term CDs. Defining characteristics: low volatility, immediate or near-immediate access, low return." },
        { "type": "list", "items": [
          "<strong>Role in a portfolio:</strong> liquidity, emergency reserves, near-term spending needs.",
          "<strong>Long-run real return:</strong> approximately 0%. Cash preserves nominal capital but loses purchasing power to inflation over time.",
          "<strong>When to hold:</strong> emergency fund, money needed within 1–3 years, dry powder for opportunities."
        ]},

        { "type": "heading", "text": "Bonds (fixed income)" },
        { "type": "paragraph", "text": "Loans from investor to borrower (corporation, government, municipality) at a stated interest rate for a stated term. The borrower repays principal at maturity and pays periodic interest in between." },
        { "type": "subheading", "text": "Sub-categories" },
        { "type": "list", "items": [
          "<strong>Treasuries</strong> — U.S. government debt. Considered the safest fixed income. Short-term: T-bills (under 1 year). Medium: T-notes (2–10 years). Long: T-bonds (20–30 years). Treasury Inflation-Protected Securities (TIPS) adjust principal for inflation.",
          "<strong>Investment-grade corporate</strong> — debt of strong corporations (rated BBB- and above). Slightly higher yield than Treasuries; modest default risk.",
          "<strong>High-yield (junk) corporate</strong> — debt of weaker corporations (rated below BBB-). Higher yield, higher default risk, behaves more like equity in downturns.",
          "<strong>Municipal bonds</strong> — issued by state and local governments. Federal tax-exempt interest; sometimes state-exempt for in-state holders. Generally lower coupon but higher after-tax yield for high-bracket investors.",
          "<strong>Mortgage-backed securities (MBS)</strong> — pools of mortgages packaged into bonds. Prepayment risk: when interest rates fall, homeowners refinance and the bonds pay off earlier than expected."
        ]},
        { "type": "callout", "kind": "key", "title": "The bond-price-vs-rate relationship", "text": "When interest rates rise, existing bond prices fall (the existing lower-coupon bonds are worth less than new higher-coupon ones). When rates fall, existing bond prices rise. Long-duration bonds are more sensitive than short-duration. This inverse relationship explains why 2022 was such a difficult year for bond investors — rates rose sharply, and bond prices dropped accordingly." },

        { "type": "heading", "text": "Stocks (equities)" },
        { "type": "paragraph", "text": "Ownership shares in a public company. Investors receive a share of profits (via dividends) and a share of growth (via price appreciation). No maturity date; can be held indefinitely." },
        { "type": "subheading", "text": "Sub-categories" },
        { "type": "list", "items": [
          "<strong>Market cap</strong>: Large-cap (>$10B), mid-cap ($2–10B), small-cap (<$2B), micro-cap. Smaller-cap historically more volatile but higher long-run return.",
          "<strong>Style</strong>: Value (lower P/E, higher dividend) vs. Growth (higher P/E, reinvesting profits for expansion). Both have outperformed in different decades.",
          "<strong>Geography</strong>: U.S., developed international (Europe, Japan), emerging markets (China, India, Brazil). Each provides diversification.",
          "<strong>Sector</strong>: Technology, financials, healthcare, consumer staples, energy, etc. Different sensitivities to economic cycles."
        ]},

        { "type": "heading", "text": "Real estate" },
        { "type": "paragraph", "text": "Physical property (direct ownership) or securitized exposure (REITs). Provides income (rent or REIT dividends) and potential appreciation. Generally less correlated with stocks and bonds, which is why it appears in diversified portfolios." },
        { "type": "list", "items": [
          "<strong>Direct ownership</strong> — illiquid, requires management, concentrated risk in one property/market.",
          "<strong>REITs</strong> — publicly traded real estate companies. Liquid, diversified, but correlate more with stocks than direct real estate.",
          "<strong>Long-run return</strong> — historically similar to stocks (roughly 7–10% nominal, depending on timeframe) but with different cyclical behavior."
        ]},

        { "type": "heading", "text": "Commodities and alternatives" },
        { "type": "paragraph", "text": "Gold, oil, agricultural products, hedge funds, private equity, private credit. Generally lower allocation in most plans (or zero); harder to access, often more expensive, performance varies." },
        { "type": "callout", "kind": "note", "title": "Don't reach for alternatives early", "text": "Most retail clients do not need a meaningful alternatives allocation to achieve their financial goals. Hedge funds and private equity sound sophisticated, but they often come with high fees, illiquidity, and limited performance advantages relative to a well-built stock-and-bond portfolio. If a client doesn't have a diversified base of stocks and bonds, the right move is to build that first, not to chase alpha in alternatives." },

        { "type": "divider" },

        { "type": "heading", "text": "Long-run real returns (approximate, U.S. data)" },
        { "type": "paragraph", "text": "Useful planning anchors. These are long-run averages and not promises:" },
        { "type": "list", "items": [
          "Cash / T-bills: ~0% to 1% real",
          "Investment-grade bonds: ~1% to 3% real",
          "U.S. stocks (broad market): ~5% to 7% real",
          "International developed stocks: ~4% to 6% real",
          "Emerging markets stocks: ~5% to 7% real with much higher volatility",
          "REITs: ~4% to 6% real",
          "Gold: ~0% to 2% real (highly variable by period)"
        ]},
        { "type": "callout", "kind": "warn", "title": "Past is not prologue", "text": "These numbers describe history. They are useful for planning anchors but they are not guarantees. The next 30 years could differ from the last 100. Always use 'expected' or 'long-run assumption' language with clients — never 'will return' or 'is going to make'." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Funds: Mutual Funds, ETFs, and the Wrapper Question",
      "summary": "How clients access asset classes in practice, and why the wrapper choice matters.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients don't own individual stocks and bonds. They own funds — pools of securities packaged together. The wrapper around the pool — mutual fund, ETF, or other — affects taxation, trading, cost, and accessibility. Knowing the differences is core counselor literacy." },

        { "type": "heading", "text": "Mutual funds" },
        { "type": "paragraph", "text": "The traditional structure. A mutual fund pools investor money to buy a portfolio of securities managed by an investment company. Shares are bought and sold once a day, at the closing net asset value (NAV)." },
        { "type": "subheading", "text": "Key characteristics" },
        { "type": "list", "items": [
          "<strong>Priced once daily at 4pm ET.</strong> Orders during the day are filled at end-of-day NAV.",
          "<strong>Often have minimums</strong> — $1,000 to $3,000 is typical for the initial purchase.",
          "<strong>Can have sales charges (loads)</strong> — front-end (paid on purchase), back-end (paid on sale), or 12b-1 (annual marketing fee). Increasingly rare; many fund families offer no-load shares.",
          "<strong>Tax inefficiency</strong> — required to distribute capital gains realized by the fund manager to shareholders annually. Even if you don't sell, you may receive a taxable distribution."
        ]},

        { "type": "heading", "text": "Exchange-traded funds (ETFs)" },
        { "type": "paragraph", "text": "Started in the 1990s; now hold trillions of dollars in U.S. assets. Same basic concept as a mutual fund — pooled portfolio managed by an investment company — but with a different legal and trading structure that produces material practical advantages." },
        { "type": "subheading", "text": "Key characteristics" },
        { "type": "list", "items": [
          "<strong>Trade like stocks throughout the day.</strong> Price changes continuously based on supply and demand, hovering near the NAV.",
          "<strong>No minimums</strong> — can buy a single share. With fractional shares (available at most brokers), can buy any dollar amount.",
          "<strong>No loads</strong> — pay only the bid-ask spread plus expense ratio plus commissions if charged (most brokers now offer commission-free ETF trading).",
          "<strong>Tax efficiency</strong> — the in-kind creation/redemption mechanism (which is structural and built into how ETFs operate) means most ETFs distribute very few capital gains compared to equivalent mutual funds. For taxable accounts, this is often the deciding factor."
        ]},

        { "type": "callout", "kind": "key", "title": "When to prefer one over the other", "text": "<strong>ETFs win in most cases</strong> for taxable accounts due to tax efficiency, and for cost-conscious clients due to lower expense ratios on equivalent strategies. <strong>Mutual funds are fine in tax-advantaged accounts</strong> (IRAs, 401(k)s), where their tax inefficiency doesn't matter, and they're still the standard inside most 401(k) plans. <strong>Index mutual funds at Vanguard, Fidelity, Schwab</strong> often have expense ratios as low as ETFs and may be the more convenient choice when you're already doing automatic recurring investments." },

        { "type": "heading", "text": "Other common wrappers" },
        { "type": "glossary", "terms": [
          { "term": "Index fund", "definition": "A fund (mutual fund or ETF) that holds securities matching a published index — S&P 500, Total Stock Market, Total Bond Market. Passive management. Low cost." },
          { "term": "Closed-end fund (CEF)", "definition": "A pool that issues a fixed number of shares, then trades on an exchange. Price often diverges from NAV. Older structure, less common now." },
          { "term": "Unit investment trust (UIT)", "definition": "Holds a fixed portfolio for a set period. Less common; sometimes encountered with brokerage account legacy holdings." },
          { "term": "SMA (separately managed account)", "definition": "A portfolio of individual securities held in the client's name and managed to a specified strategy. Used by higher-net-worth clients. Can offer tax customization (tax-loss harvesting on the individual lots)." }
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Index funds vs. actively managed funds" },
        { "type": "paragraph", "text": "An <strong>index fund</strong> aims to match the return of a published index by holding the same securities in the same weights. An <strong>actively managed fund</strong> aims to outperform the index by picking stocks the manager believes will do better." },
        { "type": "subheading", "text": "What the evidence actually shows" },
        { "type": "list", "items": [
          "Over 10–15 year windows, approximately 80–90% of actively managed U.S. equity funds underperform their benchmark index after fees (SPIVA data, multiple years).",
          "Past outperformance does not predict future outperformance. The funds that beat the index in the prior decade rarely beat it in the next.",
          "Cost is the most reliable predictor of fund return. Lower-cost funds, on average, outperform higher-cost funds in the same category."
        ]},
        { "type": "callout", "kind": "key", "title": "The honest default", "text": "For most clients, a portfolio built largely from low-cost broad-market index funds — total U.S. stock, total international stock, total bond market — captures the bulk of available return at minimum cost. Active management has a place (particularly in less efficient asset classes), but it should be the exception requiring justification, not the default." },

        { "type": "case_study",
          "title": "Two funds, twenty years",
          "scenario": "Client invests $10,000 in two funds. Fund A is an S&P 500 index fund with a 0.04% expense ratio. Fund B is an actively managed large-cap fund with a 0.85% expense ratio. Assume both deliver the same gross return — 8% annually — for 20 years. What's the difference at the end?",
          "discussion": "<p>Fund A: $10,000 × (1.0796)^20 = approximately $46,184.</p><p>Fund B: $10,000 × (1.0715)^20 = approximately $39,499.</p><p>The actively managed fund — same gross return — leaves the client roughly <strong>$6,685</strong> behind after 20 years, just from the higher expense ratio. And the assumption that both deliver the same gross return is generous: most active funds in the same category trail the index on gross returns too. The real-world gap is typically larger. <em>Fees compound the same way returns do.</em></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "How Markets Actually Work",
      "summary": "Exchanges, market makers, settlement — the mechanics behind every trade.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients click 'buy' on a stock; the order is filled. What actually happens between those two events is invisible to them but worth understanding for any counselor. The mechanics affect pricing, fees, tax treatment, and what's possible." },

        { "type": "heading", "text": "Exchanges and market participants" },
        { "type": "list", "items": [
          "<strong>Exchanges</strong> — NYSE, Nasdaq, Cboe, and others. Centralized venues where buyers and sellers meet. Most stocks are listed on one or more exchanges.",
          "<strong>Brokers</strong> — the firms clients interact with (Schwab, Fidelity, Vanguard, IBKR, Robinhood). Brokers route client orders to the market.",
          "<strong>Market makers</strong> — firms that stand ready to buy or sell a security at posted prices. They earn the bid-ask spread.",
          "<strong>Specialists / designated market makers</strong> — for stocks listed on NYSE, a designated firm ensures orderly trading.",
          "<strong>Clearing firms</strong> — handle the settlement process. The largest is DTCC, which acts as the clearinghouse for most U.S. securities transactions."
        ]},

        { "type": "heading", "text": "Order types" },
        { "type": "glossary", "terms": [
          { "term": "Market order", "definition": "Buy or sell immediately at the best available price. Fast execution but no price protection." },
          { "term": "Limit order", "definition": "Buy at a specified price or lower; sell at a specified price or higher. Price protection but no guarantee of execution." },
          { "term": "Stop order (stop-loss)", "definition": "Becomes a market order when the security crosses a specified trigger price. Used to limit losses or lock in gains. Note: in fast markets, can execute far from the trigger price." },
          { "term": "Stop-limit order", "definition": "Becomes a limit order at a specified price. Adds price protection but may not execute at all." }
        ]},
        { "type": "callout", "kind": "do", "title": "Order-type discipline", "text": "For most long-term investors buying broad-market funds, market orders are fine — the bid-ask spread on a liquid ETF is pennies. For less liquid securities (small-cap, thin trading volume), limit orders should be the default to avoid surprising fill prices. Stop-loss orders have a checkered history; they're easy to trigger during temporary volatility and can sell at exactly the wrong moment." },

        { "type": "heading", "text": "Settlement" },
        { "type": "paragraph", "text": "When you buy a stock, you receive the shares; when you sell, you receive the cash. That handoff is called <strong>settlement</strong>, and it happens on a delay." },
        { "type": "list", "items": [
          "<strong>Equities and most ETFs</strong>: T+1 (trade date plus one business day) as of May 2024. Previously T+2.",
          "<strong>Treasuries</strong>: T+1 typically.",
          "<strong>Mutual funds</strong>: typically T+1 for redemptions to settle as cash."
        ]},
        { "type": "callout", "kind": "warn", "title": "Why settlement matters for clients", "text": "A client who sells $50,000 of an ETF on Friday cannot wire that money out the same day — it doesn't settle until Monday. For tax purposes, the sale is recognized on the trade date (Friday); for cash availability, it's the settlement date. Clients planning to use proceeds (closing on a home, sending tuition) need this lead time built in." },

        { "type": "heading", "text": "Bid, ask, and spread" },
        { "type": "paragraph", "text": "Every security has a <strong>bid</strong> (highest price someone is willing to pay) and an <strong>ask</strong> or <strong>offer</strong> (lowest price someone is willing to sell). The difference is the <strong>spread</strong>." },
        { "type": "list", "items": [
          "Highly liquid securities (SPY, AAPL, MSFT): spread is often $0.01 or less.",
          "Less liquid securities (small-cap, niche ETFs): spread can be $0.05–$0.50 or more — material.",
          "Buying at the ask and selling at the bid means losing the spread on every round-trip. For frequent traders, this adds up; for buy-and-hold investors, it's negligible."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Dividends, splits, and corporate actions" },
        { "type": "list", "items": [
          "<strong>Dividend</strong> — cash payment per share, paid to shareholders of record on a specified date.",
          "<strong>Ex-dividend date</strong> — the date by which an investor must own the stock to receive the next dividend.",
          "<strong>Stock split</strong> — increases share count, proportionally decreases share price. No change in total value. 2-for-1 split: 100 shares at $200 become 200 shares at $100.",
          "<strong>Reverse split</strong> — opposite. Often signals a struggling company trying to keep share price above exchange listing minimums.",
          "<strong>Spin-off</strong> — parent company creates a separate publicly traded subsidiary. Shareholders receive shares in the new entity proportional to their parent holdings.",
          "<strong>Merger/acquisition</strong> — shareholders may receive cash, shares of the acquiring company, or both."
        ]},
        { "type": "callout", "kind": "note", "title": "DRIP (dividend reinvestment)", "text": "Most brokers offer the option to automatically reinvest dividends into more shares of the same security. For long-term accumulation, this is usually fine and removes a friction. For taxable accounts, dividend reinvestment can complicate tax-loss harvesting (reinvested shares create new lots and wash sale risk if a near-term sale happens at a loss). Check the client's DRIP settings during reviews." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Fees and What They Actually Cost",
      "summary": "Layered costs, expressed as percentages, compounding against the client. The largest hidden line item in most portfolios.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Fees are the most predictable destroyer of long-term return. Markets are uncertain; fees are certain. Every dollar paid in fees is a dollar the client doesn't keep. A counselor who systematically reduces fees in a client's portfolio is creating real, measurable, lasting value." },

        { "type": "heading", "text": "The layers of fees in a typical portfolio" },
        { "type": "numbered", "items": [
          "<strong>Expense ratio</strong> — annual fee charged by the fund or ETF. Expressed as a percentage of assets. Deducted daily from fund value. The most visible fee.",
          "<strong>Trading commissions</strong> — fee per trade. Many brokers now offer zero commissions on stocks and ETFs. Mutual funds may have transaction fees ($25–$75 outside the broker's no-fee list).",
          "<strong>Bid-ask spread</strong> — invisible cost on every trade. Material in less liquid securities.",
          "<strong>Loads</strong> — front-end (paid on purchase) or back-end (paid on sale) sales charges on some mutual funds. Common in older accounts; usually avoidable.",
          "<strong>12b-1 fees</strong> — annual marketing fee, baked into the expense ratio of some mutual funds. Up to 1% annually. A reason to scrutinize the expense ratio breakdown.",
          "<strong>Advisor fee</strong> — what the client pays the advisor or advisory firm. Typically 0.5%–1.5% of assets under management for traditional firms; some hourly or flat-fee.",
          "<strong>Platform fee</strong> — some 401(k) plans charge an additional administrative fee on top of fund expense ratios.",
          "<strong>Custodian/wrap fees</strong> — bundled fees that include trading, custody, and sometimes advice."
        ]},

        { "type": "callout", "kind": "key", "title": "Expense ratios in dollar terms", "text": "An expense ratio of 1% on a $500,000 portfolio is $5,000/year. Same ratio on a $1M portfolio is $10,000/year. Whether it's labeled as a small decimal or a fund-family name, it's a real annual cost. Reframing it in dollars often unlocks the client conversation about whether the value justifies the cost." },

        { "type": "heading", "text": "Expense ratio benchmarks" },
        { "type": "paragraph", "text": "For broad-market index funds, the floor has fallen dramatically over the past decade:" },
        { "type": "list", "items": [
          "<strong>Top-tier U.S. total market index (Vanguard VTI, Fidelity FZROX, etc.)</strong>: 0.00% to 0.04%",
          "<strong>Top-tier international index</strong>: 0.04% to 0.08%",
          "<strong>Top-tier total bond market index</strong>: 0.03% to 0.06%",
          "<strong>Average actively managed equity mutual fund</strong>: 0.45% to 0.90%",
          "<strong>Higher-cost specialty funds, certain target-date funds, certain insurance subaccounts</strong>: 0.80% to 1.50%+"
        ]},
        { "type": "callout", "kind": "warn", "title": "Where high fees still hide", "text": "Old employer 401(k)s left behind, variable annuity subaccounts, broker-sold mutual fund classes with loads or 12b-1 fees, certain bank-sold managed accounts, target-date funds at the wrong fund family. The first job when taking on a new client is auditing the existing portfolio for fee leakage. Often, the fee reduction alone pays for the first year of the advisor relationship." },

        { "type": "divider" },

        { "type": "heading", "text": "The 1% advisor fee question" },
        { "type": "paragraph", "text": "Many advisors charge approximately 1% of assets under management annually. On a $1M portfolio, that's $10,000/year. Over 30 years, with a 7% gross return, the difference between a portfolio that pays 1% AUM and one that doesn't is roughly $1 million in final value." },
        { "type": "subheading", "text": "When the 1% fee creates value" },
        { "type": "list", "items": [
          "Comprehensive financial planning (cash flow, tax, retirement, estate, insurance)",
          "Behavioral coaching that prevents costly mistakes (panic-selling, performance-chasing)",
          "Tax-aware investing (asset location, harvesting, Roth conversions)",
          "Coordination with CPA, attorney, insurance, lender",
          "Major life-event planning (career transition, inheritance, business sale)"
        ]},
        { "type": "subheading", "text": "When the 1% fee doesn't" },
        { "type": "list", "items": [
          "Pure investment management with no planning",
          "Off-the-shelf models with no customization",
          "Limited contact and reactive service",
          "Clients with very large portfolios — the math no longer works on a flat percentage"
        ]},
        { "type": "callout", "kind": "note", "title": "The counselor's role here", "text": "GIC operates on a fee-for-service / advisory model — not commission. Apprentices should be able to articulate exactly what value the client is receiving for the fee they pay. \"You're paying me to think about your money, not just to manage it,\" is the spirit. Vague answers about \"long-term relationship\" are a sign that the value proposition isn't fully thought through." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Risk-Return Relationship",
      "summary": "Why higher returns come with higher volatility — and what that means for real portfolios.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "There is no free lunch. Every additional dollar of expected return, in efficient markets, comes paired with additional risk. A portfolio of Treasury bills will produce reliable but modest returns; a portfolio of small-cap emerging markets stocks will produce highly variable returns with higher long-run expectations. The client's job (with the advisor's help) is to choose where on this spectrum they belong." },

        { "type": "heading", "text": "Measuring risk" },
        { "type": "paragraph", "text": "Common measures, each with limits:" },
        { "type": "glossary", "terms": [
          { "term": "Standard deviation (volatility)", "definition": "Measures how much returns vary around the average. Higher = more variable returns. U.S. stocks historically ~15–17% annual standard deviation; high-quality bonds ~5–7%." },
          { "term": "Drawdown / maximum drawdown", "definition": "The peak-to-trough decline in value. The worst loss from a high-water mark. U.S. stocks have had multiple 40%+ drawdowns historically." },
          { "term": "Beta", "definition": "Sensitivity to overall market movements. Beta of 1 = moves with market. Beta of 1.5 = amplified. Beta of 0.5 = damped. Beta of 0 = uncorrelated." },
          { "term": "Sharpe ratio", "definition": "Excess return over risk-free rate, divided by standard deviation. Higher = better risk-adjusted return. A way to compare investments across risk levels." }
        ]},

        { "type": "heading", "text": "What clients actually experience" },
        { "type": "paragraph", "text": "Standard deviation is a useful technical concept. But in practice, clients don't experience volatility — they experience drawdowns. A portfolio with a 15% standard deviation can drop 40% in a serious bear market and stay there for years before recovering." },
        { "type": "callout", "kind": "key", "title": "The drawdowns to remember", "text": "<strong>1973–74:</strong> S&P 500 dropped about 48% (in nominal terms; worse in real terms with high inflation). <strong>2000–2002:</strong> S&P 500 dropped about 49%; tech-heavy Nasdaq dropped about 78%. <strong>2007–2009:</strong> S&P 500 dropped about 57% peak-to-trough. <strong>2020:</strong> S&P 500 dropped about 34% in five weeks (and recovered quickly). <strong>2022:</strong> S&P 500 dropped about 25%; bonds dropped about 13% simultaneously. The client who hasn't lived through one of these may genuinely not understand what they're agreeing to when they say they're \"comfortable with risk.\"" },

        { "type": "heading", "text": "Risk tolerance vs. risk capacity" },
        { "type": "glossary", "terms": [
          { "term": "Risk tolerance", "definition": "How much volatility the client can emotionally handle. A behavioral measure." },
          { "term": "Risk capacity", "definition": "How much volatility the client's financial situation can absorb without harming their plan. A structural measure." }
        ]},
        { "type": "paragraph", "text": "These can differ. A young client with stable income and a 30-year horizon has high capacity — they can afford a 50% drawdown because they have time and income to recover. But their tolerance may be much lower, especially if they've never lived through a real bear market. A retiree drawing on their portfolio has low capacity (drawdowns plus withdrawals compound badly) but may have high tolerance from years of investing experience." },
        { "type": "callout", "kind": "do", "title": "Build the portfolio for the lower of the two", "text": "If tolerance is lower than capacity, build for tolerance — a too-aggressive portfolio that triggers panic-selling produces worse outcomes than a too-conservative one held faithfully. If capacity is lower than tolerance, build for capacity — the client's situation can't actually support what their stomach wants. This is the conversation. Document the rationale." },

        { "type": "divider" },

        { "type": "heading", "text": "The investor's true return" },
        { "type": "paragraph", "text": "Dalbar and similar studies have shown that the average investor's actual return is materially lower than the market's return — often by 3% or more annually. The gap isn't because the market did something secret; it's because investors buy high (after bull runs) and sell low (during bear markets), miss the best days, switch strategies after underperformance, and otherwise behave their way into a worse outcome." },
        { "type": "callout", "kind": "key", "title": "The thing the advisor protects against", "text": "The biggest source of return destruction in a typical client's lifetime isn't fees, isn't market drops, isn't tax. It's behavior — selling at the bottom, buying at the top, abandoning a plan when it's working but feels bad. The single largest source of value an advisor delivers is preventing the client from doing this. Coaching matters more than picking. Always." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What happens to existing bond prices when interest rates rise?",
        "options": [
          "They rise.",
          "They fall.",
          "They stay the same.",
          "It depends on the issuer."
        ],
        "correct": 1,
        "explanation": "Bond prices and rates move inversely. New bonds at higher rates make existing lower-coupon bonds less valuable. Long-duration bonds are more sensitive than short. This relationship explains why 2022 was so difficult for bond investors."
      },
      {
        "id": "q2",
        "prompt": "Why are ETFs generally more tax-efficient than equivalent mutual funds in taxable accounts?",
        "options": [
          "ETFs are exempt from federal tax.",
          "ETFs' in-kind creation/redemption mechanism allows them to distribute very few capital gains, whereas mutual funds must distribute realized gains annually to shareholders.",
          "ETFs use different accounting.",
          "Mutual funds are taxed twice; ETFs once."
        ],
        "correct": 1,
        "explanation": "The structural in-kind mechanism of ETFs lets the fund manager avoid realizing capital gains in most cases. Mutual funds, by contrast, must distribute realized gains to shareholders annually — even shareholders who didn't sell. For taxable accounts, this is often the deciding factor."
      },
      {
        "id": "q3",
        "prompt": "What do SPIVA and similar studies consistently show about actively managed U.S. equity funds?",
        "options": [
          "They outperform their benchmarks roughly 80% of the time.",
          "They roughly match their benchmarks.",
          "Approximately 80–90% underperform their benchmark over 10–15 year windows, after fees.",
          "Past performance reliably predicts future performance."
        ],
        "correct": 2,
        "explanation": "The data consistently show roughly 80–90% of actively managed U.S. equity funds trail their benchmark over long periods. And past outperformance does not reliably predict future. Low-cost index funds win in the aggregate."
      },
      {
        "id": "q4",
        "prompt": "A $500,000 portfolio is charged a 1% annual advisor fee. What is the annual fee in dollar terms?",
        "options": [
          "$500",
          "$1,000",
          "$5,000",
          "$50,000"
        ],
        "correct": 2,
        "explanation": "1% of $500,000 = $5,000/year. Reframing percentage fees in dollar terms is one of the most useful tools for evaluating whether the value justifies the cost."
      },
      {
        "id": "q5",
        "prompt": "Which order type should typically be used for a small-cap, thinly traded ETF?",
        "options": [
          "Market order — speed matters most.",
          "Limit order — to avoid surprising fill prices in a thin market.",
          "Stop order — to lock in gains.",
          "Order type doesn't matter."
        ],
        "correct": 1,
        "explanation": "Less liquid securities can have wide bid-ask spreads. A market order might execute at a much worse price than the last quote. Limit orders provide price protection at the cost of execution uncertainty."
      },
      {
        "id": "q6",
        "prompt": "What is the current standard settlement period for U.S. equities?",
        "options": [
          "Same day (T+0)",
          "T+1 (trade date plus one business day)",
          "T+3",
          "Five business days"
        ],
        "correct": 1,
        "explanation": "U.S. equity settlement moved to T+1 in May 2024. A sale on Friday settles Monday for cash availability. The trade date is what counts for tax purposes; settlement date for cash."
      },
      {
        "id": "q7",
        "prompt": "Why are REITs typically held in tax-advantaged accounts rather than taxable accounts?",
        "options": [
          "REITs are riskier than other investments.",
          "REIT distributions are mostly taxed as ordinary income (not qualified dividends), making them tax-inefficient in taxable accounts.",
          "REITs are required to be held in IRAs.",
          "REITs have higher expense ratios."
        ],
        "correct": 1,
        "explanation": "REIT distributions don't qualify for the lower qualified-dividend rates. Holding them in an IRA or 401(k) shelters the ordinary-income drag. This is one of the most common asset-location moves."
      },
      {
        "id": "q8",
        "prompt": "Which best describes the difference between risk tolerance and risk capacity?",
        "options": [
          "They are the same thing.",
          "Tolerance is the emotional ability to handle volatility; capacity is the financial ability of the plan to absorb volatility. Build the portfolio to the lower of the two.",
          "Tolerance applies to bonds; capacity applies to stocks.",
          "Tolerance is for retirees; capacity is for young investors."
        ],
        "correct": 1,
        "explanation": "Tolerance and capacity can differ. A young investor may have high capacity (long horizon, income) but low tolerance (no bear-market experience). A retiree may have high tolerance but low capacity (drawdowns plus withdrawals compound badly). Build for the lower number, document the reasoning."
      },
      {
        "id": "q9",
        "prompt": "Two funds deliver identical 8% gross returns over 20 years. Fund A has a 0.04% expense ratio; Fund B has 0.85%. What's the approximate difference on a $10,000 initial investment after 20 years?",
        "options": [
          "Negligible — basis points don't matter over long periods.",
          "Roughly $6,000–$7,000.",
          "Roughly $500.",
          "Fund B wins because of active management."
        ],
        "correct": 1,
        "explanation": "Fund A: $10,000 × (1.0796)^20 ≈ $46,184. Fund B: $10,000 × (1.0715)^20 ≈ $39,499. Difference ≈ $6,685. And that assumes identical gross returns — in practice, higher-cost funds typically also have lower gross returns in the same category. Fees compound."
      },
      {
        "id": "q10",
        "prompt": "What does the Dalbar research suggest about typical investor returns?",
        "options": [
          "Investors typically beat the market by 3% annually.",
          "Investor returns are usually within 1% of market returns.",
          "Investors typically underperform the market by several percentage points annually, primarily due to behavioral mistakes — buying high, selling low, chasing performance.",
          "Investor returns are unmeasurable."
        ],
        "correct": 2,
        "explanation": "The behavioral gap — buying high, selling low, performance-chasing — typically costs the average investor 2–4% per year compared to the index they're invested in. This is the largest source of value an advisor delivers: preventing the behavior, not picking the funds."
      },
      {
        "id": "q11",
        "prompt": "Which is the most defensible default for a typical long-term investor's core portfolio?",
        "options": [
          "Single-stock concentrated bet in a high-conviction company.",
          "Diversified mix of low-cost index funds covering U.S. stocks, international stocks, and bonds, sized to the client's risk tolerance and capacity.",
          "Aggressive trading using stop-loss orders.",
          "Hedge funds and private equity."
        ],
        "correct": 1,
        "explanation": "Broad, low-cost, index-based diversification captures the bulk of available return at minimum cost. Active management, alternatives, and concentrated bets have specific use cases but should be the exception, requiring justification, not the default."
      },
      {
        "id": "q12",
        "prompt": "What is the single largest source of long-term return destruction in the typical client's lifetime?",
        "options": [
          "Market downturns.",
          "Behavioral mistakes — selling at the bottom, buying at the top, abandoning plans during stress.",
          "Inflation.",
          "Taxes."
        ],
        "correct": 1,
        "explanation": "Markets recover. Tax can be managed. Inflation is steady. Behavior is the variable that destroys plans repeatedly. The advisor's most important job is helping clients stay on the plan when staying feels bad. That's the value proposition."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 6;

-- ============================================================================
-- DONE.
-- ============================================================================

-- ── module7_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 7 CONTENT
-- Retirement Planning Foundations
-- ============================================================================

update public.modules set
  title = 'Retirement Planning Foundations',
  competency_id = 'CORE-7',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The math, accounts, and tradeoffs behind every retirement plan — accumulation, distribution, and the risks that derail both.',
  learning_objectives = ARRAY[
    'Compute a retirement income need and a corresponding nest-egg target.',
    'Compare 401(k), IRA, Roth, SEP, Solo 401(k), and SIMPLE structures and recommend the right vehicle for a given client.',
    'Explain sequence-of-returns risk and how to mitigate it near and into retirement.',
    'Apply the 4% withdrawal rule, identify its assumptions, and adapt it when those assumptions don''t fit.',
    'Articulate the Social Security claim-timing decision and its trade-offs.',
    'Build a defensible Monte Carlo-style projection or interpret one produced by planning software.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Retirement Equation",
      "summary": "Time, return, savings rate, and withdrawal — the four levers, and what they actually do.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every retirement plan reduces to four variables: how much the client saves, for how long, at what rate of return, and how much they withdraw later. Holding any three constant, the fourth is determined. A counselor's job is to make the client see which of those levers they can move, and what each move costs." },

        { "type": "callout", "kind": "key", "title": "The accumulation question", "text": "<strong>How big a nest egg does this client need, and what monthly savings rate gets them there by their target retirement age?</strong>" },

        { "type": "heading", "text": "Step 1 — Estimate retirement spending" },
        { "type": "paragraph", "text": "Start with current spending. Subtract things that disappear in retirement (commuting, work clothes, mortgage if paid off, retirement contributions themselves). Add things that may grow (healthcare before Medicare, travel, hobbies). Most clients spend roughly <strong>70–85% of their pre-retirement net spending</strong> in retirement — but the range is wide, and the only honest way to estimate is to look at their actual current spending and adjust line by line." },
        { "type": "callout", "kind": "warn", "title": "The 80% rule of thumb is too rough", "text": "Pre-retirees with high mortgage payments that will be paid off, high commuting costs, and big retirement contributions might need 60% of current income. Pre-retirees who plan extensive travel, have ongoing mortgage, or expect to support adult children might need 100%+. Do the work; don't apply the rule blindly." },

        { "type": "heading", "text": "Step 2 — Subtract guaranteed income sources" },
        { "type": "paragraph", "text": "Many clients have income streams in retirement that aren't from their portfolio:" },
        { "type": "list", "items": [
          "<strong>Social Security</strong> — covered in detail later; varies by claim age and earnings history.",
          "<strong>Pension</strong> — defined-benefit plan, often from public-sector or older private-sector employment.",
          "<strong>Annuities</strong> — purchased income streams.",
          "<strong>Rental income</strong> — net of expenses.",
          "<strong>Part-time work</strong> — many retirees continue some level of paid work, at least for the first decade."
        ]},
        { "type": "paragraph", "text": "The <strong>income gap</strong> — annual spending minus guaranteed income — is what the portfolio must cover." },

        { "type": "heading", "text": "Step 3 — Translate the gap into a nest-egg target" },
        { "type": "paragraph", "text": "The standard rule: use a <strong>safe withdrawal rate</strong> to convert annual income need into total portfolio size. A 4% withdrawal rate corresponds to multiplying annual need by 25:" },
        { "type": "list", "items": [
          "Annual gap of $40,000 → $40,000 × 25 = $1,000,000 portfolio target",
          "Annual gap of $60,000 → $60,000 × 25 = $1,500,000 portfolio target",
          "Annual gap of $100,000 → $100,000 × 25 = $2,500,000 portfolio target"
        ]},
        { "type": "callout", "kind": "note", "title": "The 4% rule's caveats", "text": "Originally derived from Bengen (1994) and Trinity Study research. Assumes a balanced portfolio, 30-year horizon, and inflation-adjusted withdrawals. Has held up reasonably across most historical periods but is not a guarantee. For longer retirements (early retirees), more conservative (3.0–3.5%). For shorter (late retirees), can be higher. Detailed treatment later in the module." },

        { "type": "heading", "text": "Step 4 — Back into a savings rate" },
        { "type": "paragraph", "text": "Given current savings, years to retirement, and expected return, compute the monthly contribution required to hit the target. Use the future-value-of-an-annuity formula from Module 2, or a financial calculator." },

        { "type": "case_study",
          "title": "Walking through Marcus and Tasha",
          "scenario": "Marcus and Tasha, early 40s, want to retire at 65. Current household spending: $108,000/year ($9,000/month). Expected retirement spending: ~$90,000/year (mortgage gone, no work expenses, slightly more travel). Combined Social Security at 67 estimated at $50,000/year. Current retirement savings: $250,000. Current combined retirement contributions: $1,800/month.",
          "discussion": "<p><strong>Income gap in retirement:</strong> $90,000 spending − $50,000 SS = $40,000 from portfolio.</p><p><strong>Nest egg target:</strong> $40,000 × 25 = $1,000,000 (in today's dollars).</p><p><strong>Years to retirement:</strong> 23 (from age 42 to 65).</p><p><strong>Projection at current pace:</strong> $250,000 grows for 23 years at 7% real = ~$1,180,000. Plus contributions of $1,800/month for 23 years at 7% = ~$1,140,000. Total: ~$2,320,000 (in today's dollars). <strong>They are comfortably on track</strong> if those assumptions hold.</p><p>This is the kind of analysis that turns a 'we want to save more' goal into a defensible plan. The numbers say they don't need to save more — they need to <em>not screw it up</em>: stay invested through downturns, manage health-related risks, get insurance right, avoid lifestyle creep that pushes retirement spending past $90K.</p>"
        }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Retirement Accounts: The Vehicles",
      "summary": "Workplace plans, IRAs, self-employed plans — what fits whom and why.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax-advantaged retirement accounts are the structural foundation of nearly every retirement plan. Knowing the rules — contribution limits, eligibility, withdrawal terms — well enough to recommend the right vehicle is core competence." },

        { "type": "heading", "text": "Workplace plans" },

        { "type": "subheading", "text": "401(k) and 403(b)" },
        { "type": "paragraph", "text": "Workplace defined-contribution plans. 401(k) is private sector; 403(b) is nonprofit and education. Mechanically very similar. Employee contributions are pre-tax (Traditional) or after-tax (Roth, if offered). Employer match is common." },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: $23,500 employee. Catch-up $7,500 if age 50+. New super catch-up of about $11,250 for ages 60–63 under SECURE 2.0.",
          "<strong>Employer match</strong>: free money. Capture the full match before anything else.",
          "<strong>Vesting</strong>: employer contributions may have a vesting schedule (typically 3–6 years to fully vest). Important for clients considering a job change.",
          "<strong>Investment menu</strong>: limited to the plan's selected fund lineup. Quality varies enormously by employer.",
          "<strong>Withdrawals before 59½</strong>: generally subject to ordinary income tax plus 10% penalty. Exceptions exist (rule of 55 if separating from service)."
        ]},

        { "type": "subheading", "text": "457(b)" },
        { "type": "paragraph", "text": "State and local government, plus some nonprofits. Similar to 401(k) with two important differences: no 10% early-withdrawal penalty after separation from service at any age, and contributions can be stacked with 401(k) for clients with access to both (e.g., teachers in some states)." },

        { "type": "subheading", "text": "TSP (Thrift Savings Plan)" },
        { "type": "paragraph", "text": "Federal employees and uniformed services. Among the lowest-cost workplace plans in existence. Treats Traditional and Roth contributions similarly to private-sector 401(k)." },

        { "type": "divider" },

        { "type": "heading", "text": "Individual retirement accounts" },

        { "type": "subheading", "text": "Traditional IRA" },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: $7,000 ($8,000 if 50+).",
          "<strong>Deductibility</strong>: full deduction if neither spouse is covered by a workplace plan. Phaseout if covered: $79K–$89K single, $126K–$146K MFJ (2024 figures, approximate; check current).",
          "<strong>Tax treatment</strong>: deductible contribution (if eligible), tax-deferred growth, taxable withdrawals as ordinary income."
        ]},

        { "type": "subheading", "text": "Roth IRA" },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: same as Traditional — $7,000 ($8,000 if 50+).",
          "<strong>Income limits</strong>: contribution phases out at $150K–$165K single, $236K–$246K MFJ (2025 approximate).",
          "<strong>Tax treatment</strong>: after-tax contribution, tax-free growth, tax-free qualified withdrawals.",
          "<strong>Contribution withdrawal</strong>: contributions (not earnings) can be withdrawn at any time, tax- and penalty-free. This makes the Roth IRA quietly liquid.",
          "<strong>No RMDs</strong> during the original owner's lifetime."
        ]},
        { "type": "callout", "kind": "key", "title": "The backdoor Roth", "text": "Clients above the Roth IRA income limit can still effectively contribute by: (1) making a nondeductible Traditional IRA contribution, (2) immediately converting to Roth. As long as the client has no other pre-tax IRA balances (the pro-rata rule), the conversion is largely tax-free. Legal as of this writing; worth executing for high earners." },

        { "type": "heading", "text": "Self-employed plans" },

        { "type": "subheading", "text": "SEP-IRA" },
        { "type": "paragraph", "text": "Simplified Employee Pension. Employer-only contributions up to about 25% of compensation, capped at $70,000 (2025). Cheap and easy to administer. Best for solo self-employed or very small businesses with no employees." },

        { "type": "subheading", "text": "Solo 401(k)" },
        { "type": "paragraph", "text": "For self-employed with no employees other than a spouse. Combines employee contributions (same $23,500 limit as workplace 401(k)) with employer profit-sharing (up to ~25% of compensation), total capped at about $70,000. Often offers higher contribution capacity than SEP at the same income level. Many Solo 401(k)s now offer Roth contributions and a mega backdoor Roth strategy." },

        { "type": "subheading", "text": "SIMPLE IRA" },
        { "type": "paragraph", "text": "For small employers (under 100 employees). Lower contribution limit ($16,000 in 2025 plus $3,500 catch-up). Required employer match or contribution. Less common; SEP and 401(k) generally preferred when feasible." },

        { "type": "callout", "kind": "do", "title": "The matching framework", "text": "<strong>W-2 employee with workplace 401(k):</strong> contribute at least up to the match, then maximize Roth IRA, then increase 401(k) toward the limit. <strong>Self-employed with no employees:</strong> Solo 401(k) typically optimal. <strong>Self-employed with employees:</strong> SEP-IRA for simplicity if employees are few, regular 401(k) if practical to administer. <strong>Government employee:</strong> 457(b) plus IRA for tax diversification; TSP if federal." },

        { "type": "divider" },

        { "type": "heading", "text": "Rollovers and consolidation" },
        { "type": "paragraph", "text": "When clients leave jobs, their workplace plans can be rolled to an IRA without tax. Common counselor work:" },
        { "type": "list", "items": [
          "<strong>401(k) to IRA rollover</strong> — direct rollover preferred (the money moves trustee-to-trustee without coming to the client). Avoids withholding and potential 60-day-rollover headaches.",
          "<strong>Roth 401(k) to Roth IRA</strong> — also tax-free.",
          "<strong>When to leave it</strong> — sometimes the old 401(k) has better/cheaper funds, creditor protection, or an in-service rollover restriction that means it can't be moved. Audit before recommending rollover.",
          "<strong>Backdoor Roth complications</strong> — clients executing backdoor Roth need to keep pretax IRA balances at zero. Rolling an old 401(k) into a Traditional IRA can ruin their backdoor Roth strategy. Sometimes the right move is rolling 401(k) into a current 401(k), or leaving it."
        ]}
      ]
    },

    {
      "id": "lesson-3",
      "title": "Sequence-of-Returns Risk",
      "summary": "Why the order of good and bad years matters — and what to do about it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two retirees can have identical average returns over their retirement years and dramatically different outcomes. The difference is when the bad years happen. Bad years early in retirement, while the portfolio is being drawn down, are devastating. The same bad years late in retirement are almost harmless." },

        { "type": "callout", "kind": "key", "title": "The core mechanic", "text": "When the portfolio is in <em>accumulation</em>, a downturn is opportunity — contributions buy more shares at lower prices. When the portfolio is in <em>distribution</em>, a downturn is destruction — withdrawals lock in losses, leaving less to recover when markets rebound." },

        { "type": "heading", "text": "The numerical demonstration" },
        { "type": "paragraph", "text": "Two retirees, each with $1 million, withdrawing $50,000/year, retiring with average annual return of 7% over the retirement period." },

        { "type": "subheading", "text": "Retiree A — bad returns at the start" },
        { "type": "list", "items": [
          "Year 1: −20% return. Portfolio: $1,000,000 × 0.80 − $50,000 = $750,000.",
          "Year 2: −10% return. Portfolio: $750,000 × 0.90 − $50,000 = $625,000.",
          "Years 3–30: average ~9% per year recovery.",
          "Roughly 25 years before the portfolio depletes."
        ]},

        { "type": "subheading", "text": "Retiree B — bad returns at the end" },
        { "type": "list", "items": [
          "Years 1–28: average ~9% per year.",
          "Year 29: −20% return.",
          "Year 30: −10% return.",
          "Portfolio still has substantial balance at age 95."
        ]},

        { "type": "paragraph", "text": "Same average return. Same withdrawals. Very different outcomes. This is sequence-of-returns risk." },

        { "type": "callout", "kind": "warn", "title": "When the risk is highest", "text": "The five years before retirement and the first ten years of retirement are the danger zone. A bear market in this window can permanently damage a retiree's portfolio — there's no time to wait it out without withdrawing during the trough." },

        { "type": "heading", "text": "Mitigating the risk" },

        { "type": "subheading", "text": "1. Glide path — reduce equity exposure entering retirement" },
        { "type": "paragraph", "text": "Most target-date funds reduce equity allocation as the target date approaches. By age 65, a typical target-date fund might hold 50–60% stocks and 40–50% bonds. Less aggressive = less drawdown risk in the danger zone." },

        { "type": "subheading", "text": "2. Cash reserves and the bucket strategy" },
        { "type": "paragraph", "text": "Hold 1–3 years of expenses in cash. In a downturn, draw from cash rather than selling equities at depressed prices. Refill the cash bucket from equities in good years. Some advisors expand this to three buckets: cash (1–2 years), bonds (next 3–7 years), stocks (8+ years)." },

        { "type": "subheading", "text": "3. Flexible withdrawals" },
        { "type": "paragraph", "text": "The 4% rule assumes fixed real withdrawals regardless of market conditions. In practice, retirees who reduce spending in bear-market years (skip the big vacation, postpone the new car) significantly increase plan durability. Even a 10–15% temporary spending reduction has outsize effect." },

        { "type": "subheading", "text": "4. Guaranteed income floor" },
        { "type": "paragraph", "text": "If Social Security, pension, and (sometimes) a single-premium immediate annuity (SPIA) cover essential expenses, the portfolio only needs to fund discretionary spending. The retiree can absorb portfolio drawdowns without changing their basic standard of living." },

        { "type": "subheading", "text": "5. Delay retirement or work part-time" },
        { "type": "paragraph", "text": "Working one extra year, or part-time for several years, reduces the years of withdrawal needed and shrinks the sequence-risk window. For retirees willing and able, this is the most powerful mitigation available." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "A 2008 retiree",
          "scenario": "A retiree who retired in late 2007 with $1 million in a 60/40 portfolio and a 4% withdrawal rate watched the portfolio drop nearly 30% by early 2009 while still drawing $40,000/year. How does this play out?",
          "discussion": "<p>At the trough, the portfolio is well below $700,000. Continuing $40,000 withdrawals is now ~6% of the depressed portfolio — a much higher real withdrawal rate than the 4% rule assumes. If the retiree maintained the withdrawal schedule rigidly, the plan has a meaningful probability of failure across the full 30-year retirement.</p><p>Mitigations that saved many such retirees: (1) flexibility — reducing spending during 2008–2010 by 10–20%; (2) cash buffers — drawing from cash rather than equities during the worst years; (3) Social Security being available to cushion the gap; (4) recovery — markets rebounded substantially by 2013, and a portfolio that survived to 2013 was largely restored.</p><p>The structural lesson: <strong>build flexibility into the plan up front</strong>. The retiree who locks in fixed real withdrawals and never reduces spending is most exposed to sequence risk. The retiree who built a cash buffer, kept some equity exposure, and is willing to flex spending almost always comes out the other side.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Social Security: Timing and Trade-offs",
      "summary": "The decision most clients make poorly, and the analysis that gets it right.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Social Security claim timing is one of the most consequential single decisions a retiree makes. Claim at 62 and benefits are permanently reduced. Claim at full retirement age (currently 67 for most clients) and you get the baseline benefit. Wait until 70 and benefits are permanently increased. The math, and a few often-missed structural considerations, decide the right answer." },

        { "type": "heading", "text": "The basic math" },
        { "type": "paragraph", "text": "Each year of delay between age 62 and full retirement age increases the benefit by roughly 6–7% per year. Each year of delay beyond FRA up to age 70 adds an additional 8% per year. The total difference between claiming at 62 and claiming at 70 is roughly <strong>76% more lifetime monthly benefit</strong>." },

        { "type": "subheading", "text": "Approximate benefit at each age" },
        { "type": "list", "items": [
          "<strong>Claim at 62</strong>: ~70% of full benefit (early-claim reduction of 30%)",
          "<strong>Claim at 67 (FRA for most current clients)</strong>: 100% of full benefit",
          "<strong>Claim at 70</strong>: ~124% of full benefit (delayed-retirement credits)"
        ]},

        { "type": "callout", "kind": "key", "title": "The break-even age", "text": "Compare cumulative benefits. Claiming early gives more checks earlier; claiming later gives larger checks. Break-even between claiming at 62 vs. 67 is typically around age 78–79. Break-even between 67 vs. 70 is typically around age 82–83. <strong>Clients who expect to live past these ages are mathematically better off waiting. Clients who don't, aren't.</strong>" },

        { "type": "heading", "text": "Factors that argue for claiming earlier" },
        { "type": "list", "items": [
          "<strong>Health</strong> — serious health issues, low expected longevity.",
          "<strong>Need</strong> — no other income, can't afford to wait.",
          "<strong>Spousal coordination</strong> — sometimes one spouse claims early to provide income while the other delays.",
          "<strong>Behavioral</strong> — some clients value the certainty of income they receive over a larger income they might not live to collect."
        ]},

        { "type": "heading", "text": "Factors that argue for claiming later" },
        { "type": "list", "items": [
          "<strong>Longevity</strong> — family history of long life, current good health.",
          "<strong>Higher-earning spouse</strong> — delaying the higher earner's benefit also increases the surviving spouse's benefit after the first death (survivor benefit is based on the higher earner's claim).",
          "<strong>Tax planning</strong> — delaying Social Security creates room for Roth conversions in the meantime at low rates.",
          "<strong>Longevity insurance</strong> — Social Security is the cheapest longevity insurance available. Higher benefits in the years a retiree is most likely to need them are structurally valuable."
        ]},

        { "type": "callout", "kind": "do", "title": "The default for healthy clients", "text": "For most healthy clients with adequate resources to bridge the gap, delaying Social Security — at least to FRA, and often to 70 — is the right default. The higher inflation-adjusted income later in life is structurally valuable, and it's the cheapest longevity insurance available. Document when departing from this default and why." },

        { "type": "divider" },

        { "type": "heading", "text": "Spousal and survivor benefits" },
        { "type": "list", "items": [
          "<strong>Spousal benefit</strong>: at FRA, equals up to 50% of the spouse's primary insurance amount (PIA). Available even if the lower-earning spouse never worked.",
          "<strong>Survivor benefit</strong>: equals 100% of the deceased spouse's benefit at the time of death (or what it would have been at FRA if they died before claiming). The surviving spouse gets the higher of the two benefits — not both.",
          "<strong>Divorced spouse benefit</strong>: marriage lasted at least 10 years, current unmarried, ex-spouse is at least 62. Up to 50% of ex's PIA. Doesn't affect ex-spouse's benefit."
        ]},

        { "type": "heading", "text": "Working while claiming" },
        { "type": "paragraph", "text": "Claiming before FRA while still working triggers earnings-test reductions: $1 of benefit withheld for every $2 of earnings above an annual exempt amount (~$23,400 in 2025). The amount returns to you later in higher benefits at FRA, but in the meantime, claiming-while-working can reduce or eliminate the check entirely. Often a reason to delay." },

        { "type": "case_study",
          "title": "Two-earner couple, planning Social Security",
          "scenario": "Both spouses are 64, both worked similar careers, both have estimated FRA benefits of about $30,000/year. Combined retirement spending need: $90,000/year. Portfolio: $1.5M. Both in good health, family longevity into mid-80s.",
          "discussion": "<p>Several reasonable strategies:</p><p><strong>Both delay to 70</strong> — maximizes lifetime benefit (~$48K each at age 70). Requires bridge income from portfolio for 6 years. Best longevity insurance. Best survivor benefit. Default for two healthy spouses.</p><p><strong>One claims early, one delays</strong> — provides some income immediately, larger benefit later. Often used when one spouse has health concerns.</p><p><strong>Both claim at FRA</strong> — middle ground. Avoids the cost of delay for those uncomfortable bridging from portfolio.</p><p>For this couple, recommendation depends on tolerance for portfolio drawdown in the bridge years and view on longevity. Default: delay both. Document the reasoning. Revisit if health or markets change materially.</p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Distribution Phase",
      "summary": "Drawing the money down — withdrawal rates, tax sequencing, and managing the spend.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Accumulation gets the attention; distribution is harder. Once a client retires, the questions get more complex: how much can they safely spend, in what order do they draw from accounts, when do they take RMDs, how do they manage taxes across the rest of their life? Distribution is where the planning shifts from saving to deploying." },

        { "type": "heading", "text": "Safe withdrawal rates" },
        { "type": "paragraph", "text": "The 4% rule (covered earlier) remains the most-cited starting point. Refinements:" },
        { "type": "list", "items": [
          "<strong>Retirement length matters.</strong> 4% works for 30-year retirements. For 40+ year retirements (early retirees), drop to 3.0–3.5%.",
          "<strong>Portfolio composition matters.</strong> 4% assumes a diversified stock/bond portfolio. Too conservative (all bonds) supports lower withdrawals; too aggressive (all stocks) is volatile.",
          "<strong>Flexibility increases safe rate.</strong> A retiree willing to reduce spending in bad years can sustainably withdraw 4.5–5%.",
          "<strong>Guaranteed income reduces portfolio strain.</strong> If Social Security + pension cover 50% of spending, the portfolio is supporting less of the burden and effective rates are different."
        ]},

        { "type": "heading", "text": "Withdrawal sequencing" },
        { "type": "paragraph", "text": "When a retiree has multiple account types — taxable, traditional, Roth — the order of withdrawal materially affects total taxes paid over retirement. The conventional ordering (with significant nuance):" },
        { "type": "numbered", "items": [
          "<strong>Required minimum distributions first.</strong> RMDs from traditional accounts are mandatory starting at 73 (rising to 75 by 2033). Penalty for missing is harsh. Take them.",
          "<strong>Taxable accounts next.</strong> Each year, sell long-term holdings as needed to fill the spending gap. Take advantage of low LTCG brackets when total income is modest. Use tax-loss harvesting to offset gains.",
          "<strong>Traditional IRA/401(k) before Roth.</strong> Generally. The reasoning: traditional withdrawals are taxed; Roth withdrawals aren't. Burning through traditional first uses up your bracket capacity at moderate rates rather than letting it grow into RMDs at potentially higher rates.",
          "<strong>Roth last.</strong> Roth grows tax-free and has no RMDs. Letting it grow as long as possible maximizes tax-free wealth. Also: Roth is the most beneficiary-friendly asset to leave to heirs."
        ]},
        { "type": "callout", "kind": "warn", "title": "The conventional ordering is not always right", "text": "For some clients — especially those with very large traditional balances facing massive future RMDs — partial Roth conversions during the bridge years (early retirement, before Social Security and RMDs) are more valuable than strictly following conventional ordering. The right answer depends on bracket math at every age. Planning software helps, but the advisor's job is checking the model against reality." },

        { "type": "heading", "text": "Tax considerations through retirement" },
        { "type": "list", "items": [
          "<strong>Pre-Social Security, pre-RMD window (e.g., 65–72)</strong>: often the lowest-tax years of retirement. Excellent window for Roth conversions and capital gains realization in the 0% LTCG bracket.",
          "<strong>Post-RMD (age 73+)</strong>: traditional withdrawals plus Social Security plus pensions pile up income. Higher brackets. Less planning flexibility.",
          "<strong>Survivor years</strong>: when one spouse passes, surviving spouse files single — brackets compress sharply. Marginal rates can jump even though income hasn't changed. Plan ahead with Roth conversions while both spouses are alive."
        ]},

        { "type": "heading", "text": "Medicare and IRMAA" },
        { "type": "paragraph", "text": "At 65, clients enroll in Medicare. Premiums have a tiered structure based on income (IRMAA — Income-Related Monthly Adjustment Amount). High-income retirees pay more, sometimes dramatically more, for Medicare Part B and Part D." },
        { "type": "list", "items": [
          "IRMAA looks at modified AGI from <em>two years prior</em> (2025 premiums based on 2023 income).",
          "Roth conversions, large capital gains, and one-time income events can spike a year's income and trigger higher premiums two years later.",
          "Cliffs exist at specific income thresholds — being $1 over a threshold can cost $1,000+ in higher annual premiums.",
          "Form SSA-44 allows appeal of IRMAA for life-changing events (retirement itself qualifies)."
        ]},
        { "type": "callout", "kind": "do", "title": "The plan that doesn't surprise the client", "text": "Map IRMAA brackets onto the retirement plan from day one. Coordinate Roth conversions, Social Security timing, and capital gains realization to manage AGI around the brackets. Many retirees discover the cost of IRMAA only after they've triggered it — the advisor's job is to see it coming and adjust." },

        { "type": "divider" },

        { "type": "heading", "text": "Monte Carlo and the projection question" },
        { "type": "paragraph", "text": "Most retirement planning software now runs <strong>Monte Carlo simulations</strong> — generating hundreds or thousands of randomized return sequences to estimate the probability that a given plan succeeds. A 'success rate' of 85% means the plan worked in 85% of simulated paths." },
        { "type": "callout", "kind": "note", "title": "What success rate to aim for", "text": "100% is typically too conservative — it forces unnecessarily low spending. 50% is too aggressive — too high a failure risk. Most planners target 75–90% success. Lower success rates can be appropriate when (1) the retiree has flexibility to reduce spending if needed, (2) there are non-portfolio resources to fall back on, (3) the alternative is unacceptable scrimping in retirement." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A client has annual retirement spending of $80,000, expected Social Security of $30,000, and no pension. What's the rough nest-egg target using the 4% rule?",
        "options": [
          "$500,000",
          "$1,250,000",
          "$2,000,000",
          "$3,200,000"
        ],
        "correct": 1,
        "explanation": "Income gap: $80,000 − $30,000 = $50,000. Nest egg = $50,000 × 25 = $1,250,000. The portfolio must support only the gap between spending and guaranteed income, not the full spending number."
      },
      {
        "id": "q2",
        "prompt": "What is sequence-of-returns risk?",
        "options": [
          "The risk that returns will be negative on average.",
          "The risk that the ORDER of returns (bad years early in retirement while withdrawing) damages a portfolio far more than the same returns occurring later.",
          "The risk that returns vary year to year.",
          "The risk that the client doesn't follow the plan."
        ],
        "correct": 1,
        "explanation": "Two retirees with the same average return can have very different outcomes depending on when the bad years happen. Withdrawals during a drawdown lock in losses and reduce the base from which the portfolio can recover. Bad years early are far more damaging than bad years late."
      },
      {
        "id": "q3",
        "prompt": "Roughly how much larger is a Social Security benefit if claimed at 70 vs. 62?",
        "options": [
          "About 10% larger",
          "About 30% larger",
          "About 76% larger",
          "About 200% larger"
        ],
        "correct": 2,
        "explanation": "Claim at 62 = ~70% of full benefit. Claim at 70 = ~124% of full benefit. 124/70 ≈ 1.77 — about 76% more lifetime monthly income for the patient claimant."
      },
      {
        "id": "q4",
        "prompt": "Which is the strongest reason a healthy client with adequate bridge resources should consider delaying Social Security past full retirement age?",
        "options": [
          "Tax advantages of delaying are large.",
          "Higher benefits are inflation-adjusted and represent the cheapest longevity insurance available; for higher-earning spouse, also raises the survivor benefit.",
          "It's required by law for high earners.",
          "Markets will be lower then."
        ],
        "correct": 1,
        "explanation": "Delayed-retirement credits add ~8% per year of inflation-adjusted lifetime income — extraordinarily valuable longevity insurance. For couples, the higher earner's delay also raises the survivor benefit, protecting the longer-living spouse."
      },
      {
        "id": "q5",
        "prompt": "What is the conventional withdrawal sequencing in retirement (after RMDs)?",
        "options": [
          "Roth → Traditional → Taxable",
          "Taxable → Traditional → Roth",
          "All accounts proportionally each year",
          "Traditional → Taxable → Roth"
        ],
        "correct": 1,
        "explanation": "Conventional: required minimums first, then taxable, then traditional, then Roth. Taxable funds use lower-rate LTCG brackets, traditional uses up bracket capacity at moderate rates, Roth grows tax-free as long as possible. Not always the optimal — Roth conversions in the bridge years often improve on this."
      },
      {
        "id": "q6",
        "prompt": "Why is the early-retirement, pre-RMD window so valuable for tax planning?",
        "options": [
          "Brackets are lower than they'll be later when Social Security and RMDs both fill them. Excellent window for Roth conversions and realizing capital gains at low rates.",
          "Tax rates are temporarily lower by law.",
          "The IRS doesn't audit during this period.",
          "It's the only time Roth conversions are legal."
        ],
        "correct": 0,
        "explanation": "Early retirement before Social Security, before RMDs, can be the lowest-tax window of a client's lifetime. Use it to do Roth conversions, harvest gains in the 0% LTCG bracket, and reduce future tax pressure."
      },
      {
        "id": "q7",
        "prompt": "What is IRMAA?",
        "options": [
          "An IRS retirement account.",
          "Medicare's Income-Related Monthly Adjustment Amount — higher-income retirees pay higher Medicare Part B and Part D premiums; looks at AGI from two years prior.",
          "An annuity product.",
          "A type of Social Security benefit."
        ],
        "correct": 1,
        "explanation": "IRMAA tiers Medicare premiums by income, using AGI from two years prior. Roth conversions, capital gains, and large one-time income events can spike a year's MAGI and trigger higher premiums two years later. Cliffs exist — $1 over a threshold can cost $1,000+ annually."
      },
      {
        "id": "q8",
        "prompt": "What's the right move for a client who has both a workplace 401(k) match and is otherwise on the fence about contributions?",
        "options": [
          "Skip the 401(k) and contribute to an IRA instead.",
          "Always contribute at least up to the full employer match — it's an immediate guaranteed return that almost always outranks other priorities.",
          "Wait until pay raises arrive.",
          "Use a Roth IRA only."
        ],
        "correct": 1,
        "explanation": "The match is free money — typically a 50% or 100% return on contributions up to a cap. Almost no other use of those dollars produces a comparable risk-free return. Capture the match first; everything else is secondary."
      },
      {
        "id": "q9",
        "prompt": "What is the backdoor Roth, and who uses it?",
        "options": [
          "An illegal tax shelter.",
          "A two-step process — make a nondeductible Traditional IRA contribution, then convert to Roth — that effectively allows high earners (above the Roth income limit) to contribute to a Roth.",
          "A Roth IRA available only to government employees.",
          "An emergency-withdrawal feature."
        ],
        "correct": 1,
        "explanation": "Legal as of this writing. Critical caveat: only works cleanly if the client has no other pretax IRA balances (the pro-rata rule). Common move for high earners; should be checked annually against current tax law."
      },
      {
        "id": "q10",
        "prompt": "A retiree's portfolio drops 25% in the first year of retirement. They are still drawing the originally planned $50K/year. What is the best advisor move?",
        "options": [
          "Sell stocks immediately to reduce risk.",
          "Have an honest conversation about flexibility — temporarily reducing withdrawals or drawing from cash reserves rather than depressed equities. Sequence-of-returns risk is acute right now.",
          "Reassure the client that returns will average out.",
          "Recommend buying more stocks at the dip."
        ],
        "correct": 1,
        "explanation": "Sequence risk is most acute in the first decade of retirement. Flexibility (reducing spending, drawing from cash) preserves the portfolio for recovery. Selling equities into the depressed market and replacing with bonds locks in losses. Reassurance alone misses the structural risk."
      },
      {
        "id": "q11",
        "prompt": "What is the bucket strategy in retirement planning?",
        "options": [
          "Diversifying across multiple investment platforms.",
          "Holding cash/short-term assets for near-term spending and longer-duration assets for later spending — so a market drop doesn't force selling equities at depressed prices.",
          "Holding only one asset class.",
          "Spreading withdrawals across the calendar year."
        ],
        "correct": 1,
        "explanation": "The classic three-bucket: cash (1–2 years of spending), bonds (next 3–7 years), stocks (8+ years). In a downturn, draw from cash and bonds; let stocks recover. Refill the cash bucket from stocks in good years. Mitigates sequence risk structurally."
      },
      {
        "id": "q12",
        "prompt": "What is a reasonable target for Monte Carlo simulation 'success rate' in a retirement plan?",
        "options": [
          "100% — anything less is too risky.",
          "50% — coin flip is fine.",
          "75–90% — high enough to be confident, low enough to avoid unnecessary spending restrictions.",
          "Success rates are meaningless."
        ],
        "correct": 2,
        "explanation": "100% can force unrealistically low spending. 50% is too risky. Most planners target 75–90%, lower when retirees have flexibility to adapt if results trail expectation. Always pair the number with a plan for what changes if the projection trends bad."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 7;

-- ============================================================================
-- DONE.
-- ============================================================================

-- ── module8_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 8 CONTENT
-- Estate Planning & Wealth Transfer
-- ============================================================================
update public.modules set
  title = 'Estate Planning & Wealth Transfer',
  competency_id = 'CORE-8',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How families move wealth across generations and across moments of crisis. Wills, trusts, powers of attorney, beneficiaries, and the documents that matter when something goes wrong.',
  learning_objectives = ARRAY[
    'Distinguish probate from non-probate assets and explain why this drives most estate planning.',
    'Identify the four core documents every adult should have, regardless of net worth.',
    'Distinguish revocable from irrevocable trusts and articulate when each is the right tool.',
    'Explain why beneficiary designations override wills and how to audit them.',
    'Articulate the basics of federal estate, gift, and generation-skipping taxes at current thresholds.',
    'Coordinate with an estate planning attorney effectively without practicing law.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Estate Planning Is Not Just for the Wealthy",
      "summary": "The four documents every adult needs, and what happens when they don't have them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Estate planning is one of the most over-postponed conversations in personal finance. Clients hear \"estate\" and think \"rich people problem\" — and so the documents that protect a family in a crisis go unwritten. A Wealth Solutions Counselor's job is to translate: this is not about taxes for most clients, it's about <em>what happens when something goes wrong</em>." },

        { "type": "callout", "kind": "key", "title": "The four core documents", "text": "<strong>(1) Will</strong>, <strong>(2) Durable power of attorney for finances</strong>, <strong>(3) Healthcare power of attorney / advance directive</strong>, <strong>(4) HIPAA authorization</strong>. Every adult — regardless of net worth — should have all four. Cost via an estate attorney: typically $500–$2,500 for a basic plan. Cost of not having them: incalculable when needed." },

        { "type": "heading", "text": "What happens without a will (intestacy)" },
        { "type": "paragraph", "text": "If a person dies without a will, state law decides who inherits. The state's default rules are called <strong>intestacy laws</strong>, and they rarely match what the deceased would have wanted." },
        { "type": "list", "items": [
          "Surviving spouse may share inheritance with parents or siblings of the deceased, depending on state and whether there are children.",
          "If there are children from prior relationships, the surviving spouse may share with stepchildren.",
          "Unmarried partners typically inherit nothing under intestacy.",
          "Minor children's inheritance is held by court-appointed conservators, often with high court costs.",
          "The state appoints a guardian for minor children — without input from the parents."
        ]},
        { "type": "callout", "kind": "warn", "title": "The argument that ends the conversation", "text": "\"If you die without a will, the state writes one for you — and they don't know your family.\" That sentence often opens the door for clients who've been avoiding the topic for years." },

        { "type": "heading", "text": "The four documents in plain language" },
        { "type": "subheading", "text": "Will" },
        { "type": "paragraph", "text": "Directs distribution of <em>probate</em> assets at death. Names an executor to settle the estate. Names guardians for minor children. Doesn't override beneficiary designations or jointly owned property — more on that in the next lesson." },

        { "type": "subheading", "text": "Durable power of attorney for finances" },
        { "type": "paragraph", "text": "Names someone (an \"agent\" or \"attorney-in-fact\") to manage finances if the principal becomes incapacitated. \"Durable\" means it survives incapacity (the entire point — a non-durable POA terminates when the principal can't make decisions). Critical for: paying bills, managing investments, dealing with the IRS, handling real estate, and a hundred other tasks the household needs done when someone is unable to do them." },

        { "type": "subheading", "text": "Healthcare power of attorney" },
        { "type": "paragraph", "text": "Names someone to make medical decisions when the principal can't. Often paired with an <strong>advance directive</strong> (also called a living will) that specifies preferences for end-of-life care, life support, organ donation. Without these documents, family members fight over medical decisions or hospitals follow defaults that may not match the patient's wishes." },

        { "type": "subheading", "text": "HIPAA authorization" },
        { "type": "paragraph", "text": "Federal medical privacy law (HIPAA) restricts who can receive a patient's health information. A HIPAA authorization tells providers it's OK to share the patient's medical information with named individuals — usually the agents under the healthcare POA. Without it, even spouses can be told \"I can't discuss the patient with you.\"" },

        { "type": "callout", "kind": "do", "title": "The minimum-viable estate plan", "text": "Will + durable POA + healthcare POA/advance directive + HIPAA authorization. These four documents take care of the structural risks for most clients. More sophisticated planning (trusts, advanced tax strategies) builds on top — but starts with the core four." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Probate, Beneficiaries, and How Assets Actually Transfer",
      "summary": "Why the beneficiary designation on a 401(k) overrides everything in the will.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "One of the most expensive misunderstandings in personal finance is the belief that a will controls everything. It doesn't. Knowing exactly what transfers <em>by</em> the will and what transfers <em>around</em> the will is the difference between an estate plan that works and one that explodes." },

        { "type": "heading", "text": "Probate vs. non-probate" },
        { "type": "glossary", "terms": [
          { "term": "Probate", "definition": "The court-supervised process of validating a will, paying debts and taxes, and distributing remaining assets. Public, can take 6 months to 2+ years, costs typically 3–7% of estate value." },
          { "term": "Probate assets", "definition": "Assets that pass through the will and through probate. Examples: individually-owned bank accounts without payable-on-death designations, individually-owned vehicles, real estate held solely in the decedent's name, personal property." },
          { "term": "Non-probate assets", "definition": "Assets that pass outside the will, by their own legal mechanism. They transfer faster, more privately, and sometimes more cheaply — but only if set up correctly." }
        ]},

        { "type": "heading", "text": "The four ways non-probate assets transfer" },
        { "type": "numbered", "items": [
          "<strong>Beneficiary designation</strong> — retirement accounts (401(k), IRA, Roth IRA), life insurance, annuities. Goes directly to the named beneficiary at death, bypassing the will entirely.",
          "<strong>Joint ownership with right of survivorship</strong> — bank accounts, real estate, vehicles. Surviving owner immediately becomes sole owner.",
          "<strong>Transfer-on-death (TOD) / Payable-on-death (POD) designation</strong> — many states allow these on brokerage accounts, bank accounts, even real estate. Functions like a beneficiary designation.",
          "<strong>Trust ownership</strong> — assets owned by a trust transfer according to the trust document, not by will. Major reason to use a revocable living trust."
        ]},

        { "type": "callout", "kind": "key", "title": "The rule that saves families", "text": "<strong>Beneficiary designations override wills.</strong> Always. If the will leaves everything to the second spouse but the 401(k) still names the first spouse as beneficiary, the 401(k) goes to the first spouse. This has destroyed countless second marriages' financial plans. Auditing beneficiary designations is one of the most important things an advisor can do annually." },

        { "type": "subheading", "text": "What to audit on beneficiary designations" },
        { "type": "list", "items": [
          "Every retirement account: 401(k), 403(b), IRA, Roth IRA, SEP, SIMPLE.",
          "Every life insurance policy — employer-provided AND individual.",
          "Annuities of every kind.",
          "HSAs.",
          "Brokerage accounts with TOD designations.",
          "Bank accounts with POD designations."
        ]},
        { "type": "subheading", "text": "What to check for each" },
        { "type": "list", "items": [
          "Is there a primary beneficiary?",
          "Is there a contingent beneficiary in case the primary dies first?",
          "Are the beneficiaries the right people for the current life situation? (Common errors: ex-spouses, deceased parents, minor children listed directly.)",
          "Are the percentages adding to 100%?",
          "Are spouses properly named (with full legal name, date of birth, and SSN if required)?"
        ]},

        { "type": "callout", "kind": "warn", "title": "The ex-spouse trap", "text": "After divorce, retirement accounts and life insurance still name the ex as beneficiary in a stunning percentage of cases. Some states have laws that automatically revoke ex-spouse designations on divorce, but those laws don't apply to federally-regulated plans (like 401(k)s) — federal law preempts. Result: ex-spouse legally inherits, regardless of what the will or divorce decree says. Every divorce should trigger a beneficiary audit." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The blended family disaster",
          "scenario": "Marcus (from prior modules, now imagining a remarriage scenario) divorced his first wife and remarried Tasha. He updated his will to leave everything to Tasha and his two children. He died unexpectedly. His will was clean. His 401(k) still named his first wife as primary beneficiary — he'd never updated it after the divorce.",
          "discussion": "<p>The $340,000 401(k) goes to the first wife. By law. There's no provision for the surviving family to challenge it successfully — the beneficiary designation is contractually binding on the plan administrator.</p><p>Tasha inherits the house (jointly titled), the cars, the bank accounts (which had her as a co-owner or POD beneficiary), and the rest of the will-controlled assets — but the largest single asset, the retirement account, is gone to someone he hadn't lived with in 12 years.</p><p>This story is not rare. The advisor who, in a routine annual review, asks \"can we pull up your beneficiary designations and confirm they're current?\" is doing structural risk management that quietly prevents these disasters. <strong>That is what this profession is for.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Trusts — Revocable and Irrevocable",
      "summary": "When a will is enough, and when a trust earns its keep.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Trusts are misunderstood in roughly equal measure as estate-planning savior and unnecessary complication. They are useful for specific purposes; for many clients with simple situations, they're overkill. A Wealth Solutions Counselor needs to know when to suggest a trust to the client and when to leave well enough alone." },

        { "type": "heading", "text": "What a trust actually is" },
        { "type": "paragraph", "text": "A trust is a legal arrangement where one party (the <strong>grantor</strong> or <strong>settlor</strong>) gives property to a <strong>trustee</strong> to hold and manage for the benefit of <strong>beneficiaries</strong>, according to terms spelled out in the trust document. The trust itself owns the property; the trustee operates under fiduciary duty." },

        { "type": "heading", "text": "Revocable living trust" },
        { "type": "paragraph", "text": "A revocable trust is one the grantor can change or terminate during their lifetime. Most commonly used for:" },
        { "type": "list", "items": [
          "<strong>Avoiding probate</strong> — assets owned by the trust pass per the trust document, not through court probate. In states with painful probate processes (California, Florida), this alone justifies the cost.",
          "<strong>Privacy</strong> — wills become public record in probate. Trust distributions don't.",
          "<strong>Incapacity planning</strong> — the successor trustee can step in if the grantor becomes incapacitated, without a court-appointed conservatorship.",
          "<strong>Multi-state property</strong> — owning real estate in multiple states normally triggers probate in each. Trust ownership avoids this.",
          "<strong>Blended family planning</strong> — can specify complex distributions across multiple sets of beneficiaries with more nuance than a will."
        ]},
        { "type": "callout", "kind": "note", "title": "What revocable trusts do NOT do", "text": "They do <em>not</em> save federal estate taxes (because the grantor still controls and owns the assets for tax purposes). They do <em>not</em> protect assets from the grantor's creditors during their lifetime. They are estate-administration tools, not tax-avoidance or asset-protection tools." },

        { "type": "heading", "text": "Irrevocable trusts" },
        { "type": "paragraph", "text": "An irrevocable trust, once created, generally cannot be changed by the grantor. The grantor has surrendered control over the assets. This makes irrevocable trusts powerful for specific planning purposes that revocable trusts can't accomplish:" },
        { "type": "list", "items": [
          "<strong>Estate tax reduction</strong> — assets transferred to certain irrevocable trusts are removed from the grantor's taxable estate.",
          "<strong>Asset protection</strong> — properly structured irrevocable trusts can shield assets from future creditors (rules vary widely by state).",
          "<strong>Special needs planning</strong> — a special needs trust preserves a disabled beneficiary's eligibility for government benefits while providing supplemental support.",
          "<strong>Life insurance ownership (ILIT)</strong> — an irrevocable life insurance trust owns the policy so death proceeds are not part of the taxable estate.",
          "<strong>Charitable planning</strong> — charitable remainder trusts and charitable lead trusts have specialized estate and income tax benefits."
        ]},

        { "type": "callout", "kind": "warn", "title": "The cost of irrevocability", "text": "An irrevocable trust gives up control. If circumstances change, the trust is generally stuck. Most clients should not enter irrevocable arrangements until the basic planning is solid and the specific tax/protection benefit clearly justifies the loss of flexibility. Always involve an experienced estate attorney." },

        { "type": "divider" },

        { "type": "heading", "text": "When a will alone is fine" },
        { "type": "paragraph", "text": "Most clients do not need a trust. A well-drafted will, combined with proper beneficiary designations and joint ownership where appropriate, handles their estate cleanly." },
        { "type": "subheading", "text": "Will-only is typically sufficient when..." },
        { "type": "list", "items": [
          "Estate is well below federal exemption (currently $13+ million per individual, sunset reverts lower in 2026).",
          "Single state of residence with reasonable probate (most states are not California or Florida).",
          "Simple family structure — first marriage, no special-needs beneficiaries.",
          "No business interests requiring sophisticated succession planning.",
          "No need for incapacity-driven trust management (powers of attorney suffice)."
        ]},

        { "type": "case_study",
          "title": "Trust or no trust?",
          "scenario": "Two clients each have $1.4 million net worth, two adult children, simple family situations. Client A lives in Texas. Client B lives in California.",
          "discussion": "<p>Client A (Texas): probate in Texas is relatively painless and quick — independent administration is common, court oversight minimal. A well-drafted will plus beneficiary designations and joint titling on the house likely suffices. <strong>Trust adds cost without much benefit.</strong></p><p>Client B (California): California probate is famously slow, expensive (statutory attorney fees on a $1.4M estate run roughly $25,000+), and public. A revocable living trust costs $2,000–$5,000 to set up but saves the probate process entirely. <strong>The trust pays for itself many times over.</strong></p><p>The trust decision is jurisdictional more than wealth-based. Always ask about the client's state and whether real estate is owned in multiple states.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Gifts, Estate Tax, and the Federal Exemption",
      "summary": "When taxes matter, who they apply to, and how to use the annual exclusion.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Federal estate and gift tax affects a small fraction of households — but for the clients it affects, the stakes are enormous. And the rules around the annual gift exclusion and lifetime exemption matter in planning conversations even when the client isn't currently above the threshold." },

        { "type": "heading", "text": "The lifetime exemption" },
        { "type": "paragraph", "text": "Federal estate tax applies to the value transferred at death (or by gift during life) that exceeds the <strong>lifetime exemption</strong>. As of 2025, the exemption is approximately <strong>$13.99 million per individual</strong> ($27.98 million per couple). For estates above this threshold, the marginal federal estate tax rate is 40%." },
        { "type": "callout", "kind": "warn", "title": "The 2026 sunset", "text": "Unless Congress acts, the lifetime exemption is currently scheduled to be roughly cut in half at the end of 2025, dropping to approximately $7 million per individual. Clients with estates in the $7–14M range may move from \"not subject to estate tax\" to \"subject to estate tax\" based on legislative action alone. This is a real planning consideration; high-net-worth clients should be discussing it with an estate attorney now. <em>Always verify the current threshold before quoting it to clients — legislation changes.</em>" },

        { "type": "heading", "text": "Annual gift exclusion" },
        { "type": "paragraph", "text": "Separate from the lifetime exemption, every individual can gift up to a certain amount per recipient per year with no tax consequence and no use of the lifetime exemption. As of 2025: <strong>$19,000 per recipient per year</strong>. A married couple can jointly gift $38,000 per recipient. There is no limit on the number of recipients." },
        { "type": "subheading", "text": "Annual exclusion examples" },
        { "type": "list", "items": [
          "A couple gifts $38,000 to each of their three children annually: $114,000 per year transferred, no gift tax filing required, no use of lifetime exemption.",
          "Grandparents (a couple) gift $38,000 to each of five grandchildren plus three children: $304,000 per year transferred.",
          "Over a 10-year period, the same couple could transfer over $3 million using only annual exclusions — sizable wealth movement with no tax cost."
        ]},
        { "type": "callout", "kind": "key", "title": "Why this matters for high-net-worth families", "text": "Systematic use of the annual gift exclusion reduces the taxable estate over time. Combined with strategic use of the lifetime exemption (especially before any reduction), it can move enormous wealth across generations tax-free. The window is open until it isn't — and unlike many planning ideas, this one runs on a literal calendar." },

        { "type": "divider" },

        { "type": "heading", "text": "Step-up in basis" },
        { "type": "paragraph", "text": "When an asset is inherited at death, the recipient's tax basis is generally reset to the asset's value at the date of death — the <strong>step-up in basis</strong>. This can be a far more valuable tax provision than the estate tax exemption for many families." },
        { "type": "subheading", "text": "Why step-up matters" },
        { "type": "list", "items": [
          "A client buys $50,000 of stock that grows to $500,000 over 30 years. If she sells, she owes capital gains tax on the $450,000 gain.",
          "If she instead holds the stock until death, her heirs inherit it at the $500,000 stepped-up basis. They can sell immediately and owe no capital gains tax.",
          "This is why planners often recommend that highly-appreciated assets be held until death rather than sold during life, particularly when heirs will receive them anyway."
        ]},
        { "type": "callout", "kind": "do", "title": "The planning move", "text": "When a client has both highly-appreciated assets and assets without much gain, sell the low-gain assets first if cash is needed. Leave the appreciated assets for the step-up at death. This is one of the highest-leverage tax planning moves available to anyone with taxable investments, and it costs nothing to execute correctly." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Working with the Estate Attorney",
      "summary": "How a Wealth Solutions Counselor coordinates without practicing law.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Drafting wills and trusts is the practice of law and requires a licensed attorney. A Wealth Solutions Counselor's role in estate planning is to identify the need, prepare the client for the conversation, coordinate with the attorney, and implement and maintain the plan over time. Done well, the counselor multiplies the value of the attorney's work." },

        { "type": "heading", "text": "What the counselor does" },
        { "type": "list", "items": [
          "<strong>Identify the gap.</strong> Most clients haven't done estate planning, or did it many years ago. The counselor notices and raises the conversation.",
          "<strong>Gather information.</strong> Before the attorney meeting, help the client prepare: asset inventory, beneficiaries, family details, goals for distribution.",
          "<strong>Explain plain-language basics.</strong> Walk the client through what a will does, why beneficiary designations matter, what powers of attorney accomplish. Demystify the conversation before they meet with the attorney.",
          "<strong>Refer to a qualified attorney.</strong> Have a short list of vetted estate planning attorneys. Match the complexity to the right attorney.",
          "<strong>Coordinate implementation.</strong> Once documents are signed, help the client retitle assets into the trust, update beneficiary designations, and store documents safely.",
          "<strong>Monitor and update.</strong> Life changes (marriage, divorce, new child, inheritance, business sale, move) and law changes both trigger reviews."
        ]},

        { "type": "callout", "kind": "warn", "title": "What the counselor does NOT do", "text": "Draft documents. Provide legal advice on which provisions to choose. Opine on trust selection, executor selection, or specific clauses. Witness signing of estate documents (unless explicitly part of firm procedure, and even then under attorney supervision). Be the trustee, executor, or POA agent for a client (unless your firm has a formal corporate trustee arrangement). The line is real — when in doubt, defer to the attorney." },

        { "type": "heading", "text": "Storing the documents" },
        { "type": "paragraph", "text": "An estate plan that can't be found is no plan at all. Help clients establish a system:" },
        { "type": "list", "items": [
          "Original signed documents stored in a fireproof safe or with the attorney (not in a bank safe deposit box — those can be sealed at death until court order).",
          "Copies provided to the executor, POA agents, and healthcare agents.",
          "Family members told where the originals are kept.",
          "Beneficiary designations stored alongside or referenced — they're not part of the will but are part of the plan.",
          "Digital asset inventory: passwords, accounts, cryptocurrency. This is a growing gap; courts and family struggle to access digital assets without documentation."
        ]},

        { "type": "case_study",
          "title": "The first estate planning conversation",
          "scenario": "Naomi (now 36) is single, no children, $250K net worth, lives in California. She's never had any estate documents drafted. In a routine planning meeting, you ask: 'What happens if you can't make medical decisions tomorrow?' She doesn't know.",
          "discussion": "<p>Naomi doesn't need a trust at this stage. Her assets are still below the California probate hassle threshold, her situation is simple, and she has no dependents requiring complex distribution. What she needs:</p><ul><li>Will — names a beneficiary (likely her parents or a sibling) and an executor.</li><li>Durable POA for finances — names someone to manage her finances if she's incapacitated.</li><li>Healthcare POA + advance directive — names a medical decision-maker and her preferences.</li><li>HIPAA authorization — allows the medical agent to access her records.</li><li>Beneficiary designations updated on her Roth IRA, 401(k), HSA, and any life insurance.</li></ul><p>Cost: probably $500–$1,500 with a flat-fee estate attorney. Time: one or two meetings.</p><p>The advisor's contribution: noticing the gap, framing it without scaring her, providing a vetted attorney, and helping her implement after signing. As her net worth grows or her family situation changes, she'll come back for revisions. <strong>This is what 'preparing the next generation of Wealth Solutions Counselors' actually looks like in practice — taking a smart 36-year-old from 'I should do that someday' to 'I have all the documents' in less than a month.</strong></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which four documents make up the minimum-viable estate plan every adult should have?",
        "options": [
          "Will, 401(k), homeowners insurance, life insurance",
          "Will, durable financial POA, healthcare POA / advance directive, HIPAA authorization",
          "Will, trust, deed, mortgage",
          "Living will, last will, holographic will, codicil"
        ],
        "correct": 1,
        "explanation": "Every adult — regardless of net worth — should have these four. They handle the structural risks of death and incapacity. Trusts and advanced planning layer on top of this base."
      },
      {
        "id": "q2",
        "prompt": "If a person dies without a will, their estate is distributed:",
        "options": [
          "Equally among all surviving relatives.",
          "To the federal government.",
          "According to the state's intestacy laws, which often produce surprising results.",
          "To whomever filed the death certificate."
        ],
        "correct": 2,
        "explanation": "State intestacy laws set default distribution. They rarely match what the deceased would have chosen — surviving spouses may share with parents, unmarried partners may inherit nothing, minor children's funds get held by court-appointed conservators."
      },
      {
        "id": "q3",
        "prompt": "Beneficiary designations on retirement accounts and life insurance:",
        "options": [
          "Are controlled by the will.",
          "Override the will and pass directly to the named beneficiary, regardless of what the will says.",
          "Only apply if the will is missing or contested.",
          "Require probate court approval to be honored."
        ],
        "correct": 1,
        "explanation": "Beneficiary designations override wills. Always. The most common estate-planning disaster: a will leaving everything to the second spouse, while the 401(k) still names the ex-spouse from 15 years ago. The 401(k) goes to the ex. Auditing beneficiaries annually prevents this."
      },
      {
        "id": "q4",
        "prompt": "What is the primary purpose of a revocable living trust?",
        "options": [
          "Save federal estate taxes.",
          "Protect assets from creditors during the grantor's lifetime.",
          "Avoid probate, plan for incapacity, and provide privacy for asset distribution.",
          "Generate income tax deductions."
        ],
        "correct": 2,
        "explanation": "Revocable trusts are estate-administration tools, not tax tools. They bypass probate, allow seamless management at incapacity, and keep distributions private. They do NOT save estate taxes (grantor still owns the assets for tax purposes) or protect from grantor's creditors during life."
      },
      {
        "id": "q5",
        "prompt": "Which factor makes a revocable trust most clearly worth the cost?",
        "options": [
          "The client lives in a state with painful probate (California, Florida, etc.) or owns real estate in multiple states.",
          "The client's net worth is above $1 million.",
          "The client has more than one child.",
          "The client is over age 65."
        ],
        "correct": 0,
        "explanation": "The trust decision is jurisdictional more than wealth-based. In states with slow, expensive, public probate processes, even modest estates benefit from trust ownership. Conversely, in states with streamlined probate, the same wealth level may not justify the trust."
      },
      {
        "id": "q6",
        "prompt": "What is the 2025 federal estate tax lifetime exemption per individual (approximate)?",
        "options": [
          "$1 million",
          "$5.5 million",
          "$13.99 million",
          "$25 million"
        ],
        "correct": 2,
        "explanation": "Approximately $13.99 million per individual in 2025. Note: scheduled to roughly halve at end of 2025 absent congressional action. Verify the current threshold before quoting to clients — this number moves."
      },
      {
        "id": "q7",
        "prompt": "What is the 2025 annual gift tax exclusion per recipient?",
        "options": [
          "$5,000",
          "$15,000",
          "$19,000",
          "$50,000"
        ],
        "correct": 2,
        "explanation": "$19,000 per recipient per giver in 2025. A married couple can jointly gift $38,000 per recipient. No limit on number of recipients. Systematic use can transfer significant wealth across generations tax-free."
      },
      {
        "id": "q8",
        "prompt": "What is the 'step-up in basis' and why does it matter?",
        "options": [
          "An IRS penalty on gifts made within one year of death.",
          "When assets are inherited at death, the recipient's tax basis is reset to the asset's value at date of death — eliminating capital gains tax on prior appreciation.",
          "A method of valuing real estate for property tax purposes.",
          "The increase in retirement contribution limits at age 50."
        ],
        "correct": 1,
        "explanation": "Step-up in basis often saves more tax for middle-class families than estate tax exemption ever could. Highly appreciated assets held until death allow heirs to sell immediately with no capital gains tax on the prior growth. This is why advisors often recommend selling low-gain assets first and holding high-gain assets for inheritance."
      },
      {
        "id": "q9",
        "prompt": "When does an irrevocable trust make sense versus a revocable trust?",
        "options": [
          "Always — irrevocable trusts are more flexible.",
          "When the planning goal specifically requires loss of grantor control: estate tax reduction, asset protection, special-needs planning, or specific tax structures.",
          "When the client doesn't trust their family members.",
          "Whenever net worth exceeds $1 million."
        ],
        "correct": 1,
        "explanation": "Irrevocable trusts surrender grantor control. They're appropriate when a specific goal — estate tax reduction, asset protection, special needs preservation, life insurance trust structures — justifies giving up the flexibility. They are never the default; always involve experienced estate counsel."
      },
      {
        "id": "q10",
        "prompt": "Which life event MOST commonly creates a beneficiary designation problem advisors must catch?",
        "options": [
          "Birth of a child",
          "Buying a home",
          "Divorce — ex-spouses often remain beneficiaries on retirement accounts and life insurance long after the divorce.",
          "Job change"
        ],
        "correct": 2,
        "explanation": "Divorce is the highest-stakes trigger. State law sometimes auto-revokes ex-spouse designations, but federal law preempts for ERISA-governed plans (401(k)s) and the ex remains beneficiary unless manually changed. Every divorce should trigger a beneficiary audit on every retirement account and life insurance policy."
      },
      {
        "id": "q11",
        "prompt": "What is the role of a Wealth Solutions Counselor in estate planning?",
        "options": [
          "Draft the will and trust documents themselves.",
          "Identify the need, prepare the client, refer to and coordinate with an estate attorney, and implement and maintain the plan over time.",
          "Serve as executor and trustee for all clients.",
          "Provide specific legal advice on which provisions to choose."
        ],
        "correct": 1,
        "explanation": "Drafting documents is the practice of law and requires a licensed attorney. The counselor's role is identifying the need, preparing the client, coordinating with the attorney, and handling implementation (retitling, beneficiaries, ongoing review). The boundary is real — when in doubt, defer to the attorney."
      },
      {
        "id": "q12",
        "prompt": "Why is a bank safe deposit box generally a BAD place to store original estate documents?",
        "options": [
          "Banks don't keep them secure.",
          "They can be sealed at death until a court order is issued — exactly the moment the family needs access.",
          "Banks charge too much rent for the boxes.",
          "Documents fade in safe deposit boxes."
        ],
        "correct": 1,
        "explanation": "Safe deposit boxes can be sealed at the owner's death, requiring court intervention to access. The family needs the documents at precisely that moment. Better options: fireproof home safe, with the attorney, or with the executor. Always tell the family where the originals are."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 8;

-- ── module9_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 9 CONTENT
-- Ethics, Fiduciary Duty & Regulation
-- ============================================================================
update public.modules set
  title = 'Ethics, Fiduciary Duty & Regulation',
  competency_id = 'CORE-9',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The standards that separate a professional from a salesperson. Fiduciary duty, suitability, the regulatory landscape, and the daily judgment calls that make or break a career.',
  learning_objectives = ARRAY[
    'Distinguish fiduciary duty from suitability and explain why the difference matters.',
    'Identify the major U.S. regulators (SEC, FINRA, state regulators, CFP Board) and who they oversee.',
    'Recognize conflicts of interest and apply the disclose/mitigate/avoid framework.',
    'Explain Regulation Best Interest (Reg BI) and the Investment Advisers Act of 1940 at a working level.',
    'Apply the CFP Board Code of Ethics to common client scenarios.',
    'Identify the red flags that require immediate escalation to compliance.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Fiduciary Duty vs. Suitability",
      "summary": "The single most important distinction in the financial services industry.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "If a client asked you, \"is my advisor required to act in my best interest?\" — would you know how to answer? The answer depends on what kind of advisor they have, what regulator oversees that advisor, and what they're being advised on. This lesson teaches the distinction every counselor must be able to make in plain language." },

        { "type": "heading", "text": "Fiduciary duty" },
        { "type": "callout", "kind": "key", "title": "The fiduciary standard, plainly", "text": "A fiduciary is legally required to act in the client's best interest, putting the client's interests <em>ahead</em> of the fiduciary's own. This includes a duty of loyalty (no self-dealing), a duty of care (reasonable competence and prudence), and a duty of full disclosure of material conflicts of interest." },
        { "type": "paragraph", "text": "Fiduciary duty applies to:" },
        { "type": "list", "items": [
          "Registered Investment Advisers (RIAs) under the Investment Advisers Act of 1940.",
          "Investment Adviser Representatives (IARs) — the individuals registered with RIAs.",
          "Trustees, executors, attorneys, doctors, and many other professional roles.",
          "CFP® professionals when providing financial advice (per CFP Board's Code of Ethics, since 2019)."
        ]},

        { "type": "heading", "text": "Suitability" },
        { "type": "paragraph", "text": "A lower standard. Historically applied to brokers (registered representatives of broker-dealers): the recommended product must be \"suitable\" given the client's profile, but the broker is not required to recommend the <em>best</em> option for the client — only one that fits." },
        { "type": "callout", "kind": "warn", "title": "Why this difference matters", "text": "Under suitability, a broker could recommend a product paying them a 5% commission when an identical product at 0.5% existed — as long as the recommended product was \"suitable.\" Under fiduciary duty, that recommendation would be a violation. Same product. Same client. Different legal duty. Different outcome." },

        { "type": "heading", "text": "Regulation Best Interest (Reg BI)" },
        { "type": "paragraph", "text": "Adopted by the SEC in 2019. Raised the broker standard from \"suitability\" to \"best interest\" for retail customers, but stopped short of full fiduciary duty. Reg BI requires brokers to:" },
        { "type": "list", "items": [
          "Act in the retail customer's best interest at the time of recommendation.",
          "Not place the broker's financial interests ahead of the customer's.",
          "Have policies to identify and mitigate conflicts.",
          "Provide a customer relationship summary (Form CRS) disclosing relationships, fees, and conflicts."
        ]},
        { "type": "callout", "kind": "note", "title": "Reg BI is NOT full fiduciary duty", "text": "Reg BI applies to brokers at the moment of recommendation; fiduciary duty under the Advisers Act applies to investment advisers continuously across the relationship. Reg BI permits commission-based compensation; full fiduciary duty doesn't prohibit it but treats it as a conflict requiring management. The standards have converged somewhat but are not the same — and the difference still matters in client conversations." },

        { "type": "divider" },

        { "type": "heading", "text": "Why this lives at the center of the profession" },
        { "type": "paragraph", "text": "Financial advice is the rare service where the advisor's compensation can be structured in ways that conflict with what's best for the client. A real estate agent earns a commission only if you buy. A car salesperson is compensated when the car sells. Financial advisors can be paid by fees, commissions, asset-based percentages, sales contests, or product-specific compensation — and the structure shapes the recommendation, whether or not the advisor consciously realizes it." },
        { "type": "callout", "kind": "key", "title": "The honest frame", "text": "Don't ask <em>\"is this advisor a fiduciary?\"</em> Ask <em>\"how does this advisor get paid, and what would they recommend differently if they were paid another way?\"</em> That question gets to the heart of the matter and respects the client's intelligence." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Regulatory Map",
      "summary": "Who regulates whom — and where Global Investment Company fits.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial services regulation in the U.S. is a maze. A counselor doesn't need to be a compliance attorney, but does need to know who oversees each piece of the work — and who to call when something goes wrong." },

        { "type": "heading", "text": "The major regulators" },
        { "type": "glossary", "terms": [
          { "term": "SEC — Securities and Exchange Commission", "definition": "Federal regulator of securities markets, broker-dealers (jointly with FINRA), and Registered Investment Advisers with assets under management above $100 million." },
          { "term": "FINRA — Financial Industry Regulatory Authority", "definition": "Self-regulatory organization overseeing broker-dealers and registered representatives. Administers the Series 7, Series 6, Series 65, Series 66 and other licensing exams." },
          { "term": "State securities regulators", "definition": "Oversee Investment Advisers with AUM below $100 million (mid-sized advisers split by state-specific thresholds) and broker-dealers operating within the state." },
          { "term": "CFP Board", "definition": "Private organization that grants and maintains the Certified Financial Planner® credential. Enforces its own Code of Ethics and Standards of Conduct for CFP professionals." },
          { "term": "DOL — Department of Labor", "definition": "Regulates advice and management of ERISA-covered retirement plans (most 401(k)s, pensions). Issues fiduciary regulations for retirement plan investment advice." },
          { "term": "CFPB — Consumer Financial Protection Bureau", "definition": "Regulates consumer financial products: mortgages, credit cards, credit reporting, debt collection. Less directly relevant to investment advice but matters for advisors discussing debt and credit." },
          { "term": "State insurance commissioners", "definition": "Regulate insurance products and producers. Insurance is largely a state regulatory matter." }
        ]},

        { "type": "heading", "text": "Three kinds of advisor licensure" },
        { "type": "subheading", "text": "Investment Adviser Representative (IAR)" },
        { "type": "paragraph", "text": "Provides investment advice for compensation. Registered with an RIA firm, which is registered with the SEC (large firms) or state regulators (smaller firms). Operates under fiduciary duty. Typically passes the Series 65 (or Series 66 with Series 7). Compensation usually fee-based: percentage of AUM, hourly, flat fees." },

        { "type": "subheading", "text": "Registered Representative (RR)" },
        { "type": "paragraph", "text": "Sometimes called a stockbroker. Sells securities through a broker-dealer. Regulated by FINRA. Operates under suitability + Reg BI. Typically passes Series 7 (full securities) or Series 6 (mutual funds and variable annuities only). Compensation often commission-based." },

        { "type": "subheading", "text": "Insurance producer" },
        { "type": "paragraph", "text": "Sells insurance and annuity products. State-licensed. Operates under state insurance laws (suitability standards for annuities; variable annuities are securities and require additional FINRA licensing). Compensation typically commission-based, sometimes with renewals." },

        { "type": "callout", "kind": "key", "title": "Most modern advisors are 'dual-registered'", "text": "Carry both IAR and RR credentials. They can provide advisory services under fiduciary duty <em>and</em> sell commission products under Reg BI. The duty applied to a specific transaction depends on which capacity the advisor is acting in. Client confusion about \"hats\" is endemic; the advisor's job is to make the hat clear at every relevant moment." },

        { "type": "divider" },

        { "type": "heading", "text": "Where Global Investment Company fits" },
        { "type": "paragraph", "text": "Global Investment Company operates as a Registered Investment Adviser under the Investment Advisers Act of 1940. Wealth Solutions Counselors at GIC operate under fiduciary duty. This is the firm's chosen standard and is reflected in our compensation model (fee-based, no commissions), our disclosure practices (Form ADV available to all clients), and our standards of practice (documented in this curriculum)." },
        { "type": "callout", "kind": "do", "title": "Form ADV", "text": "Every RIA must file <strong>Form ADV</strong> with the SEC or state regulators. Parts 2A and 2B are written in plain English and disclose services, fees, conflicts, disciplinary history of the firm and its representatives. Every client must receive these. As a counselor, you should be able to point clients to GIC's Form ADV and walk them through the relevant sections. Memorize where they live in your firm's onboarding kit." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Conflicts of Interest",
      "summary": "What they are, why they're inevitable, and the framework for handling them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Conflicts of interest are not bad in themselves — they're inherent to almost every advisor-client relationship. The professional question is not \"are there conflicts?\" The professional question is \"are the conflicts disclosed, mitigated, or avoided — and which one is appropriate for each conflict?\"" },

        { "type": "heading", "text": "Common conflicts to recognize" },
        { "type": "list", "items": [
          "<strong>Compensation structure</strong> — fee-based, commission-based, AUM-based all create different incentives. AUM advisors are paid more when assets grow, including incentivizing the advisor to keep client assets under management even when paying down debt or buying a home would be a better use.",
          "<strong>Product compensation differentials</strong> — some products pay the firm more than others. The advisor's recommendation should not be driven by what pays better.",
          "<strong>Proprietary products</strong> — firms with their own mutual funds, annuities, or insurance products face conflicts when recommending in-house vs. third-party alternatives.",
          "<strong>Cross-selling pressure</strong> — banks and large firms often expect advisors to refer clients to other product lines (mortgages, insurance, trust services). Each referral creates a potential conflict.",
          "<strong>Sales contests and incentives</strong> — quarterly contests, trips, bonuses tied to product sales create strong incentives that can override fiduciary judgment.",
          "<strong>Outside relationships</strong> — when the advisor has a personal or business relationship with a product provider, custodian, or referral source.",
          "<strong>Personal investments</strong> — when the advisor owns the same securities being recommended (front-running, etc.)."
        ]},

        { "type": "heading", "text": "The framework: disclose, mitigate, avoid" },
        { "type": "subheading", "text": "Disclose" },
        { "type": "paragraph", "text": "Most conflicts cannot be eliminated. They can be disclosed — in writing, in plain language, ideally before the recommendation is acted on. Disclosure shifts the question to the client: \"given that I am paid this way, here is my recommendation.\" Disclosure alone does not satisfy fiduciary duty if the conflict actually drives the recommendation — but it's the floor." },

        { "type": "subheading", "text": "Mitigate" },
        { "type": "paragraph", "text": "Some conflicts can be reduced. Examples:" },
        { "type": "list", "items": [
          "Internal review of recommendations involving products paying higher compensation.",
          "Required documentation of why a recommendation was made (especially when alternatives exist).",
          "Compensation grids that pay the advisor the same regardless of which product within a category is recommended.",
          "Refusing certain compensation arrangements that create structural pressure (sales contests, etc.).",
          "Pre-trade approval requirements for personal securities trades."
        ]},

        { "type": "subheading", "text": "Avoid" },
        { "type": "paragraph", "text": "Some conflicts are sufficiently serious that the only correct response is to walk away from them. Examples:" },
        { "type": "list", "items": [
          "Accepting gifts or entertainment beyond modest, customary levels.",
          "Personal financial relationships with clients beyond the advisory relationship (loans, joint investments, romantic relationships).",
          "Serving as a beneficiary of a client's estate (other than for the advisor's own family).",
          "Trading client securities for personal benefit ahead of client trades.",
          "Recommending a product that pays significantly more in compensation when an alternative is clearly better for the client."
        ]},

        { "type": "callout", "kind": "key", "title": "The decision rule", "text": "<em>If I had to defend this recommendation in front of regulators, a judge, and the client's adult children, knowing they would learn how I was compensated — would my recommendation still hold up?</em> If yes, document it and proceed. If no, change the recommendation or escalate." },

        { "type": "case_study",
          "title": "The product recommendation",
          "scenario": "Your firm offers two retirement income products in roughly the same category. Product A pays your firm a 1% advisory fee on assets; Product B is a proprietary annuity with a 5% upfront commission to the firm and to you personally. Both products are 'suitable' for the client.",
          "discussion": "<p>Under suitability, either product is acceptable. Under fiduciary duty, the standard is harder: which is actually in the client's best interest?</p><p>To answer honestly, compare on dimensions that matter to the client: total fees over expected holding period, surrender charges, flexibility of access, expected returns, tax treatment, complexity, and the client's actual planning need. If after that analysis the proprietary annuity is genuinely the better product for the client, then it's the right recommendation — and the documentation should clearly show why.</p><p>If after that analysis the open-architecture advisory fee product is better and you still recommend the annuity because of compensation, you've violated fiduciary duty regardless of whether the annuity is 'suitable.' The honest test isn't whether the product fits — it's whether it's the best available option for this client.</p><p><strong>Document the analysis, every time.</strong> If you can't explain why a higher-compensation product was chosen over a lower-compensation alternative in writing, don't choose it.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "The CFP Board Standards and Ethical Decision-Making",
      "summary": "How professionals decide when the right answer isn't obvious.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Many of the hardest moments in advisory practice are not technical questions — they're ethical ones. The CFP Board Code of Ethics and Standards of Conduct provides a framework for these moments. Even if a counselor is not yet a CFP professional, knowing the framework strengthens judgment." },

        { "type": "heading", "text": "The CFP Code of Ethics" },
        { "type": "paragraph", "text": "The CFP Board requires its certificants to commit to six principles:" },
        { "type": "numbered", "items": [
          "<strong>Act with honesty, integrity, competence, and diligence.</strong>",
          "<strong>Act in the client's best interests.</strong>",
          "<strong>Exercise due care.</strong>",
          "<strong>Avoid or disclose and manage conflicts of interest.</strong>",
          "<strong>Maintain the confidentiality and protect the privacy of client information.</strong>",
          "<strong>Act in a manner that reflects positively on the financial planning profession and CFP® certification.</strong>"
        ]},

        { "type": "heading", "text": "The fiduciary duty within the CFP Standards" },
        { "type": "paragraph", "text": "When providing financial advice to a client, a CFP professional is bound by a <strong>fiduciary duty</strong> consisting of:" },
        { "type": "list", "items": [
          "<strong>Duty of loyalty</strong> — place the client's interests above the CFP's own and the firm's.",
          "<strong>Duty of care</strong> — provide advice with care, skill, prudence, and diligence reasonable under the circumstances.",
          "<strong>Duty to follow client instructions</strong> — within the scope of the engagement and consistent with the law."
        ]},

        { "type": "heading", "text": "Ethical decision-making in practice" },
        { "type": "paragraph", "text": "When the right answer isn't obvious, the structured approach is:" },
        { "type": "numbered", "items": [
          "<strong>Identify the parties and their interests.</strong> Whose interests are affected and how?",
          "<strong>Identify the relevant duties.</strong> What does fiduciary duty require? What does the firm's policy require? What do applicable regulations require?",
          "<strong>Identify the conflict.</strong> Where do interests or duties collide?",
          "<strong>Consider alternatives.</strong> What are the possible courses of action?",
          "<strong>Evaluate each alternative.</strong> Against client interest, against duties, against the optics of the decision.",
          "<strong>Decide and act.</strong> Choose the course of action best aligned with duty and document the reasoning.",
          "<strong>Escalate when uncertain.</strong> When the stakes are meaningful or the answer unclear, involve a supervisor or compliance officer."
        ]},

        { "type": "callout", "kind": "do", "title": "The simple test before any tough call", "text": "<em>If this decision became public tomorrow — to my client, to my employer, to regulators, to the press — would I be comfortable defending it?</em> If yes, proceed and document. If no, reconsider or escalate. The discomfort of escalating is far smaller than the discomfort of a violation that surfaces later." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The friend-of-a-friend referral",
          "scenario": "A new client is referred by an existing client, who calls and says, 'I told her you'd take care of her, she's recently widowed and inherited $1.2M, just put it somewhere safe.' The widow is 64, grieving, hasn't yet processed the situation, and signs whatever you put in front of her in the first meeting.",
          "discussion": "<p>Several ethical issues at once:</p><ul><li><strong>Capacity to engage.</strong> A grieving client immediately after a major loss may not be in a state to make informed long-term decisions. The 30-day-rule (some advisors won't make major recommendations within 30–60 days of a significant life event) exists for this reason.</li><li><strong>Discovery.</strong> You can't make a fiduciary recommendation without understanding the client's situation. 'Put it somewhere safe' is not a goal — it's a feeling.</li><li><strong>Referring-client pressure.</strong> The implicit \"I told her you'd take care of her\" creates pressure to act quickly to deliver for the referrer. That pressure runs counter to taking the time the situation requires.</li><li><strong>Signing documents.</strong> The widow signing without comprehension is not informed consent.</li></ul><p>The right move: slow down. Express condolences clearly. Do a thorough discovery over multiple meetings. Park the $1.2M in a high-yield savings account or short-term Treasuries while you both work toward clarity. Document everything. Resist any temptation to recommend investment products in the first few weeks. If the referring client gets impatient, that's a signal about the referring client, not about the work — explain calmly that this is how you serve clients well, regardless of how they came in the door.</p><p><strong>This is fiduciary duty in practice: not the technical right product, but the right pace and the right care.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Red Flags and Escalation",
      "summary": "What to do when something doesn't sit right — and the price of not doing it.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Ethical practice is shaped less by big decisions and more by daily judgment calls. The counselor who learns to recognize red flags and act on them is the counselor whose career lasts. The one who lets things slide accumulates risk that eventually erupts." },

        { "type": "heading", "text": "Client-side red flags" },
        { "type": "list", "items": [
          "<strong>Diminished capacity.</strong> Client confusion about their own finances, memory lapses, unusual decisions, vulnerability to family pressure. Escalate and follow firm protocols (which may include reaching out to a trusted contact on file).",
          "<strong>Suspected elder financial abuse.</strong> Caregiver involvement in unusual transactions, new \"friend\" appearing in financial matters, isolation from family. Many states require advisors to report suspected abuse.",
          "<strong>Sudden, unexplained changes</strong> in beneficiaries, withdrawal patterns, or risk tolerance — particularly from clients who have previously been consistent.",
          "<strong>Pressure to make a transaction.</strong> 'I need this done today.' Urgency is a red flag, not a justification.",
          "<strong>Requests on accounts the client doesn't own.</strong> Anything involving an elderly parent, an adult child, an ex-spouse, a business partner.",
          "<strong>Disclosure of marital problems, depression, or addiction.</strong> Not directly an investment issue, but each affects judgment and may signal need for caution and slowing down.",
          "<strong>Mention of large unsolicited investment opportunities</strong> — friend's startup, crypto scheme, real estate fund, etc. Often legitimate, sometimes fraud, sometimes outside the advisor's scope."
        ]},

        { "type": "heading", "text": "Advisor-side red flags" },
        { "type": "paragraph", "text": "Equally important: notice when something about <em>your own</em> situation or another colleague's situation crosses a line." },
        { "type": "list", "items": [
          "Personal financial pressure that might influence recommendations.",
          "Compensation structure that's pushing toward a specific product or behavior.",
          "Personal relationship with a client that's becoming non-professional.",
          "Receiving gifts or entertainment that feels disproportionate.",
          "Colleague's behavior toward clients, accounts, or compliance procedures that doesn't add up.",
          "Pressure from a supervisor to skip steps, rush decisions, or sell specific products."
        ]},

        { "type": "callout", "kind": "warn", "title": "What to do with red flags", "text": "Document the observation in client notes. Escalate to a supervisor or compliance officer. If the conduct is criminal or fraudulent, internal whistleblower protections apply, and external reporting channels exist (SEC tip line, FINRA complaint, state regulator). Inaction is not a neutral choice — silence becomes complicity." },

        { "type": "heading", "text": "The career arc this protects" },
        { "type": "paragraph", "text": "The vast majority of advisors who are sanctioned, fined, or barred from the industry didn't intend to commit a violation. They drifted. A small ethical compromise here, a missed disclosure there, a friend's deal that seemed harmless. The accumulation eventually reaches a regulator or a lawsuit, and at that point the documentation either tells a clean story or it doesn't." },

        { "type": "callout", "kind": "key", "title": "The advisor who lasts", "text": "Treats every recommendation as if it might be reviewed five years from now. Documents conflicts before they're noticed. Escalates uncomfortable conversations rather than swallowing them. Operates with the assumption that clean practice <em>is</em> the business model — not friction that interferes with it. <strong>This is what \"professional\" means in the deepest sense.</strong> It's also what makes a 40-year career possible." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the most important practical difference between fiduciary duty and suitability?",
        "options": [
          "Fiduciary duty applies only to lawyers; suitability applies to financial advisors.",
          "Fiduciary duty requires acting in the client's best interest; suitability requires only that a recommendation be appropriate.",
          "Fiduciary duty applies only to retirement accounts; suitability applies to taxable accounts.",
          "They are the same standard with different names."
        ],
        "correct": 1,
        "explanation": "Fiduciary requires the client's interests come first. Suitability allows a 'fitting' recommendation even when better options exist. Same product, same client, different legal duty, different acceptable outcome."
      },
      {
        "id": "q2",
        "prompt": "Which federal law makes Registered Investment Advisers (RIAs) fiduciaries?",
        "options": [
          "Sarbanes-Oxley Act of 2002",
          "Investment Advisers Act of 1940",
          "Securities Act of 1933",
          "Dodd-Frank Act of 2010"
        ],
        "correct": 1,
        "explanation": "The Investment Advisers Act of 1940 establishes the regulatory framework for RIAs and the fiduciary duty under which they operate."
      },
      {
        "id": "q3",
        "prompt": "What is Regulation Best Interest (Reg BI)?",
        "options": [
          "A 2019 SEC regulation requiring brokers to act in the retail customer's best interest at the time of recommendation, raising the standard from pure suitability but stopping short of full fiduciary duty.",
          "A FINRA rule about insider trading.",
          "A state-level fiduciary requirement.",
          "A DOL rule about retirement accounts only."
        ],
        "correct": 0,
        "explanation": "Reg BI raised the broker standard above pure suitability for retail customers but did not impose full fiduciary duty. It applies at the moment of recommendation, requires conflicts disclosure, and mandates Form CRS. Distinct from the continuous fiduciary duty under the Advisers Act."
      },
      {
        "id": "q4",
        "prompt": "An advisor compares two retirement products: Product A is fee-based (1% AUM), Product B is a proprietary annuity paying 5% upfront commission. Both are 'suitable.' Under fiduciary duty, the advisor must:",
        "options": [
          "Recommend Product A because lower fees are always better.",
          "Recommend Product B because the firm benefits more.",
          "Compare them honestly on dimensions that matter to the client and recommend the genuinely better option — documenting why if Product B is chosen.",
          "Let the client decide without a recommendation."
        ],
        "correct": 2,
        "explanation": "Fiduciary duty requires honest comparison and a recommendation in the client's best interest. If Product B is genuinely better despite higher compensation, recommending it is fine — but the analysis must demonstrate why, not just that the product is 'suitable.'"
      },
      {
        "id": "q5",
        "prompt": "Which form must every Registered Investment Adviser file and provide to clients?",
        "options": [
          "Form 1099",
          "Form ADV",
          "Form W-9",
          "Form 5500"
        ],
        "correct": 1,
        "explanation": "Form ADV (Parts 2A and 2B in plain English) disclose services, fees, conflicts, disciplinary history of the firm and its representatives. Required for every RIA. Counselors should know where these live in the firm's onboarding materials."
      },
      {
        "id": "q6",
        "prompt": "Conflicts of interest in advisory practice are best handled by:",
        "options": [
          "Eliminating all conflicts entirely.",
          "Ignoring them since they're inherent to the business.",
          "Disclosing, mitigating, or avoiding each conflict as appropriate — applying the right level of response to the level of conflict.",
          "Letting compliance handle all of them."
        ],
          "correct": 2,
          "explanation": "Most conflicts cannot be eliminated and are inherent to advisor compensation structures. The professional response: disclose lower-stakes conflicts, mitigate larger ones through process and policy, and avoid the conflicts that cannot be ethically managed (personal financial relationships with clients, beneficiary designations, etc.)."
      },
      {
        "id": "q7",
        "prompt": "Which of the following are core principles of the CFP Board Code of Ethics?",
        "options": [
          "Aggressively grow client assets, generate referrals, minimize taxes, maximize returns.",
          "Honesty, integrity, competence and diligence; act in client's best interest; due care; manage conflicts; maintain confidentiality; reflect positively on the profession.",
          "Sell suitable products, document recommendations, supervise junior staff.",
          "Pass continuing education, file annual reports, pay dues on time."
        ],
        "correct": 1,
        "explanation": "These are the six core principles of the CFP Board Code of Ethics. They apply to all CFP professionals and form the foundation of professional standards in financial planning."
      },
      {
        "id": "q8",
        "prompt": "A grieving client recently inherited $1.2M and wants you to 'put it somewhere safe today.' What's the right counselor move?",
        "options": [
          "Recommend an immediate purchase of a balanced mutual fund — she said somewhere safe.",
          "Slow down, do thorough discovery over multiple meetings, park the funds in a high-yield savings or short Treasuries until the client has clarity, and document the approach.",
          "Refuse the client because she's not making informed decisions.",
          "Have her sign documents quickly while she's motivated."
        ],
        "correct": 1,
        "explanation": "A grieving client immediately after a major loss may not be in a state to make informed long-term decisions. The right move: slow down, build understanding through discovery, park the money in safe and liquid options, and resist external pressure to act quickly. This is fiduciary duty in practice — not just product selection."
      },
      {
        "id": "q9",
        "prompt": "Which is a red flag requiring immediate escalation to a supervisor?",
        "options": [
          "Client asks a question about an unfamiliar product.",
          "A request involving an account the client doesn't legally own (e.g., an elderly parent's account).",
          "Client wants to change asset allocation.",
          "Client misses a quarterly meeting."
        ],
        "correct": 1,
        "explanation": "Requests involving accounts the client doesn't legally control may signal elder abuse, unauthorized activity, or the need for proper authorization. Escalate immediately rather than proceed. The cost of escalation is small; the cost of doing nothing can be enormous."
      },
      {
        "id": "q10",
        "prompt": "Why are commission-based sales contests a particular concern under fiduciary duty?",
        "options": [
          "They violate the law.",
          "They are illegal under all circumstances.",
          "They create structural incentives that can override fiduciary judgment by paying advisors more for one product over another regardless of client benefit.",
          "They are taxed at higher rates."
        ],
        "correct": 2,
        "explanation": "Sales contests financially incentivize the advisor to recommend specific products, which can drive recommendations toward higher-commission options rather than the best client outcome. They're not necessarily illegal but they create powerful pressure against fiduciary duty. Many firms have eliminated them; many haven't."
      },
      {
        "id": "q11",
        "prompt": "The 'simple test' to apply before making a difficult ethical call is:",
        "options": [
          "Would my supervisor approve?",
          "Is it technically legal?",
          "If this decision became public tomorrow — to my client, my employer, regulators, and the press — would I be comfortable defending it?",
          "Will it generate revenue for the firm?"
        ],
        "correct": 2,
        "explanation": "The public-defensibility test captures the spirit of fiduciary duty better than any single technical rule. If you'd be comfortable defending the decision openly, document and proceed. If not, reconsider or escalate. This single question prevents most career-ending mistakes."
      },
      {
        "id": "q12",
        "prompt": "What characterizes the advisor who builds a 40-year career without regulatory issues?",
        "options": [
          "Generates the most fees and commissions.",
          "Treats every recommendation as if it might be reviewed five years from now; documents conflicts proactively; escalates uncomfortable conversations rather than swallowing them.",
          "Has the most clients.",
          "Avoids all regulators and lawyers."
        ],
        "correct": 1,
        "explanation": "The advisors who get sanctioned didn't usually intend violations — they drifted. Clean documentation, proactive disclosure, willingness to escalate, and the assumption that clean practice IS the business model are what makes a long career possible."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 9;

-- ── module10_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 10 CONTENT
-- Client Discovery & Intake
-- ============================================================================
update public.modules set
  title = 'Client Discovery & Intake',
  competency_id = 'OJL-1',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'The first conversation. How to gather what you need without making a client feel interrogated, and why the qualitative information matters more than the quantitative.',
  learning_objectives = ARRAY[
    'Conduct a structured first meeting that builds trust and surfaces the right information.',
    'Distinguish quantitative discovery (numbers) from qualitative discovery (goals, values, fears).',
    'Use open-ended questions effectively and listen actively.',
    'Recognize and adapt to family dynamics, money scripts, and emotional history with money.',
    'Document a discovery meeting in a way that allows a colleague to pick up the file cleanly.',
    'Identify when to defer questions or split discovery across multiple meetings.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The First Meeting",
      "summary": "The structure that gets discovery right — and the mistakes that derail it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The first meeting with a client sets the tone for everything that follows. A good first meeting is half listening, half clarifying, and ends with both parties knowing exactly what happens next. A bad first meeting is half pitch, half data collection, and leaves the client wondering why they came." },

        { "type": "callout", "kind": "key", "title": "The frame", "text": "Discovery is not data entry. Discovery is <em>understanding a household well enough to give them advice that fits them</em>. The numbers matter, but they're the easy part — the bank statements will arrive whether or not the meeting went well. The qualitative information either gets surfaced in the first conversations or doesn't surface at all." },

        { "type": "heading", "text": "A working structure for the first meeting" },
        { "type": "numbered", "items": [
          "<strong>Welcome and orientation (5 min).</strong> Make them comfortable. Explain how the meeting will run, how long it will take, that they can stop or ask questions anytime.",
          "<strong>Their story (15–20 min).</strong> Open with the broadest possible question and listen. \"Tell me what's going on in your financial life right now\" or \"What brought you in?\" Resist the urge to redirect, even if they wander.",
          "<strong>Goals and concerns (15 min).</strong> Surface what they want, what they're worried about, what's keeping them up. Ask follow-ups, not just the next question on the form.",
          "<strong>Quick quantitative scan (10–15 min).</strong> Get high-level numbers — income, savings, debts, family structure. Detailed gathering happens later via documents.",
          "<strong>Family and life context (10 min).</strong> Children, parents, dependents, health, expected changes.",
          "<strong>How you work (5 min).</strong> Explain your firm, your fiduciary duty, fees, services. Don't sell — orient.",
          "<strong>Next steps (5 min).</strong> Document what they'll send you (statements, tax returns, plan documents), when the next meeting is, what it will cover.",
          "<strong>Disclosures and Form ADV (during meeting or at end).</strong> Required for compliance. Set expectations for documents that will arrive in their inbox."
        ]},

        { "type": "callout", "kind": "do", "title": "The two questions to ask in every first meeting", "text": "<strong>(1)</strong> \"What would have to be true a year from now for you to feel like working with us was a good decision?\" — surfaces real goals.<br/><strong>(2)</strong> \"Tell me about your relationship with money growing up.\" — surfaces money scripts that shape every financial decision." },

        { "type": "heading", "text": "What a good first meeting feels like — to the client" },
        { "type": "list", "items": [
          "They did more talking than the advisor.",
          "They were asked at least one question no one had asked them before.",
          "They left with a written list of what to send and when.",
          "They felt understood rather than processed.",
          "They are clear on what the next meeting will accomplish and when it is."
        ]},

        { "type": "callout", "kind": "warn", "title": "Mistakes that destroy first meetings", "text": "Reading off the intake form. Selling services in the first half of the meeting. Cutting the client off when they're telling a story that doesn't seem 'on topic' — those stories ARE the topic. Making recommendations before discovery is complete. Pretending to understand when you don't. Avoiding awkward questions about death, divorce, illness, or family conflict — these are exactly the questions that produce the most planning value." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Quantitative Discovery",
      "summary": "Numbers, sources, and the documents that tell the real story.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Numbers are the easier half of discovery. A standard set of documents tells you almost everything you need about a household's quantitative situation. The skill is knowing what to ask for, how to organize it, and what to do when something is missing." },

        { "type": "heading", "text": "The standard intake document set" },
        { "type": "subheading", "text": "Income and employment" },
        { "type": "list", "items": [
          "Most recent pay stubs (showing gross, deductions, net, year-to-date) for each working adult.",
          "Most recent two years of W-2s.",
          "Self-employment: most recent two years Schedule C or business return, year-to-date P&L.",
          "Variable income (RSU, bonus, commission): vesting schedules, recent annual statements.",
          "Pension and Social Security statements (if applicable)."
        ]},

        { "type": "subheading", "text": "Tax returns" },
        { "type": "list", "items": [
          "Most recent two years of federal and state returns, all schedules.",
          "If pending an extension or amendment, status of that.",
          "Any IRS or state correspondence open."
        ]},

        { "type": "subheading", "text": "Assets" },
        { "type": "list", "items": [
          "Bank statements (checking, savings, money market) — most recent.",
          "Investment account statements — all of them. Brokerage, retirement, education savings, HSA.",
          "Real estate: current value estimate, mortgage balance, original cost basis if available.",
          "Business interests: most recent valuation if applicable.",
          "Other significant assets: collectibles, art, cryptocurrency, private investments."
        ]},

        { "type": "subheading", "text": "Liabilities" },
        { "type": "list", "items": [
          "Mortgage statement(s) showing current balance, rate, term.",
          "Other loan statements (auto, student, personal).",
          "Credit card statements showing balances and rates.",
          "Any other debts (medical, tax debt, personal loans)."
        ]},

        { "type": "subheading", "text": "Insurance" },
        { "type": "list", "items": [
          "Life insurance: declarations pages of all policies.",
          "Disability insurance: policy documents and employer benefit summaries.",
          "Health insurance: current plan and recent annual benefit statement.",
          "Property/casualty: declarations pages for auto, homeowners/renters, umbrella.",
          "Other: long-term care, annuities, specialty coverages."
        ]},

        { "type": "subheading", "text": "Estate documents" },
        { "type": "list", "items": [
          "Will (current version, all amendments).",
          "Trust documents (if any).",
          "Powers of attorney — durable financial and healthcare.",
          "Advance directives.",
          "Beneficiary designations on retirement accounts and life insurance — most recent confirmations."
        ]},

        { "type": "callout", "kind": "do", "title": "The intake checklist", "text": "Every firm should have a standard intake checklist organized by category. Send it before the first meeting if possible, or after the first meeting with deadlines. Reduce it to one page when possible — long lists trigger procrastination. Follow up at one week, two weeks, four weeks if items aren't arriving." },

        { "type": "callout", "kind": "warn", "title": "What incomplete information signals", "text": "When a client can't or won't produce a routine document, take it seriously. Sometimes it's disorganization. Sometimes it's shame about the actual numbers (especially debt). Sometimes it's marital secrecy. Sometimes there's a problem the client hasn't admitted to themselves yet. The advisor's job is to notice and proceed gently — not to demand or to ignore." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Qualitative Discovery",
      "summary": "Money scripts, family dynamics, and the questions that produce real insight.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Qualitative discovery is the harder half. It asks: <em>what does this household actually want, what are they afraid of, and what shapes their decisions?</em> No spreadsheet answers these questions. They emerge through conversation, careful listening, and questions that go beneath the surface." },

        { "type": "heading", "text": "Money scripts" },
        { "type": "paragraph", "text": "Coined by financial psychologists Brad and Ted Klontz, money scripts are unconscious beliefs about money formed in childhood and carried into adulthood. They shape financial behavior more than income does. Four common scripts:" },
        { "type": "list", "items": [
          "<strong>Money avoidance</strong> — money is bad, dirty, corrupting. Rich people are immoral. Result: subconscious sabotage of wealth-building. Underearning despite capability.",
          "<strong>Money worship</strong> — more money will solve life's problems. Happiness comes from accumulation. Result: workaholism, chronic dissatisfaction, debt to fund lifestyle.",
          "<strong>Money status</strong> — net worth equals self-worth. Spending signals identity. Result: lifestyle inflation, financial decisions driven by appearance.",
          "<strong>Money vigilance</strong> — money should be saved, not spent. Discussing finances is taboo. Generally the healthiest script, though extreme cases produce miserliness and inability to enjoy wealth."
        ]},
        { "type": "callout", "kind": "key", "title": "The advisor's role", "text": "You don't change a client's money scripts in a single meeting. You recognize them. The 60-year-old physician who 'doesn't deserve' to retire despite millions in assets is operating on a money script, not on numbers. The recently-promoted executive who immediately upgrades the house, the car, and the lifestyle is operating on a script too. Knowing the script shapes which recommendation will actually land." },

        { "type": "heading", "text": "Questions that surface qualitative information" },
        { "type": "subheading", "text": "About values and goals" },
        { "type": "list", "items": [
          "If money were no object, what would you do with the next ten years?",
          "What's a recent purchase that brought you real, lasting satisfaction?",
          "What do you wish you had more time for?",
          "What does \"enough\" look like for you?",
          "What's something you'd want to leave behind?"
        ]},

        { "type": "subheading", "text": "About fears" },
        { "type": "list", "items": [
          "What's the financial concern that wakes you up at 3 AM?",
          "What's the worst-case scenario you find yourself preparing for?",
          "What financial conversation are you avoiding?",
          "What would have to happen for things to go really wrong?"
        ]},

        { "type": "subheading", "text": "About the past" },
        { "type": "list", "items": [
          "Tell me about your relationship with money growing up.",
          "Did your parents argue about money? Talk about it?",
          "What's the best money decision you've ever made?",
          "What's a money mistake you'd want to avoid making again?"
        ]},

        { "type": "subheading", "text": "About family" },
        { "type": "list", "items": [
          "Who else has a stake in these decisions? Spouse, children, parents?",
          "Are there conversations happening at home about this we should know about?",
          "Are there family members who depend on you financially? Or might in the future?",
          "Has there been a financial event in your family — inheritance, business sale, illness — that shaped how you think about money now?"
        ]},

        { "type": "callout", "kind": "do", "title": "The technique that matters most", "text": "<strong>Silence after the question.</strong> Most advisors fill the silence after an open-ended question, robbing the client of the space to think and answer fully. Ask, then wait. The client's first answer is often surface-level; the second is often the real answer. The silence is what produces the second answer." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Family Dynamics and the Couple's Meeting",
      "summary": "When you're advising a household, you're advising a relationship.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients are not individuals — they're households. And household financial decisions are made by relationships, not by spreadsheets. A counselor who can read the relationship dimension produces planning that actually gets implemented." },

        { "type": "heading", "text": "The couple in the first meeting" },
        { "type": "subheading", "text": "Things to notice" },
        { "type": "list", "items": [
          "Who's doing the talking? Often one spouse handles money and the other defers. This isn't necessarily bad, but it's information about how decisions get made.",
          "Where do they disagree? Watch for body language when one answers a question — eye rolls, slight shake of the head, a look between them. Pause and ask: 'I get the sense you two might see this a little differently — am I right?'",
          "What language do they use? 'My money' vs. 'our money' is a window into the relationship structure, especially in second marriages.",
          "Who's anxious about what? Common pattern: one spouse worries about market risk, the other worries about not having enough."
        ]},

        { "type": "callout", "kind": "key", "title": "The seven topics couples disagree about", "text": "Most couples have at least one fundamental disagreement about: (1) <strong>how much risk is acceptable</strong>, (2) <strong>how much to give to adult children</strong>, (3) <strong>when to retire</strong>, (4) <strong>where to live in retirement</strong>, (5) <strong>how generous to be with charity</strong>, (6) <strong>how to handle aging parents</strong>, (7) <strong>what to leave to heirs</strong>. Get these surfaced early. The plan that ignores them isn't a plan — it's a paper exercise that breaks the first time real money is at stake." },

        { "type": "heading", "text": "When to recommend separate conversations" },
        { "type": "paragraph", "text": "Most discovery should happen with both spouses present. Some moments call for one-on-one conversation:" },
        { "type": "list", "items": [
          "Disclosure of past financial issues (debt, addiction, prior bankruptcy) the client may not have shared with the spouse.",
          "Disclosure of impending changes (job loss, intent to leave the marriage, health concerns).",
          "Family financial issues affecting one spouse's parents or siblings.",
          "Disagreements between spouses that are too charged to work through in front of each other."
        ]},
        { "type": "callout", "kind": "warn", "title": "The boundary", "text": "If a client tells you something privately that materially affects the planning — for example, an affair, a plan to divorce, a hidden account — you have a real ethical problem. You cannot plan honestly for the household while holding undisclosed information that would change the recommendations. Most firms have specific policies on this; know yours and consult compliance. The general principle: gently encourage disclosure, document the conversation, and decline to proceed on plans that depend on the undisclosed information." },

        { "type": "divider" },

        { "type": "heading", "text": "Multi-generational dynamics" },
        { "type": "paragraph", "text": "Increasingly, advisory engagements involve multiple generations: adult children advising aging parents, parents trying to help adult children, grandparents funding grandchildren's education. Each pattern has its own complexity." },
        { "type": "subheading", "text": "Common dynamics" },
        { "type": "list", "items": [
          "<strong>Adult child overstepping.</strong> Well-meaning child making decisions for capable parent. Watch for the autonomy of the actual client.",
          "<strong>Hidden caregiving costs.</strong> One adult child carrying most of the load for elderly parents; that cost rarely shows up in the parents' net worth statement.",
          "<strong>Inheritance expectations.</strong> Adult children making spending decisions based on expected inheritance that the parents have no intention of leaving them (or vice versa).",
          "<strong>Grandparent education funding.</strong> Generous but sometimes structured in ways that complicate financial aid, gift tax, or family relationships."
        ]},

        { "type": "case_study",
          "title": "The discovery meeting that surfaces what matters",
          "scenario": "A married couple comes in. He talks about retirement planning, target portfolio returns, the inheritance they'll receive from his mother eventually. She is quiet through most of the meeting. Toward the end you ask her: 'I'd love to hear what you most want to be true ten years from now.' She pauses, then says: 'I want to know that if something happens to him, I won't have to figure out the money alone.'",
          "discussion": "<p>In one sentence, the entire discovery just shifted. The plan he wants is about wealth accumulation. The plan she needs is about financial autonomy and her ability to manage the household alone if necessary.</p><p>A planner who builds the portfolio he asked for and skips her concern produces a 'plan' that completely misses what would make this a successful engagement for the household. The right move: pause, acknowledge what she just said, ask follow-ups (\"What would it look like for you to feel confident? What do you wish you knew that you don't?\"), and build her requirements explicitly into the goals.</p><p>The deliverable for this couple includes everything he wanted PLUS structures that make her financial life manageable on her own — simpler portfolios, named contingent contacts, clear documentation of what to do and who to call, regular check-ins with her specifically. <strong>This is what \"financial planning is half listening\" actually means in practice.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Documentation and Handoff",
      "summary": "How to leave a trail that lets a colleague pick up the file at any moment.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "The work of discovery is only as good as the documentation of it. A 90-minute meeting in your head is worth nothing two months later when you can't remember the details. The discipline of writing things up — promptly, completely, in your own words — is what makes discovery durable." },

        { "type": "heading", "text": "The discovery memo" },
        { "type": "paragraph", "text": "Within 24 hours of the meeting, capture in writing:" },
        { "type": "list", "items": [
          "<strong>Date, time, attendees.</strong>",
          "<strong>Format.</strong> In-person, video, phone.",
          "<strong>Top-line summary.</strong> One paragraph: who they are, what they want, where they are now, what's next.",
          "<strong>Quantitative snapshot.</strong> Income, current net worth, major assets, major debts. Note sources for each number.",
          "<strong>Goals.</strong> In their words first, then in planning terms. Time-bound when possible.",
          "<strong>Concerns and constraints.</strong> What worries them, what's off the table, what's non-negotiable.",
          "<strong>Family and life context.</strong> Marital status, dependents, parents, expected life changes.",
          "<strong>Money story.</strong> Brief — what came up about their relationship with money.",
          "<strong>Discovery gaps.</strong> What you didn't get to, what you still need to learn.",
          "<strong>Documents requested and status.</strong> What they're sending you and when.",
          "<strong>Next steps and next meeting.</strong> Scheduled or pending.",
          "<strong>Open issues for follow-up.</strong> Things flagged that need attention later."
        ]},

        { "type": "callout", "kind": "do", "title": "Capture impressions, not just facts", "text": "Good discovery memos include things like: 'She seemed visibly uncomfortable when discussing her mother's care needs — likely a sensitive area to revisit gently.' Or: 'He emphasized risk avoidance three times despite an aggressive current portfolio — possible mismatch between stated and actual tolerance.' These observations are planning gold and disappear if not captured." },

        { "type": "heading", "text": "The handoff principle" },
        { "type": "paragraph", "text": "Imagine you're hit by a bus tomorrow and a colleague has to take over this engagement. Can they read your files and continue the work with the client experiencing minimal disruption? If yes, your documentation is good enough. If no, fix it." },

        { "type": "callout", "kind": "key", "title": "Why this matters beyond bus accidents", "text": "Discovery files are read by: future-you in six months, a colleague covering during your vacation, the team lead reviewing the case, compliance during periodic audits, and (rarely) regulators in a complaint. Each of these readers needs to understand what happened and why. The discipline of documenting for those readers is the same discipline that protects your career, serves the client, and makes the firm professional." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the primary purpose of a first discovery meeting?",
        "options": [
          "Sell the firm's services.",
          "Collect the standard data set in the intake form.",
          "Understand the household well enough to advise them — surfacing both quantitative AND qualitative information.",
          "Make initial recommendations."
        ],
        "correct": 2,
        "explanation": "Discovery is about understanding, not data entry or selling. Documents will arrive whether or not the meeting goes well. Qualitative information (goals, fears, money scripts) either surfaces in conversation or doesn't surface at all."
      },
      {
        "id": "q2",
        "prompt": "Which two questions are most powerful in a first meeting?",
        "options": [
          "What's your risk tolerance? What's your income?",
          "What would have to be true a year from now for this to feel like a good decision? Tell me about your relationship with money growing up.",
          "What's your net worth? What's your time horizon?",
          "Have you worked with an advisor before? What did you not like?"
        ],
        "correct": 1,
        "explanation": "These two questions surface real goals (vs. surface answers) and money scripts (vs. behavior alone). Both produce information no standardized form will."
      },
      {
        "id": "q3",
        "prompt": "What is a 'money script'?",
        "options": [
          "A budget spreadsheet template.",
          "An unconscious belief about money formed in childhood that shapes adult financial behavior.",
          "The script a salesperson uses to close.",
          "A note on a check or wire transfer."
        ],
        "correct": 1,
        "explanation": "Money scripts (Klontz & Klontz) — money avoidance, money worship, money status, money vigilance — shape decisions more than income does. A counselor doesn't change a script in one meeting, but recognizing it shapes which recommendations will actually land."
      },
      {
        "id": "q4",
        "prompt": "After asking an open-ended question, what is the most important technique?",
        "options": [
          "Ask the next question immediately.",
          "Summarize what they said before they finish.",
          "Stay silent. Wait. Give them space to give a deeper second answer.",
          "Take notes loudly so they can see you're engaged."
        ],
        "correct": 2,
        "explanation": "Most advisors fill the silence after an open-ended question, robbing the client of space to think. Ask, then wait. The first answer is often surface; the second is often the real answer."
      },
      {
        "id": "q5",
        "prompt": "When a client can't or won't produce a routine document during intake (like a recent tax return), the most appropriate response is:",
        "options": [
          "Demand it immediately or refuse to continue.",
          "Ignore it and proceed with planning.",
          "Notice it, take it seriously — it may indicate shame, marital secrecy, or unresolved issues — and proceed gently while documenting.",
          "Drop the client; they're not serious."
        ],
        "correct": 2,
        "explanation": "Missing documents often signal something real beneath the surface — debt the client hasn't admitted to, marital secrecy, or a problem they haven't acknowledged. The advisor's job is to notice, not demand or ignore. Proceeding gently while watching for patterns is the right approach."
      },
      {
        "id": "q6",
        "prompt": "In a couples' first meeting, what is the right move when you notice one spouse subtly disagreeing with the other's answer?",
        "options": [
          "Ignore it and continue with the agenda.",
          "Press them to argue it out.",
          "Pause and ask: 'I get the sense you two might see this a little differently — am I right?' — surfacing the disagreement gently.",
          "Recommend they go to counseling."
        ],
        "correct": 2,
        "explanation": "Disagreements that get hidden in discovery become plan failures later. A gentle, named question opens the door without forcing an argument. Couples generally appreciate being seen accurately."
      },
      {
        "id": "q7",
        "prompt": "Which is NOT one of the seven topics couples commonly disagree about?",
        "options": [
          "How much risk is acceptable.",
          "When to retire.",
          "How much to give to adult children.",
          "Which mutual funds to buy."
        ],
        "correct": 3,
        "explanation": "The seven common disagreements: risk tolerance, support for adult children, retirement timing, retirement location, charity, aging parent decisions, and inheritance. Mutual fund selection is downstream — it's a product decision, not a values disagreement."
      },
      {
        "id": "q8",
        "prompt": "When a client privately tells you something they haven't shared with their spouse that would materially affect the planning (hidden debt, plans to divorce, hidden account), the right action is:",
        "options": [
          "Plan with the information, but keep the secret.",
          "Tell the spouse immediately.",
          "Gently encourage disclosure, document the conversation, decline to proceed on plans that depend on the undisclosed info, and consult firm compliance policy.",
          "Refuse to plan for the household at all."
        ],
        "correct": 2,
        "explanation": "Planning honestly while holding undisclosed material information is an ethical violation. The right path: encourage disclosure, document, refuse to build plans that depend on hidden information, and engage firm compliance. Know your firm's specific policy."
      },
      {
        "id": "q9",
        "prompt": "When should the discovery memo be written?",
        "options": [
          "Whenever there's time.",
          "Within 24 hours of the meeting, while memory is fresh.",
          "Quarterly, in batch.",
          "Only if requested by compliance."
        ],
        "correct": 1,
        "explanation": "Within 24 hours. Details fade fast. The 90-minute meeting that lives in your head Monday is half gone by Friday. The discipline of writing things up promptly is what makes discovery durable across time."
      },
      {
        "id": "q10",
        "prompt": "A good discovery memo includes:",
        "options": [
          "Only the verified quantitative numbers.",
          "Quantitative snapshot, goals, concerns, family context, money story, gaps, next steps, and YOUR impressions — including observations that flag sensitive areas.",
          "Just a list of documents received.",
          "Only what compliance requires."
        ],
        "correct": 1,
        "explanation": "Facts and impressions both. Notes like 'visibly uncomfortable discussing her mother's care' or 'emphasized risk avoidance despite an aggressive portfolio' are planning gold. Capture them while fresh."
      },
      {
        "id": "q11",
        "prompt": "A counselor's documentation should be good enough that:",
        "options": [
          "The client never has to repeat themselves.",
          "A colleague could pick up the file tomorrow and continue serving the client with minimal disruption.",
          "The compliance officer is happy.",
          "All of the above — but especially (B)."
        ],
        "correct": 3,
        "explanation": "All three are true, but the colleague-handoff test is the strongest version of the standard. If your files survive that test, they also satisfy the others — and they protect both the client and your career across vacations, departures, and reviews."
      },
      {
        "id": "q12",
        "prompt": "A client says she wants 'to know that if something happens to him, I won't have to figure out the money alone.' What does this require of the plan?",
        "options": [
          "Higher portfolio returns.",
          "Structures that make her financial life manageable on her own — simpler portfolios, named contacts, clear documentation, separate check-ins with her.",
          "More insurance on him.",
          "Estate planning documents only."
        ],
        "correct": 1,
        "explanation": "Her goal isn't returns — it's autonomy. The plan must build for her ability to manage independently if needed. This is qualitative discovery shaping concrete recommendations: simpler structures, documentation she can use, contact protocols, and meetings designed around her engagement. Missed by an advisor who only listens to the spouse who talks more."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 10;

-- ── module11_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 11 CONTENT
-- Goal-Setting & Prioritization
-- ============================================================================
update public.modules set
  title = 'Goal-Setting & Prioritization',
  competency_id = 'OJL-2',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'Turning vague aspirations into specific, time-bound, fundable goals — and helping clients choose between competing priorities when the math says they can''t have everything.',
  learning_objectives = ARRAY[
    'Translate vague client wishes into SMART planning goals.',
    'Apply a goal hierarchy that distinguishes survival, security, freedom, and legacy.',
    'Run trade-off conversations when client goals exceed available resources.',
    'Match each goal to an appropriate time horizon and funding strategy.',
    'Document goals in a way both client and colleague can reference.',
    'Update goals as life events and priorities shift over time.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "From Vague Wish to Plannable Goal",
      "summary": "What 'I want to retire someday' actually means when you turn it into something you can plan.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients rarely arrive with planning-ready goals. They arrive with wishes — 'I want to retire,' 'I want to be okay,' 'I want to give my kids a head start.' Half the value of a financial planning engagement is helping the client move from the wish to a specific, time-bound, fundable goal. Without that translation, the rest of the work is just guessing." },

        { "type": "callout", "kind": "key", "title": "The SMART standard, adapted for planning", "text": "<strong>Specific</strong> (what exactly), <strong>Measurable</strong> (in dollars or some unit), <strong>Actionable</strong> (achievable through identifiable steps), <strong>Relevant</strong> (connected to the client's actual values), and <strong>Time-bound</strong> (with a target year or age). Goals that lack any of these dimensions resist planning." },

        { "type": "heading", "text": "Examples of the translation" },
        { "type": "subheading", "text": "Vague: 'I want to retire someday.'" },
        { "type": "paragraph", "text": "Plannable: 'I want to retire by age 65 (in 23 years) with $75,000/year of inflation-adjusted spending power, lasting through age 95.'" },

        { "type": "subheading", "text": "Vague: 'I want to be financially comfortable.'" },
        { "type": "paragraph", "text": "Plannable: 'I want a fully funded 6-month emergency fund within 18 months, debt-free outside of mortgage within 5 years, and on track for retirement by age 50.'" },

        { "type": "subheading", "text": "Vague: 'I want to help my kids with college.'" },
        { "type": "paragraph", "text": "Plannable: 'I want to fund 4 years of in-state public university for each of my two kids — approximately $30,000/year in today's dollars, starting in 8 years for the older and 12 for the younger.'" },

        { "type": "subheading", "text": "Vague: 'I want to leave something for my children.'" },
        { "type": "paragraph", "text": "Plannable: 'I want at least $250,000 each to go to my two children after both my spouse and I are gone, in addition to whatever we use for our own care.'" },

        { "type": "heading", "text": "Why specificity matters" },
        { "type": "paragraph", "text": "Once a goal is specific, it can be:" },
        { "type": "list", "items": [
          "<strong>Costed.</strong> You know what it requires.",
          "<strong>Tracked.</strong> You can measure progress quarter-over-quarter.",
          "<strong>Traded off.</strong> When two goals compete, you can have the conversation in numbers, not feelings.",
          "<strong>Defended.</strong> The plan you build can be evaluated against the goal years later."
        ]},

        { "type": "callout", "kind": "do", "title": "The translation technique", "text": "When a client gives you a vague wish, ask the follow-ups that turn it into a SMART goal — gently, conversationally: \"When you imagine retiring, what age comes to mind?\" \"What does that look like — what would a typical week be?\" \"What kind of lifestyle — current spending, more, less?\" \"And if it doesn't work — if you couldn't retire then, what's the latest acceptable date?\" Each question adds a dimension. By the end you have a plannable goal in the client's own words." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Goal Hierarchy",
      "summary": "Survival, security, freedom, legacy — and which one wins when they collide.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Not all goals are equal. A simple hierarchy helps both advisor and client decide what comes first when resources are constrained — which is most of the time." },

        { "type": "callout", "kind": "key", "title": "The four levels", "text": "<strong>(1) Survival</strong> — meet current needs, protect against catastrophe.<br/><strong>(2) Security</strong> — eliminate destructive debt, build emergency reserves, ensure income protection.<br/><strong>(3) Freedom</strong> — accumulate assets that fund the life the client wants, with optionality.<br/><strong>(4) Legacy</strong> — transfer wealth or impact beyond the client's life." },

        { "type": "heading", "text": "Survival goals" },
        { "type": "list", "items": [
          "Meet monthly basic needs (housing, food, utilities, transportation, healthcare).",
          "Maintain employer health insurance or equivalent coverage.",
          "Make minimum payments on all debts to avoid default and credit damage.",
          "Protect against catastrophic income loss with appropriate insurance (life, disability, health)."
        ]},
        { "type": "paragraph", "text": "Survival goals win every trade-off. A plan that pushes investing or aggressive debt paydown while letting health insurance lapse or skipping mortgage payments is not a plan." },

        { "type": "heading", "text": "Security goals" },
        { "type": "list", "items": [
          "Build full 3–6 month emergency fund.",
          "Eliminate high-interest debt (credit cards, payday loans, anything 7%+).",
          "Capture employer 401(k) match.",
          "Establish adequate liability and umbrella coverage.",
          "Establish minimum-viable estate documents (will, POA, healthcare directive)."
        ]},

        { "type": "heading", "text": "Freedom goals" },
        { "type": "list", "items": [
          "Fully fund retirement (within tax-advantaged accounts, then taxable).",
          "Build assets that allow career flexibility, business launch, or other major life options.",
          "Pay down moderate-interest debt (mortgage acceleration, student loans).",
          "Fund children's education or other major dependent expenses.",
          "Build cash for major life purchases (home, second home, business)."
        ]},

        { "type": "heading", "text": "Legacy goals" },
        { "type": "list", "items": [
          "Estate planning above the minimum (trusts, advanced tax strategies).",
          "Wealth transfer to heirs.",
          "Charitable giving programs.",
          "Family business succession planning."
        ]},

        { "type": "callout", "kind": "do", "title": "The diagnostic question", "text": "<em>Which level of the hierarchy is this household truly secure at?</em> Many clients arrive saying 'I want to think about legacy' while their security level is incomplete. The advisor's job is to gently re-anchor: legacy planning is wonderful AND we need to make sure the foundation is solid first. The Marcus and Tasha households of the world don't need to talk about generational wealth transfer — they need to fix the periodic-expense gap from Module 1." },

        { "type": "callout", "kind": "warn", "title": "The exception to the hierarchy", "text": "Capture of employer 401(k) match (Security level) is typically worth doing even before the emergency fund is complete, because the match is effectively a 50–100% guaranteed return that disappears if not captured each year. Most planners adjust the hierarchy slightly for this single exception." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Trade-Offs When Goals Compete",
      "summary": "What to do when the math says the client can't have everything.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The most common moment in financial planning is the moment when the client's stated goals require more than their resources can produce. The advisor either runs an honest trade-off conversation or quietly builds an unrealistic plan that disappoints later. The first option is harder. It's also the job." },

        { "type": "heading", "text": "The trade-off conversation, structurally" },
        { "type": "numbered", "items": [
          "<strong>State the gap clearly.</strong> \"At your current savings rate, projected to retirement at 65, you'd have approximately $1.1M. Your stated need is approximately $1.8M. There's a gap of roughly $700,000 we need to close.\"",
          "<strong>Identify the levers.</strong> Save more, work longer, spend less in retirement, take more investment risk, get higher returns. Maybe inherit something. Those are the levers — there aren't others.",
          "<strong>Quantify each lever.</strong> What would it take? \"To close the gap by saving more, we'd need an additional $X per month. By delaying retirement to 67, the gap drops to $Y. By reducing retirement spending by 15%, $Z.\"",
          "<strong>Hand the choice to the client.</strong> The client decides which combination of levers fits their life. The advisor's job is to make the trade-off visible, not to choose for them.",
          "<strong>Document the decision and the alternatives considered.</strong> Years from now, both client and advisor should be able to remember why the plan looks the way it does."
        ]},

        { "type": "callout", "kind": "key", "title": "The reframe that helps", "text": "Don't ask <em>'what are you willing to give up?'</em> — it puts everything in the language of loss. Ask <em>'given these options, which version of this plan feels most like the life you want?'</em> Same trade-off, different emotional posture. The first frame produces resistance; the second produces choices." },

        { "type": "divider" },

        { "type": "heading", "text": "Trade-off scenarios" },
        { "type": "subheading", "text": "Retirement vs. kids' college" },
        { "type": "paragraph", "text": "The clearest competing-goal scenario for parents. The right answer almost always tilts toward retirement because:" },
        { "type": "list", "items": [
          "Children can borrow for college; parents cannot borrow for retirement.",
          "Time-value-of-money math heavily favors letting retirement assets compound longer.",
          "If parents under-save and can't retire, the burden may eventually fall on the children anyway."
        ]},
        { "type": "paragraph", "text": "Most planners recommend funding retirement first, then funding college from the remaining capacity. This is not what most parents want to hear, and the conversation requires care — but the math is consistent." },

        { "type": "subheading", "text": "Debt paydown vs. investing" },
        { "type": "paragraph", "text": "Generally, compare guaranteed debt rate to expected after-tax investment return:" },
        { "type": "list", "items": [
          "Debt rate above expected investment return → pay debt first (mathematical certainty).",
          "Debt rate near or below expected investment return → behavioral and tax considerations dominate. Many clients sleep better with debt paid down, even if math is slightly against it. Tax-deductibility of mortgage interest can shift the comparison.",
          "Very low-rate debt (e.g., 2.5% mortgage in 2021) — most planners recommend investing instead of accelerating paydown."
        ]},

        { "type": "subheading", "text": "Lifestyle now vs. wealth later" },
        { "type": "paragraph", "text": "The deepest values question in personal finance. The advisor's role is not to impose a value, but to make the trade-off visible:" },
        { "type": "list", "items": [
          "What does an extra $1,000/month of current lifestyle cost in eventual retirement income? (Use TVM from Module 2.)",
          "What does saving an extra $1,000/month now buy in retirement income?",
          "Neither answer is right. Clients have to choose, and they choose better when they see the math."
        ]},

        { "type": "case_study",
          "title": "The Marcus and Tasha trade-off",
          "scenario": "Marcus (42) and Tasha (41) want to: (1) save more for retirement, (2) help both their kids go to college without student debt, (3) take a major family trip every other year, and (4) eventually buy a second home in the mountains for retirement. Combined gross income $148,000. Current saving capacity after the fixes from Module 1: roughly $30,000/year.",
          "discussion": "<p>The total cost of all four goals far exceeds what $30,000/year can fund over the remaining 23 years to retirement. Trade-off conversation:</p><ul><li><strong>Retirement (must-fund):</strong> $20,000/year going into 401(k)s and Roth IRAs. Realistic projected balance at 65: roughly $1.6M.</li><li><strong>College (modify the goal):</strong> $5,000/year into 529 accounts. Won't fully fund both kids at private schools, but covers in-state public university with modest gap they could finance.</li><li><strong>Travel (annualize):</strong> $3,000/year into a sinking fund for trips every other year. They don't give it up — they fund it explicitly.</li><li><strong>Mountain home (defer or modify):</strong> Honestly tabled for the next 5 years. Revisit when retirement is more secure and college is more in view. Possibly funded by a downsize of the primary home at retirement.</li></ul><p>The plan now fits the available resources, and the client makes the choices about which goals get priority. Both Marcus and Tasha know what's funded, what's modified, and what's deferred. <strong>That's planning. The plan that quietly fails to mention the mountain home is fragile until the day they bring it up.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Matching Goals to Time Horizons",
      "summary": "Money for next year and money for 30 years from now do not live in the same place.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every goal has a time horizon. The time horizon determines where the money should live — cash, bonds, stocks, real estate, illiquid alternatives — because the right investment for one horizon is the wrong investment for another." },

        { "type": "callout", "kind": "key", "title": "The horizon-allocation principle", "text": "Money needed soon must be safe and liquid. Money needed later can take risk for higher expected returns. Mismatching these is one of the most common and costly errors in personal finance." },

        { "type": "heading", "text": "Standard horizons and allocation" },
        { "type": "subheading", "text": "0–1 year — Cash" },
        { "type": "list", "items": [
          "Emergency fund.",
          "Money for known near-term expenses (taxes due, planned major purchases, tuition coming up).",
          "Vehicle: High-yield savings, money market, short Treasuries. No exposure to market volatility."
        ]},

        { "type": "subheading", "text": "1–5 years — Conservative" },
        { "type": "list", "items": [
          "Down payment on a home being purchased in a couple of years.",
          "Education funding for a child currently in late high school.",
          "Sabbatical or career-transition cash.",
          "Vehicle: Short- to intermediate-term Treasuries, CDs, conservative bond funds, modest equity exposure (15–30%) only if some flexibility on timing exists."
        ]},

        { "type": "subheading", "text": "5–15 years — Balanced" },
        { "type": "list", "items": [
          "Education funding for younger children.",
          "Major lifestyle goals (career change, business launch, second home).",
          "Mid-career retirement assets approaching withdrawal.",
          "Vehicle: Balanced portfolio (40–70% equities), typically diversified across asset classes."
        ]},

        { "type": "subheading", "text": "15+ years — Growth" },
        { "type": "list", "items": [
          "Long retirement.",
          "Young children's college (when child is under 6).",
          "Multi-generational wealth.",
          "Vehicle: Growth-oriented portfolio (70–100% equities), diversified globally. Long horizon allows volatility to wash out."
        ]},

        { "type": "callout", "kind": "warn", "title": "The classic horizon mistake", "text": "Putting house-down-payment money (3-year horizon) into the stock market because returns look attractive. If the market drops 30% in year 2, the timing of the home purchase is broken. Conversely: keeping decades' worth of retirement savings in cash because of fear, missing the growth that long horizons are <em>for</em>. Both are common; both are expensive." },

        { "type": "heading", "text": "When horizons overlap" },
        { "type": "paragraph", "text": "Retirement isn't a single moment — it's a 30-year withdrawal period. Different layers of the retirement portfolio serve different horizons within retirement itself:" },
        { "type": "list", "items": [
          "<strong>Years 1–3</strong> of retirement spending: cash and short bonds, so a market crash doesn't force sales at the bottom.",
          "<strong>Years 4–10</strong>: intermediate bonds and balanced exposure.",
          "<strong>Years 10+</strong>: growth-oriented, because the money won't be touched for a decade."
        ]},
        { "type": "paragraph", "text": "This is the foundation of the bucket strategy or sequence-of-returns management — covered more deeply in the Retirement Planning module (CORE-7). Discovery and goal-setting is where the horizons get clarified; portfolio construction is where they get implemented." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Documenting Goals and Keeping Them Alive",
      "summary": "Goals don't stay set. They evolve as life evolves.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "Goals are not set once and filed away. They change as life changes — and the advisor who treats them as a one-time exercise eventually has a plan that no longer fits the client. Living documents only stay living through ongoing care." },

        { "type": "heading", "text": "What goal documentation includes" },
        { "type": "list", "items": [
          "Goal statement in plain language, in the client's words where possible.",
          "Target dollar amount (in today's dollars and/or future dollars, with assumption documented).",
          "Target date or age.",
          "Priority level — must-fund, important, aspirational. Helps when trade-offs come up later.",
          "Funding source — which account, which monthly contribution.",
          "Status — on track, behind, ahead.",
          "Last review date."
        ]},

        { "type": "heading", "text": "Review cadence" },
        { "type": "list", "items": [
          "<strong>Annually</strong>: full review with the client. What changed? What new goals? What old goals are no longer relevant? Status of each.",
          "<strong>Quarterly</strong>: light check-in. Status updates, any urgent changes flagged.",
          "<strong>Life-event triggered</strong>: marriage, divorce, child, job change, inheritance, health diagnosis, business sale — any of these may demand an unscheduled goals refresh."
        ]},

        { "type": "callout", "kind": "do", "title": "The closing question for every review", "text": "\"Has anything changed in the last 12 months that we should think about?\" Open enough that something might surface. Direct enough that the client knows you actually want to hear it. Specific examples worth probing: jobs, dependents, health, family relationships, business situations, large purchases planned." },

        { "type": "callout", "kind": "key", "title": "Why goals are the deliverable, not the plan", "text": "Clients often think the deliverable of financial planning is the plan document — the binder, the dashboard, the projection. It isn't. The deliverable is <em>clarity about what they're building toward and confidence that the plan supports it</em>. The numbers serve the goals; the goals don't serve the numbers. Counselors who keep this orientation produce better advice and longer-lasting client relationships." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What does it mean to translate a 'wish' into a SMART goal?",
        "options": [
          "Make it sound more professional in writing.",
          "Make it Specific, Measurable, Actionable, Relevant, and Time-bound.",
          "Use SMART software for tracking.",
          "Add a budget to it."
        ],
        "correct": 1,
        "explanation": "SMART criteria — specificity, measurability, actionability, relevance, and time-bound — convert vague wishes ('I want to retire someday') into plannable goals ('I want to retire at 65 with $75,000/year inflation-adjusted spending lasting through age 95')."
      },
      {
        "id": "q2",
        "prompt": "Which level of the goal hierarchy comes first in trade-offs?",
        "options": [
          "Legacy",
          "Freedom",
          "Security",
          "Survival"
        ],
        "correct": 3,
        "explanation": "Survival (basic needs, catastrophic protection) wins every trade-off. A plan that pushes investing while letting health insurance lapse isn't a plan."
      },
      {
        "id": "q3",
        "prompt": "What is the typical exception to the strict goal hierarchy?",
        "options": [
          "Charitable giving comes before retirement.",
          "Capturing employer 401(k) match is typically done even before the emergency fund is complete, because the match is essentially a guaranteed 50–100% return that disappears if not captured.",
          "Estate planning comes before debt paydown.",
          "Insurance comes after investing."
        ],
        "correct": 1,
        "explanation": "Employer match is the rare guaranteed return that expires annually. Most planners advise capturing the match even before fully building the emergency fund. Few other goals justify departing from the survival → security → freedom → legacy order."
      },
      {
        "id": "q4",
        "prompt": "When client goals exceed available resources, the right move is:",
        "options": [
          "Quietly build the most realistic plan you can and hope they don't notice.",
          "Refuse to plan.",
          "State the gap clearly, identify and quantify the levers (save more, work longer, spend less, take more risk), then hand the choice to the client and document the decision.",
          "Tell them their goals are unrealistic."
        ],
        "correct": 2,
        "explanation": "The trade-off conversation, run honestly, is what financial planning IS. Make the gap visible, quantify the levers, let the client choose the combination that fits their life. Document the alternatives considered."
      },
      {
        "id": "q5",
        "prompt": "When retirement funding and college funding compete for the same dollar, the typical recommendation is to prioritize retirement because:",
        "options": [
          "Retirement is more important than children.",
          "Children can borrow for college, but parents cannot borrow for retirement; under-saved parents may eventually become a burden on the children anyway.",
          "Tax laws favor it.",
          "College is not really necessary."
        ],
        "correct": 1,
        "explanation": "The math and structural logic favor retirement first. Children have access to loans; parents don't. Under-funded retirement often forces eventual reliance on adult children — the very thing parents typically want to avoid. Not what most parents want to hear, but consistent."
      },
      {
        "id": "q6",
        "prompt": "Money needed within 1 year should live in:",
        "options": [
          "A diversified stock portfolio for growth.",
          "Real estate.",
          "High-yield savings, money market, or short Treasuries — safe and liquid.",
          "Long-term bonds."
        ],
        "correct": 2,
        "explanation": "Short horizon = no exposure to market volatility. The right investment for a 30-year goal is the wrong investment for a 1-year goal. Mismatching is one of the most expensive errors in personal finance."
      },
      {
        "id": "q7",
        "prompt": "Money for a goal 15+ years away can appropriately be invested in:",
        "options": [
          "Mostly cash to avoid volatility.",
          "Mostly stocks (70–100%), diversified globally — long horizon allows volatility to wash out and growth to compound.",
          "Only certificates of deposit.",
          "Real estate only."
        ],
        "correct": 1,
        "explanation": "Long horizons are what growth investing is for. Cash for a 30-year goal nearly guarantees underperformance to inflation. Equity volatility, painful in 1-year windows, washes out across 15+ year horizons in historical data."
      },
      {
        "id": "q8",
        "prompt": "Within a retirement portfolio, why might different 'buckets' have different time horizons?",
        "options": [
          "Bucket strategies are gimmicks.",
          "Different years of retirement spending have different time horizons — the first few years are short-horizon and need safety, while later decades remain long-horizon and benefit from growth exposure.",
          "Tax law requires bucketing.",
          "It increases trading fees."
        ],
        "correct": 1,
        "explanation": "Retirement is a 30-year withdrawal period, not a single moment. Money needed in years 1–3 of retirement is short-horizon; money needed in years 15–30 is still long-horizon. Bucketing aligns each layer of the portfolio to its actual time horizon, mitigating sequence-of-returns risk."
      },
      {
        "id": "q9",
        "prompt": "How often should goals be reviewed?",
        "options": [
          "Once when the plan is built, then never.",
          "Annually with the client, with lighter quarterly check-ins and life-event-triggered updates as needed.",
          "Only when the client asks.",
          "Every five years."
        ],
        "correct": 1,
        "explanation": "Annual full reviews. Quarterly light check-ins. Plus immediate refresh on major life events (marriage, divorce, child, job change, inheritance, health, business sale). Goals are living documents."
      },
      {
        "id": "q10",
        "prompt": "What is the closing question worth asking in every review?",
        "options": [
          "Are you happy with our returns?",
          "Has anything changed in the last 12 months that we should think about?",
          "Do you want to add money?",
          "Should we increase your risk?"
        ],
        "correct": 1,
        "explanation": "Open enough to surface things you don't know. Direct enough that the client knows you actually want to hear. Captures the life events that change priorities — job, family, health, relationships, business — before they break the plan."
      },
      {
        "id": "q11",
        "prompt": "What is the deliverable of financial planning, really?",
        "options": [
          "The binder, plan document, or dashboard.",
          "Clarity about what the client is building toward and confidence that the plan supports it.",
          "The portfolio.",
          "A signed agreement."
        ],
        "correct": 1,
        "explanation": "The artifacts are not the deliverable. The deliverable is clarity and confidence. Counselors who keep this orientation produce better advice and longer client relationships. The numbers serve the goals — not the other way around."
      },
      {
        "id": "q12",
        "prompt": "A client says 'I want to think about legacy planning' but their cash flow shows a structural monthly deficit. What's the right reframe?",
        "options": [
          "Build the legacy plan; cash flow is separate.",
          "Refuse to discuss legacy until they fix the cash flow.",
          "Gently re-anchor: legacy planning is wonderful, AND we need to make sure the foundation is solid first. Address the cash flow gap as the immediate priority while keeping the legacy goal in view.",
          "Tell them they can't afford to think about legacy."
        ],
        "correct": 2,
        "explanation": "Honor the aspiration while honestly assessing where they truly are in the goal hierarchy. Most clients who want to discuss legacy planning are still working on security — they may not realize it. The gentle re-anchor preserves the relationship and refocuses on the work that has to happen first."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 11;

-- ── module12_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 12 CONTENT
-- Document Collection & Analysis
-- ============================================================================
update public.modules set
  title = 'Document Collection & Analysis',
  competency_id = 'OJL-3',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'How to gather, organize, and read the documents that tell the real story of a client''s financial life — tax returns, statements, policies, and the gaps between them.',
  learning_objectives = ARRAY[
    'Gather and organize the standard document set efficiently and securely.',
    'Read a personal tax return (Form 1040 and key schedules) and extract planning-relevant information.',
    'Analyze investment account statements for fees, allocation, and red flags.',
    'Read an insurance policy declarations page and benefit summary.',
    'Identify document gaps and what they typically signal.',
    'Store and protect client documents according to firm and regulatory standards.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Gathering and Organizing the Document Set",
      "summary": "How to ask, how to follow up, and how to keep your sanity through the intake process.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Document collection is the connective tissue between discovery and planning. Without the documents, the advisor is working from client memory — which is unreliable, often optimistic, and full of small errors. With the documents, the advisor can see what's actually happening. Many planning surprises live in pages the client never opens." },

        { "type": "heading", "text": "The standard intake set" },
        { "type": "paragraph", "text": "Building on the categories introduced in Module 10:" },
        { "type": "list", "items": [
          "<strong>Identity and household</strong>: government ID, marriage certificate (if applicable), dependent info.",
          "<strong>Income</strong>: recent pay stubs, two years of W-2s, self-employment financials.",
          "<strong>Tax returns</strong>: two most recent years federal and state, all schedules.",
          "<strong>Bank accounts</strong>: recent statements for all checking, savings, money market.",
          "<strong>Investment accounts</strong>: recent statements for all brokerage, retirement, education, HSA.",
          "<strong>Debts</strong>: mortgage(s), auto loans, student loans, credit cards, any other.",
          "<strong>Insurance</strong>: declarations pages and policy summaries for life, disability, health, P&C, umbrella.",
          "<strong>Employer benefits</strong>: most recent benefits summary, equity comp documents (RSU vesting, options).",
          "<strong>Estate</strong>: will, trust documents, powers of attorney, advance directive, beneficiary designations.",
          "<strong>Real estate</strong>: deeds, recent property tax bills, appraisals if available.",
          "<strong>Business interests</strong>: business returns, operating agreements, partnership/shareholder agreements.",
          "<strong>Other</strong>: anything client flagged as significant — collectibles, crypto wallets, private investments."
        ]},

        { "type": "heading", "text": "How to ask without overwhelming" },
        { "type": "callout", "kind": "do", "title": "The one-page intake checklist", "text": "Reduce the request list to a single, well-organized page. Long lists trigger procrastination. Group items by location: 'Probably in your filing cabinet' / 'Probably in your online accounts' / 'Probably from your employer's HR portal'. Set a target date — typically 2–3 weeks from the first meeting. Follow up at 1, 2, and 3 weeks if items are missing." },

        { "type": "heading", "text": "Secure transmission" },
        { "type": "paragraph", "text": "Client documents contain SSNs, account numbers, addresses, dates of birth, and everything else identity thieves want. Email is not appropriate for this material." },
        { "type": "list", "items": [
          "<strong>Use the firm's secure document portal.</strong> Every modern advisory firm should have one. Train clients to use it before they need to use it.",
          "<strong>Encrypted email with strong password if portal unavailable.</strong> Send the password separately (text, voice, or different email thread).",
          "<strong>Physical drop-off and pickup</strong> remain acceptable, with appropriate chain-of-custody handling at the office.",
          "<strong>Never use unencrypted email for documents containing SSNs, account numbers, or financial details.</strong> Tell clients why."
        ]},

        { "type": "heading", "text": "Organizing what arrives" },
        { "type": "list", "items": [
          "Standard folder structure in the firm's document system — same structure for every client makes audits and handoffs cleaner.",
          "Naming convention: client_name / category / document_type_date (e.g., 'jackson_marcus / tax / 1040_2024.pdf').",
          "Date received and verified noted in client file or CRM.",
          "Acknowledge receipt to client — closes the loop and signals professionalism."
        ]},

        { "type": "callout", "kind": "warn", "title": "What missing documents commonly signal", "text": "Repeat reminders for tax returns: possibly an extension or amendment in progress, possibly an IRS issue. Avoidance of credit card statements: possibly higher debt than disclosed. Missing insurance dec pages: possibly inadequate coverage the client doesn't want to expose. None of these is necessarily nefarious — most are mundane. But notice the pattern and ask gently." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Reading a Tax Return",
      "summary": "What Form 1040 and its schedules tell you about a client — that they didn't.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "The tax return is the single most informative document in financial planning. Almost everything financially material about a client shows up somewhere in it. A counselor who can read a 1040 fluently extracts in 20 minutes what would otherwise take three meetings to uncover." },

        { "type": "heading", "text": "Form 1040 — the cover page" },
        { "type": "paragraph", "text": "The 1040 is short — typically two pages. Each line tells you something about the client." },
        { "type": "subheading", "text": "Filing status (top of return)" },
        { "type": "paragraph", "text": "Married filing jointly, married filing separately, single, head of household, qualifying widow(er). Confirms household structure. MFS is unusual and often signals a specific issue (asset protection, problematic spouse, separating couple)." },
        { "type": "subheading", "text": "Dependents listed" },
        { "type": "paragraph", "text": "Children, qualifying relatives. Cross-check against discovery — if client mentioned 3 kids but only 2 are listed, ask why." },

        { "type": "subheading", "text": "Income lines (Form 1040 lines 1–8)" },
        { "type": "list", "items": [
          "<strong>Wages (line 1)</strong> — should match the W-2s.",
          "<strong>Interest (line 2)</strong> — taxable interest from bank accounts and bonds. Also notice tax-exempt interest on 2a — often municipal bonds.",
          "<strong>Dividends (line 3)</strong> — taxable and qualified (the second is taxed at long-term cap gains rates). Significant qualified dividends suggest substantial taxable equity holdings.",
          "<strong>IRA distributions (line 4)</strong> — relevant for clients in or near retirement; taxable amount may differ from gross.",
          "<strong>Pensions and annuities (line 5)</strong> — taxable retirement income.",
          "<strong>Social Security (line 6)</strong> — taxable portion of SS benefits (up to 85% can be taxable based on income).",
          "<strong>Capital gains/losses (line 7)</strong> — from Schedule D; positive number means realized gains, negative means realized losses (capped at $3,000/year of net loss deductible against ordinary income).",
          "<strong>Other income (line 8)</strong> — from Schedule 1; gig work, unemployment, alimony received, etc."
        ]},

        { "type": "heading", "text": "Schedules that matter most" },
        { "type": "subheading", "text": "Schedule A — Itemized deductions" },
        { "type": "paragraph", "text": "If filed: state and local taxes (capped at $10,000), mortgage interest, charitable giving, medical expenses above 7.5% of AGI. Charitable giving on Schedule A is a window into values; mortgage interest tells you about the mortgage size and rate stage; SALT cap tells you the client is in a high-tax state. If not filed (took the standard deduction): client likely has fewer planning levers via itemized deductions." },

        { "type": "subheading", "text": "Schedule B — Interest and dividends" },
        { "type": "paragraph", "text": "Required when interest or dividends exceed $1,500. Lists payers — gives you the institutions holding the client's accounts. Useful for confirming you have statements from all of them." },

        { "type": "subheading", "text": "Schedule C — Self-employment" },
        { "type": "paragraph", "text": "Sole proprietor or single-member LLC business income. Reveals: gross revenue, major expense categories, net profit. Net profit drives self-employment tax and qualifies the client for solo 401(k) or SEP-IRA contributions. Sustained Schedule C losses raise IRS hobby-loss concerns and planning questions." },

        { "type": "subheading", "text": "Schedule D and Form 8949 — Capital gains and losses" },
        { "type": "paragraph", "text": "Realized investment gains and losses for the year. Short-term and long-term separated. Useful for: identifying tax-loss harvesting history, spotting concentrated positions being unwound, understanding the client's tendency to trade. Large unused capital loss carryovers (from prior years) are valuable assets — they offset future gains tax-free." },

        { "type": "subheading", "text": "Schedule E — Rental income, royalties, K-1s" },
        { "type": "paragraph", "text": "Investment property income (and expense), royalty income, and pass-through income from partnerships and S-corps (via K-1s). Reveals: rental property ownership the client may not have mentioned in passing, business ownership through entities, complexity that requires specialist coordination." },

        { "type": "subheading", "text": "Schedule 1 — Additional income and adjustments" },
        { "type": "paragraph", "text": "Includes: unemployment, gambling winnings, IRA contribution deductions, HSA contribution deductions, student loan interest, self-employed health insurance, half of SE tax. Quick way to see whether the client is using HSA or IRA deductions." },

        { "type": "callout", "kind": "key", "title": "The single most useful number on the return", "text": "<strong>Adjusted Gross Income (AGI)</strong> — line 11 on the 1040. Drives Roth contribution limits, IRA deductibility, Medicare premium tiers (IRMAA), and many credit phaseouts. Compare current AGI to prior year and to projected next year — trend often matters more than absolute level." },

        { "type": "callout", "kind": "do", "title": "The tax return read-through", "text": "First pass: scan the 1040 cover page, look at every line item with a dollar amount. Second pass: open each schedule, read the totals. Third pass: read the explanation lines and any unusual items. Allow 20–30 minutes for a complex return on first read. Make notes: what surprises you? What's missing? What planning opportunities are visible? Keep these in the client file." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Investment Statements",
      "summary": "What an account statement tells you — and what to be suspicious of.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment statements share a common structure across custodians, even if the formatting differs. Knowing what to look for converts a stack of paper into a clear picture of the client's portfolio." },

        { "type": "heading", "text": "What every statement contains" },
        { "type": "list", "items": [
          "<strong>Account holder, account number, account type</strong> (taxable, IRA, Roth, 401(k), etc.). Account type drives tax treatment.",
          "<strong>Period covered</strong> — usually monthly, quarterly, or annual.",
          "<strong>Beginning and ending balance.</strong>",
          "<strong>Positions held</strong> — security name, ticker, share count, current value.",
          "<strong>Cost basis</strong> — for taxable accounts, what the position was purchased for. Critical for tax planning.",
          "<strong>Income received</strong> — dividends and interest paid into the account.",
          "<strong>Activity</strong> — purchases, sales, contributions, distributions, dividends reinvested, fees charged."
        ]},

        { "type": "heading", "text": "What to scan for" },
        { "type": "subheading", "text": "Asset allocation" },
        { "type": "paragraph", "text": "What percentage of the account is in stocks, bonds, cash, alternatives? Does it match the stated risk tolerance? A 65-year-old client who says \"I'm conservative, I can't handle losses\" but holds a 95% equity portfolio has a mismatch that will hurt them in the next downturn." },

        { "type": "subheading", "text": "Concentration risk" },
        { "type": "paragraph", "text": "Any single position over 10% of the portfolio? Common scenarios: legacy employer stock, an inherited concentrated position, a winning bet they haven't trimmed. Concentration may be appropriate in specific circumstances, but it needs to be a deliberate choice — and the client needs to know what risk they're carrying." },

        { "type": "subheading", "text": "Fees" },
        { "type": "paragraph", "text": "Expense ratios on each fund. Account-level fees (custodial, IRA maintenance, etc.). Advisor fees if applicable. The cost of holding an investment over decades compounds — a 1.5% expense ratio costs the client roughly 30% of their potential ending wealth over 30 years versus a 0.1% alternative. Read these line items." },

        { "type": "subheading", "text": "Trading activity" },
        { "type": "paragraph", "text": "How often do trades happen? Is there a pattern? Excessive trading drives tax inefficiency in taxable accounts and may signal a previous advisor who churned. Inactivity in a 25-year-old's 401(k) sitting in a money market fund (something not uncommon) signals neglect, not strategy." },

        { "type": "callout", "kind": "warn", "title": "Red flags in investment statements", "text": "Unfamiliar or illiquid private investments (especially in retirement accounts) — high risk and often high fees. Variable annuities with surrender charges still in effect. Significant cash holdings in long-term accounts that have been there for years. Holdings labeled 'proprietary' with names matching a prior advisor's firm. Highly concentrated single-stock positions without a documented reason. Excessive number of overlapping mutual funds (e.g., 8 different large-cap funds doing the same thing)." },

        { "type": "heading", "text": "Cost basis lots — why they matter" },
        { "type": "paragraph", "text": "When the client bought 1,000 shares of a stock over 10 years in 50 separate purchases, each \"lot\" has its own basis. When selling some shares, the choice of which lots to sell affects the tax outcome:" },
        { "type": "list", "items": [
          "<strong>First-in, first-out (FIFO)</strong> — sells oldest shares first. Usually the highest gain (oldest shares appreciated most).",
          "<strong>Specific identification</strong> — pick the exact lots to sell. Used for tax optimization (sell highest-basis lots to minimize realized gain, or sell loss lots for tax-loss harvesting).",
          "<strong>Average cost</strong> — only for mutual funds; uses average basis across all shares. Once chosen, generally stuck with for that fund."
        ]},
        { "type": "callout", "kind": "do", "title": "Default rule for taxable accounts", "text": "Set cost basis tracking to <strong>specific identification</strong> on all taxable accounts unless there's a reason not to. This preserves the flexibility to optimize tax outcomes at sale time. FIFO is fine for mutual funds where averaging happens anyway. Get this set early in the relationship." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Insurance Policies and Benefit Summaries",
      "summary": "Reading what's covered, what's excluded, and what the costs really are.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Insurance documents are intimidating because they're written by lawyers, for lawyers. The advisor's job is not to read the entire 80-page policy — it's to read the parts that matter and know when to ask for help with the rest." },

        { "type": "heading", "text": "The declarations page" },
        { "type": "paragraph", "text": "Every P&C and most life and disability policies have a declarations page — usually the first one or two pages. Summarizes the contract. As covered in Module 4, this is the page to read first." },

        { "type": "subheading", "text": "Key items across all types" },
        { "type": "list", "items": [
          "Named insured(s).",
          "Coverage period (effective date, renewal date).",
          "Coverage limits (by type and total).",
          "Deductibles or elimination periods.",
          "Premium and frequency.",
          "Riders or endorsements added."
        ]},

        { "type": "heading", "text": "Type-specific items to verify" },
        { "type": "subheading", "text": "Life insurance" },
        { "type": "list", "items": [
          "Type: term, whole, universal, variable. Each has different planning implications.",
          "Death benefit amount and whether level or increasing.",
          "Term length (if term policy) and date of expiration.",
          "Cash value (if permanent) — recent statement, surrender charges still in effect, loan balances against the policy.",
          "Beneficiaries — primary and contingent."
        ]},

        { "type": "subheading", "text": "Disability insurance" },
        { "type": "list", "items": [
          "Own-occupation or any-occupation definition.",
          "Benefit amount as percentage of pre-disability income.",
          "Elimination period (90 days standard).",
          "Benefit period (to age 65, or shorter).",
          "Inflation rider, residual disability rider, future increase option."
        ]},

        { "type": "subheading", "text": "Homeowners and renters" },
        { "type": "list", "items": [
          "Dwelling coverage (Coverage A) — should approximate replacement cost, not market value.",
          "Personal property (Coverage C) — sub-limits on jewelry, art, electronics.",
          "Liability (Coverage E) — typically inadequate at $100,000–$300,000 default; should match assets.",
          "Endorsements: water backup, scheduled property, identity theft, etc."
        ]},

        { "type": "subheading", "text": "Auto" },
        { "type": "list", "items": [
          "Bodily injury liability limits.",
          "Property damage liability.",
          "UM/UIM (uninsured/underinsured motorist).",
          "Collision and comprehensive — necessary on financed/newer cars; consider dropping on older cars.",
          "Medical payments / PIP."
        ]},

        { "type": "heading", "text": "Employer benefit summaries" },
        { "type": "paragraph", "text": "An often-overlooked source of planning information. The annual benefits summary typically includes:" },
        { "type": "list", "items": [
          "Employer-provided life insurance (often 1–2× salary, sometimes more — useful but not portable).",
          "Short-term and long-term disability — what percentage of salary, taxable or not, owned by employee or employer.",
          "401(k) match formula — what's the trigger and the cap?",
          "Stock plan participation — ESPP discount, RSU vesting schedule, options.",
          "Health, vision, dental coverage details.",
          "Other perks: legal services, identity theft, commuter benefits, dependent care FSA."
        ]},

        { "type": "callout", "kind": "do", "title": "The benefits enrollment season opportunity", "text": "Fall benefits enrollment is one of the best moments to add value to a client. Most employees autofill the same elections every year without optimization. The counselor who reviews the upcoming year's elections — HSA vs. FSA, life insurance buy-up, disability buy-up, dependent care decisions — can produce hundreds to thousands of dollars of value in a 30-minute review. Schedule these conversations proactively." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Document Storage and Security",
      "summary": "Where files live, who can access them, and what to do when something goes wrong.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client documents are sensitive — financial details, SSNs, account numbers, family information. The firm has both regulatory and ethical obligations to protect them. The counselor is a daily participant in that protection." },

        { "type": "heading", "text": "The standard practices" },
        { "type": "list", "items": [
          "<strong>Documents stored in the firm's secure system</strong> — encrypted at rest, access-controlled, audit-logged. Not on personal devices, personal cloud storage, or unencrypted laptop drives.",
          "<strong>Access limited to staff with legitimate need</strong> to know.",
          "<strong>Retention policy followed</strong> — SEC requirements typically mandate 5-year retention for many advisory documents (longer for some); firm policy specifies how long each category of document is kept.",
          "<strong>Disposal handled securely</strong> — paper shredded, digital files deleted from active and backup systems per policy.",
          "<strong>Annual training</strong> on data security, phishing recognition, and incident response."
        ]},

        { "type": "callout", "kind": "warn", "title": "The phishing exposure", "text": "Financial advisors are targeted by phishing because the rewards are large. Common attacks: emails impersonating clients requesting wire transfers, emails impersonating the firm asking for credentials, emails impersonating custodians with urgent requests. Verbal verification on a phone number you have (not the number in the email) before any irregular financial action. Always. Even if the email looks legitimate. Especially if the email looks urgent." },

        { "type": "heading", "text": "What to do if something goes wrong" },
        { "type": "list", "items": [
          "<strong>Lost laptop or device:</strong> Report immediately to firm IT and compliance. Devices should have remote-wipe capability.",
          "<strong>Suspected phishing email opened or clicked:</strong> Report immediately to firm IT. Change passwords. Watch for further attempts.",
          "<strong>Confirmed unauthorized access:</strong> Firm has a defined incident response process. Notification of affected clients is required by state and federal law in most cases. Follow the process; don't try to handle it informally.",
          "<strong>Client reports identity theft:</strong> Help the client through the recovery process (freeze credit, file police report, FTC IdentityTheft.gov, monitor accounts). Document the support provided."
        ]},

        { "type": "callout", "kind": "key", "title": "The professional posture on security", "text": "Treat every client document, login credential, and identity element as if a data breach were costly enough to destroy the firm — because in many cases it would be. The discipline of locking down documents, verifying transactions out-of-band, and reporting anomalies fast isn't optional. It's the work." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Why is the tax return often called the most informative document in financial planning?",
        "options": [
          "It is required by the IRS.",
          "Almost everything financially material about a client appears somewhere in it — income, deductions, investment activity, business interests, real estate, dependents — making it the highest-density source of planning information.",
          "It is the longest document a client provides.",
          "It contains the client's address."
        ],
        "correct": 1,
        "explanation": "A fluent reading of a 1040 plus schedules surfaces in 20 minutes what would take multiple discovery meetings otherwise. Income types, deductions, investment trades, rental property, business activity, retirement contributions — all in one document."
      },
      {
        "id": "q2",
        "prompt": "Which line on Form 1040 is the most useful single number for planning?",
        "options": [
          "Total wages",
          "Adjusted Gross Income (AGI)",
          "Refund amount",
          "Total tax paid"
        ],
        "correct": 1,
        "explanation": "AGI drives Roth contribution limits, IRA deductibility, Medicare premium tiers (IRMAA), credit phaseouts, and many other planning thresholds. Trend year-over-year often matters more than absolute level."
      },
      {
        "id": "q3",
        "prompt": "Why is sending client documents by unencrypted email a problem?",
        "options": [
          "It's slow.",
          "Documents contain SSNs, account numbers, and identity-theft-grade information; email is not secure transmission. Use the firm's portal or encrypted email with separately-transmitted password.",
          "It clutters the client's inbox.",
          "Email attachments are too large."
        ],
        "correct": 1,
        "explanation": "Email is not a secure channel for sensitive financial information. Use the firm's secure document portal, encrypted email with separately-shared password, or physical handoff with proper chain of custody."
      },
      {
        "id": "q4",
        "prompt": "Schedule D on a tax return shows:",
        "options": [
          "Dividends received.",
          "Realized capital gains and losses for the year.",
          "Rental income.",
          "Itemized deductions."
        ],
        "correct": 1,
        "explanation": "Schedule D (with detailed transactions on Form 8949) shows the year's realized investment gains and losses, separated into short-term and long-term. Useful for spotting tax-loss harvesting history and concentrated-position unwinds."
      },
      {
        "id": "q5",
        "prompt": "Schedule E on a tax return reveals:",
        "options": [
          "Self-employment business income.",
          "Rental property income, royalties, and pass-through income from partnerships and S-corps (via K-1s).",
          "Itemized deductions.",
          "Capital gains and losses."
        ],
        "correct": 1,
        "explanation": "Schedule E surfaces rental property ownership the client may not have mentioned, business ownership through entities, and other complexity that requires specialist coordination."
      },
      {
        "id": "q6",
        "prompt": "On a brokerage account statement, what does 'cost basis' mean?",
        "options": [
          "The current value of the position.",
          "What the position was originally purchased for, used to calculate capital gain/loss at sale for tax purposes.",
          "The advisor's fee for managing the position.",
          "The brokerage account's monthly fee."
        ],
        "correct": 1,
        "explanation": "Cost basis is the original purchase price (with adjustments for splits, dividends reinvested, return of capital, etc.). At sale, gain = sale price - cost basis. Lot-level basis tracking is critical for tax optimization."
      },
      {
        "id": "q7",
        "prompt": "What is the default cost-basis method recommendation for taxable brokerage accounts?",
        "options": [
          "First-in, first-out (FIFO).",
          "Specific identification — allows the client to choose which lots to sell at any time, preserving flexibility for tax-loss harvesting and gain optimization.",
          "Last-in, first-out (LIFO).",
          "Average cost."
        ],
        "correct": 1,
        "explanation": "Specific identification preserves the flexibility to optimize tax outcomes. FIFO is the default at most custodians and usually produces the highest gain (oldest, lowest-basis shares sell first). Set to specific identification early."
      },
      {
        "id": "q8",
        "prompt": "Which is a red flag when reviewing an investment statement?",
        "options": [
          "Holdings in low-cost index funds.",
          "Single-stock concentration above 10% with no documented strategic reason; significant cash holdings sitting for years in long-term accounts; or proprietary funds matching a prior advisor's firm.",
          "Cost basis information being tracked.",
          "Dividends being reinvested."
        ],
        "correct": 1,
        "explanation": "These are common findings in transferred accounts that signal prior advisor decisions worth revisiting. Each warrants discussion: the concentration may be intentional or inherited; the cash may be neglect; the proprietary funds were often sold for advisor compensation."
      },
      {
        "id": "q9",
        "prompt": "On an insurance declarations page, which item is most often the source of structural under-insurance?",
        "options": [
          "Coverage period.",
          "Liability limits — auto and homeowners liability often sit at policy defaults ($100K-$300K) while clients have $1M+ in assets to protect.",
          "Premium amount.",
          "Insurance company name."
        ],
        "correct": 1,
        "explanation": "Liability limits are routinely set at low defaults and never updated. A client with $1M net worth and $300K auto liability has a structural mismatch. Annual review should check this and add umbrella where appropriate (covered in Module 4)."
      },
      {
        "id": "q10",
        "prompt": "When in the year is the best time to review a client's employer benefits elections?",
        "options": [
          "January (start of new year).",
          "Fall, before open enrollment for the next plan year — when changes can be made.",
          "Tax season.",
          "Anytime."
        ],
        "correct": 1,
        "explanation": "Most employees autofill elections every fall without optimization. A 30-minute review then — covering HSA vs. FSA, life insurance buy-up, disability buy-up, dependent care — produces real value because changes can be made for the upcoming plan year."
      },
      {
        "id": "q11",
        "prompt": "An email from a client requests an urgent wire transfer of $50,000 to an unfamiliar account. The right response is:",
        "options": [
          "Send the wire immediately to be responsive.",
          "Reply to the email asking for confirmation.",
          "Call the client on a phone number you already have on file (not from the email) to verbally verify before initiating any wire — always, regardless of how legitimate the email looks.",
          "Forward the request to the trading desk."
        ],
        "correct": 2,
        "explanation": "Wire fraud via spoofed emails impersonating clients is one of the most common attacks on advisory firms. Verbal verification on a known phone number — not the number or contact info in the email — is non-negotiable before any irregular financial action. Even if the email looks legitimate. Especially if it's urgent."
      },
      {
        "id": "q12",
        "prompt": "If a counselor suspects a data security incident has occurred, the right action is:",
        "options": [
          "Try to handle it discreetly to avoid alarming anyone.",
          "Wait and see if anything further happens.",
          "Report immediately to firm IT and compliance and follow the defined incident response process — including required client notifications under state/federal law.",
          "Tell the affected client first, then the firm."
        ],
        "correct": 2,
        "explanation": "Incident response has defined steps for legal and operational reasons. Most states and federal law require specific notifications to affected clients on confirmed unauthorized access. Reporting fast is what allows the firm to contain damage and meet obligations. Don't handle informally."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 12;

-- ── module13_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 13 CONTENT
-- Building Financial Statements
-- ============================================================================
update public.modules set
  title = 'Building Financial Statements',
  competency_id = 'OJL-4',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'Net worth and cash flow statements that actually reflect a household. How to build them, what assumptions matter, and how to present them so clients can use them.',
  learning_objectives = ARRAY[
    'Build a net worth statement that accurately represents a household''s position at a point in time.',
    'Build a cash flow statement that surfaces real spending patterns, not aspirational ones.',
    'Categorize assets and choose appropriate valuation methods for each.',
    'Identify common errors and quality issues in personal financial statements.',
    'Present financial statements to a client in a way that produces insight, not overwhelm.',
    'Use financial statements as the foundation for the rest of the planning process.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building the Net Worth Statement",
      "summary": "A snapshot of where the household stands today.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The net worth statement is the foundation document of financial planning. It says: at a specific date, here is what this household owns, here is what it owes, here is the difference. Built well, it grounds every other piece of the plan. Built carelessly, it produces a number that's right by accident — and breaks when anything depends on it." },

        { "type": "callout", "kind": "key", "title": "Net Worth = Assets − Liabilities", "text": "Conceptually simple. The complexity is in the details: what counts as an asset, how to value each item, what counts as a liability, and what date the snapshot represents." },

        { "type": "heading", "text": "Standard asset categories" },
        { "type": "subheading", "text": "Liquid assets (cash and near-cash)" },
        { "type": "list", "items": [
          "Checking accounts",
          "Savings accounts",
          "Money market accounts and funds",
          "CDs maturing within 12 months",
          "Treasury bills"
        ]},

        { "type": "subheading", "text": "Investment assets — taxable" },
        { "type": "list", "items": [
          "Brokerage accounts (joint, individual, joint with rights of survivorship)",
          "Mutual funds held outside retirement",
          "Stocks and bonds held individually",
          "Crypto held in personal wallets or exchanges (with appropriate volatility considerations in valuation)"
        ]},

        { "type": "subheading", "text": "Investment assets — retirement" },
        { "type": "list", "items": [
          "401(k), 403(b), 457 employer plans",
          "Traditional and Roth IRAs",
          "SEP, SIMPLE, solo 401(k) for self-employed",
          "Pensions — valued at present value of expected stream, when applicable"
        ]},

        { "type": "subheading", "text": "Other investment assets" },
        { "type": "list", "items": [
          "529 plans and other education savings",
          "HSAs (with note that they're triple-tax-advantaged)",
          "Annuities (cash surrender value, not face value)",
          "Cash value of permanent life insurance"
        ]},

        { "type": "subheading", "text": "Real estate" },
        { "type": "list", "items": [
          "Primary residence (market value)",
          "Rental properties (market value)",
          "Vacation or second homes",
          "Undeveloped land",
          "REITs held as investments belong in investment assets, not real estate"
        ]},

        { "type": "subheading", "text": "Business interests" },
        { "type": "list", "items": [
          "Closely held business interests (valued at best estimate or recent valuation)",
          "Partnership interests",
          "LLC ownership stakes"
        ]},

        { "type": "subheading", "text": "Personal property" },
        { "type": "list", "items": [
          "Vehicles (Kelley Blue Book or similar)",
          "Collectibles, art, jewelry of meaningful value",
          "Household goods — typically excluded or summarized at modest value unless significant"
        ]},

        { "type": "heading", "text": "Standard liability categories" },
        { "type": "subheading", "text": "Short-term liabilities (due within 12 months)" },
        { "type": "list", "items": [
          "Credit card balances",
          "Personal loans",
          "Tax debt due currently",
          "Medical bills outstanding"
        ]},

        { "type": "subheading", "text": "Long-term liabilities" },
        { "type": "list", "items": [
          "Mortgages on primary and other properties",
          "Auto loans",
          "Student loans",
          "Home equity loans and lines of credit",
          "Margin loans against investment accounts"
        ]},

        { "type": "callout", "kind": "do", "title": "The 'as of' date matters", "text": "A net worth statement always represents a specific point in time. Mark it clearly at the top: 'As of [Date]'. Year-end is conventional. Quarter-end works for active accumulation. Compare year-over-year to track progress. Don't mix asset values from different dates — Q1 brokerage with Q3 mortgage produces a number that doesn't mean anything." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Building the Cash Flow Statement",
      "summary": "What comes in, what goes out — and why most clients have no idea what they actually spend.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Cash flow is harder than net worth, because it covers a period rather than a point and because most households genuinely don't know what they spend. The cash flow statement either reflects reality or it doesn't — and an aspirational one is worse than none at all." },

        { "type": "heading", "text": "Cash flow categories" },
        { "type": "subheading", "text": "Income (inflows)" },
        { "type": "list", "items": [
          "Wages and salary (gross and net both useful)",
          "Self-employment net income",
          "Investment income (dividends, interest)",
          "Rental income (gross less expenses, or net)",
          "Retirement distributions",
          "Social Security benefits",
          "Other (alimony, child support, business distributions, gifts received)"
        ]},

        { "type": "subheading", "text": "Fixed expenses (predictable, repeating)" },
        { "type": "list", "items": [
          "Housing: mortgage/rent, property tax, insurance, HOA, utilities (recurring portion)",
          "Transportation: car payments, insurance, registration",
          "Loan payments: student, auto, personal, credit cards (minimums)",
          "Insurance premiums: health, life, disability, umbrella",
          "Subscriptions: phone, internet, streaming, software, gym",
          "Childcare and tuition (when applicable)"
        ]},

        { "type": "subheading", "text": "Variable expenses (discretionary or semi-fixed)" },
        { "type": "list", "items": [
          "Groceries",
          "Dining out",
          "Personal care, household supplies",
          "Clothing",
          "Entertainment, hobbies",
          "Travel",
          "Gifts and charitable giving (when not committed)"
        ]},

        { "type": "subheading", "text": "Periodic expenses (not monthly, but real)" },
        { "type": "list", "items": [
          "Annual taxes (property, income true-ups)",
          "Annual insurance premiums paid annually rather than monthly",
          "Vehicle maintenance (oil changes, tires, repairs)",
          "Home maintenance (HVAC service, paint, plumbing repairs)",
          "Holidays and gift-giving seasons",
          "Vacations",
          "Annual subscriptions or memberships"
        ]},

        { "type": "subheading", "text": "Savings and contributions (the 'pay yourself' lines)" },
        { "type": "list", "items": [
          "401(k) and other retirement contributions",
          "HSA contributions",
          "529 contributions",
          "Brokerage contributions",
          "Emergency fund building",
          "Debt paydown beyond minimums"
        ]},

        { "type": "callout", "kind": "key", "title": "The cash flow identity", "text": "Income − Expenses − Savings = $0 (or near zero). Every dollar must be accounted for. When the equation doesn't balance, the unaccounted amount is the 'leak' — money disappearing into untracked spending. The size of the leak is one of the most useful planning numbers." },

        { "type": "heading", "text": "Sources for the numbers" },
        { "type": "subheading", "text": "Easiest to verify" },
        { "type": "list", "items": [
          "Income: pay stubs and tax returns.",
          "Fixed expenses paid by recurring auto-payment: bank and credit card statements show them precisely.",
          "Loan payments and tax payments: contract terms and payment confirmations."
        ]},

        { "type": "subheading", "text": "Harder to capture accurately" },
        { "type": "list", "items": [
          "Variable expenses paid by debit card or cash: requires categorizing several months of statements.",
          "Periodic expenses: often missed because they don't appear monthly. Look at 12 months of statements to catch them.",
          "Cash spending: the hardest. If significant, ask the client to estimate weekly cash withdrawals × 52."
        ]},

        { "type": "callout", "kind": "do", "title": "The 90-day reconstruction technique", "text": "Have the client export 90 days of transactions from their primary checking account and primary credit card. Sort by merchant. Categorize. Multiply by 4 for annual estimate. Add known periodic expenses. This produces a defensible cash flow statement in 1–2 hours of analyst work — and surfaces the gap between what the client thinks they spend and what they actually spend. The gap is almost always meaningful." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Valuation and Asset Categorization",
      "summary": "How to value what's not obvious — and what counts as a 'real' asset.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "For most assets, valuation is straightforward — the statement says what it's worth. For others, judgment is required. The principles below produce defensible numbers." },

        { "type": "heading", "text": "Liquid and investment assets — market value at statement date" },
        { "type": "paragraph", "text": "Straightforward: the brokerage statement or bank balance on the relevant date is the value. For end-of-year net worth statements, use 12/31 balances." },

        { "type": "heading", "text": "Real estate — three approaches" },
        { "type": "list", "items": [
          "<strong>Recent appraisal</strong> — most defensible if available within the last 12 months. Cost: $400–$800 for a residential appraisal.",
          "<strong>Comparative market analysis (CMA)</strong> from a real estate agent — free, useful, generally reasonable.",
          "<strong>Online estimate</strong> (Zillow, Redfin) — quick and free, but margins of error are real. Adjust if the home has unusual features (great kitchen renovation, deferred maintenance) that algorithms miss.",
          "<strong>Recent purchase price</strong> — useful only if recent (within last year or two)."
        ]},
        { "type": "callout", "kind": "note", "title": "Conservative vs. aggressive estimates", "text": "Lean modestly conservative on real estate valuation. Aspirational numbers produce net worth that the client can't actually access at the stated level. Build the plan on values the asset would realize in a normal sale within 90 days." },

        { "type": "heading", "text": "Closely held business interests" },
        { "type": "paragraph", "text": "The most challenging asset to value. Options range in formality:" },
        { "type": "list", "items": [
          "<strong>Formal business valuation</strong> — required for serious purposes (gift tax filings, divorce, succession planning). Cost: $5,000–$25,000+ for a small business.",
          "<strong>Industry rules of thumb</strong> — for many small businesses, multiples of revenue or EBITDA used as rough estimates (e.g., service businesses often value at 0.5–2× annual revenue, depending on profitability and recurring nature).",
          "<strong>Recent transactions</strong> — buy-sell agreement values, recent offers received, prior sales of similar businesses.",
          "<strong>Owner's estimate</strong> — least defensible but often the only practical option for routine planning."
        ]},
        { "type": "paragraph", "text": "Always note the valuation method in the financial statement. \"$2M business interest (owner estimate)\" tells a planner — and the next planner who reads the file — what kind of number they're working with." },

        { "type": "heading", "text": "Pensions — when to include and how" },
        { "type": "paragraph", "text": "Defined-benefit pensions are valuable assets, but they typically don't appear on standard statements. Two approaches:" },
        { "type": "list", "items": [
          "<strong>Include as an asset at present value</strong> of the expected income stream. Requires actuarial assumptions about discount rate, mortality, COLA. More technically correct but harder to estimate.",
          "<strong>Exclude from balance sheet, include in retirement income projections.</strong> Simpler, often clearer for clients. Treat the pension as guaranteed monthly income reducing the amount needed from other assets."
        ]},
        { "type": "paragraph", "text": "Either approach is acceptable as long as it's consistent and disclosed. Don't double-count the pension as both an asset and projected income — that's the error to avoid." },

        { "type": "heading", "text": "What to exclude from net worth" },
        { "type": "list", "items": [
          "Expected inheritance — not yet received, no contractual right.",
          "Future earnings — important to planning, but not an asset.",
          "Insurance death benefits — those go to beneficiaries when the insured dies, not assets of the current household.",
          "Social Security future benefits — usually treated as future income, not balance sheet asset.",
          "Personal property of modest value — household goods, clothing, ordinary items. Some statements include 'household contents' at a modest line — fine, but don't inflate."
        ]},

        { "type": "callout", "kind": "warn", "title": "The valuation trap that breaks plans", "text": "Inflating real estate, closely held business, or personal property values to produce a higher net worth number that feels good. The plan built on those values won't survive contact with reality — when the business sells for half what the owner estimated, or the house sits unsold at the aspirational price, the household discovers their plan was built on numbers that weren't there. Honest valuation isn't pessimism. It's the foundation of plans that actually work." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Statement Quality and Auditability",
      "summary": "How to know your numbers will hold up — to a colleague, to a client, to a future advisor.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "A financial statement is auditable when someone else can trace each number back to its source. This is the standard a counselor's work should aim for, every time." },

        { "type": "heading", "text": "What an auditable statement includes" },
        { "type": "list", "items": [
          "<strong>Source notation</strong> for every meaningful asset and liability — \"Schwab statement 12/31/2024\" or \"Realtor CMA 11/15/2024\" or \"Owner estimate, business valuation pending\".",
          "<strong>Valuation date</strong> consistent across the statement.",
          "<strong>Categorization that's consistent</strong> with firm conventions and prior years' statements for the same client.",
          "<strong>Method disclosure</strong> where judgment is required (especially real estate and business interests).",
          "<strong>Excluded items noted explicitly</strong> if the client might expect them included (e.g., expected inheritance — note 'expected inheritance not included').",
          "<strong>Sign-off and review</strong> per firm process."
        ]},

        { "type": "heading", "text": "Common quality issues" },
        { "type": "list", "items": [
          "Mixed-date asset values (assets from different statement dates).",
          "Liabilities included that have been paid off.",
          "Joint accounts double-counted or missed depending on context.",
          "Beneficiary-designated accounts shown as separate from the client's net worth (they are part of net worth during the client's life; they pass via designation at death).",
          "Cash value of life insurance reported as face value (the death benefit, not the current accessible cash value).",
          "Restricted stock valued without considering vesting and tax — net-after-tax for unvested RSUs is more useful for planning than gross unvested value.",
          "Foreign accounts or assets missed entirely."
        ]},

        { "type": "callout", "kind": "do", "title": "The two-pass review", "text": "Build the statement. Then walk through it line by line a second time, asking: 'Can I point to the source for this number?' 'Is the valuation method documented?' 'Is this number current?' 'Is anything obviously missing?' The two-pass review catches almost all of the common errors. Skip it and the errors stay." },

        { "type": "callout", "kind": "key", "title": "Why this matters", "text": "Financial statements get used. They appear in every plan, in every review, in every conversation about progress. They are read by colleagues during coverage, by compliance during audits, by the client when they're trying to understand their own situation, and sometimes by the courts in divorce or estate proceedings. The discipline of building them carefully isn't optional decorative work — it's the spine of the practice." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Presenting Financial Statements to a Client",
      "summary": "How to share what you've built so the client actually understands it.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "A beautifully constructed financial statement that confuses or overwhelms a client has failed at its purpose. The presentation matters as much as the underlying work. The goal is insight, not impression." },

        { "type": "heading", "text": "Principles of good presentation" },
        { "type": "list", "items": [
          "<strong>Show the totals first.</strong> Lead with net worth and key cash flow numbers. Details follow if asked.",
          "<strong>Use simple categories.</strong> Five to seven groupings on each statement is plenty. Twenty line items overwhelm.",
          "<strong>Round appropriately.</strong> Net worth of '$1,237,492.18' is precise but not useful in a conversation. '$1.24M' communicates better.",
          "<strong>Compare to last year.</strong> Year-over-year change matters more than absolute level for ongoing clients.",
          "<strong>Visualize the breakdown.</strong> A simple pie chart of asset categories often communicates more than the table.",
          "<strong>Highlight the planning implication, not just the number.</strong> 'Your liquid assets cover 8 months of expenses — you're in good shape on emergency reserves.'"
        ]},

        { "type": "heading", "text": "Questions to anticipate" },
        { "type": "list", "items": [
          "'Why is my house worth less than I thought?' — explain valuation methodology, willingness to adjust if a recent appraisal exists.",
          "'Where does my expected inheritance fit?' — explain why future expectations aren't assets, but they ARE part of the planning conversation.",
          "'Why isn't my company stock worth more?' — for restricted stock, explain vesting and tax considerations.",
          "'Is my net worth good for my age?' — provide context honestly without making clients feel bad. National percentile data exists; use carefully.",
          "'My friend has [X], should I have [Y]?' — pivot to their own goals."
        ]},

        { "type": "callout", "kind": "key", "title": "The line that often lands", "text": "<em>'This is what you've built. It's where we're starting from, and it's the foundation for everything we're going to plan.'</em> Frames the number as a starting point, not a verdict. Especially helpful with clients who have negative net worth, lower-than-expected numbers, or strong feelings about their financial position." },

        { "type": "case_study",
          "title": "Marcus and Tasha's first financial statement",
          "scenario": "After the discovery phase, you build their first net worth statement (as of 12/31/2024): Assets $665,000 (home equity $190K, his 401(k) $145K, her 403(b) $95K, brokerage $35K, kids' 529s $40K, cash $25K, vehicles $35K, business interest $100K). Liabilities $345,000 (mortgage $280K, student loans $35K, credit cards $30K). Net worth $320,000. Cash flow shows ~$5,800/month after fixed expenses but only ~$1,500/month actually saved — the rest is the 'leak' through variable spending and small periodic expenses.",
          "discussion": "<p>Present in this order:</p><p><strong>1. The headline numbers.</strong> 'Your net worth is approximately $320,000, your annual savings is approximately $18,000, and your monthly take-home minus fixed expenses is about $5,800.'</p><p><strong>2. The structure.</strong> 'Your assets are well-distributed across retirement, home equity, and college savings. You don't have a meaningful concentration in any single area, which is good.'</p><p><strong>3. The opportunity.</strong> 'Of the $5,800 you have left each month after fixed expenses, about $1,500 is going to savings. The other $4,300 is going somewhere — that's the area we want to understand and shape. If we can move even half of that toward savings, your retirement and college numbers improve significantly.'</p><p><strong>4. The trade-off invitation.</strong> 'There's nothing wrong with the spending — that's your life. The question is whether the current pattern is the one you'd choose if you saw it all on one page. That's what we're going to look at together in the next meeting.'</p><p>This framing turns the financial statement from a verdict into a conversation. <strong>That's what the deliverable looks like when it's done well.</strong></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the basic identity for net worth?",
        "options": [
          "Income minus Expenses",
          "Assets minus Liabilities",
          "Cash minus Debt",
          "Salary minus Taxes"
        ],
        "correct": 1,
        "explanation": "Net Worth = Assets − Liabilities, at a specific point in time. Conceptually simple; the complexity is in what counts and how to value each item."
      },
      {
        "id": "q2",
        "prompt": "Why must a net worth statement carry an 'as of' date?",
        "options": [
          "Required by the IRS.",
          "Asset and liability values change daily; a statement is meaningful only as a point-in-time snapshot, and mixing values from different dates produces a meaningless total.",
          "Clients are confused without it.",
          "It satisfies SEC requirements."
        ],
        "correct": 1,
        "explanation": "Net worth is a balance sheet snapshot. Brokerage values from March combined with mortgage balance from October produce a number that doesn't represent any actual moment. Mark the date clearly."
      },
      {
        "id": "q3",
        "prompt": "Which of the following should NOT typically be included as an asset on a net worth statement?",
        "options": [
          "401(k) balance",
          "Home equity",
          "Expected inheritance",
          "Cash value of permanent life insurance"
        ],
        "correct": 2,
        "explanation": "Expected inheritance is not yet received and not contractually owed — it's not an asset. It's relevant to planning conversations but doesn't belong on the balance sheet. Future Social Security is similarly excluded as an asset (typically modeled as future income instead)."
      },
      {
        "id": "q4",
        "prompt": "When valuing closely held business interests, the most defensible source for a major planning purpose is:",
        "options": [
          "The owner's estimate.",
          "An online business valuation calculator.",
          "A formal business valuation by a qualified valuation professional.",
          "Last year's revenue × 2."
        ],
        "correct": 2,
        "explanation": "Formal valuations are necessary for major purposes (gift tax filings, divorce, succession planning, etc.). Owner estimates and rules of thumb are acceptable for routine planning but should be labeled as such on the financial statement. Always note the valuation method."
      },
      {
        "id": "q5",
        "prompt": "What is the 'cash flow identity' an advisor uses to find spending leaks?",
        "options": [
          "Income should equal Expenses.",
          "Income − Expenses − Savings should approximately equal $0; the unaccounted-for amount is the 'leak' of untracked spending.",
          "Assets minus Liabilities equals Cash Flow.",
          "Net Worth must equal Cash Flow × 12."
        ],
        "correct": 1,
        "explanation": "Every dollar should be accounted for. When income minus expenses minus savings produces a meaningful unexplained amount, that's the leak — untracked spending. The size of the leak is one of the most useful planning numbers."
      },
      {
        "id": "q6",
        "prompt": "Which expense category is most commonly missed when clients estimate their own spending?",
        "options": [
          "Mortgage payment.",
          "Periodic expenses — annual insurance premiums, vehicle maintenance, home repairs, holiday gifting — that don't appear monthly but add up.",
          "Groceries.",
          "Utilities."
        ],
        "correct": 1,
        "explanation": "Periodic expenses are real but don't show up in any given month, so they're missed in monthly mental accounting. Looking at 12 months of statements catches them. Once captured, they often surprise clients by their total."
      },
      {
        "id": "q7",
        "prompt": "What is the '90-day reconstruction' technique for building cash flow?",
        "options": [
          "Forecasting the next 90 days of spending.",
          "Exporting 90 days of transactions from primary accounts, categorizing them, multiplying by 4 for annual estimate, then adding known periodic expenses.",
          "Doing 90 days of receipt collection.",
          "Reviewing the last 90 days of investments."
        ],
        "correct": 1,
        "explanation": "90 days of transactions × 4 + periodic expenses produces a defensible cash flow statement in 1–2 hours. It also surfaces the gap between what the client thinks they spend and what they actually spend — almost always meaningful."
      },
      {
        "id": "q8",
        "prompt": "When valuing real estate on a net worth statement, the most defensible source is:",
        "options": [
          "Owner's estimate of what the house 'feels' worth.",
          "The original purchase price.",
          "A recent appraisal or comparative market analysis from a real estate professional — leaning modestly conservative.",
          "Highest recent sale on the street."
        ],
        "correct": 2,
        "explanation": "Recent appraisal or agent CMA is the right source. Modestly conservative valuation is the discipline — aspirational numbers produce plans the client can't actually realize. Build on values that would clear in a 90-day normal sale."
      },
      {
        "id": "q9",
        "prompt": "How should defined-benefit pensions be treated on a net worth statement?",
        "options": [
          "Always at face value of expected lifetime benefits.",
          "Either as a present-value asset OR as an exclusion from balance sheet with treatment as projected retirement income — consistent and disclosed either way, and never double-counted.",
          "Ignored.",
          "Counted twice for safety."
        ],
        "correct": 1,
        "explanation": "Both approaches are valid as long as treatment is consistent and disclosed. The error to avoid is counting a pension as both an asset on the balance sheet AND as projected income in retirement projections — that double-counts the benefit."
      },
      {
        "id": "q10",
        "prompt": "Which is a common quality issue in personal financial statements?",
        "options": [
          "Cost basis being tracked.",
          "Permanent life insurance cash value reported at the face death benefit rather than current accessible cash value.",
          "Asset categories being labeled clearly.",
          "Year-over-year comparison included."
        ],
        "correct": 1,
        "explanation": "Death benefit (face value) and cash value (accessible during life) are very different numbers. Only cash value belongs on a net worth statement during the insured's lifetime. Face value pays to beneficiaries at death and isn't an asset of the current household."
      },
      {
        "id": "q11",
        "prompt": "When presenting a financial statement to a client, what's the right level of precision?",
        "options": [
          "Penny-precise — '$1,237,492.18'.",
          "Appropriately rounded for the conversation — '$1.24M' communicates better than penny-precise. Reserve precision for the underlying workpaper.",
          "Always to the nearest dollar.",
          "Always in scientific notation."
        ],
        "correct": 1,
        "explanation": "Penny precision overwhelms in conversation; round to communicate. The workpaper has the exact figures for audit. The client presentation has appropriate roundings to support understanding."
      },
      {
        "id": "q12",
        "prompt": "What's the best framing line when sharing a net worth statement that's lower than the client expected?",
        "options": [
          "'You should have saved more by now.'",
          "'This is what you've built. It's where we're starting from, and it's the foundation for everything we're going to plan.'",
          "'Your friends probably have more.'",
          "'We can fix this with the right portfolio.'"
        ],
        "correct": 1,
        "explanation": "Frames the number as a starting point, not a verdict. Acknowledges what the client has built without judgment. Pivots immediately to the work ahead. Especially helpful for clients with negative or lower-than-hoped numbers — the goal is producing useful insight, not making them feel worse."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 13;

-- ── module14_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 14 CONTENT
-- Behavioral Finance & Client Coaching
-- ============================================================================
update public.modules set
  title = 'Behavioral Finance & Client Coaching',
  competency_id = 'OJL-5',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Recognize the cognitive and emotional patterns that drive client decisions, and learn the coaching moves that keep plans intact when markets get loud.',
  learning_objectives = ARRAY[
    'Identify the most common cognitive biases that show up in real client conversations',
    'Recognize emotional patterns around volatility, windfalls, and losses',
    'Apply motivational interviewing techniques to client meetings',
    'Use pre-commitment, automation, and framing to design around bias',
    'Coach couples and families when stakeholders disagree about money'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Why Smart People Make Predictable Money Mistakes",
        "summary": "Behavioral finance is the study of why humans systematically deviate from rational economic behavior — and why even sophisticated clients need coaching.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Traditional economics assumed people were rational utility-maximizers. Decades of research — much of it from Daniel Kahneman and Amos Tversky — proved they aren't. People are loss-averse, present-biased, herd-following, overconfident, and prone to remembering the dramatic over the typical. None of this makes clients stupid. It makes them human. Your job as a counselor is not to lecture clients out of these patterns — that doesn't work. Your job is to recognize the patterns and design the plan, the conversation, and the environment so the patterns don't sink the plan."},
          {"type": "heading", "content": "The advisor's behavioral premium"},
          {"type": "paragraph", "content": "Vanguard's Advisor's Alpha research and Russell Investments' Value of an Advisor studies both estimate that a meaningful portion of the value advisors deliver comes not from picking better investments but from preventing client behavioral mistakes — talking the panicked client off a sell-everything ledge in March 2020, slowing the euphoric client who wants to dump retirement savings into a hot meme stock, getting the couple in agreement so they stop sabotaging each other's contributions. Behavior coaching is not soft skills. It is the work."},
          {"type": "callout", "kind": "key", "content": "If you only learn one thing from this module: the goal is not to be right about the client's biases. The goal is to design the relationship so the biases never get to drive."},
          {"type": "subheading", "content": "The bias toolkit you will see every week"},
          {"type": "glossary", "terms": [
            {"term": "Loss aversion", "definition": "The pain of losing $1,000 feels roughly twice as strong as the pleasure of gaining $1,000. Drives panic selling and refusal to realize losses."},
            {"term": "Anchoring", "definition": "Fixating on a reference number — what the stock used to be worth, what the house was listed for, what the 401(k) hit at its peak. The anchor often has no bearing on the present decision."},
            {"term": "Recency bias", "definition": "Weighting recent events more heavily than long-term data. A client who watched the market drop 15% this quarter cannot easily picture a 30-year horizon."},
            {"term": "Confirmation bias", "definition": "Seeking and remembering information that supports an existing belief while filtering out contradictory evidence."},
            {"term": "Herding", "definition": "Doing what others are doing — buying into a rally because friends are bragging, selling because the news cycle is grim."},
            {"term": "Overconfidence", "definition": "Believing one's predictions are more accurate than they actually are. Especially common in high-earning professionals."},
            {"term": "Mental accounting", "definition": "Treating money differently based on its source or label — bonus money gets spent, salary gets saved, tax refunds get blown."},
            {"term": "Present bias / hyperbolic discounting", "definition": "Overweighting immediate rewards versus future ones. The reason saving is hard even when the math is obvious."}
          ]},
          {"type": "case_study", "title": "Naomi after a bad quarter", "scenario": "Naomi, the analyst we have followed since Module 2, watches her 401(k) drop 18% in a quarter. She emails her advisor at 11pm: 'I want to move everything to cash until this settles down.' Her time horizon is 32 years. The portfolio is doing exactly what a 90/10 portfolio is supposed to do during a drawdown. Three biases are firing at once: loss aversion (the pain is acute), recency bias (she cannot feel the 32-year horizon), and anchoring (she is mentally anchored to the peak balance from three months ago).", "discussion": "The wrong move is to email back a Vanguard chart about 'time in the market.' That validates that this is a math problem. It is not. It is a fear problem dressed up in math clothing. The right move is to call her in the morning, acknowledge the fear, ask what specifically she is afraid of, and only then walk through what her plan was designed to do in exactly this scenario."},
          {"type": "paragraph", "content": "Notice the move: you start with the emotion, not the data. Clients who feel heard can hear data. Clients who feel dismissed cannot."},
          {"type": "callout", "kind": "note", "content": "Biases are not character flaws. They are features of human cognition that evolved to keep our ancestors alive. The same loss aversion that makes Naomi want to sell at the bottom is what kept her great-grandmother from eating unfamiliar berries."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Reading Emotion in the Room",
        "summary": "Before you can coach, you have to diagnose. What clients say is rarely the whole story — learn to read what they are actually feeling.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Clients almost never walk into a meeting and say 'I am terrified about running out of money in retirement and that terror is making me consider a decision I will regret.' They say things like 'I have been thinking about being more conservative' or 'a friend told me about an annuity.' Your job in the first ten minutes of any consequential conversation is to translate the surface request into the underlying feeling. You cannot solve the surface request well if you have misread the underlying state."},
          {"type": "subheading", "content": "The four emotional states that show up most often"},
          {"type": "list", "items": [
            "Fear — usually around loss, running out, or being exposed as not having known something",
            "Shame — typically about past financial choices, debt, divorce settlements, not having saved enough",
            "Euphoria — after a windfall, a hot investment, an inheritance, a business sale",
            "Resentment — usually around a spouse, a sibling, a former partner, or an institution"
          ]},
          {"type": "paragraph", "content": "Each state distorts decision-making differently. Fear narrows the field of view; the client cannot consider long-term tradeoffs because everything is about the immediate threat. Shame makes clients omit information — they leave out the credit card balance, the second mortgage, the loan from dad. Euphoria makes clients unusually willing to take risks they would have rejected a year earlier. Resentment makes clients make decisions to spite someone else rather than to serve themselves."},
          {"type": "subheading", "content": "Verbal signals to listen for"},
          {"type": "glossary", "terms": [
            {"term": "Should statements", "definition": "'I should have started saving sooner.' 'We should be further along.' Almost always shame. Do not validate the should — redirect to what is possible now."},
            {"term": "Catastrophic language", "definition": "'Everything I have worked for.' 'Nothing left.' 'Wiped out.' Almost always fear. The actual situation is rarely as binary as the language suggests."},
            {"term": "Comparison statements", "definition": "'My brother-in-law is up 40% this year.' 'Everyone in my office is buying X.' Usually herding pressure. Slow down before responding."},
            {"term": "Vague qualifiers", "definition": "'Some' debt. 'A few' credit cards. 'A while ago.' Shame about specifics. Get the actual numbers gently."},
            {"term": "Spouse-blame language", "definition": "'He never wanted to save.' 'She insisted on the bigger house.' Resentment. Both spouses need to be in the room before you build a plan."}
          ]},
          {"type": "subheading", "content": "Non-verbal signals you can train yourself to notice"},
          {"type": "list", "items": [
            "Body closing off — arms crossing, leaning back, turning toward the door. Trust is dropping.",
            "Glancing at the spouse before answering — the answer being given may not be the real answer.",
            "Long pauses before numbers — the client is calculating whether to tell you the truth.",
            "Voice dropping or trailing off — the topic has hit something painful.",
            "Sudden topic changes — you have approached something the client is not ready to discuss."
          ]},
          {"type": "case_study", "title": "Marcus and Tasha in the discovery meeting", "scenario": "Marcus and Tasha — the couple from Modules 3 and 11 — are in their first planning meeting. When the apprentice asks about debt, Marcus answers immediately: 'We have the mortgage, that is it.' Tasha glances at him, says nothing. Five minutes later when the apprentice asks about emergency savings, Tasha mentions 'the card we use for emergencies sometimes.' The apprentice gently follows up: 'Tell me a little more about that card — what's the balance?' Tasha says about $14,000.", "discussion": "Marcus was not lying — he genuinely did not consider the card a debt because Tasha manages it. But the glance was the signal. A counselor who pushed past the first 'that is it' would have missed the fourteen thousand dollars and built a plan around a fiction. Reading the glance is more important than reading the spreadsheet."},
          {"type": "callout", "kind": "do", "content": "When something feels off, slow down. Ask one more open question. 'Help me understand a little more about...' is one of the most powerful sentences in this work."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "The Coaching Conversation — Motivational Interviewing for Money",
        "summary": "Motivational interviewing is a clinical technique developed for addiction counseling. It works in financial coaching for the same reason it works there: people change when they hear themselves say why.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If you have ever tried to argue someone out of a bad financial decision, you already know it does not work. The harder you push, the more committed the client becomes to defending the position. Motivational interviewing flips this. Instead of telling the client what to do, you ask questions designed to surface their own reasons for change. The client persuades themselves. You just hold the space."},
          {"type": "subheading", "content": "The four core moves — OARS"},
          {"type": "glossary", "terms": [
            {"term": "Open questions", "definition": "Questions that cannot be answered with yes or no. 'What does retirement look like for you?' beats 'Do you want to retire at 65?' every time."},
            {"term": "Affirmations", "definition": "Specific recognition of strengths and effort. Not flattery. 'It took real discipline to pay off that card last year.'"},
            {"term": "Reflections", "definition": "Saying back what you heard, sometimes with slight amplification. 'So even though the market makes you nervous, you have stayed with the plan for three years now.'"},
            {"term": "Summaries", "definition": "Pulling together what the client has said over a longer stretch and offering it back. Lets the client hear their own thinking organized."}
          ]},
          {"type": "subheading", "content": "Change talk — the sound of motivation"},
          {"type": "paragraph", "content": "When clients start using certain kinds of language, motivation is rising. Listen for: desire ('I want to...'), ability ('I could...'), reasons ('Because if I do not...'), need ('I have to...'), and commitment ('I will...'). Your job is to ask questions that elicit more of this language. The more the client hears themselves talking about change, the more likely change becomes."},
          {"type": "subheading", "content": "Sustain talk and rolling with resistance"},
          {"type": "paragraph", "content": "The opposite of change talk is sustain talk — reasons to keep doing what they are doing. 'I cannot save more, I just cannot.' 'My husband would never agree to that.' When you hear sustain talk, the wrong move is to argue. The right move is to reflect it back without agreeing, then ask a question that opens a different angle. 'Saving more feels impossible right now. If we could find $50 a month somewhere, where would you want it to go?' You are not contradicting the client. You are inviting them to imagine differently."},
          {"type": "activity", "title": "Practice — flipping the script", "prompt": "For each statement below, write a response that reflects the client's feeling without agreeing with the conclusion, then asks an open question:", "steps": [
            "'There is no point trying to save for retirement, it is too late for me.'",
            "'My friends are all buying crypto and they are making a fortune. I am missing out.'",
            "'My wife handles all the money, I just sign what she puts in front of me.'",
            "'We will get serious about this when the kids are out of college.'"
          ]},
          {"type": "case_study", "title": "Devon and the equipment loan", "scenario": "Devon, the small business owner from prior modules, wants to take out a $90,000 equipment loan at 9.5% interest. He has $130,000 in his business savings. When the apprentice asks why he prefers debt to using cash, Devon says 'I never want to be cash-poor in the business.' The apprentice does not argue. Instead: 'Tell me about a time being cash-poor really hurt the business.' Devon describes 2020 — a stretch when receivables stretched out and he almost missed payroll. 'So the loan is partly about protecting against that feeling again.' Devon agrees. 'If we could solve the cash protection a different way — say a line of credit at 7% you only draw if you actually need it — what would that change?'", "discussion": "The apprentice never told Devon his plan was wrong. They asked questions that surfaced the real driver — fear of 2020 repeating — and then offered a structure that solved for the fear without the 9.5% locked-in debt. Devon makes the new decision. He owns it because he arrived at it."},
          {"type": "callout", "kind": "key", "content": "You will not persuade clients with better arguments. You will only persuade them by asking questions that let them persuade themselves."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Designing Around Bias — Automation, Pre-Commitment, and Framing",
        "summary": "Some bias problems can be solved by conversation. Others need to be solved by structure. Learn to build a plan that does not rely on the client being a different person than they are.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Coaching is necessary but not sufficient. The best behavioral interventions remove the decision from the moment of weakness entirely. If a client cannot resist spending the bonus, the plan should automatically route the bonus into investments before the client sees it. If a client panics when the market drops, the rebalancing rules should be written down in advance, signed, and triggered by predetermined thresholds — not by how the news is making the client feel that morning. Design the environment, not the resolve."},
          {"type": "subheading", "content": "Automation as a bias antidote"},
          {"type": "list", "items": [
            "Automatic contributions to 401(k), IRA, brokerage — removes the monthly decision",
            "Auto-escalation — contribution rate increases by 1% each year on a set date",
            "Sweep accounts — anything above $X in checking moves to savings on the 1st",
            "Direct deposit splitting — bonuses or commissions routed directly to savings before they hit checking",
            "Automatic rebalancing on a fixed schedule or threshold, not a feeling"
          ]},
          {"type": "subheading", "content": "Pre-commitment devices"},
          {"type": "paragraph", "content": "A pre-commitment device is a decision the client makes when they are calm that constrains the decision they will be tempted to make when they are not. The classic example is the Investment Policy Statement — a written document that says 'I will not change my allocation in response to a single quarter's performance. If I want to make a change, I will wait 30 days and re-discuss.' Signed when the client is calm. Pulled out when the client wants to panic-sell."},
          {"type": "callout", "kind": "do", "content": "Every client over a certain asset threshold should have a one-page Investment Policy Statement signed at the start of the relationship. It is the single most useful tool for surviving market drawdowns."},
          {"type": "subheading", "content": "Framing — same fact, different feeling"},
          {"type": "paragraph", "content": "How information is framed changes how clients react to it, even when the underlying numbers are identical. A 90% survival probability feels safer than a 10% failure probability — even though they are the same. A $10,000 loss feels different described as 'a 5% drawdown in a portfolio that has averaged 8% over 15 years' than as 'losing $10,000.' Framing is not manipulation. It is presenting the same truth in a way the client can actually process. The lie would be omitting either side. The skill is in choosing which frame to lead with."},
          {"type": "glossary", "terms": [
            {"term": "Default framing", "definition": "Setting the default option to the desired behavior. Auto-enrollment in a 401(k) raises participation from ~60% to ~90% — same employees, same plan, different default."},
            {"term": "Loss framing", "definition": "Describing a choice in terms of what is at risk of being lost. Tends to motivate action because of loss aversion."},
            {"term": "Gain framing", "definition": "Describing the same choice in terms of what could be gained. Tends to feel less urgent but more sustainable."},
            {"term": "Bucket framing", "definition": "Mentally separating money by purpose — emergency bucket, retirement bucket, near-term goals bucket. Leverages mental accounting positively."}
          ]},
          {"type": "case_study", "title": "Designing for Marcus and Tasha", "scenario": "Marcus and Tasha agreed to save more after Modules 3 and 11. But three months in, the extra savings are not happening — they keep meaning to transfer money and never do. The apprentice does not call this a discipline problem. They restructure: bi-weekly automatic transfer of $400 from checking to a high-yield savings account labeled 'Emergency Fund' at a different bank than their checking. The money moves the day after each payday, before discretionary spending. Three months later, the emergency fund is at $2,400 with no further conversations.", "discussion": "Marcus and Tasha did not become more disciplined. The system became more forgiving of their actual discipline level. Notice also the labeling — 'Emergency Fund' at a different bank — uses mental accounting and friction to discourage casual withdrawal."},
          {"type": "callout", "kind": "warn", "content": "If a plan requires the client to make a recurring willpower-dependent decision, the plan will eventually fail. Engineer the willpower out."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "When Two People Have to Agree — Coaching Couples and Families",
        "summary": "Most household financial decisions involve more than one person. When stakeholders disagree, the coaching work doubles — and the wrong move can damage the marriage as much as the portfolio.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Money is one of the top three causes of divorce. By the time a couple is sitting across from you, there is often a long history of money fights, money silences, money resentments — and the conversation you are about to have is not really about asset allocation. It is about whether two people who love each other can build something together that they both believe in. Take the role seriously. You are not a marriage counselor, but you are doing some of the work."},
          {"type": "subheading", "content": "Common couple patterns to recognize"},
          {"type": "glossary", "terms": [
            {"term": "The CFO and the consumer", "definition": "One spouse handles all the money decisions, the other spouse spends without engagement. Eventually the CFO burns out or the consumer wakes up to a balance sheet they do not recognize."},
            {"term": "The saver and the spender", "definition": "One spouse is wired toward security, the other toward enjoyment. Neither is wrong. The plan has to honor both or it will break."},
            {"term": "The risk-seeker and the risk-avoider", "definition": "One spouse is comfortable with equity volatility, the other cannot sleep with it. A 70/30 portfolio works for neither — design something asymmetric."},
            {"term": "The yours/mine couple", "definition": "Separate accounts, separate everything, often after a prior marriage. Build a plan that respects the separation but creates joint accountability where needed."},
            {"term": "The silent spouse", "definition": "One spouse comes to every meeting and does not speak. Either disengaged or being overridden. Address it directly and gently."}
          ]},
          {"type": "subheading", "content": "Ground rules for the joint meeting"},
          {"type": "list", "items": [
            "Both spouses in the room for any consequential decision — no one-sided sign-offs on things that affect them both",
            "Ask each spouse questions directly, not just 'you two' — make sure both voices land in the record",
            "When one spouse interrupts the other, calmly redirect: 'I want to hear Maria finish that thought'",
            "Never side with one spouse against the other, even when you privately agree with one of them",
            "Surface disagreement explicitly — 'It sounds like you two see this differently. Let's slow down here.'",
            "If a couple is in active conflict, do not push to a decision in that meeting. Reschedule."
          ]},
          {"type": "subheading", "content": "Working with adult children, parents, and blended families"},
          {"type": "paragraph", "content": "The household is not always two people. Adult children may be involved in aging parents' decisions. Stepchildren and former spouses complicate estate planning. Sometimes a financially successful child is supporting a parent or a sibling. Each of these situations has emotional currents that long predate you. Your job is to map the dynamics without judging them, and to design a plan that does not require the family to suddenly become a different family."},
          {"type": "case_study", "title": "Marcus's mother", "scenario": "During the planning conversation, Marcus mentions that he has been sending his mother $400 a month for two years. Tasha looks surprised. She knew he helped sometimes but did not know it was monthly or that amount. The apprentice does not move past this. 'It sounds like this is the first time you two are talking about this number together. I want to make sure we plan with the real picture.' The apprentice asks Marcus to explain what the support is for, asks Tasha what she is feeling hearing it for the first time, and only then continues.", "discussion": "The apprentice did not avoid the moment because it was uncomfortable. They held the moment. The $4,800 a year matters for the cash flow plan — but the bigger issue is that Marcus and Tasha did not have a shared picture of their own money. Surfacing that gently, with care, is part of the work. A counselor who breezed past it would have built a financial plan that excluded reality."},
          {"type": "callout", "kind": "note", "content": "When you sense a couple has just disagreed on something for the first time in front of you, you have two options: rush past it or hold it. Hold it. The couple needs to talk about it eventually. They might as well do it with a calm professional in the room."},
          {"type": "subheading", "content": "Tying it back to the apprentice role"},
          {"type": "paragraph", "content": "Behavioral coaching is the difference between being a financial calculator and being a counselor. The numbers any apprentice can learn. The capacity to sit with another human being's fear, shame, euphoria, or resentment — without flinching, without judging, without trying to fix what is not yours to fix — that is the practice. Every client meeting is an opportunity to develop it."},
          {"type": "divider"},
          {"type": "paragraph", "content": "In the next module, we move from coaching the relationship to the structured tool that translates client risk capacity and tolerance into an actual portfolio decision: risk profiling and suitability."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "A client emails at 11pm wanting to move everything to cash after a bad quarter. The first move is to:", "options": ["Email back a chart showing long-term market returns", "Call in the morning and start with the emotion, not the data", "Process the trade overnight to honor client wishes", "Refer the client to a different advisor"], "correct": 1, "explanation": "Clients in fear cannot hear data until they feel heard. Start with the emotion. The data conversation follows."},
        {"id": "q2", "prompt": "Loss aversion describes which of the following?", "options": ["The tendency to lose money on most trades", "The pain of losing $1,000 feeling roughly twice as strong as the pleasure of gaining $1,000", "The risk of avoiding all investments", "A bias unique to inexperienced investors"], "correct": 1, "explanation": "Loss aversion is the asymmetry between the felt pain of loss and the felt pleasure of equivalent gain. It affects everyone, including sophisticated investors."},
        {"id": "q3", "prompt": "Which of the following is an example of a pre-commitment device?", "options": ["Telling the client to be more disciplined", "An Investment Policy Statement signed when the client is calm that constrains future panic decisions", "Reading market news every morning", "Setting more aggressive return targets"], "correct": 1, "explanation": "A pre-commitment device is a decision made in a calm state that constrains a decision the client will be tempted to make under stress. The IPS is the classic example."},
        {"id": "q4", "prompt": "Motivational interviewing's OARS framework stands for:", "options": ["Observe, Ask, Recommend, Sell", "Open questions, Affirmations, Reflections, Summaries", "Outline, Articulate, Reason, Solve", "Onboarding, Assessment, Review, Strategy"], "correct": 1, "explanation": "OARS — Open questions, Affirmations, Reflections, Summaries — is the core conversational toolkit of motivational interviewing."},
        {"id": "q5", "prompt": "A client says 'My friends are all buying crypto and making a fortune. I am missing out.' This is most likely:", "options": ["A rational reallocation request", "Anchoring bias", "Herding pressure", "Hyperbolic discounting"], "correct": 2, "explanation": "Herding — doing what others are doing because they are doing it — is the bias driving most 'everyone else is...' statements."},
        {"id": "q6", "prompt": "Auto-enrollment raises 401(k) participation rates from roughly 60% to 90% because:", "options": ["Employees become more financially literate", "The contribution rates increase automatically", "Setting the default to the desired behavior leverages how people respond to defaults", "Employers offer better matches"], "correct": 2, "explanation": "Default framing is one of the most powerful behavioral interventions. Most people accept the default, so designing the default is designing the outcome."},
        {"id": "q7", "prompt": "Which of the following best describes 'change talk' in motivational interviewing?", "options": ["The advisor telling the client what to change", "The client using language of desire, ability, reasons, need, or commitment toward change", "Switching topics during a conversation", "Discussing market changes"], "correct": 1, "explanation": "Change talk is the client's own language signaling motivation. The more change talk, the more likely behavior change. The advisor's job is to ask questions that elicit it."},
        {"id": "q8", "prompt": "During a joint meeting, one spouse interrupts the other every time the second spouse tries to speak. The most appropriate move is to:", "options": ["Let the dominant spouse finish, since they seem more engaged", "Side with the quieter spouse to even things out", "Calmly redirect: 'I want to hear Maria finish that thought'", "End the meeting and only meet with one spouse going forward"], "correct": 2, "explanation": "Both voices need to land in the record. Calmly redirecting without taking sides preserves your neutrality and protects the relationship."},
        {"id": "q9", "prompt": "Mental accounting refers to:", "options": ["The math of calculating portfolio returns", "Treating money differently based on its source or label", "Reviewing accounts mentally before sleep", "A type of double-entry bookkeeping"], "correct": 1, "explanation": "Mental accounting is the tendency to treat money differently depending on where it came from or what we call it. Bonus money gets spent, salary gets saved, refunds get blown."},
        {"id": "q10", "prompt": "A client says 'I should have started saving sooner. I should be further along by now.' This 'should' language most often indicates:", "options": ["Strong financial literacy", "Confirmation bias", "Shame about past financial choices", "A request for tax planning"], "correct": 2, "explanation": "'Should' statements about the past are almost always shame. The right move is to redirect to what is possible now, not to validate the should."},
        {"id": "q11", "prompt": "Devon wants a $90,000 equipment loan at 9.5% when he has $130,000 in business savings. After exploring, the apprentice learns Devon is afraid of repeating a 2020 cash crisis. The strongest next move is to:", "options": ["Tell Devon his fear is irrational and use the cash", "Refuse to discuss the loan", "Offer a structure — like a line of credit — that solves the cash protection without the high locked-in rate", "Process the loan as requested"], "correct": 2, "explanation": "You do not win by overriding the client's fear. You win by designing a structure that honors the underlying need (cash protection) without paying 9.5% locked in."},
        {"id": "q12", "prompt": "The behavioral premium of an advisor — the value of preventing client behavioral mistakes — is best described as:", "options": ["A marketing concept with no empirical support", "A meaningful portion of the value advisors deliver according to multiple industry studies", "A practice only used by fee-only advisors", "Only relevant for high-net-worth clients"], "correct": 1, "explanation": "Industry research from Vanguard, Russell, and others estimates behavioral coaching is a meaningful part of advisor value — often as much or more than investment selection."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 14;

-- ── module15_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 15 CONTENT
-- Risk Profiling & Suitability
-- ============================================================================
update public.modules set
  title = 'Risk Profiling & Suitability',
  competency_id = 'OJL-6',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Translate a client''s risk capacity, tolerance, and required return into a defensible suitability determination — and document it the way regulators expect.',
  learning_objectives = ARRAY[
    'Distinguish risk capacity, risk tolerance, and required return',
    'Administer and interpret a risk profiling questionnaire',
    'Reconcile mismatches between what a client says and what their situation requires',
    'Document a suitability determination that holds up to compliance review',
    'Communicate risk in terms clients actually feel, not just statistics'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Three Risks That Live in Every Client",
        "summary": "Every client has three different risk numbers — and one of the most common counselor mistakes is conflating them. Get them separated.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Ask three different planners 'how risky a portfolio should this client have' and you can get three different answers — not because anyone is wrong but because they are answering different questions. Risk in client work is not one number. It is three numbers that have to be reconciled. If you mix them up, you build the wrong portfolio for the right client, or worse, the right portfolio for the wrong client."},
          {"type": "subheading", "content": "The three risk dimensions"},
          {"type": "glossary", "terms": [
            {"term": "Risk capacity", "definition": "How much loss the client can financially absorb without breaking the plan. A function of time horizon, income stability, savings rate, and other resources. Objective. Calculable."},
            {"term": "Risk tolerance", "definition": "How much loss the client can emotionally absorb without breaking themselves. A function of personality, history, and current life stress. Subjective. Measured by questionnaire and conversation."},
            {"term": "Required return", "definition": "The annualized return the client's portfolio needs to deliver for the stated goals to be achievable. A function of starting assets, savings, time horizon, and target. Objective. Calculable from the financial plan."}
          ]},
          {"type": "callout", "kind": "key", "content": "Capacity says what the client can take. Tolerance says what the client can stand. Required return says what the client needs. The portfolio has to honor all three — and when they conflict, the conversation gets interesting."},
          {"type": "subheading", "content": "Worked example — Naomi at 32"},
          {"type": "paragraph", "content": "Naomi has a 32-year time horizon for retirement, stable W-2 income, six months of emergency reserves, and is saving 18% of gross income. Her risk capacity is high — even a 40% drawdown does not break the plan because she will not need the money for three decades and has cash flow to keep contributing through any drawdown. Her risk tolerance, based on questionnaire and the panic email from Module 14, is moderate — she felt real pain at 18% down. Her required return to hit a comfortable retirement is about 6% real. The portfolio decision has to thread the needle: capacity says go aggressive, tolerance says no more than she can stand, required return says she does not need to take maximum risk."},
          {"type": "subheading", "content": "Worked example — A 68-year-old retiree"},
          {"type": "paragraph", "content": "Now consider a 68-year-old retiree drawing 4.5% of a $1.2M portfolio annually. Risk capacity is lower than Naomi's — a 40% drawdown means selling assets to fund withdrawals at depressed prices, which can permanently impair the plan. Risk tolerance is high — this client lived through 1987, 2000, and 2008 and never sold. Required return is about 5% nominal to sustain the withdrawal rate. Here capacity is the binding constraint, not tolerance. Just because the client can stand more risk does not mean the plan can. The 60/40 portfolio is right not because the client is timid but because the plan cannot tolerate large equity drawdowns at this stage."},
          {"type": "callout", "kind": "warn", "content": "Common error: building portfolios based only on risk tolerance. A client who says 'I can handle anything' but who needs the money in 18 months for a down payment has high tolerance and zero capacity. The capacity wins. Always."},
          {"type": "subheading", "content": "The fourth quiet variable — risk perception"},
          {"type": "paragraph", "content": "Some practitioners add a fourth: risk perception, or how the client interprets the risk they are taking. Two clients with identical 70/30 portfolios can perceive their risk completely differently — one because they understand what they own, the other because they do not. Perception is what the counselor's communication shapes. The same portfolio that feels 'volatile and concerning' can feel 'doing exactly what it should' when the client understands the design. Education is part of risk management."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Questionnaire and What It Actually Measures",
        "summary": "Risk tolerance questionnaires are a compliance requirement and a starting point. They are not the answer — they are a prompt for a conversation.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most broker-dealers and RIAs require a documented risk tolerance questionnaire on file for every client. The instruments vary — Riskalyze (now Nitrogen), FinaMetrica, internal proprietary scales — but they generally try to do three things: measure stated risk tolerance under hypothetical scenarios, measure investment knowledge, and surface preferences about volatility versus growth. Used well, they are useful. Used badly, they are dangerous — because a client who scored 'aggressive' on a questionnaire and then sold at the bottom of a drawdown will be the first person the client's attorney points at."},
          {"type": "subheading", "content": "What good questionnaires try to measure"},
          {"type": "list", "items": [
            "Stated reaction to hypothetical drawdowns — would you sell, hold, or buy more if your portfolio fell 25%?",
            "Investment knowledge and experience — how long have you invested, what have you owned?",
            "Time horizon and liquidity needs — when do you need the money, how much, for what?",
            "Preference between volatility and growth — would you take a steady 5% or a volatile 10%?",
            "Income stability and other resources — how does this money fit the rest of your picture?"
          ]},
          {"type": "subheading", "content": "What questionnaires cannot measure"},
          {"type": "list", "items": [
            "How the client will actually behave when the loss is real instead of hypothetical",
            "How the client will behave when their spouse, parent, or coworker is panicking around them",
            "Whether the client understood the questions the way you intended",
            "Hidden context — a recent layoff, a divorce, a parent's illness — that shifts everything"
          ]},
          {"type": "callout", "kind": "do", "content": "Walk through the questionnaire with the client, do not just hand it to them. Watch which questions they hesitate on. Ask 'tell me more about why you picked that' on any answer that feels off. The conversation around the questionnaire is more valuable than the score."},
          {"type": "subheading", "content": "Interpreting the score"},
          {"type": "paragraph", "content": "Most questionnaires output a number or band — Conservative, Moderately Conservative, Moderate, Moderately Aggressive, Aggressive — that maps to a model portfolio. Treat the band as a starting point and a documentation artifact, not a final answer. If the questionnaire says Moderate but the client just received a $1.5M inheritance from a parent they lost three months ago, the right move may be to start more conservatively than the band suggests for the first year. The score does not know about the grief."},
          {"type": "case_study", "title": "The questionnaire that lied", "scenario": "Naomi takes a risk tolerance questionnaire and scores Aggressive. She answers every drawdown question with 'I would buy more.' Six months later she sends the panic email from Module 14 after an 18% drop. The questionnaire was not wrong on its terms — Naomi genuinely believed she would buy more. But she had never experienced a drawdown with real money. Stated tolerance and revealed tolerance can differ enormously. The advisor's note after the panic episode: 'Reassess as Moderately Aggressive at most. Build a 5-7% cash buffer to give her something to deploy during the next drawdown so she has agency.'", "discussion": "The questionnaire's mistake was not the score. It was being treated as the answer. Revealed behavior in the first real drawdown is more diagnostic than any questionnaire. Reassess and document the reassessment."},
          {"type": "callout", "kind": "note", "content": "Re-administer the risk tolerance questionnaire after major life events, after a significant drawdown the client experienced, and at minimum every two to three years. Tolerance is not a fixed trait."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Suitability — The Legal Standard, Plain English",
        "summary": "Suitability is not a vague aspiration. It is a regulatory requirement with specific elements. Know what it requires and what it does not.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Suitability is the foundational regulatory requirement for investment recommendations in the United States. FINRA Rule 2111 governs broker-dealer representatives. SEC Regulation Best Interest (Reg BI), effective June 2020, raised the standard for broker-dealers when recommending securities to retail customers — requiring that recommendations be in the customer's best interest at the time of the recommendation. RIAs and their representatives operate under a separate fiduciary standard under the Investment Advisers Act of 1940, which has historically been a higher standard than suitability — though the practical gap narrowed somewhat with Reg BI."},
          {"type": "callout", "kind": "key", "content": "Suitability is the floor. Fiduciary duty is the higher standard. Know which applies to you in the role you are operating. At GIC, the apprentice operates under the supervision of a fiduciary advisor — your work is held to the higher standard whether or not you personally hold the license that requires it."},
          {"type": "subheading", "content": "FINRA Rule 2111 — three suitability obligations"},
          {"type": "glossary", "terms": [
            {"term": "Reasonable-basis suitability", "definition": "The recommendation is reasonable for at least some investors. The product itself is not inherently unsuitable. Diligence on the product."},
            {"term": "Customer-specific suitability", "definition": "The recommendation is reasonable for this specific customer based on their profile — age, financial situation, tax status, investment experience, objectives, time horizon, liquidity needs, and risk tolerance."},
            {"term": "Quantitative suitability", "definition": "Even if individual recommendations are suitable, the pattern of recommendations — the frequency, volume, and turnover — is not excessive for the customer."}
          ]},
          {"type": "subheading", "content": "Reg BI — four obligations for broker-dealers"},
          {"type": "list", "items": [
            "Disclosure — provide certain disclosures before or at the time of the recommendation",
            "Care — exercise reasonable diligence, care, and skill",
            "Conflict of interest — establish and enforce written policies addressing conflicts",
            "Compliance — establish and enforce policies reasonably designed to achieve compliance with Reg BI"
          ]},
          {"type": "subheading", "content": "The Form CRS"},
          {"type": "paragraph", "content": "Reg BI introduced a required client relationship summary — Form CRS — that broker-dealers and RIAs must deliver to retail clients. It is meant to be a plain-English explanation of services, fees, conflicts, and standard of conduct. You should be able to walk a client through your firm's Form CRS in five minutes. Practice it."},
          {"type": "subheading", "content": "Documenting suitability"},
          {"type": "paragraph", "content": "Suitability lives or dies in the documentation. A recommendation that was suitable but undocumented is, from a compliance perspective, indistinguishable from one that was unsuitable. The file note for any recommendation should capture: what was recommended, why it was suitable given the client's profile, what alternatives were considered and why they were rejected, what disclosures were made, and what the client said in response. Do this consistently and a regulator can reconstruct your reasoning years later. Skip it and you cannot reconstruct your own reasoning a year later."},
          {"type": "case_study", "title": "The variable annuity recommendation that needed a paper trail", "scenario": "An apprentice's supervising advisor is recommending a deferred variable annuity for a 58-year-old client with $450,000 in qualified retirement assets. The annuity has a 1.65% M&E fee, a 2.10% rider fee for guaranteed lifetime income, and a 7-year surrender schedule. The apprentice drafts the suitability memo: client objective (income certainty in retirement), why this product (income rider provides longevity hedging the client values), alternatives considered (managed payout fund, bond ladder, deferred income annuity at age 70 — each evaluated and noted), all fees and surrender terms disclosed, client signed acknowledgment. The memo is six paragraphs.", "discussion": "If this client complains in three years that the fees ate her returns, the file shows that the alternatives were considered, the fees were disclosed, the client's stated objective was income certainty, and the product matched that objective. The memo is the difference between a defensible recommendation and a problem."},
          {"type": "callout", "kind": "do", "content": "If you would not feel comfortable explaining the recommendation to a regulator three years from now without the file in front of you, write a better file note now. Documentation is part of the recommendation, not paperwork after it."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "When Capacity and Tolerance Disagree",
        "summary": "The hardest counseling conversations happen when what the client can financially afford and what they can emotionally tolerate point in opposite directions. Here is how to work through it.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When capacity, tolerance, and required return all line up, the portfolio decision is easy. The work happens when they disagree. The four common mismatches are worth knowing by name because you will see each of them in client meetings."},
          {"type": "subheading", "content": "Mismatch 1 — high capacity, low tolerance"},
          {"type": "paragraph", "content": "The client has a long horizon, stable income, and plenty of resources, but cannot sleep with equity volatility. They are emotionally a 40/60 client in a financial situation that could support 80/20. If you build 80/20 to maximize math, they will sell at the bottom and lock in losses. If you build 40/60 to honor emotion, they may not hit their goals. The honest move: meet them where they are now — say 50/50 or 60/40 — and use education, smaller exposures, and time to gradually grow tolerance. Do not engineer for the portfolio they should have. Engineer for the portfolio they will actually hold."},
          {"type": "subheading", "content": "Mismatch 2 — low capacity, high tolerance"},
          {"type": "paragraph", "content": "The opposite case. The retiree with high stated tolerance whose plan cannot survive a 40% drawdown. The recent retiree who 'rode out 2008 fine' but is now in a withdrawal phase rather than an accumulation phase. Capacity wins. Even if the client wants more equity, the responsible counselor explains why the portfolio that fit during accumulation is not the portfolio that fits during withdrawal. Sequence-of-returns risk is the technical name. Educate, document, and constrain."},
          {"type": "subheading", "content": "Mismatch 3 — required return exceeds capacity"},
          {"type": "paragraph", "content": "The client wants to retire at 55 on $90,000 a year and currently has $400,000 saved with eight years to go. The required return to make that math work without further savings is implausibly high. You cannot fix this with a more aggressive portfolio — taking the risk required to chase that return creates an unacceptable probability of being permanently impaired. The right conversation is not about portfolio. It is about goals. Some combination of saving more, working longer, spending less in retirement, or accepting a lower probability of success is needed. The portfolio cannot solve a goal problem."},
          {"type": "callout", "kind": "warn", "content": "When required return exceeds reasonable capacity, the temptation is to recommend more aggressive investments to chase the math. Resist. You are setting the client up to fail in a drawdown. Instead, reset the goals."},
          {"type": "subheading", "content": "Mismatch 4 — capacity exceeds required return"},
          {"type": "paragraph", "content": "The pleasant case. A client has more resources, time, or income stability than they need for their goals. They could take 80/20 risk but only need 50/50 returns to be fine. Do not maximize what is unnecessary. A wealthy retiree who already has more than enough for the rest of their life does not benefit from chasing growth — the marginal dollar from upside does not change their life, while a large drawdown could meaningfully damage it. Discuss explicitly with the client whether they want growth for heirs, philanthropy, or other purposes — and let that conversation, not a return target, drive the allocation."},
          {"type": "case_study", "title": "Marcus and Tasha — required return reality check", "scenario": "Marcus and Tasha — early 30s, two kids — want to fully fund both college costs and retire at 60. After running the projections, the required return is 8.5% real to do everything without raising savings. That is implausible to plan around — it exceeds long-term equity real returns and would require taking risk that breaks tolerance. The apprentice does not propose a more aggressive portfolio. Instead they walk through the four levers: save more, retire later, spend less in retirement, or accept partially funding college (with the kids covering the gap through scholarships, in-state schools, or loans). Marcus and Tasha decide to raise savings by 3% and target 80% of college costs rather than 100%. The required return drops to 5.8% real — achievable.", "discussion": "Notice that the apprentice did not solve a goals problem with a portfolio recommendation. They surfaced the math, explained the levers, and let the clients choose. That is fiduciary work."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Talking About Risk So Clients Actually Feel It",
        "summary": "Statistics about standard deviation and Sharpe ratios do not move clients. Dollar amounts and lived scenarios do. Communicate risk the way clients hear it.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A 15% standard deviation on a portfolio means almost nothing to almost any client. 'Your portfolio could drop by $87,000 in a bad year' means everything. The skill is in translating statistical risk into experienced risk — turning percentages into dollars, charts into stories, and abstract probabilities into something the client can feel before they have to live through it."},
          {"type": "subheading", "content": "From percentages to dollars"},
          {"type": "paragraph", "content": "Every time you discuss potential drawdowns with a client, translate to dollars on their actual balance. A 30% drawdown on a $750,000 portfolio is $225,000 — and the client needs to sit with that number before agreeing to the allocation that produces it. If they flinch at the number, the allocation is wrong. If they nod calmly and say 'I have seen that before and it does not move me,' the allocation may be right. The point is not to scare the client. The point is to surface the actual experience the portfolio is signing them up for."},
          {"type": "subheading", "content": "Historical context — what the portfolio has done before"},
          {"type": "paragraph", "content": "Show clients the actual worst rolling 12-month and 36-month periods for portfolios similar to theirs. A 70/30 portfolio's worst 12-month period since 1976 was roughly -28% in 2008. That is what the portfolio did the last time things got bad. If the client cannot imagine signing for that, do not build that portfolio. If the client says 'I lived through it and added money,' you have useful information."},
          {"type": "subheading", "content": "Range framing"},
          {"type": "paragraph", "content": "Rather than a single expected return, show the client the range. 'Over 20 years, a portfolio like this has historically returned between X% and Y% per year on the worst and best rolling 20-year windows. The middle is around Z%.' This honors the truth that returns are not a constant and prevents the client from anchoring on the median as a promise."},
          {"type": "subheading", "content": "Probability of failure language"},
          {"type": "paragraph", "content": "Monte Carlo simulations output a probability that the plan succeeds — say, '88% probability the plan succeeds over the planning horizon.' Many clients hear 88% and feel reassured. Some clients hear 12% probability of failure and feel terrified — same number, different framing. Both framings are honest. Lead with the one that gives the client the most accurate emotional signal for their situation. If the client is risk-tolerant and may underprepare, lead with the failure framing. If the client is risk-averse and may overreact, lead with the success framing. Both numbers should be in the document."},
          {"type": "case_study", "title": "Explaining a 70/30 portfolio to a couple in their 40s", "scenario": "The apprentice is presenting a 70/30 portfolio to a couple with $560,000 invested. Rather than 'expected return 6.5%, standard deviation 11.2%,' the apprentice says: 'Based on history, this portfolio averages about 6 to 7 percent a year, but in a bad year it could drop by $90,000 to $170,000. The worst 12-month period for something like this since 1976 was about $156,000 down. The recovery from that took roughly three years. Can you sign up for that experience between now and retirement, knowing it will happen at least once or twice?'", "discussion": "Notice — dollars, history, recovery time, and an explicit invitation to commit. The couple either says yes with eyes open or says no and the apprentice goes back to design. Either outcome is better than building a portfolio the clients did not actually understand the risk of."},
          {"type": "callout", "kind": "key", "content": "If the client cannot sign for the drawdown number in calm conversation, they cannot hold the portfolio in the actual drawdown. Find the allocation they can sign for. That is the right one."},
          {"type": "subheading", "content": "Closing the suitability loop"},
          {"type": "paragraph", "content": "When risk is communicated this way and the client agrees to the allocation in writing, suitability is not a paperwork exercise. It is a documented record of an informed decision. That is what regulators want to see. That is what clients want to remember when the drawdown actually arrives. That is the goal of this entire module — not to predict the future, but to prepare the relationship for whatever future shows up."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: now that you have the right allocation, you have to present the full plan in a way the client can actually absorb. Plan Presentation & Communication."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Risk capacity is best described as:", "options": ["How much loss the client can emotionally absorb", "How much loss the client can financially absorb without breaking the plan", "The annualized return needed to hit goals", "The standard deviation of the portfolio"], "correct": 1, "explanation": "Capacity is the objective financial measure — what the plan can survive. Tolerance is the emotional measure. Required return is the math need."},
        {"id": "q2", "prompt": "A 24-year-old client with stable income, a 40-year horizon, and high stated comfort with volatility wants to invest a down payment they will use in 18 months. The right portfolio decision is:", "options": ["Aggressive equity allocation since they have high tolerance", "Conservative cash or short-term instruments since capacity for this dollar is low", "Match their stated tolerance regardless of horizon", "60/40 by default"], "correct": 1, "explanation": "Capacity wins. The dollar is needed in 18 months — that is zero capacity for equity drawdown, no matter what tolerance the client states."},
        {"id": "q3", "prompt": "FINRA Rule 2111 includes which three suitability obligations?", "options": ["Disclosure, care, and conflict of interest", "Reasonable-basis, customer-specific, and quantitative suitability", "Capacity, tolerance, and required return", "Fees, performance, and benchmarks"], "correct": 1, "explanation": "Rule 2111 specifies reasonable-basis (product itself), customer-specific (right for this client), and quantitative (pattern of recommendations not excessive) suitability."},
        {"id": "q4", "prompt": "Regulation Best Interest (Reg BI) became effective in:", "options": ["June 2017", "January 2019", "June 2020", "January 2022"], "correct": 2, "explanation": "Reg BI became effective in June 2020 and raised the standard for broker-dealer recommendations to retail customers."},
        {"id": "q5", "prompt": "Form CRS is:", "options": ["A risk tolerance questionnaire", "A required client relationship summary explaining services, fees, conflicts, and standard of conduct", "A custodial agreement", "A tax form"], "correct": 1, "explanation": "Form CRS is the plain-English client relationship summary that broker-dealers and RIAs must deliver to retail clients under Reg BI."},
        {"id": "q6", "prompt": "When required return significantly exceeds reasonable capacity, the right move is to:", "options": ["Recommend a more aggressive portfolio to chase returns", "Reset the goals through some combination of saving more, working longer, spending less, or accepting lower success probability", "Switch to alternative investments", "Tell the client to be patient"], "correct": 1, "explanation": "Portfolio cannot solve a goals problem. Surface the math, walk the client through the levers, and let them choose."},
        {"id": "q7", "prompt": "Sequence-of-returns risk is most relevant to:", "options": ["Young accumulators with long horizons", "Clients in or near withdrawal from the portfolio", "Tax-advantaged accounts only", "Fixed-income investors"], "correct": 1, "explanation": "Sequence risk matters most when withdrawals are being taken — early drawdowns paired with withdrawals can permanently impair the plan."},
        {"id": "q8", "prompt": "Naomi scored 'Aggressive' on her risk questionnaire but panicked after an 18% drawdown. The right interpretation is:", "options": ["The questionnaire was useless", "Stated tolerance and revealed tolerance can differ; reassess based on lived behavior and document the change", "Naomi should be reclassified as Conservative", "Risk questionnaires should not be used"], "correct": 1, "explanation": "Stated tolerance under hypothetical scenarios is not the same as revealed behavior in real drawdowns. Reassess and document the reassessment."},
        {"id": "q9", "prompt": "Communicating risk to clients is most effective when:", "options": ["Standard deviation and Sharpe ratios are emphasized", "Risk is translated into dollar amounts on the client's actual balance and into historical experienced drawdowns", "Only positive outcomes are highlighted", "Probability of failure is never mentioned"], "correct": 1, "explanation": "Dollars and historical experience move clients in a way statistics do not. The goal is for the client to feel the risk before they have to live through it."},
        {"id": "q10", "prompt": "Suitability documentation should capture, at minimum:", "options": ["The recommendation only", "What was recommended, why suitable for this client, alternatives considered, disclosures made, and client response", "The fee schedule", "Marketing materials"], "correct": 1, "explanation": "The file note should let a reviewer reconstruct the reasoning years later, including alternatives considered and rejected and disclosures made."},
        {"id": "q11", "prompt": "When capacity exceeds required return — the client has more resources or time than they need — the appropriate response is to:", "options": ["Automatically recommend more aggressive growth", "Discuss with the client whether growth for heirs, philanthropy, or other purposes is desired, and let purpose drive allocation", "Move to all cash since growth is unnecessary", "Maintain the standard model regardless"], "correct": 1, "explanation": "When unnecessary risk is not needed, the right conversation is about purpose. Excess capacity becomes a choice, not a default."},
        {"id": "q12", "prompt": "At GIC, an apprentice operating under the supervision of a fiduciary advisor is held to:", "options": ["The suitability standard only", "The higher fiduciary standard, regardless of personal licensing", "No regulatory standard", "Whatever the client chooses"], "correct": 1, "explanation": "The fiduciary standard governs the work product at GIC. Apprentices learn and operate to the higher standard from day one."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 15;

-- ── module16_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 16 CONTENT
-- Plan Presentation & Communication
-- ============================================================================
update public.modules set
  title = 'Plan Presentation & Communication',
  competency_id = 'OJL-7',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Present a complete financial plan in a way clients can absorb, remember, and act on — without drowning them in detail or hiding behind jargon.',
  learning_objectives = ARRAY[
    'Structure a plan presentation that leads with the client''s goals, not your analysis',
    'Build plan documents and slide decks that an intelligent non-expert can read alone',
    'Lead a presentation meeting with confidence, including for difficult news',
    'Handle questions, objections, and emotional reactions in real time',
    'Close the meeting with clear action steps, ownership, and follow-up dates'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Designing the Plan Document for the Client, Not the Planner",
        "summary": "Most financial plans are written for the planner who built them. The good ones are written for the client who has to read them — once, alone, sitting at the kitchen table.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A planning deliverable that the client cannot read alone has failed, no matter how technically excellent it is. The test for any plan document is: if the client looked at this six months from now without you in the room, could they tell what their situation is, what was recommended, and what their action items are? If yes, you have done the work. If no, you have produced a beautiful artifact that does not serve the client."},
          {"type": "subheading", "content": "The standard plan document structure"},
          {"type": "numbered", "items": [
            "Executive summary — one page, written last, captures the entire plan in a way a busy client can read in three minutes",
            "Goals as stated — what the client said they wanted, in their words and prioritized order",
            "Current financial position — net worth, cash flow, key balances, current account titles",
            "Key observations — what the analysis revealed, organized by topic not by spreadsheet",
            "Recommendations — clear, prioritized, with rationale and tradeoffs explained",
            "Implementation plan — who does what by when",
            "Appendices — full statements, projections, Monte Carlo runs, disclosure documents"
          ]},
          {"type": "callout", "kind": "key", "content": "Lead with goals, end with action. Everything in between is supporting the path from one to the other."},
          {"type": "subheading", "content": "The one-page executive summary"},
          {"type": "paragraph", "content": "The executive summary is the most important page of the document and should be written last. It captures, in order: who the client is (one sentence), what they came to plan for, what you found, what you recommend, and what happens next. A client should be able to read the executive summary alone and know whether to read the rest. If the summary cannot stand alone, the plan is not yet finished."},
          {"type": "subheading", "content": "Visual hierarchy and white space"},
          {"type": "list", "items": [
            "One major idea per page — do not pack pages with multiple topics",
            "Headings at the top of pages, not floating in the middle",
            "Tables and charts captioned with the takeaway, not just the data ('Net worth has grown 32% over three years' beats 'Net worth over time')",
            "Reading text at 11-12pt minimum — older clients especially should not have to squint",
            "Black ink on white pages for most content; reserve color for emphasis and brand consistency"
          ]},
          {"type": "subheading", "content": "Plain language commitment"},
          {"type": "paragraph", "content": "Every word of jargon in a plan document is a small invitation for the client to feel stupid or to disengage. Both are bad outcomes. Sweep through any draft and replace: 'asset allocation' becomes 'how your money is split between stocks, bonds, and other things'; 'tax-deferred' becomes 'taxes due later, not now'; 'Roth conversion' becomes 'paying tax now to make a chunk of your retirement money tax-free later.' Use industry terms only after you have established the plain English meaning, and only where the term itself is part of what the client needs to learn."},
          {"type": "callout", "kind": "do", "content": "Read the draft aloud as if you were the client. If you stumble on a sentence, rewrite it. If a sentence requires you to pause and explain to yourself, the client will not understand it either."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Presentation Meeting — Structure and Flow",
        "summary": "A good plan presentation is not just reading the document out loud. It is a designed experience that builds understanding, surfaces reactions, and ends in clear commitment.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The plan presentation meeting is usually 60 to 90 minutes. The temptation is to walk page by page through everything you produced. Resist. The client does not need a tour of your work. They need to understand their situation, understand your recommendations, and arrive at the end of the meeting with clarity about what to do next."},
          {"type": "subheading", "content": "The flow"},
          {"type": "numbered", "items": [
            "Reset the room (5 min) — reconnect, remind them why you are here, restate goals as they stated them",
            "Walk the current position (10-15 min) — net worth, cash flow, where their money is today",
            "Surface key findings (15 min) — three to five observations from the analysis, in order of importance",
            "Present recommendations (20-30 min) — what to do, in priority order, with rationale and tradeoffs",
            "Discuss and react (10-15 min) — open the floor, hear questions and objections, adjust where needed",
            "Close with action (5-10 min) — what happens next, who owns each step, when you talk again"
          ]},
          {"type": "subheading", "content": "Reset the room"},
          {"type": "paragraph", "content": "Open with the client's own goals in their own words, read back from the discovery meeting. This grounds the conversation in why you are here. Clients will sit through 75 minutes of analysis if they feel the analysis is in service of what they actually want. They will tune out in five minutes if they feel the meeting is about the planner's process."},
          {"type": "subheading", "content": "Walk the current position"},
          {"type": "paragraph", "content": "Before you present recommendations, the client and you need to share a picture of where they are now. Use the financial statements from Module 13. Walk net worth, walk cash flow, point out the biggest line items. Ask 'does this look like your situation?' and pause for the answer. Catching a missing $14,000 credit card balance in this conversation is much cheaper than discovering it after recommendations have been made."},
          {"type": "subheading", "content": "Surface key findings"},
          {"type": "paragraph", "content": "After current position, share three to five findings from your analysis. Not twenty. Three to five. Examples: 'You are over-allocated to a single employer's stock through your RSUs.' 'Your beneficiary designations are stale from before you got married.' 'You are funding a 529 before maxing the match on your 401(k).' Each finding sets up a recommendation. Each one should be a clean sentence the client can repeat to their spouse later."},
          {"type": "callout", "kind": "key", "content": "Findings are not the recommendations. They are the observations that justify the recommendations. Separating them keeps the logic clean."},
          {"type": "subheading", "content": "Present recommendations in priority order"},
          {"type": "paragraph", "content": "Lead with the highest-impact, easiest-to-implement recommendation. Build momentum. A client who agrees to three things in the first ten minutes is more likely to agree to the harder recommendation that comes after. A client who hears the hardest recommendation first may dig in and refuse everything that follows. Sequence intentionally."},
          {"type": "subheading", "content": "Tradeoffs explicitly named"},
          {"type": "paragraph", "content": "Every recommendation costs something. Maxing the 401(k) means less cash flow now. Paying off the auto loan early means less in the brokerage. A Roth conversion means a tax bill this year. Name the tradeoff every time. Clients who hear only the benefits become suspicious, or worse, surprised later when they see the cost. Clients who hear benefits and tradeoffs trust the recommendation more, even when they decline it."},
          {"type": "case_study", "title": "Marcus and Tasha at the presentation meeting", "scenario": "The apprentice opens with their stated goals: pay down debt, build emergency fund, fund college, retire at 60. Walks current position — including the $14,000 credit card balance surfaced in discovery. Three findings: (1) the rate on the credit card is the highest-cost thing in their financial picture; (2) Marcus's 401(k) match is being left on the table; (3) the 529 was started before either of those was addressed. Three recommendations in order: redirect the 529 contribution temporarily, capture the full match, attack the credit card aggressively. Tradeoff named: 529 will fall a year behind plan, recoverable later. Marcus and Tasha agree to all three in 45 minutes. The fourth and harder recommendation — raising the savings rate by 3% — comes after they have already said yes three times.", "discussion": "Notice the order. Easy wins first, hard ask last. Notice the explicit tradeoff. Notice that the recommendations all trace back to findings, which all trace back to stated goals. The presentation is not a sales pitch. It is a logical chain the clients can follow and own."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Delivering Difficult News",
        "summary": "Sometimes the analysis says things the client does not want to hear. The skill of delivering hard news without breaking trust is what separates apprentices from counselors.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Some of the most important sentences in this work are uncomfortable to say. 'You will not be able to retire at the age you planned.' 'The way you have been managing taxes has cost you significant money.' 'Your current allocation cannot survive a major drawdown.' 'The spending level you are describing is not sustainable.' Saying these things clearly, kindly, and with the next step ready is part of the practice. Hiding from them is malpractice."},
          {"type": "subheading", "content": "The structure of a difficult-news conversation"},
          {"type": "numbered", "items": [
            "Signal that something hard is coming — 'I want to walk through one finding that I think will be the most important conversation we have today'",
            "Deliver the news cleanly — no hedging, no jargon, no minimizing",
            "Give the client a moment — silence is appropriate; do not rush to fill it",
            "Acknowledge the emotion — name what you observe ('this is a lot to take in')",
            "Move to options — 'here are the levers we can pull' — never deliver bad news without a path forward",
            "Invite the client to choose the path — they decide, not you"
          ]},
          {"type": "subheading", "content": "Do not minimize"},
          {"type": "paragraph", "content": "When delivering hard news, the temptation is to soften it: 'It is probably not as bad as it sounds' or 'lots of clients are in this position.' These phrases protect the planner's discomfort, not the client. They also make the client distrust the data. Say it cleanly. The client can handle truth. They cannot handle a counselor who flinches."},
          {"type": "subheading", "content": "Do not catastrophize either"},
          {"type": "paragraph", "content": "The opposite mistake is loading the news with urgency that is not warranted. 'You are in serious trouble' when the client has time to course-correct creates fear without information. Calibrate to the actual situation: how big is the gap, what is the time horizon, what levers exist?"},
          {"type": "subheading", "content": "Always have the next step ready"},
          {"type": "paragraph", "content": "Never deliver bad news without options for what to do about it. If you have to say 'you cannot retire at 60 on your current trajectory,' you should be ready immediately with: 'Here are the four things we could do — work two more years, raise savings by X, lower spending target by Y, or accept higher probability of needing to adjust mid-retirement. We do not have to decide today.' The path forward turns a verdict into a problem the client can solve with you."},
          {"type": "case_study", "title": "The retiree who is overspending", "scenario": "A 71-year-old client has been drawing 7.5% of her portfolio annually for the last four years. The Monte Carlo run shows a 35% probability the plan fails by age 88. The apprentice does not soften: 'I want to walk through what we found, because it is important. At your current spending rate, our analysis shows about a 35% chance the portfolio runs short before age 88. I do not want you to find that out at 85. Here is what we can do: adjust spending by about $1,200 a month, sell the second car and reduce insurance and fuel, downsize the home in the next two years, or some combination of these. We have time to decide. Which of these is hardest to hear?' The client says the second car. The apprentice explores it without judgment.", "discussion": "Notice the clarity, the options, the pause, the invitation. The client is not lectured. The client is informed and then asked. By the end of the meeting the client has chosen a path that reduces spending by $850 a month — drawing from two of the three levers. The plan now projects 91% probability of success. The hard news became a solvable problem."},
          {"type": "callout", "kind": "do", "content": "If you cannot bring yourself to say the hard thing, you cannot do this job. Practice the sentences. Say them out loud before the meeting if you have to. The client deserves someone who can deliver truth with care."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Handling Questions, Objections, and Emotional Reactions",
        "summary": "The middle of a plan presentation is where it earns its keep. Real questions surface. Real objections come up. Real feelings arrive. Handle them well and the plan gets implemented.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If the client asks no questions during your presentation, they either understand everything or they have stopped engaging. The second is more likely. Build pauses into the presentation explicitly. 'Before I move on, what questions are coming up?' 'How is this landing for you?' Silence is not agreement. Silence is data."},
          {"type": "subheading", "content": "Types of questions and how to handle them"},
          {"type": "glossary", "terms": [
            {"term": "Clarifying questions", "definition": "The client wants to make sure they understood. Answer plainly and check that the answer landed. 'Did that make sense, or do you want me to explain it differently?'"},
            {"term": "Stress-test questions", "definition": "The client is testing the recommendation. 'What if the market drops 40%?' 'What if I lose my job?' Welcome these. Run the scenario if the data supports it."},
            {"term": "Skeptical questions", "definition": "The client is not convinced. 'Why this and not that?' Take the question seriously. If you do not have a good answer, do not bluff. 'That is a good question, let me get you a better answer before we decide.'"},
            {"term": "Emotional questions disguised as logical ones", "definition": "'But what if I want to retire earlier?' is sometimes a math question and sometimes an underlying anxiety. Listen to which."},
            {"term": "Sourced-elsewhere questions", "definition": "'My brother-in-law says I should buy gold.' Acknowledge the source, address the substance gently, do not insult the brother-in-law."}
          ]},
          {"type": "subheading", "content": "When clients object"},
          {"type": "paragraph", "content": "Objections are not the end of the conversation. They are the beginning. An objection means the client is engaged enough to push back — which is better than a silent nod followed by no implementation. The move when you hear an objection: slow down, do not defend, ask one open question."},
          {"type": "list", "items": [
            "'Tell me more about what is bothering you about that recommendation'",
            "'What would have to be true for that to feel like the right move?'",
            "'Help me understand what you are weighing'",
            "'Is there a piece of this I have not addressed yet?'"
          ]},
          {"type": "subheading", "content": "Adjusting in real time"},
          {"type": "paragraph", "content": "Sometimes the client raises something that genuinely changes the recommendation. The right response is not to defend the original plan. The right response is to incorporate the new information. 'Given what you just told me, I want to walk back to the recommendation on the 529 and think differently about it.' This is not weakness. This is fiduciary work — the recommendation should match the facts, and the facts just changed."},
          {"type": "subheading", "content": "When emotions surface"},
          {"type": "paragraph", "content": "Plan presentations can trigger emotion. A client may cry talking about a parent's terminal illness that affects estate plans. A spouse may get angry at the other spouse mid-meeting. A retiree may grieve realizing they have to keep working two more years. None of this is unprofessional. All of it is part of the work. Slow down, acknowledge what you observe ('I can see this is a lot'), let them have the moment, and continue when they are ready. Offer water. Offer to pause and resume later. Do not pretend you did not notice."},
          {"type": "callout", "kind": "warn", "content": "Never make a recommendation feel like a sales close. 'So can we get this implemented today?' lands wrong in a fiduciary relationship. The client should feel like the decision is theirs and the timeline serves them, not you."},
          {"type": "case_study", "title": "Devon pushes back on the line of credit", "scenario": "After the equipment financing conversation, the apprentice recommends Devon establish a $150,000 business line of credit at his bank to address the cash protection need. Devon resists: 'I do not want to owe the bank anything.' The apprentice does not argue. 'Tell me more about that — what is the feeling about owing the bank?' Devon describes a childhood watching his uncle's restaurant fail under bank debt. The apprentice acknowledges the experience, then offers a reframe: 'A line of credit you do not draw on costs you a small annual fee but creates optionality. It is not the same as debt — it is access to debt only if you decide to use it. What would feel different if you knew you could decide later?' Devon stays skeptical. The apprentice does not push. 'Let us hold the line of credit idea for now and come back to it after we work through the next set of recommendations. There is no rush.'", "discussion": "The apprentice noticed the emotion behind the objection, honored it, offered information, and then let go of the close. Devon will think about it. He may agree in the next meeting. He may not. Either way, the relationship and the rest of the plan are not at risk."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing the Meeting — Action, Ownership, Next Date",
        "summary": "A plan that ends with 'we will follow up soon' is a plan that does not get implemented. Close every meeting with specifics so the client knows exactly what happens next.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The last ten minutes of the meeting matter as much as the previous eighty. This is where commitment turns into action — or where action quietly evaporates because nobody specified who does what by when. Treat the closing of the meeting as a separate section of the agenda with its own time block."},
          {"type": "subheading", "content": "The action list — every item has three things"},
          {"type": "numbered", "items": [
            "What — a specific, concrete task in plain language",
            "Who owns it — exactly one person, named",
            "By when — a specific date, not 'soon' or 'this month'"
          ]},
          {"type": "paragraph", "content": "Examples that work: 'Tasha will pull last year's tax return and email a PDF to me by November 8.' 'I will draft the beneficiary change forms for both IRAs and send them for your signature by November 15.' 'Marcus will increase the 401(k) contribution from 6% to 9% in the employer's portal by November 22.' Each item is unambiguous. Each item has a single owner. Each item has a date. The whole list lives at the bottom of the executive summary and in your CRM."},
          {"type": "callout", "kind": "do", "content": "Read the action list aloud at the end of the meeting and ask the client to confirm each item. 'Tasha, you have the tax return by the 8th — does that work?' If they hesitate, find a better date now, not later."},
          {"type": "subheading", "content": "Document the meeting"},
          {"type": "paragraph", "content": "Within 24 hours, send a written meeting recap to the client that includes: what was discussed, what was decided, the action list with owners and dates, and the next meeting date. This serves three purposes: it gives the client a written reference, it triggers the action list (the recap email is often what makes the client actually do their tasks), and it creates a record for compliance. The recap should be plain English. Not a transcript. A clear summary."},
          {"type": "subheading", "content": "Set the next date before you leave the room"},
          {"type": "paragraph", "content": "The single biggest predictor of whether action items get done is whether a follow-up meeting is on both calendars. 'We will check in once you have done those things' is too vague. 'Let us put 30 minutes on the calendar for December 10 to review where you got' is concrete. Schedule it before the current meeting ends. Send the invite from the room if needed."},
          {"type": "subheading", "content": "Quality check — would the client tell their friend?"},
          {"type": "paragraph", "content": "After the meeting ends, ask yourself: if this client called their best friend tomorrow and said 'I just had my plan presentation,' would they describe a clear set of decisions and a path forward, or would they describe a confusing meeting with a lot of charts? The first is the goal. If you cannot picture the friend conversation going well, the meeting was not closed properly. Improve the close next time."},
          {"type": "case_study", "title": "Closing with Marcus and Tasha", "scenario": "After the 75-minute presentation, the apprentice spends the final 10 minutes on the action list. Six items: (1) Marcus increases 401(k) to 9% by Nov 22 in Fidelity portal; (2) Tasha pulls last year's tax return and emails to apprentice by Nov 8; (3) Tasha sets up auto-transfer of $400 bi-weekly to high-yield savings account by Nov 15; (4) Both sign updated beneficiary change forms for IRAs once apprentice sends by Nov 15; (5) Apprentice prepares 529 contribution pause memo and emails by Nov 12; (6) Both review and approve the written plan and sign the IPS by Nov 30. Next meeting set for December 14 at 4pm to review progress. Recap email sent the next morning. Five of six items completed by next meeting.", "discussion": "Not because Marcus and Tasha were unusually disciplined — because the action list was unambiguous, the owners were assigned, the dates were specific, and the recap arrived in writing. The structure produced the outcome."},
          {"type": "callout", "kind": "key", "content": "The presentation meeting does not end with a plan. It ends with the next action. Always."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: implementation. The plan has been presented and agreed to. Now somebody has to actually move the money, file the paperwork, change the beneficiaries, and coordinate with the CPA and attorney. Implementation & Coordination."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The single best test for a plan document is:", "options": ["The number of pages it contains", "Whether it includes Monte Carlo projections", "Whether the client can read it alone six months later and understand their situation, recommendations, and next steps", "Whether it uses industry-standard terminology throughout"], "correct": 2, "explanation": "A plan document that requires the planner present to be understood has failed. The standalone readability test is the right standard."},
        {"id": "q2", "prompt": "In a plan presentation, recommendations should be sequenced:", "options": ["Hardest first to get them out of the way", "In random order to keep the client engaged", "In priority order, with high-impact easy wins first to build momentum", "Alphabetically"], "correct": 2, "explanation": "Building momentum with easy agreements early makes harder recommendations later more likely to be accepted. Sequence intentionally."},
        {"id": "q3", "prompt": "When delivering difficult news, the right structure includes:", "options": ["Soften the news so the client does not get upset", "Signal something hard is coming, deliver cleanly, give a moment, acknowledge emotion, move to options, let client choose", "Move quickly past the hard part to keep momentum", "Avoid the hard news if possible"], "correct": 1, "explanation": "The structure protects both clarity and care. Never deliver bad news without options for what to do next."},
        {"id": "q4", "prompt": "A client says 'lots of clients must be in worse shape than us.' The planner's best response is to:", "options": ["Agree to make the client feel better", "Avoid the comparison and refocus on the client's specific situation and the path forward", "Compare to specific other clients", "Drop the difficult finding"], "correct": 1, "explanation": "Comparing to others, either to comfort or alarm, distracts from the client's actual situation. Refocus on what the analysis shows and the options available."},
        {"id": "q5", "prompt": "Every action item in a plan close should have:", "options": ["A category and a color code", "What, who owns it, and a specific date", "An expected return", "A signature"], "correct": 1, "explanation": "Specific task, single owner, concrete date. Without all three, action items decay."},
        {"id": "q6", "prompt": "When a client raises an objection during presentation, the most effective first move is to:", "options": ["Defend the recommendation with more data", "Slow down, do not defend, and ask one open question about the objection", "Move to the next topic", "Lower the recommendation"], "correct": 1, "explanation": "Objections are engagement. Open questions explore the underlying concern. Defense usually makes objections harder, not softer."},
        {"id": "q7", "prompt": "The plan document's executive summary should be:", "options": ["Written first, before the analysis", "Written last and able to stand alone as a summary the client can read in a few minutes", "Three or more pages with all detail", "Optional"], "correct": 1, "explanation": "The executive summary is written last because it captures the entire plan. It should be standalone-readable for the busy client."},
        {"id": "q8", "prompt": "In delivering difficult news, never:", "options": ["Be specific about the magnitude", "Deliver bad news without ready options for what to do about it", "Pause for the client to react", "Acknowledge the emotion"], "correct": 1, "explanation": "Bad news without options creates fear without agency. Always have the next-step levers ready before you open the conversation."},
        {"id": "q9", "prompt": "The standard plan document structure leads with:", "options": ["Detailed investment performance tables", "The client's goals as stated in their own words", "Disclosure documents", "The planner's credentials"], "correct": 1, "explanation": "Leading with client goals grounds everything that follows in the reason the work was done. Goals first, action last."},
        {"id": "q10", "prompt": "Within how long should a meeting recap be sent to the client after the presentation?", "options": ["A week", "24 hours", "30 days", "Only if requested"], "correct": 1, "explanation": "Within 24 hours preserves the freshness of the conversation and triggers the action list while commitment is high."},
        {"id": "q11", "prompt": "Tradeoffs in recommendations should be:", "options": ["Mentioned only if the client asks", "Named explicitly every time, including what the recommendation costs", "Hidden so the recommendation is more appealing", "Discussed only in the appendix"], "correct": 1, "explanation": "Naming the tradeoff every time builds trust and prevents surprises. Clients who hear both benefits and costs make better decisions and trust the counselor more."},
        {"id": "q12", "prompt": "If a client cries or shows strong emotion during a plan presentation, the right response is to:", "options": ["Pretend you did not notice and continue", "End the meeting immediately", "Slow down, acknowledge what you observe, let them have the moment, and continue when they are ready", "Tell them to stay focused on the numbers"], "correct": 2, "explanation": "Emotion is part of the work, not a disruption to it. Acknowledge gently, hold the moment, and continue when they are ready."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 16;

-- ── module17_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 17 CONTENT
-- Implementation & Coordination
-- ============================================================================
update public.modules set
  title = 'Implementation & Coordination',
  competency_id = 'OJL-8',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Move from agreed plan to executed plan — opening accounts, transferring assets, coordinating with the CPA and attorney, and tracking every moving piece without dropping any of them.',
  learning_objectives = ARRAY[
    'Sequence implementation steps in the right order to avoid avoidable mistakes',
    'Execute account opens, transfers, and rollovers cleanly',
    'Coordinate with external professionals — CPA, estate attorney, insurance broker',
    'Track implementation status across multiple workstreams without dropping items',
    'Recognize when an implementation step is going wrong and intervene early'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Implementation Is Where Plans Die",
        "summary": "Excellent plans that never get implemented are common. The implementation phase is operational, detail-heavy, and where most relationships either prove their value or quietly fail.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most clients who switch advisors do so not because the previous advisor gave bad advice but because the previous advisor never finished implementing the advice they gave. The plan landed in a binder. The action items decayed. The beneficiary update never happened. The 401(k) increase was set up incorrectly. The Roth conversion the client agreed to was never executed before year-end. Implementation is unglamorous, repetitive, deadline-driven work — and it is the work that determines whether the plan was real."},
          {"type": "callout", "kind": "key", "content": "A plan is not a recommendation. A plan is a sequence of completed actions. Until each action is done and documented, the plan is aspirational."},
          {"type": "subheading", "content": "Why implementation breaks down"},
          {"type": "list", "items": [
            "Too many items moving at once with no master list and no owner per item",
            "Sequence errors — a step happens before its prerequisite is done, creating rework",
            "Hand-offs without confirmation — assuming the client did their part, or the custodian processed the form, without verifying",
            "External professionals not looped in or looped in too late",
            "Tax deadlines missed because the calendar was not respected"
          ]},
          {"type": "subheading", "content": "The implementation tracker"},
          {"type": "paragraph", "content": "Every client should have a single implementation tracker — a document or CRM record listing every action item, owner, status, and completion date. This is not the action list from the presentation meeting. That list seeded the tracker. The tracker grows as the work surfaces sub-items (the beneficiary form needs notarization; the rollover requires a Letter of Acceptance from the receiving custodian; the Roth conversion has to happen before December 31 and after the client's CPA confirms the year's marginal bracket). The tracker is reviewed at every internal review of the relationship and updated weekly while implementation is active."},
          {"type": "subheading", "content": "Status discipline"},
          {"type": "paragraph", "content": "Each item on the tracker has a status. Useful states: Not Started, In Progress (with sub-state), Waiting On Client, Waiting On Custodian, Waiting On External Pro, Complete, Blocked. The 'Waiting On' states are the danger zones — items in 'Waiting On Client' for three weeks need a follow-up. Items in 'Waiting On Custodian' for ten business days need an escalation. The status is not just a label. It is a trigger for a specific next action."},
          {"type": "callout", "kind": "warn", "content": "An item that has been 'In Progress' for more than two weeks without sub-state explanation is almost always actually stuck. Investigate. Things do not unstick themselves."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Sequencing — What Has to Happen Before What",
        "summary": "Some implementation tasks have dependencies. Doing them out of order creates rework, missed deadlines, and avoidable client confusion. Learn the common sequences.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The order of implementation matters as much as the items themselves. A few classic sequence rules — break them and you create avoidable problems."},
          {"type": "subheading", "content": "Account opens before transfers"},
          {"type": "paragraph", "content": "If a recommendation involves transferring assets from one custodian to another, the receiving account has to exist before the transfer can be initiated. Sounds obvious. Gets missed routinely when the transfer paperwork goes out before the receiving account has been fully funded with its initial deposit and is in 'active' status. Open the account, fund it with a small initial deposit if required, confirm active status, then initiate the transfer."},
          {"type": "subheading", "content": "Beneficiaries updated immediately when accounts open"},
          {"type": "paragraph", "content": "Every new account — IRA, Roth, 401(k), brokerage, life insurance — has a beneficiary designation. Default beneficiary is usually 'estate' if you do not designate, which is the worst outcome for almost every client. Update beneficiaries the same day the account opens. Do not wait. People die unexpectedly. Beneficiaries trump wills. This is one of the most important and most neglected items in implementation."},
          {"type": "callout", "kind": "do", "content": "On every new account opened, the same-day checklist includes: beneficiaries designated, contingent beneficiaries designated, beneficiary percentages add to 100%, transfer-on-death (TOD) registration on taxable accounts where appropriate, and the client has a copy of the confirmed designation."},
          {"type": "subheading", "content": "Tax-aware sequencing within the calendar year"},
          {"type": "list", "items": [
            "Roth conversions should happen as early in the year as you can confirm the year's bracket, or as late as you can with enough lead time to settle before December 31",
            "Required Minimum Distributions (RMDs) must complete by December 31 (with the first one optionally by April 1 of the year after the client turns 73)",
            "Mega-backdoor Roth in-plan conversions are typically annual or per-pay-period; align with the plan's rules",
            "Tax-loss harvesting is most relevant in volatile years and must complete before December 31 with attention to wash-sale rules (30 days before or after)",
            "Charitable contributions — DAF funding, QCDs from IRAs — must complete and clear by December 31 to count for that tax year"
          ]},
          {"type": "subheading", "content": "Rollovers — direct vs indirect"},
          {"type": "paragraph", "content": "When moving money between retirement accounts — say a 401(k) at a former employer to an IRA — the direct rollover (also called a trustee-to-trustee transfer) is almost always the right choice. The check, if any, is made payable to the receiving custodian for benefit of the client. No tax withholding. No 60-day clock. An indirect rollover — where the check is made payable to the client and the client has 60 days to redeposit — triggers mandatory 20% federal tax withholding on pre-tax balances and requires the client to come up with that 20% from their own pocket to complete the full rollover. The IRS one-rollover-per-12-months rule also restricts indirect rollovers. Avoid indirect rollovers unless there is a specific reason."},
          {"type": "callout", "kind": "warn", "content": "If a rollover check arrives at the client's house made payable to the client, it is an indirect rollover. Stop the implementation, document the situation, and call the sending custodian to reissue properly. Depositing the check to the client's checking account starts the 60-day clock and the tax consequences. Time is of the essence."},
          {"type": "subheading", "content": "Insurance changes — apply before canceling"},
          {"type": "paragraph", "content": "If a client is replacing one insurance policy with another, the new policy must be issued and in force before the old policy is canceled. Otherwise the client may end up uninsured during the gap, or worse, develop a health condition that makes them uninsurable at the new policy. This is so basic it gets violated routinely. Issued, in force, premiums paid on the new policy — only then cancel the old."},
          {"type": "case_study", "title": "The rollover that took six weeks instead of two", "scenario": "An apprentice initiates a 401(k) rollover from a client's former employer to an IRA at the new custodian. The receiving IRA was opened but had no initial deposit. The former employer's plan custodian processed the rollover request, generated a check, and held it pending receipt of the new account being active. Two weeks later, nothing had happened. The apprentice discovered the receiving account was sitting in 'pending funding' status. They made a $25 initial deposit to activate the account, which took another four business days to clear. The rollover check was finally issued — but to the wrong address because the new custodian's record had a typo from the original form. Total elapsed time: six weeks. Avoidable.", "discussion": "Two errors compounded: not funding the receiving account at open, and not double-checking address fields on the receiving paperwork. Both are one-minute checks that prevent multi-week delays. Implementation is detail work. The details matter."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Coordinating With External Professionals",
        "summary": "Tax planning lives at the CPA. Estate planning lives at the attorney. Insurance lives at the broker. You orchestrate. Doing it well means clear hand-offs and shared records.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most clients have a roster of professionals — financial advisor, CPA or tax preparer, estate attorney, insurance broker, sometimes a business attorney or a banker. Each of these professionals has expertise the financial advisor does not have and authority over decisions the advisor cannot make. Implementation usually requires getting work done across this roster, with the client in the center and the advisor often as the coordinator."},
          {"type": "subheading", "content": "Get authorization first"},
          {"type": "paragraph", "content": "Before reaching out to a client's CPA or attorney, you need the client's written authorization to communicate with that professional. Most firms have a 'Authorization to Release Information' form for this. Without it, the CPA cannot legally discuss the client's tax situation with you, and the attorney cannot share estate documents. Get the authorization signed early in the relationship for everyone the client wants in the loop. It saves weeks of friction later."},
          {"type": "subheading", "content": "Working with the CPA"},
          {"type": "list", "items": [
            "Send the CPA a written summary of any tax-relevant moves before executing — Roth conversion, harvesting transaction, sizable charitable contribution, distribution from an inherited IRA",
            "Ask the CPA to confirm the projected tax impact in writing before you execute",
            "After execution, send the CPA the confirmation and 1099 reporting details",
            "Coordinate timing — March through April the CPA is unreachable; do not plan major moves with a tax deadline in tax season",
            "Year-end planning conversations should happen in October or early November, not December"
          ]},
          {"type": "subheading", "content": "Working with the estate attorney"},
          {"type": "list", "items": [
            "Estate documents — will, revocable trust, durable power of attorney, healthcare directive — usually need to be reviewed every 3-5 years or after any major life event",
            "When the attorney updates documents, request copies of the executed final versions for your file",
            "Beneficiary designations on retirement accounts and life insurance often need to be coordinated with the trust structure; do not assume the attorney did this — verify",
            "Account titling matters as much as beneficiaries; if the attorney recommends retitling assets into a trust, track which accounts are completed",
            "Be explicit about who is responsible for funding the trust — the attorney may draft the trust but funding is often the client's or advisor's responsibility"
          ]},
          {"type": "subheading", "content": "Working with the insurance professional"},
          {"type": "paragraph", "content": "If the client uses a separate insurance broker — common — coordinate on policy changes carefully. Beneficiary changes on life insurance need to match the estate plan. Disability and long-term care coverage assumptions in the financial plan need to match the actual policy terms (which the insurance broker has). Annuity decisions in particular benefit from a three-way conversation between client, advisor, and insurance broker so the client is not navigating product complexity alone."},
          {"type": "subheading", "content": "Shared documentation"},
          {"type": "paragraph", "content": "When professionals coordinate, share the relevant documents — with client consent — in a single shared folder or via direct exchange. Avoid forwarding chains. Avoid attaching documents the client did not approve to share. Each professional should be working from the same numbers; if estate plan projections are using one net worth figure and the financial plan is using a different one, decisions get made on inconsistent data."},
          {"type": "case_study", "title": "The Roth conversion that needed three people", "scenario": "A client wants to convert $80,000 from a Traditional IRA to a Roth in October. The financial advisor's apprentice runs the projection and identifies $80,000 as the amount that fills the 24% bracket without spilling into 32%. Before executing, the apprentice emails the client's CPA with the calculation. The CPA replies — appreciates the math, notes the client also has a large planned bonus arriving in November that will push the bracket boundary down by about $14,000. Revised conversion: $66,000. The apprentice updates the projection, gets the client's written approval for the new figure, executes the conversion in October. The 1099-R goes to the CPA in January. Tax filed cleanly.", "discussion": "Without the CPA loop, the apprentice would have over-converted by $14,000, generating an avoidable tax bill in the 32% bracket and a frustrated client. The CPA's information existed; the apprentice's coordination unlocked it. Coordination is not an extra step — it is part of the recommendation."},
          {"type": "callout", "kind": "key", "content": "If a recommendation has tax implications and you have not talked to the CPA, you have not finished the recommendation. If it has estate implications and you have not coordinated with the attorney, you are working blind."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "The Operational Mechanics — Forms, Signatures, Custodian Workflows",
        "summary": "The day-to-day of implementation is paperwork, signatures, and custodian-specific quirks. Knowing what each step actually requires saves time and prevents errors.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Every custodian — Schwab, Fidelity, Pershing, Goldman Sachs Custody Solutions, others — has its own forms, its own workflows, its own quirks. Multiply this by the dozens of operational tasks in a typical client relationship and the operational load gets significant. Master the basic toolkit and you can navigate any custodian's specifics."},
          {"type": "subheading", "content": "Common forms an apprentice will handle"},
          {"type": "glossary", "terms": [
            {"term": "New account application", "definition": "Opens a new account with the custodian. Requires identity verification (KYC), investment objectives, risk tolerance, source of funds, and signed agreements."},
            {"term": "ACAT transfer", "definition": "Automated Customer Account Transfer Service. The industry standard for transferring securities between brokerage accounts. Typically 5-10 business days."},
            {"term": "Letter of Acceptance (LOA)", "definition": "Document from the receiving custodian confirming they will accept the transfer. Required for some non-standard transfers."},
            {"term": "TOD (Transfer on Death) registration", "definition": "Allows a taxable account to pass directly to a named beneficiary outside probate."},
            {"term": "Beneficiary designation form", "definition": "Names primary and contingent beneficiaries for retirement accounts and insurance products. Must specify percentages totaling 100% within each category."},
            {"term": "Standing instruction / Letter of Authorization", "definition": "Allows recurring transfers or specific authority. Some are good only for one occurrence; some are durable."},
            {"term": "W-9 / W-8BEN", "definition": "Tax certification forms. W-9 for U.S. persons, W-8BEN for non-U.S. persons."},
            {"term": "Distribution form", "definition": "Authorizes a distribution from a retirement account. Specifies amount, tax withholding, payment method."}
          ]},
          {"type": "subheading", "content": "Signature mechanics"},
          {"type": "paragraph", "content": "Most custodians now accept e-signature via DocuSign or equivalent. A few specific forms still require wet signature or notarization — older life insurance policies, certain bank accounts, some retirement plan beneficiary changes when the client is married and the spouse must consent. Know which forms in your firm's typical workflow require wet signature or notarization, and warn the client at the start so they are not surprised by a notary trip."},
          {"type": "subheading", "content": "Spousal consent — easy to miss, expensive when missed"},
          {"type": "paragraph", "content": "Qualified retirement plans (ERISA 401(k)s, profit-sharing plans) require spousal consent for non-spouse beneficiary designations and certain distribution choices. The spouse's signature must be witnessed by a plan representative or notarized. Miss this step and the designation may not be valid. IRAs are not subject to the same federal spousal consent rule (though community property states have their own treatment). Know the rules that apply to the specific account type."},
          {"type": "subheading", "content": "Standard quality checks before submission"},
          {"type": "list", "items": [
            "All required fields completed — no blanks the custodian will reject the form for",
            "Date is current — most forms have a 30-90 day shelf life from signature date",
            "Account numbers match the actual accounts on the custodian's system, not a typo",
            "Dollar amounts and percentages internally consistent — 60/40/0 adds to 100, not 100 with a 5 hiding somewhere",
            "Names spelled exactly as on the account — Robert vs Bob, middle initial vs not",
            "Notary block completed if required — notary's signature, seal, expiration date all present"
          ]},
          {"type": "callout", "kind": "do", "content": "Have a second person on the team review any consequential form before submission. Two sets of eyes catch errors one set misses. The marginal time cost is minutes. The cost of a rejected form is days."},
          {"type": "case_study", "title": "The beneficiary form that did not count", "scenario": "An apprentice helps a client update the beneficiary on a 401(k) from 'estate' to 'spouse 100%.' The form is signed by the client and submitted. Three months later when the apprentice does a routine review, they pull up the plan portal and notice the designation still shows 'estate.' On investigation: the plan's beneficiary form requires spousal consent for the change to be valid, and the spousal consent line was blank. The plan administrator processed the form as 'incomplete — no change recorded' but did not notify the apprentice or client. The original beneficiary remained in effect.", "discussion": "Two failures: the form was submitted without spousal consent that was required, and the plan administrator's silent rejection was not detected because nobody verified the change took effect. Process fix: any consequential designation change should be confirmed by pulling the post-change record from the source system within a week of submission. Trust but verify."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing the Loop — Confirming Everything Actually Happened",
        "summary": "Submission is not completion. The implementation phase ends only when every action has been verified on the source system and documented. Closing the loop is the discipline that separates working plans from theatrical ones.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An apprentice's instinct is to mark an action 'done' when they submit it. The correct discipline is to mark it 'done' only when verified — when the change has appeared in the actual source system, when the beneficiary shows correctly in the plan portal, when the rollover has settled in the receiving account at the right amount, when the form has been processed by the custodian rather than rejected, when the trust has been funded with the asset rather than just listed in the trust document. Trust the system once. Verify the system always."},
          {"type": "subheading", "content": "Verification practices for common tasks"},
          {"type": "list", "items": [
            "Account opening — pull the new account record and confirm: title is correct, registration matches, beneficiaries are populated, all features (TOD, check-writing, debit access) are configured as intended",
            "Asset transfer — confirm the dollar amount that arrived matches what was sent (within reasonable cost-basis transfer accuracy); review the cost basis on transferred securities for accuracy",
            "Beneficiary change — pull the post-change designation page and confirm the new beneficiaries are present at the correct percentages",
            "Contribution change — confirm the change is reflected in the next pay period or contribution cycle, not just in the request",
            "Distribution — confirm the dollar amount received matches the requested amount and withholding; confirm tax withholding was correctly applied",
            "Roth conversion — confirm the converted amount left the traditional account and arrived in the Roth, with the correct tax-year coding for reporting"
          ]},
          {"type": "subheading", "content": "Document everything"},
          {"type": "paragraph", "content": "Every implementation action generates an artifact — a confirmation number, a screenshot, an email, a paper statement. File each one in the client folder with a date and a short description. This is not paranoia. This is the audit trail that protects the client and the firm if a question arises a year or five years later. 'I submitted that change' is not a defensible statement. 'Here is the confirmation showing the change was made on March 14 at 11:42am' is."},
          {"type": "subheading", "content": "Communicate completion to the client"},
          {"type": "paragraph", "content": "When an action is verified complete, tell the client. A simple email — 'The Roth conversion of $66,000 was completed on October 12; you will receive a 1099-R from the custodian in January. The CPA has been copied' — gives the client confidence that the work is happening and creates a record they can refer back to. The cumulative effect of these small communications is enormous over the course of a year. Clients who hear from their advisor about completed work feel taken care of. Clients who never hear anything assume nothing is happening."},
          {"type": "subheading", "content": "The implementation review at the end"},
          {"type": "paragraph", "content": "Once the implementation phase of a new plan or a major change is complete, hold a brief internal review: did every action item complete, what took longer than expected, what surfaced unexpected complications, what should we do differently next time. This is not a long meeting. Twenty minutes. The point is to keep getting better at the operational work, which compounds across hundreds of clients over a career."},
          {"type": "case_study", "title": "Closing out Marcus and Tasha's first 90 days", "scenario": "Of the six action items from the presentation meeting, five completed within the target dates. The sixth — the auto-transfer setup for $400 bi-weekly — was set up but the initial transfer date was set to the wrong day, missing the first paycheck cycle. The apprentice caught it because they had a tracker item to verify the first transfer hit. They corrected the date, the second cycle ran clean, and they emailed Tasha to confirm. Six of six items now verified complete. The apprentice writes a one-page summary for the client: what was done, current state of accounts, next review date.", "discussion": "Without the verification step, the missed first transfer would have surfaced months later as 'wait, we have less in the emergency fund than I expected.' The discipline of confirming each action on the source system caught the error within days. The summary email also doubled as a touchpoint that reinforced the client relationship."},
          {"type": "callout", "kind": "key", "content": "Implementation ends when verified, not when submitted. The verification habit, more than any other operational skill, separates apprentices who become trusted counselors from those who stay junior forever."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: the relationship does not end with implementation. Ongoing reviews, life events, and the long-term cadence of the planning relationship."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "An action item should be marked complete when:", "options": ["The form was submitted", "The client confirmed they did their part", "The change has been verified on the source system", "The follow-up meeting is scheduled"], "correct": 2, "explanation": "Submission is not completion. Verification on the actual system the change affects is the only valid completion signal."},
        {"id": "q2", "prompt": "On a new account, beneficiary designations should be:", "options": ["Updated within 30 days of opening", "Updated at the next annual review", "Updated the same day the account opens, with primary and contingent beneficiaries both designated", "Optional — wills cover everything"], "correct": 2, "explanation": "Beneficiaries trump wills. Default beneficiary on most accounts is 'estate,' which is the worst outcome. Update same-day, always."},
        {"id": "q3", "prompt": "Direct rollover versus indirect rollover — the direct rollover is preferred because:", "options": ["It is faster", "It avoids mandatory 20% tax withholding and the 60-day redeposit risk", "It costs less", "It is required by law"], "correct": 1, "explanation": "Direct rollovers move funds custodian-to-custodian without withholding and without the 60-day clock. Indirect rollovers trigger 20% mandatory federal withholding on pre-tax balances."},
        {"id": "q4", "prompt": "Before reaching out to a client's CPA to discuss their tax situation, you need:", "options": ["The CPA's business card", "Written authorization from the client to communicate with the CPA", "The client's verbal okay on the phone", "Nothing — CPAs can always discuss their clients"], "correct": 1, "explanation": "Written authorization (Authorization to Release Information) is required. Without it, the CPA legally cannot discuss the client's tax situation with you."},
        {"id": "q5", "prompt": "When replacing one insurance policy with another, the correct sequence is:", "options": ["Cancel the old policy first to save money during application", "Apply for the new policy, get it issued and in force with premiums paid, then cancel the old", "Submit both simultaneously", "Let the policies overlap for at least six months"], "correct": 1, "explanation": "Never leave the client uninsured during a gap. The new policy must be issued and in force before the old policy is canceled."},
        {"id": "q6", "prompt": "A Roth conversion intended for the current tax year must be completed:", "options": ["By April 15 of the following year", "By the client's tax filing deadline", "Before December 31 of the conversion year", "Within 60 days of starting the process"], "correct": 2, "explanation": "Roth conversions count for the tax year in which the conversion completes — funds must leave the traditional IRA and arrive in the Roth before December 31."},
        {"id": "q7", "prompt": "Qualified ERISA retirement plans like 401(k)s require spousal consent for:", "options": ["All distributions of any size", "Non-spouse beneficiary designations and certain distribution choices, with the spouse's signature witnessed or notarized", "Account opening", "Investment changes"], "correct": 1, "explanation": "ERISA spousal consent applies to non-spouse beneficiary designations and certain distribution elections. Missing the consent invalidates the change."},
        {"id": "q8", "prompt": "Implementation status of 'Waiting On Custodian' for ten business days should trigger:", "options": ["Continued patience", "Escalation — something is likely stuck and needs follow-up", "Automatic reassignment to another team member", "Marking the item complete"], "correct": 1, "explanation": "Items do not unstick themselves. Ten business days of waiting on a custodian is the threshold to escalate and find out what is blocking."},
        {"id": "q9", "prompt": "The Letter of Acceptance (LOA) is used in implementation to:", "options": ["Confirm a client's identity", "Document that the receiving custodian will accept a non-standard transfer", "Authorize standing instructions", "Acknowledge fee disclosures"], "correct": 1, "explanation": "An LOA from the receiving custodian confirms they will accept the inbound transfer, especially for non-standard assets or registrations."},
        {"id": "q10", "prompt": "Year-end tax planning conversations with the CPA should ideally happen:", "options": ["In December, just before deadlines", "In October or early November, before tax season pressure", "In April after returns are filed", "Anytime in the year"], "correct": 1, "explanation": "October/early November leaves enough time to execute moves before December 31 and avoids the March-April CPA unavailability."},
        {"id": "q11", "prompt": "If a rollover check arrives at the client's house made payable to the client, the right move is to:", "options": ["Deposit it to the client's checking account immediately", "Stop, document, and call the sending custodian to reissue the check made payable to the receiving custodian for the benefit of the client", "Cash it and use the proceeds for the rollover", "Hold it for 60 days"], "correct": 1, "explanation": "A check payable to the client is an indirect rollover. Reissue properly as a direct rollover to avoid the 20% withholding and 60-day clock."},
        {"id": "q12", "prompt": "The post-implementation review with the team should focus on:", "options": ["Assigning blame for any items that took longer than expected", "Identifying what surfaced unexpected complications and what to do differently next time", "Renegotiating client fees", "Marketing the firm's services"], "correct": 1, "explanation": "The review is a process improvement exercise — capture what surfaced, what slowed things down, and what should change going forward. Operational learning compounds across hundreds of clients."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 17;

-- ── module18_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 18 CONTENT
-- Ongoing Reviews & Life Events
-- ============================================================================
update public.modules set
  title = 'Ongoing Reviews & Life Events',
  competency_id = 'OJL-9',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Move from a one-time plan to a continuing relationship — building a review cadence, watching for life events that change the plan, and adapting without losing continuity.',
  learning_objectives = ARRAY[
    'Design a review cadence that matches client complexity and stage of life',
    'Lead an effective annual review that surfaces what has changed and what should change',
    'Recognize the life events that require plan changes — and the ones that do not',
    'Handle estate-relevant life events (death, divorce, disability) with care and competence',
    'Maintain continuity in the relationship across years and transitions'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "From One-Time Plan to Continuing Relationship",
        "summary": "The first 90 days deliver the plan. The next thirty years deliver the value. Building a relationship structure that lasts is the real work.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Financial planning is not a project with an end date. It is a relationship that lasts decades. The plan you build in year one is a snapshot. The plan that actually serves the client is the moving body of work that adapts as their life changes — new jobs, marriages, divorces, children, inheritances, business sales, health events, deaths. The counselor who sees clients only once a year and produces an annual report has built a thin relationship. The counselor who has rhythm with the client across the year, knows what is coming, and adapts as life happens has built something different."},
          {"type": "callout", "kind": "key", "content": "Plans do not fail because the math was wrong. Plans fail because life changed and nobody updated the plan."},
          {"type": "subheading", "content": "The continuing relationship has structure"},
          {"type": "paragraph", "content": "A well-structured ongoing relationship has at least three components: a scheduled review cadence (annual at minimum, more often for complex clients), trigger-based touchpoints (calls or meetings when something material changes), and ambient communication (regular brief updates, market context when warranted, year-end planning reminders). The cadence is set at the start and adjusted as the client's situation evolves. A 35-year-old accumulator with a stable W-2 does not need the same cadence as a 68-year-old business seller in transition."},
          {"type": "subheading", "content": "Typical cadences by client stage"},
          {"type": "list", "items": [
            "Early accumulator (20s-30s, simple situation) — annual review, ad hoc check-ins around major decisions",
            "Mid-career complex (40s-50s, multi-account, business owner, or pre-retirement) — semi-annual reviews, quarterly informal touch",
            "Pre-retirement (3-5 years before retirement) — semi-annual reviews with explicit retirement countdown, more frequent in the final year",
            "Recently retired (first 5 years) — semi-annual reviews to dial in the withdrawal strategy as it meets reality",
            "Mature retirement (steady-state) — annual review, more often if health or longevity events are surfacing",
            "Transition periods (divorce, business sale, recent widow/widower) — weekly to monthly for the duration of the transition, then taper"
          ]},
          {"type": "subheading", "content": "Cadence is not the same as 'check the boxes'"},
          {"type": "paragraph", "content": "An annual review that consists of a custodian-generated performance report and twenty minutes of small talk is not a review. It is theater. A real review surfaces what has changed in the client's life, what has changed in the plan, what needs to change going forward, and what the client should expect over the next year. If you cannot answer 'what did we accomplish in that meeting' with three specific things, the meeting was not used well."},
          {"type": "subheading", "content": "Building the relationship account"},
          {"type": "paragraph", "content": "Every interaction with a client is a small deposit or withdrawal from the relationship. Calls returned promptly are deposits. Forgotten birthdays of the client's children that the client mentioned years ago are withdrawals. Remembered details — the client's recent surgery, the kid who started college, the parent who passed — are large deposits. The cumulative effect over a decade is the difference between a counselor the client describes as 'my advisor who manages my money' and one they describe as 'someone I trust completely with everything.'"},
          {"type": "callout", "kind": "do", "content": "After every client interaction, take 60 seconds and add one or two human details to the CRM. The client's golden retriever's name. The kid's college. The travel plans they mentioned. A year from now you will remember to ask, and that question will be the most important thing you do that meeting."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Annual Review — Structure, Preparation, Execution",
        "summary": "An annual review well-led is more valuable than the first plan that produced it. Here is how to do one that actually moves the relationship and the plan forward.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The annual review is the most important single meeting in most client relationships. It is the moment where the past year is reckoned with and the next year is shaped. Done well, it generates clarity, surfaces issues early, and produces a refreshed action list. Done poorly, it becomes a perfunctory 'everything is on track' that papers over the actual situation."},
          {"type": "subheading", "content": "Preparation — what you do before the meeting"},
          {"type": "numbered", "items": [
            "Pull current financial statements — updated net worth and cash flow",
            "Run a fresh projection — has the trajectory changed from last year's expectations?",
            "Review the action items from the last meeting — what was done, what slipped, what is still open",
            "Review any communications during the year — what did the client tell you about that should inform the review?",
            "Pull any data the client may have shared — recent tax return, salary changes, new debts, life events",
            "Scan the markets and the macro — what context might the client be carrying into the meeting?",
            "Note any compliance, tax, or law changes that affect the client"
          ]},
          {"type": "subheading", "content": "Open the meeting on a personal note"},
          {"type": "paragraph", "content": "Do not lead with 'let me walk through your performance.' Lead with the client. 'How was your year overall — what stands out?' This opens space for the things you need to know about (a new job, a parent's illness, a kid's surprise college acceptance) that may not have surfaced in routine touches. Spend the first ten minutes here. If something significant has happened, you will need to restructure the rest of the meeting around it. Better to know early."},
          {"type": "subheading", "content": "The five-section agenda"},
          {"type": "numbered", "items": [
            "What changed for you this year? (10 min) — personal, professional, family, health",
            "Where you are now (10 min) — net worth, cash flow, progress against goals",
            "Did the plan do what it was supposed to? (15 min) — performance, withdrawals, savings, projections",
            "What needs to change for next year? (15 min) — recommendations driven by what was surfaced",
            "Action items and next meeting (10 min) — owners, dates, follow-up"
          ]},
          {"type": "subheading", "content": "Did the plan do what it was supposed to?"},
          {"type": "paragraph", "content": "This section is not 'how did the market do.' It is 'how did the plan do.' The plan was designed to accomplish certain things — fund savings, hit certain account balances, provide a certain income, maintain a certain risk level. Walk through whether each expected thing happened. If the client was supposed to save $24,000 to the IRA and Roth IRA combined and only $18,000 was saved, that is the conversation, not the S&P 500's return. Performance matters — but in context of the plan, not in isolation."},
          {"type": "subheading", "content": "What needs to change for next year?"},
          {"type": "paragraph", "content": "Based on what surfaced in sections 1 and 2 and what worked or did not work in section 3, make specific recommendations for the next year. Sometimes there are none — the plan is on track, the client's life is stable, the right move is to keep doing what is working. Sometimes there are many — a new job changes contribution capacity, a paid-off mortgage frees cash flow, a child's college is now four years closer. Whatever the recommendations, they should trace back to what was discussed in the meeting, not appear from nowhere."},
          {"type": "case_study", "title": "Marcus and Tasha's first annual review", "scenario": "One year after the initial plan presentation. Marcus and Tasha sit down with their apprentice for the annual review. The personal opening surfaces: Tasha's mother had a stroke six months ago — Tasha has been her caregiver and the family has spent ~$8,000 on home modifications and medical equipment. The financial section: credit card paid off, emergency fund at $7,200 (target was $9,000 — caregiving costs slowed progress), 401(k) contribution at 9% as planned, 529 still paused. Plan section: progress is real but slower than projected. Recommendations: continue paused 529 for another six months, hold emergency fund target steady (do not push to $12,000 yet), discuss long-term care planning for Tasha's mother as a separate workstream, surface the question of how the mother's care affects retirement timing.", "discussion": "Without the personal opening, the apprentice would have walked through numbers and recommended raising the 529 contribution — completely missing that Tasha is providing meaningful family caregiving. The recommendation set is now responsive to the actual life the clients are living, not to the spreadsheet."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Recognizing Life Events That Change the Plan",
        "summary": "Some life events require plan changes. Some do not. Knowing which is which — and acting promptly when one does — is core counselor judgment.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Life events fall on a spectrum. At one end are events that fundamentally change the plan: marriage, divorce, the birth of a child, death of a spouse, a major inheritance, a business sale, a significant disability, retirement itself. At the other end are events that feel big in the moment but do not actually require plan changes — a normal market drawdown, a missed bonus, a friend's bad financial advice. Calibrating which is which is judgment. Acting promptly when a real life event happens is non-negotiable."},
          {"type": "subheading", "content": "Major life events and what they typically require"},
          {"type": "glossary", "terms": [
            {"term": "Marriage", "definition": "Beneficiary review across all accounts, estate document update (will, POAs, healthcare directives), tax filing status review, insurance review (spouse covered, life insurance amounts), potential consolidation of accounts."},
            {"term": "Divorce", "definition": "QDRO for retirement plan division, beneficiary updates urgent, new will/trust, separate accounts re-established, cash flow reset for new household, often a year of close support."},
            {"term": "Birth/adoption of a child", "definition": "529 plan considered, life insurance review (term coverage often increases), guardian designation in will, possibly umbrella liability coverage."},
            {"term": "Death of a spouse", "definition": "Surviving-spouse rollovers, beneficiary cash flow assessment, Social Security survivor planning, estate administration, often six to twelve months of intensive support and decisions deferred where possible."},
            {"term": "Major inheritance", "definition": "Step-up basis valuation if inherited assets, qualified vs non-qualified inherited accounts each have own rules (SECURE Act 10-year window for most non-spouse inherited retirement accounts), tax planning urgent, behavioral support around the money."},
            {"term": "Business sale", "definition": "Tax planning (QSBS Section 1202, installment sales, earnouts), wealth management transition from concentrated business owner to diversified investor, estate planning review, often a multi-year project."},
            {"term": "Disability", "definition": "Disability insurance benefits coordination, Social Security disability if applicable, cash flow restructure, possible Special Needs Trust if permanent, estate plan review for capacity considerations."},
            {"term": "Retirement", "definition": "Cash flow transition from earned income to portfolio withdrawals, Social Security start decision, Medicare enrollment (turning 65), tax bracket management for early retirement years, withdrawal sequencing across account types."},
            {"term": "Job change", "definition": "Old 401(k) decision (leave, roll to new plan, roll to IRA), new benefits package review, salary change effect on savings rate, equity compensation if applicable, stock option/RSU treatment."}
          ]},
          {"type": "subheading", "content": "Events that look big but usually do not require plan changes"},
          {"type": "list", "items": [
            "A market drawdown — the plan was built assuming this would happen periodically",
            "A missed bonus — annual variability is part of the cash flow plan, not an anomaly unless persistent",
            "A friend's investment advice that conflicts with the plan — usually a conversation, not a plan change",
            "Short-term media noise (this election, this tax proposal, this crisis) — almost never requires a change in long-term allocation"
          ]},
          {"type": "callout", "kind": "warn", "content": "The hardest moment of judgment is when the client believes a non-event is an event and wants to change the plan. Push back gently. 'Let us not change the plan in response to this. Let us put it on the agenda for our next scheduled review and decide with a calmer head.'"},
          {"type": "subheading", "content": "When the client tells you about a life event"},
          {"type": "paragraph", "content": "When a client mentions a life event — even casually, even at the end of a meeting about something else — pause. Do not let it slip past. 'You mentioned your father moved in with you. Help me understand what is changing there.' Then schedule a dedicated conversation if the event warrants it. Some events warrant a meeting within a week. Some warrant a meeting within a month. Almost no event warrants 'we will get to that at the annual review' if the annual review is more than 90 days away."},
          {"type": "case_study", "title": "Devon's business sale", "scenario": "Devon, the small business owner from prior modules, calls the apprentice to mention he received an unsolicited offer to acquire his business at a price that would net him about $4.2M after taxes. The apprentice does not try to handle this in a phone call. They schedule a 90-minute meeting for that week, prepare by pulling Devon's financials and reviewing QSBS eligibility, recommend Devon engage a business attorney and a transaction-experienced CPA, and outline the multi-year wealth planning that will be needed if the sale proceeds. Devon's sale ultimately closes nine months later. The relationship and the plan are transformed.", "discussion": "Devon was a comfortable mid-six-figure client. Post-sale he is a wealth management client. The apprentice's recognition that this was a major life event — not a hypothetical to discuss whenever convenient — set up everything that followed. Speed and structure of response matter."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Handling Estate Events — Death, Disability, Divorce",
        "summary": "Three life events deserve their own treatment because of their emotional weight and operational complexity. Doing them well is what counselors are made for.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Death of a client, severe disability, and divorce are among the hardest situations a counselor will work through. The financial work is real and consequential. The human work alongside it — sitting with grief, navigating family dynamics, witnessing the worst chapters of someone's life — is real too. Be ready for both. Decline neither."},
          {"type": "subheading", "content": "When a client dies"},
          {"type": "numbered", "items": [
            "First contact is usually from the surviving spouse, an adult child, or the executor — within days of death",
            "Do not push for decisions in the first 30 days unless legally required (RMDs in year of death, certain tax-elective items)",
            "Death certificates — surviving family needs multiple originals; help guide where to order them",
            "Account-level work: each retirement account, brokerage, bank account, insurance policy has its own claims process; build a master tracker for the survivor",
            "Surviving spouse rollover — surviving spouse inheriting an IRA can typically roll it to their own IRA, treating it as their own (with their own RMD age and rules), which is usually preferred",
            "Non-spouse inherited retirement accounts — SECURE Act generally requires distribution within 10 years (with some exceptions), planning the withdrawal across the 10 years to manage tax brackets is part of the work",
            "Social Security survivor benefits — file with SSA, coordinate timing with the survivor's own benefits",
            "Estate administration coordinates with the attorney — probate where applicable, trust administration where applicable",
            "Cash flow reset for the survivor — household income often drops significantly; new plan needed"
          ]},
          {"type": "callout", "kind": "do", "content": "When a client dies, send a handwritten condolence note. Not an email. Not a card from the firm. From you, signed by you. The smallest gesture is the largest signal."},
          {"type": "subheading", "content": "When a client experiences a major disability"},
          {"type": "paragraph", "content": "Disability creates cash flow disruption (lost earned income), often new expenses (medical, equipment, home modifications, ongoing care), and sometimes capacity questions. Work in sequence: stabilize cash flow first (disability insurance benefits if any, possibly Social Security disability, drawing from emergency reserves), then assess the medium-term picture (return to work timeline, severity of impairment), then update the long-term plan. If capacity is impaired, the durable power of attorney becomes active — confirm it is in place and the agent knows. If a Special Needs Trust may be needed (for ongoing support without disqualifying from means-tested benefits), engage the attorney early."},
          {"type": "subheading", "content": "When clients divorce"},
          {"type": "paragraph", "content": "Divorce is the financial event most commonly mishandled by advisors. Both spouses were your clients. Now one or both will not be. The fiduciary duty does not disappear during the divorce. Common rules: stop making changes to joint accounts without both signatures, refer the spouses to separate counsel (yours and a separate advisor for the spouse who will leave), avoid being drawn into the legal or emotional fight, and prepare for the operational work — QDRO for retirement plan division, beneficiary updates that are now urgent, new wills, new accounts, new tax filing status."},
          {"type": "list", "items": [
            "QDRO (Qualified Domestic Relations Order) — the legal instrument required to divide an ERISA-qualified retirement plan in divorce; must be drafted by attorney and accepted by plan administrator",
            "Beneficiary updates are urgent — divorce does not automatically remove the ex-spouse from many beneficiary designations; update or face the possibility of the ex-spouse inheriting",
            "Tax filing status changes — joint to single, with attention to the year of divorce specifics",
            "New estate documents — old will likely names ex-spouse as executor and beneficiary",
            "Insurance review — life insurance for child support obligations, health insurance transition, disability if relevant",
            "Cash flow reset — household income usually drops, new fixed costs may rise"
          ]},
          {"type": "callout", "kind": "warn", "content": "Beneficiary designations on retirement accounts and life insurance survive divorce in most cases unless updated. Divorce decrees often require beneficiary changes — but the changes have to actually be made. People die between the decree and the update. Treat this as urgent."},
          {"type": "case_study", "title": "Tasha's mother — disability planning becomes real", "scenario": "Six months after the annual review, Tasha's mother's condition has progressed. Tasha and her siblings are deciding whether to bring in 24/7 home care, move her to a care facility, or have her move in with Tasha and Marcus permanently. The apprentice does not try to make this decision. They convene a session with Tasha, Marcus, and Tasha's siblings (with everyone's consent) to think through the financial implications of each scenario, identify what resources the mother has (Social Security, pension, small savings), surface what insurance coverage exists, and outline what Tasha and Marcus would need to take on financially. The family ultimately decides on a hybrid — daytime in-home care plus weekend support from siblings. The apprentice draws up a 24-month cash flow projection for the new arrangement and integrates it into Marcus and Tasha's plan.", "discussion": "The apprentice did not pretend to be a geriatric care expert. They were a planner who helped the family think through the financial consequences clearly. The family kept its own decision-making authority. The plan adapted to the new reality. Both human and operational work were done well."},
          {"type": "subheading", "content": "Sitting with the difficulty"},
          {"type": "paragraph", "content": "The temptation in hard life events is to retreat into spreadsheets and operational tasks because the operational tasks feel manageable and the human reality does not. Resist that impulse. Spreadsheets are part of the work, not all of it. The client needs both — competence at the operations and presence with the difficulty. If you can offer both, you become irreplaceable in the most important seasons of their life."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Continuity — Staying With the Client Across Decades",
        "summary": "The most valuable financial relationships are measured in decades. Building one requires intentional systems for memory, communication, and adaptation across years.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most advisors are with a client for a fraction of the client's financial life. The best advisors are with a client for the whole back half of it. Continuity is a system, not a feeling. The advisor who built systems for memory, communication, and adaptation early in their career has a different relationship at year fifteen than the advisor who relied on goodwill."},
          {"type": "subheading", "content": "The CRM as institutional memory"},
          {"type": "paragraph", "content": "Every client interaction generates information that may matter ten years later. The kid's name. The medical condition the spouse has. The vacation property in Oregon. The specific anxiety the client expressed about running out of money. The reason they switched advisors before you. None of this can be recalled reliably from human memory across a 20-year relationship and hundreds of other clients. The CRM is the place where the relationship's memory actually lives. Treat it that way. Add to it after every meeting. Read from it before every meeting. The few minutes invested compound enormously over the relationship."},
          {"type": "subheading", "content": "What goes in the CRM"},
          {"type": "list", "items": [
            "Family details — names, birthdays, relationships, anniversaries that matter",
            "Health information they have shared (with privacy and discretion)",
            "Career history and current role",
            "Hobbies, interests, what they look forward to",
            "Past financial mistakes or wounds they have referenced",
            "Stated values and what money is for them",
            "Specific anxieties — running out, leaving enough for kids, getting taxed",
            "Their preferred communication style and cadence",
            "Things they have told you about other professionals — CPA, attorney, doctor, contractor"
          ]},
          {"type": "callout", "kind": "do", "content": "Use the CRM's calendar features to remind yourself about meaningful dates — the client's late spouse's anniversary, the date a child was born, when the parent passed. A short message on the right date is one of the most meaningful things you can send."},
          {"type": "subheading", "content": "Adapting the relationship as the client ages"},
          {"type": "paragraph", "content": "A client in their 30s and the same client in their 70s may want very different things from the relationship. The younger version wanted to know they were on track. The older version may want reassurance, simplicity, and the sense that someone is looking out for them. Read the change. Slow your communication style. Use more visual aids, larger type, simpler documents. Consider whether adult children should be in some meetings (with consent). Watch for capacity decline — gently, over years — and plan ahead for what the relationship looks like if the client cannot make their own decisions."},
          {"type": "subheading", "content": "Handling counselor turnover"},
          {"type": "paragraph", "content": "Sometimes the advisor changes — an apprentice gets promoted, a counselor retires, a firm reorganizes. The transition is risky to the client relationship. Best practices: introduce the new counselor in person before the transition, have several joint meetings during the handoff, share notes openly with the client about what is in the CRM (transparency builds trust), and let the client know that the firm's commitment to them does not depend on a single individual. Done well, transitions strengthen the institutional relationship. Done badly, they end the relationship."},
          {"type": "subheading", "content": "Year-over-year continuity rituals"},
          {"type": "list", "items": [
            "Annual review at the same approximate time each year — predictability is a feature",
            "Year-end planning letter or email in early November with personalized recommendations",
            "Brief mid-year check-in call — 'just confirming everything is going as expected'",
            "Holiday acknowledgment in December — handwritten when possible",
            "Recognition of anniversaries the client values — never sales-y, always personal"
          ]},
          {"type": "subheading", "content": "Closing the OJL-A band"},
          {"type": "paragraph", "content": "You have now worked through the full client-facing band of competencies: discovery, goal-setting, document collection, financial statements, behavioral coaching, risk profiling, plan presentation, implementation, and ongoing reviews. Together these nine modules describe the practice of a counselor — the work that produces a real planning relationship rather than a sequence of transactions. The next band shifts to operations and investment work. But this band is where the relationship lives. Master it and the rest serves the relationship rather than substituting for it."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: OJL-B opens with Portfolio Construction — translating risk profile and plan into the actual portfolio."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The most appropriate review cadence for a 68-year-old recently-retired client in the first five years of retirement is:", "options": ["Annual review", "Semi-annual reviews to dial in the withdrawal strategy as it meets reality", "Monthly reviews", "Quarterly reviews only if performance is poor"], "correct": 1, "explanation": "Early retirement is a transition stage. Withdrawal strategies often need adjustment as theory meets practice. Semi-annual cadence allows responsive tuning."},
        {"id": "q2", "prompt": "When opening an annual review meeting, the most effective first move is to:", "options": ["Pull up the performance report and start with returns", "Walk through the action items from last year", "Open on a personal note — 'how was your year overall?' — to surface what has changed in their life", "Discuss markets and current events"], "correct": 2, "explanation": "Leading personally surfaces life changes that should shape the rest of the meeting. Performance data discussed without context of life events is less useful and can be misleading."},
        {"id": "q3", "prompt": "A non-spouse inherited retirement account under the SECURE Act (for most beneficiaries) generally must be distributed:", "options": ["Within one year", "Over the beneficiary's life expectancy", "Within ten years", "By the end of the calendar year of the death"], "correct": 2, "explanation": "The SECURE Act generally requires non-spouse inherited retirement accounts to be fully distributed within 10 years (with limited exceptions for certain eligible designated beneficiaries)."},
        {"id": "q4", "prompt": "A QDRO is used to:", "options": ["Designate retirement plan beneficiaries", "Divide an ERISA-qualified retirement plan in divorce", "Authorize a Roth conversion", "Transfer accounts between custodians"], "correct": 1, "explanation": "A Qualified Domestic Relations Order is the legal instrument that divides ERISA-qualified retirement plans pursuant to divorce."},
        {"id": "q5", "prompt": "When a client tells you casually at the end of a meeting that their father has moved in with them, the right response is to:", "options": ["Note it for the next annual review", "Pause, acknowledge it, and ask one open question to understand what is changing", "Move on, since the meeting was about something else", "Send a follow-up email asking them to schedule a separate meeting"], "correct": 1, "explanation": "Life events surface in casual mentions. Do not let them slip past. Acknowledge, ask, and schedule a dedicated conversation if warranted."},
        {"id": "q6", "prompt": "Beneficiary designations on retirement accounts and life insurance following a divorce:", "options": ["Are automatically updated by the divorce decree", "Survive divorce in most cases unless actively updated — treat as urgent", "Are voided by the divorce", "Become the responsibility of the attorney"], "correct": 1, "explanation": "Without active update, ex-spouse beneficiary designations often remain in effect. People die between decree and update. This is urgent."},
        {"id": "q7", "prompt": "The most appropriate response to a client who wants to dramatically change the plan in reaction to a normal market drawdown is to:", "options": ["Make the change immediately to honor client wishes", "Refuse to discuss the topic", "Push back gently — suggest holding the discussion for the next scheduled review with a calmer head", "Increase the equity allocation"], "correct": 2, "explanation": "Reactive plan changes during drawdowns are usually destructive. Delay the decision to a calmer moment without dismissing the client's concern."},
        {"id": "q8", "prompt": "A surviving spouse inheriting an IRA can usually:", "options": ["Only take a lump-sum distribution", "Roll the IRA into their own IRA, treating it as their own going forward (typically preferred)", "Must distribute within 10 years", "Must wait one year before doing anything"], "correct": 1, "explanation": "A surviving spouse has the unique option to roll an inherited IRA into their own, which restarts the rules under their own age and circumstances. Usually the preferred treatment."},
        {"id": "q9", "prompt": "When a client dies, the first 30 days should generally:", "options": ["Be used to liquidate the portfolio for tax purposes", "Not push for decisions unless legally required (RMDs in year of death, certain elections); focus on stabilizing and gathering information", "Be used to update all beneficiary designations on the surviving spouse's accounts", "Be skipped entirely until the executor is appointed"], "correct": 1, "explanation": "Grief impairs decision-making. Defer non-urgent decisions. Operational and information-gathering work happens early; consequential decisions wait."},
        {"id": "q10", "prompt": "The CRM in a long-term advisor-client relationship is best understood as:", "options": ["A compliance requirement", "The relationship's institutional memory — the place where details that may matter ten years later live", "A marketing tool", "Optional"], "correct": 1, "explanation": "Across 20-year relationships and hundreds of other clients, human memory cannot reliably retain the details that build trust. The CRM is the memory. Treat it accordingly."},
        {"id": "q11", "prompt": "A counselor who is being transitioned off a client relationship to another counselor at the firm should:", "options": ["Stop communicating with the client immediately", "Introduce the new counselor in person before the transition, have several joint meetings during the handoff, share notes openly", "Refer the client to a competing firm", "Wait for the client to ask about the change"], "correct": 1, "explanation": "Transitions are risky to retention. In-person introductions, joint meetings, and transparency about institutional knowledge protect the relationship and often strengthen it."},
        {"id": "q12", "prompt": "Devon receiving an unsolicited offer to acquire his business at a $4.2M after-tax price is best handled by:", "options": ["Discussing in the next quarterly check-in", "Scheduling a dedicated 90-minute meeting that week, engaging a transaction-experienced CPA and business attorney, and outlining multi-year wealth planning", "Recommending Devon accept the offer immediately", "Waiting until the next annual review"], "correct": 1, "explanation": "Major life events warrant prompt, structured response. Speed and the right professionals on the team early are how these situations get handled well."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 18;
