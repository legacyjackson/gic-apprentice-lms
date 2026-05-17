-- ============================================================
-- patch_new_features.sql
-- Run once in Supabase SQL Editor after patch_exam_early_access.sql
-- ============================================================

-- 1. Lesson read tracking (auto-marked when lesson is opened)
CREATE TABLE IF NOT EXISTS public.lesson_reads (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_id      uuid NOT NULL REFERENCES public.modules(id) ON DELETE CASCADE,
  lesson_index   integer NOT NULL,
  first_read_at  timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, module_id, lesson_index)
);
ALTER TABLE public.lesson_reads ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "lesson_reads_own"  ON public.lesson_reads;
DROP POLICY IF EXISTS "lesson_reads_admin" ON public.lesson_reads;
CREATE POLICY "lesson_reads_own"   ON public.lesson_reads FOR ALL USING (user_id = auth.uid());
CREATE POLICY "lesson_reads_admin" ON public.lesson_reads FOR SELECT USING (get_my_role() IN ('admin','approver','mentor'));

-- 2. Study notes (one row per user × module × lesson)
CREATE TABLE IF NOT EXISTS public.lesson_notes (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_id     uuid NOT NULL REFERENCES public.modules(id) ON DELETE CASCADE,
  lesson_index  integer NOT NULL,
  note_text     text NOT NULL DEFAULT '',
  updated_at    timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, module_id, lesson_index)
);
ALTER TABLE public.lesson_notes ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "lesson_notes_own" ON public.lesson_notes;
CREATE POLICY "lesson_notes_own" ON public.lesson_notes FOR ALL USING (user_id = auth.uid());

-- 3. Prerequisite waiver requests (jump-ahead approvals)
CREATE TABLE IF NOT EXISTS public.prerequisite_waivers (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  apprentice_id  uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_id      uuid NOT NULL REFERENCES public.modules(id) ON DELETE CASCADE,
  reason         text,
  status         text NOT NULL DEFAULT 'pending', -- pending | approved | denied
  reviewed_by    uuid REFERENCES auth.users(id),
  reviewer_note  text,
  reviewed_at    timestamptz,
  created_at     timestamptz NOT NULL DEFAULT now(),
  UNIQUE (apprentice_id, module_id)
);
ALTER TABLE public.prerequisite_waivers ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "waivers_own"   ON public.prerequisite_waivers;
DROP POLICY IF EXISTS "waivers_staff" ON public.prerequisite_waivers;
CREATE POLICY "waivers_own"   ON public.prerequisite_waivers FOR ALL  USING (apprentice_id = auth.uid());
CREATE POLICY "waivers_staff" ON public.prerequisite_waivers FOR ALL  USING (get_my_role() IN ('admin','approver','mentor'));
