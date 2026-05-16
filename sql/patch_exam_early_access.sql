-- ============================================================
-- patch_exam_early_access.sql
-- Adds exam_early_access column to profiles so admins/mentors
-- can grant apprentices the ability to take the final exam
-- before completing all modules.
-- Run once in Supabase SQL Editor.
-- ============================================================

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS exam_early_access boolean NOT NULL DEFAULT false;

-- Optional: grant access to a specific user by email
-- UPDATE public.profiles SET exam_early_access = true WHERE email = 'apprentice@example.com';
