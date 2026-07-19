-- ============================================================
-- PATCH: Add norma@globalinvestmentcompanies.com as admin
--
-- Fixes "Database error creating new user" that occurred when adding
-- norma@globalinvestmentcompanies.com via Auth > Users in the Supabase
-- dashboard. Root cause: public.profiles.email is UNIQUE NOT NULL, and
-- an orphaned profiles row (no matching auth.users row) for that email
-- was tripping the constraint inside the handle_new_user() trigger,
-- rolling back the whole auth.users insert.
--
-- Idempotent — safe to run more than once.
-- ============================================================

-- 1. Remove any orphaned profiles row blocking the unique(email) constraint
DELETE FROM public.profiles
WHERE email ILIKE 'norma@globalinvestmentcompanies.com'
  AND id NOT IN (SELECT id FROM auth.users);

-- 2. Update the signup trigger: add norma@ as auto-admin (alongside
--    julius@/ricky@), make it upsert-safe on conflict.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, full_name)
  VALUES (
    NEW.id,
    NEW.email,
    CASE lower(NEW.email)
      WHEN 'cathy@globalinvestmentcompanies.com'  THEN 'approver'::public.user_role
      WHEN 'julius@globalinvestmentcompanies.com' THEN 'admin'::public.user_role
      WHEN 'ricky@globalinvestmentcompanies.com'  THEN 'admin'::public.user_role
      WHEN 'norma@globalinvestmentcompanies.com'  THEN 'admin'::public.user_role
      ELSE 'apprentice'::public.user_role
    END,
    COALESCE(
      NEW.raw_user_meta_data ->> 'full_name',
      NEW.raw_user_meta_data ->> 'name',
      split_part(NEW.email, '@', 1)
    )
  )
  ON CONFLICT (id) DO UPDATE SET
    role  = EXCLUDED.role,
    email = EXCLUDED.email;
  RETURN NEW;
END;
$$;

-- 3. Safety net if norma already partially exists in profiles
UPDATE public.profiles
SET role = 'admin'
WHERE email ILIKE 'norma@globalinvestmentcompanies.com';
