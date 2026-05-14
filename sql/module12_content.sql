-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 12 CONTENT
-- Document Collection & Analysis
-- ============================================================================
update public.modules set
  title = 'Document Collection & Analysis',
  competency_id = 'OJL-3',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'How to gather, organize, and read the documents that tell the real story of a client''s financial life — tax returns, statements, policies, and the gaps between them.',
  learning_objectives = ARRAY[
    'Gather and organize the standard document set efficiently and securely.',
    'Read a personal tax return (Form 1040 and key schedules) and extract planning-relevant information.',
    'Analyze investment account statements for fees, allocation, and red flags.',
    'Read an insurance policy declarations page and benefit summary.',
    'Identify document gaps and what they typically signal.',
    'Store and protect client documents according to firm and regulatory standards.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Gathering and Organizing the Document Set",
      "summary": "How to ask, how to follow up, and how to keep your sanity through the intake process.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Document collection is the connective tissue between discovery and planning. Without the documents, the advisor is working from client memory — which is unreliable, often optimistic, and full of small errors. With the documents, the advisor can see what's actually happening. Many planning surprises live in pages the client never opens." },

        { "type": "heading", "text": "The standard intake set" },
        { "type": "paragraph", "text": "Building on the categories introduced in Module 10:" },
        { "type": "list", "items": [
          "<strong>Identity and household</strong>: government ID, marriage certificate (if applicable), dependent info.",
          "<strong>Income</strong>: recent pay stubs, two years of W-2s, self-employment financials.",
          "<strong>Tax returns</strong>: two most recent years federal and state, all schedules.",
          "<strong>Bank accounts</strong>: recent statements for all checking, savings, money market.",
          "<strong>Investment accounts</strong>: recent statements for all brokerage, retirement, education, HSA.",
          "<strong>Debts</strong>: mortgage(s), auto loans, student loans, credit cards, any other.",
          "<strong>Insurance</strong>: declarations pages and policy summaries for life, disability, health, P&C, umbrella.",
          "<strong>Employer benefits</strong>: most recent benefits summary, equity comp documents (RSU vesting, options).",
          "<strong>Estate</strong>: will, trust documents, powers of attorney, advance directive, beneficiary designations.",
          "<strong>Real estate</strong>: deeds, recent property tax bills, appraisals if available.",
          "<strong>Business interests</strong>: business returns, operating agreements, partnership/shareholder agreements.",
          "<strong>Other</strong>: anything client flagged as significant — collectibles, crypto wallets, private investments."
        ]},

        { "type": "heading", "text": "How to ask without overwhelming" },
        { "type": "callout", "kind": "do", "title": "The one-page intake checklist", "text": "Reduce the request list to a single, well-organized page. Long lists trigger procrastination. Group items by location: 'Probably in your filing cabinet' / 'Probably in your online accounts' / 'Probably from your employer's HR portal'. Set a target date — typically 2–3 weeks from the first meeting. Follow up at 1, 2, and 3 weeks if items are missing." },

        { "type": "heading", "text": "Secure transmission" },
        { "type": "paragraph", "text": "Client documents contain SSNs, account numbers, addresses, dates of birth, and everything else identity thieves want. Email is not appropriate for this material." },
        { "type": "list", "items": [
          "<strong>Use the firm's secure document portal.</strong> Every modern advisory firm should have one. Train clients to use it before they need to use it.",
          "<strong>Encrypted email with strong password if portal unavailable.</strong> Send the password separately (text, voice, or different email thread).",
          "<strong>Physical drop-off and pickup</strong> remain acceptable, with appropriate chain-of-custody handling at the office.",
          "<strong>Never use unencrypted email for documents containing SSNs, account numbers, or financial details.</strong> Tell clients why."
        ]},

        { "type": "heading", "text": "Organizing what arrives" },
        { "type": "list", "items": [
          "Standard folder structure in the firm's document system — same structure for every client makes audits and handoffs cleaner.",
          "Naming convention: client_name / category / document_type_date (e.g., 'jackson_marcus / tax / 1040_2024.pdf').",
          "Date received and verified noted in client file or CRM.",
          "Acknowledge receipt to client — closes the loop and signals professionalism."
        ]},

        { "type": "callout", "kind": "warn", "title": "What missing documents commonly signal", "text": "Repeat reminders for tax returns: possibly an extension or amendment in progress, possibly an IRS issue. Avoidance of credit card statements: possibly higher debt than disclosed. Missing insurance dec pages: possibly inadequate coverage the client doesn't want to expose. None of these is necessarily nefarious — most are mundane. But notice the pattern and ask gently." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Reading a Tax Return",
      "summary": "What Form 1040 and its schedules tell you about a client — that they didn't.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "The tax return is the single most informative document in financial planning. Almost everything financially material about a client shows up somewhere in it. A counselor who can read a 1040 fluently extracts in 20 minutes what would otherwise take three meetings to uncover." },

        { "type": "heading", "text": "Form 1040 — the cover page" },
        { "type": "paragraph", "text": "The 1040 is short — typically two pages. Each line tells you something about the client." },
        { "type": "subheading", "text": "Filing status (top of return)" },
        { "type": "paragraph", "text": "Married filing jointly, married filing separately, single, head of household, qualifying widow(er). Confirms household structure. MFS is unusual and often signals a specific issue (asset protection, problematic spouse, separating couple)." },
        { "type": "subheading", "text": "Dependents listed" },
        { "type": "paragraph", "text": "Children, qualifying relatives. Cross-check against discovery — if client mentioned 3 kids but only 2 are listed, ask why." },

        { "type": "subheading", "text": "Income lines (Form 1040 lines 1–8)" },
        { "type": "list", "items": [
          "<strong>Wages (line 1)</strong> — should match the W-2s.",
          "<strong>Interest (line 2)</strong> — taxable interest from bank accounts and bonds. Also notice tax-exempt interest on 2a — often municipal bonds.",
          "<strong>Dividends (line 3)</strong> — taxable and qualified (the second is taxed at long-term cap gains rates). Significant qualified dividends suggest substantial taxable equity holdings.",
          "<strong>IRA distributions (line 4)</strong> — relevant for clients in or near retirement; taxable amount may differ from gross.",
          "<strong>Pensions and annuities (line 5)</strong> — taxable retirement income.",
          "<strong>Social Security (line 6)</strong> — taxable portion of SS benefits (up to 85% can be taxable based on income).",
          "<strong>Capital gains/losses (line 7)</strong> — from Schedule D; positive number means realized gains, negative means realized losses (capped at $3,000/year of net loss deductible against ordinary income).",
          "<strong>Other income (line 8)</strong> — from Schedule 1; gig work, unemployment, alimony received, etc."
        ]},

        { "type": "heading", "text": "Schedules that matter most" },
        { "type": "subheading", "text": "Schedule A — Itemized deductions" },
        { "type": "paragraph", "text": "If filed: state and local taxes (capped at $10,000), mortgage interest, charitable giving, medical expenses above 7.5% of AGI. Charitable giving on Schedule A is a window into values; mortgage interest tells you about the mortgage size and rate stage; SALT cap tells you the client is in a high-tax state. If not filed (took the standard deduction): client likely has fewer planning levers via itemized deductions." },

        { "type": "subheading", "text": "Schedule B — Interest and dividends" },
        { "type": "paragraph", "text": "Required when interest or dividends exceed $1,500. Lists payers — gives you the institutions holding the client's accounts. Useful for confirming you have statements from all of them." },

        { "type": "subheading", "text": "Schedule C — Self-employment" },
        { "type": "paragraph", "text": "Sole proprietor or single-member LLC business income. Reveals: gross revenue, major expense categories, net profit. Net profit drives self-employment tax and qualifies the client for solo 401(k) or SEP-IRA contributions. Sustained Schedule C losses raise IRS hobby-loss concerns and planning questions." },

        { "type": "subheading", "text": "Schedule D and Form 8949 — Capital gains and losses" },
        { "type": "paragraph", "text": "Realized investment gains and losses for the year. Short-term and long-term separated. Useful for: identifying tax-loss harvesting history, spotting concentrated positions being unwound, understanding the client's tendency to trade. Large unused capital loss carryovers (from prior years) are valuable assets — they offset future gains tax-free." },

        { "type": "subheading", "text": "Schedule E — Rental income, royalties, K-1s" },
        { "type": "paragraph", "text": "Investment property income (and expense), royalty income, and pass-through income from partnerships and S-corps (via K-1s). Reveals: rental property ownership the client may not have mentioned in passing, business ownership through entities, complexity that requires specialist coordination." },

        { "type": "subheading", "text": "Schedule 1 — Additional income and adjustments" },
        { "type": "paragraph", "text": "Includes: unemployment, gambling winnings, IRA contribution deductions, HSA contribution deductions, student loan interest, self-employed health insurance, half of SE tax. Quick way to see whether the client is using HSA or IRA deductions." },

        { "type": "callout", "kind": "key", "title": "The single most useful number on the return", "text": "<strong>Adjusted Gross Income (AGI)</strong> — line 11 on the 1040. Drives Roth contribution limits, IRA deductibility, Medicare premium tiers (IRMAA), and many credit phaseouts. Compare current AGI to prior year and to projected next year — trend often matters more than absolute level." },

        { "type": "callout", "kind": "do", "title": "The tax return read-through", "text": "First pass: scan the 1040 cover page, look at every line item with a dollar amount. Second pass: open each schedule, read the totals. Third pass: read the explanation lines and any unusual items. Allow 20–30 minutes for a complex return on first read. Make notes: what surprises you? What's missing? What planning opportunities are visible? Keep these in the client file." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Investment Statements",
      "summary": "What an account statement tells you — and what to be suspicious of.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment statements share a common structure across custodians, even if the formatting differs. Knowing what to look for converts a stack of paper into a clear picture of the client's portfolio." },

        { "type": "heading", "text": "What every statement contains" },
        { "type": "list", "items": [
          "<strong>Account holder, account number, account type</strong> (taxable, IRA, Roth, 401(k), etc.). Account type drives tax treatment.",
          "<strong>Period covered</strong> — usually monthly, quarterly, or annual.",
          "<strong>Beginning and ending balance.</strong>",
          "<strong>Positions held</strong> — security name, ticker, share count, current value.",
          "<strong>Cost basis</strong> — for taxable accounts, what the position was purchased for. Critical for tax planning.",
          "<strong>Income received</strong> — dividends and interest paid into the account.",
          "<strong>Activity</strong> — purchases, sales, contributions, distributions, dividends reinvested, fees charged."
        ]},

        { "type": "heading", "text": "What to scan for" },
        { "type": "subheading", "text": "Asset allocation" },
        { "type": "paragraph", "text": "What percentage of the account is in stocks, bonds, cash, alternatives? Does it match the stated risk tolerance? A 65-year-old client who says \"I'm conservative, I can't handle losses\" but holds a 95% equity portfolio has a mismatch that will hurt them in the next downturn." },

        { "type": "subheading", "text": "Concentration risk" },
        { "type": "paragraph", "text": "Any single position over 10% of the portfolio? Common scenarios: legacy employer stock, an inherited concentrated position, a winning bet they haven't trimmed. Concentration may be appropriate in specific circumstances, but it needs to be a deliberate choice — and the client needs to know what risk they're carrying." },

        { "type": "subheading", "text": "Fees" },
        { "type": "paragraph", "text": "Expense ratios on each fund. Account-level fees (custodial, IRA maintenance, etc.). Advisor fees if applicable. The cost of holding an investment over decades compounds — a 1.5% expense ratio costs the client roughly 30% of their potential ending wealth over 30 years versus a 0.1% alternative. Read these line items." },

        { "type": "subheading", "text": "Trading activity" },
        { "type": "paragraph", "text": "How often do trades happen? Is there a pattern? Excessive trading drives tax inefficiency in taxable accounts and may signal a previous advisor who churned. Inactivity in a 25-year-old's 401(k) sitting in a money market fund (something not uncommon) signals neglect, not strategy." },

        { "type": "callout", "kind": "warn", "title": "Red flags in investment statements", "text": "Unfamiliar or illiquid private investments (especially in retirement accounts) — high risk and often high fees. Variable annuities with surrender charges still in effect. Significant cash holdings in long-term accounts that have been there for years. Holdings labeled 'proprietary' with names matching a prior advisor's firm. Highly concentrated single-stock positions without a documented reason. Excessive number of overlapping mutual funds (e.g., 8 different large-cap funds doing the same thing)." },

        { "type": "heading", "text": "Cost basis lots — why they matter" },
        { "type": "paragraph", "text": "When the client bought 1,000 shares of a stock over 10 years in 50 separate purchases, each \"lot\" has its own basis. When selling some shares, the choice of which lots to sell affects the tax outcome:" },
        { "type": "list", "items": [
          "<strong>First-in, first-out (FIFO)</strong> — sells oldest shares first. Usually the highest gain (oldest shares appreciated most).",
          "<strong>Specific identification</strong> — pick the exact lots to sell. Used for tax optimization (sell highest-basis lots to minimize realized gain, or sell loss lots for tax-loss harvesting).",
          "<strong>Average cost</strong> — only for mutual funds; uses average basis across all shares. Once chosen, generally stuck with for that fund."
        ]},
        { "type": "callout", "kind": "do", "title": "Default rule for taxable accounts", "text": "Set cost basis tracking to <strong>specific identification</strong> on all taxable accounts unless there's a reason not to. This preserves the flexibility to optimize tax outcomes at sale time. FIFO is fine for mutual funds where averaging happens anyway. Get this set early in the relationship." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Insurance Policies and Benefit Summaries",
      "summary": "Reading what's covered, what's excluded, and what the costs really are.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Insurance documents are intimidating because they're written by lawyers, for lawyers. The advisor's job is not to read the entire 80-page policy — it's to read the parts that matter and know when to ask for help with the rest." },

        { "type": "heading", "text": "The declarations page" },
        { "type": "paragraph", "text": "Every P&C and most life and disability policies have a declarations page — usually the first one or two pages. Summarizes the contract. As covered in Module 4, this is the page to read first." },

        { "type": "subheading", "text": "Key items across all types" },
        { "type": "list", "items": [
          "Named insured(s).",
          "Coverage period (effective date, renewal date).",
          "Coverage limits (by type and total).",
          "Deductibles or elimination periods.",
          "Premium and frequency.",
          "Riders or endorsements added."
        ]},

        { "type": "heading", "text": "Type-specific items to verify" },
        { "type": "subheading", "text": "Life insurance" },
        { "type": "list", "items": [
          "Type: term, whole, universal, variable. Each has different planning implications.",
          "Death benefit amount and whether level or increasing.",
          "Term length (if term policy) and date of expiration.",
          "Cash value (if permanent) — recent statement, surrender charges still in effect, loan balances against the policy.",
          "Beneficiaries — primary and contingent."
        ]},

        { "type": "subheading", "text": "Disability insurance" },
        { "type": "list", "items": [
          "Own-occupation or any-occupation definition.",
          "Benefit amount as percentage of pre-disability income.",
          "Elimination period (90 days standard).",
          "Benefit period (to age 65, or shorter).",
          "Inflation rider, residual disability rider, future increase option."
        ]},

        { "type": "subheading", "text": "Homeowners and renters" },
        { "type": "list", "items": [
          "Dwelling coverage (Coverage A) — should approximate replacement cost, not market value.",
          "Personal property (Coverage C) — sub-limits on jewelry, art, electronics.",
          "Liability (Coverage E) — typically inadequate at $100,000–$300,000 default; should match assets.",
          "Endorsements: water backup, scheduled property, identity theft, etc."
        ]},

        { "type": "subheading", "text": "Auto" },
        { "type": "list", "items": [
          "Bodily injury liability limits.",
          "Property damage liability.",
          "UM/UIM (uninsured/underinsured motorist).",
          "Collision and comprehensive — necessary on financed/newer cars; consider dropping on older cars.",
          "Medical payments / PIP."
        ]},

        { "type": "heading", "text": "Employer benefit summaries" },
        { "type": "paragraph", "text": "An often-overlooked source of planning information. The annual benefits summary typically includes:" },
        { "type": "list", "items": [
          "Employer-provided life insurance (often 1–2× salary, sometimes more — useful but not portable).",
          "Short-term and long-term disability — what percentage of salary, taxable or not, owned by employee or employer.",
          "401(k) match formula — what's the trigger and the cap?",
          "Stock plan participation — ESPP discount, RSU vesting schedule, options.",
          "Health, vision, dental coverage details.",
          "Other perks: legal services, identity theft, commuter benefits, dependent care FSA."
        ]},

        { "type": "callout", "kind": "do", "title": "The benefits enrollment season opportunity", "text": "Fall benefits enrollment is one of the best moments to add value to a client. Most employees autofill the same elections every year without optimization. The counselor who reviews the upcoming year's elections — HSA vs. FSA, life insurance buy-up, disability buy-up, dependent care decisions — can produce hundreds to thousands of dollars of value in a 30-minute review. Schedule these conversations proactively." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Document Storage and Security",
      "summary": "Where files live, who can access them, and what to do when something goes wrong.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client documents are sensitive — financial details, SSNs, account numbers, family information. The firm has both regulatory and ethical obligations to protect them. The counselor is a daily participant in that protection." },

        { "type": "heading", "text": "The standard practices" },
        { "type": "list", "items": [
          "<strong>Documents stored in the firm's secure system</strong> — encrypted at rest, access-controlled, audit-logged. Not on personal devices, personal cloud storage, or unencrypted laptop drives.",
          "<strong>Access limited to staff with legitimate need</strong> to know.",
          "<strong>Retention policy followed</strong> — SEC requirements typically mandate 5-year retention for many advisory documents (longer for some); firm policy specifies how long each category of document is kept.",
          "<strong>Disposal handled securely</strong> — paper shredded, digital files deleted from active and backup systems per policy.",
          "<strong>Annual training</strong> on data security, phishing recognition, and incident response."
        ]},

        { "type": "callout", "kind": "warn", "title": "The phishing exposure", "text": "Financial advisors are targeted by phishing because the rewards are large. Common attacks: emails impersonating clients requesting wire transfers, emails impersonating the firm asking for credentials, emails impersonating custodians with urgent requests. Verbal verification on a phone number you have (not the number in the email) before any irregular financial action. Always. Even if the email looks legitimate. Especially if the email looks urgent." },

        { "type": "heading", "text": "What to do if something goes wrong" },
        { "type": "list", "items": [
          "<strong>Lost laptop or device:</strong> Report immediately to firm IT and compliance. Devices should have remote-wipe capability.",
          "<strong>Suspected phishing email opened or clicked:</strong> Report immediately to firm IT. Change passwords. Watch for further attempts.",
          "<strong>Confirmed unauthorized access:</strong> Firm has a defined incident response process. Notification of affected clients is required by state and federal law in most cases. Follow the process; don't try to handle it informally.",
          "<strong>Client reports identity theft:</strong> Help the client through the recovery process (freeze credit, file police report, FTC IdentityTheft.gov, monitor accounts). Document the support provided."
        ]},

        { "type": "callout", "kind": "key", "title": "The professional posture on security", "text": "Treat every client document, login credential, and identity element as if a data breach were costly enough to destroy the firm — because in many cases it would be. The discipline of locking down documents, verifying transactions out-of-band, and reporting anomalies fast isn't optional. It's the work." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Why is the tax return often called the most informative document in financial planning?",
        "options": [
          "It is required by the IRS.",
          "Almost everything financially material about a client appears somewhere in it — income, deductions, investment activity, business interests, real estate, dependents — making it the highest-density source of planning information.",
          "It is the longest document a client provides.",
          "It contains the client's address."
        ],
        "correct": 1,
        "explanation": "A fluent reading of a 1040 plus schedules surfaces in 20 minutes what would take multiple discovery meetings otherwise. Income types, deductions, investment trades, rental property, business activity, retirement contributions — all in one document."
      },
      {
        "id": "q2",
        "prompt": "Which line on Form 1040 is the most useful single number for planning?",
        "options": [
          "Total wages",
          "Adjusted Gross Income (AGI)",
          "Refund amount",
          "Total tax paid"
        ],
        "correct": 1,
        "explanation": "AGI drives Roth contribution limits, IRA deductibility, Medicare premium tiers (IRMAA), credit phaseouts, and many other planning thresholds. Trend year-over-year often matters more than absolute level."
      },
      {
        "id": "q3",
        "prompt": "Why is sending client documents by unencrypted email a problem?",
        "options": [
          "It's slow.",
          "Documents contain SSNs, account numbers, and identity-theft-grade information; email is not secure transmission. Use the firm's portal or encrypted email with separately-transmitted password.",
          "It clutters the client's inbox.",
          "Email attachments are too large."
        ],
        "correct": 1,
        "explanation": "Email is not a secure channel for sensitive financial information. Use the firm's secure document portal, encrypted email with separately-shared password, or physical handoff with proper chain of custody."
      },
      {
        "id": "q4",
        "prompt": "Schedule D on a tax return shows:",
        "options": [
          "Dividends received.",
          "Realized capital gains and losses for the year.",
          "Rental income.",
          "Itemized deductions."
        ],
        "correct": 1,
        "explanation": "Schedule D (with detailed transactions on Form 8949) shows the year's realized investment gains and losses, separated into short-term and long-term. Useful for spotting tax-loss harvesting history and concentrated-position unwinds."
      },
      {
        "id": "q5",
        "prompt": "Schedule E on a tax return reveals:",
        "options": [
          "Self-employment business income.",
          "Rental property income, royalties, and pass-through income from partnerships and S-corps (via K-1s).",
          "Itemized deductions.",
          "Capital gains and losses."
        ],
        "correct": 1,
        "explanation": "Schedule E surfaces rental property ownership the client may not have mentioned, business ownership through entities, and other complexity that requires specialist coordination."
      },
      {
        "id": "q6",
        "prompt": "On a brokerage account statement, what does 'cost basis' mean?",
        "options": [
          "The current value of the position.",
          "What the position was originally purchased for, used to calculate capital gain/loss at sale for tax purposes.",
          "The advisor's fee for managing the position.",
          "The brokerage account's monthly fee."
        ],
        "correct": 1,
        "explanation": "Cost basis is the original purchase price (with adjustments for splits, dividends reinvested, return of capital, etc.). At sale, gain = sale price - cost basis. Lot-level basis tracking is critical for tax optimization."
      },
      {
        "id": "q7",
        "prompt": "What is the default cost-basis method recommendation for taxable brokerage accounts?",
        "options": [
          "First-in, first-out (FIFO).",
          "Specific identification — allows the client to choose which lots to sell at any time, preserving flexibility for tax-loss harvesting and gain optimization.",
          "Last-in, first-out (LIFO).",
          "Average cost."
        ],
        "correct": 1,
        "explanation": "Specific identification preserves the flexibility to optimize tax outcomes. FIFO is the default at most custodians and usually produces the highest gain (oldest, lowest-basis shares sell first). Set to specific identification early."
      },
      {
        "id": "q8",
        "prompt": "Which is a red flag when reviewing an investment statement?",
        "options": [
          "Holdings in low-cost index funds.",
          "Single-stock concentration above 10% with no documented strategic reason; significant cash holdings sitting for years in long-term accounts; or proprietary funds matching a prior advisor's firm.",
          "Cost basis information being tracked.",
          "Dividends being reinvested."
        ],
        "correct": 1,
        "explanation": "These are common findings in transferred accounts that signal prior advisor decisions worth revisiting. Each warrants discussion: the concentration may be intentional or inherited; the cash may be neglect; the proprietary funds were often sold for advisor compensation."
      },
      {
        "id": "q9",
        "prompt": "On an insurance declarations page, which item is most often the source of structural under-insurance?",
        "options": [
          "Coverage period.",
          "Liability limits — auto and homeowners liability often sit at policy defaults ($100K-$300K) while clients have $1M+ in assets to protect.",
          "Premium amount.",
          "Insurance company name."
        ],
        "correct": 1,
        "explanation": "Liability limits are routinely set at low defaults and never updated. A client with $1M net worth and $300K auto liability has a structural mismatch. Annual review should check this and add umbrella where appropriate (covered in Module 4)."
      },
      {
        "id": "q10",
        "prompt": "When in the year is the best time to review a client's employer benefits elections?",
        "options": [
          "January (start of new year).",
          "Fall, before open enrollment for the next plan year — when changes can be made.",
          "Tax season.",
          "Anytime."
        ],
        "correct": 1,
        "explanation": "Most employees autofill elections every fall without optimization. A 30-minute review then — covering HSA vs. FSA, life insurance buy-up, disability buy-up, dependent care — produces real value because changes can be made for the upcoming plan year."
      },
      {
        "id": "q11",
        "prompt": "An email from a client requests an urgent wire transfer of $50,000 to an unfamiliar account. The right response is:",
        "options": [
          "Send the wire immediately to be responsive.",
          "Reply to the email asking for confirmation.",
          "Call the client on a phone number you already have on file (not from the email) to verbally verify before initiating any wire — always, regardless of how legitimate the email looks.",
          "Forward the request to the trading desk."
        ],
        "correct": 2,
        "explanation": "Wire fraud via spoofed emails impersonating clients is one of the most common attacks on advisory firms. Verbal verification on a known phone number — not the number or contact info in the email — is non-negotiable before any irregular financial action. Even if the email looks legitimate. Especially if it's urgent."
      },
      {
        "id": "q12",
        "prompt": "If a counselor suspects a data security incident has occurred, the right action is:",
        "options": [
          "Try to handle it discreetly to avoid alarming anyone.",
          "Wait and see if anything further happens.",
          "Report immediately to firm IT and compliance and follow the defined incident response process — including required client notifications under state/federal law.",
          "Tell the affected client first, then the firm."
        ],
        "correct": 2,
        "explanation": "Incident response has defined steps for legal and operational reasons. Most states and federal law require specific notifications to affected clients on confirmed unauthorized access. Reporting fast is what allows the firm to contain damage and meet obligations. Don't handle informally."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 12;
