-- ============================================================================
-- SESSION 6: Insert two new competency modules
--
-- 1. Insurance Planning  → inserted between original 18 and 19  (becomes 19)
-- 2. AI for Reporting, Automation, and Client Relationships
--                        → inserted between original 28 and 29  (becomes 30
--                          after the Insurance Planning shift)
--
-- Uses a +1000 offset strategy to avoid UNIQUE constraint conflicts during
-- the renumber. Safe to run once on a live database.
-- ============================================================================

-- ── STEP 1: Shift original modules 19–30 → 20–31  (make room for Insurance) ──

-- Move up by +1000 to clear the constraint, then settle at +1
UPDATE public.modules SET module_number = module_number + 1000 WHERE module_number >= 19;
UPDATE public.modules SET module_number = module_number - 999  WHERE module_number >= 1019;

-- Insert Insurance Planning as module 19
INSERT INTO public.modules (module_number, title, short_description, learning_objectives, content, is_published)
VALUES (
  19,
  'Insurance Planning',
  'Build a complete safety net for your clients. This module covers the major insurance types every financial counselor must understand — from life and disability to property and liability — so you can identify gaps, explain options, and protect everything your clients are working to build.',
  ARRAY[
    'Explain how insurance fits into a comprehensive financial plan as a risk-management tool',
    'Identify and distinguish the major personal insurance categories: life, health, disability, property/casualty, and liability',
    'Calculate a client''s life insurance need using the income-replacement and DIME methods',
    'Compare term and permanent life insurance structures and explain when each is appropriate',
    'Describe how disability insurance protects earned income, including key policy provisions such as elimination period, benefit period, and own-occupation definitions',
    'Conduct a basic insurance needs analysis to identify coverage gaps in a client''s current plan',
    'Explain how annuities function as insurance products and their role in retirement income planning'
  ],
  '{"lessons":[]}'::jsonb,
  true
);

-- ── STEP 2: Shift original 29–31 (now 30–32 after step 1) → 31–33
--           to make room for the AI module at position 30 ──

-- After step 1: original 28 → 29, original 29 → 30, original 30 → 31
-- We want AI at slot 30, so shift everything >= 30 up by 1
UPDATE public.modules SET module_number = module_number + 1000 WHERE module_number >= 30;
UPDATE public.modules SET module_number = module_number - 999  WHERE module_number >= 1030;

-- Insert AI module as module 30
INSERT INTO public.modules (module_number, title, short_description, learning_objectives, content, is_published)
VALUES (
  30,
  'AI for Reporting, Automation, and Client Relationships',
  'AI is reshaping how financial advisors work. This module prepares Wealth Solutions Counselors to use AI tools for client reporting, workflow automation, and relationship management — while understanding the ethical guardrails and accuracy standards every practitioner must maintain before sharing AI-generated content with clients.',
  ARRAY[
    'Explain how AI tools are currently being used in financial planning, reporting, and client communication',
    'Use an AI assistant to draft client reports, meeting summaries, and financial education content',
    'Identify the limitations and ethical considerations when using AI tools with client data',
    'Demonstrate a repeatable workflow for using AI to automate routine administrative tasks',
    'Apply AI tools to improve client relationship management, follow-up cadence, and personalized outreach',
    'Evaluate AI-generated financial content for accuracy and compliance before sharing with clients',
    'Describe emerging AI applications in portfolio analysis, compliance monitoring, and client onboarding'
  ],
  '{"lessons":[]}'::jsonb,
  true
);

-- ── VERIFICATION ──
-- Run these to confirm the final module order:
-- SELECT module_number, title FROM public.modules ORDER BY module_number;
-- Expected: 32 total modules, with 19 = Insurance Planning, 30 = AI module

-- ============================================================================
-- DONE. The two new modules appear in the LMS as empty drafts.
-- Use the Admin → Module Editor to add lesson content.
-- ============================================================================
