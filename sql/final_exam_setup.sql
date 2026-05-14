-- ============================================================================
-- GIC APPRENTICE LMS — FINAL COMPREHENSIVE EXAM
-- 30 questions, one per competency, integration-level assessment
-- Passing score: 85% (26 of 30 correct)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Schema: final_exams + final_exam_attempts (idempotent)
-- ----------------------------------------------------------------------------

create table if not exists public.final_exams (
  id uuid primary key default gen_random_uuid(),
  exam_code text unique not null,
  title text not null,
  description text,
  passing_score integer not null default 85,
  content jsonb not null,
  is_active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.final_exam_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  exam_code text not null,
  score integer not null,
  total_questions integer not null,
  passed boolean not null,
  answers jsonb,
  competency_breakdown jsonb,
  started_at timestamptz default now(),
  completed_at timestamptz default now(),
  reviewed_by uuid references auth.users(id),
  reviewed_at timestamptz,
  review_notes text
);

create index if not exists final_exam_attempts_user_idx
  on public.final_exam_attempts(user_id);
create index if not exists final_exam_attempts_exam_idx
  on public.final_exam_attempts(exam_code);

-- ----------------------------------------------------------------------------
-- 2. RLS
-- ----------------------------------------------------------------------------

alter table public.final_exams enable row level security;
alter table public.final_exam_attempts enable row level security;

drop policy if exists "final_exams readable by authenticated" on public.final_exams;
create policy "final_exams readable by authenticated"
  on public.final_exams for select
  using (auth.role() = 'authenticated' and is_active = true);

drop policy if exists "final_exams admin manage" on public.final_exams;
create policy "final_exams admin manage"
  on public.final_exams for all
  using (
    exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver')
    )
  );

drop policy if exists "exam_attempts own read" on public.final_exam_attempts;
create policy "exam_attempts own read"
  on public.final_exam_attempts for select
  using (
    user_id = auth.uid()
    or exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver', 'mentor')
    )
  );

drop policy if exists "exam_attempts own insert" on public.final_exam_attempts;
create policy "exam_attempts own insert"
  on public.final_exam_attempts for insert
  with check (user_id = auth.uid());

drop policy if exists "exam_attempts admin review" on public.final_exam_attempts;
create policy "exam_attempts admin review"
  on public.final_exam_attempts for update
  using (
    exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver')
    )
  );

-- Trigger for updated_at (depends on tg_set_updated_at() from session 1)
drop trigger if exists final_exams_set_updated_at on public.final_exams;
create trigger final_exams_set_updated_at
  before update on public.final_exams
  for each row execute function public.tg_set_updated_at();

-- ----------------------------------------------------------------------------
-- 3. Insert the comprehensive final exam
-- ----------------------------------------------------------------------------

