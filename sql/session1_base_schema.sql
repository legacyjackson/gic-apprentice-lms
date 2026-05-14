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
