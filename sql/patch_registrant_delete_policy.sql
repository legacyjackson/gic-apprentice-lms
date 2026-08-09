-- ============================================================================
-- patch_registrant_delete_policy.sql
-- Run once in the Supabase SQL Editor after session9_registrant_pipeline.sql.
-- Adds the missing DELETE policy on registrants — session9 only granted
-- select/update to admin/approver, so deleting an application was silently
-- denied by RLS with no policy at all.
-- ============================================================================

drop policy if exists "registrants_admin_delete" on public.registrants;
create policy "registrants_admin_delete"
  on public.registrants for delete
  using (public.get_my_role() in ('admin', 'approver'));