insert into public.final_exams (exam_code, title, description, passing_score, content)
values (
  'FINAL-COMPREHENSIVE',
  'Wealth Solutions Counselor — Final Comprehensive Exam',
  'Capstone assessment covering all thirty competencies of the apprenticeship. One question per competency, integration-level scenarios drawn from real client work. Must be completed after all thirty modules and signed off by the supervising counselor. Passing score: 85% (26 of 30 correct).',
  85,
  $jsonb$
  {
    "exam_type": "final_comprehensive",
    "intro": {
      "title": "Final Comprehensive Exam",
      "summary": "Thirty integration-level questions covering all thirty competencies. This is the final assessment of the Wealth Solutions Counselor apprenticeship.",
      "instructions": [
        "You must have completed all thirty modules before sitting for this exam.",
        "Your supervising counselor must have signed off on your apprenticeship completion before submission counts.",
        "Passing score is 85% — 26 of 30 questions correct.",
        "The exam covers integration of competencies in scenarios drawn from real client work. Recall alone is not sufficient — apply what you have learned.",
        "If you do not pass on the first attempt, a retake may be scheduled after additional review with your mentor on the competencies missed.",
        "Take the time you need. This is not timed. Quality of reasoning matters more than speed.",
        "After you submit, your supervising counselor and the firm's approver will review the result and any apprenticeship documentation."
      ]
    },
    "passing_score": 85,
    "competency_count": 30,
    "questions": [
      {
        "id": "q1",
        "competency": "CORE-1",
        "competency_name": "Financial Literacy & Planning",
        "prompt": "A client reports monthly take-home income of $8,400 and expenses of $7,950, telling you they feel they 'should be saving more.' The strongest next move is to:",
        "options": [
          "Recommend they begin saving $1,500 per month immediately",
          "Walk through their expense categories — fixed, variable, discretionary — to build savings around an honest cash flow picture rather than an aspirational one",
          "Suggest a budgeting app and end the conversation",
          "Defer planning until next year's tax return is filed"
        ],
        "correct": 1,
        "explanation": "Cash flow analysis must precede savings recommendations. Imposing a savings target the cash flow cannot support invites failure and damages trust. Working through real categories produces sustainable saving."
      },
      {
        "id": "q2",
        "competency": "CORE-2",
        "competency_name": "Time Value of Money",
        "prompt": "A 30-year-old client has $25,000 saved, can contribute $500 per month, and expects 7% nominal annualized returns. At age 65, the projected balance is approximately:",
        "options": [
          "~$300,000",
          "~$580,000",
          "~$1.1 million",
          "~$2.5 million"
        ],
        "correct": 2,
        "explanation": "Lump-sum future value of $25,000 at 7% for 35 years is roughly $267,000. Future value of a $500/month annuity at 7% over 35 years is roughly $900,000. Combined ≈ $1.17M. This is the power of compounding paired with consistent contribution."
      },
      {
        "id": "q3",
        "competency": "CORE-3",
        "competency_name": "Credit, Debt & Lending",
        "prompt": "Marcus and Tasha carry credit card debt at 22% APR, an auto loan at 6%, and a mortgage at 4.5%. With $1,500 of extra monthly cash flow, the mathematically optimal payoff strategy is:",
        "options": [
          "Pay off the smallest balance first regardless of rate (debt snowball)",
          "Apply all extra to the highest-rate debt — the credit card at 22% — first (debt avalanche)",
          "Distribute extra payments evenly across all three",
          "Accelerate the mortgage first because of the long term"
        ],
        "correct": 1,
        "explanation": "The avalanche method — extra payments to the highest-interest debt first — minimizes total interest paid. The snowball method has behavioral advantages but is mathematically suboptimal. Knowing both and choosing intentionally with the client is the skill."
      },
      {
        "id": "q4",
        "competency": "CORE-4",
        "competency_name": "Risk Management & Insurance",
        "prompt": "A 38-year-old primary earner with two young children, a non-working spouse, a $500,000 mortgage, and $25,000 in savings has the most urgent insurance need for:",
        "options": [
          "Whole life insurance with cash value accumulation",
          "Term life insurance with a death benefit sized to replace income through child independence and pay off the mortgage",
          "A deferred annuity",
          "Long-term care insurance"
        ],
        "correct": 1,
        "explanation": "The catastrophic loss for this household is the loss of the earner. Term life — cheap, large death benefit, matched to the dependency horizon — is the right tool. Whole life addresses different problems and is not the urgent need here."
      },
      {
        "id": "q5",
        "competency": "CORE-5",
        "competency_name": "Tax Fundamentals",
        "prompt": "A client in the 24% federal marginal tax bracket contributes $7,000 to a Traditional IRA (assume full deductibility). The immediate federal income tax savings is approximately:",
        "options": [
          "$7,000",
          "$1,680",
          "$2,400",
          "$0 — IRA contributions never reduce current taxes"
        ],
        "correct": 1,
        "explanation": "$7,000 × 24% = $1,680. Traditional IRA contributions reduce current taxable income, with savings calculated at the marginal rate. The full $7,000 is not saved — only the tax on that income would have been."
      },
      {
        "id": "q6",
        "competency": "CORE-6",
        "competency_name": "Investment Vehicles & Markets",
        "prompt": "An ETF and a mutual fund tracking the same index differ most importantly in:",
        "options": [
          "Their underlying holdings — they hold different securities",
          "Structural differences affecting tax efficiency, intraday tradability, and expense ratios — with ETFs generally more tax-efficient due to in-kind creation/redemption",
          "Return potential — ETFs outperform mutual funds",
          "Regulatory oversight — only one is SEC-regulated"
        ],
        "correct": 1,
        "explanation": "Same index, same holdings, materially different structure. ETFs trade intraday on exchanges and use in-kind transfers that limit capital gains distributions. Mutual funds price once daily and can distribute taxable gains to all shareholders."
      },
      {
        "id": "q7",
        "competency": "CORE-7",
        "competency_name": "Retirement Planning Foundations",
        "prompt": "A client with a Social Security Full Retirement Age (FRA) of 67 claims benefits at age 62. They will receive approximately what percentage of their Primary Insurance Amount (PIA)?",
        "options": [
          "100% — claiming early has no permanent effect",
          "About 70% — claiming five years early permanently reduces the benefit",
          "50% — early claiming halves the benefit",
          "132% — early claiming triggers delayed retirement credits"
        ],
        "correct": 1,
        "explanation": "Claiming at 62 with an FRA of 67 reduces the benefit to roughly 70% of PIA, permanently. Conversely, delaying past FRA earns 8% annually in delayed retirement credits up to age 70."
      },
      {
        "id": "q8",
        "competency": "CORE-8",
        "competency_name": "Estate Planning & Wealth Transfer",
        "prompt": "A client has a will leaving everything to their spouse. They also have an IRA on which an old beneficiary form names their adult child from a prior marriage as 100% beneficiary. Upon the client's death, the IRA passes to:",
        "options": [
          "The spouse, because the will controls all assets",
          "The adult child named on the beneficiary form, because retirement account beneficiary designations override the will",
          "The estate, splitting between spouse and child",
          "Probate court — to be decided by a judge"
        ],
        "correct": 1,
        "explanation": "Beneficiary designations on retirement accounts and life insurance are non-probate transfers that override the will. This is one of the most consequential and routinely-mishandled details in estate planning."
      },
      {
        "id": "q9",
        "competency": "CORE-9",
        "competency_name": "Ethics, Fiduciary Duty & Regulation",
        "prompt": "A counselor recommends a product paying them a 5% commission when an equally suitable, lower-cost no-commission alternative exists. Under a fiduciary standard, this:",
        "options": [
          "Is permissible if disclosed to the client",
          "Violates the duty of loyalty — the recommendation must be in the client's best interest, not the counselor's, regardless of disclosure",
          "Is required by FINRA",
          "Is acceptable if the recommended product performs well"
        ],
        "correct": 1,
        "explanation": "Fiduciary duty is more than disclosure. Loyalty requires the client's best interest to come first. Disclosure cures conflicts in some circumstances but does not cure choosing a worse option for the client because it pays the counselor more."
      },
      {
        "id": "q10",
        "competency": "OJL-1",
        "competency_name": "Client Discovery & Intake",
        "prompt": "In a discovery meeting, a client casually mentions 'I had some health issues last year' and immediately changes the topic. The most appropriate response is to:",
        "options": [
          "Move on — health is outside financial planning scope",
          "Pause and ask one open question to understand whether the health event affects current planning, while leaving the client in control of how much to share",
          "Request medical records to update risk profile",
          "Refer them to a physician"
        ],
        "correct": 1,
        "explanation": "Health events have real planning implications — disability insurance, retirement timing, estate planning, cash flow. But pressing too hard breaks trust. The skill is acknowledging gently and inviting one more sentence without prying."
      },
      {
        "id": "q11",
        "competency": "OJL-2",
        "competency_name": "Goal-Setting & Prioritization",
        "prompt": "A client lists six goals: emergency fund, debt payoff, retirement saving, kids' college, vacation home, kitchen renovation. With limited cash flow, the right next step is to:",
        "options": [
          "Pursue all six simultaneously with equal funding",
          "Tell the client to pick the single most important goal",
          "Help the client sequence and prioritize, distinguishing foundational goals (emergency fund, high-rate debt) from longer-horizon and discretionary goals",
          "Pursue them in the order the client listed"
        ],
        "correct": 2,
        "explanation": "Foundational goals (emergency reserve, high-rate debt) usually need to be at least partially established before longer-horizon goals can be safely funded. Sequencing is a counselor skill — not a personal ranking but a structural one."
      },
      {
        "id": "q12",
        "competency": "OJL-3",
        "competency_name": "Document Collection & Analysis",
        "prompt": "The most efficient and reliable way to manage document collection across a client base is:",
        "options": [
          "Ad hoc emails when something specific is needed",
          "A consistent tracker (CRM or shared list) showing requested, received, and outstanding items per client, reviewed at a regular cadence with clear next actions",
          "Wait for clients to send what they think is relevant",
          "Collect everything at once in a single massive request"
        ],
        "correct": 1,
        "explanation": "Document collection is operational discipline. A tracker prevents drop-through, reduces follow-up friction, and lets the counselor verify status in seconds rather than hunting through email threads."
      },
      {
        "id": "q13",
        "competency": "OJL-4",
        "competency_name": "Building Financial Statements",
        "prompt": "A client's net worth has increased $80,000 year-over-year. Their cash flow statement shows only $15,000 in savings from income during the same period. The most likely explanation is:",
        "options": [
          "The savings figure is understated and must be corrected",
          "Asset appreciation — investments and home equity — accounts for most of the increase, since net worth reflects both cash flow contributions and market value changes",
          "The client is hiding income",
          "The cash flow statement is wrong"
        ],
        "correct": 1,
        "explanation": "Net worth changes from two sources: contributions from cash flow, and appreciation/depreciation of existing assets. A counselor who conflates the two will misread the client's actual savings discipline."
      },
      {
        "id": "q14",
        "competency": "OJL-5",
        "competency_name": "Behavioral Finance & Client Coaching",
        "prompt": "A client emails at 11pm wanting to 'move everything to cash' after an 18% portfolio drop. The strongest next-morning response is to:",
        "options": [
          "Process the trade per the client's written instructions",
          "Reply with a chart of long-term market returns and a recommendation to stay the course",
          "Call the client, acknowledge the fear before any data, and only then walk through what the plan was designed to do in exactly this scenario",
          "Refer them to a mental health professional"
        ],
        "correct": 2,
        "explanation": "Clients in fear cannot hear data until they feel heard. The emotion comes first, the data follows. Charts emailed in response to panic almost always fail. A live conversation that begins with the feeling almost always works."
      },
      {
        "id": "q15",
        "competency": "OJL-6",
        "competency_name": "Risk Profiling & Suitability",
        "prompt": "A 24-year-old client with high stated risk tolerance wants to invest a house down payment they will use in approximately 18 months. The portfolio decision should be driven primarily by:",
        "options": [
          "Their high stated risk tolerance — aggressive equity allocation",
          "Risk capacity — the 18-month horizon for the specific dollar means short-term instruments are appropriate regardless of stated tolerance",
          "A standard 60/40 allocation",
          "Maximizing expected return given their long career horizon"
        ],
        "correct": 1,
        "explanation": "Capacity beats tolerance every time. The dollar's job determines its allocation. An 18-month down payment has zero capacity for equity drawdown no matter how aggressive the client says they are."
      },
      {
        "id": "q16",
        "competency": "OJL-7",
        "competency_name": "Plan Presentation & Communication",
        "prompt": "Presenting a plan with five recommendations, the most effective sequencing is:",
        "options": [
          "Hardest first to get the difficult conversation over with",
          "Random order to keep the client engaged",
          "High-impact, easy wins first to build momentum and agreement before harder asks",
          "Alphabetical for clarity"
        ],
        "correct": 2,
        "explanation": "A client who has agreed to three things in the first ten minutes is far more likely to agree to a harder fourth. Sequencing intentionally — easy wins first, hardest ask last — is communication craft."
      },
      {
        "id": "q17",
        "competency": "OJL-8",
        "competency_name": "Implementation & Coordination",
        "prompt": "A 401(k) rollover check arrives at the client's home made payable to the client (not to the receiving custodian). The right immediate action is to:",
        "options": [
          "Have the client deposit the check and complete the 60-day indirect rollover",
          "Stop the process, document the situation, and call the sending custodian to reissue the check made payable to the receiving custodian for benefit of the client — converting it to a direct rollover",
          "Have the client cash the check and wire the funds",
          "Wait 30 days to see if the situation resolves"
        ],
        "correct": 1,
        "explanation": "A check payable to the client is an indirect rollover — triggers mandatory 20% federal withholding and a 60-day deposit clock. Reissue properly to avoid both. Time matters; the 60-day clock starts when the client receives the check."
      },
      {
        "id": "q18",
        "competency": "OJL-9",
        "competency_name": "Ongoing Reviews & Life Events",
        "prompt": "During an annual review, a client mentions casually that their adult daughter is going through a divorce. The right response is to:",
        "options": [
          "Note it but defer until the next scheduled annual review",
          "Acknowledge it and ask one open question about whether the parents are providing any financial support — adult children's life events can have material planning implications even when indirect",
          "Push to revise the entire estate plan that day",
          "Refer them to a family law attorney"
        ],
        "correct": 1,
        "explanation": "Indirect life events still touch the plan — financial support to adult children, estate plan beneficiary considerations, potential capacity to help. Surface it gently and explore what matters for planning."
      },
      {
        "id": "q19",
        "competency": "OJL-10",
        "competency_name": "Portfolio Construction",
        "prompt": "A 35-year-old client with a 30+ year horizon, stable W-2 income, six months of emergency reserves, and moderate risk tolerance is most appropriately served by a portfolio that is:",
        "options": [
          "100% cash to preserve capital",
          "Diversified with a meaningful equity allocation appropriate to a long horizon, fixed-income exposure for stability and behavioral ballast, and global diversification — without concentration in any single position",
          "100% in employer stock to maximize growth potential",
          "Concentrated in a single high-conviction sector"
        ],
        "correct": 1,
        "explanation": "Portfolio construction follows from goals, horizon, capacity, and tolerance — not from chasing returns or avoiding all risk. Diversification across asset classes and regions, scaled to the client's actual situation, is the foundation."
      },
      {
        "id": "q20",
        "competency": "OJL-11",
        "competency_name": "Investment Research & Due Diligence",
        "prompt": "When evaluating a new fund for inclusion in a client portfolio, the most important factors to assess are:",
        "options": [
          "Trailing 1-year performance and recent star ratings",
          "Investment process, fees and expense ratio, manager tenure, fit with the existing portfolio's role for that allocation slot, risk-adjusted long-term track record, and tax efficiency",
          "Marketing materials and brand recognition",
          "Whatever the sales representative recommends"
        ],
        "correct": 1,
        "explanation": "Recent performance is the weakest predictor of future performance. Fees, process, tenure, fit, and risk-adjusted long-term results are stronger signals. Due diligence is structured, repeatable analysis — not pattern-matching to recent winners."
      },
      {
        "id": "q21",
        "competency": "OJL-12",
        "competency_name": "Asset Allocation & Rebalancing",
        "prompt": "A portfolio designed as 70% equity / 30% fixed income has drifted to 78/22 after a strong equity year. The disciplined response is to:",
        "options": [
          "Let it ride — the equities are working",
          "Rebalance toward target, trimming equities and adding to fixed income — restoring the risk profile the client signed for and locking in some gains",
          "Sell all equities to cash",
          "Buy more equities to extend the trend"
        ],
        "correct": 1,
        "explanation": "Rebalancing enforces the discipline of buying low and selling high — and more importantly, holds the portfolio to the risk profile the client agreed to. Drift is a risk signal, not a feature."
      },
      {
        "id": "q22",
        "competency": "OJL-13",
        "competency_name": "Performance Reporting",
        "prompt": "A client portfolio returned 12% in a year the S&P 500 returned 18%. The right framing for the client is:",
        "options": [
          "Acknowledge underperformance and consider manager changes",
          "Compare the return to the appropriate blended benchmark for the client's actual allocation, not a 100% equity index — a 70/30 benchmark may have returned approximately 12%",
          "Recommend shifting to a 100% S&P 500 portfolio",
          "Avoid the topic"
        ],
        "correct": 1,
        "explanation": "Performance reporting without correct benchmarking misleads. A diversified portfolio should be compared to a diversified benchmark. Comparing a 70/30 portfolio to the S&P 500 invites bad decisions in both directions across cycles."
      },
      {
        "id": "q23",
        "competency": "OJL-14",
        "competency_name": "Trading & Execution",
        "prompt": "For a large equity trade in a thinly-traded stock, best execution practice is to:",
        "options": [
          "Submit as a single market order for immediate fill",
          "Use limit orders and/or work the order over time to manage market impact, prioritizing execution quality (price, total cost) over speed alone",
          "Wait until the closing auction regardless of conditions",
          "Always use stop orders"
        ],
        "correct": 1,
        "explanation": "Best execution considers price, total cost, speed, likelihood of execution, and market impact. For thinly-traded names, market orders can move the price against the client. Limit orders and time-weighted execution protect the client's outcome."
      },
      {
        "id": "q24",
        "competency": "OJL-15",
        "competency_name": "Tax-Loss Harvesting",
        "prompt": "A client harvests a $5,000 loss by selling a fund. To preserve the loss for tax purposes, they must avoid repurchasing 'substantially identical' securities for:",
        "options": [
          "The same trading day",
          "30 calendar days before or after the sale (a 61-day window total) — the wash-sale rule",
          "The remainder of the tax year",
          "Six months from the sale date"
        ],
        "correct": 1,
        "explanation": "The wash-sale rule disallows the loss if substantially identical securities are purchased within 30 days before or after the sale. The window extends across the sale date — both directions matter. Violations defer rather than eliminate the loss but complicate basis tracking."
      },
      {
        "id": "q25",
        "competency": "OJL-16",
        "competency_name": "Account Administration & Custody",
        "prompt": "At a qualified custodian like Schwab or Fidelity serving an RIA, client assets are held:",
        "options": [
          "On the advisor firm's balance sheet, commingled with firm assets",
          "In the client's name at the qualified custodian, segregated from advisor firm assets, with the advisor having limited authority per the advisory agreement",
          "In a single pooled account with other clients",
          "Anywhere the advisor chooses to hold them"
        ],
        "correct": 1,
        "explanation": "Qualified custody is a regulatory protection — client assets stay in the client's name at an independent custodian. The advisor has agreed-upon authority (trade, fee deduction) but does not hold the assets. This is foundational to client protection in the RIA model."
      },
      {
        "id": "q26",
        "competency": "OJL-17",
        "competency_name": "Reconciliation & Operations Controls",
        "prompt": "Daily reconciliation between the firm's internal records and the custodian's records exists primarily to:",
        "options": [
          "Satisfy regulators with paperwork",
          "Catch errors, fraud, and discrepancies early — when they are still small and recoverable — through systematic comparison rather than accidental discovery later",
          "Generate billable activity",
          "Replace external audits"
        ],
        "correct": 1,
        "explanation": "Reconciliation is the operational discipline that catches problems before they become catastrophes. The cost of daily reconciliation is small. The cost of discovering a six-month-old error or a quiet fraud through an unrelated audit is enormous."
      },
      {
        "id": "q27",
        "competency": "OJL-18",
        "competency_name": "Compliance Workflows",
        "prompt": "A compliance review surfaces a recommendation that was substantively suitable for the client but had no documented rationale in the client file. The compliance issue is:",
        "options": [
          "None — the recommendation was suitable",
          "The missing documentation — a suitable recommendation without documented rationale is, for regulatory and audit purposes, indistinguishable from an unsuitable one",
          "The recommendation itself, which should be reversed",
          "Both — and the matter should be escalated to FINRA immediately"
        ],
        "correct": 1,
        "explanation": "Compliance lives in the documentation. A regulator reviewing the file three years later cannot reconstruct your reasoning if it was never written down. 'It was suitable' is not a defensible claim without contemporaneous evidence of why."
      },
      {
        "id": "q28",
        "competency": "OJL-19",
        "competency_name": "Cybersecurity & Data Protection",
        "prompt": "An apprentice receives an urgent wire transfer request via email from a long-standing client on a Friday afternoon. The non-negotiable next action is to:",
        "options": [
          "Process the wire to meet the Friday cutoff",
          "Voice-verify the request by calling the client at the phone number already in the CRM — not at any number provided in the email — before any wire is processed",
          "Reply to the email confirming receipt and process",
          "Have a second team member verify via email and then process"
        ],
        "correct": 1,
        "explanation": "Wire fraud is the highest-loss event most advisor firms face. Voice verification at a known number is the entire defense. Friday-afternoon urgency is itself a signal often engineered by attackers to delay weekend discovery. Verify every time, no exceptions."
      },
      {
        "id": "q29",
        "competency": "OJL-20",
        "competency_name": "Practice Management & Business Development",
        "prompt": "The most important growth lever for most advisory firms is:",
        "options": [
          "Aggressive marketing spend on digital lead generation",
          "Client retention over decades — most firms with a perceived growth problem actually have a quiet retention problem disguised as a marketing problem",
          "Hiring more advisors as quickly as possible",
          "Lowering fees to undercut competitors"
        ],
        "correct": 1,
        "explanation": "A retained client compounds in value over a 20-year relationship. A new client added to replace a lost one resets the clock. Firms that retain well grow almost without trying. Firms that lose quietly cannot out-market the leak."
      },
      {
        "id": "q30",
        "competency": "OJL-21",
        "competency_name": "Capstone — Building a Practice",
        "prompt": "Completing this apprenticeship is most accurately understood as:",
        "options": [
          "A finished credential that completes the counselor's development",
          "The foundation of a craft — the apprenticeship gives the shape of the work; the next decade of repeated practice with real clients gives the substance",
          "Sufficient preparation for partnership-level responsibilities immediately",
          "A regulatory checkbox unrelated to actual practice"
        ],
        "correct": 1,
        "explanation": "An apprenticeship graduate who treats the credential as the destination is not yet what the credential represents. An apprenticeship graduate who treats it as the starting line of a thirty-year practice is. The thirty competencies are foundations — mastery comes through years of repetition with real clients."
      }
    ]
  }
  $jsonb$::jsonb
)
on conflict (exam_code) do update set
  title = excluded.title,
  description = excluded.description,
  passing_score = excluded.passing_score,
  content = excluded.content,
  updated_at = now();

-- ----------------------------------------------------------------------------
-- 4. Verification query (run manually to confirm)
-- ----------------------------------------------------------------------------
-- select exam_code, title, passing_score,
--   jsonb_array_length(content -> 'questions') as question_count
-- from public.final_exams
-- where exam_code = 'FINAL-COMPREHENSIVE';
