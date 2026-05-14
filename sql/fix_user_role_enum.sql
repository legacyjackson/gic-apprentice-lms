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
