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
