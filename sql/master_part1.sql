-- ================================================================
-- GIC LMS — MASTER SETUP PART 1
-- Run parts in order: 1 → 2 → 3 → 4 → 5
-- ================================================================


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
