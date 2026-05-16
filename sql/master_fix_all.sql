-- ============================================================================
-- GIC APPRENTICE LMS — MASTER FIX: All module titles + all lesson content
-- Run this single file to align everything to the GIC Work Process list.
--
-- Order:
--   1. session8 — sets correct GIC titles, IDs, hours, objectives for all 32 modules
--   2. gic_content 01-08  — sets GIC-aligned lessons for modules 1-8
--   3. gic_content 09-16  — sets GIC-aligned lessons for modules 9-16
--   4. gic_content 17-24  — sets GIC-aligned lessons for modules 17-24 (skips 19)
--   5. gic_content 25-32  — sets GIC-aligned lessons for modules 25-32 (skips 30)
--   6. final_exam         — replaces exam with 30 GIC-competency questions
--
-- Insurance Planning (module 19) and AI (module 30) keep their existing content.
-- ============================================================================

-- ── PART 1: Titles, IDs, hours, descriptions, objectives (session8) ──
-- ============================================================================
-- SESSION 8: Realign all module titles, competency IDs, hours, descriptions
-- and learning objectives to match the official GIC Work Process list.
--
-- Module mapping:
--   Modules  1-18 → GIC Work Process #1-18  (direct match)
--   Module   19   → Insurance Planning       (supplemental)
--   Modules 20-29 → GIC Work Process #19-28 (shifted +1 by Insurance)
--   Module   30   → AI for Reporting         (supplemental)
--   Modules 31-32 → GIC Work Process #29-30 (shifted +2 by both)
--
-- Run in Supabase SQL Editor. Safe to re-run.
-- ============================================================================

-- ── 1: Client Intake & Discovery Interviews ──────────────────────────────
UPDATE public.modules SET
  title               = 'Client Intake & Discovery Interviews',
  competency_id       = 'GIC-01',
  ri_hours            = 0,
  ojl_hours           = 80,
  short_description   = 'Master the first and most critical step in the advisory relationship. You will learn to conduct structured discovery interviews that surface a client''s full financial picture, goals, fears, and values — so every recommendation that follows is built on a solid, accurate foundation.',
  learning_objectives = ARRAY[
    'Conduct a structured discovery interview that builds trust and surfaces complete financial information.',
    'Distinguish between quantitative discovery (numbers) and qualitative discovery (goals, values, and motivations).',
    'Use open-ended questions to guide clients through their full financial picture without making them feel interrogated.',
    'Recognize family dynamics, money scripts, and emotional history that shape financial behavior.',
    'Document a discovery interview in a format that allows any team member to pick up the file cleanly.',
    'Identify when to defer questions or schedule follow-up sessions based on client readiness.',
    'Capture the minimum required data to initiate a financial planning engagement.'
  ]
WHERE module_number = 1;

-- ── 2: Gathering & Organizing Financial Documents ────────────────────────
UPDATE public.modules SET
  title               = 'Gathering & Organizing Financial Documents',
  competency_id       = 'GIC-02',
  ri_hours            = 0,
  ojl_hours           = 70,
  short_description   = 'Learn to systematically collect, verify, and organize every financial document a planning engagement requires. Accurate document collection is the foundation of every plan — missing or misread documents are the most common source of advice errors.',
  learning_objectives = ARRAY[
    'Identify the complete set of documents required for a financial planning engagement.',
    'Build and use a document checklist that tracks collection status for each client.',
    'Verify documents for completeness, accuracy, and currency before using them in analysis.',
    'Organize documents in a format that supports efficient retrieval and compliance review.',
    'Recognize red flags in financial documents that require further investigation.',
    'Handle sensitive financial documents in compliance with privacy and security requirements.',
    'Communicate document requests to clients clearly and professionally.'
  ]
WHERE module_number = 2;

-- ── 3: Cash Flow & Budgeting Analysis ────────────────────────────────────
UPDATE public.modules SET
  title               = 'Cash Flow & Budgeting Analysis',
  competency_id       = 'GIC-03',
  ri_hours            = 0,
  ojl_hours           = 90,
  short_description   = 'Cash flow is the engine of every financial plan. You will learn to analyze household income and expenses, identify gaps, build actionable budgets, and explain cash flow findings to clients in a way that motivates change rather than defensiveness.',
  learning_objectives = ARRAY[
    'Construct a complete household cash flow statement from client documents and interviews.',
    'Distinguish between fixed, variable, and periodic expenses and explain the planning significance of each.',
    'Calculate net cash flow and identify surplus or deficit positions.',
    'Apply budgeting frameworks (50/30/20, zero-based, envelope) to different client situations.',
    'Identify cash flow patterns that indicate financial stress or structural problems.',
    'Present cash flow findings to clients using plain language that leads to action.',
    'Use cash flow analysis as the starting point for savings, debt payoff, and investment planning.'
  ]
WHERE module_number = 3;

-- ── 4: Retirement Planning Scenario Preparation ──────────────────────────
UPDATE public.modules SET
  title               = 'Retirement Planning Scenario Preparation',
  competency_id       = 'GIC-04',
  ri_hours            = 0,
  ojl_hours           = 100,
  short_description   = 'Retirement planning is the most complex and consequential engagement most clients will have with a financial advisor. You will learn to build retirement scenarios, model income needs, analyze Social Security timing, and prepare materials that give clients a clear picture of their retirement readiness.',
  learning_objectives = ARRAY[
    'Calculate a client''s retirement income need using replacement rate and expense-based methods.',
    'Build retirement projections using basic time-value-of-money concepts.',
    'Analyze Social Security benefit options and explain optimal claiming strategies.',
    'Model the impact of savings rate changes, retirement date changes, and return assumptions.',
    'Identify retirement savings vehicles — 401(k), IRA, Roth IRA — and their planning roles.',
    'Explain sequence-of-returns risk and basic strategies to manage it.',
    'Prepare a retirement readiness summary that clients can understand and act on.'
  ]
WHERE module_number = 4;

-- ── 5: Legacy & Estate Coordination Support ──────────────────────────────
UPDATE public.modules SET
  title               = 'Legacy & Estate Coordination Support',
  competency_id       = 'GIC-05',
  ri_hours            = 0,
  ojl_hours           = 70,
  short_description   = 'Estate planning touches every client regardless of wealth level. You will learn the foundational documents, beneficiary structures, and coordination tasks that ensure a client''s legacy intentions are carried out — and when to bring in legal counsel.',
  learning_objectives = ARRAY[
    'Identify the core estate planning documents: will, trust, power of attorney, healthcare directive.',
    'Explain the difference between probate and non-probate assets and why it matters.',
    'Review beneficiary designations across all accounts and identify conflicts or gaps.',
    'Coordinate with estate planning attorneys to gather and organize required information.',
    'Explain basic trust structures — revocable living trust, irrevocable trust — in plain language.',
    'Identify when a client''s estate situation requires attorney referral.',
    'Document legacy goals and charitable intentions as part of the financial plan.'
  ]
WHERE module_number = 5;

-- ── 6: Preparing Planning Summaries & Client-Ready Materials ─────────────
UPDATE public.modules SET
  title               = 'Preparing Planning Summaries & Client-Ready Materials',
  competency_id       = 'GIC-06',
  ri_hours            = 0,
  ojl_hours           = 80,
  short_description   = 'The quality of a financial plan is judged by the quality of how it is communicated. You will learn to produce clear, professional planning summaries, recommendation letters, and client-facing materials that translate complex analysis into decisions clients can understand and act on.',
  learning_objectives = ARRAY[
    'Write a planning summary that accurately reflects the analysis and recommendations without jargon.',
    'Structure a client-facing document to lead with conclusions and support with evidence.',
    'Prepare visual aids — charts, tables, timelines — that clarify rather than complicate.',
    'Adapt written materials for different client communication styles and financial literacy levels.',
    'Review planning documents for accuracy, completeness, and compliance before delivery.',
    'Use firm templates and branding standards consistently across all client materials.',
    'Produce a complete meeting preparation package for an advisor-client review.'
  ]
WHERE module_number = 6;

-- ── 7: CRM Documentation & Data Accuracy ─────────────────────────────────
UPDATE public.modules SET
  title               = 'CRM Documentation & Data Accuracy',
  competency_id       = 'GIC-07',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'The CRM is the operational backbone of an advisory practice. You will learn to maintain client records with the accuracy and completeness that compliance requires and that colleagues need to serve clients effectively.',
  learning_objectives = ARRAY[
    'Enter, update, and verify client data in the CRM accurately and completely.',
    'Document client interactions — calls, meetings, emails — in a format that creates a reliable audit trail.',
    'Identify and resolve data integrity issues: duplicates, outdated information, missing fields.',
    'Use CRM workflows and automation to support consistent client follow-up.',
    'Understand the compliance importance of CRM documentation for regulatory review.',
    'Coordinate data entry responsibilities across advisor, associate, and operations roles.',
    'Run basic CRM reports to support client service and business management.'
  ]
WHERE module_number = 7;

-- ── 8: Observing & Supporting Client Meetings ────────────────────────────
UPDATE public.modules SET
  title               = 'Observing & Supporting Client Meetings',
  competency_id       = 'GIC-08',
  ri_hours            = 0,
  ojl_hours           = 50,
  short_description   = 'Client meetings are where the advisory relationship is built and maintained. You will develop the professional presence, preparation skills, and note-taking discipline that make you an effective meeting participant — and eventually a skilled meeting leader.',
  learning_objectives = ARRAY[
    'Prepare a pre-meeting brief that includes client history, open items, and agenda.',
    'Observe and document key discussion points, decisions, and action items during a client meeting.',
    'Demonstrate professional presence and communication in a client-facing setting.',
    'Distinguish between meetings that are routine service events and those that require special preparation.',
    'Draft a post-meeting follow-up summary that captures commitments and next steps.',
    'Recognize verbal and non-verbal cues that signal client concern, confusion, or opportunity.',
    'Manage the logistics of a client meeting: scheduling, room setup, materials, follow-up.'
  ]
WHERE module_number = 8;

-- ── 9: Client Risk Assessment & Suitability ──────────────────────────────
UPDATE public.modules SET
  title               = 'Client Risk Assessment & Suitability',
  competency_id       = 'GIC-09',
  ri_hours            = 0,
  ojl_hours           = 70,
  short_description   = 'Suitability is both a legal requirement and an ethical obligation. You will learn to assess a client''s risk capacity, risk tolerance, and investment objectives — and document your findings in a way that protects the client and stands up to compliance review.',
  learning_objectives = ARRAY[
    'Distinguish between risk capacity (financial ability to absorb loss) and risk tolerance (psychological comfort with loss).',
    'Administer and interpret a risk profiling questionnaire accurately.',
    'Reconcile mismatches between what a client says and what their financial situation can support.',
    'Document a suitability determination that meets regulatory standards.',
    'Communicate risk concepts to clients in terms they can understand and relate to.',
    'Identify changes in client circumstances that require a suitability reassessment.',
    'Apply suitability standards to investment recommendations across account types.'
  ]
WHERE module_number = 9;

-- ── 10: Asset Allocation Modeling & Updates ──────────────────────────────
UPDATE public.modules SET
  title               = 'Asset Allocation Modeling & Updates',
  competency_id       = 'GIC-10',
  ri_hours            = 0,
  ojl_hours           = 80,
  short_description   = 'Asset allocation is the single most important investment decision a client makes. You will learn to build, document, and maintain allocation models that match each client''s risk profile, time horizon, and financial goals.',
  learning_objectives = ARRAY[
    'Explain the role of asset allocation in managing portfolio risk and return.',
    'Build a basic asset allocation model using equity, fixed income, and cash categories.',
    'Apply strategic vs. tactical allocation concepts to client portfolios.',
    'Calculate portfolio drift and determine when rebalancing is required.',
    'Document an allocation recommendation with rationale tied to client objectives.',
    'Update allocation models when client circumstances or market conditions change.',
    'Explain the trade-offs between diversification and concentration in plain language.'
  ]
WHERE module_number = 10;

-- ── 11: Investment Product Comparison ────────────────────────────────────
UPDATE public.modules SET
  title               = 'Investment Product Comparison — Stocks, Bonds, ETFs & Mutual Funds',
  competency_id       = 'GIC-11',
  ri_hours            = 0,
  ojl_hours           = 90,
  short_description   = 'Every recommendation involves a product. You will develop the product knowledge to compare stocks, bonds, ETFs, and mutual funds on cost, risk, structure, and suitability — so you can support well-reasoned investment decisions and explain them clearly to clients.',
  learning_objectives = ARRAY[
    'Explain the structure, risk profile, and return characteristics of stocks, bonds, ETFs, and mutual funds.',
    'Compare investment products on expense ratios, tax efficiency, liquidity, and transparency.',
    'Read a fund prospectus, fact sheet, and performance report critically.',
    'Evaluate fund performance in context: benchmarks, peer groups, and time periods.',
    'Identify conflicts of interest in product recommendations and compensation structures.',
    'Apply basic due diligence criteria to assess whether a product fits a client''s situation.',
    'Explain investment product trade-offs to clients using plain, non-technical language.'
  ]
WHERE module_number = 11;

-- ── 12: Monitoring Market Conditions & Portfolio Performance ─────────────
UPDATE public.modules SET
  title               = 'Monitoring Market Conditions & Portfolio Performance',
  competency_id       = 'GIC-12',
  ri_hours            = 0,
  ojl_hours           = 90,
  short_description   = 'Staying current on markets is a professional obligation. You will build habits and workflows for monitoring economic conditions, market trends, and individual portfolio performance — and learn to distinguish signal from noise.',
  learning_objectives = ARRAY[
    'Identify the key economic indicators that affect investment markets and client portfolios.',
    'Monitor portfolio performance against benchmarks and client objectives.',
    'Distinguish between short-term market volatility and structural changes requiring action.',
    'Prepare a brief market update summary suitable for client communication.',
    'Use portfolio management software to review holdings, performance, and allocation.',
    'Identify positions that have drifted from target allocation or require review.',
    'Apply a systematic monitoring cadence rather than reacting to headlines.'
  ]
WHERE module_number = 12;

-- ── 13: Preparing Investment Research Summaries ───────────────────────────
UPDATE public.modules SET
  title               = 'Preparing Investment Research Summaries',
  competency_id       = 'GIC-13',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Research summaries translate complex analysis into actionable advisor briefings. You will learn to gather, evaluate, and synthesize investment research into clear, accurate summaries that support well-informed recommendations.',
  learning_objectives = ARRAY[
    'Identify credible sources of investment research and market analysis.',
    'Evaluate research quality: methodology, conflicts of interest, and recency.',
    'Synthesize information from multiple sources into a coherent summary.',
    'Write a research brief that presents findings, implications, and recommended action.',
    'Distinguish between facts, analysis, and opinion in investment research.',
    'Verify data accuracy before incorporating research into client materials.',
    'Organize research files in a format that supports efficient retrieval and review.'
  ]
WHERE module_number = 13;

-- ── 14: Compliance Support & Documentation ────────────────────────────────
UPDATE public.modules SET
  title               = 'Compliance Support & Documentation',
  competency_id       = 'GIC-14',
  ri_hours            = 0,
  ojl_hours           = 50,
  short_description   = 'Compliance is the foundation of client trust and firm integrity. You will learn the documentation standards, regulatory requirements, and internal controls that keep an advisory practice operating within the law — and understand why each requirement exists.',
  learning_objectives = ARRAY[
    'Explain the regulatory framework governing registered investment advisors: SEC, FINRA, and state rules.',
    'Apply recordkeeping requirements to client files, correspondence, and transactions.',
    'Prepare and organize documents required for compliance review and regulatory examination.',
    'Recognize activities that require supervisory approval before execution.',
    'Document client complaints, conflicts of interest, and exceptions according to firm policy.',
    'Support annual compliance reviews and audits with accurate, organized documentation.',
    'Understand the personal liability implications of compliance failures.'
  ]
WHERE module_number = 14;

-- ── 15: Portfolio Reporting & Performance Snapshots ──────────────────────
UPDATE public.modules SET
  title               = 'Portfolio Reporting & Performance Snapshots',
  competency_id       = 'GIC-15',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Portfolio reports are the primary way clients evaluate whether their advisor is delivering results. You will learn to produce accurate, clear performance reports that present results in context and support productive client conversations.',
  learning_objectives = ARRAY[
    'Generate accurate portfolio performance reports using portfolio management software.',
    'Calculate and present time-weighted and dollar-weighted returns correctly.',
    'Benchmark portfolio performance against appropriate indexes and peer groups.',
    'Present performance results in context: market environment, client objectives, time horizon.',
    'Identify and correct errors in performance reports before delivery to clients.',
    'Customize reporting formats for different client needs and communication preferences.',
    'Prepare a performance snapshot suitable for an annual review meeting.'
  ]
WHERE module_number = 15;

-- ── 16: Maintaining Chart of Accounts & Financial Records ────────────────
UPDATE public.modules SET
  title               = 'Maintaining Chart of Accounts & Financial Records',
  competency_id       = 'GIC-16',
  ri_hours            = 0,
  ojl_hours           = 80,
  short_description   = 'Financial record integrity is non-negotiable in an advisory practice. You will learn to maintain a chart of accounts, classify transactions correctly, and keep financial records in a state that supports accurate reporting and audit readiness.',
  learning_objectives = ARRAY[
    'Explain the structure and purpose of a chart of accounts in a financial advisory firm.',
    'Classify financial transactions accurately across income, expense, asset, and liability accounts.',
    'Maintain accounts receivable and payable records for advisory fee billing.',
    'Reconcile account balances against bank and custodian statements.',
    'Identify and correct posting errors before they affect financial statements.',
    'Organize financial records to support tax preparation and audit review.',
    'Apply basic internal controls to financial record maintenance.'
  ]
WHERE module_number = 16;

-- ── 17: Performance Reconciliations ──────────────────────────────────────
UPDATE public.modules SET
  title               = 'Performance Reconciliations',
  competency_id       = 'GIC-17',
  ri_hours            = 0,
  ojl_hours           = 90,
  short_description   = 'Reconciliation catches errors before they reach clients. You will develop the discipline and methodology to reconcile portfolio positions, cash balances, and performance figures against custodian records — ensuring that every number a client sees is correct.',
  learning_objectives = ARRAY[
    'Reconcile portfolio holdings and cash positions against custodian statements.',
    'Identify and investigate discrepancies between internal records and custodian data.',
    'Apply a systematic reconciliation workflow that catches errors consistently.',
    'Document reconciliation results and escalate unresolved items appropriately.',
    'Understand the timing differences that create apparent discrepancies in reconciliation.',
    'Prepare a reconciliation report that satisfies compliance and audit requirements.',
    'Use portfolio accounting software to streamline the reconciliation process.'
  ]
WHERE module_number = 17;

-- ── 18: Preparing Financial Statements ───────────────────────────────────
UPDATE public.modules SET
  title               = 'Preparing Financial Statements',
  competency_id       = 'GIC-18',
  ri_hours            = 0,
  ojl_hours           = 80,
  short_description   = 'Financial statements are the scorecard of a client''s financial life. You will learn to prepare and interpret personal financial statements — the net worth statement and the cash flow statement — as core deliverables in the financial planning process.',
  learning_objectives = ARRAY[
    'Prepare a personal net worth statement from client-provided documents.',
    'Build a comprehensive household cash flow statement showing income, expenses, and surplus/deficit.',
    'Calculate and interpret key ratios: savings rate, debt-to-income, and liquidity ratio.',
    'Identify changes in financial position over time by comparing statements year over year.',
    'Present financial statements to clients in a format they can understand and act on.',
    'Use financial statements as the starting point for goal-setting and planning conversations.',
    'Maintain financial statement accuracy through disciplined data collection and verification.'
  ]
WHERE module_number = 18;

-- ── 19: Insurance Planning (supplemental — not in GIC core 30) ───────────
UPDATE public.modules SET
  competency_id = 'GIC-SUP-1',
  ri_hours      = 16,
  ojl_hours     = 24
WHERE module_number = 19;

-- ── 20: Billing, Invoicing & Payment Tracking (GIC #19) ──────────────────
UPDATE public.modules SET
  title               = 'Billing, Invoicing & Payment Tracking',
  competency_id       = 'GIC-19',
  ri_hours            = 0,
  ojl_hours           = 70,
  short_description   = 'Revenue integrity starts with accurate billing. You will learn the invoicing, payment tracking, and fee reconciliation workflows that keep a practice financially healthy and in compliance with fee disclosure requirements.',
  learning_objectives = ARRAY[
    'Calculate advisory fees accurately using AUM-based, flat-fee, and hourly billing models.',
    'Prepare and issue client invoices in compliance with firm billing policies.',
    'Track payment status and follow up on outstanding balances professionally.',
    'Reconcile billing records against custodian fee deductions and client accounts.',
    'Maintain fee disclosure documentation required by regulatory standards.',
    'Identify and resolve billing discrepancies before they reach clients.',
    'Support quarterly billing cycles with accurate fee schedules and client tier assignments.'
  ]
WHERE module_number = 20;

-- ── 21: CRM & Financial System Data Entry (GIC #20) ──────────────────────
UPDATE public.modules SET
  title               = 'CRM & Financial System Data Entry',
  competency_id       = 'GIC-20',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Accurate data entry is the foundation of every system in an advisory practice. You will develop the speed, accuracy, and verification habits that keep CRM records, financial systems, and client data clean and reliable.',
  learning_objectives = ARRAY[
    'Enter client and account data into CRM and financial planning systems accurately.',
    'Verify data entry against source documents before saving or submitting.',
    'Update client records promptly when circumstances, contact information, or accounts change.',
    'Identify and merge duplicate records to maintain database integrity.',
    'Use system shortcuts and batch entry tools to improve data entry efficiency.',
    'Apply data security practices when handling sensitive client information.',
    'Support data quality reviews and system audits with accurate, complete records.'
  ]
WHERE module_number = 21;

-- ── 22: Audit Readiness & Documentation Standards (GIC #21) ──────────────
UPDATE public.modules SET
  title               = 'Audit Readiness & Documentation Standards',
  competency_id       = 'GIC-21',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Regulatory audits are a reality in financial services. You will learn to maintain documentation standards that make the practice audit-ready at all times — not just when an examination is scheduled.',
  learning_objectives = ARRAY[
    'Identify the documentation an SEC or state examiner expects to find in a client file.',
    'Apply consistent file organization standards across all client records.',
    'Prepare a sample client file that meets compliance review standards.',
    'Conduct a self-audit of documentation completeness across a client book.',
    'Respond to documentation requests from compliance officers and examiners professionally.',
    'Understand the retention periods for different categories of financial records.',
    'Build documentation habits that prevent compliance issues rather than react to them.'
  ]
WHERE module_number = 22;

-- ── 23: Workflow Coordination with Operations Staff (GIC #22) ────────────
UPDATE public.modules SET
  title               = 'Workflow Coordination with Operations Staff',
  competency_id       = 'GIC-22',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Advisory work gets done through teams. You will develop the communication, task management, and coordination skills that make you a reliable partner to operations staff, custodians, and service teams — ensuring that client work moves forward without delays.',
  learning_objectives = ARRAY[
    'Coordinate task handoffs between advisory, operations, and compliance teams clearly.',
    'Use project management and task tracking tools to keep work moving forward.',
    'Write clear, actionable internal communications that eliminate ambiguity.',
    'Prioritize concurrent workflows based on client deadlines and urgency.',
    'Escalate blockers to the right person without delay.',
    'Build professional relationships with operations counterparts at custodians and partner firms.',
    'Document workflow processes so that coverage during absences is seamless.'
  ]
WHERE module_number = 23;

-- ── 24: Preparing Advisory Meeting Materials (GIC #23) ───────────────────
UPDATE public.modules SET
  title               = 'Preparing Advisory Meeting Materials',
  competency_id       = 'GIC-23',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Great meetings are made before they start. You will master the preparation of agenda packets, performance reports, planning updates, and supporting materials that enable advisors to run focused, productive client meetings.',
  learning_objectives = ARRAY[
    'Assemble a complete advisory meeting packet: agenda, performance report, planning updates, and action items.',
    'Customize meeting materials for the client''s specific situation, goals, and history.',
    'Prepare a pre-meeting briefing that surfaces key topics and potential client concerns.',
    'Produce materials that are visually clean, accurate, and free of jargon.',
    'Coordinate with multiple team members to gather all required inputs before a deadline.',
    'Review meeting materials for errors and consistency before advisor review.',
    'Build and maintain a meeting preparation workflow that scales across a large client book.'
  ]
WHERE module_number = 24;

-- ── 25: Conducting Supervised Suitability Needs Analysis (GIC #24) ───────
UPDATE public.modules SET
  title               = 'Conducting Supervised Suitability Needs Analysis',
  competency_id       = 'GIC-24',
  ri_hours            = 0,
  ojl_hours           = 70,
  short_description   = 'Suitability analysis is the professional and legal standard for investment recommendations. Under supervision, you will conduct full needs analyses — gathering objectives, assessing risk, and documenting conclusions in a format that supports defensible recommendations.',
  learning_objectives = ARRAY[
    'Conduct a complete client needs analysis under advisor supervision.',
    'Apply a structured framework to gather investment objectives, time horizon, and constraints.',
    'Document the analysis in a format that satisfies suitability and best interest standards.',
    'Identify when a client''s stated preferences conflict with their financial situation.',
    'Prepare a suitability summary that an advisor can review, revise, and sign off on.',
    'Recognize personal and situational factors that affect investment suitability.',
    'Build the skills to eventually conduct needs analyses independently.'
  ]
WHERE module_number = 25;

-- ── 26: Supporting Wealth Management Planning (GIC #25) ──────────────────
UPDATE public.modules SET
  title               = 'Supporting Wealth Management Planning',
  competency_id       = 'GIC-25',
  ri_hours            = 0,
  ojl_hours           = 70,
  short_description   = 'Wealth management integrates every element of a client''s financial life into a single coherent strategy. You will learn to support comprehensive planning engagements — coordinating tax, investment, estate, and insurance considerations into unified client plans.',
  learning_objectives = ARRAY[
    'Explain how tax planning, investment management, estate planning, and insurance fit together in a comprehensive wealth management plan.',
    'Support the preparation of a comprehensive financial plan under advisor supervision.',
    'Coordinate inputs from multiple specialists — CPA, attorney, insurance advisor — into a unified plan.',
    'Identify planning opportunities and gaps across a client''s complete financial picture.',
    'Prepare planning summaries that reflect the interaction of multiple financial planning areas.',
    'Update wealth management plans when client circumstances change.',
    'Communicate the value of comprehensive planning to clients in business development contexts.'
  ]
WHERE module_number = 26;

-- ── 27: Developing Investment Product Knowledge (GIC #26) ────────────────
UPDATE public.modules SET
  title               = 'Developing Investment Product Knowledge',
  competency_id       = 'GIC-26',
  ri_hours            = 0,
  ojl_hours           = 60,
  short_description   = 'Deep product knowledge is a professional responsibility. You will build a systematic understanding of the investment products used in client portfolios — including how they work, how they are priced, and where they fit in a comprehensive investment strategy.',
  learning_objectives = ARRAY[
    'Develop working knowledge of the investment products used in the firm''s client portfolios.',
    'Explain the mechanics, costs, risks, and tax treatment of each product type clearly.',
    'Compare products across key dimensions: expense, liquidity, tax efficiency, and suitability.',
    'Stay current on product changes, new offerings, and market developments.',
    'Identify which products are appropriate for different client situations and objectives.',
    'Read product disclosure documents, prospectuses, and term sheets critically.',
    'Communicate product characteristics to clients without making a specific recommendation.'
  ]
WHERE module_number = 27;

-- ── 28: Client Relationship Management Tasks (GIC #27) ───────────────────
UPDATE public.modules SET
  title               = 'Client Relationship Management Tasks',
  competency_id       = 'GIC-27',
  ri_hours            = 0,
  ojl_hours           = 50,
  short_description   = 'Client relationships are sustained through consistent, proactive service. You will develop the communication habits, follow-through discipline, and relationship touchpoint strategies that build long-term client loyalty.',
  learning_objectives = ARRAY[
    'Implement a systematic client contact and outreach program.',
    'Respond to client inquiries and service requests promptly and professionally.',
    'Conduct proactive outreach triggered by life events, market conditions, or planning milestones.',
    'Document all client interactions in the CRM to maintain a complete relationship record.',
    'Identify clients at risk of attrition and initiate appropriate service responses.',
    'Support client referral programs and introductions professionally.',
    'Build the communication habits that transform satisfied clients into loyal advocates.'
  ]
WHERE module_number = 28;

-- ── 29: Portfolio Construction Basics & Modeling (GIC #28) ───────────────
UPDATE public.modules SET
  title               = 'Portfolio Construction Basics & Modeling',
  competency_id       = 'GIC-28',
  ri_hours            = 0,
  ojl_hours           = 40,
  short_description   = 'Portfolio construction is where investment theory meets client reality. You will learn the foundational principles of portfolio design — diversification, factor exposure, correlation, and rebalancing — and how to apply them in practice.',
  learning_objectives = ARRAY[
    'Apply diversification principles across asset classes, sectors, and geographies.',
    'Understand basic portfolio construction inputs: expected return, volatility, and correlation.',
    'Build a model portfolio that reflects a client''s asset allocation target.',
    'Calculate portfolio characteristics: weighted average expense ratio, yield, and beta.',
    'Identify when a portfolio requires rebalancing and model the rebalancing trades.',
    'Evaluate portfolio construction trade-offs: active vs. passive, concentrated vs. diversified.',
    'Document a portfolio construction rationale that supports suitability and compliance review.'
  ]
WHERE module_number = 29;

-- ── 30: AI for Reporting, Automation & Client Relationships (supplemental) ─
UPDATE public.modules SET
  competency_id = 'GIC-SUP-2',
  ri_hours      = 8,
  ojl_hours     = 40
WHERE module_number = 30;

-- ── 31: Market Trend Monitoring & Sector Analysis (GIC #29) ──────────────
UPDATE public.modules SET
  title               = 'Market Trend Monitoring & Sector Analysis',
  competency_id       = 'GIC-29',
  ri_hours            = 0,
  ojl_hours           = 30,
  short_description   = 'Understanding market trends and sector dynamics sharpens every investment recommendation. You will develop a systematic approach to monitoring markets, analyzing sector performance, and translating macro trends into actionable portfolio insights.',
  learning_objectives = ARRAY[
    'Monitor equity and fixed income market trends using reliable data sources.',
    'Analyze sector performance and rotation patterns in the context of the economic cycle.',
    'Distinguish between cyclical and secular trends in market data.',
    'Prepare a sector analysis brief that summarizes current conditions and implications.',
    'Apply technical and fundamental analysis concepts to market monitoring tasks.',
    'Identify macroeconomic factors — interest rates, inflation, GDP growth — that drive sector performance.',
    'Translate market trend observations into portfolio review triggers and client communication.'
  ]
WHERE module_number = 31;

-- ── 32: Preparing Research Briefs & Communication Drafts (GIC #30) ────────
UPDATE public.modules SET
  title               = 'Preparing Research Briefs & Communication Drafts',
  competency_id       = 'GIC-30',
  ri_hours            = 0,
  ojl_hours           = 20,
  short_description   = 'The final competency integrates research and communication skills into polished deliverables. You will learn to produce research briefs, client communication drafts, and advisor notes that are clear, accurate, and ready for review.',
  learning_objectives = ARRAY[
    'Produce a research brief that synthesizes findings into a clear executive summary.',
    'Draft client-facing communications — emails, letters, market commentary — that are professional and compliant.',
    'Write internal advisor notes that capture analysis and recommendations concisely.',
    'Apply the firm''s writing standards and compliance review requirements to all drafts.',
    'Adapt communication tone and complexity for different audience types.',
    'Review and self-edit drafts for clarity, accuracy, and appropriate language.',
    'Build a personal library of communication templates that improves efficiency over time.'
  ]
WHERE module_number = 32;

-- ============================================================================
-- VERIFICATION
-- SELECT module_number, competency_id, title, ojl_hours
-- FROM public.modules ORDER BY module_number;
-- Expected: 32 rows with GIC-01 through GIC-30 plus GIC-SUP-1 (Insurance)
-- and GIC-SUP-2 (AI)
-- ============================================================================


-- ── PART 2: Lesson content modules 1-8 ──
-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 1–8
-- Aligned to GIC Work Process titles and practical on-the-job tasks.
-- Run AFTER session8_module_realignment.sql
-- ============================================================================

-- ── MODULE 1: Client Intake & Discovery Interviews ────────────────────────
UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Discovery Is Actually For",
      "summary": "Discovery is not data collection. It is the foundation of every recommendation you will ever make.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Before you can recommend anything — a savings rate, an investment strategy, an insurance policy — you have to understand the person sitting across from you. Discovery is how you get there. It is not a form-filling exercise. It is a structured conversation that surfaces who someone is financially, where they want to go, and what is standing in their way." },
        { "type": "callout", "kind": "key", "title": "The purpose of the first meeting", "text": "You are not there to impress the client. You are there to understand them. The more you talk, the less you learn. The best advisors ask great questions and then get out of the way." },
        { "type": "heading", "text": "How to open the discovery meeting" },
        { "type": "paragraph", "text": "Set the agenda in the first two minutes. Tell the client exactly what you are going to do and why: <em>'Today I want to understand your full financial picture — where you are, where you want to go, and what concerns you most. From there we can figure out how to be most useful to you.'</em> This reduces anxiety, builds trust, and gives you permission to ask personal questions." },
        { "type": "heading", "text": "The three layers of discovery" },
        { "type": "numbered", "items": [
          "<strong>Financial facts</strong> — income, assets, liabilities, insurance, estate documents. What exists.",
          "<strong>Goals and priorities</strong> — what the client wants to accomplish and when. What matters.",
          "<strong>Values and concerns</strong> — what drives their decisions, what keeps them up at night. What is underneath the numbers."
        ]},
        { "type": "callout", "kind": "warn", "title": "The trap most new advisors fall into", "text": "Jumping to solutions before completing discovery. If you are thinking about what to recommend while the client is still talking, you are not listening. Recommendations come after understanding — never during." },
        { "type": "activity", "title": "Practice Opening a Discovery Meeting", "prompt": "Write the first 3 minutes of a discovery meeting script for a 42-year-old married client who was referred by a colleague. They have never worked with a financial advisor before.", "steps": [
          "Start with a brief introduction of yourself and the firm.",
          "Set the agenda: explain what today's meeting is for.",
          "Explain what the client can expect from the process.",
          "Ask your first open-ended question to begin the conversation.",
          "Read it aloud — does it sound natural, or does it sound like a script?"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Discovery Interview Framework",
      "summary": "A structured question sequence that surfaces everything you need without making the client feel interrogated.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "Discovery works best when it follows a logical sequence: start with the factual and concrete, then move to goals, then to values and concerns. This sequence builds psychological safety. Clients are more comfortable sharing their fears and frustrations after they have already shared their balance sheet." },
        { "type": "heading", "text": "The question sequence" },
        { "type": "numbered", "items": [
          "<strong>Situational questions</strong> — 'Walk me through your current income sources.' 'What accounts do you currently have?' These are easy to answer and warm the conversation.",
          "<strong>Goal questions</strong> — 'What are the two or three financial goals that matter most to you right now?' 'When do you hope to retire?' These get to the heart of the engagement.",
          "<strong>Priority questions</strong> — 'If we could only accomplish one thing together in the next 12 months, what would it be?' This reveals what is truly urgent.",
          "<strong>Concern questions</strong> — 'What keeps you up at night financially?' 'Is there anything about your situation that worries you that we haven't talked about?' These surface the emotional agenda.",
          "<strong>Experience questions</strong> — 'Have you worked with an advisor before? What worked well? What didn't?' This tells you how to serve them."
        ]},
        { "type": "heading", "text": "Active listening in practice" },
        { "type": "paragraph", "text": "Active listening is not just being quiet while the client talks. It means demonstrating that you are processing what they say: reflecting back ('So what I'm hearing is...'), asking follow-up questions ('You mentioned you're worried about your daughter's college costs — can you tell me more about that?'), and resisting the urge to fill silence. Silence is productive. Let it breathe." },
        { "type": "callout", "kind": "do", "title": "The note-taking balance", "text": "Take notes, but do not let your notepad become a barrier. Glance down to write, but maintain eye contact. If you are writing constantly, the client feels like they are being processed. If you write nothing, you will miss critical details." },
        { "type": "glossary", "terms": [
          { "term": "Open-ended question", "definition": "A question that cannot be answered with yes or no. Begins with 'what,' 'how,' 'tell me about,' or 'walk me through.' Opens the conversation." },
          { "term": "Closed question", "definition": "A question with a specific answer: 'Do you have a 401(k)?' Useful for confirming facts, not for discovery." },
          { "term": "Reflective listening", "definition": "Paraphrasing what the client said to confirm understanding and show you were paying attention." }
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Quantitative vs. Qualitative Discovery",
      "summary": "Numbers tell you position. Goals tell you direction. Values tell you why. You need all three.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two clients with identical balance sheets — the same net worth, the same income, the same portfolio — can have completely different financial plans. The difference is not in the numbers. It is in what those numbers are supposed to accomplish and what the person is willing to do to get there." },
        { "type": "heading", "text": "Quantitative discovery — the factual layer" },
        { "type": "list", "items": [
          "Current income: all sources, gross and net",
          "Assets: bank accounts, investment accounts, retirement accounts, real property, business interests",
          "Liabilities: mortgage, auto loans, student loans, credit card balances",
          "Insurance: life, disability, health, property, liability",
          "Estate documents: will, trust, POA, beneficiary designations"
        ]},
        { "type": "heading", "text": "Qualitative discovery — the goal and values layer" },
        { "type": "paragraph", "text": "Qualitative discovery is harder because it requires clients to reflect on what they actually want — not what they think they should want, not what their parents wanted for them, but what genuinely matters to them. This takes patience and skill. Many clients have never had a structured conversation about their financial values before." },
        { "type": "callout", "kind": "key", "title": "Translating vague goals into plannable objectives", "text": "'I want to be comfortable in retirement' is not plannable. 'I want $6,000 per month in after-tax income starting at age 65, adjusted for inflation, that I cannot outlive' is plannable. Your job is to ask enough questions to make the translation." },
        { "type": "activity", "title": "Goal Translation Exercise", "prompt": "Take each vague client statement below and write the follow-up questions you would ask to turn it into a specific, plannable objective.", "steps": [
          "'I want to take care of my kids.' — What does taking care of them mean? Education? Down payment help? Life insurance?",
          "'I want to retire someday.' — When? What will retirement look like? What income will you need?",
          "'I want to be debt-free.' — All debt, or just consumer debt? By when? How aggressively?",
          "'I want to grow my money.' — What is the purpose of the growth? What is the time horizon? What risk is acceptable?",
          "'I want financial security.' — What would security look like? What would have to be true for you to feel secure?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting the Discovery Meeting",
      "summary": "A discovery conversation that isn't documented didn't happen. Here's how to capture it correctly.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Documentation is not a formality. It is what allows a colleague to pick up a client file and serve that client effectively. It is what protects you in a compliance examination. It is what the advisor uses to prepare for the next meeting. If it is not in writing, it does not count." },
        { "type": "heading", "text": "What to document from the discovery meeting" },
        { "type": "list", "items": [
          "Date, attendees, and meeting format (in-person, phone, video)",
          "Financial facts gathered: accounts, income, liabilities, insurance, estate documents",
          "Goals identified: specific, prioritized, with target dates where possible",
          "Concerns raised: what the client is worried about, what they want to avoid",
          "Action items: what the advisor committed to, what the client needs to provide",
          "Next steps and scheduled follow-up"
        ]},
        { "type": "heading", "text": "The CRM entry standard" },
        { "type": "paragraph", "text": "Every discovery meeting gets a CRM interaction log entry within 24 hours. The entry should be complete enough that someone who was not in the meeting could understand what happened and what comes next. Use the firm's interaction log template. Do not summarize so heavily that the record is useless." },
        { "type": "callout", "kind": "do", "title": "The follow-up email", "text": "Send the client a follow-up email within 24 hours summarizing what was discussed, what you need from them, and the next step. This confirms their understanding, creates a paper trail, and demonstrates professionalism. Use a template but personalize it." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Common Discovery Challenges",
      "summary": "Not every discovery meeting goes smoothly. Here's how to handle the situations that trip up new advisors.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Discovery is a skill that improves with repetition. Even experienced advisors encounter challenging clients. The difference is that experienced advisors have learned to recognize the pattern and respond professionally rather than freeze or improvise poorly." },
        { "type": "case_study", "title": "The Reluctant Sharer", "scenario": "A client agrees to the meeting but gives one-word answers and seems uncomfortable discussing finances. 'I just want someone to manage my money. I don't see why I have to share all of this.' How do you respond?", "discussion": "Acknowledge the discomfort directly: 'I understand that talking about finances can feel personal — it is personal. The reason I ask these questions is that without understanding your full situation, I can't give you advice I can actually stand behind. I'm not asking to be intrusive. I'm asking because I want to get it right.' Then slow down, ask smaller questions, and build trust gradually." },
        { "type": "case_study", "title": "The Spouse Who Won't Engage", "scenario": "A couple comes in for discovery. One spouse is engaged and answering questions. The other is checking their phone and giving minimal responses. This matters because financial planning is a household exercise.", "discussion": "Direct a question specifically to the quieter spouse — something non-threatening and specific to them: 'From your perspective, what would make this year feel like a financial success?' Make them feel that their input matters and that you are working for both of them, not just the one who made the appointment." },
        { "type": "case_study", "title": "The Client Who Doesn't Know Their Own Numbers", "scenario": "You ask about household income and the client says 'I'm not sure exactly — somewhere around $200,000?' They don't know their account balances, their mortgage balance, or what they have in their 401(k).", "discussion": "This is more common than it sounds. Don't make them feel embarrassed. Normalize it: 'That's completely fine — most people don't have these numbers memorized. Let me give you a document checklist and we'll get exact figures from your statements.' Then work with estimated numbers for now and refine as documents come in." },
        { "type": "callout", "kind": "note", "title": "The skill that takes longest to develop", "text": "Comfortable silence. Most new advisors rush to fill a pause after a question. But silence often means the client is processing something important. Give them 5-10 seconds before you speak again. What comes after a pause is often the most important thing they say." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the primary purpose of a client discovery meeting?", "options": ["To understand the client's full financial situation, goals, and values before making any recommendations", "To present the firm's investment products and services", "To complete the required KYC documentation for compliance", "To determine how much the client can afford to invest"], "correct": 0, "explanation": "Discovery is about understanding before recommending. Recommendations made without complete discovery are guesswork." },
      { "id": "q2", "text": "In what order should discovery questions typically be asked?", "options": ["Factual/situational questions first, then goals, then values and concerns", "Values and concerns first, then goals, then facts", "Goals first, then facts, then values", "All at the same time using a structured questionnaire"], "correct": 0, "explanation": "Starting with factual questions builds psychological safety before asking more personal questions about values and concerns." },
      { "id": "q3", "text": "A client says 'I want to be comfortable in retirement.' What is the advisor's best next step?", "options": ["Ask follow-up questions to translate this into a specific, plannable objective", "Note the goal as stated and move on to other topics", "Recommend a retirement income annuity", "Explain that 'comfortable' is too vague to plan around"], "correct": 0, "explanation": "Vague goals must be translated into specific, measurable objectives before planning can begin. Follow-up questions are the tool." },
      { "id": "q4", "text": "What should the CRM interaction log entry from a discovery meeting include?", "options": ["Date, attendees, financial facts gathered, goals identified, concerns raised, and action items", "Only the client's account balances and investment preferences", "A summary of the advisor's recommendations", "The client's personal background and family history"], "correct": 0, "explanation": "Complete documentation allows any team member to serve the client effectively and satisfies compliance requirements." },
      { "id": "q5", "text": "A client answers questions with one-word responses and seems uncomfortable. What is the best approach?", "options": ["Acknowledge the discomfort directly, explain why the questions matter, then ask smaller, less threatening questions", "Skip the discovery and move to investment recommendations", "End the meeting and reschedule", "Have the client fill out a written questionnaire instead"], "correct": 0, "explanation": "Normalizing the discomfort and explaining the purpose of discovery builds trust. Skipping discovery leads to poor advice." },
      { "id": "q6", "text": "Which type of question is most effective for opening a discovery conversation?", "options": ["An open-ended question that cannot be answered with yes or no", "A closed question about current account balances", "A multiple-choice question about risk tolerance", "A yes/no question about whether the client has a will"], "correct": 0, "explanation": "Open-ended questions invite the client to share their full perspective and open the conversation naturally." },
      { "id": "q7", "text": "Within how long should a follow-up email and CRM entry be completed after a discovery meeting?", "options": ["Within 24 hours", "Within one week", "Before the next client meeting", "Only when the client requests it"], "correct": 0, "explanation": "24 hours is the professional standard. It confirms understanding, creates an audit trail, and demonstrates reliability." },
      { "id": "q8", "text": "A spouse in a couple's meeting is disengaged and checking their phone. What should the advisor do?", "options": ["Direct a specific, non-threatening question to the quieter spouse to make them feel included", "Focus on the engaged spouse and follow up with the other separately", "Note the engagement level and continue the meeting", "Ask the engaged spouse to encourage their partner to participate"], "correct": 0, "explanation": "Financial planning affects both partners. The advisor must engage both. A direct, personal question signals that their input matters." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 1;

-- ── MODULE 2: Gathering & Organizing Financial Documents ──────────────────
UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Document Universe",
      "summary": "Every financial planning engagement starts with documents. Know what you need, why you need it, and what is missing.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "You cannot build an accurate financial plan from what clients tell you from memory. Memory is selective, imprecise, and optimistic. Documents are authoritative. The discipline of gathering and organizing the right documents before analysis begins is the foundation of every accurate plan." },
        { "type": "heading", "text": "The core document set" },
        { "type": "glossary", "terms": [
          { "term": "Tax returns (2 years)", "definition": "Shows actual income, deductions, investment activity, business income, and tax liability. More reliable than a pay stub for complex income situations." },
          { "term": "Pay stubs (most recent)", "definition": "Confirms current gross income, tax withholding, benefits deductions, and retirement contributions. Use the YTD column for annualized figures." },
          { "term": "Investment account statements", "definition": "Shows holdings, balances, cost basis, dividends, and realized gains. Request the most recent quarter-end statement for each account." },
          { "term": "Retirement account statements", "definition": "401(k), 403(b), IRA, Roth IRA — each account separately. Shows balance, contribution rate, investment elections, and vesting schedule if applicable." },
          { "term": "Mortgage statement", "definition": "Shows current balance, interest rate, remaining term, and monthly payment. Essential for cash flow analysis and net worth calculation." },
          { "term": "Life and disability insurance policies", "definition": "Shows coverage amounts, premiums, beneficiaries, and policy type. Many clients cannot describe their own coverage accurately." },
          { "term": "Social Security statement", "definition": "Shows estimated benefit at various claiming ages based on earnings history. Available at ssa.gov. Critical for retirement planning." },
          { "term": "Estate planning documents", "definition": "Will, trust agreement, power of attorney, healthcare directive. Without reviewing these, beneficiary and ownership structures are unknown." }
        ]},
        { "type": "callout", "kind": "warn", "title": "What clients think they need vs. what you actually need", "text": "Clients often bring account statements but forget tax returns. They describe their insurance but cannot produce the policy. They know they have a will but haven't seen it in ten years. Build your checklist around documents, not client memory." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Building and Using a Document Checklist",
      "summary": "A well-built checklist is the difference between a complete file and an expensive mistake.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The document checklist is one of the most important tools in the advisory practice. Used correctly, it ensures nothing is missed. Used poorly — or not at all — it creates gaps that produce inaccurate analysis, bad recommendations, and compliance exposure." },
        { "type": "heading", "text": "Building the checklist" },
        { "type": "paragraph", "text": "The master checklist includes every document category. The client-specific checklist is customized at the start of each engagement: if the client has no business income, remove the business tax return. If they are renters, remove the mortgage statement. Customization reduces client overwhelm and improves response rate." },
        { "type": "heading", "text": "Tracking collection status" },
        { "type": "list", "items": [
          "<strong>Requested</strong> — you have asked for it, it has not arrived",
          "<strong>Received</strong> — you have it in hand",
          "<strong>Verified</strong> — you have confirmed it is complete and current",
          "<strong>N/A</strong> — not applicable for this client"
        ]},
        { "type": "callout", "kind": "do", "title": "The two-week follow-up rule", "text": "If a document has been requested and not received in two weeks, follow up. Use the checklist to identify what is outstanding. Clients are busy, not uncooperative. A friendly reminder with a specific list of what is missing gets results." },
        { "type": "activity", "title": "Build a Client Document Checklist", "prompt": "For a 48-year-old married client with W-2 income, a 401(k), two taxable investment accounts, a mortgage, and term life insurance, build a complete document checklist.", "steps": [
          "List every document category that applies to this client.",
          "For each document, specify the version needed (most recent, prior two years, etc.).",
          "Add a status column: Requested / Received / Verified / N/A.",
          "Identify two documents that clients in this situation most commonly forget or delay.",
          "Write the email you would send requesting these documents, with the checklist attached."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Verifying What You Receive",
      "summary": "Receiving a document is not the same as having usable information. Learn to read each document critically.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "Documents are only useful if you can read them correctly. A brokerage statement, a tax return, and a pay stub each have a specific structure. Knowing where to find the numbers you need — and recognizing when something looks wrong — is a core skill." },
        { "type": "heading", "text": "Reading a brokerage statement" },
        { "type": "list", "items": [
          "Account summary: total value, cash position, market value of securities",
          "Holdings detail: each position, shares held, current price, market value, cost basis",
          "Transaction history: buys, sells, dividends, interest, fees during the period",
          "Performance: portfolio return for the period — check the benchmark comparison"
        ]},
        { "type": "heading", "text": "Reading a pay stub" },
        { "type": "paragraph", "text": "The pay stub tells you three critical things: gross income (what the client earns), net income (what actually hits the bank account), and what is being withheld (taxes, retirement contributions, health insurance, HSA contributions). The YTD columns are more reliable than a single pay period for annualizing." },
        { "type": "callout", "kind": "warn", "title": "Red flags in documents", "text": "Large unexplained deposits or withdrawals on bank statements. Cost basis labeled as 'N/A' on investment statements (may indicate inherited assets or very old holdings). Life insurance premiums that seem disproportionately high for the coverage amount. Beneficiary designations that name an estate rather than a person. Each of these requires follow-up before analysis proceeds." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Organizing Files for Planning and Compliance",
      "summary": "Organization is not just for your convenience — it is a compliance requirement and a client service standard.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A disorganized client file is a liability. It slows down planning, creates errors, and fails compliance review. The time invested in organizing documents at intake pays dividends every time the file is touched." },
        { "type": "heading", "text": "The standard folder structure" },
        { "type": "numbered", "items": [
          "01 — Discovery & Intake (questionnaires, meeting notes, signed agreements)",
          "02 — Financial Documents (tax returns, statements, pay stubs, insurance policies)",
          "03 — Planning Work (analysis, scenarios, plan drafts)",
          "04 — Client Communications (emails, letters, follow-ups)",
          "05 — Compliance (signed disclosures, ADV receipts, suitability documentation)"
        ]},
        { "type": "callout", "kind": "note", "title": "Version control matters", "text": "When you receive an updated document — a new tax return, a revised account statement — do not delete the old one. Rename it with the date and keep it. Compliance examinations sometimes ask for historical documents. Deleting superseded files can create problems." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Requesting Documents Professionally",
      "summary": "How you ask for documents affects whether you get them. Tone, timing, and specificity all matter.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients do not always prioritize document gathering. They are busy, the task feels tedious, and they are not sure exactly what you need. Your job is to make it easy. A clear, specific, friendly request gets a faster response than a vague, formal one." },
        { "type": "heading", "text": "Elements of an effective document request" },
        { "type": "list", "items": [
          "<strong>Specific list</strong> — name each document, not just 'financial documents'",
          "<strong>Why it matters</strong> — one sentence explaining what you use each document for",
          "<strong>Format flexibility</strong> — 'A photo or PDF is fine' reduces friction",
          "<strong>Clear deadline</strong> — 'By Friday so we can begin analysis next week'",
          "<strong>Easy submission method</strong> — secure email, client portal, in-person"
        ]},
        { "type": "callout", "kind": "do", "title": "The follow-up without nagging", "text": "If documents haven't arrived after two weeks: 'Hi [Name], I wanted to follow up on the document list I sent. We're ready to begin your analysis as soon as we receive these three items — your most recent tax return, your 401(k) statement, and your life insurance policy. Happy to answer any questions about what we need or why.' Friendly, specific, forward-looking." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why are client documents more reliable than client memory for financial planning?", "options": ["Documents are authoritative and precise while memory is selective and often inaccurate", "Documents are required by regulation but memory is not", "Clients refuse to provide memory-based information", "Documents are easier to organize in the CRM"], "correct": 0, "explanation": "Memory is selective and optimistic. Actual tax returns, statements, and policy documents reflect reality. Plans built on documented facts are more accurate." },
      { "id": "q2", "text": "What does a Social Security statement show that is critical for retirement planning?", "options": ["Estimated benefit amounts at various claiming ages based on the client's actual earnings history", "The client's current Medicare eligibility status", "Required minimum distribution amounts", "The client's lifetime contribution history to Social Security"], "correct": 0, "explanation": "The SSA statement shows projected benefits at age 62, full retirement age, and 70. This is essential data for retirement income modeling." },
      { "id": "q3", "text": "Which document status means the document has been confirmed as complete and current?", "options": ["Verified", "Received", "Requested", "Reviewed"], "correct": 0, "explanation": "Received means it arrived. Verified means you confirmed it is complete, current, and usable. Both steps are required before using a document in analysis." },
      { "id": "q4", "text": "On a pay stub, which column is most useful for calculating annualized income?", "options": ["Year-to-date (YTD) column, which accumulates across all pay periods", "The current pay period column", "The gross pay line only", "The net pay line"], "correct": 0, "explanation": "The YTD column accumulates across all pay periods, making it more reliable for annualizing income than a single pay period figure." },
      { "id": "q5", "text": "A client's brokerage statement shows cost basis labeled as 'N/A' for several positions. What does this most likely indicate?", "options": ["Inherited assets or very old holdings where cost basis was not transferred", "The account was opened this year and no positions have been sold", "The client has elected not to report cost basis", "An error in the statement that should be ignored"], "correct": 0, "explanation": "N/A cost basis often signals inherited assets or positions transferred from old accounts where the original cost was not reported. This requires follow-up before analyzing gains." },
      { "id": "q6", "text": "What is the primary reason for maintaining the standard folder structure in client files?", "options": ["It allows any team member to find documents quickly and satisfies compliance documentation requirements", "It is required by SEC regulations for all RIA client files", "It makes it easier to send documents to clients", "It reduces storage costs for the firm"], "correct": 0, "explanation": "Consistent organization serves both efficiency (anyone can work the file) and compliance (examiners can find what they need)." },
      { "id": "q7", "text": "When a client provides an updated tax return, what should happen to the prior year's return?", "options": ["Rename it with the date and retain it — historical documents may be needed for compliance review", "Delete it since it is no longer current", "Move it to the client's personal folder outside the main filing system", "Return it to the client"], "correct": 0, "explanation": "Version control requires retaining superseded documents. Compliance examinations sometimes request historical records. Deleting old files creates risk." },
      { "id": "q8", "text": "What should a professional document request email include?", "options": ["A specific list of documents needed, why each matters, the format accepted, a clear deadline, and how to submit", "A general request for 'all financial documents'", "A list of what the advisor will do with the documents once received", "A formal letter on firm letterhead"], "correct": 0, "explanation": "Specific, clear document requests with reasons and deadlines get faster responses than vague requests. Reducing client friction speeds up the planning process." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 2;

-- ── MODULE 3: Cash Flow & Budgeting Analysis ──────────────────────────────
UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building the Cash Flow Statement",
      "summary": "Cash flow is the engine of every financial plan. Learn to construct it from documents, not estimates.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow statement answers one question: does more money come in than go out each month — and by how much? The answer determines what is possible. Without a clear cash flow picture, savings goals, debt payoff plans, and investment strategies are built on guesswork." },
        { "type": "heading", "text": "Income: start with net, not gross" },
        { "type": "paragraph", "text": "Gross income is what clients earn. Net income is what they can spend. Every budgeting conversation must happen in net terms. When a client says 'I make $120,000 a year,' your first question is always: 'Is that gross or net?' The difference can be $30,000 or more after taxes, retirement contributions, and benefit deductions." },
        { "type": "heading", "text": "Three categories of expenses" },
        { "type": "glossary", "terms": [
          { "term": "Fixed expenses", "definition": "Same amount every month: rent or mortgage, car payment, insurance premiums, loan payments, subscriptions. Predictable and contractual." },
          { "term": "Variable expenses", "definition": "Change month to month: groceries, gas, dining, entertainment, clothing. Harder to track, easier to reduce." },
          { "term": "Periodic expenses", "definition": "Real expenses that don't occur monthly: annual insurance premiums, property taxes, car registration, holiday gifts, medical costs, home maintenance. The most commonly forgotten category — and the one that breaks most budgets." }
        ]},
        { "type": "callout", "kind": "key", "title": "The periodic expense problem", "text": "Most household budgeting failures trace back to forgetting periodic expenses. A client who 'has $800 left at the end of every month' may actually be running a deficit when you account for the $1,200 car registration in March, the $2,400 property tax payment in December, and the $3,000 holiday spending. Always ask: 'What expenses come up that aren't monthly?'" },
        { "type": "activity", "title": "Build a Cash Flow Statement", "prompt": "Using the information below, build a complete monthly cash flow statement and calculate net cash flow.", "steps": [
          "Gross income: $95,000/year. After taxes, 401(k) contribution (6%), and health insurance ($280/month), net monthly income = ?",
          "Fixed expenses: $2,200 mortgage, $450 car payment, $180 insurance, $90 subscriptions.",
          "Variable expenses: $600 groceries, $200 gas, $350 dining, $150 entertainment.",
          "Periodic expenses (monthly equivalent): $150 property tax, $80 car registration, $200 home maintenance reserve, $100 holiday/gifts.",
          "Calculate total monthly expenses and net cash flow (income minus expenses).",
          "Is this household in surplus or deficit? What would change if the car payment ended in 6 months?"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Finding the Gap — Surplus vs. Deficit",
      "summary": "The cash flow that looks fine from the outside often isn't. Learn to find the real number.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients frequently believe their cash flow is positive because they have not explicitly tracked where the money goes. Credit card debt that grows slowly, savings that barely move, and account balances that never quite improve — these are the symptoms of a cash flow problem that has not been diagnosed." },
        { "type": "heading", "text": "The proof is in the accounts" },
        { "type": "paragraph", "text": "If a client says they have $500 left at the end of every month but their savings account grew by only $1,200 last year, the math does not work. ($500 × 12 = $6,000 expected savings vs. $1,200 actual.) The gap is the spending that wasn't tracked. This discrepancy is your most powerful diagnostic tool." },
        { "type": "callout", "kind": "warn", "title": "The lifestyle inflation trap", "text": "Incomes rise. Expenses follow immediately. Every raise, bonus, or promotion is absorbed by a bigger car, a bigger house, a nicer vacation. This is normal human behavior. The cash flow analysis makes it visible so the client can make a conscious choice about it." },
        { "type": "callout", "kind": "do", "title": "Present findings, not judgments", "text": "When you find a spending gap: 'Looking at your cash flow, there's a difference between what you tell me should be left over and what's actually accumulating. Let's figure out where that gap is.' Not: 'You're overspending.' One opens a problem-solving conversation. The other creates defensiveness." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Budgeting Frameworks",
      "summary": "There is no universal budget. Learn which framework fits which client — and how to present it.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The best budget is the one the client will actually use. A technically perfect zero-based budget that a client abandons after three weeks is worse than a simple framework they stick with for years. Match the framework to the client." },
        { "type": "heading", "text": "The 50/30/20 framework" },
        { "type": "paragraph", "text": "50% of net income to needs (housing, food, transportation, utilities), 30% to wants (dining, entertainment, travel, hobbies), 20% to savings and debt repayment. Simple enough for clients who resist budgeting detail. Not precise enough for clients with complex situations or significant debt." },
        { "type": "heading", "text": "Zero-based budgeting" },
        { "type": "paragraph", "text": "Every dollar of income is assigned a category until the balance is zero. More rigorous, more powerful, and more difficult to maintain. Best for clients who are in debt, who have tried other approaches without success, or who genuinely want to optimize their cash flow." },
        { "type": "callout", "kind": "key", "title": "The spending plan vs. the restriction plan", "text": "Call it a spending plan, not a budget. 'Budget' carries a connotation of restriction and sacrifice. A spending plan is about intention — deciding in advance where the money goes rather than wondering afterward where it went. Framing matters." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Cash Flow as a Planning Tool",
      "summary": "Every goal in the financial plan gets funded from surplus cash flow. Here's how to use it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow statement is not just a diagnostic tool. It is the mechanism by which financial goals get funded. Every dollar of surplus cash flow is a dollar that can go toward savings, debt reduction, emergency fund building, or investment. The sequence matters." },
        { "type": "heading", "text": "Cash flow funding sequence" },
        { "type": "numbered", "items": [
          "Emergency fund first — 3-6 months of fixed expenses in liquid savings",
          "Employer 401(k) match — free money that should not be left on the table",
          "High-interest debt elimination — any debt above 6-7% interest rate",
          "Additional retirement contributions — maxing tax-advantaged accounts",
          "Other financial goals — education savings, home down payment, taxable investment"
        ]},
        { "type": "callout", "kind": "note", "title": "Debt payoff sequencing", "text": "The mathematically optimal approach is avalanche method: pay minimums on all debt, put extra toward the highest interest rate first. The behaviorally effective approach is snowball method: pay off the smallest balance first for motivational wins. Know both and match the method to the client." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Cash Flow Findings to Clients",
      "summary": "How you share the cash flow analysis determines whether the client acts on it or gets defensive.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow conversation is emotionally loaded. People have feelings about money — shame, pride, anxiety, defensiveness. How you present the findings determines whether the conversation becomes productive or shuts down." },
        { "type": "heading", "text": "Language that opens vs. language that closes" },
        { "type": "list", "items": [
          "<strong>Opens:</strong> 'Here's what your cash flow tells us about what's possible.' <strong>Closes:</strong> 'You're spending too much on dining out.'",
          "<strong>Opens:</strong> 'There's a gap between your income and your savings rate. Let's figure out what's driving it.' <strong>Closes:</strong> 'You're not saving enough.'",
          "<strong>Opens:</strong> 'If we redirect $400/month, here's what changes in 10 years.' <strong>Closes:</strong> 'You need to cut back on your lifestyle.'"
        ]},
        { "type": "callout", "kind": "do", "title": "Show the impact, not the sacrifice", "text": "Clients don't want to cut spending. They want to achieve goals. Show them what redirecting cash flow makes possible — a paid-off mortgage in 12 years instead of 22, a retirement at 62 instead of 67, a fully funded college education — and the sacrifice becomes a trade, not a loss." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why must cash flow analysis be conducted in net income terms rather than gross income?", "options": ["Net income is what the client actually has available to spend and save after taxes and deductions", "Gross income is harder to verify from documents", "Regulators require net income for financial planning", "Gross income varies too much month to month"], "correct": 0, "explanation": "Gross income is what clients earn. Net income is what they can actually deploy. Budgeting from gross figures leads to systematic overestimation of available cash." },
      { "id": "q2", "text": "Which category of expenses is most commonly forgotten in cash flow analysis?", "options": ["Periodic expenses — real costs that don't occur monthly but are predictable", "Fixed expenses like rent and mortgage payments", "Variable expenses like groceries and gas", "Investment contributions"], "correct": 0, "explanation": "Periodic expenses (annual insurance, property taxes, seasonal spending) break most budgets because they are real but not monthly. Always ask clients about non-monthly expenses." },
      { "id": "q3", "text": "A client says they have $600 left at the end of each month but their savings grew by only $900 last year. What does this suggest?", "options": ["There is approximately $6,300 of untracked spending — the gap between expected and actual savings", "The client made a large purchase during the year", "The client's income decreased during the year", "The savings account interest rate is dragging down the balance"], "correct": 0, "explanation": "$600 × 12 = $7,200 expected. $900 actual. The $6,300 gap represents spending that wasn't tracked. This is a powerful diagnostic finding." },
      { "id": "q4", "text": "What is the correct order for allocating surplus cash flow in a financial plan?", "options": ["Emergency fund, employer match, high-interest debt, additional retirement savings, other goals", "Investments first, then emergency fund, then debt", "Debt elimination first, then all savings goals simultaneously", "Retirement savings first regardless of other factors"], "correct": 0, "explanation": "The sequence matters. Emergency fund prevents new debt. Employer match is free money. High-interest debt has a guaranteed return equal to the interest rate. Then long-term goals." },
      { "id": "q5", "text": "What does the 50/30/20 budgeting framework allocate to savings and debt repayment?", "options": ["20% of net income", "30% of net income", "50% of net income", "It does not specify a savings allocation"], "correct": 0, "explanation": "50% to needs, 30% to wants, 20% to savings and debt repayment. Simple and memorable, though not precise enough for complex situations." },
      { "id": "q6", "text": "Why is calling it a 'spending plan' rather than a 'budget' recommended when working with clients?", "options": ["It reframes the exercise as intentional decision-making rather than restriction, which improves client engagement", "The term 'budget' is technically incorrect in financial planning", "Clients prefer longer terminology", "Regulators require the term 'spending plan'"], "correct": 0, "explanation": "Framing matters. 'Budget' implies restriction and sacrifice. 'Spending plan' implies intention and control. Clients are more likely to engage with the latter." },
      { "id": "q7", "text": "What is the mathematically optimal debt payoff method?", "options": ["Avalanche method: pay minimums on all debts, put extra toward highest interest rate first", "Snowball method: pay off smallest balance first", "Equal extra payments across all debts", "Minimum payments on all debts while maximizing investments"], "correct": 0, "explanation": "The avalanche method minimizes total interest paid by attacking the highest rate first. The snowball method is behaviorally superior for some clients but mathematically less efficient." },
      { "id": "q8", "text": "When presenting cash flow findings that show overspending in a specific category, what is the most effective approach?", "options": ["Frame it as what redirecting that cash flow makes possible, not what the client is doing wrong", "Show the client exactly how much they spent in each category with a detailed breakdown", "Compare the client's spending to national averages in each category", "Recommend specific spending cuts in problem categories"], "correct": 0, "explanation": "Clients respond to possibility, not judgment. Showing what a cash flow redirect achieves — years off a mortgage, earlier retirement — converts the sacrifice into a trade." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 3;

-- ── MODULES 4-8: Titles and structure maintained, core content provided ───

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Retirement Income Problem",
      "summary": "Retirement is the most complex planning challenge most clients face. Start with the income question.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "The fundamental challenge of retirement planning is not accumulation — it is income. A client who retires at 65 and lives to 90 needs 25 years of income from a pool of assets that is no longer being replenished. The question is not 'how much do you have?' It is 'how long will it last, and what happens if it doesn't?'" },
        { "type": "heading", "text": "The three sources of retirement income" },
        { "type": "list", "items": [
          "<strong>Social Security</strong> — guaranteed, inflation-adjusted, but rarely sufficient alone",
          "<strong>Pension or annuity income</strong> — guaranteed income that fewer clients have than a generation ago",
          "<strong>Portfolio withdrawals</strong> — from 401(k), IRA, and taxable accounts — the variable, depletable source"
        ]},
        { "type": "callout", "kind": "key", "title": "The inflation problem", "text": "At 3% annual inflation, $1 today buys $0.74 worth of goods in 10 years and $0.55 in 20 years. A client who needs $6,000/month at 65 will need approximately $8,100/month at 75 and $10,900/month at 85 to maintain the same purchasing power. Plans that ignore inflation are dangerously optimistic." },
        { "type": "heading", "text": "Calculating the retirement income need" },
        { "type": "paragraph", "text": "The replacement rate method: estimate that the client needs 70-85% of pre-retirement income. This is a rough approximation — adequate for a first conversation but not for a plan. The expense-based method is more accurate: project actual retirement expenses category by category (housing, healthcare, travel, food, insurance), then add an inflation buffer." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Social Security — Timing and Strategy",
      "summary": "Social Security claiming decisions are permanent. Most clients make them without analysis.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Social Security is the most underanalyzed decision most clients make. The claiming age determines the benefit amount for life. Taking benefits at 62 versus waiting until 70 can mean a 77% difference in monthly income. For a couple, the coordination of claiming strategies adds another layer of complexity." },
        { "type": "heading", "text": "The three claiming ages" },
        { "type": "glossary", "terms": [
          { "term": "Age 62 (earliest)", "definition": "Benefit is permanently reduced by 25-30% compared to full retirement age. Available immediately but locks in a lower amount for life." },
          { "term": "Full retirement age (66-67)", "definition": "Depends on birth year. The baseline benefit with no reduction or delayed credit." },
          { "term": "Age 70 (maximum)", "definition": "Delayed retirement credits add 8% per year after full retirement age. Maximum possible benefit." }
        ]},
        { "type": "callout", "kind": "key", "title": "The break-even analysis", "text": "Delaying Social Security means forgoing years of benefits in exchange for higher monthly payments later. The break-even point — when the cumulative total from delayed claiming catches up to the total from early claiming — is typically age 78-82. Clients in good health with longevity in their family have good reason to delay." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Retirement Accounts and Their Roles",
      "summary": "Know the vehicles before you discuss strategy. Each account has different rules and planning implications.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client will have one or more retirement accounts. Knowing the rules for each — contribution limits, tax treatment, required distributions, withdrawal penalties — is a prerequisite for retirement planning, not an advanced skill." },
        { "type": "glossary", "terms": [
          { "term": "Traditional 401(k)", "definition": "Pre-tax contributions reduce current taxable income. Growth is tax-deferred. Withdrawals in retirement are taxed as ordinary income. RMDs begin at age 73." },
          { "term": "Roth 401(k)", "definition": "After-tax contributions. Growth and qualified withdrawals are tax-free. Same contribution limits as Traditional. No RMDs during the owner's lifetime." },
          { "term": "Traditional IRA", "definition": "May be tax-deductible depending on income and employer plan coverage. Tax-deferred growth. RMDs at 73. Backdoor Roth conversion strategy for high earners." },
          { "term": "Roth IRA", "definition": "After-tax contributions. Tax-free growth and qualified withdrawals. No RMDs. Income limits apply for direct contributions." },
          { "term": "SEP-IRA", "definition": "For self-employed and small business owners. Higher contribution limits than traditional IRA. Employer contributions only." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The Roth vs. Traditional decision", "text": "The core question: will the client be in a higher or lower tax bracket in retirement than today? If higher in retirement (young, low income now, expecting higher income later) — Roth. If lower in retirement (high income now, lower expected in retirement) — Traditional. If uncertain — split the contributions." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Building a Retirement Scenario",
      "summary": "Turn the analysis into a client-ready scenario that shows the path forward.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A retirement scenario is not a projection of what will happen. It is a model of what could happen under specified assumptions. The assumptions must be documented, defensible, and explained to the client. The scenario is a planning tool, not a forecast." },
        { "type": "heading", "text": "Key assumptions to document" },
        { "type": "list", "items": [
          "Retirement age and retirement date",
          "Pre-retirement savings rate and account growth assumption",
          "Social Security claiming age and estimated benefit",
          "Estimated retirement spending (monthly, inflation-adjusted)",
          "Portfolio withdrawal rate in retirement",
          "Life expectancy assumption (usually plan to age 90 or 95 for conservative modeling)"
        ]},
        { "type": "activity", "title": "Sensitivity Analysis Exercise", "prompt": "Take a basic retirement scenario and model how changes in key variables affect the outcome.", "steps": [
          "Base case: retire at 65, 7% pre-retirement return, 4% withdrawal rate, plan to 90.",
          "Scenario 2: retire at 63 instead of 65. How does this change portfolio depletion?",
          "Scenario 3: portfolio returns are 5% instead of 7%. What changes?",
          "Scenario 4: client lives to 95 instead of 90. Is the portfolio sufficient?",
          "Which variable has the biggest impact on the outcome? What does this tell the client about their greatest risk?"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Documenting and Presenting Retirement Analysis",
      "summary": "The analysis is only useful if the client understands it and can act on it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Retirement scenarios can become technical very quickly. The advisor's job is to make the analysis legible to the client — not to show the full complexity of the model, but to answer the three questions clients actually care about: Am I on track? What do I need to change? What happens if things don't go as planned?" },
        { "type": "callout", "kind": "do", "title": "The three-question framework", "text": "<strong>1. Am I on track?</strong> A simple yes or no, with context. <strong>2. What needs to change?</strong> Specific, actionable — savings rate, retirement date, spending in retirement. <strong>3. What are my risks?</strong> The scenarios that could derail the plan — longevity, poor returns, unexpected health costs — and how to mitigate them." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "At 3% annual inflation, approximately what does $1 of purchasing power today become in 20 years?", "options": ["About $0.55", "About $0.75", "About $0.90", "About $0.85"], "correct": 0, "explanation": "At 3% inflation, purchasing power erodes to approximately $0.55 over 20 years. Plans that ignore inflation significantly underestimate retirement income needs." },
      { "id": "q2", "text": "What is the primary advantage of delaying Social Security claiming to age 70?", "options": ["Delayed retirement credits add 8% per year after full retirement age, resulting in the maximum possible monthly benefit", "The benefit becomes tax-free after age 70", "Medicare coverage begins automatically at 70 regardless of enrollment", "The benefit increases with inflation only after age 70"], "correct": 0, "explanation": "Delayed retirement credits increase the benefit by 8% per year from full retirement age to age 70. For clients in good health, this can be highly valuable." },
      { "id": "q3", "text": "When does a Traditional 401(k) require minimum distributions to begin?", "options": ["Age 73", "Age 70½", "Age 65", "Age 59½"], "correct": 0, "explanation": "The SECURE 2.0 Act moved the RMD starting age to 73. Failure to take RMDs results in a 25% excise tax on the amount not withdrawn." },
      { "id": "q4", "text": "In a retirement scenario, what is the purpose of documenting assumptions?", "options": ["To make the analysis defensible, transparent, and adjustable as circumstances change", "To satisfy regulatory requirements for retirement projections", "To show clients the complexity of the modeling process", "To set a legally binding expectation of future portfolio performance"], "correct": 0, "explanation": "Documented assumptions make the scenario auditable, allow for sensitivity analysis, and set appropriate client expectations about uncertainty." },
      { "id": "q5", "text": "A client is 30 years old with low current income but expects to be in a high tax bracket at retirement. Which account type is generally preferred?", "options": ["Roth, because tax rates are low now and withdrawals will be tax-free when they are likely higher", "Traditional, because the current deduction is more valuable at high income", "SEP-IRA, which provides the highest contribution limits", "Taxable brokerage account for maximum flexibility"], "correct": 0, "explanation": "Roth accounts are advantageous when current tax rates are lower than expected future rates. Paying tax on contributions now avoids taxes on a much larger balance later." },
      { "id": "q6", "text": "What is the break-even age range for delayed vs. early Social Security claiming?", "options": ["Approximately age 78-82, when cumulative delayed benefits catch up to cumulative early benefits", "Age 70, when delayed credits stop accruing", "Age 75, the median life expectancy for retirees", "Age 85, accounting for inflation adjustments"], "correct": 0, "explanation": "The break-even age is typically 78-82 depending on the specific early vs. delayed benefit amounts. Clients who expect to live past break-even generally benefit from delaying." },
      { "id": "q7", "text": "In a sensitivity analysis for retirement planning, which variable typically has the largest impact on portfolio depletion risk?", "options": ["Retirement age — retiring earlier dramatically increases portfolio drawdown years and reduces accumulation time", "Portfolio management fees", "Social Security claiming age", "The choice between Traditional and Roth accounts"], "correct": 0, "explanation": "Each year of earlier retirement both reduces the accumulation period and extends the drawdown period. The compounded impact on portfolio sustainability is significant." },
      { "id": "q8", "text": "What are the three questions clients most want answered in a retirement planning presentation?", "options": ["Am I on track? What do I need to change? What are my risks?", "What is my expected return? How should I invest? When will my money run out?", "What is my Social Security benefit? What is my RMD? What is my account balance?", "How much do I need to save? What is the inflation rate? What is my tax bracket?"], "correct": 0, "explanation": "These three questions capture the client's actual concern: current status, required action, and risk exposure. Structuring the presentation around them makes it actionable." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 4;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Estate Planning Belongs in Every Financial Plan",
      "summary": "Estate planning is not just for the wealthy. Every client needs a minimum set of documents.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Estate planning is the part of financial planning that most clients avoid until it is too late. The consequences of dying without a plan — dying intestate — include assets distributed according to state law rather than the client's wishes, delays and costs of probate, potential family conflict, and minor children left in the care of someone the client would not have chosen." },
        { "type": "callout", "kind": "key", "title": "The minimum every client needs", "text": "Regardless of net worth: (1) A will or trust. (2) A durable power of attorney. (3) A healthcare directive. (4) Current beneficiary designations on all accounts. These four documents solve the majority of estate planning problems at any wealth level." },
        { "type": "heading", "text": "The consequences of dying without a plan" },
        { "type": "list", "items": [
          "Assets distributed by state intestacy laws, which may not match client wishes",
          "Probate process: public, time-consuming, expensive (3-7% of estate value in some states)",
          "Minor children placed with whoever the court appoints, not necessarily the client's preference",
          "No one with legal authority to manage finances if the client becomes incapacitated",
          "No healthcare decision-maker if the client cannot speak for themselves"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Core Estate Planning Documents",
      "summary": "Know what each document does, when it is used, and how to explain it in plain language.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The financial advisor does not draft estate planning documents — that is the attorney's role. But the advisor must understand each document well enough to identify gaps in the client's estate plan and make appropriate referrals." },
        { "type": "glossary", "terms": [
          { "term": "Will (Last Will and Testament)", "definition": "Specifies how assets are to be distributed after death and who manages the process (executor). Must go through probate. Does not control accounts with beneficiary designations." },
          { "term": "Revocable Living Trust", "definition": "Holds assets during life and distributes them after death without probate. The grantor retains full control during their lifetime. Effective for privacy, probate avoidance, and multi-state property." },
          { "term": "Durable Power of Attorney", "definition": "Authorizes a named agent to manage financial affairs if the principal becomes incapacitated. 'Durable' means it remains effective after incapacity." },
          { "term": "Healthcare Directive (Living Will / Healthcare POA)", "definition": "Specifies medical treatment preferences and names a healthcare agent to make decisions if the client cannot. Two documents in one: a living will (treatment preferences) and a healthcare proxy (decision-maker)." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The most expensive estate planning mistake", "text": "Having a will but not funding the trust. Many clients pay for a revocable living trust but never transfer assets into it. At death, the assets that were not transferred go through probate anyway — defeating the entire purpose. Your role is to check that the trust is funded." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Beneficiary Designations — The Most Important Form",
      "summary": "A beneficiary designation overrides the will. Most clients don't know this.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Beneficiary designations control the distribution of retirement accounts, life insurance policies, and certain bank accounts regardless of what the will says. This is the most commonly misunderstood aspect of estate planning. A client whose will leaves everything to their current spouse but whose IRA still names their ex-spouse as beneficiary will have their IRA go to the ex-spouse." },
        { "type": "callout", "kind": "key", "title": "The beneficiary hierarchy", "text": "Every account with a beneficiary designation needs: (1) a primary beneficiary (who gets the money first), and (2) a contingent beneficiary (who gets it if the primary beneficiary predeceases the account holder). If no contingent beneficiary is named and the primary beneficiary dies first, the account may pass through the estate and into probate." },
        { "type": "activity", "title": "Beneficiary Designation Audit", "prompt": "Conduct a beneficiary designation audit for a hypothetical client.", "steps": [
          "List every account type the client might have: 401(k), IRA, Roth IRA, life insurance, bank accounts with POD.",
          "For each account, identify who should be named as primary and contingent beneficiary.",
          "Identify the three situations that commonly require beneficiary updates: marriage, divorce, death of a beneficiary.",
          "Draft a one-paragraph explanation of why beneficiary designations override the will, in plain language suitable for a client.",
          "What would you say to a client who is reluctant to name a contingent beneficiary?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Working with Estate Planning Attorneys",
      "summary": "Your role is coordination and information gathering, not legal advice.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The financial advisor and the estate planning attorney serve different functions but need the same information. The advisor coordinates the financial picture; the attorney creates the legal documents. The handoff between them is where estate plans most often fall through the cracks." },
        { "type": "callout", "kind": "do", "title": "What to gather before the attorney referral", "text": "Net worth statement showing all assets and their ownership structure. Beneficiary designations on all accounts. Goals for asset distribution. Names and ages of heirs. Any specific concerns: a child with special needs, a blended family, a business interest. Bringing this to the attorney meeting saves time and produces better documents." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Legacy Goals Beyond the Documents",
      "summary": "Estate planning is also about values, stories, and intentions — not just legal structures.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The legal documents handle the mechanics of wealth transfer. But many clients have legacy goals that go beyond who gets the money: passing down values, funding a cause they care about, ensuring a family business continues, supporting a community institution. These goals belong in the financial plan." },
        { "type": "callout", "kind": "key", "title": "The legacy conversation starter", "text": "'Beyond the financial accounts and legal documents, what do you most want to leave behind — what values, what opportunities, what impact?' This question often opens conversations that no amount of document review would reveal." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What does dying intestate mean?", "options": ["Dying without a valid will, resulting in asset distribution according to state law", "Dying with a will that has not been probated", "Dying with assets solely held in a trust", "Dying with outstanding debts that exceed assets"], "correct": 0, "explanation": "Intestate means without a will. State intestacy laws determine who receives assets, which may not reflect the client's wishes." },
      { "id": "q2", "text": "Which document authorizes someone to manage a client's financial affairs if they become incapacitated?", "options": ["Durable power of attorney", "Healthcare directive", "Revocable living trust", "Beneficiary designation form"], "correct": 0, "explanation": "The durable power of attorney authorizes a named agent to manage financial affairs. 'Durable' means it remains effective even after the principal becomes incapacitated." },
      { "id": "q3", "text": "A client has a will leaving everything to their current spouse. Their IRA still names their ex-spouse as beneficiary. Who receives the IRA at death?", "options": ["The ex-spouse, because beneficiary designations override the will", "The current spouse, because the will supersedes beneficiary designations", "The estate, which then distributes per the will", "It depends on state law"], "correct": 0, "explanation": "Beneficiary designations control retirement accounts and insurance regardless of the will. This is the most commonly misunderstood aspect of estate distribution." },
      { "id": "q4", "text": "What is the primary advantage of a revocable living trust over a will?", "options": ["Assets in the trust avoid probate, reducing cost, time, and public disclosure", "It provides asset protection from creditors during the client's lifetime", "It eliminates estate taxes for large estates", "It is less expensive to create than a will"], "correct": 0, "explanation": "The key advantage of a living trust is probate avoidance: faster distribution, lower costs, and privacy. It does not provide asset protection during life." },
      { "id": "q5", "text": "What is the most common error clients make with revocable living trusts?", "options": ["Creating the trust but not transferring assets into it, so those assets still pass through probate", "Naming the wrong trustee", "Failing to include a pour-over will", "Making the trust irrevocable when it should be revocable"], "correct": 0, "explanation": "An unfunded trust is nearly useless. Assets must be formally transferred into the trust for it to control their distribution. Many clients pay for a trust and never fund it." },
      { "id": "q6", "text": "Why is naming a contingent beneficiary important?", "options": ["If the primary beneficiary dies before the account holder, the contingent beneficiary receives the assets — without one, the account may go through probate", "Contingent beneficiaries receive the assets simultaneously with the primary beneficiary", "Contingent beneficiaries are required by law for retirement accounts", "The contingent beneficiary receives the assets only if specifically requested"], "correct": 0, "explanation": "If the primary beneficiary predeceases the account holder and no contingent is named, the account passes to the estate and through probate — often not the intended result." },
      { "id": "q7", "text": "Before referring a client to an estate planning attorney, what information should the financial advisor gather?", "options": ["Net worth statement, beneficiary designations, asset ownership structures, distribution goals, and specific family concerns", "The attorney's billing rate and scope of services", "A list of the client's outstanding debts", "The client's annual income and tax bracket"], "correct": 0, "explanation": "Organized financial information makes the attorney engagement more efficient and produces better documents. The advisor coordinates the financial picture before legal work begins." },
      { "id": "q8", "text": "What does 'funding the trust' mean in estate planning?", "options": ["Transferring ownership of assets — bank accounts, investments, real property — into the trust so it controls their distribution", "Making a financial contribution to establish the trust", "Naming beneficiaries in the trust document", "Paying the attorney fees to draft the trust"], "correct": 0, "explanation": "A trust only controls assets that have been legally transferred into it. Funding is the administrative step that most clients overlook after the documents are signed." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 5;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Purpose of a Planning Summary",
      "summary": "A planning summary is a decision document, not a report card. Know the difference.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The planning summary is the deliverable that translates months of discovery, analysis, and scenario modeling into something the client can read, understand, and act on. It is not a comprehensive documentation of everything the advisor did. It is the answer to the client's implicit question: 'What should I do?'" },
        { "type": "callout", "kind": "key", "title": "Lead with conclusions", "text": "Every planning summary should answer the three key questions on page one: Are you on track? What are the most important things to change? What should happen next? If the client reads only the first page, they should know what to do. Everything else is supporting evidence." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Structure of a Planning Summary",
      "summary": "The structure determines whether clients read it. Most planning documents are organized wrong.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The traditional financial plan is organized like an academic paper: background, methodology, analysis, then conclusions. Clients read in the opposite order — they want conclusions first, then the evidence. Structure your planning summary accordingly." },
        { "type": "numbered", "items": [
          "<strong>Executive summary</strong> — 3-5 sentences. Current situation, most important findings, recommended priorities.",
          "<strong>Your financial snapshot</strong> — one-page net worth and cash flow summary. The scoreboard.",
          "<strong>Key findings by area</strong> — retirement, protection, tax, estate, each in 1-2 paragraphs.",
          "<strong>Recommendations</strong> — specific, prioritized, actionable. Not 'consider increasing savings' but 'increase 401(k) contribution to 12% by January.'",
          "<strong>Next steps and timeline</strong> — who does what by when. Both advisor and client responsibilities."
        ]},
        { "type": "callout", "kind": "do", "title": "The one-page test", "text": "If you cannot summarize the most important points of the plan on one page, you have not thought about it clearly enough. The one-page summary is not a shortcut — it is the hardest thing to write. It forces clarity." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Writing for Clients, Not Advisors",
      "summary": "Every sentence should be understandable to someone who did not go to financial planning school.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial planning has its own vocabulary: asset allocation, basis points, tax-loss harvesting, required minimum distributions, sequence-of-returns risk. Advisors use these terms automatically. Clients encounter them and stop reading." },
        { "type": "activity", "title": "Plain Language Rewrite Exercise", "prompt": "Rewrite each of the following advisor-language sentences in plain client language.", "steps": [
          "'We recommend a tactical reallocation toward fixed income given elevated equity valuations.' → Write the same recommendation in one clear sentence a client can understand.",
          "'Your current savings rate is insufficient to fund your retirement income need at your target retirement date.' → What does this actually mean, and how would you say it?",
          "'Your estate planning documents do not reflect your current family structure and asset ownership.' → Translate.",
          "'Your disability insurance has an any-occupation definition with a 90-day elimination period.' → Plain English?",
          "Read each rewrite aloud. If it sounds like a human talking, it passes the test."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Visual Communication in Planning Materials",
      "summary": "The right chart makes a complex point instantly. The wrong chart makes a simple point confusing.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "One well-designed chart can communicate what two pages of text cannot. But poorly designed charts — too complex, wrong format, unlabeled axes — obscure rather than clarify. Use visuals intentionally." },
        { "type": "list", "items": [
          "<strong>Net worth over time</strong> — line chart. Shows trajectory clearly.",
          "<strong>Asset allocation</strong> — pie chart (one of the few appropriate uses). Simple and intuitive.",
          "<strong>Retirement income sources</strong> — stacked bar. Shows Social Security, pension, portfolio withdrawal proportions.",
          "<strong>Goal funding status</strong> — progress bars. Immediately legible at a glance.",
          "<strong>Scenario comparison</strong> — side-by-side table. Retire at 62 vs. 65 vs. 67."
        ]},
        { "type": "callout", "kind": "warn", "title": "The complexity trap", "text": "Charts with more than 5 data points, multiple axes, or dense annotation confuse clients. If you need a legend to explain a chart, simplify it. The goal is insight, not comprehensiveness." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Compliance Review and Final Check",
      "summary": "Materials that reach clients without a final review create compliance risk and damage trust.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every piece of client-facing material must be reviewed for accuracy, compliance language, and consistency before delivery. A single error in a planning summary — a wrong account balance, an incorrect projection, an inappropriate guarantee — can create a compliance issue and destroy client confidence." },
        { "type": "list", "items": [
          "All numbers verified against source documents",
          "No specific return promises or guarantees",
          "Required disclosures included",
          "Consistent figures throughout (net worth on page 2 matches page 5)",
          "Client name spelled correctly on every page",
          "All recommendations tied to client's stated goals"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "How should a planning summary be structured for maximum client impact?", "options": ["Conclusions and recommendations first, with supporting analysis following", "Background and methodology first, then analysis, then conclusions", "Analysis first, recommendations last, with conclusions in the appendix", "Alphabetically by planning topic for easy reference"], "correct": 0, "explanation": "Clients want conclusions first. Leading with 'are you on track, what needs to change, what happens next' ensures the most important information is seen even if the client doesn't read the full document." },
      { "id": "q2", "text": "What is the 'one-page test' for a planning summary?", "options": ["If you cannot summarize the most important points on one page, the thinking is not clear enough yet", "Planning summaries must legally fit on one page for compliance", "Clients only read the first page, so all information must be there", "One page is the industry standard length for financial planning documents"], "correct": 0, "explanation": "The one-page summary test is a clarity standard. If you can't summarize the key points concisely, it signals that the analysis needs more focus and prioritization." },
      { "id": "q3", "text": "Which chart type is most appropriate for showing a client's asset allocation?", "options": ["Pie chart — simple, intuitive, immediately legible for proportional data", "Line chart — shows change over time", "Scatter plot — shows correlation between variables", "Histogram — shows distribution of values"], "correct": 0, "explanation": "Pie charts work well for proportional data where the parts of a whole need to be visualized. Asset allocation — 60% equity, 30% fixed income, 10% cash — is a classic use case." },
      { "id": "q4", "text": "Why is plain language critical in client-facing planning materials?", "options": ["Technical jargon causes clients to stop reading, which means recommendations are never understood or acted on", "Plain language is required by SEC regulations for investment advisors", "Technical language implies the advisor lacks expertise", "Client-facing materials must be understandable to non-English speakers"], "correct": 0, "explanation": "If clients don't understand the plan, they can't follow it. Jargon is a barrier to the action the plan is designed to produce." },
      { "id": "q5", "text": "What should a planning summary's 'next steps' section include?", "options": ["Specific actions, responsible parties (advisor and client), and deadlines", "A general description of the planning process going forward", "A list of all planning topics that were covered in the analysis", "Contact information for the advisor and firm"], "correct": 0, "explanation": "Next steps must be specific and assigned. 'Increase 401(k) contribution to 12% by January 1' is actionable. 'Consider increasing retirement savings' is not." },
      { "id": "q6", "text": "When reviewing planning materials before client delivery, what must be verified?", "options": ["All numbers against source documents, no guarantees, required disclosures, consistency throughout, correct client name", "The advisor's signature and firm letterhead are included", "The document is under 20 pages", "All charts use the firm's brand colors"], "correct": 0, "explanation": "Accuracy, compliance language, and consistency are the critical checks. A single number error or inappropriate guarantee in a client document creates both compliance and trust risk." },
      { "id": "q7", "text": "What is wrong with a planning recommendation that says 'consider increasing savings'?", "options": ["It is not specific enough to act on — a good recommendation names the account, the amount, and the timeline", "It implies the client is not saving enough, which may offend them", "It does not reference the client's specific goal", "It is not technically a financial planning recommendation"], "correct": 0, "explanation": "Vague recommendations produce no action. 'Increase 401(k) contribution from 6% to 10% beginning with the January payroll cycle' is actionable." },
      { "id": "q8", "text": "What does a chart with more than 5 data points and a legend most likely indicate?", "options": ["The chart is too complex and should be simplified for client communication", "The advisor has done thorough analysis worth documenting", "The chart meets the standard for financial planning exhibits", "Additional data points improve client understanding"], "correct": 0, "explanation": "Complexity in a chart means the message is unclear. Client-facing visuals should communicate a single insight immediately. If a legend is needed, the chart should be redesigned." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 6;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why CRM Accuracy Is a Professional Standard",
      "summary": "The CRM is the institutional memory of the practice. Accurate records protect clients, protect advisors, and enable great service.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A CRM entry that is missing, inaccurate, or incomplete is not just an operational inconvenience. It creates client service failures when the wrong person is called. It creates compliance exposure when interactions are undocumented. It creates business risk when institutional knowledge lives only in one person's head." },
        { "type": "callout", "kind": "key", "title": "Your personal responsibility", "text": "CRM accuracy is not the firm's responsibility to manage after the fact. It is every team member's responsibility to maintain in real time. If you have an interaction with a client and don't log it, it didn't happen — professionally and legally." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "What Goes in the CRM",
      "summary": "Every client record has required fields. Every interaction has a documentation standard.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The CRM client profile is the authoritative record of who the client is and how the relationship is managed. It contains static information (demographics, accounts, family), dynamic information (recent interactions, open tasks, life events), and compliance information (signed documents, disclosures)." },
        { "type": "glossary", "terms": [
          { "term": "Client profile", "definition": "Core demographic and contact information: name, address, phone, email, date of birth, SSN (encrypted), employment, marital status, dependents." },
          { "term": "Account records", "definition": "All accounts linked to the client: account numbers, custodian, account type, ownership, beneficiaries." },
          { "term": "Interaction log", "definition": "A dated record of every client contact: call, email, meeting, text. Includes summary of topics discussed, decisions made, and action items." },
          { "term": "Task list", "definition": "Open items with assigned responsibility and deadline. The mechanism that ensures nothing falls through the cracks." }
        ]},
        { "type": "callout", "kind": "do", "title": "The 24-hour rule", "text": "Log every client interaction within 24 hours. After 24 hours, memory degrades and details are lost. After a week, you are fabricating the record. Compliance requires accurate records, not good-faith approximations." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Logging Client Interactions",
      "summary": "What to capture, how much detail, and how quickly.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "An interaction log entry should be complete enough that someone who was not present could understand what happened and what comes next. This is the compliance standard and the service standard simultaneously." },
        { "type": "list", "items": [
          "<strong>Date and duration</strong> — when, how long",
          "<strong>Type of interaction</strong> — phone call, in-person meeting, email, text",
          "<strong>Attendees</strong> — who was present on both sides",
          "<strong>Topics discussed</strong> — the substance of the conversation, not just 'spoke with client'",
          "<strong>Decisions made</strong> — any commitments, approvals, or changes agreed to",
          "<strong>Action items</strong> — who does what by when, assigned to advisor or client"
        ]},
        { "type": "case_study", "title": "What Good Documentation Looks Like", "scenario": "After a 30-minute phone call with a client who wants to increase their 401(k) contribution and asked about converting their IRA to Roth, what does the interaction log entry look like?", "discussion": "Date: [today], Type: Phone call, Duration: 30 min. Topics: (1) Client requested 401(k) contribution increase from 6% to 10%, effective next payroll cycle. (2) Client inquired about Roth IRA conversion — concerned about tax impact. Action items: Advisor to confirm 401(k) change with payroll (by [date]). Advisor to model Roth conversion scenario for 2026 (by [date]). Client to gather prior year tax return for conversion analysis." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Maintaining Data Accuracy",
      "summary": "Records decay. Build the habits that keep the CRM current.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client data changes constantly: new phone numbers, new employers, new accounts, new family members, beneficiary changes. An address that was current 18 months ago may not be current today. A CRM with stale data fails the clients it is supposed to serve." },
        { "type": "callout", "kind": "do", "title": "The annual data review", "text": "Once per year, review every field in each client profile and confirm it is current. The annual review meeting is a natural trigger. Ask: 'Has your contact information, employer, or family situation changed in the past year?' Update immediately." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "CRM as a Practice Management Tool",
      "summary": "A well-used CRM does more than store information — it drives the entire service delivery system.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The CRM is the engine of a well-run advisory practice. Used to its full potential, it generates follow-up workflows, triggers review meetings, manages birthday and anniversary outreach, tracks task completion, and provides management reporting. Most teams use 20% of the capability." },
        { "type": "callout", "kind": "key", "title": "Automation that works", "text": "The highest-value CRM automations: (1) Automatic task creation after a meeting log entry. (2) Annual review scheduling triggers tied to client anniversary dates. (3) Birthday and milestone outreach. (4) Follow-up reminders for outstanding client actions. These run without manual effort and ensure nothing falls through the cracks." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the professional standard for logging a client interaction in the CRM?", "options": ["Within 24 hours of the interaction", "Before the end of the business week", "At the next scheduled team meeting", "Within 48 hours if detailed notes are required"], "correct": 0, "explanation": "24 hours is the standard. After that, memory degrades and the accuracy of the record cannot be assured. Compliance requires accurate records, not reconstructed ones." },
      { "id": "q2", "text": "An interaction log entry for a 30-minute client phone call should include which of the following?", "options": ["Date, type, attendees, topics discussed, decisions made, and action items with deadlines", "A brief note that contact occurred and the client is satisfied", "The full transcript of the conversation", "Only information that affects investment recommendations"], "correct": 0, "explanation": "Complete interaction logs allow any team member to understand the relationship history and serve clients effectively. They also satisfy compliance documentation requirements." },
      { "id": "q3", "text": "Why is CRM data accuracy considered a personal professional responsibility, not just a firm IT issue?", "options": ["Every team member generates client interactions that must be documented; inaccurate records create compliance exposure and service failures", "The firm charges back CRM errors to individual team members", "Regulatory examiners review individual employee CRM entries during examinations", "CRM accuracy is tied to performance reviews at most firms"], "correct": 0, "explanation": "Inaccurate CRM records are created by individuals failing to log interactions or update information. The responsibility to maintain accuracy belongs to the people who generate the activity." },
      { "id": "q4", "text": "Which of the following is the best example of an action item in an interaction log?", "options": ["'Advisor to model Roth conversion scenario by March 15'", "'Discuss Roth conversion further'", "'Client interested in Roth'", "'Roth conversion — follow up'"], "correct": 0, "explanation": "Action items must be specific: who, what, and by when. Vague entries like 'follow up' do not create accountability and result in missed commitments." },
      { "id": "q5", "text": "When should client profile information be reviewed and updated?", "options": ["At minimum annually, with immediate updates whenever the advisor learns of a life change", "Only when the client requests a change", "During compliance examinations", "Every three years as part of the planning review cycle"], "correct": 0, "explanation": "Annual reviews catch systematic drift. Immediate updates for known life changes (marriage, divorce, new address, new employer) ensure the record is current when it matters." },
      { "id": "q6", "text": "What is the highest-value CRM automation for a financial advisory practice?", "options": ["Automatic task creation after meeting logs and annual review scheduling triggers tied to client anniversary dates", "Automatic generation of investment recommendations based on account performance", "Automated email responses to all client inquiries", "Automatic account rebalancing notifications"], "correct": 0, "explanation": "Meeting follow-up tasks and review scheduling automations ensure consistent service delivery without manual effort. They operationalize the service model." },
      { "id": "q7", "text": "What does a CRM 'task list' accomplish in client service?", "options": ["Tracks open action items with assigned responsibility and deadlines, ensuring commitments are fulfilled", "Generates automated reminders for investment trades", "Documents the client's financial goals for planning purposes", "Records compliance-required disclosures for each client"], "correct": 0, "explanation": "The task list is the mechanism for following through on commitments. Without it, action items discussed in meetings are frequently forgotten or delayed." },
      { "id": "q8", "text": "A colleague asks you to complete a CRM entry for a client interaction they had yesterday but didn't log. What is the appropriate response?", "options": ["Decline — only the person who had the interaction can accurately document what was discussed and decided", "Complete the entry based on the colleague's verbal summary", "Create a placeholder entry noting the interaction occurred", "Note the interaction in the client file rather than the CRM"], "correct": 0, "explanation": "CRM entries require firsthand knowledge of what occurred. An entry based on a second-hand account is unreliable and potentially inaccurate. The person who had the interaction must complete the documentation." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 7;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Apprentice's Role in Client Meetings",
      "summary": "Your first client meetings are learning opportunities. Know what is expected of you before you walk in the door.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "As an apprentice observing and supporting client meetings, your role has three components: preparation, professional presence, and documentation. You are not there to contribute your opinions. You are there to learn how skilled advisors manage relationships, to support the meeting logistics, and to capture what happens accurately." },
        { "type": "callout", "kind": "key", "title": "The three rules for meeting presence", "text": "1. Be prepared — know the client before you walk in. 2. Be present — phone away, eyes on the conversation. 3. Be useful — take thorough notes, manage the logistics, follow through on action items." },
        { "type": "heading", "text": "What the advisor expects from support staff in a meeting" },
        { "type": "list", "items": [
          "Accurate, complete notes of what was discussed, decided, and committed to",
          "Professional presentation: appropriate dress, no distractions, confidential conduct",
          "Logistics management: materials ready, room set, technology working",
          "Active listening: noting client concerns and questions to surface in follow-up",
          "CRM entry within 24 hours of the meeting"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Meeting Preparation",
      "summary": "Great meetings are made before they start. Here's what to do before every client meeting.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The advisor who walks into a client meeting unprepared is not just inefficient — they are telling the client that the relationship is not a priority. Every client meeting, regardless of how routine, requires preparation." },
        { "type": "heading", "text": "The pre-meeting brief" },
        { "type": "list", "items": [
          "<strong>Account summary</strong> — current balances, recent performance, any significant changes since the last meeting",
          "<strong>Action items from the last meeting</strong> — what was committed to by the advisor, status of each",
          "<strong>What the client cares about</strong> — recent life events, known concerns from the CRM, questions from the last interaction",
          "<strong>Agenda for today</strong> — what the meeting is designed to accomplish",
          "<strong>Materials check</strong> — performance report, planning updates, any documents requiring signature"
        ]},
        { "type": "callout", "kind": "do", "title": "Prepare the advisor, not just yourself", "text": "Your job before a client meeting is not just to know the client yourself — it is to make sure the advisor walks in fully briefed. A one-page pre-meeting summary for the advisor, delivered 30 minutes before the meeting, is one of the most valuable things a support associate can do." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Taking Notes That Are Actually Useful",
      "summary": "Meeting notes are only valuable if they capture what matters. Learn the difference.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Many new professionals take notes that are comprehensive but useless: they capture everything said without distinguishing what matters. The goal is a record that allows any team member to understand what happened and what comes next — without reading a transcript." },
        { "type": "heading", "text": "What to capture" },
        { "type": "list", "items": [
          "<strong>Decisions</strong> — what was agreed to: a strategy change, a contribution increase, a referral request",
          "<strong>Action items</strong> — who does what by when, for both advisor and client",
          "<strong>Client concerns</strong> — anything the client expressed worry about, even if not addressed in the meeting",
          "<strong>Follow-up questions</strong> — things that came up and were deferred for further research"
        ]},
        { "type": "heading", "text": "What not to capture" },
        { "type": "list", "items": [
          "Verbatim quotes unless they are highly significant",
          "Background information the team already knows from the CRM",
          "Every pleasantry and conversational detour",
          "Information the advisor shared that was purely educational"
        ]},
        { "type": "activity", "title": "Meeting Notes Practice", "prompt": "Read the following meeting scenario and write the interaction log entry.", "steps": [
          "Scenario: 45-minute annual review with a married couple. Performance was discussed — portfolio up 8.2% versus benchmark of 7.5%. Client asked about adding a vacation property. Wife mentioned she may retire earlier than planned (60 vs. 65). Advisor recommended increasing savings rate and said he would model the earlier retirement scenario. Client needs to provide updated insurance policy by next meeting.",
          "Write the CRM interaction log entry covering: key topics, decisions, and action items.",
          "What would you flag for the advisor's attention that might require follow-up beyond the stated action items?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "What to Watch for in Client Meetings",
      "summary": "The most valuable learning from observing meetings is watching how skilled advisors read and respond to clients.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Attending client meetings as an observer is one of the richest learning opportunities in the apprenticeship. But only if you know what to watch for. Focus less on the content of what is said — you will read about that in your modules — and more on how the advisor manages the relationship." },
        { "type": "list", "items": [
          "How does the advisor open the meeting and set the agenda?",
          "When a client expresses concern, how does the advisor acknowledge it before moving to a solution?",
          "How does the advisor handle disagreement between spouses?",
          "What does the advisor do when a client asks a question they cannot immediately answer?",
          "How does the advisor close the meeting: summarizing, confirming action items, setting the next appointment?"
        ]},
        { "type": "callout", "kind": "key", "title": "After every meeting you observe", "text": "Write down one thing the advisor did well that you want to adopt. Write down one question you have about a decision they made. Bring these to your next check-in with the advisor. The reflection habit turns observation into learning." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Post-Meeting Follow-Through",
      "summary": "What happens after the meeting determines whether the meeting was worth having.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The follow-through after a client meeting is where the advisor's reliability is established. Clients remember whether you did what you said you would do. Missing a commitment or delivering it late damages trust more than most advisors realize." },
        { "type": "callout", "kind": "do", "title": "The follow-up email standard", "text": "Send within 24 hours. Include: (1) a brief thank-you for the client's time, (2) a summary of what was discussed, (3) what the advisor will do and by when, (4) what the client needs to do and by when, (5) date of the next meeting if scheduled. Keep it under 200 words. Professional and personal, not formal and generic." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the primary role of an apprentice observing a client meeting?", "options": ["Preparation, professional presence, and documentation — not contributing opinions or advice", "Introducing the firm's products and services when appropriate", "Answering technical questions the advisor cannot address", "Managing the client relationship while the advisor focuses on analysis"], "correct": 0, "explanation": "Apprentices in client meetings learn by observing and support by documenting. Contributing advice without authorization is inappropriate and potentially a compliance issue." },
      { "id": "q2", "text": "How long before a client meeting should the advisor receive the pre-meeting brief?", "options": ["30 minutes before the meeting", "The morning of the meeting", "The day before the meeting", "At the start of the meeting"], "correct": 0, "explanation": "30 minutes gives the advisor time to review and internalize the brief without being too far in advance to remember the details." },
      { "id": "q3", "text": "Which of the following belongs in a meeting interaction log entry?", "options": ["Decisions made, action items with deadlines, and client concerns raised", "A verbatim transcript of the client conversation", "Background information already documented in the client's CRM profile", "The advisor's personal assessment of the client's financial sophistication"], "correct": 0, "explanation": "Interaction logs capture what happened and what comes next — decisions, commitments, and concerns. Verbatim transcripts and background information are not necessary." },
      { "id": "q4", "text": "When observing a client meeting, what should an apprentice primarily focus on learning?", "options": ["How the advisor manages the relationship: opens meetings, handles concerns, manages conflict, closes with action items", "The specific investment products the advisor recommends", "The technical financial analysis the advisor presents", "How the firm's compliance policies are applied in client conversations"], "correct": 0, "explanation": "Technical knowledge comes from coursework and self-study. Observing meetings is the opportunity to learn the relationship management skills that cannot be read in a textbook." },
      { "id": "q5", "text": "What should a client follow-up email include?", "options": ["Thank-you, summary of topics, advisor action items with deadlines, client action items with deadlines, and next meeting date", "A full recap of all financial recommendations made during the meeting", "The performance report and all planning documents discussed", "Only the action items that require the client's participation"], "correct": 0, "explanation": "The follow-up email confirms shared understanding, documents commitments, and creates a reference for both parties. All five elements are important." },
      { "id": "q6", "text": "After observing a client meeting, what should an apprentice do to maximize learning?", "options": ["Write down one thing the advisor did well and one question about a decision they made, then discuss with the advisor", "Write a detailed report of the entire meeting for the client file", "Review the client's account statements to understand the context", "Ask the client for feedback on the meeting quality"], "correct": 0, "explanation": "Structured reflection after observation accelerates learning. Identifying specific techniques to adopt and specific questions to discuss converts passive observation to active development." },
      { "id": "q7", "text": "A client asks a question during the meeting that the advisor cannot immediately answer. What should the advisor do?", "options": ["Acknowledge the question, commit to a specific response by a specific date, and document it as an action item", "Provide a best estimate and follow up only if the estimate was wrong", "Defer the question to the compliance department", "Suggest the client research the answer independently"], "correct": 0, "explanation": "Admitting uncertainty and committing to a specific follow-up is far more trustworthy than guessing. Clients respect advisors who know their limits." },
      { "id": "q8", "text": "Why does missing a commitment to a client damage trust more than many advisors expect?", "options": ["Clients rely on follow-through as the primary evidence that the advisor is trustworthy and attentive to their interests", "Missing commitments triggers regulatory reporting requirements", "Clients typically fire advisors immediately after a missed commitment", "The financial planning literature identifies missed commitments as the leading cause of client dissatisfaction"], "correct": 0, "explanation": "Trust in an advisory relationship is built through consistent reliability. A missed commitment — however small — signals that the client is not the priority, which undermines the entire relationship." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 8;


-- ── PART 3: Lesson content modules 9-16 ──
-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 9–16
-- Aligned to GIC Work Process titles and practical on-the-job tasks.
-- ============================================================================

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Understanding Risk — Three Numbers, Not One",
      "summary": "Suitability depends on three distinct risk concepts. Confusing them is the most common error in risk assessment.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client has three different 'risk numbers,' and they rarely align perfectly. The advisor's job is to understand all three, surface the conflicts, and make a defensible suitability determination that serves the client's actual situation — not just what they said they want." },
        { "type": "glossary", "terms": [
          { "term": "Risk capacity", "definition": "The financial ability to absorb investment losses without jeopardizing financial goals. Determined by income, assets, time horizon, and obligations. Objective." },
          { "term": "Risk tolerance", "definition": "The psychological comfort with investment volatility and potential loss. Highly subjective. Changes with market conditions and life circumstances." },
          { "term": "Required return", "definition": "The return rate needed to achieve the client's stated goals given their savings rate and time horizon. Mathematically derived. Sets a floor for risk." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The conflict that must be resolved", "text": "A client who says 'I want to be conservative' (tolerance) but needs 8% returns to fund retirement (required return) is not actually able to be conservative. The advisor must surface this conflict and help the client make an informed choice — not simply document the stated preference and ignore the math." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Administering the Risk Questionnaire",
      "summary": "The questionnaire is a tool, not a compliance form. How you conduct it determines how useful the results are.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The risk questionnaire is the most commonly administered tool in financial services and the most commonly misused. When administered as a form-filling exercise, it produces compliance documentation. When administered as a structured conversation, it produces genuine insight into how a client thinks about risk." },
        { "type": "heading", "text": "How to administer the questionnaire effectively" },
        { "type": "numbered", "items": [
          "Explain the purpose: 'This helps us understand how you think about investment risk so we can build a portfolio that fits you — not just your financial situation, but your comfort level.'",
          "Read each question aloud rather than handing the form to the client.",
          "Ask follow-up questions when answers seem inconsistent or extreme: 'You said you'd be comfortable with a 30% drop — can you tell me what that would feel like in practice?'",
          "Note where the client hesitates or changes their answer.",
          "Document not just the answers but your observations about the quality of the responses."
        ]},
        { "type": "callout", "kind": "warn", "title": "Red flag answers to investigate", "text": "'I've never lost money in the market' — may indicate limited investment experience. 'I don't care about risk, I just want to make money' — may not understand what risk means. 'My last advisor put me in something conservative' — may be guiding answers based on past experience rather than current reality. Each of these requires a follow-up conversation." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Interpreting Risk Results and Handling Conflicts",
      "summary": "What to do when the questionnaire result and the client's situation don't match.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The questionnaire produces a risk category — conservative, moderate, aggressive. This is the starting point, not the conclusion. The next step is comparing the questionnaire result to the client's financial situation, their goals, and their required return to identify any conflicts." },
        { "type": "case_study", "title": "The Conflict Resolution Conversation", "scenario": "A 55-year-old client with $300,000 in savings scores 'conservative' on the risk questionnaire. They want to retire at 65 with $5,000/month in income and have a $2,800/month Social Security benefit confirmed. The gap ($2,200/month) requires withdrawals of about $264,000/year from a projected portfolio — far more than conservative growth would support.", "discussion": "This is not a conservative situation. The math requires growth. The advisor must have a direct conversation: 'Based on your retirement goals and your current savings, a fully conservative portfolio is unlikely to produce the income you need. Here is what a conservative portfolio would produce — and here is the gap. We have three options: accept more investment risk, save more, or adjust the retirement goal. Which of these are you willing to explore?'" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting Suitability Determinations",
      "summary": "The documentation must stand on its own — a regulator should be able to read it and understand why the recommendation was suitable.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The suitability determination is not just a questionnaire result filed in the client folder. It is a documented professional judgment that connects the client's situation, goals, and risk profile to the investment recommendation. The documentation must show the reasoning — not just the conclusion." },
        { "type": "list", "items": [
          "Client's investment objective and time horizon",
          "Questionnaire results and risk category",
          "Any conflicts identified and how they were resolved",
          "The investment recommendation and the rationale",
          "Client's acknowledgment of the recommendation and any concerns expressed"
        ]},
        { "type": "callout", "kind": "do", "title": "The documentation test", "text": "If a regulator reads the suitability documentation three years from now, can they understand why this recommendation was suitable for this client at this time? If the answer is yes, the documentation is adequate. If it just says 'client scored moderate, recommended balanced portfolio,' the documentation is insufficient." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Ongoing Suitability and Reassessment",
      "summary": "Suitability is not a one-time event. Life changes — and the portfolio must change with it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A suitability determination is current as of the date it was made. When a client's circumstances change — job loss, inheritance, divorce, approaching retirement, health event — the suitability determination must be revisited." },
        { "type": "list", "items": [
          "Major life events: marriage, divorce, death of a spouse, birth of a child",
          "Significant financial changes: job loss, inheritance, major debt, retirement",
          "Health changes that affect life expectancy or care costs",
          "Market events that have dramatically changed portfolio value relative to goals",
          "Changes in time horizon as retirement approaches"
        ]},
        { "type": "callout", "kind": "key", "title": "The annual review as a suitability check", "text": "Every annual review meeting should include a suitability check: 'Has your financial situation, goals, or risk tolerance changed in the past year?' The answer to this question determines whether the current investment strategy remains appropriate — and must be documented." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the difference between risk capacity and risk tolerance?", "options": ["Risk capacity is the financial ability to absorb losses (objective); risk tolerance is the psychological comfort with volatility (subjective)", "Risk capacity is determined by age; risk tolerance is determined by income", "Risk capacity applies to stocks; risk tolerance applies to bonds", "They are different terms for the same concept"], "correct": 0, "explanation": "Risk capacity is objective — it's about what the financial situation can absorb. Risk tolerance is subjective — it's about what the client can emotionally handle. Both must be assessed." },
      { "id": "q2", "text": "A client scores 'conservative' on the risk questionnaire but their retirement goals require an 8% return. What should the advisor do?", "options": ["Surface the conflict and present three options: accept more risk, save more, or adjust the retirement goal", "Default to the questionnaire result and document 'conservative' strategy", "Recommend a moderate strategy as a compromise without further discussion", "Refer the client to a different advisor who specializes in conservative portfolios"], "correct": 0, "explanation": "The questionnaire result is a starting point, not the conclusion. When it conflicts with the required return, the advisor must have an honest conversation about the tradeoffs." },
      { "id": "q3", "text": "When a client says 'I've never lost money in the market' during a risk questionnaire, what is the best response?", "options": ["Ask a follow-up question to understand their investment history and whether they have experience with a significant market decline", "Accept the statement and note their conservative orientation", "Explain that all investments carry risk as a required disclosure", "Move on to the next question to avoid making the client uncomfortable"], "correct": 0, "explanation": "This statement is a red flag that may indicate limited investment experience. A follow-up question explores whether the client truly understands investment risk or has simply been fortunate." },
      { "id": "q4", "text": "What is 'required return' in the context of risk assessment?", "options": ["The return rate needed to achieve the client's goals given their current savings rate and time horizon", "The minimum return required by the client's employment contract", "The benchmark return for the client's industry sector", "The return rate needed to outperform inflation"], "correct": 0, "explanation": "Required return is mathematically derived from the client's savings, time horizon, and goals. It sets a floor below which the investment strategy cannot fall without jeopardizing the goals." },
      { "id": "q5", "text": "What must suitability documentation show beyond just the questionnaire result?", "options": ["The reasoning that connects the client's situation and risk profile to the specific investment recommendation", "The client's full financial history and account statements", "The advisor's credentials and professional background", "A comparison of the recommended strategy to all available alternatives"], "correct": 0, "explanation": "Documentation must show the reasoning, not just the conclusion. A regulator reading it should understand why this recommendation was suitable for this specific client at this specific time." },
      { "id": "q6", "text": "Which life event most clearly requires a suitability reassessment?", "options": ["A client receives a significant inheritance that doubles their investable assets", "A client changes their email address", "A client's portfolio performance exceeds its benchmark", "A client relocates to a different state"], "correct": 0, "explanation": "A significant inheritance changes risk capacity, goals, time horizon, and possibly required return — all core suitability factors. The existing strategy must be evaluated against the new situation." },
      { "id": "q7", "text": "Why should risk questionnaires be conducted as structured conversations rather than written forms?", "options": ["Conversational administration allows for follow-up questions on inconsistent or extreme answers that would be lost on a written form", "Written forms are not accepted as compliance documentation", "Clients complete written forms inaccurately when unsupervised", "Regulatory rules prohibit written risk questionnaires"], "correct": 0, "explanation": "When clients complete forms independently, hesitations, changes of mind, and inconsistencies are invisible. A structured conversation allows the advisor to observe and probe for genuine understanding." },
      { "id": "q8", "text": "At a minimum, how often should a client's suitability determination be reviewed?", "options": ["Annually at the scheduled review meeting, and additionally whenever a significant life event occurs", "Every five years as part of the planning cycle", "Only when the client requests a change", "When market conditions change significantly"], "correct": 0, "explanation": "Annual review is the minimum baseline. Life events — not market events — are the primary trigger for interim suitability reassessment." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 9;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Asset Allocation Actually Does",
      "summary": "Asset allocation is the primary driver of portfolio risk and return — more important than any individual investment selection.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A foundational study by Brinson, Hood, and Beebower found that asset allocation explains more than 90% of a portfolio's variability in return over time. Individual security selection and market timing account for the rest. This finding has been replicated many times. The implication for advisors: getting the allocation right matters far more than picking the right stocks." },
        { "type": "heading", "text": "The core asset classes" },
        { "type": "glossary", "terms": [
          { "term": "Equities (stocks)", "definition": "Ownership stakes in businesses. Historically highest long-term return among major asset classes. Also highest volatility. Appropriate for long time horizons." },
          { "term": "Fixed income (bonds)", "definition": "Loans to governments or corporations that pay interest. Lower expected return than equities, lower volatility. Income-producing. Reduces portfolio volatility when combined with equities." },
          { "term": "Cash and equivalents", "definition": "Money market, CDs, T-bills. Lowest return, zero credit risk, highest liquidity. Used for short-term needs and as a stability buffer, not for growth." },
          { "term": "Alternative investments", "definition": "Real estate, commodities, private equity, hedge funds. May provide diversification benefits but often have liquidity constraints, higher costs, and complexity." }
        ]},
        { "type": "callout", "kind": "key", "title": "The allocation decision is the most important investment decision", "text": "Whether a client is 80% in equities or 40% in equities determines more about their portfolio's behavior than any other choice. This decision must be tied directly to the suitability assessment — risk capacity, risk tolerance, time horizon, and required return — not to market opinion." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Building an Allocation Model",
      "summary": "How to move from a risk profile to a concrete allocation target.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most advisory firms use model portfolios: pre-built allocation targets for different risk categories. The process is to match the client to the appropriate model, then populate the model with specific funds or securities. Understanding how models are built helps you apply them correctly." },
        { "type": "heading", "text": "Sub-asset class diversification" },
        { "type": "list", "items": [
          "<strong>Within equities:</strong> domestic vs. international, large cap vs. small cap, growth vs. value, sector allocation",
          "<strong>Within fixed income:</strong> government vs. corporate, investment grade vs. high yield, short-term vs. long-term, nominal vs. inflation-protected",
          "<strong>Geographic diversification:</strong> developed markets vs. emerging markets"
        ]},
        { "type": "callout", "kind": "warn", "title": "Over-diversification is also a problem", "text": "Owning 47 funds does not make a portfolio more diversified if those funds hold many of the same underlying securities. True diversification means exposure to genuinely uncorrelated asset classes — not simply owning more products." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Portfolio Drift and Rebalancing",
      "summary": "Markets move. Portfolios drift from their targets. Rebalancing restores the intended risk level.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A portfolio that starts at 60% equity and 40% fixed income will drift over time as equities and bonds produce different returns. After a strong equity market, the portfolio might be 75% equity — far more risk than the client's profile supports. Rebalancing restores the target allocation." },
        { "type": "heading", "text": "The rebalancing trigger decision" },
        { "type": "list", "items": [
          "<strong>Calendar rebalancing</strong> — rebalance at fixed intervals (quarterly, annually). Simple, predictable, low cost. May miss large drifts between intervals.",
          "<strong>Threshold rebalancing</strong> — rebalance when any asset class drifts beyond a set percentage (e.g., ±5% from target). More precise, potentially more trades.",
          "<strong>Hybrid approach</strong> — review quarterly but rebalance only when a threshold is exceeded. Most common in practice."
        ]},
        { "type": "callout", "kind": "key", "title": "Tax-aware rebalancing", "text": "In taxable accounts, selling appreciated positions to rebalance triggers capital gains. Tax-aware rebalancing uses four techniques: (1) redirect new contributions to underweight asset classes, (2) use dividends and interest to rebalance, (3) rebalance within tax-advantaged accounts first, (4) harvest losses to offset gains." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Updating Allocations for Life Changes",
      "summary": "A portfolio built for a 45-year-old is wrong for the same person at 62. Allocations must evolve.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Asset allocation is not set and forgotten. As clients age, approach retirement, or experience life changes, the appropriate allocation changes. The advisor's job is to identify when an allocation update is needed and execute it thoughtfully." },
        { "type": "list", "items": [
          "<strong>Approaching retirement (5-7 years out)</strong> — begin reducing equity allocation, increase fixed income and cash for near-term income",
          "<strong>At retirement</strong> — the portfolio shifts from accumulation to distribution mode; sequence-of-returns risk becomes primary concern",
          "<strong>After a job loss</strong> — liquidity becomes more critical; may need to reduce risk temporarily",
          "<strong>After an inheritance</strong> — reassess goals, time horizon, and required return; the allocation that fit before may not fit the new situation"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Allocation Decisions to Clients",
      "summary": "The best allocation in the world doesn't work if the client abandons it during a downturn.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client behavior is the biggest risk in portfolio management. Research consistently shows that the average investor earns significantly less than the funds they invest in — because they sell during downturns and buy during run-ups. The advisor's job is to build a portfolio the client can stick with, then help them stick with it." },
        { "type": "callout", "kind": "do", "title": "Set expectations before volatility, not during it", "text": "When allocating: 'A portfolio like this has historically declined 20-25% in a bad year. That translates to about $X in your specific account. When that happens — and it will happen at some point — our plan is to [stay the course/rebalance/add to equities]. I want you to know this in advance so it doesn't feel like a crisis when it happens.'" }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Research by Brinson, Hood, and Beebower found that asset allocation explains what percentage of portfolio return variability?", "options": ["More than 90%", "About 50%", "About 70%", "About 30%"], "correct": 0, "explanation": "The landmark study found that asset allocation — not security selection or market timing — explains the majority of a portfolio's return variability over time." },
      { "id": "q2", "text": "A portfolio that started at 60% equity has grown to 75% equity after a strong market. What is required?", "options": ["Rebalancing to restore the target allocation and the intended risk level", "Increasing the client's risk profile to match the new allocation", "No action, since equity gains are always in the client's interest", "Converting the gains to cash to lock in returns"], "correct": 0, "explanation": "Drift above the equity target means the portfolio carries more risk than the client's profile supports. Rebalancing restores the intended allocation." },
      { "id": "q3", "text": "Which rebalancing approach triggers a rebalance when any asset class drifts beyond a set percentage from target?", "options": ["Threshold rebalancing", "Calendar rebalancing", "Tactical rebalancing", "Strategic rebalancing"], "correct": 0, "explanation": "Threshold rebalancing triggers a rebalance when drift exceeds a specified tolerance band (e.g., ±5%). More precise than calendar rebalancing but potentially generates more trades." },
      { "id": "q4", "text": "What is the first and most tax-efficient technique for rebalancing a taxable portfolio?", "options": ["Redirect new contributions and dividends to underweight asset classes before selling anything", "Sell overweight positions and repurchase underweight positions simultaneously", "Transfer assets to a tax-advantaged account before rebalancing", "Harvest all capital losses before making any rebalancing trades"], "correct": 0, "explanation": "Redirecting cash inflows avoids triggering taxable events while gradually restoring balance. It is the lowest-cost, most tax-efficient rebalancing technique." },
      { "id": "q5", "text": "Why does owning 47 different funds not necessarily result in a diversified portfolio?", "options": ["Many funds may hold the same underlying securities, creating concentration despite the appearance of diversification", "Regulatory rules limit the number of funds in a diversified portfolio", "Each additional fund increases correlation, reducing diversification", "Fund of funds structures eliminate the diversification benefit"], "correct": 0, "explanation": "True diversification requires genuinely uncorrelated exposures. Many domestic equity funds hold the same large-cap stocks. Multiplying products does not multiply diversification." },
      { "id": "q6", "text": "When should an advisor begin reducing equity allocation for a client approaching retirement?", "options": ["5-7 years before the planned retirement date", "At the moment of retirement", "At age 65 regardless of planned retirement date", "Only when the client requests a more conservative approach"], "correct": 0, "explanation": "The glide path toward lower equity allocation should begin well before retirement to reduce sequence-of-returns risk — the danger of a major decline in the years immediately before or after retirement." },
      { "id": "q7", "text": "What does research on investor behavior show about actual investor returns compared to fund returns?", "options": ["The average investor earns significantly less than the funds they invest in due to buying high and selling low", "Investors who actively trade consistently outperform buy-and-hold investors", "Average investors approximately match fund returns over long periods", "Active traders earn the same returns as passive investors after fees"], "correct": 0, "explanation": "Investor behavior — selling during downturns and buying during run-ups — systematically produces returns below the funds themselves. This behavior gap is one of the most well-documented findings in behavioral finance." },
      { "id": "q8", "text": "What is the best time to discuss expected portfolio volatility with a client?", "options": ["When allocating — before volatility occurs, not during a downturn when emotions are high", "During a market downturn when the discussion is most relevant", "At the annual review meeting every year", "Only when the client asks about it"], "correct": 0, "explanation": "Clients who have been told to expect a 20-25% decline react very differently than those who weren't. Pre-setting expectations prevents panic selling and keeps clients in their long-term strategy." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 10;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Stocks — Ownership, Return, and Risk",
      "summary": "What owning a stock actually means, how returns are generated, and where the risk comes from.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A stock is an ownership interest in a business. When you own a share of a company, you own a proportional claim on its earnings, assets, and future growth. This is fundamentally different from lending money (a bond) — you share in both the upside and the downside." },
        { "type": "glossary", "terms": [
          { "term": "Dividend", "definition": "A cash distribution from a company's earnings to shareholders. Not guaranteed and can be reduced or eliminated. Component of total return." },
          { "term": "Capital appreciation", "definition": "Increase in stock price over time. The other component of total return. Drives most of the long-term return for growth-oriented stocks." },
          { "term": "Market capitalization", "definition": "Total market value of a company's outstanding shares (share price × shares outstanding). Used to classify stocks as large cap, mid cap, or small cap." },
          { "term": "Price-to-earnings ratio (P/E)", "definition": "Stock price divided by earnings per share. A basic measure of valuation. Higher P/E = higher growth expectations or potential overvaluation." }
        ]},
        { "type": "callout", "kind": "key", "title": "Why equities belong in long-term portfolios", "text": "Over any 20-year rolling period in modern market history, the US equity market has produced positive real returns. Short-term volatility is the price of long-term growth. Clients who exit equities during downturns pay twice: once for the decline, and again by missing the recovery." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Bonds — How They Work and Why They Matter",
      "summary": "The mechanics of fixed income and why bonds behave differently from stocks.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A bond is a loan. The investor lends money to a government or corporation, which promises to pay interest (the coupon) at regular intervals and return the principal at maturity. Bonds provide income, reduce portfolio volatility, and serve as a counterweight to equities in a diversified portfolio." },
        { "type": "callout", "kind": "key", "title": "The most important bond concept: price and yield move inversely", "text": "When interest rates rise, existing bond prices fall — because bonds paying lower rates become less attractive than new bonds paying higher rates. When interest rates fall, existing bond prices rise. This is not intuitive to most clients. It is the source of most bond-related client confusion." },
        { "type": "glossary", "terms": [
          { "term": "Coupon", "definition": "The annual interest payment expressed as a percentage of face value. A $1,000 bond with a 4% coupon pays $40/year." },
          { "term": "Duration", "definition": "A measure of a bond's sensitivity to interest rate changes. Higher duration = higher price change for a given rate move. Long-term bonds have higher duration than short-term bonds." },
          { "term": "Credit rating", "definition": "An assessment of the issuer's ability to repay. Investment grade (BBB/Baa and above) vs. high yield/junk (BB/Ba and below). Lower rating = higher yield = higher default risk." },
          { "term": "Yield to maturity", "definition": "The total return if the bond is held to maturity, accounting for coupon payments and any difference between purchase price and face value." }
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Funds — ETFs vs. Mutual Funds",
      "summary": "The two dominant investment vehicles in most client portfolios. Know the real differences.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients invest in funds rather than individual securities. The two dominant structures are mutual funds and exchange-traded funds (ETFs). Understanding the structural differences helps advisors match the right vehicle to the client's needs." },
        { "type": "list", "items": [
          "<strong>Mutual funds:</strong> priced once daily at NAV; bought/sold directly from the fund company; may have minimum investments; may have sales loads; can be active or index-based",
          "<strong>ETFs:</strong> trade throughout the day like stocks; generally lower expense ratios; highly tax-efficient due to in-kind redemption mechanism; minimum purchase is one share; no sales loads"
        ]},
        { "type": "callout", "kind": "key", "title": "The expense ratio compounds relentlessly", "text": "A 1% difference in annual expense ratio costs $100,000 in a $1M portfolio over 30 years at 7% growth — the difference is approximately $760,000. The first question when evaluating any fund: what does it cost, and is the cost justified by what it provides?" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Reading the Fund Documents",
      "summary": "The prospectus, fact sheet, and performance report each tell a different part of the story.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every fund has required disclosures. The summary prospectus is the legally mandated document covering key fund facts. The fact sheet is the marketing-friendly summary. The annual report covers the full year's activity. Know which document answers which question." },
        { "type": "list", "items": [
          "<strong>Expense ratio</strong> — what you pay annually as a percentage of assets. The most important single number in fund evaluation.",
          "<strong>Turnover ratio</strong> — how frequently the fund trades. High turnover = higher costs and potentially more taxable distributions.",
          "<strong>Benchmark</strong> — what index the fund is measured against. An actively managed small-cap fund should be compared to a small-cap index, not the S&P 500.",
          "<strong>Manager tenure</strong> — for active funds, how long the current management has been in place. A great 10-year record means less if the manager who produced it left 2 years ago.",
          "<strong>Performance in down markets</strong> — how the fund performed during the 2008-09 and 2020 downturns tells you more about risk than any up-market period."
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Comparing Products for a Client",
      "summary": "The comparison framework that leads to defensible, client-appropriate product recommendations.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every product comparison for a client should answer five questions: Does it fit the allocation target? What does it cost? How liquid is it? What are the tax implications? Is it suitable for this specific client?" },
        { "type": "activity", "title": "Product Comparison Exercise", "prompt": "Compare two large-cap equity funds for a 52-year-old client in a taxable account who values tax efficiency.", "steps": [
          "Fund A: Active large-cap growth mutual fund. Expense ratio 0.89%. Turnover 120%. 10-year return 11.2%. Tracks S&P 500 closely.",
          "Fund B: Large-cap index ETF. Expense ratio 0.03%. Turnover 4%. 10-year return 10.8%. Mirrors S&P 500.",
          "Calculate the cost difference over 10 years on $100,000 assuming 10% annual return.",
          "Explain why the turnover difference matters for a taxable account.",
          "Which fund is more appropriate for this client? Write a one-paragraph recommendation with rationale."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What are the two components of total return for a stock investor?", "options": ["Dividends and capital appreciation", "Coupon payments and face value return", "Expense ratio savings and index replication", "Rental income and property appreciation"], "correct": 0, "explanation": "Stocks generate return through dividends (income distributions) and capital appreciation (price increase). Both together constitute total return." },
      { "id": "q2", "text": "What happens to existing bond prices when interest rates rise?", "options": ["Bond prices fall because existing bonds paying lower rates become less attractive than new higher-rate bonds", "Bond prices rise because higher rates increase coupon payments", "Bond prices are unaffected by interest rate changes", "Bond prices temporarily fall then recover to face value"], "correct": 0, "explanation": "The inverse relationship between bond prices and interest rates is the foundational bond concept. Higher rates make existing lower-rate bonds less valuable." },
      { "id": "q3", "text": "A $1,000 face value bond with a 5% coupon pays how much in annual interest?", "options": ["$50 per year (5% × $1,000)", "$500 per year", "$50 total over the bond's life", "It depends on the current market interest rate"], "correct": 0, "explanation": "The coupon payment is the coupon rate multiplied by the face value. 5% × $1,000 = $50 per year, regardless of what the bond is trading at in the market." },
      { "id": "q4", "text": "What is the primary tax efficiency advantage of ETFs over mutual funds?", "options": ["ETF's in-kind redemption mechanism typically avoids distributing capital gains that mutual fund redemptions can trigger", "ETFs are exempt from capital gains tax under current law", "ETF dividends are taxed at a lower rate than mutual fund dividends", "ETFs have a lower expense ratio that reduces taxable income"], "correct": 0, "explanation": "When investors redeem mutual fund shares, the fund may sell securities and distribute capital gains to all remaining shareholders. ETFs redeem through in-kind exchanges with authorized participants, generally avoiding this taxable event." },
      { "id": "q5", "text": "Why does manager tenure matter when evaluating an actively managed fund?", "options": ["A strong long-term track record is less meaningful if the manager who produced it is no longer running the fund", "Longer-tenured managers have lower expense ratios", "Manager tenure determines the fund's risk category", "Regulatory rules require a minimum manager tenure for fund qualification"], "correct": 0, "explanation": "Past performance is attributed to the team that produced it. If the fund manager who generated the 10-year track record left 2 years ago, the historical record has limited predictive value." },
      { "id": "q6", "text": "A 1% difference in annual expense ratio on a $1,000,000 portfolio growing at 7% annually results in approximately how much cost difference over 30 years?", "options": ["Approximately $760,000 in foregone portfolio value", "Approximately $10,000 per year in direct fees", "Approximately $300,000 total over 30 years", "The difference is negligible over long periods"], "correct": 0, "explanation": "The expense ratio reduces compounded growth every year. On a $1M portfolio at 7%, the difference between 0% and 1% annual fees compounds to approximately $760,000 over 30 years." },
      { "id": "q7", "text": "Why is a fund's performance during down markets more informative than its up-market performance?", "options": ["Down-market performance reveals how the fund manages risk, which is the more differentiating characteristic among otherwise similar funds", "Regulators require down-market performance disclosure", "Down-market performance is more accurately measured than up-market performance", "All funds perform similarly during up markets"], "correct": 0, "explanation": "Many funds can perform well when markets are rising. How a fund performs during significant declines — 2008-09, 2020 — reveals its true risk characteristics and how clients will actually experience holding it." },
      { "id": "q8", "text": "A high portfolio turnover ratio in an actively managed fund held in a taxable account primarily indicates what risk?", "options": ["Higher likelihood of taxable capital gain distributions to all shareholders", "Higher probability of investment losses", "Lower diversification due to concentrated positions", "Greater vulnerability to interest rate changes"], "correct": 0, "explanation": "High turnover means frequent buying and selling, which generates realized gains that are distributed to all shareholders — even those who didn't sell. In a taxable account, this creates a tax liability the investor did not choose." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 11;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building a Market Monitoring Habit",
      "summary": "What to watch, how often, and how to distinguish signal from noise.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Market monitoring is a professional discipline, not a market-watching hobby. The goal is not to be aware of every headline — it is to track the economic and market factors that actually affect client portfolios and to identify when something material enough to act on has changed." },
        { "type": "heading", "text": "Key economic indicators to monitor" },
        { "type": "glossary", "terms": [
          { "term": "GDP growth rate", "definition": "Measures the rate of economic expansion or contraction. Sustained negative GDP growth signals recession. Released quarterly." },
          { "term": "CPI (Consumer Price Index)", "definition": "Measures inflation. Rising inflation typically leads to higher interest rates, which affect both stocks and bonds. Released monthly." },
          { "term": "Unemployment rate", "definition": "Measures labor market health. Low unemployment supports consumer spending. Very low unemployment can signal inflationary pressure." },
          { "term": "Federal Funds Rate", "definition": "The interest rate the Federal Reserve sets for overnight lending between banks. The primary policy lever affecting borrowing costs throughout the economy." },
          { "term": "Yield curve", "definition": "The spread between short-term and long-term Treasury yields. An inverted yield curve (short rates > long rates) has preceded most recessions." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The noise problem", "text": "Financial media generates daily content. Most of it is noise — information that does not affect client portfolios or planning decisions. Your discipline is to identify the signal: actual changes in economic conditions that warrant a portfolio review or client communication." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Monitoring Portfolio Performance",
      "summary": "How to access performance data, identify what is driving results, and recognize when action is needed.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance monitoring is not watching the market — it is watching your clients' actual portfolios relative to their goals and their benchmarks. These are different activities. A portfolio that is down 5% in a quarter is a problem or it is not, depending entirely on what the market did and what the client's benchmark returned." },
        { "type": "list", "items": [
          "Access the portfolio management system daily for accounts with significant activity or special monitoring requirements",
          "Review performance reports at each quarter end: absolute return, benchmark comparison, attribution",
          "Flag accounts where the portfolio has drifted beyond the rebalancing threshold",
          "Identify positions that have declined significantly relative to peers or benchmark",
          "Note any accounts approaching withdrawal needs where cash positioning may need to be reviewed"
        ]},
        { "type": "activity", "title": "Performance Review Exercise", "prompt": "Review this hypothetical portfolio performance scenario and prepare the advisor brief.", "steps": [
          "Q3 portfolio return: +4.2%. Benchmark (60/40 blend): +5.8%. Difference: -1.6%.",
          "Identify whether this is a meaningful underperformance or within normal range.",
          "Equity component returned +6.1% vs. equity benchmark +7.4%. Fixed income returned +0.8% vs. +2.1%.",
          "Which component drove the underperformance? What additional information would you need to determine why?",
          "Write a two-paragraph advisor brief explaining the performance in terms suitable for a client conversation."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Review Trigger System",
      "summary": "Building a systematic approach to knowing when to act — and when to hold steady.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The discipline of market monitoring is not just watching — it is knowing what you are watching for and having a clear framework for what triggers action. Without this framework, monitoring either becomes reactive panic or passive inaction." },
        { "type": "list", "items": [
          "<strong>Allocation drift trigger</strong> — any asset class has moved beyond the rebalancing threshold",
          "<strong>Underperformance trigger</strong> — a position has meaningfully underperformed its category benchmark for 3+ consecutive quarters",
          "<strong>Client life event trigger</strong> — a client has experienced a major life change that affects suitability",
          "<strong>Market structural change</strong> — an event material enough to warrant reviewing planning assumptions (rate regime change, recession confirmation)"
        ]},
        { "type": "callout", "kind": "key", "title": "Do NOT trigger on", "text": "Daily market fluctuations. A down month. A single weak earnings report. Media predictions. These are noise. Trading on noise increases costs and reduces returns. The trigger system exists to filter out the noise and respond only to genuine signals." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Preparing a Market Update for Clients",
      "summary": "The one-page format that informs without alarming and demonstrates professional competence.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A client market update serves two purposes: keeping clients informed and preventing panic-driven decisions. Done well, it demonstrates the advisor's knowledge and reassures clients that someone is watching their portfolio. Done poorly, it amplifies fear or comes across as marketing." },
        { "type": "list", "items": [
          "<strong>What happened</strong> — 2-3 sentences on the most significant market events of the period",
          "<strong>What it means for clients</strong> — how this affected the types of portfolios your clients hold",
          "<strong>What we are doing (if anything)</strong> — specific to actual portfolio actions, not vague reassurance",
          "<strong>What to watch next</strong> — the one or two factors most relevant to the outlook"
        ]},
        { "type": "callout", "kind": "warn", "title": "Language to avoid in market communications", "text": "'Don't panic' — plants the idea of panic. 'The markets are volatile' — states the obvious without adding value. 'We believe the market will recover' — an opinion, not a commitment. 'This is a buying opportunity' — may not be true and creates liability." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Communicating Performance to Clients",
      "summary": "How to present a down quarter without losing client confidence — and how to present an up quarter without setting unrealistic expectations.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance communication is the moment when theory meets emotion. Clients may intellectually understand that portfolios fluctuate, but when they see their account down $40,000, the intellectual understanding evaporates. Your role is to reframe the loss in context and reinforce the long-term plan." },
        { "type": "callout", "kind": "do", "title": "The context framework for down periods", "text": "Three questions to answer: (1) What did the market do? (Their portfolio decline in context.) (2) Did the portfolio do what it was supposed to do relative to its benchmark? (3) Has anything changed that warrants revising the plan? If the answers are 'similar to the market,' 'yes,' and 'no' — the message is: this is the portfolio behaving normally. Stay the course." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "An inverted yield curve (short-term rates higher than long-term rates) is historically associated with what economic signal?", "options": ["Recession — it has preceded most US recessions in modern economic history", "Rapid economic growth", "High inflation", "A Federal Reserve rate cut"], "correct": 0, "explanation": "An inverted yield curve signals that the market expects economic slowdown. It has preceded most US recessions in the post-war era, making it one of the most closely watched economic indicators." },
      { "id": "q2", "text": "A portfolio returned +4.2% while its benchmark returned +5.8%. How should this be characterized?", "options": ["Underperformance of 1.6% relative to benchmark — context determines whether this is meaningful", "Outperformance, because the absolute return was positive", "Unacceptable performance that requires immediate portfolio changes", "In-line performance within normal variance"], "correct": 0, "explanation": "Benchmark-relative performance of -1.6% means the portfolio underperformed. Whether this is meaningful depends on the time period, the components driving it, and whether it is within the normal range for the portfolio type." },
      { "id": "q3", "text": "Which of the following should NOT trigger a portfolio review action?", "options": ["A single bad week in equity markets driven by a one-time news event", "Allocation drift beyond the rebalancing threshold", "Three consecutive quarters of meaningful benchmark underperformance", "A client's approaching retirement that changes their cash flow needs"], "correct": 0, "explanation": "Daily and weekly market fluctuations are noise. Portfolio reviews should be triggered by structural changes: drift, sustained underperformance, or client circumstances — not short-term volatility." },
      { "id": "q4", "text": "What is the primary purpose of a client market update communication?", "options": ["Keeping clients informed and preventing panic-driven decisions by providing professional context", "Demonstrating the advisor's investment prediction capabilities", "Meeting the quarterly reporting requirement", "Explaining every transaction made in the client's portfolio"], "correct": 0, "explanation": "Market updates serve clients by providing context that prevents emotional decision-making. They reinforce the long-term plan and demonstrate that the advisor is attentive." },
      { "id": "q5", "text": "When presenting a down quarter to a client, what three questions provide the most useful context?", "options": ["What did the market do? Did the portfolio perform as expected vs. benchmark? Has anything changed that warrants revising the plan?", "What was the portfolio return? What should the return have been? When will it recover?", "Why did the market decline? When will it recover? What should we sell?", "What positions caused the decline? Should we reduce equity exposure? Is this the advisor's fault?"], "correct": 0, "explanation": "These three questions frame down-market performance in context: relative to the market, relative to the benchmark, and relative to the long-term plan. They answer the client's real question: 'Is this a problem?'" },
      { "id": "q6", "text": "Why should the phrase 'don't panic' be avoided in client market communications?", "options": ["It plants the idea of panic in the client's mind, potentially increasing rather than reducing anxiety", "It implies the advisor is panicking", "It is not allowed in regulated client communications", "It is overused and therefore ineffective"], "correct": 0, "explanation": "Telling someone not to panic introduces the concept of panic. More effective language focuses on context and the plan: 'This is the portfolio behaving as designed.' 'Our strategy accounts for periods like this.'" },
      { "id": "q7", "text": "What does a high CPI reading typically signal for fixed income portfolios?", "options": ["Potential for rising interest rates, which would cause bond prices to decline", "Higher coupon payments on existing bonds", "Reduced volatility in bond portfolios", "Improved credit quality across bond issuers"], "correct": 0, "explanation": "High inflation typically leads the Federal Reserve to raise interest rates. Higher interest rates cause existing bond prices to fall, creating losses in fixed income portfolios." },
      { "id": "q8", "text": "In a market update, what is the most important thing to clarify when describing what the firm is doing in response to market conditions?", "options": ["Be specific about actual portfolio actions taken, rather than vague reassurances like 'we are monitoring closely'", "Emphasize that the firm predicted the market conditions in advance", "Focus on future market predictions and expected recovery timelines", "List all the funds in the portfolio and their individual performance"], "correct": 0, "explanation": "Specific actions (rebalanced to target allocation, added to fixed income) demonstrate professional engagement. Vague language like 'monitoring closely' communicates nothing and erodes confidence." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 12;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Makes Research Credible",
      "summary": "Not all research is equal. Learn to evaluate sources before using their conclusions.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial research ranges from rigorous academic work to thinly disguised product marketing. As an advisor associate preparing investment research summaries, your first job is to evaluate the source and identify any conflicts of interest before using a research conclusion." },
        { "type": "glossary", "terms": [
          { "term": "Sell-side research", "definition": "Research produced by investment banks and brokerage firms that sell securities. Potential conflict: researchers may be incentivized to rate stocks positively to support investment banking relationships." },
          { "term": "Buy-side research", "definition": "Research produced by investment managers for internal portfolio decision-making. Generally more objective; not published for public use." },
          { "term": "Independent research", "definition": "Research produced by firms with no investment banking or product sales relationship to the securities covered. Generally considered more objective." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The rating distribution problem", "text": "Studies consistently show that sell-side analysts issue far more Buy ratings than Sell ratings — typically 55-60% Buy, 35-40% Hold, and only 5-10% Sell. A Sell rating from a sell-side analyst is extremely rare and therefore highly meaningful. A Buy rating from the same source is nearly the baseline." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Gathering Research Efficiently",
      "summary": "The 30-minute research workflow that produces what you need without drowning in data.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Research efficiency is a professional skill. The goal is not to read everything — it is to find the most relevant, authoritative information on a specific question as quickly as possible. This requires knowing where to look and what to look for." },
        { "type": "list", "items": [
          "<strong>Morningstar</strong> — fund analysis, analyst ratings, portfolio X-ray, manager research. Best for fund evaluation.",
          "<strong>FactSet / Bloomberg</strong> — real-time data, earnings estimates, economic data. Best for securities research and market data.",
          "<strong>SEC EDGAR</strong> — company filings: 10-K (annual), 10-Q (quarterly), 8-K (material events), proxy. Primary source for company-level research.",
          "<strong>Federal Reserve</strong> — economic data, monetary policy statements, FOMC minutes. Primary source for macro and rate research.",
          "<strong>CFA Institute / academic journals</strong> — methodology and foundational research. Use for understanding concepts, not breaking news."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Research Summary Structure",
      "summary": "The format that produces actionable briefs advisors can actually use.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A research summary is a professional deliverable. Its job is to give an advisor the information they need to make a decision in five minutes, without requiring them to read everything you read. Structure it so the most important conclusions are immediately accessible." },
        { "type": "numbered", "items": [
          "<strong>Executive summary</strong> — two sentences. What is the conclusion and what does it mean for client portfolios?",
          "<strong>Key facts</strong> — the 3-5 most important data points. Sourced and dated.",
          "<strong>Investment thesis or risk</strong> — what is the opportunity or concern being described?",
          "<strong>Risks or counterarguments</strong> — what could be wrong? What would change the conclusion?",
          "<strong>Recommendation or implication</strong> — what should the advisor consider doing in response?"
        ]},
        { "type": "callout", "kind": "do", "title": "Verify before including", "text": "Every statistic, forecast, and data point in a research summary must be verifiable from the source you cite. Do not include numbers you cannot trace to a primary source. An inaccurate research brief is worse than no research brief." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Writing the Research Brief",
      "summary": "The professional voice and analytical discipline that distinguishes useful research from data dumps.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "There is a difference between summarizing research and analyzing it. A summary lists what was found. An analysis interprets what it means and draws conclusions. The research brief for an advisor should do both: tell them what the data shows and tell them what it means for their clients." },
        { "type": "callout", "kind": "key", "title": "The advisor audience", "text": "You are writing for someone who is intelligent, busy, and highly knowledgeable. They do not need you to explain what a P/E ratio is. They need you to tell them whether the current P/E of a specific sector is historically high, what that historically means, and whether it is relevant to portfolio decisions today." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Filing and Retrieval",
      "summary": "Research that cannot be found later was not worth doing.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment research files serve two purposes: supporting current decisions and documenting the basis for past decisions. Compliance examinations can ask why a specific holding was purchased or why a position was liquidated. The research file is your answer." },
        { "type": "list", "items": [
          "Name files clearly: date, subject, source (e.g., '2026-04-15_Q1_EconomicOutlook_FederalReserve')",
          "Organize by topic and date, not by when you produced the summary",
          "Keep source documents alongside your summaries",
          "Note the date research was gathered — stale research used as current is a compliance risk"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why is a 'Sell' rating from a sell-side analyst particularly noteworthy?", "options": ["Sell ratings are rare — typically less than 10% of all ratings — making them a stronger signal than the common Buy rating", "Sell ratings trigger automatic regulatory review", "Sell-side analysts are prohibited from issuing Sell ratings without special approval", "Sell ratings are only issued for securities the firm does not cover"], "correct": 0, "explanation": "Because sell-side analysts issue very few Sell ratings relative to Buy ratings, a Sell is a much stronger signal than typical. The base rate matters when interpreting research ratings." },
      { "id": "q2", "text": "For evaluating a mutual fund's performance history and analyst rating, which primary research source is most useful?", "options": ["Morningstar", "SEC EDGAR", "Federal Reserve publications", "Bloomberg earnings estimates"], "correct": 0, "explanation": "Morningstar specializes in fund analysis, ratings, and portfolio analytics. It is the primary resource for fund evaluation work." },
      { "id": "q3", "text": "In a research summary, what belongs in the executive summary section?", "options": ["Two sentences: the conclusion and what it means for client portfolios", "All key data points with sources", "A comprehensive review of all research gathered", "The risks and counterarguments to the main thesis"], "correct": 0, "explanation": "The executive summary must be immediately actionable. Two sentences: what the research shows and what it means. Advisors should be able to understand the bottom line without reading further." },
      { "id": "q4", "text": "What is the difference between summarizing research and analyzing it?", "options": ["A summary lists findings; an analysis interprets what the findings mean and draws conclusions relevant to decisions", "Summarizing is for clients; analyzing is for internal use only", "Summarizing requires citing sources; analyzing does not", "Analysis is only performed by senior advisors; associates summarize"], "correct": 0, "explanation": "The value of a research brief is in the analysis layer — the interpretation that converts raw data into actionable insight. A data dump without interpretation does not help the advisor make a decision." },
      { "id": "q5", "text": "For finding a company's annual report and quarterly filings, which source is most authoritative?", "options": ["SEC EDGAR — the official repository for all public company regulatory filings", "The company's investor relations website", "Financial news sources like Bloomberg or Reuters", "Morningstar's company analysis page"], "correct": 0, "explanation": "SEC EDGAR contains the official regulatory filings — 10-K, 10-Q, 8-K — that are the primary source documents for company-level research. Other sources summarize or comment on these filings." },
      { "id": "q6", "text": "Why must research files include the date the research was gathered?", "options": ["Stale research used as current is a compliance risk — market conditions change and old data can lead to poor decisions", "Regulatory rules require dating all research documents", "The advisor uses the date to determine the research fee", "SEC filing dates must match internal research dates"], "correct": 0, "explanation": "Research from six months ago may no longer reflect current conditions. Knowing when research was gathered allows users to evaluate its currency and avoid using outdated conclusions." },
      { "id": "q7", "text": "Which of the following describes the difference between sell-side and buy-side research?", "options": ["Sell-side is produced by banks/brokerages with potential conflicts; buy-side is produced by investment managers for internal use and is generally more objective", "Sell-side research is available for free; buy-side research is subscription-only", "Sell-side research covers stocks; buy-side research covers bonds", "Sell-side is more accurate; buy-side is more timely"], "correct": 0, "explanation": "The distinction is independence and conflict of interest. Sell-side firms may have investment banking relationships with the companies they cover. Buy-side research serves only the portfolio decision-making process." },
      { "id": "q8", "text": "What is the naming convention best practice for research files?", "options": ["Date, subject, and source — e.g., '2026-04-15_Q1_EconomicOutlook_FederalReserve'", "Subject only, in alphabetical order", "Sequential numbering assigned by the CRM system", "The advisor's initials followed by the topic"], "correct": 0, "explanation": "A naming convention that includes date, subject, and source allows research to be found quickly and confirms its currency and origin without opening the file." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 13;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Regulatory Framework You Work In",
      "summary": "Who regulates financial advisors, what they regulate, and why compliance exists.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial services is one of the most heavily regulated industries because the consequences of failures are severe — clients lose retirement savings, trust collapses, and the broader financial system can be damaged. Compliance is not bureaucratic friction — it is the institutional response to real harm that occurred when advisors operated without it." },
        { "type": "glossary", "terms": [
          { "term": "SEC (Securities and Exchange Commission)", "definition": "Federal agency that regulates registered investment advisors (RIAs) managing over $100 million in assets. Establishes the fiduciary standard for RIAs." },
          { "term": "FINRA (Financial Industry Regulatory Authority)", "definition": "Self-regulatory organization that oversees broker-dealers and their registered representatives. Applies the suitability standard." },
          { "term": "State regulators", "definition": "Regulate RIAs below the SEC threshold and other financial professionals. Requirements vary by state." },
          { "term": "Fiduciary standard", "definition": "The requirement to act in the client's best interest, not merely recommend something suitable. Applies to RIAs and their associated persons." }
        ]},
        { "type": "callout", "kind": "key", "title": "The personal liability question", "text": "Compliance failures are not just firm problems. Individual advisors and associates can face personal sanctions: fines, suspensions, and permanent bars from the industry. Understanding compliance requirements is self-protection as much as client protection." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Books and Records Requirements",
      "summary": "What must be retained, for how long, and in what format. The foundation of regulatory compliance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The SEC's books and records rules (Rule 204-2 under the Investment Advisers Act) require RIAs to maintain extensive records for specific time periods. These records exist so that regulators can reconstruct the firm's activities and client communications during any examination period." },
        { "type": "list", "items": [
          "<strong>Client agreements and contracts</strong> — five years from termination of the relationship",
          "<strong>Client communications</strong> — all written communications, including emails and texts — five years",
          "<strong>Performance records</strong> — the underlying data supporting any performance claims — five years",
          "<strong>Trade records</strong> — records of all securities transactions — five years",
          "<strong>Financial records</strong> — the firm's own financial statements — five years"
        ]},
        { "type": "callout", "kind": "warn", "title": "Electronic communication retention", "text": "Email, text messages, and any other business communication about client affairs is a business record. Using personal email or text for client communications is a compliance violation. If you communicate with a client through any channel, that communication must be retained. Most firms have specific policies — know yours." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Compliance Calendar",
      "summary": "The annual, quarterly, and personal compliance obligations every associate must know.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Compliance is not a single event — it is a continuous set of obligations with specific deadlines. Missing a compliance deadline is itself a compliance violation. Build the calendar into your workflow before you need it." },
        { "type": "list", "items": [
          "<strong>Annual (firm-level):</strong> Form ADV update filing (within 90 days of fiscal year end), annual compliance review, continuing education credits, annual privacy notice to clients",
          "<strong>Annual (personal):</strong> Complete required training modules, review and attest to compliance manual, outside business activity disclosure updates",
          "<strong>Quarterly:</strong> Personal securities transaction reporting, review of client account activity for supervisory purposes",
          "<strong>As needed:</strong> Pre-clearance for personal securities trades, outside business activity approvals, gift and entertainment reporting"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting Client Interactions for Compliance",
      "summary": "What 'it's in the file' actually means and the standard for documented advice.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every piece of advice given to a client should be traceable to a documented basis. Not because clients will sue you — though that is always possible — but because the documentation habit forces you to think clearly about why a recommendation is appropriate before making it." },
        { "type": "callout", "kind": "do", "title": "When to document immediately", "text": "When a client asks about a specific investment and you answer. When a client expresses a complaint or concern. When a recommendation is made that deviates from the model portfolio. When a client declines a recommendation. These moments create both the most value and the most risk. Documentation is how you protect both." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Handling Complaints and Exceptions",
      "summary": "The professional and compliant way to handle client complaints, errors, and exception requests.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Complaints and errors are inevitable in a financial advisory practice. They are not the end of the world — but how they are handled determines whether they become regulatory problems. The key is documentation and escalation, not defensiveness or concealment." },
        { "type": "list", "items": [
          "Log every complaint in the firm's complaint register, regardless of how minor it seems",
          "Notify the compliance department of any complaint that involves potential financial harm",
          "Never promise to resolve a complaint without compliance approval for the resolution",
          "Document errors as soon as they are discovered — do not wait to see if the client notices",
          "Follow the firm's error correction policy exactly — including supervisor approval for corrections"
        ]},
        { "type": "callout", "kind": "warn", "title": "The concealment trap", "text": "An advisor who tries to fix an error quietly — without documentation, without telling compliance — creates two problems: the original error and the cover-up. Regulators are far more lenient about disclosed errors corrected promptly than about undisclosed errors discovered in an examination." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Which regulatory body applies the fiduciary standard to registered investment advisors?", "options": ["The SEC (Securities and Exchange Commission)", "FINRA", "State insurance regulators", "The Federal Reserve"], "correct": 0, "explanation": "The SEC regulates RIAs and requires them to meet the fiduciary standard — acting in the client's best interest at all times." },
      { "id": "q2", "text": "Under SEC books and records rules, how long must a registered investment advisor retain client communications?", "options": ["Five years", "Two years", "Seven years", "Three years"], "correct": 0, "explanation": "Rule 204-2 under the Investment Advisers Act generally requires RIAs to retain books and records, including client communications, for five years." },
      { "id": "q3", "text": "Why is using personal email for client communications a compliance violation?", "options": ["Business communications with clients are required business records that must be retained — personal email typically cannot be captured by firm retention systems", "Personal email is less secure than firm email", "Clients prefer not to receive personal email from advisors", "The firm's email system provides better client service features"], "correct": 0, "explanation": "Books and records rules require retaining all business communications. Personal email channels are generally outside the firm's retention system, making compliance with this rule impossible." },
      { "id": "q4", "text": "When should a compliance complaint log entry be created?", "options": ["For every complaint, regardless of how minor it seems at the time", "Only for complaints that the client puts in writing", "Only for complaints that involve potential monetary damages", "After the compliance department has reviewed the situation"], "correct": 0, "explanation": "Every complaint must be logged. A complaint that seems minor today may become significant later. Selective logging creates compliance exposure." },
      { "id": "q5", "text": "What happens to an individual advisor who discovers an error and tries to correct it quietly without documentation or compliance notification?", "options": ["They create two problems: the original error and a concealment issue that may be treated more harshly than the error itself", "They demonstrate good judgment in resolving client issues efficiently", "They protect the firm from unnecessary regulatory attention", "They fulfill their duty to correct mistakes promptly"], "correct": 0, "explanation": "Concealment of errors is treated more seriously than the errors themselves. Prompt disclosure and correction, following the firm's procedures, is always the right path." },
      { "id": "q6", "text": "What is the annual compliance obligation that must be filed with the SEC within 90 days of fiscal year end?", "options": ["Form ADV update — the firm's registration document that discloses services, fees, conflicts, and disciplinary history", "Form CRS — the client relationship summary", "Form U4 — the individual registration form", "The firm's audited financial statements"], "correct": 0, "explanation": "Form ADV is the RIA's registration document. It must be updated annually and filed with the SEC. Clients must receive the updated ADV Part 2 annually." },
      { "id": "q7", "text": "When a client declines a recommendation made by the advisor, what should happen?", "options": ["The declination should be documented in the client file, noting the recommendation made and the client's decision to decline", "No documentation is needed since no transaction occurred", "The advisor should note it only if the recommendation involved securities", "The client should sign a waiver acknowledging the declination"], "correct": 0, "explanation": "Documenting declined recommendations protects the advisor. If a client later claims they were not given certain advice, the documentation establishes that the recommendation was made and the client chose not to follow it." },
      { "id": "q8", "text": "Personal securities transaction reporting by advisor associates is typically required on what basis?", "options": ["Quarterly, for all personal securities transactions in reportable accounts", "Annually only", "Only for transactions in securities the firm recommends to clients", "Only if the transaction involves securities in client portfolios"], "correct": 0, "explanation": "Most RIAs require associates to report personal securities transactions quarterly. This allows the compliance department to monitor for front-running and conflicts of interest." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 14;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Performance Measurement Fundamentals",
      "summary": "Two different return calculations, two different purposes. Know which one to use when.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance reporting requires using the right calculation for the right purpose. The two primary measures — time-weighted return and money-weighted return — tell different stories. Using the wrong one misleads clients and creates compliance risk." },
        { "type": "glossary", "terms": [
          { "term": "Time-weighted return (TWR)", "definition": "Measures the portfolio's return independently of the timing and size of cash flows. Shows how the investment strategy performed. Required for GIPS-compliant performance presentation. Comparable across managers." },
          { "term": "Money-weighted return (MWR / IRR)", "definition": "Accounts for the timing and size of client cash flows. Shows the individual client's actual return given when they added or withdrew money. Not comparable across managers." }
        ]},
        { "type": "callout", "kind": "key", "title": "Which return answers which question", "text": "TWR answers: 'How did the investment strategy perform?' MWR answers: 'What return did THIS CLIENT actually earn?' A client who invested a large amount at the market peak will have a different MWR than a client who invested the same amount before the peak — even though both experienced the same TWR." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Generating Performance Reports",
      "summary": "The step-by-step process for pulling accurate reports from the portfolio management system.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance reports must be generated consistently, using the same methodology each time, verified for accuracy before they reach the client. The process seems simple; the errors that creep in are not." },
        { "type": "numbered", "items": [
          "Log in to the portfolio management system and select the client account",
          "Choose the reporting period — quarter-end, year-end, or inception-to-date",
          "Select the appropriate benchmark — must match the account's investment strategy",
          "Generate the performance report",
          "Verify: check that account value on the report matches the custodian statement. Check that the benchmark selected matches the actual strategy. Check that the reporting period dates are correct.",
          "Flag any anomalies for resolution before sending"
        ]},
        { "type": "callout", "kind": "warn", "title": "The most common reporting error", "text": "Using the wrong benchmark. Comparing a 60/40 portfolio to the S&P 500 makes the portfolio look bad in strong equity markets and good in down markets — neither comparison is meaningful. Always confirm the benchmark matches the portfolio's actual strategy before finalizing the report." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Benchmarking Portfolio Performance",
      "summary": "What an appropriate benchmark is, why it matters, and how to explain it to clients.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A benchmark is the standard against which a portfolio's performance is measured. It must represent a realistic alternative to what the client is invested in — otherwise the comparison is meaningless or, worse, misleading." },
        { "type": "list", "items": [
          "A 100% US large-cap equity portfolio should be benchmarked against the S&P 500",
          "A 60/40 balanced portfolio should be benchmarked against a 60/40 blended index",
          "A global equity portfolio should be benchmarked against MSCI ACWI or similar",
          "A fixed income portfolio should be benchmarked against the Bloomberg US Aggregate Bond Index or appropriate subset"
        ]},
        { "type": "callout", "kind": "do", "title": "The benchmark explanation for clients", "text": "'The benchmark is the simplest, lowest-cost way to get the same type of exposure you have. If we're invested in US large-cap stocks, the S&P 500 index represents what you'd earn from just owning that market passively. Beating it means we added value. Trailing it means we need to understand why.'" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "The Performance Snapshot Format",
      "summary": "What belongs in a client-facing performance report — and what to leave out.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A client-facing performance snapshot is not a full accounting statement. It is a clear, readable summary of how the portfolio performed over specific periods. Its purpose is to inform, not to overwhelm." },
        { "type": "list", "items": [
          "<strong>Account value as of the report date</strong>",
          "<strong>Performance for the quarter, year-to-date, and trailing 1/3/5-year periods</strong>",
          "<strong>Benchmark return for each same period</strong>",
          "<strong>Beginning and ending value for the period with net contributions/withdrawals</strong>",
          "<strong>Asset allocation as of the report date</strong>"
        ]},
        { "type": "callout", "kind": "key", "title": "What to leave out", "text": "Individual position performance, individual lot details, detailed transaction history, internal rate of return calculations, hypothetical projections. These belong in the full accounting statement or in a separate advisor review, not in the client snapshot." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Performance in Context",
      "summary": "Performance means nothing without context. Here's how to provide it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A number without context is just a number. +8.2% means nothing unless you know what the benchmark returned, what the market environment was, and whether it is consistent with the portfolio's expected range of outcomes." },
        { "type": "callout", "kind": "do", "title": "The three-part performance narrative", "text": "1. What happened in the market: 'The first quarter was volatile — global equities declined 6% as interest rate concerns increased.' 2. How the portfolio performed in context: 'Your portfolio declined 4.8%, performing better than the benchmark, which fell 5.9%.' 3. Forward perspective: 'Nothing in the quarter changes our assessment of the strategy, and we remain positioned as agreed.'" }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Which return calculation is required for GIPS-compliant performance presentation and is comparable across investment managers?", "options": ["Time-weighted return (TWR)", "Money-weighted return (MWR)", "Simple return", "Annualized return"], "correct": 0, "explanation": "TWR eliminates the impact of cash flow timing and size, making it the appropriate measure for evaluating how an investment strategy performed. It is comparable across managers." },
      { "id": "q2", "text": "Two clients hold identical portfolios with identical TWRs, but different money-weighted returns. What explains this?", "options": ["They added or withdrew money at different times — the timing of cash flows affects MWR but not TWR", "They held the portfolio for different time periods", "One client paid higher advisory fees", "The portfolio management system calculated the returns differently"], "correct": 0, "explanation": "MWR is sensitive to the timing of contributions and withdrawals. A client who invested heavily before a decline will have a worse MWR than one who invested after the decline, even if the portfolio strategy was identical." },
      { "id": "q3", "text": "What is the most common performance reporting error?", "options": ["Using the wrong benchmark — comparing a balanced portfolio to the S&P 500", "Using quarterly rather than annual return periods", "Including withdrawals in the performance calculation", "Reporting net-of-fees returns without disclosing the fee"], "correct": 0, "explanation": "Benchmark selection is critical. Comparing a 60/40 portfolio to a 100% equity benchmark creates a misleading comparison in both up and down markets." },
      { "id": "q4", "text": "What is the appropriate benchmark for a portfolio that is 60% US equities and 40% US bonds?", "options": ["A blended benchmark of 60% S&P 500 / 40% Bloomberg US Aggregate Bond Index", "The S&P 500 alone", "The Bloomberg US Aggregate Bond Index alone", "The Dow Jones Industrial Average"], "correct": 0, "explanation": "The benchmark must reflect the portfolio's actual strategy. A 60/40 portfolio requires a 60/40 blended benchmark to make the performance comparison meaningful." },
      { "id": "q5", "text": "Before delivering a performance report to a client, what verification steps must be completed?", "options": ["Confirm account value matches custodian statement, verify benchmark matches actual strategy, verify reporting period dates are correct", "Verify the report was generated by a licensed associate", "Confirm the client has reviewed the disclosures", "Send the report to compliance for pre-approval"], "correct": 0, "explanation": "These three verification steps catch the most common reporting errors. An inaccurate performance report creates compliance risk and damages client trust." },
      { "id": "q6", "text": "What information belongs in a client performance snapshot?", "options": ["Account value, quarterly and YTD returns, benchmark comparison, asset allocation — simple and readable", "Every individual position's purchase price, current value, and unrealized gain/loss", "A detailed transaction history for the reporting period", "Hypothetical future projections based on current performance"], "correct": 0, "explanation": "The performance snapshot serves clients who want to understand how their portfolio did. Excessive detail obscures the key information and reduces the document's utility." },
      { "id": "q7", "text": "A portfolio returned +8.2% while its benchmark returned +5.8%. How should this be described in a client communication?", "options": ["The portfolio outperformed its benchmark by 2.4 percentage points during the period", "The portfolio doubled the benchmark return", "The portfolio was up 8.2% while the market was up 5.8%", "Both options 1 and 3 are acceptable"], "correct": 0, "explanation": "Outperformance in absolute terms (2.4 percentage points above benchmark) is the precise, professional way to describe benchmark-relative performance. 'Doubled the benchmark' is imprecise and potentially misleading." },
      { "id": "q8", "text": "When presenting a quarter where the portfolio was down 4.8% against a benchmark down 5.9%, what is the key message?", "options": ["The portfolio declined less than its benchmark, demonstrating relative outperformance during a difficult market", "The portfolio lost money and the strategy needs to be reconsidered", "The portfolio's absolute loss is the primary metric to focus on", "The benchmark decline makes the portfolio's decline acceptable"], "correct": 0, "explanation": "Context is everything in performance communication. A portfolio that declines 4.8% when its benchmark declines 5.9% has performed well in relative terms. The client needs to understand that the comparison makes a loss meaningful, not just uncomfortable." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 15;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Chart of Accounts — Structure and Purpose",
      "summary": "The organizational framework that makes every financial record legible and every report accurate.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The chart of accounts is the master list of every account the firm uses to record its financial activity. It is the foundation of the accounting system — without it, financial records have no consistent structure, reports cannot be produced, and audits become nightmares." },
        { "type": "glossary", "terms": [
          { "term": "Asset accounts", "definition": "Resources the firm owns: cash, accounts receivable, prepaid expenses, equipment. Numbered in the 1000s in most systems." },
          { "term": "Liability accounts", "definition": "Obligations the firm owes: accounts payable, accrued expenses, deferred revenue. Numbered in the 2000s." },
          { "term": "Equity accounts", "definition": "The owners' interest in the firm: paid-in capital, retained earnings. Numbered in the 3000s." },
          { "term": "Revenue accounts", "definition": "Income sources: advisory fees, financial planning fees. Numbered in the 4000s." },
          { "term": "Expense accounts", "definition": "Costs of operating the business: salaries, rent, technology, marketing, professional services. Numbered in the 5000s+." }
        ]},
        { "type": "callout", "kind": "key", "title": "Why classification accuracy matters", "text": "Every transaction must be classified correctly when entered. A misclassified expense reduces the accuracy of the income statement and can affect tax reporting. A misclassified asset overstates the firm's financial position. The chart of accounts is only useful if transactions are coded to it correctly and consistently." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Transaction Classification",
      "summary": "Correctly categorizing every financial transaction — the discipline that makes everything else work.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every financial transaction must be assigned to the correct account in the chart of accounts when it is recorded. Getting this right requires understanding both the account structure and the nature of each transaction." },
        { "type": "list", "items": [
          "<strong>Advisory fee income</strong> — Revenue: Advisory fees (4100). Received from custodian or client, recorded as earned.",
          "<strong>Employee salaries</strong> — Expense: Compensation (5100). Recorded at the time the payroll obligation is incurred.",
          "<strong>Software subscriptions</strong> — Expense: Technology (5300). Monthly prepaid amounts may need to be amortized.",
          "<strong>Client entertaining</strong> — Expense: Marketing and business development (5500). Subject to gift and entertainment limits.",
          "<strong>Office equipment purchase</strong> — Asset: Equipment (1400). Must be capitalized and depreciated over useful life, not expensed immediately."
        ]},
        { "type": "callout", "kind": "warn", "title": "The capitalization vs. expense decision", "text": "A purchase that provides benefit over multiple years (equipment, software licenses, leasehold improvements) should generally be capitalized as an asset and depreciated, not expensed immediately. Expensing a $15,000 server as a supply purchase in one year significantly understates the firm's asset base and overstates the current year expense." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Accounts Receivable and Payable",
      "summary": "Tracking what clients owe and what the firm owes — the cash flow of the practice.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "For an advisory firm, accounts receivable primarily represents advisory fees earned but not yet collected. Accounts payable represents vendor invoices and other obligations not yet paid. Both must be tracked accurately to understand the firm's true financial position." },
        { "type": "callout", "kind": "do", "title": "The AR aging report", "text": "Review the accounts receivable aging report weekly. Invoices in the 0-30 day column are current. The 31-60 day column requires attention. Anything beyond 60 days requires direct action — the firm is providing services without collecting the fee, which creates cash flow problems and potential write-off risk." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Month-End Closing Procedures",
      "summary": "The systematic process that ensures financial records are complete and accurate before reports are produced.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The month-end close is the period where all transactions for the month are finalized, adjusted, and confirmed before financial reports are generated. Skipping or rushing the close produces inaccurate reports that management decisions and tax filings will rely on." },
        { "type": "numbered", "items": [
          "Post all transactions for the month — ensure no activity is missing or unrecorded",
          "Reconcile all bank accounts — compare accounting system balances to bank statements",
          "Record accruals — expenses incurred but not yet invoiced, revenue earned but not yet received",
          "Reconcile investment accounts — confirm custodian balances match internal records",
          "Review trial balance — total debits must equal total credits",
          "Generate preliminary financial statements — review for obvious errors before finalizing"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Supporting the Accountant and Auditor",
      "summary": "What the CPA needs at tax time and what the auditor will request — how to be prepared.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The CPA preparing the firm's tax return and the auditor reviewing the firm's financial statements both need the same thing: organized, accurate records they can rely on. Your job is to have those records ready before they ask." },
        { "type": "list", "items": [
          "Bank statements reconciled and filed for all 12 months",
          "Expense support documents: receipts, invoices for all material transactions",
          "Payroll records: W-2s, 1099s, payroll journals",
          "Advisory fee schedules and billing records",
          "Asset and depreciation schedules for capitalized items",
          "Prior year tax return for reference"
        ]},
        { "type": "callout", "kind": "do", "title": "The pre-tax package", "text": "By January 31 each year, prepare a complete organized package of everything the CPA will need — even before they ask. Accountants who receive organized, complete information produce better work faster. Those who chase records produce rushed work that requires more review." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Advisory fees received from the custodian should be classified in which account type?", "options": ["Revenue — advisory fee income (typically account 4100)", "Asset — accounts receivable", "Liability — deferred revenue", "Equity — retained earnings"], "correct": 0, "explanation": "Advisory fees are the firm's primary revenue source. When received, they are posted to the appropriate revenue account. If earned but not yet collected, they are recorded as accounts receivable." },
      { "id": "q2", "text": "A $12,000 server purchased for the firm's network should be treated as what?", "options": ["A capitalized asset, depreciated over its useful life — not expensed immediately", "An operating expense in the period of purchase", "A prepaid expense to be amortized monthly", "A liability until the purchase is fully paid"], "correct": 0, "explanation": "Equipment that provides benefit over multiple years must be capitalized and depreciated. Expensing it immediately overstates the period's expenses and understates the firm's asset base." },
      { "id": "q3", "text": "An accounts receivable aging report shows an invoice in the '61-90 day' column. What action is required?", "options": ["Direct action to collect — the fee is significantly overdue and represents a cash flow and write-off risk", "Normal monitoring — 61-90 days is within normal payment terms", "Write off the invoice as uncollectible", "Issue a credit memo and rebill the client"], "correct": 0, "explanation": "Invoices beyond 60 days require direct follow-up. The firm is providing services without collecting the fee, which creates cash flow problems and increases the likelihood of write-off." },
      { "id": "q4", "text": "What is the purpose of recording accruals during the month-end close?", "options": ["To record expenses incurred but not yet invoiced and revenue earned but not yet received, ensuring the period's financial statements are complete", "To reverse incorrect entries from prior periods", "To reconcile the bank statement to the accounting records", "To calculate the depreciation for capitalized assets"], "correct": 0, "explanation": "Accrual accounting requires recording economic events when they occur, not when cash changes hands. Accruals ensure the income statement reflects all activity in the period." },
      { "id": "q5", "text": "Which step in the month-end close confirms that the accounting system is mathematically balanced?", "options": ["Reviewing the trial balance — total debits must equal total credits", "Reconciling bank accounts to bank statements", "Generating the preliminary balance sheet", "Reviewing the accounts receivable aging report"], "correct": 0, "explanation": "The trial balance is the mathematical proof of double-entry accounting. If debits don't equal credits, there is an error in the accounting records that must be found and corrected." },
      { "id": "q6", "text": "What is the most important accounting document to have ready before meeting with the CPA for tax preparation?", "options": ["Prior year tax return, reconciled bank statements, payroll records, expense support documents, and the advisory fee schedule", "Only the current year bank statements", "The audited financial statements from the prior year", "The firm's accounts payable aging report"], "correct": 0, "explanation": "The CPA needs complete, organized information to prepare an accurate tax return. Missing documents slow the process and increase the risk of errors or omissions." },
      { "id": "q7", "text": "Employee salaries should be recorded in the accounting system at what point?", "options": ["When the payroll obligation is incurred — when employees earn the wages, not necessarily when payment is made", "When the paycheck is issued", "When the employee cashes the check", "At the end of each fiscal quarter"], "correct": 0, "explanation": "Under accrual accounting, salary expense is recorded when employees earn wages, not when payroll is processed. This may require an accrual entry at period end if the payroll period spans the month boundary." },
      { "id": "q8", "text": "What distinguishes expense accounts from liability accounts in the chart of accounts?", "options": ["Expenses represent costs consumed in the period to generate revenue; liabilities represent obligations to pay in the future", "Expenses are tax-deductible; liabilities are not", "Expenses appear on the balance sheet; liabilities appear on the income statement", "Expenses are numbered in the 2000s; liabilities in the 5000s"], "correct": 0, "explanation": "Expenses are income statement accounts that reflect resources consumed during the period. Liabilities are balance sheet accounts representing future obligations. The distinction affects both reporting and decision-making." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 16;


-- ── PART 4: Lesson content modules 17-24 (insurance 19 kept) ──
-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 17–24
-- Module 19 = Insurance Planning (supplemental)
-- ============================================================================

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Reconciliation Is and Why It Exists",
      "summary": "Reconciliation catches errors before clients see them. It is the last line of defense in portfolio operations.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Portfolio reconciliation is the process of comparing the firm's internal records to the custodian's records and resolving any differences. It exists because errors happen — in trade processing, corporate action handling, dividend posting, and fee calculation. Reconciliation catches these errors before they appear in a client report or, worse, before they cause a financial loss." },
        { "type": "callout", "kind": "key", "title": "The three-way reconciliation", "text": "Portfolio reconciliation compares three sets of records: the portfolio management system (internal), the custodian statement (external), and the client report (derived). All three must agree. A difference between any two of them is a break that must be investigated and resolved." },
        { "type": "heading", "text": "What discrepancies reveal" },
        { "type": "list", "items": [
          "Trade errors: a trade was processed at the wrong price, wrong quantity, or wrong account",
          "Corporate action errors: a dividend or stock split was not processed correctly",
          "Fee errors: advisory fees were deducted incorrectly",
          "Timing differences: a trade settled on a different date than expected",
          "Custody errors: the custodian recorded a transaction differently than the firm"
        ]},
        { "type": "callout", "kind": "warn", "title": "Unresolved breaks are not routine", "text": "Every reconciliation break must be resolved — even small ones. A $12 discrepancy today may be the symptom of a systematic error affecting hundreds of accounts. Firms that allow breaks to accumulate 'because they're small' consistently find larger problems later." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Daily Reconciliation Workflow",
      "summary": "The first thing every morning: what you check, how you check it, and what you do with what you find.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "For active client accounts, reconciliation is a daily discipline. The workflow is consistent: import custodian data, run the exception report, investigate breaks, document resolution. The goal is to start every client-facing day knowing that internal records match external reality." },
        { "type": "numbered", "items": [
          "Import custodian data feed into the portfolio management system (automated in most systems)",
          "Run the reconciliation exception report — this shows every account with a discrepancy",
          "Sort breaks by size and account: prioritize large breaks and accounts with scheduled client contact",
          "For each break, identify the likely cause from the categories: price, quantity, missing transaction, timing",
          "Investigate through the custodian portal or transaction records",
          "Resolve or escalate — document every step regardless of outcome"
        ]},
        { "type": "activity", "title": "Break Investigation Exercise", "prompt": "You find a $3,200 break in a client account. The portfolio system shows the account holds 100 shares of a stock at $48/share ($4,800). The custodian shows 100 shares at $52/share ($5,200). What are the likely causes and how do you investigate?", "steps": [
          "Identify the type of break: it is a price discrepancy, not a position discrepancy.",
          "Check the portfolio system's price source: where does it pull prices from?",
          "Check the custodian's price: is this the closing price or an intraday price?",
          "Determine if this is a timing issue (prices are from different times) or a data quality issue.",
          "Document your investigation steps and the resolution, even if the resolution is 'this will clear tomorrow due to price feed timing.'"
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Investigating and Resolving Discrepancies",
      "summary": "Common break types, their causes, and the resolution path for each.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most reconciliation breaks fall into a small number of categories. Learning to recognize the pattern and trace it to the source is the core skill." },
        { "type": "glossary", "terms": [
          { "term": "Timing difference", "definition": "A transaction has been recorded by one party but not yet by the other. Usually self-correcting within 1-3 business days. Document and monitor — do not assume it will resolve." },
          { "term": "Price break", "definition": "The same position is valued at a different price in two systems. Check price sources: one may use closing price, the other may use a different pricing model." },
          { "term": "Missing transaction", "definition": "A trade or corporate action appears in one system but not the other. Requires reconstruction: find the original trade confirmation and determine which system failed to record it." },
          { "term": "Corporate action error", "definition": "A dividend, split, merger, or other corporate action was not processed correctly in one or both systems. Requires research into the specific corporate action terms." }
        ]},
        { "type": "callout", "kind": "do", "title": "When to escalate", "text": "Escalate immediately when: the break exceeds a dollar threshold set by firm policy (e.g., $10,000); the same type of break appears across multiple accounts (systematic error); the break involves a client with an imminent withdrawal or meeting; you cannot determine the cause after two hours of investigation." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting Reconciliation Results",
      "summary": "Every break investigated must be documented — resolved or unresolved.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The reconciliation record serves two purposes: operational tracking (ensuring breaks are actually resolved) and compliance documentation (proving that the firm monitors for errors systematically). Both purposes require the same thing: complete, contemporaneous documentation." },
        { "type": "list", "items": [
          "Date of the reconciliation run",
          "Account identifier and custodian",
          "Description of the break: type, amount, affected security",
          "Investigation steps taken",
          "Resolution: what caused it, how it was corrected",
          "Escalation record: if escalated, who was notified and when",
          "Verification: confirmation that the resolution was reflected in both systems"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Building a Zero-Tolerance Reconciliation Culture",
      "summary": "The professional standard and operational habits that prevent errors from becoming client problems.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Operations cultures that tolerate small, persistent breaks eventually produce large client problems. The discipline of resolving every break — regardless of size — is both a professional standard and a risk management practice." },
        { "type": "callout", "kind": "key", "title": "Reconciliation as early warning", "text": "Firms with rigorous reconciliation practices catch fraud, operational failures, and systematic errors early — before they create client harm. Firms that treat reconciliation as a checkbox exercise find out about problems the hard way. Your daily reconciliation habit protects clients you will never know you protected." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What are the three sets of records compared in a three-way portfolio reconciliation?", "options": ["Portfolio management system (internal), custodian statement (external), and client report (derived)", "Portfolio system, bank records, and tax records", "Trade confirmations, custodian statements, and client agreements", "Internal ledger, broker records, and regulatory filings"], "correct": 0, "explanation": "Three-way reconciliation compares the internal portfolio system, the custodian's records, and the client-facing report. All three must agree." },
      { "id": "q2", "text": "A $12 reconciliation break is found across 200 client accounts. How should this be treated?", "options": ["As a potential systematic error requiring immediate escalation, not as a routine small break", "As immaterial and not requiring investigation", "As a data feed timing issue that will self-correct", "As a rounding difference that does not require documentation"], "correct": 0, "explanation": "A small break appearing across many accounts is a red flag for a systematic error — a pricing feed issue, a corporate action processing error, or a fee calculation problem. The aggregate impact may be material." },
      { "id": "q3", "text": "A break appears in the portfolio system but resolves automatically the next day. What is the correct response?", "options": ["Document it as a timing difference, monitor to confirm resolution, and keep the record even after resolution", "Delete the break record since it resolved itself", "Note it as 'self-correcting' and take no further action", "Escalate it since any break that cannot be immediately explained is a concern"], "correct": 0, "explanation": "Timing differences are common and often self-correcting, but they must still be documented. The documentation proves the break was identified and monitored, which satisfies both operational and compliance requirements." },
      { "id": "q4", "text": "What is a 'corporate action error' in portfolio reconciliation?", "options": ["A dividend, split, merger, or other corporate action that was not processed correctly in one or both systems", "An error in the trade execution resulting from a corporate employee's mistake", "A regulatory filing error by the issuing corporation", "A dividend payment made to the wrong custodian"], "correct": 0, "explanation": "Corporate actions — dividends, splits, mergers, spin-offs — must be reflected correctly in both the internal system and the custodian records. Errors arise when the event is processed with incorrect terms, incorrect timing, or not processed at all." },
      { "id": "q5", "text": "When should a reconciliation break be escalated regardless of dollar size?", "options": ["When the same type of break appears across multiple accounts, indicating a potential systematic error", "When the break is more than $100", "When the break has persisted for more than one day", "When the client has a meeting scheduled within 30 days"], "correct": 0, "explanation": "A systematic error — the same break type across multiple accounts — can have an aggregate impact far larger than any individual instance suggests. It requires immediate escalation regardless of per-account dollar amount." },
      { "id": "q6", "text": "Which element of the reconciliation record proves that the break was actually resolved?", "options": ["Verification: confirmation that the resolution was reflected in both systems", "The escalation record showing who was notified", "The date of the reconciliation run", "The signature of the portfolio manager"], "correct": 0, "explanation": "Documenting that the resolution was confirmed in both systems is the final step. Without this, the record shows an investigation was conducted but not that the problem was actually fixed." },
      { "id": "q7", "text": "A price break shows the portfolio system valuing 100 shares at $48/share while the custodian shows $52/share. What is the most likely investigation step?", "options": ["Compare the price sources: check whether both systems are using the same pricing service and the same valuation time", "Assume the custodian is correct and update the portfolio system", "Assume the portfolio system is correct since it is the internal record", "Report the break as unresolvable and escalate to the custodian"], "correct": 0, "explanation": "Price breaks most often stem from different pricing sources or different valuation times. Identifying which price is 'correct' requires knowing each system's price feed and methodology." },
      { "id": "q8", "text": "What is the relationship between daily reconciliation discipline and client protection?", "options": ["Rigorous daily reconciliation catches errors, fraud, and systematic problems before they appear in client accounts or reports", "Daily reconciliation is primarily a regulatory requirement with limited client benefit", "Reconciliation protects the firm from liability but does not directly benefit clients", "Client protection comes from insurance, not operational processes"], "correct": 0, "explanation": "Reconciliation is the operational mechanism by which errors are caught before they cause client harm. Firms with rigorous reconciliation practices catch problems early; those without them find out about problems from clients or regulators." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 17;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Personal Net Worth Statement",
      "summary": "The balance sheet of a client's financial life — how to build it correctly from documents.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Net worth equals assets minus liabilities. It is the single most useful financial scorecard for a household — more informative than income, more actionable than a single account balance. Building it accurately from documents, not from memory, is the foundation of every financial planning engagement." },
        { "type": "heading", "text": "Asset categories" },
        { "type": "list", "items": [
          "<strong>Liquid assets:</strong> checking, savings, money market — what could be accessed within 30 days without significant cost",
          "<strong>Investment assets:</strong> taxable brokerage accounts, held-away accounts",
          "<strong>Retirement assets:</strong> 401(k), 403(b), IRA, Roth IRA, pension present value — each separately",
          "<strong>Real property:</strong> primary residence, rental property, land — use current fair market value, not purchase price",
          "<strong>Personal property:</strong> vehicles, jewelry, collectibles — use current market value, not insured value",
          "<strong>Business interests:</strong> ownership in private businesses — requires valuation discussion"
        ]},
        { "type": "heading", "text": "Liability categories" },
        { "type": "list", "items": [
          "Mortgage balance (remaining principal, not original loan amount)",
          "Home equity line balance",
          "Auto loans",
          "Student loans (federal and private separately)",
          "Credit card balances",
          "Personal loans, medical debt",
          "Business liabilities where the client is personally liable"
        ]},
        { "type": "callout", "kind": "key", "title": "The as-of date matters", "text": "A net worth statement is a snapshot in time. Every figure must be as of the same date — using today's checking balance and last quarter's investment statement overstates or understates net worth. Pull everything as of the same date, typically month-end." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Household Cash Flow Statement",
      "summary": "Income in, expenses out, and the number that determines what is possible.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow statement shows what is happening with money in motion — as opposed to the net worth statement, which shows money at rest. Together they give a complete picture of the client's financial position." },
        { "type": "callout", "kind": "key", "title": "Build from documents, not from memory", "text": "Ask clients to estimate their monthly spending and most will be wrong by 20-40%. The accurate approach: pull 3-6 months of bank and credit card statements, categorize every transaction, then calculate the average. This takes longer but produces a plan that reflects reality." },
        { "type": "heading", "text": "Income sources to capture" },
        { "type": "list", "items": [
          "W-2 employment income (gross AND net — both matter)",
          "Self-employment and business income (net of business expenses)",
          "Rental income (net of operating expenses, before debt service)",
          "Social Security, pension, or annuity income",
          "Investment income: dividends, interest, capital gain distributions",
          "Alimony or support received (if applicable and documented)",
          "Any other regular income source"
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Key Financial Ratios",
      "summary": "The numbers that flag problems before they become crises.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial ratios convert the raw data of the financial statements into diagnostic signals. Used consistently over time, they identify trends that neither the client nor the advisor would notice from the raw numbers alone." },
        { "type": "glossary", "terms": [
          { "term": "Savings rate", "definition": "Annual savings divided by gross annual income. The single most important number in long-term financial planning. A savings rate below 10% in the wealth-building years is a structural problem." },
          { "term": "Debt-to-income ratio (DTI)", "definition": "Total monthly debt payments divided by gross monthly income. Above 43% is a structural stress indicator. Lenders typically limit to 36-43% for new debt." },
          { "term": "Liquidity ratio", "definition": "Liquid assets divided by monthly expenses. Measures how many months the client could maintain their lifestyle without income. Target: 3-6 months minimum." },
          { "term": "Solvency ratio", "definition": "Total assets divided by total liabilities. Above 1.0 means the client is solvent (assets exceed debts). Declining solvency over time is a warning sign." }
        ]},
        { "type": "activity", "title": "Calculate the Key Ratios", "prompt": "Using the following data, calculate and interpret each financial ratio.", "steps": [
          "Gross income: $110,000/year. Monthly net income: $6,500. Annual savings (to 401k + savings account): $9,500.",
          "Monthly debt payments: mortgage $2,100, car $420, student loan $280 = total $2,800.",
          "Liquid assets: $22,000. Monthly essential expenses: $5,500.",
          "Total assets: $485,000. Total liabilities: $312,000.",
          "Calculate savings rate, DTI, liquidity ratio, and solvency ratio. Identify which ratio(s) indicate a potential concern."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Year-Over-Year Comparison",
      "summary": "The real value of financial statements is the trend they reveal over time.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A single financial statement is a snapshot. Two financial statements from consecutive years are a story. The year-over-year comparison reveals whether net worth is growing, whether savings are accumulating, and whether ratios are improving or declining — information the annual snapshot alone cannot provide." },
        { "type": "callout", "kind": "key", "title": "Net worth growth as the primary scorecard", "text": "If a client is making consistent financial decisions, their net worth should grow every year — not necessarily by a large amount, and not necessarily in a straight line, but in a consistent direction. Flat or declining net worth over two or more years signals that something in the plan is not working, even if the client feels like they are doing the right things." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Financial Statements to Clients",
      "summary": "The statements are only useful if the client understands them and acts on what they reveal.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Walking a client through their financial statements for the first time is a significant professional moment. Many clients have never seen their financial life organized this clearly. The advisor's job is to make the numbers meaningful — to connect them to the goals the client expressed in discovery." },
        { "type": "callout", "kind": "do", "title": "The presentation sequence", "text": "Start with net worth: 'Here is your overall financial position today — what you own versus what you owe.' Then move to cash flow: 'Here is how money is moving through your household each month.' Then to ratios: 'Here are three key measures that tell us whether you are on track.' Then to year-over-year: 'Here is how these numbers have changed since we last did this together.' Each layer adds context to the previous one." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why must all figures in a net worth statement be as of the same date?", "options": ["Using different dates for different assets and liabilities produces an inaccurate picture — the snapshot must be consistent to be meaningful", "SEC regulations require same-date financial statements", "Different dates make the statement harder to audit", "The accounting software requires consistent dates for proper formatting"], "correct": 0, "explanation": "Net worth is a point-in-time calculation. Mixing a current checking balance with a prior-quarter investment statement produces a statement that reflects no actual moment in time accurately." },
      { "id": "q2", "text": "What is the most reliable method for building an accurate monthly cash flow statement?", "options": ["Pull 3-6 months of bank and credit card statements, categorize every transaction, and calculate the average", "Ask the client to estimate their monthly spending by category", "Use the client's stated income minus their stated fixed expenses", "Apply industry-average spending percentages to the client's income"], "correct": 0, "explanation": "Client spending estimates are consistently 20-40% below actual spending. Statement-based categorization is the only approach that reflects what actually happened." },
      { "id": "q3", "text": "What does a savings rate below 10% indicate for a client in their peak earning years?", "options": ["A structural problem — the gap between income and savings is too large to reach most long-term financial goals", "Normal behavior for most American households", "A temporary situation that will self-correct as income grows", "A sign that the client has significant investment income supplementing savings"], "correct": 0, "explanation": "A savings rate below 10% in the accumulation years makes long-term goal funding very difficult. This is a structural issue that must be addressed through the financial plan." },
      { "id": "q4", "text": "A client has total monthly debt payments of $2,800 and gross monthly income of $7,500. What is their debt-to-income ratio?", "options": ["37.3% — within the commonly cited 36-43% guideline, but approaching the upper limit", "26.5% — comfortably below the 36% preferred threshold", "43% — exactly at the typical lending limit", "It cannot be calculated from the information provided"], "correct": 0, "explanation": "$2,800 ÷ $7,500 = 37.3%. This is within the 36-43% range that lenders typically accept but leaves little room for additional debt without creating financial stress." },
      { "id": "q5", "text": "A client has liquid assets of $22,000 and monthly essential expenses of $5,500. What is their liquidity ratio and what does it indicate?", "options": ["4 months — within the 3-6 month target range, adequate but not comfortable", "Below target — the client needs to build their emergency fund immediately", "Above target — the client has excess cash that should be invested", "Cannot be determined without knowing total assets"], "correct": 0, "explanation": "$22,000 ÷ $5,500 = 4 months. This is within the 3-6 month target, meaning the emergency fund is adequate but not at the upper end of the recommended range." },
      { "id": "q6", "text": "What does a declining solvency ratio (total assets / total liabilities) over three consecutive years signal?", "options": ["Liabilities are growing faster than assets — a structural financial warning sign that warrants immediate discussion", "The client is successfully paying down debt faster than their assets grow", "Normal variation in financial ratios due to market fluctuations", "The ratio is not meaningful unless it falls below 1.0"], "correct": 0, "explanation": "A declining solvency ratio means liabilities are growing relative to assets — the client is moving toward a weaker financial position. Even if still above 1.0, the trend is the warning." },
      { "id": "q7", "text": "In what sequence should an advisor present financial statements to a client for maximum clarity?", "options": ["Net worth first (position), then cash flow (movement), then ratios (diagnostics), then year-over-year (trend)", "Cash flow first, then net worth, then projections", "Ratios first to show where problems are, then documents to support", "Year-over-year first to show progress, then current snapshot"], "correct": 0, "explanation": "The sequence builds from foundation to analysis: position establishes the starting point, movement explains how it changes, ratios diagnose health, and trends show whether progress is being made." },
      { "id": "q8", "text": "Which financial statement tells you about money 'at rest' versus money 'in motion'?", "options": ["Net worth statement = money at rest (position); cash flow statement = money in motion (flow)", "Cash flow statement = money at rest; net worth = money in motion", "Both statements measure money at rest", "Both statements measure money in motion"], "correct": 0, "explanation": "The net worth statement is a balance sheet — a snapshot of position. The cash flow statement tracks income and expenses over time — money moving through the household." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 18;

-- Module 19: Insurance Planning content is already written in module19_insurance_content.sql
-- Skipping to avoid overwriting existing content

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Advisory Fee Structures",
      "summary": "The math behind how advisors are compensated and why it matters for billing accuracy.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Advisory fees are the revenue of the practice. Getting them right — calculating them accurately, communicating them clearly, and collecting them consistently — is both a client service and a compliance responsibility." },
        { "type": "glossary", "terms": [
          { "term": "AUM-based fee", "definition": "A percentage of assets under management, charged annually and typically billed quarterly. Common range: 0.50%-1.50%. Scales with client assets; aligns advisor and client interests." },
          { "term": "Flat fee", "definition": "A fixed annual or project fee regardless of assets. Common for financial planning engagements. Predictable for both parties." },
          { "term": "Hourly fee", "definition": "A rate per hour of advisor time. Common for limited-scope engagements or standalone consultations." },
          { "term": "Fee schedule tiers", "definition": "AUM-based fees often decrease as assets increase: e.g., 1.00% on first $500K, 0.75% on next $500K, 0.50% above $1M." }
        ]},
        { "type": "activity", "title": "Fee Calculation Exercise", "prompt": "Calculate the quarterly fee for a client with $875,000 under management using the following tiered fee schedule.", "steps": [
          "Tier 1: 1.00% annually on first $500,000 = $5,000/year = $1,250/quarter",
          "Tier 2: 0.75% annually on next $375,000 ($875K - $500K) = $2,812.50/year = $703.13/quarter",
          "Total quarterly fee = $1,250 + $703.13 = $1,953.13",
          "What is the effective annual fee rate for this client?",
          "If the client's assets grew to $1,050,000 next quarter, recalculate the fee (adding Tier 3 at 0.50% on amounts above $1M)."
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Preparing and Issuing Invoices",
      "summary": "What a compliant invoice contains and how to generate it accurately.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Form ADV requires that advisory fees be calculable by the client from the information in the invoice. Every invoice must contain enough information for a client to verify they were billed correctly — this is a regulatory requirement, not just a courtesy." },
        { "type": "list", "items": [
          "Billing period (e.g., Q1 2026: January 1 – March 31)",
          "Assets under management as of the billing date",
          "Annual fee rate or tiered rate schedule",
          "Calculated fee amount for the period",
          "Payment method: direct deduction from custodian account or client payment",
          "Client name and account identifier"
        ]},
        { "type": "callout", "kind": "do", "title": "The review step before billing", "text": "Before submitting any billing cycle, run a report of all fee calculations and review a sample for accuracy. Verify: the AUM figure matches the custodian statement for the billing date. The rate tier applied matches the client's fee schedule. The billing period matches what was agreed." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Payment Tracking and Collections",
      "summary": "How advisory fees are collected, what to do when payment fails, and the professional way to follow up.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most RIAs collect advisory fees by deducting them directly from the client's custodial account. This is efficient but requires the client to have pre-authorized the deduction and requires the custodian to process it correctly." },
        { "type": "callout", "kind": "key", "title": "Confirming fee deductions", "text": "After each billing cycle, reconcile the billing system against custodian confirmation of fees deducted. The number of accounts billed should match the number of fee deductions processed. Any account where the fee was not deducted requires follow-up with the custodian before month-end." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Reconciling Billing Records",
      "summary": "Matching invoices to custodian fee deductions — the billing close process.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Billing reconciliation confirms that every fee that should have been collected was collected, at the right amount, from the right account. It is the quality control process that catches errors before they accumulate." },
        { "type": "list", "items": [
          "Compare the firm's billing system to custodian fee deduction reports",
          "Identify accounts where the deducted amount differs from the invoiced amount",
          "Investigate root cause: AUM calculation difference? Wrong rate applied? Wrong account?",
          "Prepare billing adjustments where errors are confirmed — credit or additional charge as appropriate",
          "Document all errors found, root cause, and resolution"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Fee Disclosure and Compliance",
      "summary": "The documentation trail that proves billing was accurate and authorized.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The SEC has specific requirements for how advisory fees are disclosed and documented. These requirements exist to protect clients from unauthorized fee deductions — a historically common form of advisor misconduct." },
        { "type": "list", "items": [
          "Form ADV Part 2 must disclose the fee schedule clearly — clients receive this annually",
          "The client agreement (IMA) must authorize the specific fee amount and payment method",
          "For custodian deductions, the client must sign a separate deduction authorization",
          "The fee invoice or statement must be provided to the client within 30 days of the deduction",
          "All billing records must be retained for five years"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "For an AUM-based fee with a tiered schedule, what happens to the fee rate as assets increase?", "options": ["The rate typically decreases for assets above specified thresholds — higher tiers have lower rates", "The rate increases as more assets require more management", "The rate stays constant regardless of asset level", "The rate is negotiated individually for each tier"], "correct": 0, "explanation": "Tiered fee schedules typically reduce the rate at higher asset levels. This is common practice and the client should understand that only the assets above each threshold are billed at the lower rate." },
      { "id": "q2", "text": "What information must a compliant advisory fee invoice include?", "options": ["Billing period, AUM as of billing date, applicable fee rate, calculated fee, payment method, and account identifier", "Only the total fee amount and payment due date", "The client's complete account holdings and their values", "The advisor's license number and regulatory registrations"], "correct": 0, "explanation": "Form ADV requires that clients be able to verify their fee calculation from the invoice. This requires the AUM basis, the rate, the period, and the resulting fee." },
      { "id": "q3", "text": "After a quarterly billing cycle, what reconciliation step is required?", "options": ["Compare the billing system's fee records to the custodian's confirmed fee deductions — every account billed should show a corresponding deduction", "Confirm that all clients received their invoices", "Review performance reports to ensure fees are commensurate with returns", "File a fee report with the SEC"], "correct": 0, "explanation": "Billing reconciliation confirms that every fee was actually collected at the right amount. Without this step, billing errors can persist undetected." },
      { "id": "q4", "text": "A client has $875,000 in AUM. The fee schedule is 1.00% on the first $500K and 0.75% on amounts above $500K. What is the quarterly fee?", "options": ["$1,953.13 ($1,250.00 on first $500K + $703.13 on next $375K, divided by 4)", "$2,187.50 (1.00% on all assets quarterly)", "$1,640.63 (0.75% on all assets annually divided by 4)", "$2,500.00 (1.00% on first $500K annually)"], "correct": 0, "explanation": "Tier 1: 1.00% × $500,000 = $5,000/year = $1,250/quarter. Tier 2: 0.75% × $375,000 = $2,812.50/year = $703.13/quarter. Total = $1,953.13/quarter." },
      { "id": "q5", "text": "What document authorizes the custodian to deduct advisory fees directly from a client's account?", "options": ["A separately signed fee deduction authorization — distinct from the investment management agreement", "The investment management agreement alone is sufficient", "Form ADV Part 2 disclosure", "The firm's ADV filing with the SEC"], "correct": 0, "explanation": "While the IMA establishes the fee arrangement, a separate written authorization specifically for custodian deductions is required. This is an additional client protection against unauthorized fee deductions." },
      { "id": "q6", "text": "How long must billing records be retained by a registered investment advisor?", "options": ["Five years", "Two years", "Seven years (same as tax records)", "Three years"], "correct": 0, "explanation": "SEC books and records rules require RIAs to retain billing records, including invoices and fee calculations, for five years." },
      { "id": "q7", "text": "A billing reconciliation reveals that a client was charged $150 more than their calculated fee. What is the correct resolution?", "options": ["Credit the client's account for $150 and document the error, root cause, and resolution", "Apply the overage to the next billing cycle", "Notify the client and ask if they want a refund", "No action required if the amount is below a materiality threshold"], "correct": 0, "explanation": "Fee errors must be corrected immediately and documented completely. Billing clients more than the agreed fee is a compliance violation regardless of the dollar amount." },
      { "id": "q8", "text": "The fee review step before a billing cycle is sent should verify what three things?", "options": ["AUM matches the custodian statement for the billing date, the rate tier applied matches the client's fee schedule, and the billing period matches the agreement", "The advisor's license is current, the client's address is correct, and the account is active", "The performance report is complete, the compliance review is done, and the client has been contacted", "The fee is competitive, the billing system is updated, and the custodian has been notified"], "correct": 0, "explanation": "These three checks catch the most common billing errors: wrong AUM basis, wrong fee rate, and wrong billing period." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 20;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Data Entry Standard",
      "summary": "Why accuracy is not optional and what the consequences of bad data actually look like.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every system in an advisory practice — the CRM, the financial planning software, the portfolio management system, the billing system — depends on accurate data entry. An error in one system propagates to every report, recommendation, and client communication built from it." },
        { "type": "callout", "kind": "key", "title": "The cascading error problem", "text": "A transposed digit in a client's date of birth affects Social Security benefit calculations. An incorrect account balance in the planning system produces an inaccurate retirement projection. An error in the CRM address field results in compliance documents going to the wrong location. Data errors are rarely contained to where they originate." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "CRM Data Entry Workflows",
      "summary": "The fields that matter most, the workflows that keep them current, and the errors that are most common.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Setting up a new client in the CRM is the first data entry task in any client relationship and one of the highest-stakes. Errors made at setup propagate through every subsequent interaction." },
        { "type": "list", "items": [
          "<strong>Demographics:</strong> full legal name (must match account documentation), date of birth, SSN (encrypted), contact information",
          "<strong>Employment:</strong> employer, title, income source — affects planning recommendations",
          "<strong>Family:</strong> spouse/partner, dependents with ages — affects estate planning, insurance, and college planning",
          "<strong>Accounts:</strong> all accounts linked by custodian account number — must match custodian records exactly",
          "<strong>Relationships:</strong> household links, professional contacts (CPA, attorney) — critical for coordinated service"
        ]},
        { "type": "callout", "kind": "warn", "title": "Duplicate records", "text": "A duplicate client record — two profiles for the same person — is one of the most disruptive data quality problems in a CRM. It creates split interaction histories, double billing risk, and compliance documentation gaps. Before creating a new client record, always search by name AND email AND phone to check for an existing record." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Financial Planning System Entry",
      "summary": "Entering client data into planning software accurately — the foundation of every projection and recommendation.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial planning software (eMoney, MoneyGuidePro, RightCapital, etc.) builds projections from the data you enter. Garbage in, garbage out — an inaccurate input produces a confidently wrong output." },
        { "type": "activity", "title": "Data Entry Accuracy Check", "prompt": "After entering a client's financial data into the planning software, complete this verification checklist before saving.", "steps": [
          "Compare all account balances to the custodian statements — do the totals match?",
          "Verify income figures against the pay stub or tax return — is this gross or net?",
          "Check that the retirement account contribution rate matches the plan document, not just what the client said.",
          "Verify Social Security estimated benefit from the SSA statement, not from client memory.",
          "Check beneficiary designations entered against the actual forms — not the client's description of who they named.",
          "Save the entry and generate a summary report. Review it for any obviously wrong numbers before the advisor sees it."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Speed and Accuracy Techniques",
      "summary": "How to be fast without making mistakes — the professional data entry habits that scale.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Speed and accuracy are not opposites in data entry — they are both products of good habits and workflow discipline. The fastest accurate data entry comes from consistent processes, not from rushing." },
        { "type": "list", "items": [
          "<strong>Always verify as you enter</strong> — look at the source document while typing, then look at the screen before moving to the next field",
          "<strong>Use tab, not mouse</strong> — tabbing through fields is faster than clicking and reduces input errors",
          "<strong>Double-check number-critical fields</strong> — account numbers, SSNs, dollar amounts. Read them back digit by digit",
          "<strong>Use templates for repetitive entries</strong> — standardized formats for common data types reduce cognitive load and errors",
          "<strong>Never enter from memory</strong> — every entry should have a source document visible alongside the entry screen"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Data Governance and Security",
      "summary": "Who can see what, how sensitive data is protected, and your personal responsibility for data security.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client financial data is among the most sensitive information a professional handles. The responsibility to protect it is both ethical and legal — and it starts with every data entry decision." },
        { "type": "callout", "kind": "warn", "title": "The personal liability for data breaches", "text": "A firm employee who mishandles client data — shares login credentials, accesses accounts outside their job function, or transmits sensitive data over unsecured channels — can face personal liability under data protection laws. This is not a technical problem handled by IT; it is a personal professional responsibility." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why does a data entry error in a client's date of birth matter for financial planning?", "options": ["It affects Social Security benefit projections, Medicare eligibility modeling, and retirement age calculations — all tied to birth date", "It only affects compliance documentation and has no planning impact", "It matters only for account opening documents, not for planning", "It affects the client's account number assignment in the system"], "correct": 0, "explanation": "Date of birth is used in retirement projections, Social Security benefit modeling, Medicare eligibility, and RMD calculations. An incorrect birth date produces incorrect outputs in every one of these calculations." },
      { "id": "q2", "text": "Before creating a new client record in the CRM, what step must always be completed first?", "options": ["Search by name, email, AND phone to check whether the client already has a record — preventing duplicate profiles", "Verify the client has signed the advisory agreement", "Confirm the client's identity with a government-issued ID", "Check the client's credit history"], "correct": 0, "explanation": "Duplicate client records create serious operational and compliance problems. A three-field search (name, email, phone) is the minimum check before creating any new record." },
      { "id": "q3", "text": "When entering income into financial planning software, what is the most important distinction to make?", "options": ["Whether the figure is gross income or net income — the planning software needs to know which it is receiving", "Whether the income is from employment or self-employment", "Whether the income is annual or monthly", "Whether the income is taxable or tax-exempt"], "correct": 0, "explanation": "Planning software may build different projections from gross vs. net income. Entering gross income into a field that expects net (or vice versa) produces significantly inaccurate cash flow and savings analyses." },
      { "id": "q4", "text": "What is the 'cascading error problem' in data entry?", "options": ["An error entered in one field propagates to every report, projection, and recommendation built from that field", "A single large error that causes an entire system to fail", "A pattern of errors that accumulates from too many data entries in a short period", "An error that causes other users to make the same mistake"], "correct": 0, "explanation": "Data errors rarely stay isolated. An incorrect balance in the planning system affects every projection. An incorrect address in the CRM affects every compliance document. Errors cascade through every downstream output." },
      { "id": "q5", "text": "What is the most reliable technique for entering a 12-digit account number accurately?", "options": ["Read the number from the source document digit by digit, then read the entered number back before moving on", "Enter it once from memory, then enter it again to verify the match", "Copy and paste from a digital document to avoid manual entry errors", "Have a colleague verify the entry immediately after input"], "correct": 0, "explanation": "Reading digit by digit from source to screen, then reading back what was entered, is the most reliable manual verification technique for numeric fields where a single transposition creates a significant error." },
      { "id": "q6", "text": "A client mentions their Social Security benefit will be 'about $2,400 a month.' Where should this figure be verified before entering it into the planning system?", "options": ["The client's official Social Security statement from ssa.gov — not the client's estimate from memory", "The most recent Social Security Administration announcement of benefit amounts", "The advisor's experience with similar client profiles", "A Social Security benefit calculator that uses the client's income history"], "correct": 0, "explanation": "The SSA statement is the authoritative source for estimated Social Security benefits. Client memory estimates are frequently inaccurate by $200-400/month or more." },
      { "id": "q7", "text": "What is the professional data entry habit for every field entry?", "options": ["Look at the source document while typing, then look at the screen before moving to the next field", "Enter all data first, then review the entire form before saving", "Use autofill to reduce manual entry and potential errors", "Type quickly to improve productivity, then verify at the end"], "correct": 0, "explanation": "The verify-as-you-enter habit catches errors at the moment of entry, when they are easiest to correct. Reviewing after the fact misses many errors because you read what you expect to see." },
      { "id": "q8", "text": "What is the personal liability risk for a firm employee who shares their system login credentials with a colleague?", "options": ["Personal liability under data protection laws — sharing credentials creates unauthorized access and eliminates the audit trail", "No personal liability — the firm assumes responsibility for all system access", "Liability only if a data breach results from the shared access", "A minor violation addressed through the firm's internal HR process"], "correct": 0, "explanation": "Sharing login credentials eliminates the individual accountability that system access controls are designed to maintain. It creates unauthorized access (the colleague's access level may be different) and destroys the audit trail. This can result in personal regulatory sanction." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 21;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Regulators Look For",
      "summary": "How the SEC examination process works, what examiners request, and what they actually look at.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "An SEC examination is not a random audit. Examiners use a risk-based selection process to identify firms and practices for review. Knowing what triggers an examination and what examiners look at first is the foundation of meaningful audit readiness preparation." },
        { "type": "heading", "text": "What triggers an examination" },
        { "type": "list", "items": [
          "Routine examinations: most RIAs are examined every 5-10 years as part of the regular examination cycle",
          "Risk-based selection: firms with higher-risk characteristics (rapid growth, concentrated client types, related-party transactions) are examined more frequently",
          "For-cause examinations: triggered by a specific complaint, suspicious activity, or tip",
          "New registration: newly registered RIAs are often examined within the first two years"
        ]},
        { "type": "callout", "kind": "key", "title": "Day 1 document request", "text": "When the SEC notifies a firm of an examination, they typically send a document request list immediately. This list includes client files (often a sample of 5-10 accounts), the firm's policies and procedures, compliance testing records, personal trading reports, and marketing materials. If these are organized and complete, the examination proceeds smoothly. If they have to be reconstructed, everything takes longer and looks worse." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Client File Standard",
      "summary": "What a complete, compliant client file contains — and the most common gaps that create deficiencies.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client files are the primary unit of review in an SEC examination. Each selected file must contain the evidence that the firm followed its stated policies and met its fiduciary obligations for that client." },
        { "type": "list", "items": [
          "Signed investment management agreement with current fee schedule",
          "Form ADV Part 2 delivery receipt (signed and dated)",
          "Completed suitability questionnaire or risk assessment",
          "Investment policy statement or documented investment objective",
          "Beneficiary designation forms (if applicable)",
          "Signed fee deduction authorization (if fees are deducted from custodian accounts)",
          "Current account statements",
          "Interaction logs for recent client contacts",
          "Documentation of any investment changes made and the rationale"
        ]},
        { "type": "callout", "kind": "warn", "title": "The most common file gaps", "text": "Missing ADV Part 2 delivery confirmation. Suitability documentation that describes the outcome but not the reasoning. Outdated investment objectives — documented three years ago without an annual review note. Missing rationale for investment changes. These are the deficiencies that appear most frequently in examination reports." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Conducting a Self-Audit",
      "summary": "The internal review process that finds problems before regulators do.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The most effective audit preparation is ongoing — not a scramble when the examination notice arrives. A quarterly file review against the compliance checklist identifies gaps in real time, when they are easy to correct." },
        { "type": "activity", "title": "Self-Audit Checklist Exercise", "prompt": "Select three client files (actual or hypothetical) and complete a self-audit against the required documentation list.", "steps": [
          "Check each file against the 9-item document checklist from Lesson 2.",
          "For each missing item, note when it should have been obtained and what would be required to obtain it now.",
          "For suitability documentation, read it and ask: 'Could a regulator understand from this document why this investment strategy is appropriate for this specific client?'",
          "Score each file: how many of the 9 required items are present and current?",
          "Identify the most common gap across the three files — that gap represents a systematic issue in the firm's process."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Record Retention Requirements",
      "summary": "What must be kept, for how long, and what happens to records that were supposed to be kept but weren't.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Record retention is not discretionary. SEC rules specify minimum retention periods, and destroying records that should have been kept — even if done routinely as 'housekeeping' — is a compliance violation." },
        { "type": "list", "items": [
          "<strong>Five years (most records):</strong> client files, correspondence, performance records, trade records, financial records, compliance records",
          "<strong>Five years from date of last use:</strong> policy and procedure manuals, compliance testing records",
          "<strong>First two years in easily accessible location:</strong> records must be quickly producible, not just retained in archival storage",
          "<strong>Electronic records:</strong> must be maintained in a non-rewriteable, non-erasable format (WORM) or equivalent"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Responding to an Examination",
      "summary": "How to conduct yourself professionally during an examination and what happens afterward.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "An SEC examination is a professional proceeding. The examiners are doing their job. Your job is to cooperate fully, respond accurately, and present the firm's operations in the most organized and transparent manner possible." },
        { "type": "callout", "kind": "do", "title": "The three rules during an examination", "text": "1. Be accurate — answer what was asked, nothing more, nothing less. Never speculate or guess. 2. Be organized — have requested documents ready promptly. Delays signal disorganization. 3. Be professional — examiners are not adversaries. The examination proceeds more smoothly when the firm treats it as a routine professional process." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is a 'for-cause' SEC examination?", "options": ["An examination triggered by a specific complaint, suspicious activity, or regulatory tip — targeted rather than routine", "An examination that occurs automatically when a firm exceeds $100M in AUM", "An examination focused on a specific cause such as performance reporting", "A routine examination of newly registered RIAs"], "correct": 0, "explanation": "For-cause examinations are triggered by specific information — a client complaint, a suspicious pattern, or a tip from a whistleblower. They focus on the specific concern rather than the full breadth of firm operations." },
      { "id": "q2", "text": "What document must be signed and retained to prove a client received the Form ADV Part 2?", "options": ["A signed and dated delivery receipt acknowledging that the client received the ADV Part 2", "The client's signed investment management agreement", "An email confirmation from the client", "A note in the CRM interaction log"], "correct": 0, "explanation": "SEC rules require that clients receive the ADV Part 2 annually and that delivery be documented. A signed receipt is the most defensible form of proof." },
      { "id": "q3", "text": "What is the most common suitability documentation gap found in SEC examinations?", "options": ["Documentation that describes the recommendation outcome but not the reasoning behind why it was suitable for the client", "Missing the client's signature on the suitability questionnaire", "Failure to document the client's stated risk tolerance", "Not including performance benchmarks in the suitability record"], "correct": 0, "explanation": "Examiners want to see reasoning, not just outcomes. A document that says 'client is moderate risk, recommended balanced portfolio' without explaining why the recommendation is suitable for the specific client's situation is inadequate." },
      { "id": "q4", "text": "For how long must most RIA books and records be retained?", "options": ["Five years — with the first two years in an easily accessible location", "Seven years, consistent with federal tax record retention", "Three years, consistent with the statute of limitations for most disputes", "Permanently for all client-related records"], "correct": 0, "explanation": "SEC Rule 204-2 requires a five-year retention period for most books and records. The first two years must be maintained in a location where they can be quickly produced for examination." },
      { "id": "q5", "text": "What format must electronic records be maintained in for SEC compliance?", "options": ["Non-rewriteable, non-erasable format (WORM) or equivalent — preventing alteration of retained records", "Standard word processing format accessible by the SEC's document review system", "PDF format with digital signature",  "Cloud storage with multi-factor authentication"], "correct": 0, "explanation": "WORM (write once, read many) format ensures that retained electronic records cannot be altered after the fact. This is the technical requirement underlying the record integrity requirement." },
      { "id": "q6", "text": "During an SEC examination, an examiner asks a question you are unsure about. What is the correct response?", "options": ["Say you are not certain and offer to follow up with accurate information rather than guessing", "Provide your best estimate and note it is approximate", "Refer the examiner to the compliance department without answering", "State that you are not authorized to respond to that question"], "correct": 0, "explanation": "Accuracy is paramount. An inaccurate statement to an examiner creates more problems than saying 'I don't know and will get you the correct answer.' Guessing and being wrong suggests concealment or carelessness." },
      { "id": "q7", "text": "What does a firm's self-audit of client files most effectively accomplish?", "options": ["Identifying documentation gaps in real time, when they are easy to correct — before an examiner finds them first", "Generating required reporting for annual ADV filing", "Satisfying the SEC's requirement for annual internal review", "Providing evidence for the firm's annual compliance attestation"], "correct": 0, "explanation": "Self-auditing is most valuable as an early-warning system. A gap found internally can be corrected; a gap found by a regulator becomes a deficiency in the examination report." },
      { "id": "q8", "text": "Which client file element is specifically designed to document why an investment strategy is appropriate for that specific client?", "options": ["The suitability documentation — connecting the client's risk profile, objectives, and constraints to the investment recommendation", "The signed investment management agreement", "The Form ADV Part 2 delivery receipt", "The annual performance report"], "correct": 0, "explanation": "Suitability documentation is the professional and regulatory evidence that the advisor understood the client's situation and made a recommendation that fits it. Without this, the advisor cannot demonstrate they met the fiduciary standard." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 22;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "How an Advisory Practice Actually Works",
      "summary": "The org chart, the workflows, and where handoffs between teams create both efficiency and failure.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "An advisory practice is a service operation. It delivers value through the coordinated effort of multiple people — the advisor, the associate, operations, compliance, and the custodian. Understanding who does what, and where the handoffs happen, is the foundation of effective coordination." },
        { "type": "glossary", "terms": [
          { "term": "Lead advisor", "definition": "The licensed professional responsible for the client relationship and investment recommendations. The primary decision-maker for client strategy." },
          { "term": "Associate advisor / apprentice", "definition": "Supports the lead advisor with discovery, documentation, preparation, and client service tasks. In training to take on more client responsibility." },
          { "term": "Operations associate", "definition": "Handles account administration, money movement, account openings, and custodian coordination. Not a licensed advisor role." },
          { "term": "Compliance officer", "definition": "Ensures the firm operates within regulatory requirements. Reviews marketing materials, monitors personal trading, and prepares for regulatory examinations." },
          { "term": "Custodian", "definition": "The institution (Schwab, Fidelity, Pershing, etc.) that holds client assets and executes trades. Not the client's advisor — a service provider to both the advisor and the client." }
        ]},
        { "type": "callout", "kind": "key", "title": "Where breakdowns happen", "text": "Most service failures in advisory practices happen at handoffs — when work transitions from one person or team to another. The task seems like someone else's problem at the exact moment when it needs to be claimed and completed. Your role is to make handoffs explicit: 'I'm sending this to you now. It needs to be done by [date]. Please confirm you have it.'" }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Writing Effective Internal Communications",
      "summary": "The email, the task, and the handoff note that actually get things done.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Internal communication is where clarity lives or dies. An unclear request creates a unclear response — or no response at all. The discipline of writing precisely and including the right context is as important internally as it is in client communications." },
        { "type": "list", "items": [
          "<strong>Subject line:</strong> 'Action Required: Client Smith — 401(k) Rollover, Needed by Friday' > 'Quick question'",
          "<strong>Action statement first:</strong> 'Please process the attached 401(k) rollover for Client Smith.' Then provide context.",
          "<strong>Specific deadline:</strong> 'By close of business Friday, March 22.' Not 'as soon as possible.'",
          "<strong>Clear escalation path:</strong> 'If you have questions or need more information, call me directly at [number].'",
          "<strong>Confirmation request:</strong> 'Please confirm receipt and that you can meet this deadline.'"
        ]},
        { "type": "activity", "title": "Internal Communication Rewrite", "prompt": "Rewrite this ineffective internal email into an effective one.", "steps": [
          "Original: 'Hi Sarah, FYI the Smith account needs some stuff done. I talked to them yesterday and they want to move some money. Let me know. Thanks'",
          "Identify what is wrong with the original: what information is missing?",
          "Write an effective version that includes: what action is needed, which client and which account, the deadline, any required attachments or information, and a confirmation request.",
          "What is the minimum information operations needs to process a money movement request correctly?"
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Task and Project Management",
      "summary": "The tools and habits that keep work moving when everything feels urgent.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Advisory practices operate in a constant state of competing priorities. Client meetings, deadline-driven tasks, regulatory filings, and ad-hoc requests arrive simultaneously. Without a systematic approach to managing work, important tasks get lost in the noise." },
        { "type": "callout", "kind": "do", "title": "The daily task review habit", "text": "Every morning before client contact begins: review the task list. What is due today? What is overdue? What needs to be started today to meet a future deadline? The advisor who knows their task list at 8am is the advisor who delivers on commitments consistently." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Working with Custodian Operations",
      "summary": "What the custodian needs from you, how to submit requests correctly, and how to prevent the most common processing errors.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The custodian is one of the most important operational partners in an advisory practice. Account openings, money movements, trades, and transfers all flow through the custodian. Understanding how to interact with them correctly prevents delays and errors that affect clients." },
        { "type": "list", "items": [
          "<strong>Account openings:</strong> most custodians require specific forms with specific fields completed. A single missing field can reject the entire application.",
          "<strong>Money movement:</strong> wire transfers, ACH transfers, and check disbursements each have different timelines, cutoff times, and verification requirements.",
          "<strong>In-kind transfers (ACAT):</strong> transferring securities from another institution takes 5-7 business days on average. Clients must be told this, and the timeline tracked.",
          "<strong>Trade settlement:</strong> equities settle T+1, bonds settle T+1, mutual funds settle T+1. Transactions must be timed with settlement in mind for money movement planning."
        ]},
        { "type": "callout", "kind": "warn", "title": "Cutoff times are not suggestions", "text": "Wire transfer cutoff times at most custodians are 3:00-4:00 PM Eastern. A request submitted at 3:01 PM does not process that day. For time-sensitive client money movements, always confirm the cutoff time and submit well before it." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Building Reliable Relationships with Operations Colleagues",
      "summary": "Why the quality of your relationships with operations staff directly affects client service.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "The advisor who is known for submitting complete, accurate requests — and who responds promptly when operations needs additional information — will always receive faster and better service than the advisor who submits sloppy requests and is hard to reach. Reliability creates reciprocity." },
        { "type": "callout", "kind": "do", "title": "The three professional habits that build ops relationships", "text": "1. Submit complete, accurate requests the first time. 2. Respond to operations inquiries within 2 hours. 3. Acknowledge when operations does something well — it is noticed and remembered." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Where do most service failures in advisory practices occur?", "options": ["At handoffs between people or teams — when a task transitions from one owner to another without explicit confirmation", "During client meetings when complex topics are discussed", "During market volatility when portfolio decisions must be made quickly", "During the account opening process when documents are complex"], "correct": 0, "explanation": "Handoffs are the highest-risk moments in any workflow. The task is moving from 'my responsibility' to 'your responsibility' — and without explicit confirmation, it often falls through the gap." },
      { "id": "q2", "text": "Which internal email subject line is most effective?", "options": ["'Action Required: Smith Account — 401(k) Rollover, Needed by Friday'", "'Quick question about a client'", "'FYI — money movement'", "'When you have a chance'"], "correct": 0, "explanation": "An effective subject line tells the reader immediately what action is needed, which client it involves, and when the deadline is. This allows proper prioritization without opening the email." },
      { "id": "q3", "text": "What is the standard trade settlement period for US equities under current rules?", "options": ["T+1 — settlement occurs one business day after the trade date", "T+2 — settlement occurs two business days after the trade date", "T+0 — same-day settlement for all equities", "T+3 — settlement occurs three business days after the trade date"], "correct": 0, "explanation": "US equities moved to T+1 settlement in 2024. This means a trade executed on Monday settles on Tuesday. Money movement must be planned with this timeline in mind." },
      { "id": "q4", "text": "A wire transfer request is submitted to the custodian at 3:30 PM Eastern on a day when the cutoff is 3:00 PM. What happens?", "options": ["The wire processes the next business day — it missed the cutoff for same-day processing", "The wire processes that evening through the bank's after-hours system", "The custodian will hold it until the client calls to confirm", "It processes same-day because the cutoff is a guideline, not a hard rule"], "correct": 0, "explanation": "Wire transfer cutoffs are firm deadlines. Any request submitted after cutoff processes on the next business day. For time-sensitive transfers, submit well before the cutoff." },
      { "id": "q5", "text": "How long does an in-kind transfer (ACAT) between custodians typically take?", "options": ["5-7 business days on average", "1-2 business days", "2-3 weeks", "Same day for most securities"], "correct": 0, "explanation": "ACAT transfers involve both the sending and receiving custodian coordinating the movement of securities. The standard timeline is 5-7 business days, though it can vary. Clients must be informed of this timeline upfront." },
      { "id": "q6", "text": "What is the minimum information required in an internal request to operations for a money movement?", "options": ["Client name, account number, amount, destination, timeline, and authorization source", "Client name and amount only — operations can look up the rest", "A signed client authorization is sufficient", "The advisor's verbal instruction is sufficient for routine movements"], "correct": 0, "explanation": "Money movement requests require complete, specific information to prevent errors. Missing any of these elements can cause the request to be rejected, delayed, or — worst case — processed incorrectly." },
      { "id": "q7", "text": "What distinguishes an operations associate from a lead advisor in terms of client-facing activities?", "options": ["Operations associates handle account administration and custodian coordination but do not provide investment advice or make suitability determinations — that requires a licensed advisor", "Operations associates can provide investment recommendations for accounts below $250K", "Operations associates are responsible for client relationship management", "Operations associates hold the same licenses as lead advisors but focus on back-office work"], "correct": 0, "explanation": "Investment advice and suitability determinations are reserved for licensed advisors. Operations associates provide essential non-advisory support — account management, money movement, custodian coordination — without engaging in licensed activity." },
      { "id": "q8", "text": "Which professional habit most effectively builds a positive relationship with custodian operations staff?", "options": ["Submitting complete, accurate requests the first time — reducing the back-and-forth that frustrates operations teams", "Calling the custodian relationship manager to expedite all requests", "Escalating to senior management when requests are not processed promptly", "Following up on every request within one hour to signal urgency"], "correct": 0, "explanation": "Operations professionals process dozens of requests daily. Advisors who consistently submit complete requests — eliminating the need for follow-up clarification — earn a reputation for reliability that results in better, faster service." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 23;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Every Advisory Meeting Needs",
      "summary": "The minimum packet for a client meeting and how to assemble it efficiently.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A well-prepared advisory meeting has a clear agenda, relevant materials, and an advisor who walks in knowing exactly what happened since the last meeting and what needs to happen in this one. The materials you prepare either enable a productive conversation or force the advisor to fill time." },
        { "type": "list", "items": [
          "<strong>Agenda</strong> — what will be discussed, in what order, how long each topic is expected to take",
          "<strong>Performance report</strong> — current quarter, year-to-date, versus benchmark",
          "<strong>Account summary</strong> — current holdings, allocation vs. target",
          "<strong>Open action items from the last meeting</strong> — status of every commitment made by both the advisor and the client",
          "<strong>Planning updates</strong> — any changes to the financial plan since the last meeting",
          "<strong>Documents requiring signature</strong> — flagged clearly so they are not missed"
        ]},
        { "type": "callout", "kind": "key", "title": "The purpose of the meeting drives the materials", "text": "An annual review meeting needs a comprehensive packet. A 30-minute check-in call needs only a brief agenda and the one or two items being discussed. Over-preparing creates noise; under-preparing creates gaps. Match the materials to the purpose." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Customizing Materials for the Client",
      "summary": "The meeting packet for Client A should not look like the meeting packet for Client B.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client is different. The materials you prepare for a 70-year-old retiree focused on income and estate planning should look nothing like the materials for a 38-year-old accumulator focused on growth and debt management. Generic packets communicate that the advisor is not paying attention." },
        { "type": "list", "items": [
          "What has changed for this client since the last meeting? (job change, family change, windfall, concern expressed?)",
          "What does this client typically ask about? (performance? planning progress? specific accounts?)",
          "Is there a decision that needs to be made at this meeting? What information does the client need to make it?",
          "Are there any known concerns or anxieties this client has? How will the materials address them?"
        ]},
        { "type": "callout", "kind": "do", "title": "The pre-meeting client profile review", "text": "Before preparing any meeting materials, open the CRM and read every interaction log entry from the past 90 days. What was discussed? What was promised? What did the client mention that might be on their mind? This 10-minute review prevents the embarrassing moment when the advisor doesn't remember something important the client told them." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Advisor Pre-Meeting Brief",
      "summary": "The one-page summary that puts the advisor fully in context before walking into the meeting.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The advisor pre-meeting brief is not a repeat of the meeting packet — it is a curated summary of what the advisor needs to know to show up prepared. It is what you write for an advisor who does not have time to read everything before a meeting." },
        { "type": "list", "items": [
          "<strong>Who is the client:</strong> relationship stage, key facts, how long they have been a client",
          "<strong>What happened since the last meeting:</strong> any life events, market events affecting the portfolio, action items completed or outstanding",
          "<strong>What the client cares about right now:</strong> known concerns from CRM notes, topics they have raised recently",
          "<strong>What needs to happen in this meeting:</strong> decisions to be made, documents to be signed, information to be gathered",
          "<strong>Potential concerns:</strong> anything you anticipate the client may raise that the advisor should be prepared for"
        ]},
        { "type": "callout", "kind": "do", "title": "Deliver the brief 30 minutes before the meeting", "text": "A brief delivered the morning of the meeting gives the advisor time to prepare. A brief delivered at 4:55 PM for a 5:00 PM meeting is better than nothing, but only barely. Build the brief delivery into your prep schedule with enough lead time for the advisor to actually use it." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Production Workflow — Getting Materials Done on Time",
      "summary": "How to coordinate inputs from multiple sources and never miss a meeting prep deadline.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Meeting preparation requires inputs from multiple sources: performance data from the portfolio system, planning updates from the financial planning software, outstanding action items from the CRM, documents from the file management system. Each has a different availability and access path. The discipline of knowing what you need and when you need it is what keeps preparation from becoming a last-minute scramble." },
        { "type": "list", "items": [
          "Build a meeting prep calendar: for every client meeting, work backward from the meeting date to identify when each component of the packet needs to be ready",
          "Generate performance reports at least 24 hours before the meeting — this gives time to identify and resolve any reporting errors",
          "Pull CRM action items and open items the day before — do not rely on memory",
          "Confirm with the advisor 48 hours before the meeting that there are no last-minute additions to the agenda"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Quality Control Before Delivery",
      "summary": "The final check that prevents errors from reaching the client.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "A meeting packet that contains an error — a wrong account balance, someone else's performance report, an outdated plan summary — damages the meeting and the client relationship. The final quality check before delivery is non-negotiable." },
        { "type": "list", "items": [
          "Client name correct on every page",
          "Account balances match the most recent custodian statements",
          "Performance benchmark selected matches the client's actual strategy",
          "All figures are from the same reporting period",
          "No other client's information appears anywhere in the packet",
          "All required compliance disclosures are included"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the most important first step in preparing meeting materials for a specific client?", "options": ["Review the CRM interaction logs from the past 90 days to understand what has happened and what the client cares about", "Generate the performance report for the current quarter", "Confirm the meeting time and agenda with the client", "Pull the client's account statements from the custodian"], "correct": 0, "explanation": "The CRM review grounds the preparation in the specific client's recent history, concerns, and open items — ensuring the materials and the advisor brief are relevant to this client, not generic." },
      { "id": "q2", "text": "How long before a meeting should performance reports be generated?", "options": ["At least 24 hours before — to allow time for identifying and resolving any reporting errors", "Immediately before the meeting for the most current data", "At the beginning of the business week for all meetings that week", "When the advisor requests them"], "correct": 0, "explanation": "Last-minute report generation leaves no time for error correction. Generating reports 24 hours early allows any discrepancies or errors to be investigated and resolved before the client sees them." },
      { "id": "q3", "text": "What distinguishes an advisor pre-meeting brief from the meeting packet?", "options": ["The brief is a curated one-page summary of what the advisor needs to know to be prepared; the packet contains the materials for the meeting itself", "The brief is longer and more detailed than the packet", "The brief is sent to the client; the packet is for internal use", "The brief contains compliance disclosures; the packet contains performance data"], "correct": 0, "explanation": "The brief and the packet serve different purposes. The packet is what the advisor uses with the client. The brief is what gets the advisor up to speed quickly — the 10-minute read that replaces an hour of file review." },
      { "id": "q4", "text": "Which element of the meeting packet requires the most careful quality control check?", "options": ["Performance reports — where a wrong benchmark, wrong period, or wrong client can create significant problems in the meeting", "The agenda — which must match what the advisor discussed with the client", "The open action item list — which must be fully up to date", "Planning update summaries — which must match the current plan"], "correct": 0, "explanation": "Performance report errors are particularly damaging in client meetings because the client immediately focuses on the numbers. Wrong benchmark, wrong period, or wrong client creates a credibility problem that is hard to recover from during the meeting." },
      { "id": "q5", "text": "When should the advisor be notified about last-minute additions to a meeting agenda?", "options": ["At least 48 hours before the meeting — to allow materials to be updated and the brief to reflect the new topics", "As soon as the addition is identified, regardless of timing", "At the beginning of the meeting", "Only if the addition significantly changes the meeting structure"], "correct": 0, "explanation": "48 hours provides enough time to update the materials, re-prepare the brief, and ensure the advisor is not surprised by the new topic. Last-minute agenda additions without advance notice create preparation failures." },
      { "id": "q6", "text": "What does a quality control check of a meeting packet verify?", "options": ["Client name on every page, account balances matching custodian statements, correct benchmark, same reporting period throughout, no other client information present, required disclosures included", "Only that the performance report shows positive returns", "That the client has signed all required documents before the meeting", "That the packet is under 10 pages for client readability"], "correct": 0, "explanation": "The quality control checklist addresses the most common errors that appear in meeting packets and that damage client confidence and the meeting experience." },
      { "id": "q7", "text": "Why should a meeting prep calendar work backward from the meeting date?", "options": ["Working backward identifies exactly when each component must be started to be ready on time — preventing last-minute scrambles", "The calendar software requires backward scheduling for recurring meetings", "Working backward ensures the oldest items are completed first", "It is easier to identify conflicts with other scheduled activities"], "correct": 0, "explanation": "Working backward converts a deadline into a schedule. 'Performance report needed Tuesday' becomes 'start report Monday, submit for review Monday afternoon' — creating a plan that reliably delivers on time." },
      { "id": "q8", "text": "A meeting packet prepared for an annual review for a 72-year-old retiree focused on income should look different from a packet for a 35-year-old accumulator. What drives this difference?", "options": ["The meeting purpose, the client's goals, their current focus areas, and the decisions that need to be made at this particular meeting", "Regulatory requirements specifying different packet formats for different client ages", "The amount of assets the client has under management", "The advisor's preference for how different client types are presented to"], "correct": 0, "explanation": "Meeting materials should reflect the specific client's situation, goals, and the purpose of this particular meeting. Generic packets demonstrate inattention and reduce the meeting's effectiveness." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 24;


-- ── PART 5: Lesson content modules 25-32 (AI 30 kept) ──
-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 25–32
-- Module 30 = AI for Reporting (supplemental)
-- Modules 31-32 = GIC Work Process #29-30
-- ============================================================================

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Needs Analysis Framework",
      "summary": "The structured process for gathering investment objectives, constraints, and risk profile under advisor supervision.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A suitability needs analysis is the professional foundation for every investment recommendation. It answers the question: given who this client is, what they need, and what they can handle — what investment strategy is appropriate? Conducted under supervision, you are learning the process so you can eventually conduct it independently." },
        { "type": "heading", "text": "The five components of a complete needs analysis" },
        { "type": "numbered", "items": [
          "<strong>Investment objective:</strong> what is the money for? Growth, income, capital preservation, or a combination? By when does the client need it?",
          "<strong>Time horizon:</strong> when will the client need to access the funds? Short-term (under 3 years), medium-term (3-10 years), long-term (10+ years)?",
          "<strong>Risk profile:</strong> combining the questionnaire results with the financial capacity assessment and the required return calculation",
          "<strong>Constraints:</strong> liquidity needs, tax situation, legal restrictions (trusts, ERISA), ethical preferences, unique circumstances",
          "<strong>Current holdings:</strong> what does the client already own? How does the new account fit into the total portfolio?"
        ]},
        { "type": "callout", "kind": "key", "title": "The IPS as the documented output", "text": "The Investment Policy Statement (IPS) is the document that captures the completed needs analysis. It describes the objective, time horizon, risk parameters, and constraints — and becomes the ongoing reference for investment decisions. Some firms use a standardized template; others customize. Either way, the IPS is the written evidence that the analysis was done." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Gathering Investment Objectives Under Supervision",
      "summary": "The questions that distinguish between what a client says they want and what they actually need.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment objectives are often stated vaguely. 'I want to grow my money' is not an investment objective — it is an aspiration. Your job is to translate the aspiration into a specific, plannable target." },
        { "type": "case_study", "title": "Translating Vague Objectives", "scenario": "A client says: 'I want to invest this $200,000 conservatively but still get a good return.' What does this actually mean? What questions do you ask?", "discussion": "'Conservative' and 'good return' are subjective and often contradictory. You need to know: What does 'conservative' mean to them — not losing principal? Not losing more than 10%? What is 'a good return' — more than the bank? More than inflation? More than the S&P 500? And what is this money for — is it their only savings, or is it supplemental? Is this account for retirement, a major purchase, or inheritance? Each answer changes what strategy is actually appropriate." },
        { "type": "callout", "kind": "do", "title": "The translation questions", "text": "'When you say conservative, what does that mean to you in practical terms?' 'If this account were down 15% in a given year, how would you feel?' 'What is this money supposed to do for you — is it for income now, for growth over time, or as a reserve you hope to never need?' These questions transform vague preferences into plannable specifications." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Constraints That Shape the Analysis",
      "summary": "The factors beyond risk tolerance that narrow the universe of appropriate strategies.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Constraints are the boundaries within which the investment strategy must operate. A strategy that ignores constraints — even a technically excellent strategy — is not suitable for the client it ignores them for." },
        { "type": "glossary", "terms": [
          { "term": "Liquidity constraint", "definition": "The client needs to access a portion of the portfolio within a specific timeframe. Illiquid investments (real estate, private equity, long-duration bonds) may be inappropriate." },
          { "term": "Tax constraint", "definition": "The client's tax situation affects which account types and investment structures are appropriate. A high-income client in a taxable account may benefit from municipal bonds; the same securities in a tax-deferred account provide no additional benefit." },
          { "term": "Legal constraint", "definition": "Trust documents, ERISA rules, court orders, or beneficiary restrictions that limit how assets can be invested." },
          { "term": "Unique circumstances", "definition": "Client-specific factors: concentrated employer stock (don't add more of the same sector), ethical investing preferences, specific securities to exclude (for legal or personal reasons)." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The constraint you cannot see", "text": "Clients do not always volunteer constraints. A client who has a significant concentrated position in their employer's stock — but does not mention it during discovery — may end up in a portfolio that compounds rather than diversifies their risk. Always ask: 'Are there any investments you already hold that we should know about when building this strategy? Any restrictions on what you can or cannot own?'" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting the Needs Analysis",
      "summary": "The format that satisfies both compliance requirements and the advisor's practical needs.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The needs analysis documentation is the professional record that connects who the client is to what you recommended. A regulator should be able to read it and understand both the recommendation and the reasoning — without asking you to explain it." },
        { "type": "list", "items": [
          "Client identification and account type",
          "Investment objective: stated in specific terms (growth, income, preservation — with time horizon)",
          "Risk assessment: questionnaire result, capacity assessment, required return calculation",
          "Constraints identified: liquidity, tax, legal, unique circumstances",
          "Current holdings context: how this account fits with the client's total portfolio",
          "Recommended strategy and asset allocation: with explicit rationale connecting the strategy to the above",
          "Client acknowledgment: that the client reviewed and understood the recommendation",
          "Date and advisor signature"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Building Toward Independent Practice",
      "summary": "What it looks like to conduct a needs analysis without supervision — and what you still need to develop.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "This module is about conducting supervised needs analyses. The goal is to build toward independent practice — the ability to lead this process without requiring the advisor to be present for every step. That transition requires both skill and trust, and both take time to develop." },
        { "type": "callout", "kind": "key", "title": "The three markers of readiness", "text": "You are ready to conduct a needs analysis with less supervision when: (1) you consistently ask the right follow-up questions without prompting, (2) your documentation is complete and defensible the first time without revision, and (3) your recommendations connect clearly to the analysis — the advisor can see the reasoning without asking you to explain it." },
        { "type": "activity", "title": "Self-Assessment Exercise", "prompt": "Reflect honestly on your current capability in each dimension of the needs analysis process.", "steps": [
          "List the five components of a complete needs analysis and rate your confidence in each from 1-5.",
          "Identify the one component you find most difficult and write two specific things you could do to strengthen it.",
          "Think about the last needs analysis you supported. What would you do differently now?",
          "Write down two questions you would ask about the process that you have not yet asked your supervising advisor."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What are the five components of a complete suitability needs analysis?", "options": ["Investment objective, time horizon, risk profile, constraints, and current holdings context", "Return expectation, account type, fee tolerance, time horizon, and age", "Risk questionnaire, income level, tax bracket, goals, and account balance", "Objective, benchmark, rebalancing policy, performance expectations, and monitoring frequency"], "correct": 0, "explanation": "All five components must be documented. A needs analysis that captures risk tolerance but ignores constraints, or that documents the objective without the time horizon, is incomplete." },
      { "id": "q2", "text": "A client says they want their money invested 'conservatively but with a good return.' What is the advisor's best next step?", "options": ["Ask clarifying questions to translate both terms into specific, plannable parameters", "Select a moderate-risk strategy as a compromise between the two preferences", "Document 'conservative with growth objective' and proceed to allocation", "Explain that conservative and good return are mutually exclusive"], "correct": 0, "explanation": "Both terms are subjective. The advisor must understand what each means to this specific client before any strategy can be appropriate." },
      { "id": "q3", "text": "What is an Investment Policy Statement (IPS)?", "options": ["The documented output of the needs analysis — capturing objective, time horizon, risk parameters, and constraints as the reference for ongoing investment decisions", "A legally binding contract between the client and the investment manager", "A marketing document describing the firm's investment approach", "The performance benchmark for the client's portfolio"], "correct": 0, "explanation": "The IPS is the documented needs analysis. It provides the framework for all future investment decisions and serves as evidence that the analysis was conducted properly." },
      { "id": "q4", "text": "A high-income client is opening a taxable brokerage account. Which constraint is most relevant to the investment strategy?", "options": ["Tax constraint — the client's high income makes tax-efficient investments (like municipal bonds) potentially appropriate", "Liquidity constraint — high-income clients typically need immediate access to funds", "Legal constraint — high-income clients often have trust restrictions", "No special constraint — income level does not affect investment strategy"], "correct": 0, "explanation": "Tax efficiency is a critical consideration for high-income clients in taxable accounts. Tax-exempt municipal bonds may provide higher after-tax returns than taxable equivalents at high marginal rates." },
      { "id": "q5", "text": "A client has $400,000 in their employer's stock from a vested equity plan. They don't mention it during discovery. Why is this a problem?", "options": ["An advisor who recommends additional technology or sector exposure without knowing about the concentration will inadvertently compound rather than diversify the client's risk", "It is not a problem — the vested equity plan is not relevant to the advisory account", "The omission means the client is not fully committed to the engagement", "It creates a compliance issue because all assets must be disclosed"], "correct": 0, "explanation": "Hidden concentrated positions are a common source of unintended portfolio risk. A client already concentrated in tech through their employer stock should have that considered when building their investment portfolio." },
      { "id": "q6", "text": "What three markers indicate that an associate is ready to conduct needs analyses with less supervision?", "options": ["Consistently asking the right follow-up questions, documentation that is complete and defensible the first time, and recommendations that clearly connect to the analysis", "Passing the Series 65, completing 100 supervised analyses, and receiving a positive client review", "Five years of experience, no compliance violations, and advisor endorsement", "Completing all 32 apprenticeship modules, passing the final exam, and receiving firm certification"], "correct": 0, "explanation": "These three behavioral markers — questioning depth, documentation quality, and reasoning clarity — are the practical evidence that the skill has been developed, regardless of time or examination status." },
      { "id": "q7", "text": "Why must the needs analysis documentation include both the recommendation AND the rationale?", "options": ["A regulator must be able to understand why the recommendation was suitable without the advisor explaining it in person", "Rationale is required by FINRA Rule 2111", "Rationale is needed to calculate the appropriate advisory fee", "Documentation without rationale is only acceptable for accounts under $100,000"], "correct": 0, "explanation": "The fiduciary standard requires that the advisor can demonstrate their reasoning, not just their conclusion. If the documentation only says 'recommended balanced portfolio,' a regulator cannot determine whether the recommendation was appropriate." },
      { "id": "q8", "text": "Which type of constraint arises from trust documents, ERISA rules, or court orders?", "options": ["Legal constraint — formal restrictions on how assets can be invested that override advisor and client preferences", "Unique circumstances constraint", "Tax constraint", "Liquidity constraint"], "correct": 0, "explanation": "Legal constraints are imposed externally by legal instruments or regulations. They cannot be overridden by client preference or advisor judgment — the investment strategy must comply with them regardless of other considerations." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 25;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Wealth Management Actually Is",
      "summary": "True wealth management integrates every element of a client's financial life — not just investments.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Wealth management is often used as a synonym for investment management. It is not. Investment management is one component of wealth management. A true wealth management engagement integrates investments, tax planning, estate planning, insurance, cash flow, and goal planning into a single coherent strategy — where decisions in one area are made with full awareness of their impact on the others." },
        { "type": "callout", "kind": "key", "title": "The integration premium", "text": "A client who has an investment advisor, a CPA, and an estate attorney — but none of these professionals talk to each other — is not receiving wealth management. They are receiving siloed advice. The advisor who coordinates across disciplines adds value that no single specialist can." },
        { "type": "heading", "text": "The six planning dimensions" },
        { "type": "list", "items": [
          "<strong>Cash flow and budgeting</strong> — the foundation that funds every other goal",
          "<strong>Investment management</strong> — growing and protecting assets in alignment with goals and risk profile",
          "<strong>Tax planning</strong> — minimizing lifetime tax liability through strategic decisions across income, accounts, and transactions",
          "<strong>Risk management and insurance</strong> — protecting what has been built from events that could destroy it",
          "<strong>Estate planning</strong> — ensuring assets transfer according to the client's wishes, efficiently and at appropriate cost",
          "<strong>Retirement and income planning</strong> — ensuring the portfolio sustains the client's lifestyle for life"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Coordinating the Planning Team",
      "summary": "Your coordination role when the wealth management plan involves attorneys, CPAs, and insurance professionals.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A comprehensive wealth management plan often requires professionals beyond the financial advisor: an estate planning attorney to draft the documents, a CPA for tax strategy, an insurance specialist for coverage review. The advisor's role is to coordinate these specialists — gathering their inputs, ensuring they have the client information they need, and integrating their recommendations into the plan." },
        { "type": "list", "items": [
          "<strong>Before the attorney referral:</strong> prepare a complete financial summary — net worth, asset ownership structure, beneficiary designations, existing documents",
          "<strong>Before the CPA engagement:</strong> provide 2-3 years of tax returns, projected income for the current year, major planned transactions (Roth conversion, business sale, real estate)",
          "<strong>After specialist meetings:</strong> debrief the advisor and document key recommendations in the client file",
          "<strong>Ongoing:</strong> ensure the financial plan reflects the legal and tax structure — account ownership, trust funding, beneficiary alignment"
        ]},
        { "type": "callout", "kind": "do", "title": "The coordination memo", "text": "When a client is working with multiple professionals, prepare a one-page coordination memo: what each professional is doing, what information has been shared with each, and what decisions are pending. This document prevents gaps and duplicated effort across the team." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Building a Comprehensive Plan Under Supervision",
      "summary": "Assembling the inputs and producing a plan that addresses the full financial picture.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Building a comprehensive financial plan requires assembling information from many sources: financial documents, tax returns, estate documents, insurance policies, Social Security estimates, and the client's stated goals. The assembly process is as important as the analysis — an incomplete input produces an incomplete plan." },
        { "type": "activity", "title": "Plan Input Checklist Exercise", "prompt": "For a hypothetical married couple approaching retirement, build the complete information gathering checklist required to produce a comprehensive wealth management plan.", "steps": [
          "List every document needed from the investment dimension (accounts, statements, current allocation).",
          "List every document needed from the tax dimension (returns, basis records, retirement account types).",
          "List every document needed from the estate dimension (will, trust, beneficiaries, power of attorney).",
          "List every document needed from the insurance dimension (life, disability, long-term care, property).",
          "List every estimate or projection needed (Social Security, pension, home equity, business value).",
          "How many total documents is this? What is the typical completion rate from clients in the first 30 days?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Identifying Planning Opportunities and Gaps",
      "summary": "The planning gap analysis — finding what is missing, what is misaligned, and what could be better.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A comprehensive plan review looks for three things: gaps (something important that is missing), inefficiencies (something that exists but could work better), and risks (something that creates exposure if an adverse event occurs). Each dimension of the plan has its own set of gaps to look for." },
        { "type": "list", "items": [
          "<strong>Investment:</strong> Is the allocation appropriate for the time horizon and risk profile? Is the cost structure competitive?",
          "<strong>Tax:</strong> Are tax-advantaged accounts being maximized? Is there a tax diversification opportunity (Traditional vs. Roth)?",
          "<strong>Estate:</strong> Are documents current and funded? Do beneficiary designations match the estate plan?",
          "<strong>Insurance:</strong> Is the coverage adequate? Are there gaps in disability, liability, or long-term care?",
          "<strong>Cash flow:</strong> Is the savings rate sufficient to fund goals? Is there high-interest debt that should be prioritized?"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Updating Plans When Life Changes",
      "summary": "The events that require plan revision and the workflow for doing it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A financial plan is not a static document. It is a living description of the client's strategy, and it must evolve as the client's life evolves. The advisor who proactively updates the plan when life changes happen retains clients; the advisor who waits for the client to bring up the change loses the relationship." },
        { "type": "list", "items": [
          "<strong>Marriage or domestic partnership:</strong> update beneficiaries, combine or coordinate financial plans, review insurance coverage",
          "<strong>Birth or adoption of a child:</strong> update estate documents (guardian designation), start education savings, review life insurance",
          "<strong>Divorce:</strong> update beneficiaries on all accounts immediately, revise financial plan for single-income household, review QDRO if applicable",
          "<strong>Job change or major income change:</strong> update cash flow projections, review retirement savings rate, evaluate new benefits",
          "<strong>Inheritance:</strong> reassess goals and required return, review investment strategy, consider estate planning implications"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What distinguishes wealth management from investment management?", "options": ["Wealth management integrates investments, tax, estate, insurance, cash flow, and goals into a coordinated strategy; investment management focuses on portfolio construction and performance", "Wealth management is for clients with more than $1 million in assets", "Wealth management includes insurance sales; investment management does not", "They are different terms for the same service"], "correct": 0, "explanation": "Investment management is one component of wealth management. The wealth management premium comes from coordinating across all planning dimensions — so decisions in one area account for their impact on the others." },
      { "id": "q2", "text": "What information should be prepared before referring a client to an estate planning attorney?", "options": ["Net worth statement, asset ownership structure, existing estate documents, and beneficiary designations across all accounts", "Only the client's contact information and a summary of their goals", "The client's tax return from the prior year", "A list of the attorney's fees and the client's budget for legal services"], "correct": 0, "explanation": "The attorney needs the financial picture to create appropriate legal documents. Sending a client without this information wastes the attorney's time and produces documents that may not match the financial plan." },
      { "id": "q3", "text": "A client has a financial advisor, a CPA, and an estate attorney — but none of them coordinate. What is the risk?", "options": ["Siloed advice — each professional may make recommendations without knowing how they interact with the others' work, creating gaps and conflicts", "Duplication — all three will produce the same plan", "The client pays too many professional fees", "There is no risk — independent advice is always more objective"], "correct": 0, "explanation": "Without coordination, a Roth conversion recommended by the advisor may be undone by the tax impact that the CPA would have flagged, or estate documents may not match the financial account structure. Integration is the value of wealth management." },
      { "id": "q4", "text": "Which planning gap is most commonly overlooked in a comprehensive plan review?", "options": ["Insurance gaps — particularly disability and long-term care coverage — which clients are least likely to volunteer information about", "Investment allocation drift", "Retirement account contribution limits", "Estate document currency"], "correct": 0, "explanation": "Insurance is the planning dimension clients are least engaged with and least likely to raise proactively. Advisors must ask specifically about disability, long-term care, and liability coverage in every comprehensive review." },
      { "id": "q5", "text": "A client gets divorced. What is the most urgent financial planning action?", "options": ["Update beneficiary designations on all accounts immediately — before any other planning changes", "Revise the investment strategy for a single-income household", "Begin the QDRO process for retirement account division", "Review the estate documents and update the will"], "correct": 0, "explanation": "Beneficiary designations override the will. An ex-spouse still named as beneficiary on a retirement account or life insurance policy will receive those assets at death, regardless of the divorce. This must be updated immediately." },
      { "id": "q6", "text": "What is a 'coordination memo' and when is it used?", "options": ["A one-page document tracking what each professional is doing, what information has been shared, and what decisions are pending — used when the client works with multiple specialists", "A compliance document required when the advisor refers a client to an attorney or CPA", "A client-facing summary of the comprehensive financial plan", "An internal communication between the advisor and compliance department"], "correct": 0, "explanation": "The coordination memo prevents gaps and duplication across a multi-professional team. It is a project management tool for the advisor serving as the primary coordinator of the client's financial team." },
      { "id": "q7", "text": "What triggers a comprehensive plan update versus a routine annual review?", "options": ["A significant life event — marriage, divorce, death, birth, job change, inheritance, health event — that materially changes the client's situation, goals, or constraints", "A calendar date — plans are updated annually regardless of whether anything has changed", "A change in market conditions or economic outlook", "Any time a client's portfolio value changes by more than 10%"], "correct": 0, "explanation": "Life events — not calendar dates — are the primary drivers of plan updates. Annual reviews are the scheduled minimum; life events require interim updates regardless of when the last review occurred." },
      { "id": "q8", "text": "Which dimension of the financial plan requires the most coordination with professionals outside the advisory firm?", "options": ["Estate planning — requiring an attorney for document drafting and potentially a CPA for tax implications of estate structures", "Investment management — requiring custodian coordination", "Cash flow planning — requiring budget software and client data", "Retirement planning — requiring Social Security Administration data"], "correct": 0, "explanation": "Estate planning requires legally executed documents drafted by an attorney. Unlike other planning dimensions where the advisor can complete most of the work internally, estate documents require outside legal expertise." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 26;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building Product Knowledge Systematically",
      "summary": "Why product knowledge is a professional obligation and how to build it efficiently.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "An advisor who does not understand the products in their clients' portfolios cannot serve those clients well. Product knowledge is not a nice-to-have — it is the foundation of every recommendation, every client conversation about their holdings, and every due diligence decision." },
        { "type": "callout", "kind": "key", "title": "The product knowledge standard", "text": "You should be able to explain any product in a client's portfolio in plain language, answer basic questions about how it works and what it costs, and describe the circumstances under which it is and is not appropriate — without looking it up. This standard applies to every product the firm uses, not just the ones you selected." },
        { "type": "heading", "text": "Building your knowledge base" },
        { "type": "list", "items": [
          "Start with the products already in client portfolios — these are the ones you will be asked about first",
          "For each fund or ETF, read the summary prospectus and the most recent fact sheet",
          "For individual securities, read the most recent 10-K and listen to the most recent earnings call",
          "For fixed income, understand the credit rating, duration, yield, and call provisions",
          "Set a goal: know one product deeply each week until the firm's core product set is covered"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Equities in Depth",
      "summary": "Large cap, small cap, growth, value, international — the distinctions that matter for portfolio construction.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Equities are the growth engine of most long-term portfolios. Understanding the sub-categories of equities — and why the distinctions matter — allows you to evaluate whether a client's equity exposure is appropriate and well-diversified." },
        { "type": "glossary", "terms": [
          { "term": "Large cap", "definition": "Companies with market capitalization generally above $10 billion. More stable, more liquid, typically lower growth potential than smaller companies. The S&P 500 is the primary large-cap benchmark." },
          { "term": "Small cap", "definition": "Companies with market capitalization generally between $300 million and $2 billion. Higher growth potential, higher volatility, less analyst coverage. Russell 2000 is the primary small-cap benchmark." },
          { "term": "Value investing", "definition": "Selecting stocks trading below their intrinsic value based on fundamentals. Lower P/E ratios, higher dividend yields. Tends to outperform in certain market cycles." },
          { "term": "Growth investing", "definition": "Selecting companies with above-average growth rates, typically at premium valuations. Higher P/E ratios. Tends to outperform in low-interest-rate environments." },
          { "term": "International developed markets", "definition": "Equities in developed economies outside the US: Western Europe, Japan, Australia. Provides geographic diversification; currency risk is a factor." },
          { "term": "Emerging markets", "definition": "Equities in developing economies: China, India, Brazil, etc. Higher growth potential, higher volatility, additional political and currency risk." }
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Fixed Income in Depth",
      "summary": "Government, corporate, municipal — the choices and what drives them.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Fixed income provides income, reduces portfolio volatility, and serves as a counterweight to equities. Understanding the major categories of fixed income — and the trade-offs between them — is essential for evaluating bond portfolio construction." },
        { "type": "list", "items": [
          "<strong>US Treasury bonds:</strong> backed by the full faith and credit of the US government. Zero credit risk. Benchmark for all other fixed income. Yields set the risk-free rate.",
          "<strong>Investment-grade corporate bonds:</strong> rated BBB/Baa or above. Higher yield than Treasuries (credit spread) in exchange for credit risk.",
          "<strong>Municipal bonds:</strong> issued by states and local governments. Interest is federal tax-exempt (and often state tax-exempt). Most valuable to investors in high tax brackets.",
          "<strong>High-yield bonds:</strong> rated below BBB/Baa. Significantly higher yields. Significant default risk. Behave more like equities than like high-quality bonds during market stress."
        ]},
        { "type": "callout", "kind": "key", "title": "The muni bond after-tax calculation", "text": "A municipal bond yielding 3.5% tax-exempt is worth 3.5% / (1 - marginal tax rate) on a taxable equivalent basis. For a client in the 37% federal bracket: 3.5% / 0.63 = 5.56% taxable equivalent. A comparable taxable bond yielding less than 5.56% is less attractive than the muni for this client." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Alternative Investments and Specialty Products",
      "summary": "REITs, commodities, private equity — when they fit, when they don't, and what to watch for.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Alternative investments are broadly defined as anything outside of publicly traded stocks and bonds. They are often presented as portfolio diversifiers or return enhancers. Some deliver on this promise. Many do not — particularly when their fees, liquidity constraints, and actual correlation to other assets are examined honestly." },
        { "type": "glossary", "terms": [
          { "term": "REITs (Real Estate Investment Trusts)", "definition": "Publicly traded companies that own income-producing real estate. Required to distribute 90% of taxable income. Provides real estate exposure with liquidity. Not the same as owning direct real estate." },
          { "term": "Private equity", "definition": "Investment in private (non-publicly traded) companies, typically through a fund structure. High minimum investment, long lock-up periods (7-10+ years), illiquid. Historically higher returns than public equities, but with higher fees and illiquidity risk." },
          { "term": "Commodities", "definition": "Physical goods: gold, oil, agricultural products. Often used as an inflation hedge or portfolio diversifier. Can be accessed through futures, ETFs, or commodity-producing company equities." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The liquidity-return trade-off", "text": "Alternative investments often justify higher fees and complexity with the promise of higher returns. Before recommending any alternative, ask: Does this client have a genuine need for this exposure that cannot be met more cheaply and more liquidly through traditional assets? If the answer is no, traditional assets are almost always preferable." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Staying Current on Products",
      "summary": "The ongoing habit of product knowledge maintenance that professional practice requires.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Product knowledge is not a one-time achievement — it requires ongoing maintenance. Funds change management. Fee structures evolve. New products launch. Existing products are restructured or liquidated. The advisor who learned the product universe three years ago and stopped paying attention is operating with stale information." },
        { "type": "list", "items": [
          "Review fund annual reports and prospectus updates when they are issued",
          "Read the firm's research on products it uses or is considering using",
          "Attend product webinars from fund managers — at least quarterly for core holdings",
          "Track management changes: a fund manager departure is a material event requiring re-evaluation",
          "Review the firm's approved product list annually — products are added and removed"
        ]},
        { "type": "callout", "kind": "do", "title": "The 15-minute daily habit", "text": "15 minutes each morning: scan one piece of fund research, read one earnings summary for a major holding, or read one market commentary. Over a year, this produces 65+ hours of product and market knowledge — and it comes in digestible daily portions rather than indigestible annual cramming." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the taxable equivalent yield of a 3.5% tax-exempt municipal bond for a client in the 35% federal tax bracket?", "options": ["5.38% — calculated as 3.5% divided by (1 - 0.35)", "4.85%", "3.5% — the yield is the same regardless of tax status", "2.28% — calculated as 3.5% multiplied by (1 - 0.35)"], "correct": 0, "explanation": "Taxable equivalent yield = tax-exempt yield / (1 - marginal rate). 3.5% / 0.65 = 5.38%. Any taxable bond yielding less than 5.38% is less attractive than this muni for a client in the 35% bracket." },
      { "id": "q2", "text": "What distinguishes a REIT from direct real estate ownership?", "options": ["REITs are publicly traded and liquid; direct real estate is illiquid and requires active management", "REITs are tax-exempt; direct real estate produces fully taxable income", "REITs provide more stable returns than direct real estate", "Direct real estate is available to all investors; REITs require accreditation"], "correct": 0, "explanation": "The key practical distinction is liquidity and management. REITs trade on exchanges like stocks and require no property management. Direct real estate involves illiquid assets requiring hands-on oversight." },
      { "id": "q3", "text": "What should trigger a re-evaluation of an actively managed mutual fund in a client's portfolio?", "options": ["A management change — the manager who produced the historical track record has left the fund", "A period of underperformance in a single quarter", "The fund exceeds $1 billion in assets under management", "The fund's expense ratio increases by 0.01%"], "correct": 0, "explanation": "An actively managed fund's track record is attributed to its management team. A management change is a material event that makes the historical record less predictive of future results." },
      { "id": "q4", "text": "Which fixed income category typically behaves most like equities during a market stress event?", "options": ["High-yield bonds — their correlation to equities increases significantly during market dislocations", "US Treasury bonds", "Investment-grade corporate bonds", "Municipal bonds"], "correct": 0, "explanation": "High-yield bonds (junk bonds) are issued by companies with elevated default risk. During market stress, investors sell risky assets broadly — creating correlation between high-yield bonds and equities that undermines the diversification premise." },
      { "id": "q5", "text": "Before recommending an alternative investment, what is the key question to ask?", "options": ["Can the same exposure be achieved more cheaply and with better liquidity through traditional assets? If yes, why use the alternative?", "Has the alternative produced positive returns in the past three years?", "Is the alternative on the firm's approved product list?", "Does the client meet the accredited investor standard?"], "correct": 0, "explanation": "The first question is whether the alternative solves a real problem that traditional assets cannot. Many alternatives are sold on complexity and promise rather than on genuine portfolio need. Liquidity and cost should be the starting point." },
      { "id": "q6", "text": "What distinguishes value investing from growth investing?", "options": ["Value focuses on stocks trading below intrinsic value with lower P/E ratios; growth focuses on companies with above-average growth rates at premium valuations", "Value investing targets small-cap companies; growth investing targets large-cap companies", "Value investing uses fundamental analysis; growth investing uses technical analysis", "Value investors hold for longer periods than growth investors"], "correct": 0, "explanation": "The core distinction is valuation approach. Value investors seek cheap stocks relative to fundamentals. Growth investors accept premium prices for superior growth rates. Both styles have periods of outperformance and underperformance." },
      { "id": "q7", "text": "What is the primary risk that distinguishes emerging markets equities from developed international equities?", "options": ["Higher political instability, currency risk, and less developed regulatory systems — in addition to the standard market risk", "Emerging markets are more expensive to own due to higher transaction costs", "Emerging markets do not pay dividends", "Emerging markets are less liquid than developed international markets"], "correct": 0, "explanation": "Emerging markets carry political risk (government instability, nationalization risk), currency risk (exchange rate volatility against the dollar), and regulatory risk (less developed legal protections for foreign investors)." },
      { "id": "q8", "text": "What is the most efficient daily habit for maintaining product knowledge?", "options": ["15 minutes each morning reading one piece of fund research, market commentary, or earnings summary — compounding to 65+ hours of learning annually", "Weekly two-hour product research sessions", "Monthly product knowledge assessments", "Annual review of all fund prospectuses"], "correct": 0, "explanation": "Daily habits compound. 15 minutes per day totals over 65 hours per year — far more than any weekly or monthly session of comparable length. The daily cadence also keeps knowledge current rather than allowing large gaps to develop." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 27;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Relationship Calendar",
      "summary": "Systematic touchpoints that build loyalty — not the relationship moments you remember, but the ones you schedule.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client loyalty is built through consistency, not through moments of brilliance. A client who hears from their advisor at predictable, appropriate intervals — and who never has to wonder whether their advisor is paying attention — is a client who stays." },
        { "type": "heading", "text": "The standard touchpoint calendar" },
        { "type": "list", "items": [
          "<strong>Annual review meeting</strong> — comprehensive, scheduled, non-negotiable for every client",
          "<strong>Quarterly check-in</strong> — brief call or message: how are you, anything changed, here's where the portfolio stands",
          "<strong>Market event communication</strong> — when something significant happens in the market that affects client portfolios, proactive communication before clients call to ask",
          "<strong>Birthday and anniversary acknowledgment</strong> — personal, brief, consistent",
          "<strong>Life event response</strong> — a note when you learn of a marriage, birth, death, or retirement. The advisor who acknowledges life events is the advisor the client calls when financial decisions follow those events."
        ]},
        { "type": "callout", "kind": "key", "title": "Proactive vs. reactive service", "text": "Reactive service means clients call you when they have a question or concern. Proactive service means you reach out before they have to. Proactive advisors have clients who feel cared for. Reactive advisors have clients who feel like account numbers." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Proactive Outreach — The Triggers That Drive It",
      "summary": "What events in the world and in a client's life should prompt an advisor to reach out.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Proactive outreach is triggered by events — not by a calendar date. The advisor who reaches out to clients when the Fed raises rates, when a client's industry experiences disruption, or when a client mentioned they are thinking about selling their business — that advisor is demonstrating attentiveness that generic scheduled calls cannot replicate." },
        { "type": "list", "items": [
          "<strong>Market events:</strong> significant rate changes, volatility spikes, sector disruptions relevant to client holdings or employment",
          "<strong>Tax deadline proximity:</strong> April 15, December 31 — trigger conversations about tax-loss harvesting, Roth conversions, charitable giving",
          "<strong>Life milestones:</strong> a child turning 16 (college planning), a client turning 59½ (retirement account access), approaching 65 (Medicare enrollment)",
          "<strong>Known upcoming decisions:</strong> clients who mentioned a business sale, a home purchase, an inheritance — follow up when the timing is approaching",
          "<strong>Economic changes affecting specific clients:</strong> a client who works in tech during a tech sector decline"
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Handling Service Requests Professionally",
      "summary": "The response standard and workflow for client service requests.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client service requests — account changes, money movements, paperwork, questions — are the moments when advisory relationships are stressed or strengthened. A request handled quickly, completely, and with clear communication about status builds confidence. A request that disappears into a black hole destroys it." },
        { "type": "callout", "kind": "do", "title": "The 24-hour response standard", "text": "Every client service request receives a response within 24 business hours — even if the response is only: 'I received your request. I'm working on it. Here is what I expect to have for you and by when.' Acknowledgment is not resolution, but it is proof that the request was received and is being handled." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Identifying and Retaining At-Risk Clients",
      "summary": "The signals that a client may be considering leaving — and what to do about it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client attrition is expensive. Acquiring a new client costs five to seven times as much as retaining an existing one. Recognizing the early signals of client dissatisfaction — and responding before the client has decided to leave — is one of the most economically valuable skills in an advisory practice." },
        { "type": "list", "items": [
          "Reduced communication: a client who used to call regularly stops calling",
          "Unanswered calls and emails that the client previously responded to promptly",
          "Questions about fees: suddenly asking how fees are calculated and what they are paying for",
          "Questions about performance in isolation: comparing to the S&P 500 without context",
          "Withdrawal of assets: partial liquidations without a stated purpose",
          "Negative feedback: direct expressions of dissatisfaction, even if mild"
        ]},
        { "type": "callout", "kind": "do", "title": "The retention conversation", "text": "'I've noticed we haven't connected recently, and I want to make sure we're meeting your expectations. Is there anything about our relationship or our service that you feel could be better?' Direct, honest, and proactive. Most at-risk clients will either share their concern (giving you a chance to address it) or be reassured by the question itself." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "The Referral Relationship",
      "summary": "How satisfied clients become the best source of new clients — and how to facilitate that professionally.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Referrals are the highest-quality source of new clients for most advisory practices. A client who refers someone they know is providing an implicit endorsement that reduces the sales cycle, increases the likelihood of a strong relationship, and typically results in a client who is easier to serve." },
        { "type": "callout", "kind": "key", "title": "The appropriate way to ask for referrals", "text": "'If you know anyone who might benefit from the kind of work we do together — someone who is navigating a financial transition or who doesn't currently have the level of planning support you have — I'd welcome the introduction.' This is specific, non-pressured, and positions the referral as an act of generosity to the referred person." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the difference between proactive and reactive client service?", "options": ["Proactive service means reaching out before clients have to ask; reactive service means responding when clients initiate contact", "Proactive service is more expensive but not necessarily more effective", "Reactive service is preferred by most clients who don't want unsolicited contact", "There is no meaningful difference in client satisfaction outcomes between the two approaches"], "correct": 0, "explanation": "Proactive service demonstrates that the advisor is paying attention and cares about the client relationship. Reactive service leaves clients feeling like account numbers rather than valued relationships." },
      { "id": "q2", "text": "A client turns 59½ this year. What proactive outreach is most appropriate?", "options": ["A conversation about retirement account access — withdrawals from retirement accounts are now available without the 10% early withdrawal penalty", "A conversation about required minimum distributions, which begin at 59½", "A review of Medicare enrollment, which begins at 59½", "No special outreach — 59½ is not a significant financial milestone"], "correct": 0, "explanation": "Age 59½ is the threshold for penalty-free withdrawals from retirement accounts. For clients approaching retirement or needing income, this is an important milestone worth acknowledging proactively." },
      { "id": "q3", "text": "What is the 24-hour response standard for client service requests?", "options": ["Every request receives a response — even if just an acknowledgment — within 24 business hours", "Every request is fully resolved within 24 hours", "Simple requests are answered within 24 hours; complex requests within one week", "Responses are provided when the advisor's schedule permits"], "correct": 0, "explanation": "Acknowledgment within 24 hours demonstrates that the request was received and is being handled. Full resolution may take longer, but silence beyond 24 hours creates anxiety and erodes trust." },
      { "id": "q4", "text": "Which client behavior is the strongest early signal of potential attrition?", "options": ["Sudden questions about fees and what they are paying for — after previously not raising the topic", "Reduced portfolio contributions during a period of personal financial constraint", "Declining a meeting to review their annual performance report", "Asking for a copy of their account statements"], "correct": 0, "explanation": "Fee questions that arise suddenly — without an obvious trigger — often signal that the client is evaluating whether the relationship is worth continuing. This is an early warning that warrants a proactive retention conversation." },
      { "id": "q5", "text": "Why are referral clients typically easier to serve than clients acquired through other channels?", "options": ["They come pre-qualified by someone who knows both them and the advisor — reducing the trust-building phase and creating a client who generally fits the advisor's profile", "They require less documentation because the referring client vouches for them", "They are typically wealthier and therefore have simpler financial situations", "They have lower service expectations because they came through a personal introduction"], "correct": 0, "explanation": "A referral client has already received an endorsement of the advisor from someone they trust. This shortens the relationship-building timeline and typically produces clients who are more engaged and easier to work with." },
      { "id": "q6", "text": "What triggers a proactive market-event communication to clients?", "options": ["Any significant market event that affects client portfolios or that clients are likely to see reported in the news and wonder about", "Only events that require portfolio action", "Quarterly earnings announcements from major companies", "Any time the S&P 500 moves more than 1% in a day"], "correct": 0, "explanation": "The standard is: if clients are likely to see it in the news and wonder how it affects them, proactive communication prevents unnecessary anxiety and demonstrates professional attention." },
      { "id": "q7", "text": "What is the most professional way to ask a client for a referral?", "options": ["A specific, non-pressured statement that positions the referral as being helpful to the referred person — not a favor to the advisor", "Asking directly whether the client knows anyone who needs an advisor", "Offering a fee discount in exchange for successful referrals", "Including a referral request in every quarterly communication"], "correct": 0, "explanation": "The professional referral ask focuses on whether the client knows someone who could benefit from this type of planning support — making it an act of generosity rather than a sales ask." },
      { "id": "q8", "text": "Why is client retention economically more valuable than client acquisition?", "options": ["Acquiring a new client costs five to seven times more than retaining an existing one — making retention one of the highest-ROI activities in an advisory practice", "Existing clients pay higher fees than new clients", "Regulatory requirements make it more difficult to add new clients than to retain existing ones", "New clients require more compliance documentation than existing clients"], "correct": 0, "explanation": "The cost of client acquisition — marketing, meetings, onboarding — significantly exceeds the cost of retention. Every existing client retained is more economically valuable than acquiring a new one to replace them." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 28;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "From Risk Profile to Portfolio",
      "summary": "Translating the suitability assessment into a concrete, defensible portfolio.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Portfolio construction is where the theoretical work of discovery, suitability assessment, and allocation modeling becomes the client's actual investment experience. The construction decision must connect clearly and explicitly to everything that came before it." },
        { "type": "heading", "text": "The model portfolio library" },
        { "type": "paragraph", "text": "Most advisory firms use model portfolios: pre-constructed allocation targets for different risk categories. The construction process for a client account typically involves selecting the appropriate model, then populating it with specific securities or funds. Understanding how models are built helps you apply them correctly and explain them to clients." },
        { "type": "callout", "kind": "key", "title": "The documentation requirement", "text": "Every portfolio construction decision must be documented: which model was selected, why that model fits this client, and how the specific securities or funds were chosen to implement the model. This documentation is both a compliance requirement and a service standard — it allows the advisor to explain the portfolio to the client at any future meeting." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Diversification in Practice",
      "summary": "What real diversification looks like — and why owning more funds doesn't guarantee it.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Diversification is the practice of spreading investment exposure across assets that do not all move together — so that a decline in one does not produce a proportional decline in the whole portfolio. This sounds simple. In practice, achieving genuine diversification requires attention to correlation, not just count." },
        { "type": "glossary", "terms": [
          { "term": "Correlation", "definition": "A statistical measure of how two assets move relative to each other. Ranges from -1 (perfectly inverse) to +1 (perfectly aligned). True diversification requires low or negative correlation between portfolio components." },
          { "term": "Diversification on paper vs. in practice", "definition": "A portfolio with 20 different US large-cap growth funds may appear diversified but holds essentially the same underlying stocks. True diversification requires genuinely different exposures: different asset classes, geographies, sectors, and styles." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The correlation trap during market stress", "text": "Correlations between many asset classes increase during market crises — assets that appeared diversified in normal conditions fall together. The assets that tend to hold their value during stress: short-term government bonds, cash, gold. True crisis diversification requires these anchors, not just more equities." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Portfolio Characteristics",
      "summary": "The numbers that describe a portfolio's risk, cost, and income profile.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every portfolio has a set of measurable characteristics that describe its aggregate properties. These characteristics allow the advisor to compare the portfolio to its targets and to communicate the portfolio's profile to the client in clear terms." },
        { "type": "glossary", "terms": [
          { "term": "Weighted average expense ratio", "definition": "The portfolio's total cost as a percentage of assets, calculated by weighting each holding's expense ratio by its portfolio weight. A portfolio that is 60% in a 0.05% ETF and 40% in a 0.80% fund has a weighted average of 0.35%." },
          { "term": "Portfolio yield", "definition": "The aggregate income (dividends, interest) generated by the portfolio as a percentage of its value. Relevant for income-focused clients." },
          { "term": "Beta", "definition": "A measure of the portfolio's volatility relative to its benchmark. Beta of 1.0 means it moves with the market. Beta of 0.8 means it moves 80% as much as the market." },
          { "term": "Portfolio duration", "definition": "For fixed income components: the weighted average duration, measuring sensitivity to interest rate changes." }
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Modeling a Rebalancing Trade",
      "summary": "How to identify drift, calculate required trades, and prepare the rebalancing recommendation.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Rebalancing is one of the most regular and concrete portfolio construction tasks in advisory practice. It restores the intended allocation after market movement has caused drift. The process of identifying drift, modeling the trades, and documenting the rationale is a standard associate task." },
        { "type": "activity", "title": "Rebalancing Exercise", "prompt": "A client's target allocation is 60% equities / 40% fixed income. After a strong equity market, the portfolio is now 70% equities / 30% fixed income. Portfolio value: $500,000.", "steps": [
          "Calculate the dollar amount of equity overweight: 70% actual vs. 60% target = 10% × $500,000 = $50,000 overweight in equities.",
          "Identify which equity position(s) to reduce: start with highest-gain positions for tax efficiency in taxable accounts, or any position in rebalancing threshold.",
          "Calculate where the proceeds go: $50,000 must move to fixed income to restore the target.",
          "Model the trades: list the specific buy and sell orders.",
          "Consider tax implications: if this is a taxable account, calculate the estimated capital gain from selling the equity positions.",
          "Prepare a rebalancing memo for the advisor's review and approval."
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Documentation and Investment Rationale",
      "summary": "Every construction decision needs a written rationale that makes the reasoning visible.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The investment rationale memo is the document that connects the portfolio construction decision to the client's needs. It is not a marketing document — it is a professional record of why this portfolio was built this way for this client." },
        { "type": "list", "items": [
          "Client: name and account",
          "Date of construction/change",
          "What changed and why: what was the trigger for this construction decision?",
          "How the construction relates to the investment policy statement: does it match the target allocation?",
          "Specific fund or security selection rationale: why these holdings vs. alternatives?",
          "Tax considerations: any decisions made with tax efficiency in mind?",
          "Advisor approval: signature indicating review"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "A portfolio holds 15 different US large-cap growth mutual funds. Is this portfolio well-diversified?", "options": ["No — owning multiple funds in the same category provides minimal diversification because they hold largely the same underlying stocks", "Yes — 15 funds is more than the minimum for diversification", "It depends on how different the fund managers' approaches are", "Yes, as long as the funds have different names and management teams"], "correct": 0, "explanation": "True diversification requires genuinely different exposures. Multiple large-cap growth funds typically hold the same top 50-100 stocks. Diversification requires different asset classes, geographies, and styles — not just more funds." },
      { "id": "q2", "text": "A portfolio is 60% in a 0.04% index ETF and 40% in a 0.90% active fund. What is the weighted average expense ratio?", "options": ["0.384% — (0.60 × 0.04%) + (0.40 × 0.90%)", "0.47% — the simple average of 0.04% and 0.90%", "0.90% — the most expensive fund determines the portfolio cost", "0.04% — the index fund dominates by weight"], "correct": 0, "explanation": "Weighted average expense ratio = (0.60 × 0.04%) + (0.40 × 0.90%) = 0.024% + 0.36% = 0.384%. Each fund's cost is weighted by its share of the portfolio." },
      { "id": "q3", "text": "What is 'beta' in the context of portfolio characteristics?", "options": ["A measure of portfolio volatility relative to the benchmark — beta of 1.0 means it moves with the market; 0.8 means it moves 80% as much", "The target return objective for the portfolio", "The weighted average duration of the fixed income component", "The portfolio's maximum drawdown over the past year"], "correct": 0, "explanation": "Beta measures systematic risk relative to the benchmark. A beta below 1.0 indicates lower volatility than the market; above 1.0 indicates higher volatility. It is a key portfolio risk characteristic." },
      { "id": "q4", "text": "In a rebalancing trade for a taxable account, which equity positions should generally be sold first?", "options": ["Positions with the highest gains — reducing the overweight while realizing the gain that would eventually be taxed anyway", "Positions with the smallest gains to minimize taxable events", "The largest position by dollar value regardless of tax impact", "Positions that have been held the longest regardless of gain size"], "correct": 0, "explanation": "Tax-aware rebalancing often means selling the most appreciated positions first since the gain will eventually be realized. However, tax-loss harvesting opportunities and holding period (short vs. long-term gain) should also be considered." },
      { "id": "q5", "text": "What is the primary purpose of the investment rationale memo?", "options": ["To create a written record connecting the portfolio construction decision to the client's needs and the investment policy statement", "To market the portfolio strategy to the client for approval", "To satisfy the custodian's requirement for documentation of trade decisions", "To compare the portfolio's performance to its benchmark"], "correct": 0, "explanation": "The rationale memo is a professional and compliance document. It makes the advisor's reasoning visible and auditable — demonstrating that the construction decision was deliberate and connected to the client's documented needs." },
      { "id": "q6", "text": "What happens to correlations between many asset classes during a market crisis?", "options": ["Correlations increase — many assets that appeared diversified in normal conditions fall together during stress", "Correlations decrease — assets become more independent during crisis periods", "Correlations remain stable — they reflect long-term structural relationships that do not change", "Correlations only change between equities and fixed income, not within asset classes"], "correct": 0, "explanation": "The correlation trap in crises: investors sell broadly when fear rises, causing assets that normally move independently to fall together. Government bonds and cash tend to hold value, making them the reliable crisis diversifiers." },
      { "id": "q7", "text": "A client's target allocation is 60/40 and the current allocation is 70/30 on a $500,000 portfolio. What dollar amount must move from equities to fixed income?", "options": ["$50,000 — 10% drift × $500,000", "$25,000 — 5% of the overweight position", "$100,000 — the entire equity overweight must be liquidated", "$10,000 — only the amount above the rebalancing threshold"], "correct": 0, "explanation": "The drift is 10 percentage points (70% actual vs. 60% target). 10% × $500,000 = $50,000 must be moved from equities to fixed income to restore the target allocation." },
      { "id": "q8", "text": "Why must every portfolio construction decision be documented in a rationale memo?", "options": ["To create an auditable record that demonstrates the decision was deliberate and connected to the client's investment policy — satisfying both compliance and service requirements", "To satisfy FINRA Rule 2111 which requires written documentation of all investment recommendations", "To establish a benchmark against which portfolio performance will be measured", "Because clients must approve all construction decisions in writing before implementation"], "correct": 0, "explanation": "Documentation serves both compliance (demonstrating due diligence in a regulatory examination) and service (allowing the advisor to explain the portfolio coherently at any future meeting)." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 29;

-- Module 30: AI for Reporting content is already written in module30_ai_content.sql
-- Skipping to avoid overwriting existing content

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Economic Cycle and Markets",
      "summary": "How the four phases of the economic cycle drive sector and asset class performance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Markets do not move randomly. Over time, they respond to the same economic forces in recognizable patterns. Understanding the economic cycle — expansion, peak, contraction, trough — provides a framework for monitoring market conditions and contextualizing what you observe in client portfolios." },
        { "type": "glossary", "terms": [
          { "term": "Expansion", "definition": "GDP growth is positive and accelerating. Employment is rising. Corporate earnings are growing. Equities typically perform well. Consumer spending is strong. Early expansion favors cyclical sectors." },
          { "term": "Peak", "definition": "Growth rate is at its highest point before decelerating. Inflation may be rising. The Fed may be tightening. Late-cycle sectors (energy, materials) may outperform." },
          { "term": "Contraction (recession)", "definition": "GDP growth is negative for two or more consecutive quarters. Unemployment rising. Corporate earnings declining. Defensive sectors (utilities, healthcare, consumer staples) typically outperform." },
          { "term": "Trough", "definition": "The low point of the cycle before recovery begins. Interest rates are typically low. Early-cycle sectors and growth assets often begin to outperform as recovery expectations build." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The cycle timing problem", "text": "The economic cycle is a useful framework for understanding market behavior in hindsight. It is much less reliable for making specific investment decisions in real time. Nobody rings a bell at the peak or the trough. Use the cycle to provide context for what you observe — not to predict what will happen next." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Reading Market Data",
      "summary": "The key data series, what they measure, and where to find them.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Market monitoring requires knowing where to look for data and how to interpret what you find. The same number can mean different things depending on the trend, the direction of change, and the economic context." },
        { "type": "glossary", "terms": [
          { "term": "Equity indices", "definition": "S&P 500 (large-cap US), Russell 2000 (small-cap US), MSCI ACWI (global), MSCI Emerging Markets. Each measures a different slice of the equity universe." },
          { "term": "Treasury yields", "definition": "The interest rate on US government bonds at different maturities. The 10-year Treasury yield is the most widely watched benchmark rate in the world." },
          { "term": "VIX (Volatility Index)", "definition": "Often called the 'fear gauge.' Measures the market's expectation of volatility over the next 30 days. Above 30 indicates elevated fear. Below 15 indicates complacency." },
          { "term": "Credit spreads", "definition": "The difference in yield between corporate bonds and equivalent Treasury bonds. Widening spreads indicate increasing fear of corporate default. Tight spreads indicate confidence." }
        ]},
        { "type": "callout", "kind": "key", "title": "The yield curve: still the most important chart", "text": "The spread between the 2-year and 10-year Treasury yield (the 2-10 spread) has predicted most US recessions when it inverts (2-year yield exceeds 10-year yield). Monitor it weekly. When it inverts, acknowledge the signal while avoiding the prediction: 'Historically, this has preceded recessions. The timing is uncertain.'" }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Sector Analysis",
      "summary": "The 11 GICS sectors, what drives each, and how to compare sector performance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Sector analysis helps explain why a portfolio performed differently from the broad market and identifies concentration risks. Knowing what macro factors drive each sector allows you to contextualize performance and anticipate how different economic environments affect client portfolios." },
        { "type": "list", "items": [
          "<strong>Financials:</strong> interest rate sensitive. Banks benefit from rising rates (wider net interest margin). Insurance benefits from higher investment income.",
          "<strong>Technology:</strong> growth-oriented. Benefits from low interest rates (longer-duration earnings). Sensitive to rate increases.",
          "<strong>Healthcare:</strong> defensive. Demand is relatively stable regardless of economic cycle.",
          "<strong>Consumer Staples:</strong> defensive. Food, beverage, household products. Stable demand, lower growth.",
          "<strong>Consumer Discretionary:</strong> cyclical. Autos, retail, restaurants. Demand rises in expansions, falls in contractions.",
          "<strong>Energy:</strong> driven by commodity prices. Benefits from inflation and supply constraints.",
          "<strong>Utilities:</strong> defensive, high dividend yield. Sensitive to interest rates (compete with bonds for income investors)."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Preparing the Market Trend Summary",
      "summary": "The one-page format that turns monitoring into advisor-ready information.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The market trend summary is the output of your monitoring work — a concise briefing that gives the advisor what they need to have informed client conversations. It is not a comprehensive market analysis. It is the most important things the advisor needs to know, stated clearly and briefly." },
        { "type": "list", "items": [
          "<strong>Equity market summary:</strong> major index returns for the period, in 2 sentences",
          "<strong>Fixed income summary:</strong> yield changes, credit spread movement, in 1-2 sentences",
          "<strong>Economic data highlights:</strong> the 1-2 most significant data releases (jobs report, CPI, Fed decision)",
          "<strong>Sector performance:</strong> notable outperformers and underperformers and why",
          "<strong>What to watch next:</strong> upcoming data releases or events that may be relevant to client portfolios"
        ]},
        { "type": "callout", "kind": "warn", "title": "What NOT to include", "text": "Predictions. Specific market calls. Dramatic language ('markets are in crisis'). Reassurances that you cannot back up ('markets always recover'). The summary should inform, not alarm or falsely comfort." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "During a contraction phase of the economic cycle, which sectors typically outperform?", "options": ["Defensive sectors: utilities, healthcare, and consumer staples — whose demand is relatively stable regardless of the economy", "Cyclical sectors: consumer discretionary, industrials, and materials", "Technology, which benefits from companies increasing efficiency spending during downturns", "Financials, which benefit from the credit demand that increases during contractions"], "correct": 0, "explanation": "Defensive sectors produce goods and services people need regardless of economic conditions. During contractions, their relative stability makes them outperformers compared to cyclical sectors whose revenues decline with economic activity." },
      { "id": "q2", "text": "What does a VIX reading above 30 indicate?", "options": ["Elevated market fear — investors expect significant volatility over the next 30 days", "Unusual market calm — low volatility expected", "The market is overvalued relative to earnings", "Interest rates are expected to rise substantially"], "correct": 0, "explanation": "The VIX is the market's expectation of 30-day volatility. Above 30 typically indicates elevated fear and uncertainty. Below 15 indicates market complacency. The VIX tends to spike during market crises." },
      { "id": "q3", "text": "Why is the 2-year/10-year Treasury yield spread (the 2-10 spread) closely watched?", "options": ["Inversion of this spread — when the 2-year yield exceeds the 10-year — has historically preceded most US recessions", "It determines the Federal Reserve's next policy decision", "It measures the premium for holding long-term corporate bonds over government bonds", "It is the primary benchmark for adjustable-rate mortgage pricing"], "correct": 0, "explanation": "The 2-10 inversion has preceded every recession since the 1970s, though with variable lead times. It is the most widely cited yield curve indicator for recession prediction." },
      { "id": "q4", "text": "Why should the economic cycle framework be used for context rather than for specific investment predictions?", "options": ["Nobody rings a bell at the peak or trough — the cycle is identifiable in hindsight but not precisely in real time, making timing calls unreliable", "The economic cycle has not been a reliable indicator of market performance since 2000", "Regulatory rules prohibit using macroeconomic forecasts in investment recommendations", "The cycle is too complex for most clients to understand"], "correct": 0, "explanation": "The economic cycle provides a useful conceptual framework for understanding market behavior patterns. As a timing tool for investment decisions, it is unreliable because the turning points are only identified clearly after they have occurred." },
      { "id": "q5", "text": "Which market data measures the additional yield investors require to hold corporate bonds versus equivalent Treasury bonds?", "options": ["Credit spreads — widening spreads indicate increasing default risk concerns; tightening spreads indicate confidence", "The VIX — which measures equity market volatility expectations", "The yield curve slope — which measures the difference between short and long-term government rates", "Duration — which measures the sensitivity of bonds to rate changes"], "correct": 0, "explanation": "Credit spreads measure the risk premium for corporate credit. Widening spreads signal that the market is becoming more concerned about corporate defaults — often preceding or coinciding with economic deterioration." },
      { "id": "q6", "text": "What drives Financial sector outperformance in a rising interest rate environment?", "options": ["Banks' net interest margin (the spread between what they earn on loans and what they pay on deposits) typically widens when rates rise", "Higher rates reduce loan defaults, improving bank profitability", "Financial companies benefit from the increased demand for hedging products during rate cycles", "Rising rates reduce insurance company liabilities"], "correct": 0, "explanation": "Net interest margin is the primary profitability driver for banks. When short-term rates rise, banks' borrowing costs (deposits) typically adjust more slowly than their lending rates, widening the margin." },
      { "id": "q7", "text": "What belongs in a market trend summary prepared for an advisor?", "options": ["Equity and fixed income returns for the period, significant economic data highlights, sector performance, and upcoming events to watch — all stated concisely", "Comprehensive analysis of every data point released during the period", "Specific investment recommendations triggered by the market conditions", "Predictions about where markets will go over the next quarter"], "correct": 0, "explanation": "The market trend summary is a concise briefing, not a comprehensive analysis. It gives the advisor the most important context for client conversations without requiring them to process everything themselves." },
      { "id": "q8", "text": "Which type of language should be excluded from client market communications?", "options": ["Dramatic language, specific market predictions, and false reassurances like 'markets always recover'", "Plain language explanations of market events", "Contextual comparisons to benchmark performance", "Historical data about how similar market environments have unfolded"], "correct": 0, "explanation": "Dramatic language amplifies fear. Predictions create liability. False reassurances undermine credibility. Market communications should inform and contextualize — not alarm, predict, or falsely comfort." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 31;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Research Brief Format",
      "summary": "The structure that turns research into actionable advisor intelligence.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The research brief is the final deliverable of your research process. It condenses hours of information gathering into the five minutes an advisor needs to make an informed decision or conduct an informed client conversation. Its quality reflects the quality of your thinking — not the volume of your reading." },
        { "type": "numbered", "items": [
          "<strong>Executive summary (2 sentences):</strong> what is the finding and what should the advisor do with it?",
          "<strong>Context (2-3 sentences):</strong> why does this matter now? What prompted the research?",
          "<strong>Key findings (3-5 bullet points):</strong> the data that supports the conclusion, sourced and dated",
          "<strong>Risks / counterarguments (2-3 bullet points):</strong> what could be wrong? What would change the conclusion?",
          "<strong>Recommendation / implication (1-2 sentences):</strong> specifically what should the advisor consider doing in response?"
        ]},
        { "type": "callout", "kind": "key", "title": "Write the executive summary last", "text": "The executive summary is the first thing the advisor reads but it should be the last thing you write. Only after you have completed the full analysis do you know what the two most important sentences are. Writing it first produces a summary of what you intended to find rather than what you actually found." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Drafting Client Communications",
      "summary": "Emails, letters, and market commentary that are professional, compliant, and readable.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client communications are simultaneously relationship tools and compliance documents. They must be accurate, professional, and appropriate — and they must reflect the firm's voice rather than the individual writer's casual register." },
        { "type": "list", "items": [
          "<strong>Email:</strong> subject line states the purpose; first sentence states the most important point; paragraphs are short; close with a clear next step or action",
          "<strong>Client letters:</strong> use the firm's letterhead and approved format; include required compliance disclosures at the end; do not guarantee future performance or returns",
          "<strong>Market commentary:</strong> factual, contextual, no predictions; 200-300 words maximum; ends with how this connects to client strategy"
        ]},
        { "type": "callout", "kind": "warn", "title": "Compliance review requirements", "text": "Any client communication that discusses specific securities, investment strategies, or performance must go through the firm's compliance review before it is sent. This includes market commentaries, emails referencing a specific trade or recommendation, and any communication that could be construed as investment advice." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Internal Advisor Notes",
      "summary": "Writing for the advisor — what they need to know quickly and how to give it to them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Internal advisor notes are a different genre from client communications. They are written for someone with deep expertise who needs specific information quickly — not for someone who needs to be educated about the topic. Write to your audience." },
        { "type": "list", "items": [
          "Lead with the action or recommendation — not the background",
          "Assume the advisor knows the basics — do not over-explain concepts they already understand",
          "Be specific about what you need from them: approval? input? a decision?",
          "Include the deadline if there is one",
          "Attach supporting documents rather than summarizing them extensively in the note"
        ]},
        { "type": "activity", "title": "Communication Format Exercise", "prompt": "For each scenario below, identify the appropriate communication format and write the first paragraph.", "steps": [
          "Scenario A: You need the advisor to approve a rebalancing trade before the market opens tomorrow. Format? Key elements?",
          "Scenario B: A client called while the advisor was in a meeting and left a message asking about the impact of rising rates on their bond portfolio. You need to relay the question and provide relevant context. Format?",
          "Scenario C: You have completed research on a fund that the advisor asked you to evaluate. The fund is not a strong fit. Format? How do you lead?",
          "Scenario D: A client's birthday is tomorrow and the advisor wants a brief, personal note sent. Format and tone?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Building Your Communication Template Library",
      "summary": "The 10 communications you write most often deserve a template — here's how to build one.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every professional who writes regularly develops a set of recurring communication types — the post-meeting follow-up, the document request, the performance review email, the market update, the birthday note. Building and maintaining a template library for these recurring formats saves time and produces more consistent quality." },
        { "type": "numbered", "items": [
          "Identify your 10 most frequently written communications",
          "For each, write the best version you can — including required compliance language, the right tone, and the structure that works",
          "Save it as a template with clear field markers for personalization: [CLIENT NAME], [DATE], [SPECIFIC TOPIC]",
          "Review templates annually — regulatory requirements change, the firm's language standards may evolve",
          "Share templates with colleagues — a good template improves team-wide quality"
        ]},
        { "type": "callout", "kind": "do", "title": "Personalization within templates", "text": "A template should handle the structure and the required language. The personalization — the specific client detail, the reference to their situation, the acknowledgment of what was discussed — that is what makes a template feel personal rather than generic. Templates set the floor; personalization raises it." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why should the executive summary of a research brief be written last?", "options": ["Only after completing the full analysis do you know what the two most important sentences are — writing it first produces a summary of your intentions, not your findings", "Executive summaries require compliance review, which happens after the analysis", "The advisor reads the executive summary first, so it needs to be formatted last", "Writing it last ensures consistency with the conclusion section"], "correct": 0, "explanation": "The executive summary distills the most important insight. Before the analysis is complete, you don't yet know what that insight is. Writing it first leads you to confirm your initial assumption rather than report what you found." },
      { "id": "q2", "text": "Which client communication type must go through compliance review before being sent?", "options": ["Any communication discussing specific securities, investment strategies, or performance — which could be construed as investment advice", "All client emails regardless of content", "Only written letters — emails are exempt from pre-approval requirements", "Communications to clients with more than $1 million in assets"], "correct": 0, "explanation": "Content that references specific securities, strategies, or performance is subject to compliance review because it constitutes investment-related communication with potential liability implications." },
      { "id": "q3", "text": "When writing an internal advisor note requesting approval for a rebalancing trade, what should come first?", "options": ["The action needed and the deadline — not the background or context", "An explanation of why rebalancing is necessary and the supporting analysis", "The specific trades being proposed with their tax implications", "A summary of the client's account history and portfolio objectives"], "correct": 0, "explanation": "Internal notes to advisors should lead with what is needed and by when. The advisor is an expert who doesn't need context explained — they need to know quickly what decision or action is required." },
      { "id": "q4", "text": "What is the maximum recommended length for a client market commentary?", "options": ["200-300 words — concise enough to be read in full, long enough to provide genuine context", "1-2 pages — comprehensive coverage demonstrates advisor expertise", "500 words — enough to fully explain the market environment", "No limit — clients appreciate thorough analysis"], "correct": 0, "explanation": "Client market commentaries that exceed 300 words risk losing the reader. The goal is to be read and understood, not comprehensive. The 200-300 word constraint forces clarity." },
      { "id": "q5", "text": "What are the five components of a well-structured research brief?", "options": ["Executive summary, context, key findings, risks/counterarguments, and recommendation/implication", "Background, methodology, analysis, conclusion, and references", "Investment thesis, supporting data, competing views, risk factors, and price target", "Summary, holdings analysis, performance attribution, risk metrics, and outlook"], "correct": 0, "explanation": "These five components ensure the brief moves from conclusion (executive summary) through evidence (findings and risks) to action (recommendation). The structure makes the brief usable even if the reader only has two minutes." },
      { "id": "q6", "text": "What makes a communication template 'feel personal' rather than generic?", "options": ["Personalization beyond the template: specific client details, references to their situation, and acknowledgments of what was discussed — added to the template's structural framework", "Using the client's first name in the salutation", "Avoiding any templated language whatsoever", "Sending it at a time of day specific to the client's time zone"], "correct": 0, "explanation": "Templates handle structure and required language. Personalization — the specific detail that tells the client you were paying attention — transforms a template into a genuine communication." },
      { "id": "q7", "text": "When a research finding is negative — the fund you evaluated is not a good fit — how should the internal advisor note lead?", "options": ["State the conclusion directly: 'After reviewing [Fund], I recommend we do not use it for these reasons...' — then explain", "Begin with the fund's positive attributes before presenting the concerns", "Present the findings neutrally and allow the advisor to draw their own conclusion", "Start with an explanation of the research methodology before presenting findings"], "correct": 0, "explanation": "Advisors need clear, direct communication — including when the answer is no. Leading with the conclusion and then the reasoning is far more efficient than making the reader infer the conclusion from the data." },
      { "id": "q8", "text": "How frequently should communication templates be reviewed and updated?", "options": ["Annually — regulatory requirements, firm language standards, and best practices evolve and templates must reflect current standards", "Only when a specific error or problem is identified", "When a new advisor joins the team and wants to update the approach", "Every five years as part of the firm's strategic planning cycle"], "correct": 0, "explanation": "Templates contain regulatory language, disclosure requirements, and professional standards that change over time. Annual review ensures templates remain compliant and reflect current best practices." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 32;


-- ── PART 6: GIC-aligned final exam ──
-- ============================================================================
-- GIC APPRENTICE LMS — FINAL COMPREHENSIVE EXAM (GIC Work Process Aligned)
-- 30 questions — one integration-level question per GIC competency GIC-01 to GIC-30
-- Passing score: 85% (26 of 30 correct)
-- Run this AFTER session1_base_schema.sql and final_exam_setup.sql
-- This UPDATES the existing exam content — it does not recreate the tables.
-- ============================================================================

-- Update the existing exam record with new GIC-aligned questions
-- If the exam doesn't exist yet, insert it
INSERT INTO public.final_exams (exam_code, title, description, passing_score, content)
VALUES (
  'WSC-FINAL-2026',
  'Wealth Solutions Counselor — Final Competency Examination',
  'A 30-question integration assessment covering all GIC Work Process competencies. Each question is scenario-based and tests practical application at the level expected of a qualified Wealth Solutions Counselor. Passing score: 85% (26 of 30 correct).',
  85,
  $jsonb$
{
  "questions": [
    {
      "id": "f01",
      "competency": "GIC-01",
      "text": "During a first discovery meeting, a client answers your questions with one or two words and seems reluctant to share financial details. They say, 'I just want someone to manage my money. I don't see why I have to answer all these questions.' What is the most professional response?",
      "options": [
        "Acknowledge the discomfort directly, explain that discovery is how you ensure your advice actually fits their situation, and then ask a smaller, easier-to-answer question to rebuild momentum",
        "Skip the detailed discovery and proceed to investment recommendations to respect the client's preference",
        "Reschedule the meeting for when the client is more willing to participate",
        "Hand the client a written questionnaire to complete on their own time"
      ],
      "correct": 0,
      "explanation": "A reluctant client needs to understand why the questions matter — not be pushed or accommodated by skipping discovery. Acknowledging the discomfort and continuing with smaller questions builds trust while maintaining the professional standard."
    },
    {
      "id": "f02",
      "competency": "GIC-02",
      "text": "A client returns a document package that includes tax returns, brokerage statements, and a pay stub. You notice that the investment statement is from 18 months ago, the pay stub is from a previous employer, and the tax returns are for the most recent year. What is the correct next step?",
      "options": [
        "Request updated documents specifically: a current brokerage statement as of the most recent quarter-end and a current pay stub from the client's current employer, then verify before proceeding with analysis",
        "Use the available documents and note in the file that some information may be outdated",
        "Proceed with the analysis using the tax returns, which are current, and estimate the other figures",
        "Contact the custodian directly to obtain a current brokerage statement without involving the client"
      ],
      "correct": 0,
      "explanation": "Financial planning requires current, accurate documents. An 18-month-old investment statement and a pay stub from a previous employer cannot support accurate analysis. Both must be replaced before work proceeds."
    },
    {
      "id": "f03",
      "competency": "GIC-03",
      "text": "A client says they have $800 left over at the end of every month, but their savings account grew by only $1,200 last year. How do you explain this gap and what is the most useful next step?",
      "options": [
        "Explain that the $6,600 gap ($9,600 expected minus $1,200 actual) represents untracked spending, and offer to review 3-6 months of bank statements together to identify where the money is actually going",
        "Suggest the client set up automatic transfers of $800/month to prevent the money from being spent",
        "Conclude that the client's income must have been lower than expected and recalculate based on a lower figure",
        "Assume the client made a large one-time purchase and proceed with planning based on the stated surplus"
      ],
      "correct": 0,
      "explanation": "The gap between expected and actual savings is one of the most diagnostic findings in cash flow work. The $6,600 discrepancy represents real spending that wasn't tracked. Bank statement review is the only way to find it."
    },
    {
      "id": "f04",
      "competency": "GIC-04",
      "text": "A 58-year-old client wants to retire at 62. They currently earn $95,000/year, have $380,000 in their 401(k), and expect Social Security of $1,650/month at 62. They estimate they need $5,500/month in retirement. What is the most immediate concern you should surface in the retirement scenario?",
      "options": [
        "The portfolio must fund a $3,850/month gap ($5,500 needed minus $1,650 Social Security) for potentially 30+ years from a $380,000 base — which at a 4% withdrawal rate supports only $1,267/month. The client is significantly underfunded for their retirement goal at 62.",
        "The client should delay Social Security until 70 to maximize the benefit",
        "The 401(k) balance is adequate if invested aggressively for the four remaining working years",
        "The client's income is too low to fund the gap and they should consider part-time work"
      ],
      "correct": 0,
      "explanation": "A 4% withdrawal rate on $380,000 yields ~$15,200/year (~$1,267/month). The client needs $3,850/month beyond Social Security. The portfolio shortfall is the primary planning problem — it must be surfaced directly."
    },
    {
      "id": "f05",
      "competency": "GIC-05",
      "text": "A client has a will leaving everything to their current spouse. Their IRA beneficiary form still lists their ex-spouse (divorced 3 years ago). The client is surprised and says the will should override the beneficiary form. What is the accurate explanation?",
      "options": [
        "Beneficiary designations on retirement accounts override the will — the ex-spouse will receive the IRA at death regardless of what the will says. The beneficiary form must be updated immediately.",
        "The will does override the beneficiary form since it was executed after the divorce",
        "The divorce decree automatically removes the ex-spouse as beneficiary by operation of law",
        "The IRA custodian will investigate the conflict and determine the correct beneficiary at death"
      ],
      "correct": 0,
      "explanation": "Beneficiary designations are contractual — they control the distribution of retirement accounts regardless of what the will says. This is the most misunderstood aspect of estate planning. The update must happen immediately."
    },
    {
      "id": "f06",
      "competency": "GIC-06",
      "text": "You are preparing a planning summary for a client who just received a $200,000 inheritance. The summary is 14 pages and includes the full analysis, all scenario details, and every data point you reviewed. The advisor asks you to revise it before the client meeting. What is the most important revision?",
      "options": [
        "Add a one-page executive summary at the front that answers three questions: where does the client stand, what are the most important recommendations for the inheritance, and what are the next steps — so the client can understand the key points without reading all 14 pages",
        "Reduce the font size so the document fits in fewer pages",
        "Remove the scenario details and leave only the final recommendations",
        "Add a table of contents so the client can navigate to sections of interest"
      ],
      "correct": 0,
      "explanation": "Planning summaries must lead with conclusions. A 14-page document without an executive summary forces the client to read everything to find what matters most. The one-page executive summary is the essential missing element."
    },
    {
      "id": "f07",
      "competency": "GIC-07",
      "text": "Three days after a client meeting, you realize you never logged the interaction in the CRM. You remember most of what was discussed but not all the details. What is the correct action?",
      "options": [
        "Log the interaction now with as much accurate detail as you can recall, clearly noting the actual meeting date and the date the entry was created, and flag any uncertain details as 'per recollection' — then commit to logging within 24 hours going forward",
        "Skip the entry since too much time has passed for it to be useful",
        "Ask a colleague to log the entry based on your verbal summary",
        "Wait for the client's next contact and update the log at that point"
      ],
      "correct": 0,
      "explanation": "A late entry is better than no entry, but it must be accurate and transparent about its limitations. Noting both the actual meeting date and the entry date, and flagging uncertain details, maintains the integrity of the record."
    },
    {
      "id": "f08",
      "competency": "GIC-08",
      "text": "During a client annual review meeting you are attending as a support associate, you notice that the client seems confused after the advisor explains a Roth conversion strategy — but the advisor has already moved on to the next topic. What is the appropriate action?",
      "options": [
        "Note the apparent confusion in your meeting notes and flag it to the advisor after the meeting, recommending that Roth conversion be followed up with a brief written explanation in the follow-up email",
        "Interrupt the meeting to re-explain the Roth conversion to the client",
        "Say nothing — it is the advisor's responsibility to read the room",
        "Ask the client directly if they understood the strategy while the advisor is speaking"
      ],
      "correct": 0,
      "explanation": "Your role in client meetings is observation, documentation, and follow-through — not intervention. The correct action is to capture the confusion in your notes and ensure the advisor addresses it in the follow-up. Interrupting the meeting oversteps your role."
    },
    {
      "id": "f09",
      "competency": "GIC-09",
      "text": "A client scores 'moderately aggressive' on the risk questionnaire but their financial situation shows: six months from retirement, all savings in a single 401(k), no pension, and Social Security of only $1,400/month. They need $5,000/month in retirement. How should the suitability determination resolve this?",
      "options": [
        "Surface the conflict: the client's risk capacity (near-retirement, single asset, large income gap) does not support a moderately aggressive strategy regardless of their stated tolerance. Present the options honestly: accept a lower-return conservative strategy and adjust retirement income expectations, or extend the working timeline.",
        "Accept the questionnaire result and invest aggressively as the client prefers — their stated tolerance controls",
        "Average the questionnaire result with the financial situation to arrive at a 'moderate' strategy",
        "Document 'moderately aggressive' as stated and note the concerns separately without changing the recommendation"
      ],
      "correct": 0,
      "explanation": "When risk tolerance and risk capacity conflict, the fiduciary obligation requires surfacing the conflict and helping the client make an informed decision. A client six months from retirement with no pension and a large income gap does not have the capacity to absorb significant losses."
    },
    {
      "id": "f10",
      "competency": "GIC-10",
      "text": "A client's portfolio started the year at 60% equities / 40% fixed income. After a strong equity market, the allocation has drifted to 72% equities / 28% fixed income. The client is in a taxable account. What is the most tax-efficient first step before selling anything to rebalance?",
      "options": [
        "Redirect the client's next quarterly contribution and any dividends entirely to the fixed income positions to restore balance without triggering a taxable sale",
        "Sell the most appreciated equity positions to fund the fixed income purchase",
        "Sell the lowest-gain equity positions first to minimize capital gains",
        "Wait until December to harvest any offsetting losses before rebalancing"
      ],
      "correct": 0,
      "explanation": "Redirecting new contributions and dividends is the most tax-efficient rebalancing technique — it restores balance without triggering any taxable event. Only after exhausting this option should actual selling be considered."
    },
    {
      "id": "f11",
      "competency": "GIC-11",
      "text": "You are comparing two funds for a client's taxable account. Fund A is an actively managed large-cap fund with a 0.92% expense ratio and 95% annual turnover. Fund B is a large-cap index ETF with a 0.04% expense ratio and 4% turnover. Both have similar 10-year performance records. Which is more appropriate for a taxable account and why?",
      "options": [
        "Fund B — the ETF's dramatically lower expense ratio and near-zero turnover mean lower annual costs and far fewer taxable capital gain distributions, which is critical for a taxable account",
        "Fund A — higher turnover signals more active management, which may protect the client during market downturns",
        "Fund A — the higher expense ratio reflects more sophisticated management that produces better risk-adjusted returns",
        "They are equally appropriate since the 10-year performance records are similar"
      ],
      "correct": 0,
      "explanation": "In a taxable account, costs and tax efficiency dominate. Fund B's expense ratio is 22x lower and its 4% turnover vs. 95% means dramatically fewer taxable distributions. When after-tax, after-cost returns are considered, Fund B wins significantly."
    },
    {
      "id": "f12",
      "competency": "GIC-12",
      "text": "The S&P 500 declined 8% in a quarter. A client's 60/40 portfolio declined 4.9%. The 60/40 benchmark declined 5.2%. The client calls concerned. What is the most accurate and reassuring context to provide?",
      "options": [
        "The portfolio declined 4.9%, which is less than its benchmark (5.2%) and significantly less than the pure equity index (8%). The portfolio performed as designed — the fixed income allocation cushioned the equity decline. Nothing in the quarter changes the investment strategy.",
        "The market is down, but markets always recover — no action needed",
        "The portfolio lost nearly 5%, which is concerning and may warrant a shift to a more conservative allocation",
        "The S&P 500 is the wrong benchmark — the client should compare to a pure bond index for a fair comparison"
      ],
      "correct": 0,
      "explanation": "Performance communication must provide three pieces of context: what the market did, how the portfolio performed relative to its benchmark, and whether anything warrants a strategy change. All three point to 'the portfolio worked as intended.'"
    },
    {
      "id": "f13",
      "competency": "GIC-13",
      "text": "You are preparing a research brief on a sector ETF your advisor is considering for client portfolios. You find conflicting data: one sell-side report rates the sector 'Overweight' while another rates it 'Underweight.' How should you handle this conflict in the brief?",
      "options": [
        "Present both views, note the potential conflict of interest inherent in sell-side research, include the key supporting data for each position, and let the advisor draw the conclusion — your job is to surface the tension, not resolve it unilaterally",
        "Use only the 'Overweight' recommendation since it supports the advisor's consideration of the ETF",
        "Exclude both since conflicting sell-side opinions are not useful research",
        "Average the two views and present a 'Neutral' recommendation"
      ],
      "correct": 0,
      "explanation": "Conflicting research is valuable information — it tells you the sector is genuinely uncertain. The research brief must present both views with their supporting data and flag the conflict of interest. The advisor makes the judgment call with complete information."
    },
    {
      "id": "f14",
      "competency": "GIC-14",
      "text": "A colleague discovers a trade error in a client account — the wrong security was purchased. The error has not been noticed by the client. The colleague wants to quietly sell the wrong security and purchase the correct one without documenting the error. What is the correct response?",
      "options": [
        "Document the error immediately and involve the compliance department — attempting to correct it quietly creates a second, more serious problem (concealment) on top of the original error",
        "Help the colleague execute the correction quietly since the client was not harmed",
        "Tell the colleague to disclose the error to the client before correcting it",
        "Do nothing since the error is not yours to report"
      ],
      "correct": 0,
      "explanation": "Concealing errors from compliance is a more serious violation than the original error. Regulators distinguish between errors that are disclosed and corrected promptly versus errors that are concealed. The colleague must involve compliance, not avoid it."
    },
    {
      "id": "f15",
      "competency": "GIC-15",
      "text": "You generate a quarterly performance report for a client and notice the portfolio is showing +11.4% while the benchmark shows +5.8%. Before sending the report, you realize the benchmark selected is the S&P 500 but the client's portfolio is 60% equities / 40% bonds. What do you do?",
      "options": [
        "Correct the benchmark to a 60/40 blended index before sending — using the S&P 500 as a benchmark for a balanced portfolio is misleading regardless of whether it makes performance look better or worse",
        "Send the report with the S&P 500 benchmark since it shows favorable relative performance",
        "Send the report without any benchmark since the comparison is not straightforward",
        "Use the client's original benchmark from when the account was opened, even if it is no longer appropriate"
      ],
      "correct": 0,
      "explanation": "Benchmark selection is a professional and compliance obligation. An inappropriate benchmark — even one that makes performance look good — produces a misleading report. The correct benchmark for a 60/40 portfolio is a 60/40 blended index."
    },
    {
      "id": "f16",
      "competency": "GIC-16",
      "text": "The firm purchases a new server for $18,000. The bookkeeper wants to expense it as an office supply purchase this month. Why is this incorrect and what is the right treatment?",
      "options": [
        "A server that provides benefit over multiple years must be capitalized as an asset and depreciated — expensing it immediately overstates this period's expenses and understates the firm's long-term asset base",
        "It is correct since the server is a technology purchase, which is always expensed",
        "The treatment depends on the firm's cash accounting method — under cash basis, immediate expensing is acceptable",
        "The threshold for capitalization is $25,000 — items below this amount should be expensed"
      ],
      "correct": 0,
      "explanation": "Capitalization rules require that assets providing multi-year benefit be recorded as assets and depreciated over their useful life. Expensing an $18,000 server produces an inaccurate income statement and an understated balance sheet."
    },
    {
      "id": "f17",
      "competency": "GIC-17",
      "text": "During daily reconciliation, you find a $4,200 discrepancy in a client account — the portfolio management system shows 100 shares valued at $42/share while the custodian shows the same 100 shares at $84/share. After investigation, you discover the custodian applied a 2-for-1 stock split but the portfolio system did not. What is the resolution?",
      "options": [
        "Process the corporate action in the portfolio management system: double the share count to 200 shares at $42/share and verify the total market value now matches the custodian — then document the error, root cause, and resolution",
        "Accept the custodian's figures since they are always authoritative",
        "Accept the portfolio system's figures and report the discrepancy to the custodian as their error",
        "Escalate immediately to senior management since the discrepancy exceeds $1,000"
      ],
      "correct": 0,
      "explanation": "The corporate action (2-for-1 split) was processed by the custodian but not by the portfolio system. The resolution is to apply the split in the portfolio system and verify the reconciliation clears. Documentation is required regardless of size."
    },
    {
      "id": "f18",
      "competency": "GIC-18",
      "text": "A client's net worth statement shows total assets of $845,000 and total liabilities of $410,000. This is the third consecutive year the net worth has declined (from $950,000 two years ago and $890,000 last year). What does this trend signal and what is the appropriate advisor response?",
      "options": [
        "Liabilities are growing faster than assets over three consecutive years — this is a structural financial warning that requires an honest conversation about what is driving the trend and what needs to change in the financial plan",
        "A declining net worth over three years is normal during a market downturn and does not require immediate action",
        "The trend is not significant since the client still has positive net worth",
        "Request updated documents to verify the figures are accurate before drawing conclusions"
      ],
      "correct": 0,
      "explanation": "Three consecutive years of declining net worth signals a structural problem, not a market event. Even with positive net worth, the trend means liabilities are outpacing assets. This requires investigation and a plan response, not reassurance."
    },
    {
      "id": "f19",
      "competency": "GIC-19",
      "text": "After running the quarterly billing cycle, your reconciliation shows that 3 accounts were billed $150 more than their calculated fee due to an AUM calculation error — the fee was calculated on a higher balance than the actual quarter-end balance. What is the correct response?",
      "options": [
        "Credit each of the three accounts for the $150 overbilling, document the error and its cause, correct the AUM calculation process, and report the error to the compliance department per firm policy",
        "Apply the $450 total overbilling as a credit against next quarter's fees to avoid the administrative burden of individual credits",
        "No action is required since $150 per account is below the materiality threshold",
        "Notify the clients informally and resolve at the next billing cycle"
      ],
      "correct": 0,
      "explanation": "Fee errors — even small ones — must be corrected immediately, documented completely, and reported to compliance. Billing clients more than their agreed fee is a compliance violation. Materiality thresholds do not apply to unauthorized fee deductions."
    },
    {
      "id": "f20",
      "competency": "GIC-20",
      "text": "You are entering a client's retirement account information into the financial planning software. The client told you their 401(k) balance is 'around $485,000.' Their statement shows the quarter-end balance as $478,340. Which figure should you enter?",
      "options": [
        "The documented figure from the statement: $478,340 — client estimates are unreliable for planning purposes and all data entry must be sourced from verified documents",
        "The round number of $480,000 as a reasonable approximation",
        "The client's estimate of $485,000 since they know their account better than a statement",
        "The average of $481,670 to balance the two sources"
      ],
      "correct": 0,
      "explanation": "Every data entry must be sourced from a verified document — never from client memory. The quarter-end statement is the authoritative figure. Estimates produce plans that reflect estimates, not reality."
    },
    {
      "id": "f21",
      "competency": "GIC-21",
      "text": "During a self-audit of client files, you find that 8 of 20 files are missing the signed ADV Part 2 delivery receipt. The annual ADV was sent to all clients 4 months ago. What is the appropriate response?",
      "options": [
        "Report the gap to the compliance department, identify the 8 clients who did not return a receipt, and follow up to obtain signed receipts — then implement a tracking process to prevent the same gap next year",
        "Send the ADV Part 2 again to the 8 clients and wait for them to return receipts at their convenience",
        "Note the gap in the file with an explanation that the ADV was sent and compliance assumes receipt",
        "No action is needed since the firm has records that the ADV was sent, which is sufficient"
      ],
      "correct": 0,
      "explanation": "Sending the ADV is required; documenting receipt is also required. Missing receipts are an audit finding waiting to happen. Reporting to compliance, following up to obtain receipts, and fixing the process prevents recurrence."
    },
    {
      "id": "f22",
      "competency": "GIC-22",
      "text": "You send an email to operations requesting a wire transfer for a client. The wire does not process and you later find out the email contained the account number but not the wire amount, destination bank, or wire instructions. The wire cutoff has now passed. What should have been in the original request?",
      "options": [
        "Client name and account number, wire amount, destination bank name and routing number, beneficiary account number and name, any special instructions, and the requested processing date — all in the first email",
        "A phone call to operations rather than an email, since wire requests require verbal confirmation",
        "The client's signed authorization form, which operations can use to look up all other details",
        "A general description of the wire request with a follow-up call to provide specifics"
      ],
      "correct": 0,
      "explanation": "Money movement requests must include every piece of information operations needs to process correctly in the first communication. Missing any element causes delays and, in time-sensitive situations, missed cutoffs."
    },
    {
      "id": "f23",
      "competency": "GIC-23",
      "text": "You are preparing the meeting packet for a client's annual review. The performance report you generated shows the client's account is up 9.2% while the benchmark is up 12.1%. Before sending the packet to the advisor, what additional preparation is most important?",
      "options": [
        "Prepare a brief note for the advisor explaining the 2.9% underperformance — what drove it, whether it is within the normal range for this strategy, and suggested talking points for the client conversation",
        "Regenerate the report using a different benchmark to produce a more favorable comparison",
        "Add a disclaimer to the performance report noting that past performance does not guarantee future results",
        "Send the packet as-is since the advisor will identify and address the underperformance in the meeting"
      ],
      "correct": 0,
      "explanation": "The advisor pre-meeting brief should flag potential client concerns — including underperformance — with context and suggested talking points. This is the value of thorough preparation. Sending the packet without a briefing note leaves the advisor unprepared."
    },
    {
      "id": "f24",
      "competency": "GIC-24",
      "text": "During a supervised suitability needs analysis, a client says: 'I want to invest this $300,000 conservatively, but I need it to grow enough that I can retire in 8 years.' You calculate that retiring in 8 years requires approximately 7.5% annual growth on this amount. What is the correct way to handle this conflict?",
      "options": [
        "Surface the conflict directly: a conservative strategy is unlikely to achieve 7.5% growth. Present the three options — accept more investment risk, extend the working timeline, or reduce retirement income expectations — and document the discussion and the client's decision",
        "Select a 'moderate' strategy as a compromise between conservative and the required return",
        "Document 'conservative with growth objective' and invest conservatively as stated",
        "Recommend a 7.5% return target and explain that this requires an aggressive strategy, overriding the client's stated preference"
      ],
      "correct": 0,
      "explanation": "The fiduciary obligation requires surfacing conflicts between stated preference and mathematical reality. A conservative strategy cannot reliably achieve 7.5% growth. The client must make an informed choice among the available options — not have the conflict papered over."
    },
    {
      "id": "f25",
      "competency": "GIC-25",
      "text": "A client has a financial advisor, a CPA, and an estate attorney, but you discover the financial plan shows the client's taxable brokerage account titled in their individual name while the estate plan requires it to be titled in the name of their revocable trust. What action is required?",
      "options": [
        "This is a plan implementation gap — the account must be retitled into the trust to fund it properly. Coordinate with the estate attorney to confirm the correct titling and with the custodian to process the retitling before it becomes a probate issue",
        "Note the discrepancy in the file and address it at the next annual review",
        "The attorney's responsibility — no action needed from the advisory team",
        "Retitle the account immediately without consulting the attorney since the intent is clear from the trust document"
      ],
      "correct": 0,
      "explanation": "An unfunded trust is nearly useless. This is a wealth management coordination gap — the legal document exists but the financial account does not reflect it. The advisor must coordinate with the attorney and custodian to fund the trust correctly."
    },
    {
      "id": "f26",
      "competency": "GIC-26",
      "text": "A client asks why their portfolio holds municipal bonds in their Roth IRA account. You know from your product knowledge that municipal bond interest is federal tax-exempt. Why is this placement potentially suboptimal?",
      "options": [
        "Municipal bonds' tax-exempt interest provides no additional benefit inside a Roth IRA, which is already tax-free. The yield premium of munis over taxable bonds compensates for the tax exemption — placing them in a Roth eliminates the tax advantage while accepting the lower pre-tax yield",
        "Municipal bonds are not allowed in retirement accounts due to their tax-exempt status",
        "Roth IRAs require growth investments — income-producing bonds are not appropriate",
        "There is no issue — the tax treatment of the account and the bond are independent"
      ],
      "correct": 0,
      "explanation": "Municipal bonds are priced to provide a lower pre-tax yield in exchange for their tax exemption. In a Roth IRA — which is already tax-free — the tax exemption adds no value. The after-tax yield would typically be higher with a taxable bond in the same account."
    },
    {
      "id": "f27",
      "competency": "GIC-27",
      "text": "A client who normally calls every few weeks has not contacted the office in three months. They also missed their annual review meeting without rescheduling and did not respond to two emails. What is the appropriate response?",
      "options": [
        "Treat this as a potential attrition signal and make direct personal contact — call the client, acknowledge the gap, and ask a direct question about whether the relationship is meeting their expectations",
        "Continue the normal service cadence and wait for the client to re-engage on their own timeline",
        "Send a formal letter documenting the missed review and requesting a response within 30 days",
        "Schedule a home visit to check on the client's wellbeing"
      ],
      "correct": 0,
      "explanation": "Sudden disengagement is one of the strongest attrition signals. The appropriate response is proactive, personal contact — not patience. A direct question about whether the relationship is meeting expectations gives the client a chance to either raise their concern or be reassured by the outreach."
    },
    {
      "id": "f28",
      "competency": "GIC-28",
      "text": "A client's target portfolio is 60% US equities / 20% international equities / 20% bonds. The current allocation is 68% US equities / 18% international equities / 14% bonds. You are modeling the rebalancing trades on a $400,000 taxable account. What is the minimum set of trades that restores the target?",
      "options": [
        "Sell approximately $32,000 of US equities; use the proceeds to buy $8,000 of international equities and $24,000 of bonds — restoring US equities to 60% ($240K), international to 20% ($80K), and bonds to 20% ($80K)",
        "Sell all overweight positions simultaneously and buy all underweight positions with the proceeds",
        "Sell $32,000 of US equities and buy $32,000 of bonds only, leaving international unchanged",
        "Buy the underweight positions using new contributions rather than selling anything"
      ],
      "correct": 0,
      "explanation": "US equities are 8% overweight ($32,000 on $400K). International is 2% underweight ($8,000). Bonds are 6% underweight ($24,000). The minimum correction sells $32,000 of US equities and buys both underweight positions proportionally."
    },
    {
      "id": "f29",
      "competency": "GIC-29",
      "text": "The 2-year Treasury yield rises above the 10-year Treasury yield (the yield curve inverts). In your weekly market trend summary for the advisor, how should you characterize this?",
      "options": [
        "Note that the yield curve has inverted — a condition that has historically preceded most US recessions, though with uncertain timing — and identify which client portfolios have the most exposure to the risks typically associated with economic slowdown",
        "Predict that a recession will begin within the next six months based on the historical pattern",
        "Recommend shifting all client portfolios to cash since recession is imminent",
        "Dismiss it as a temporary technical event unlikely to reflect economic fundamentals"
      ],
      "correct": 0,
      "explanation": "The yield curve inversion is a meaningful signal worth noting — but it is a pattern, not a prediction. The professional response acknowledges the historical context, avoids specific timing claims, and identifies portfolio implications for the advisor's consideration."
    },
    {
      "id": "f30",
      "competency": "GIC-30",
      "text": "You have completed a research brief recommending against adding a specific alternative investment fund to the firm's model portfolios. The fund has strong marketing materials and the advisor has expressed initial enthusiasm. How do you present the finding?",
      "options": [
        "Lead with the conclusion directly: 'After reviewing [Fund], I recommend we do not use it. The primary reasons are: [1, 2, 3]. Here is the supporting evidence.' Then provide the counterarguments and the data that informed the conclusion.",
        "Present the positive and negative factors equally and ask the advisor to make the call without stating your view",
        "Present only the positive factors since the advisor is enthusiastic and a negative recommendation may create friction",
        "Ask a colleague to review and present the finding since your negative recommendation may conflict with the advisor's preference"
      ],
      "correct": 0,
      "explanation": "Professional research communication leads with the conclusion, regardless of whether it aligns with the audience's prior view. Presenting findings neutrally to avoid conflict is not objectivity — it is avoidance. The advisor needs the conclusion and the reasoning to make a good decision."
    }
  ]
}
$jsonb$::jsonb
)
ON CONFLICT (exam_code) DO UPDATE SET
  title        = EXCLUDED.title,
  description  = EXCLUDED.description,
  passing_score = EXCLUDED.passing_score,
  content      = EXCLUDED.content,
  updated_at   = now();

-- ============================================================================
-- VERIFICATION
-- SELECT exam_code, title, passing_score,
--        jsonb_array_length(content->'questions') as question_count
-- FROM public.final_exams;
-- Expected: 1 row, WSC-FINAL-2026, passing_score 85, question_count 30
-- ============================================================================
