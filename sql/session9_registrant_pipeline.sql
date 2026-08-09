-- ============================================================================
-- GIC APPRENTICE LMS — SESSION 9 SCHEMA MIGRATION
-- Registrant application pipeline: public application form -> admin review ->
-- sponsor + seats + mentor assignment -> approve/close -> self-serve activation.
-- Also adds analytics instrumentation (login events, last active, lesson time).
--
-- Run this AFTER session1_base_schema.sql, session2_setup.sql, and
-- patch_new_features.sql (needs profiles, employer_sponsors,
-- sponsorship_tokens, lesson_reads).
-- Safe to re-run; uses `if not exists` / `add column if not exists` /
-- `create or replace` throughout.
-- ============================================================================

-- ============================================================================
-- 1. REGISTRANTS — canonical record of a public application
-- ============================================================================
create table if not exists public.registrants (
  id                    uuid primary key default gen_random_uuid(),

  -- Identity / status
  status                text not null default 'submitted'
                          check (status in ('submitted', 'approved', 'closed')),
  closed_reason         text,
  reviewed_by           uuid references public.profiles(id) on delete set null,
  reviewed_at           timestamptz,
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),

  -- Personal
  full_name             text not null,
  dob                   date,
  address               text,
  city                  text,
  state                 text,
  zip                   text,
  county                text,
  phone                 text,
  email                 text not null,
  emergency_contact_name  text,
  emergency_contact_phone text,

  -- Eligibility
  age_16_plus           boolean,
  work_eligible_us      boolean,
  can_attend_training   boolean,
  reliable_transportation boolean,
  willing_ojt           boolean,

  -- Education
  education_level       text,
  school_name           text,
  graduation_year        text,
  education_other        text,

  -- Wealth planning experience
  experience_years      integer,
  experience_explain     text,
  experience_level      text, -- none | beginner | intermediate | advanced
  exp_budgeting          text,
  exp_credit             text,
  exp_debt                text,
  exp_banking             text,
  exp_customer_service    text,

  -- Employment history
  current_employer       text,
  current_position       text,
  current_employment_dates text,
  previous_employer      text,
  previous_position      text,
  previous_employment_dates text,

  -- Career goals
  goal_why               text,
  goal_skills             text,
  goal_longterm           text,

  -- Skills self-rating questionnaire (1-5 each)
  skills                 jsonb not null default '{}'::jsonb,

  -- Client interaction
  helped_financial_decisions boolean,
  helped_financial_decisions_explain text,
  comfortable_diverse_communities boolean,
  comfortable_sensitive_topics boolean,

  -- Training history
  workshops_completed    text,

  -- Eligibility documents checklist (self-attestation only — no numbers/uploads)
  eligibility_docs        jsonb not null default '{}'::jsonb,

  -- Supportive services needs
  support_childcare        boolean,
  support_transportation   boolean,
  support_tutoring         boolean,
  support_mental_health    boolean,
  support_tech_access      boolean,
  support_other            text,

  -- Commitment agreement
  agreed_to_commitment     boolean not null default false,
  signature_name           text,
  signed_at                timestamptz,

  -- DOL demographics (optional; SSN intentionally excluded)
  sex                     text,
  ethnicity               text,
  race                    text[] not null default array[]::text[],
  disability              text,
  veteran_status          text,
  education_level_dol     text,
  employment_status       text,
  pre_apprenticeship_program boolean,

  -- Admin assignment
  sponsor_id              uuid references public.employer_sponsors(id) on delete set null,
  sponsor_token_id        uuid,
  mentor_id               uuid references public.profiles(id) on delete set null,
  activated_profile_id    uuid references public.profiles(id) on delete set null
);

create index if not exists idx_registrants_status on public.registrants(status);
create index if not exists idx_registrants_email on public.registrants(email);
create index if not exists idx_registrants_sponsor on public.registrants(sponsor_id);
create index if not exists idx_registrants_activated_profile on public.registrants(activated_profile_id);

drop trigger if exists tr_registrants_updated_at on public.registrants;
create trigger tr_registrants_updated_at
  before update on public.registrants
  for each row execute function public.tg_set_updated_at();

-- Lock down fields an anonymous applicant must never be able to set directly,
-- regardless of what the insert payload contains.
create or replace function public.registrants_lock_admin_fields()
returns trigger
language plpgsql
as $$
begin
  new.status               := 'submitted';
  new.closed_reason         := null;
  new.reviewed_by           := null;
  new.reviewed_at           := null;
  new.sponsor_id            := null;
  new.sponsor_token_id      := null;
  new.mentor_id             := null;
  new.activated_profile_id  := null;
  return new;
end;
$$;

drop trigger if exists tr_registrants_lock_admin_fields on public.registrants;
create trigger tr_registrants_lock_admin_fields
  before insert on public.registrants
  for each row execute function public.registrants_lock_admin_fields();

alter table public.registrants enable row level security;

