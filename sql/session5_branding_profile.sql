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
create policy "site_config_select_authenticated"
  on public.site_config for select
  to authenticated
  using (true);

-- Only admins and approvers can update
create policy "site_config_update_admin"
  on public.site_config for update
  to authenticated
  using   (get_my_role() in ('admin', 'approver'))
  with check (get_my_role() in ('admin', 'approver'));

-- Only admins and approvers can upsert (needed for upsert() calls)
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
