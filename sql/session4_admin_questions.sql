-- ============================================================
-- SESSION 4: Admin users, questions table, question_answers,
--            Module 1 metadata update
-- ============================================================

-- ============================================================
-- 1. Update handle_new_user trigger to make ricky@ an admin
-- ============================================================
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
    CASE
      WHEN NEW.email ILIKE 'ricky@%'  THEN 'admin'
      WHEN NEW.email ILIKE 'julius@%' THEN 'admin'
      WHEN NEW.email ILIKE 'cathy@%'  THEN 'approver'
      ELSE 'apprentice'
    END
  )
  ON CONFLICT (id) DO UPDATE SET
    email     = EXCLUDED.email,
    full_name = COALESCE(EXCLUDED.full_name, profiles.full_name),
    role      = EXCLUDED.role;
  RETURN NEW;
END;
$$;

-- ============================================================
-- 2. Upsert ricky's profile as admin if they already exist
-- ============================================================
UPDATE public.profiles
SET role = 'admin'
WHERE email ILIKE 'ricky@%';

-- If ricky exists in auth.users but not profiles, insert them.
-- (Safe to run multiple times — ON CONFLICT handles it.)
INSERT INTO public.profiles (id, email, full_name, role)
SELECT
  au.id,
  au.email,
  COALESCE(au.raw_user_meta_data->>'full_name', split_part(au.email, '@', 1)),
  'admin'
FROM auth.users au
WHERE au.email ILIKE 'ricky@%'
ON CONFLICT (id) DO UPDATE SET role = 'admin';

-- ============================================================
-- 3. Update julius@ profile to admin (not just trusting trigger)
-- ============================================================
UPDATE public.profiles
SET role = 'admin'
WHERE email ILIKE 'julius@%';

INSERT INTO public.profiles (id, email, full_name, role)
SELECT
  au.id,
  au.email,
  COALESCE(au.raw_user_meta_data->>'full_name', split_part(au.email, '@', 1)),
  'admin'
FROM auth.users au
WHERE au.email ILIKE 'julius@%'
ON CONFLICT (id) DO UPDATE SET role = 'admin';

-- ============================================================
-- 4. Create questions table
-- ============================================================
CREATE TABLE IF NOT EXISTS public.questions (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  asker_id       UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_number  INT,
  lesson_index   INT,
  lesson_title   TEXT,
  question_text  TEXT NOT NULL,
  status         TEXT NOT NULL DEFAULT 'open'
                   CHECK (status IN ('open', 'resolved')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS questions_updated_at ON public.questions;
CREATE TRIGGER questions_updated_at
  BEFORE UPDATE ON public.questions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ============================================================
-- 5. Create question_answers table
-- ============================================================
CREATE TABLE IF NOT EXISTS public.question_answers (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id    UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  responder_id   UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  responder_name TEXT,
  answer_text    TEXT NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ============================================================
-- 6. RLS policies for questions and question_answers
-- ============================================================

ALTER TABLE public.questions        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_answers ENABLE ROW LEVEL SECURITY;

-- ---- questions policies ----

-- Apprentices can insert their own questions
DROP POLICY IF EXISTS "questions_insert_own" ON public.questions;
CREATE POLICY "questions_insert_own" ON public.questions
  FOR INSERT TO authenticated
  WITH CHECK (asker_id = auth.uid());

-- Apprentices can read their own questions
DROP POLICY IF EXISTS "questions_select_own" ON public.questions;
CREATE POLICY "questions_select_own" ON public.questions
  FOR SELECT TO authenticated
  USING (
    asker_id = auth.uid()
    OR get_my_role() IN ('mentor', 'admin', 'approver')
  );

-- Apprentices can update their own open questions; mentors/admins can update status
DROP POLICY IF EXISTS "questions_update_own" ON public.questions;
CREATE POLICY "questions_update_own" ON public.questions
  FOR UPDATE TO authenticated
  USING (
    asker_id = auth.uid()
    OR get_my_role() IN ('mentor', 'admin', 'approver')
  );

-- ---- question_answers policies ----

-- Mentors, admins, and approvers can insert answers
DROP POLICY IF EXISTS "question_answers_insert_mentor" ON public.question_answers;
CREATE POLICY "question_answers_insert_mentor" ON public.question_answers
  FOR INSERT TO authenticated
  WITH CHECK (
    get_my_role() IN ('mentor', 'admin', 'approver')
  );

-- Anyone can read answers to their own questions; mentors/admins can read all
DROP POLICY IF EXISTS "question_answers_select" ON public.question_answers;
CREATE POLICY "question_answers_select" ON public.question_answers
  FOR SELECT TO authenticated
  USING (
    get_my_role() IN ('mentor', 'admin', 'approver')
    OR EXISTS (
      SELECT 1 FROM public.questions q
      WHERE q.id = question_answers.question_id
        AND q.asker_id = auth.uid()
    )
  );

-- ============================================================
-- 7. Update Module 1: short_description and learning_objectives
-- ============================================================
UPDATE public.modules
SET
  short_description = 'Financial literacy is the foundation of everything we do as Wealth Solutions Counselors. This module builds your fluency with the core vocabulary, frameworks, and ratios that every advisor uses to understand a client''s full financial picture and guide them toward sustainable wealth.',
  learning_objectives = ARRAY[
    'Distinguish between gross income and net income, and explain how each affects take-home pay, budgeting decisions, and long-term wealth accumulation.',
    'Categorize personal expenses as fixed, variable, or periodic, and construct a complete monthly budget that accounts for all three expense types.',
    'Define assets, liabilities, and net worth, and calculate a client''s net worth from a simplified balance sheet.',
    'Explain equity and liquidity as financial concepts, and identify why liquidity matters in emergency planning and short-term cash flow management.',
    'Calculate the debt-to-income (DTI) ratio and interpret what different DTI levels signal about a client''s financial health and borrowing capacity.',
    'Perform a basic cash flow analysis — mapping income sources against all expense categories — to identify surplus, deficit, and opportunities for wealth-building.',
    'Describe the core principles of wealth-building (spending less than you earn, reducing liabilities, growing assets) and connect each principle to the budgeting and planning frameworks covered in this module.'
  ],
  updated_at = now()
WHERE module_number = 1;