drop policy if exists "registrants_public_insert" on public.registrants;
create policy "registrants_public_insert"
  on public.registrants for insert
  to anon, authenticated
  with check (true);

drop policy if exists "registrants_admin_select" on public.registrants;
create policy "registrants_admin_select"
  on public.registrants for select
  using (public.get_my_role() in ('admin', 'approver'));

drop policy if exists "registrants_admin_update" on public.registrants;
create policy "registrants_admin_update"
  on public.registrants for update
  using (public.get_my_role() in ('admin', 'approver'));

-- ============================================================================
-- 2. EMPLOYER SPONSORS — seat cap
-- ============================================================================
alter table public.employer_sponsors
  add column if not exists seats_total integer; -- null = unlimited

-- ============================================================================
-- 3. SPONSORSHIP TOKENS — carry registrant + mentor through to activation
-- ============================================================================
alter table public.sponsorship_tokens
  add column if not exists registrant_id uuid references public.registrants(id) on delete set null;
alter table public.sponsorship_tokens
  add column if not exists mentor_id uuid references public.profiles(id) on delete set null;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'registrants_sponsor_token_id_fkey'
  ) then
    alter table public.registrants
      add constraint registrants_sponsor_token_id_fkey
      foreign key (sponsor_token_id) references public.sponsorship_tokens(id) on delete set null;
  end if;
end$$;

-- ============================================================================
-- 4. PROFILES — last active timestamp
-- ============================================================================
alter table public.profiles
  add column if not exists last_active_at timestamptz;

-- ============================================================================
-- 5. LESSON_READS — time-on-lesson accumulator
-- ============================================================================
alter table public.lesson_reads
  add column if not exists seconds_spent integer not null default 0;
alter table public.lesson_reads
  add column if not exists last_read_at timestamptz not null default now();

-- ============================================================================
-- 6. LOGIN_EVENTS — login count / recency
-- ============================================================================
create table if not exists public.login_events (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  logged_in_at  timestamptz not null default now()
);

create index if not exists idx_login_events_user on public.login_events(user_id);

alter table public.login_events enable row level security;

drop policy if exists "login_events_self_insert" on public.login_events;
create policy "login_events_self_insert"
  on public.login_events for insert
  with check (user_id = auth.uid());

drop policy if exists "login_events_admin_select" on public.login_events;
create policy "login_events_admin_select"
  on public.login_events for select
  using (public.get_my_role() in ('admin', 'approver', 'mentor'));

-- ============================================================================
-- 7. RPC: redeem_sponsorship_token — now returns sponsor/mentor/registrant
-- ============================================================================
drop function if exists public.redeem_sponsorship_token(text);

create or replace function public.redeem_sponsorship_token(p_token text)
returns table(
  sponsor_id    uuid,
  mentor_id     uuid,
  registrant_id uuid
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_row public.sponsorship_tokens%rowtype;
  v_mentor_id uuid;
begin
  select * into v_row
    from public.sponsorship_tokens
   where token = upper(trim(p_token));

  if not found                                       then return; end if;
  if v_row.expires_at is not null
     and v_row.expires_at < now()                    then return; end if;
  if v_row.uses >= v_row.max_uses                    then return; end if;

  update public.sponsorship_tokens
     set uses = uses + 1
   where id = v_row.id;

  -- Prefer the registrant's current mentor assignment (may have been changed
  -- after the code was generated) over whatever was on the token at issue time.
  v_mentor_id := v_row.mentor_id;
  if v_row.registrant_id is not null then
    select r.mentor_id into v_mentor_id from public.registrants r where r.id = v_row.registrant_id;
  end if;

  return query select v_row.employer_sponsor_id, v_mentor_id, v_row.registrant_id;
end;
$$;

revoke all on function public.redeem_sponsorship_token(text) from public, anon, authenticated;

-- ============================================================================
-- 8. RPC: increment_lesson_time — atomic time-on-lesson accumulator
-- ============================================================================
create or replace function public.increment_lesson_time(p_module_id uuid, p_lesson_index int, p_seconds int)
returns void
language plpgsql
security invoker
set search_path = public
as $$
begin
  if p_seconds is null or p_seconds <= 0 then return; end if;

  insert into public.lesson_reads (user_id, module_id, lesson_index, seconds_spent, last_read_at)
  values (auth.uid(), p_module_id, p_lesson_index, p_seconds, now())
  on conflict (user_id, module_id, lesson_index)
  do update set seconds_spent = public.lesson_reads.seconds_spent + excluded.seconds_spent,
                last_read_at  = now();
end;
$$;

grant execute on function public.increment_lesson_time(uuid, int, int) to authenticated;

-- ============================================================================
-- Verification — run manually after
-- ============================================================================
-- select count(*) from public.registrants;
-- select column_name from information_schema.columns where table_name = 'employer_sponsors' and column_name = 'seats_total';
-- select column_name from information_schema.columns where table_name = 'sponsorship_tokens' and column_name in ('registrant_id','mentor_id');
