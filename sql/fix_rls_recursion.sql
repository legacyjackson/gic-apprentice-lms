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
