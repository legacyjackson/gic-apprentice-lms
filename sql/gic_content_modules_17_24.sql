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
