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
