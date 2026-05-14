-- ================================================================
-- GIC LMS — MASTER SETUP PART 3
-- Run parts in order: 1 → 2 → 3 → 4 → 5
-- ================================================================


-- ── module13_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 13 CONTENT
-- Building Financial Statements
-- ============================================================================
update public.modules set
  title = 'Building Financial Statements',
  competency_id = 'OJL-4',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'Net worth and cash flow statements that actually reflect a household. How to build them, what assumptions matter, and how to present them so clients can use them.',
  learning_objectives = ARRAY[
    'Build a net worth statement that accurately represents a household''s position at a point in time.',
    'Build a cash flow statement that surfaces real spending patterns, not aspirational ones.',
    'Categorize assets and choose appropriate valuation methods for each.',
    'Identify common errors and quality issues in personal financial statements.',
    'Present financial statements to a client in a way that produces insight, not overwhelm.',
    'Use financial statements as the foundation for the rest of the planning process.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building the Net Worth Statement",
      "summary": "A snapshot of where the household stands today.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The net worth statement is the foundation document of financial planning. It says: at a specific date, here is what this household owns, here is what it owes, here is the difference. Built well, it grounds every other piece of the plan. Built carelessly, it produces a number that's right by accident — and breaks when anything depends on it." },

        { "type": "callout", "kind": "key", "title": "Net Worth = Assets − Liabilities", "text": "Conceptually simple. The complexity is in the details: what counts as an asset, how to value each item, what counts as a liability, and what date the snapshot represents." },

        { "type": "heading", "text": "Standard asset categories" },
        { "type": "subheading", "text": "Liquid assets (cash and near-cash)" },
        { "type": "list", "items": [
          "Checking accounts",
          "Savings accounts",
          "Money market accounts and funds",
          "CDs maturing within 12 months",
          "Treasury bills"
        ]},

        { "type": "subheading", "text": "Investment assets — taxable" },
        { "type": "list", "items": [
          "Brokerage accounts (joint, individual, joint with rights of survivorship)",
          "Mutual funds held outside retirement",
          "Stocks and bonds held individually",
          "Crypto held in personal wallets or exchanges (with appropriate volatility considerations in valuation)"
        ]},

        { "type": "subheading", "text": "Investment assets — retirement" },
        { "type": "list", "items": [
          "401(k), 403(b), 457 employer plans",
          "Traditional and Roth IRAs",
          "SEP, SIMPLE, solo 401(k) for self-employed",
          "Pensions — valued at present value of expected stream, when applicable"
        ]},

        { "type": "subheading", "text": "Other investment assets" },
        { "type": "list", "items": [
          "529 plans and other education savings",
          "HSAs (with note that they're triple-tax-advantaged)",
          "Annuities (cash surrender value, not face value)",
          "Cash value of permanent life insurance"
        ]},

        { "type": "subheading", "text": "Real estate" },
        { "type": "list", "items": [
          "Primary residence (market value)",
          "Rental properties (market value)",
          "Vacation or second homes",
          "Undeveloped land",
          "REITs held as investments belong in investment assets, not real estate"
        ]},

        { "type": "subheading", "text": "Business interests" },
        { "type": "list", "items": [
          "Closely held business interests (valued at best estimate or recent valuation)",
          "Partnership interests",
          "LLC ownership stakes"
        ]},

        { "type": "subheading", "text": "Personal property" },
        { "type": "list", "items": [
          "Vehicles (Kelley Blue Book or similar)",
          "Collectibles, art, jewelry of meaningful value",
          "Household goods — typically excluded or summarized at modest value unless significant"
        ]},

        { "type": "heading", "text": "Standard liability categories" },
        { "type": "subheading", "text": "Short-term liabilities (due within 12 months)" },
        { "type": "list", "items": [
          "Credit card balances",
          "Personal loans",
          "Tax debt due currently",
          "Medical bills outstanding"
        ]},

        { "type": "subheading", "text": "Long-term liabilities" },
        { "type": "list", "items": [
          "Mortgages on primary and other properties",
          "Auto loans",
          "Student loans",
          "Home equity loans and lines of credit",
          "Margin loans against investment accounts"
        ]},

        { "type": "callout", "kind": "do", "title": "The 'as of' date matters", "text": "A net worth statement always represents a specific point in time. Mark it clearly at the top: 'As of [Date]'. Year-end is conventional. Quarter-end works for active accumulation. Compare year-over-year to track progress. Don't mix asset values from different dates — Q1 brokerage with Q3 mortgage produces a number that doesn't mean anything." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Building the Cash Flow Statement",
      "summary": "What comes in, what goes out — and why most clients have no idea what they actually spend.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Cash flow is harder than net worth, because it covers a period rather than a point and because most households genuinely don't know what they spend. The cash flow statement either reflects reality or it doesn't — and an aspirational one is worse than none at all." },

        { "type": "heading", "text": "Cash flow categories" },
        { "type": "subheading", "text": "Income (inflows)" },
        { "type": "list", "items": [
          "Wages and salary (gross and net both useful)",
          "Self-employment net income",
          "Investment income (dividends, interest)",
          "Rental income (gross less expenses, or net)",
          "Retirement distributions",
          "Social Security benefits",
          "Other (alimony, child support, business distributions, gifts received)"
        ]},

        { "type": "subheading", "text": "Fixed expenses (predictable, repeating)" },
        { "type": "list", "items": [
          "Housing: mortgage/rent, property tax, insurance, HOA, utilities (recurring portion)",
          "Transportation: car payments, insurance, registration",
          "Loan payments: student, auto, personal, credit cards (minimums)",
          "Insurance premiums: health, life, disability, umbrella",
          "Subscriptions: phone, internet, streaming, software, gym",
          "Childcare and tuition (when applicable)"
        ]},

        { "type": "subheading", "text": "Variable expenses (discretionary or semi-fixed)" },
        { "type": "list", "items": [
          "Groceries",
          "Dining out",
          "Personal care, household supplies",
          "Clothing",
          "Entertainment, hobbies",
          "Travel",
          "Gifts and charitable giving (when not committed)"
        ]},

        { "type": "subheading", "text": "Periodic expenses (not monthly, but real)" },
        { "type": "list", "items": [
          "Annual taxes (property, income true-ups)",
          "Annual insurance premiums paid annually rather than monthly",
          "Vehicle maintenance (oil changes, tires, repairs)",
          "Home maintenance (HVAC service, paint, plumbing repairs)",
          "Holidays and gift-giving seasons",
          "Vacations",
          "Annual subscriptions or memberships"
        ]},

        { "type": "subheading", "text": "Savings and contributions (the 'pay yourself' lines)" },
        { "type": "list", "items": [
          "401(k) and other retirement contributions",
          "HSA contributions",
          "529 contributions",
          "Brokerage contributions",
          "Emergency fund building",
          "Debt paydown beyond minimums"
        ]},

        { "type": "callout", "kind": "key", "title": "The cash flow identity", "text": "Income − Expenses − Savings = $0 (or near zero). Every dollar must be accounted for. When the equation doesn't balance, the unaccounted amount is the 'leak' — money disappearing into untracked spending. The size of the leak is one of the most useful planning numbers." },

        { "type": "heading", "text": "Sources for the numbers" },
        { "type": "subheading", "text": "Easiest to verify" },
        { "type": "list", "items": [
          "Income: pay stubs and tax returns.",
          "Fixed expenses paid by recurring auto-payment: bank and credit card statements show them precisely.",
          "Loan payments and tax payments: contract terms and payment confirmations."
        ]},

        { "type": "subheading", "text": "Harder to capture accurately" },
        { "type": "list", "items": [
          "Variable expenses paid by debit card or cash: requires categorizing several months of statements.",
          "Periodic expenses: often missed because they don't appear monthly. Look at 12 months of statements to catch them.",
          "Cash spending: the hardest. If significant, ask the client to estimate weekly cash withdrawals × 52."
        ]},

        { "type": "callout", "kind": "do", "title": "The 90-day reconstruction technique", "text": "Have the client export 90 days of transactions from their primary checking account and primary credit card. Sort by merchant. Categorize. Multiply by 4 for annual estimate. Add known periodic expenses. This produces a defensible cash flow statement in 1–2 hours of analyst work — and surfaces the gap between what the client thinks they spend and what they actually spend. The gap is almost always meaningful." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Valuation and Asset Categorization",
      "summary": "How to value what's not obvious — and what counts as a 'real' asset.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "For most assets, valuation is straightforward — the statement says what it's worth. For others, judgment is required. The principles below produce defensible numbers." },

        { "type": "heading", "text": "Liquid and investment assets — market value at statement date" },
        { "type": "paragraph", "text": "Straightforward: the brokerage statement or bank balance on the relevant date is the value. For end-of-year net worth statements, use 12/31 balances." },

        { "type": "heading", "text": "Real estate — three approaches" },
        { "type": "list", "items": [
          "<strong>Recent appraisal</strong> — most defensible if available within the last 12 months. Cost: $400–$800 for a residential appraisal.",
          "<strong>Comparative market analysis (CMA)</strong> from a real estate agent — free, useful, generally reasonable.",
          "<strong>Online estimate</strong> (Zillow, Redfin) — quick and free, but margins of error are real. Adjust if the home has unusual features (great kitchen renovation, deferred maintenance) that algorithms miss.",
          "<strong>Recent purchase price</strong> — useful only if recent (within last year or two)."
        ]},
        { "type": "callout", "kind": "note", "title": "Conservative vs. aggressive estimates", "text": "Lean modestly conservative on real estate valuation. Aspirational numbers produce net worth that the client can't actually access at the stated level. Build the plan on values the asset would realize in a normal sale within 90 days." },

        { "type": "heading", "text": "Closely held business interests" },
        { "type": "paragraph", "text": "The most challenging asset to value. Options range in formality:" },
        { "type": "list", "items": [
          "<strong>Formal business valuation</strong> — required for serious purposes (gift tax filings, divorce, succession planning). Cost: $5,000–$25,000+ for a small business.",
          "<strong>Industry rules of thumb</strong> — for many small businesses, multiples of revenue or EBITDA used as rough estimates (e.g., service businesses often value at 0.5–2× annual revenue, depending on profitability and recurring nature).",
          "<strong>Recent transactions</strong> — buy-sell agreement values, recent offers received, prior sales of similar businesses.",
          "<strong>Owner's estimate</strong> — least defensible but often the only practical option for routine planning."
        ]},
        { "type": "paragraph", "text": "Always note the valuation method in the financial statement. \"$2M business interest (owner estimate)\" tells a planner — and the next planner who reads the file — what kind of number they're working with." },

        { "type": "heading", "text": "Pensions — when to include and how" },
        { "type": "paragraph", "text": "Defined-benefit pensions are valuable assets, but they typically don't appear on standard statements. Two approaches:" },
        { "type": "list", "items": [
          "<strong>Include as an asset at present value</strong> of the expected income stream. Requires actuarial assumptions about discount rate, mortality, COLA. More technically correct but harder to estimate.",
          "<strong>Exclude from balance sheet, include in retirement income projections.</strong> Simpler, often clearer for clients. Treat the pension as guaranteed monthly income reducing the amount needed from other assets."
        ]},
        { "type": "paragraph", "text": "Either approach is acceptable as long as it's consistent and disclosed. Don't double-count the pension as both an asset and projected income — that's the error to avoid." },

        { "type": "heading", "text": "What to exclude from net worth" },
        { "type": "list", "items": [
          "Expected inheritance — not yet received, no contractual right.",
          "Future earnings — important to planning, but not an asset.",
          "Insurance death benefits — those go to beneficiaries when the insured dies, not assets of the current household.",
          "Social Security future benefits — usually treated as future income, not balance sheet asset.",
          "Personal property of modest value — household goods, clothing, ordinary items. Some statements include 'household contents' at a modest line — fine, but don't inflate."
        ]},

        { "type": "callout", "kind": "warn", "title": "The valuation trap that breaks plans", "text": "Inflating real estate, closely held business, or personal property values to produce a higher net worth number that feels good. The plan built on those values won't survive contact with reality — when the business sells for half what the owner estimated, or the house sits unsold at the aspirational price, the household discovers their plan was built on numbers that weren't there. Honest valuation isn't pessimism. It's the foundation of plans that actually work." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Statement Quality and Auditability",
      "summary": "How to know your numbers will hold up — to a colleague, to a client, to a future advisor.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "A financial statement is auditable when someone else can trace each number back to its source. This is the standard a counselor's work should aim for, every time." },

        { "type": "heading", "text": "What an auditable statement includes" },
        { "type": "list", "items": [
          "<strong>Source notation</strong> for every meaningful asset and liability — \"Schwab statement 12/31/2024\" or \"Realtor CMA 11/15/2024\" or \"Owner estimate, business valuation pending\".",
          "<strong>Valuation date</strong> consistent across the statement.",
          "<strong>Categorization that's consistent</strong> with firm conventions and prior years' statements for the same client.",
          "<strong>Method disclosure</strong> where judgment is required (especially real estate and business interests).",
          "<strong>Excluded items noted explicitly</strong> if the client might expect them included (e.g., expected inheritance — note 'expected inheritance not included').",
          "<strong>Sign-off and review</strong> per firm process."
        ]},

        { "type": "heading", "text": "Common quality issues" },
        { "type": "list", "items": [
          "Mixed-date asset values (assets from different statement dates).",
          "Liabilities included that have been paid off.",
          "Joint accounts double-counted or missed depending on context.",
          "Beneficiary-designated accounts shown as separate from the client's net worth (they are part of net worth during the client's life; they pass via designation at death).",
          "Cash value of life insurance reported as face value (the death benefit, not the current accessible cash value).",
          "Restricted stock valued without considering vesting and tax — net-after-tax for unvested RSUs is more useful for planning than gross unvested value.",
          "Foreign accounts or assets missed entirely."
        ]},

        { "type": "callout", "kind": "do", "title": "The two-pass review", "text": "Build the statement. Then walk through it line by line a second time, asking: 'Can I point to the source for this number?' 'Is the valuation method documented?' 'Is this number current?' 'Is anything obviously missing?' The two-pass review catches almost all of the common errors. Skip it and the errors stay." },

        { "type": "callout", "kind": "key", "title": "Why this matters", "text": "Financial statements get used. They appear in every plan, in every review, in every conversation about progress. They are read by colleagues during coverage, by compliance during audits, by the client when they're trying to understand their own situation, and sometimes by the courts in divorce or estate proceedings. The discipline of building them carefully isn't optional decorative work — it's the spine of the practice." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Presenting Financial Statements to a Client",
      "summary": "How to share what you've built so the client actually understands it.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "A beautifully constructed financial statement that confuses or overwhelms a client has failed at its purpose. The presentation matters as much as the underlying work. The goal is insight, not impression." },

        { "type": "heading", "text": "Principles of good presentation" },
        { "type": "list", "items": [
          "<strong>Show the totals first.</strong> Lead with net worth and key cash flow numbers. Details follow if asked.",
          "<strong>Use simple categories.</strong> Five to seven groupings on each statement is plenty. Twenty line items overwhelm.",
          "<strong>Round appropriately.</strong> Net worth of '$1,237,492.18' is precise but not useful in a conversation. '$1.24M' communicates better.",
          "<strong>Compare to last year.</strong> Year-over-year change matters more than absolute level for ongoing clients.",
          "<strong>Visualize the breakdown.</strong> A simple pie chart of asset categories often communicates more than the table.",
          "<strong>Highlight the planning implication, not just the number.</strong> 'Your liquid assets cover 8 months of expenses — you're in good shape on emergency reserves.'"
        ]},

        { "type": "heading", "text": "Questions to anticipate" },
        { "type": "list", "items": [
          "'Why is my house worth less than I thought?' — explain valuation methodology, willingness to adjust if a recent appraisal exists.",
          "'Where does my expected inheritance fit?' — explain why future expectations aren't assets, but they ARE part of the planning conversation.",
          "'Why isn't my company stock worth more?' — for restricted stock, explain vesting and tax considerations.",
          "'Is my net worth good for my age?' — provide context honestly without making clients feel bad. National percentile data exists; use carefully.",
          "'My friend has [X], should I have [Y]?' — pivot to their own goals."
        ]},

        { "type": "callout", "kind": "key", "title": "The line that often lands", "text": "<em>'This is what you've built. It's where we're starting from, and it's the foundation for everything we're going to plan.'</em> Frames the number as a starting point, not a verdict. Especially helpful with clients who have negative net worth, lower-than-expected numbers, or strong feelings about their financial position." },

        { "type": "case_study",
          "title": "Marcus and Tasha's first financial statement",
          "scenario": "After the discovery phase, you build their first net worth statement (as of 12/31/2024): Assets $665,000 (home equity $190K, his 401(k) $145K, her 403(b) $95K, brokerage $35K, kids' 529s $40K, cash $25K, vehicles $35K, business interest $100K). Liabilities $345,000 (mortgage $280K, student loans $35K, credit cards $30K). Net worth $320,000. Cash flow shows ~$5,800/month after fixed expenses but only ~$1,500/month actually saved — the rest is the 'leak' through variable spending and small periodic expenses.",
          "discussion": "<p>Present in this order:</p><p><strong>1. The headline numbers.</strong> 'Your net worth is approximately $320,000, your annual savings is approximately $18,000, and your monthly take-home minus fixed expenses is about $5,800.'</p><p><strong>2. The structure.</strong> 'Your assets are well-distributed across retirement, home equity, and college savings. You don't have a meaningful concentration in any single area, which is good.'</p><p><strong>3. The opportunity.</strong> 'Of the $5,800 you have left each month after fixed expenses, about $1,500 is going to savings. The other $4,300 is going somewhere — that's the area we want to understand and shape. If we can move even half of that toward savings, your retirement and college numbers improve significantly.'</p><p><strong>4. The trade-off invitation.</strong> 'There's nothing wrong with the spending — that's your life. The question is whether the current pattern is the one you'd choose if you saw it all on one page. That's what we're going to look at together in the next meeting.'</p><p>This framing turns the financial statement from a verdict into a conversation. <strong>That's what the deliverable looks like when it's done well.</strong></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the basic identity for net worth?",
        "options": [
          "Income minus Expenses",
          "Assets minus Liabilities",
          "Cash minus Debt",
          "Salary minus Taxes"
        ],
        "correct": 1,
        "explanation": "Net Worth = Assets − Liabilities, at a specific point in time. Conceptually simple; the complexity is in what counts and how to value each item."
      },
      {
        "id": "q2",
        "prompt": "Why must a net worth statement carry an 'as of' date?",
        "options": [
          "Required by the IRS.",
          "Asset and liability values change daily; a statement is meaningful only as a point-in-time snapshot, and mixing values from different dates produces a meaningless total.",
          "Clients are confused without it.",
          "It satisfies SEC requirements."
        ],
        "correct": 1,
        "explanation": "Net worth is a balance sheet snapshot. Brokerage values from March combined with mortgage balance from October produce a number that doesn't represent any actual moment. Mark the date clearly."
      },
      {
        "id": "q3",
        "prompt": "Which of the following should NOT typically be included as an asset on a net worth statement?",
        "options": [
          "401(k) balance",
          "Home equity",
          "Expected inheritance",
          "Cash value of permanent life insurance"
        ],
        "correct": 2,
        "explanation": "Expected inheritance is not yet received and not contractually owed — it's not an asset. It's relevant to planning conversations but doesn't belong on the balance sheet. Future Social Security is similarly excluded as an asset (typically modeled as future income instead)."
      },
      {
        "id": "q4",
        "prompt": "When valuing closely held business interests, the most defensible source for a major planning purpose is:",
        "options": [
          "The owner's estimate.",
          "An online business valuation calculator.",
          "A formal business valuation by a qualified valuation professional.",
          "Last year's revenue × 2."
        ],
        "correct": 2,
        "explanation": "Formal valuations are necessary for major purposes (gift tax filings, divorce, succession planning, etc.). Owner estimates and rules of thumb are acceptable for routine planning but should be labeled as such on the financial statement. Always note the valuation method."
      },
      {
        "id": "q5",
        "prompt": "What is the 'cash flow identity' an advisor uses to find spending leaks?",
        "options": [
          "Income should equal Expenses.",
          "Income − Expenses − Savings should approximately equal $0; the unaccounted-for amount is the 'leak' of untracked spending.",
          "Assets minus Liabilities equals Cash Flow.",
          "Net Worth must equal Cash Flow × 12."
        ],
        "correct": 1,
        "explanation": "Every dollar should be accounted for. When income minus expenses minus savings produces a meaningful unexplained amount, that's the leak — untracked spending. The size of the leak is one of the most useful planning numbers."
      },
      {
        "id": "q6",
        "prompt": "Which expense category is most commonly missed when clients estimate their own spending?",
        "options": [
          "Mortgage payment.",
          "Periodic expenses — annual insurance premiums, vehicle maintenance, home repairs, holiday gifting — that don't appear monthly but add up.",
          "Groceries.",
          "Utilities."
        ],
        "correct": 1,
        "explanation": "Periodic expenses are real but don't show up in any given month, so they're missed in monthly mental accounting. Looking at 12 months of statements catches them. Once captured, they often surprise clients by their total."
      },
      {
        "id": "q7",
        "prompt": "What is the '90-day reconstruction' technique for building cash flow?",
        "options": [
          "Forecasting the next 90 days of spending.",
          "Exporting 90 days of transactions from primary accounts, categorizing them, multiplying by 4 for annual estimate, then adding known periodic expenses.",
          "Doing 90 days of receipt collection.",
          "Reviewing the last 90 days of investments."
        ],
        "correct": 1,
        "explanation": "90 days of transactions × 4 + periodic expenses produces a defensible cash flow statement in 1–2 hours. It also surfaces the gap between what the client thinks they spend and what they actually spend — almost always meaningful."
      },
      {
        "id": "q8",
        "prompt": "When valuing real estate on a net worth statement, the most defensible source is:",
        "options": [
          "Owner's estimate of what the house 'feels' worth.",
          "The original purchase price.",
          "A recent appraisal or comparative market analysis from a real estate professional — leaning modestly conservative.",
          "Highest recent sale on the street."
        ],
        "correct": 2,
        "explanation": "Recent appraisal or agent CMA is the right source. Modestly conservative valuation is the discipline — aspirational numbers produce plans the client can't actually realize. Build on values that would clear in a 90-day normal sale."
      },
      {
        "id": "q9",
        "prompt": "How should defined-benefit pensions be treated on a net worth statement?",
        "options": [
          "Always at face value of expected lifetime benefits.",
          "Either as a present-value asset OR as an exclusion from balance sheet with treatment as projected retirement income — consistent and disclosed either way, and never double-counted.",
          "Ignored.",
          "Counted twice for safety."
        ],
        "correct": 1,
        "explanation": "Both approaches are valid as long as treatment is consistent and disclosed. The error to avoid is counting a pension as both an asset on the balance sheet AND as projected income in retirement projections — that double-counts the benefit."
      },
      {
        "id": "q10",
        "prompt": "Which is a common quality issue in personal financial statements?",
        "options": [
          "Cost basis being tracked.",
          "Permanent life insurance cash value reported at the face death benefit rather than current accessible cash value.",
          "Asset categories being labeled clearly.",
          "Year-over-year comparison included."
        ],
        "correct": 1,
        "explanation": "Death benefit (face value) and cash value (accessible during life) are very different numbers. Only cash value belongs on a net worth statement during the insured's lifetime. Face value pays to beneficiaries at death and isn't an asset of the current household."
      },
      {
        "id": "q11",
        "prompt": "When presenting a financial statement to a client, what's the right level of precision?",
        "options": [
          "Penny-precise — '$1,237,492.18'.",
          "Appropriately rounded for the conversation — '$1.24M' communicates better than penny-precise. Reserve precision for the underlying workpaper.",
          "Always to the nearest dollar.",
          "Always in scientific notation."
        ],
        "correct": 1,
        "explanation": "Penny precision overwhelms in conversation; round to communicate. The workpaper has the exact figures for audit. The client presentation has appropriate roundings to support understanding."
      },
      {
        "id": "q12",
        "prompt": "What's the best framing line when sharing a net worth statement that's lower than the client expected?",
        "options": [
          "'You should have saved more by now.'",
          "'This is what you've built. It's where we're starting from, and it's the foundation for everything we're going to plan.'",
          "'Your friends probably have more.'",
          "'We can fix this with the right portfolio.'"
        ],
        "correct": 1,
        "explanation": "Frames the number as a starting point, not a verdict. Acknowledges what the client has built without judgment. Pivots immediately to the work ahead. Especially helpful for clients with negative or lower-than-hoped numbers — the goal is producing useful insight, not making them feel worse."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 13;

-- ── module14_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 14 CONTENT
-- Behavioral Finance & Client Coaching
-- ============================================================================
update public.modules set
  title = 'Behavioral Finance & Client Coaching',
  competency_id = 'OJL-5',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Recognize the cognitive and emotional patterns that drive client decisions, and learn the coaching moves that keep plans intact when markets get loud.',
  learning_objectives = ARRAY[
    'Identify the most common cognitive biases that show up in real client conversations',
    'Recognize emotional patterns around volatility, windfalls, and losses',
    'Apply motivational interviewing techniques to client meetings',
    'Use pre-commitment, automation, and framing to design around bias',
    'Coach couples and families when stakeholders disagree about money'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Why Smart People Make Predictable Money Mistakes",
        "summary": "Behavioral finance is the study of why humans systematically deviate from rational economic behavior — and why even sophisticated clients need coaching.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Traditional economics assumed people were rational utility-maximizers. Decades of research — much of it from Daniel Kahneman and Amos Tversky — proved they aren't. People are loss-averse, present-biased, herd-following, overconfident, and prone to remembering the dramatic over the typical. None of this makes clients stupid. It makes them human. Your job as a counselor is not to lecture clients out of these patterns — that doesn't work. Your job is to recognize the patterns and design the plan, the conversation, and the environment so the patterns don't sink the plan."},
          {"type": "heading", "content": "The advisor's behavioral premium"},
          {"type": "paragraph", "content": "Vanguard's Advisor's Alpha research and Russell Investments' Value of an Advisor studies both estimate that a meaningful portion of the value advisors deliver comes not from picking better investments but from preventing client behavioral mistakes — talking the panicked client off a sell-everything ledge in March 2020, slowing the euphoric client who wants to dump retirement savings into a hot meme stock, getting the couple in agreement so they stop sabotaging each other's contributions. Behavior coaching is not soft skills. It is the work."},
          {"type": "callout", "kind": "key", "content": "If you only learn one thing from this module: the goal is not to be right about the client's biases. The goal is to design the relationship so the biases never get to drive."},
          {"type": "subheading", "content": "The bias toolkit you will see every week"},
          {"type": "glossary", "terms": [
            {"term": "Loss aversion", "definition": "The pain of losing $1,000 feels roughly twice as strong as the pleasure of gaining $1,000. Drives panic selling and refusal to realize losses."},
            {"term": "Anchoring", "definition": "Fixating on a reference number — what the stock used to be worth, what the house was listed for, what the 401(k) hit at its peak. The anchor often has no bearing on the present decision."},
            {"term": "Recency bias", "definition": "Weighting recent events more heavily than long-term data. A client who watched the market drop 15% this quarter cannot easily picture a 30-year horizon."},
            {"term": "Confirmation bias", "definition": "Seeking and remembering information that supports an existing belief while filtering out contradictory evidence."},
            {"term": "Herding", "definition": "Doing what others are doing — buying into a rally because friends are bragging, selling because the news cycle is grim."},
            {"term": "Overconfidence", "definition": "Believing one's predictions are more accurate than they actually are. Especially common in high-earning professionals."},
            {"term": "Mental accounting", "definition": "Treating money differently based on its source or label — bonus money gets spent, salary gets saved, tax refunds get blown."},
            {"term": "Present bias / hyperbolic discounting", "definition": "Overweighting immediate rewards versus future ones. The reason saving is hard even when the math is obvious."}
          ]},
          {"type": "case_study", "title": "Naomi after a bad quarter", "scenario": "Naomi, the analyst we have followed since Module 2, watches her 401(k) drop 18% in a quarter. She emails her advisor at 11pm: 'I want to move everything to cash until this settles down.' Her time horizon is 32 years. The portfolio is doing exactly what a 90/10 portfolio is supposed to do during a drawdown. Three biases are firing at once: loss aversion (the pain is acute), recency bias (she cannot feel the 32-year horizon), and anchoring (she is mentally anchored to the peak balance from three months ago).", "discussion": "The wrong move is to email back a Vanguard chart about 'time in the market.' That validates that this is a math problem. It is not. It is a fear problem dressed up in math clothing. The right move is to call her in the morning, acknowledge the fear, ask what specifically she is afraid of, and only then walk through what her plan was designed to do in exactly this scenario."},
          {"type": "paragraph", "content": "Notice the move: you start with the emotion, not the data. Clients who feel heard can hear data. Clients who feel dismissed cannot."},
          {"type": "callout", "kind": "note", "content": "Biases are not character flaws. They are features of human cognition that evolved to keep our ancestors alive. The same loss aversion that makes Naomi want to sell at the bottom is what kept her great-grandmother from eating unfamiliar berries."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Reading Emotion in the Room",
        "summary": "Before you can coach, you have to diagnose. What clients say is rarely the whole story — learn to read what they are actually feeling.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Clients almost never walk into a meeting and say 'I am terrified about running out of money in retirement and that terror is making me consider a decision I will regret.' They say things like 'I have been thinking about being more conservative' or 'a friend told me about an annuity.' Your job in the first ten minutes of any consequential conversation is to translate the surface request into the underlying feeling. You cannot solve the surface request well if you have misread the underlying state."},
          {"type": "subheading", "content": "The four emotional states that show up most often"},
          {"type": "list", "items": [
            "Fear — usually around loss, running out, or being exposed as not having known something",
            "Shame — typically about past financial choices, debt, divorce settlements, not having saved enough",
            "Euphoria — after a windfall, a hot investment, an inheritance, a business sale",
            "Resentment — usually around a spouse, a sibling, a former partner, or an institution"
          ]},
          {"type": "paragraph", "content": "Each state distorts decision-making differently. Fear narrows the field of view; the client cannot consider long-term tradeoffs because everything is about the immediate threat. Shame makes clients omit information — they leave out the credit card balance, the second mortgage, the loan from dad. Euphoria makes clients unusually willing to take risks they would have rejected a year earlier. Resentment makes clients make decisions to spite someone else rather than to serve themselves."},
          {"type": "subheading", "content": "Verbal signals to listen for"},
          {"type": "glossary", "terms": [
            {"term": "Should statements", "definition": "'I should have started saving sooner.' 'We should be further along.' Almost always shame. Do not validate the should — redirect to what is possible now."},
            {"term": "Catastrophic language", "definition": "'Everything I have worked for.' 'Nothing left.' 'Wiped out.' Almost always fear. The actual situation is rarely as binary as the language suggests."},
            {"term": "Comparison statements", "definition": "'My brother-in-law is up 40% this year.' 'Everyone in my office is buying X.' Usually herding pressure. Slow down before responding."},
            {"term": "Vague qualifiers", "definition": "'Some' debt. 'A few' credit cards. 'A while ago.' Shame about specifics. Get the actual numbers gently."},
            {"term": "Spouse-blame language", "definition": "'He never wanted to save.' 'She insisted on the bigger house.' Resentment. Both spouses need to be in the room before you build a plan."}
          ]},
          {"type": "subheading", "content": "Non-verbal signals you can train yourself to notice"},
          {"type": "list", "items": [
            "Body closing off — arms crossing, leaning back, turning toward the door. Trust is dropping.",
            "Glancing at the spouse before answering — the answer being given may not be the real answer.",
            "Long pauses before numbers — the client is calculating whether to tell you the truth.",
            "Voice dropping or trailing off — the topic has hit something painful.",
            "Sudden topic changes — you have approached something the client is not ready to discuss."
          ]},
          {"type": "case_study", "title": "Marcus and Tasha in the discovery meeting", "scenario": "Marcus and Tasha — the couple from Modules 3 and 11 — are in their first planning meeting. When the apprentice asks about debt, Marcus answers immediately: 'We have the mortgage, that is it.' Tasha glances at him, says nothing. Five minutes later when the apprentice asks about emergency savings, Tasha mentions 'the card we use for emergencies sometimes.' The apprentice gently follows up: 'Tell me a little more about that card — what's the balance?' Tasha says about $14,000.", "discussion": "Marcus was not lying — he genuinely did not consider the card a debt because Tasha manages it. But the glance was the signal. A counselor who pushed past the first 'that is it' would have missed the fourteen thousand dollars and built a plan around a fiction. Reading the glance is more important than reading the spreadsheet."},
          {"type": "callout", "kind": "do", "content": "When something feels off, slow down. Ask one more open question. 'Help me understand a little more about...' is one of the most powerful sentences in this work."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "The Coaching Conversation — Motivational Interviewing for Money",
        "summary": "Motivational interviewing is a clinical technique developed for addiction counseling. It works in financial coaching for the same reason it works there: people change when they hear themselves say why.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If you have ever tried to argue someone out of a bad financial decision, you already know it does not work. The harder you push, the more committed the client becomes to defending the position. Motivational interviewing flips this. Instead of telling the client what to do, you ask questions designed to surface their own reasons for change. The client persuades themselves. You just hold the space."},
          {"type": "subheading", "content": "The four core moves — OARS"},
          {"type": "glossary", "terms": [
            {"term": "Open questions", "definition": "Questions that cannot be answered with yes or no. 'What does retirement look like for you?' beats 'Do you want to retire at 65?' every time."},
            {"term": "Affirmations", "definition": "Specific recognition of strengths and effort. Not flattery. 'It took real discipline to pay off that card last year.'"},
            {"term": "Reflections", "definition": "Saying back what you heard, sometimes with slight amplification. 'So even though the market makes you nervous, you have stayed with the plan for three years now.'"},
            {"term": "Summaries", "definition": "Pulling together what the client has said over a longer stretch and offering it back. Lets the client hear their own thinking organized."}
          ]},
          {"type": "subheading", "content": "Change talk — the sound of motivation"},
          {"type": "paragraph", "content": "When clients start using certain kinds of language, motivation is rising. Listen for: desire ('I want to...'), ability ('I could...'), reasons ('Because if I do not...'), need ('I have to...'), and commitment ('I will...'). Your job is to ask questions that elicit more of this language. The more the client hears themselves talking about change, the more likely change becomes."},
          {"type": "subheading", "content": "Sustain talk and rolling with resistance"},
          {"type": "paragraph", "content": "The opposite of change talk is sustain talk — reasons to keep doing what they are doing. 'I cannot save more, I just cannot.' 'My husband would never agree to that.' When you hear sustain talk, the wrong move is to argue. The right move is to reflect it back without agreeing, then ask a question that opens a different angle. 'Saving more feels impossible right now. If we could find $50 a month somewhere, where would you want it to go?' You are not contradicting the client. You are inviting them to imagine differently."},
          {"type": "activity", "title": "Practice — flipping the script", "prompt": "For each statement below, write a response that reflects the client's feeling without agreeing with the conclusion, then asks an open question:", "steps": [
            "'There is no point trying to save for retirement, it is too late for me.'",
            "'My friends are all buying crypto and they are making a fortune. I am missing out.'",
            "'My wife handles all the money, I just sign what she puts in front of me.'",
            "'We will get serious about this when the kids are out of college.'"
          ]},
          {"type": "case_study", "title": "Devon and the equipment loan", "scenario": "Devon, the small business owner from prior modules, wants to take out a $90,000 equipment loan at 9.5% interest. He has $130,000 in his business savings. When the apprentice asks why he prefers debt to using cash, Devon says 'I never want to be cash-poor in the business.' The apprentice does not argue. Instead: 'Tell me about a time being cash-poor really hurt the business.' Devon describes 2020 — a stretch when receivables stretched out and he almost missed payroll. 'So the loan is partly about protecting against that feeling again.' Devon agrees. 'If we could solve the cash protection a different way — say a line of credit at 7% you only draw if you actually need it — what would that change?'", "discussion": "The apprentice never told Devon his plan was wrong. They asked questions that surfaced the real driver — fear of 2020 repeating — and then offered a structure that solved for the fear without the 9.5% locked-in debt. Devon makes the new decision. He owns it because he arrived at it."},
          {"type": "callout", "kind": "key", "content": "You will not persuade clients with better arguments. You will only persuade them by asking questions that let them persuade themselves."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Designing Around Bias — Automation, Pre-Commitment, and Framing",
        "summary": "Some bias problems can be solved by conversation. Others need to be solved by structure. Learn to build a plan that does not rely on the client being a different person than they are.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Coaching is necessary but not sufficient. The best behavioral interventions remove the decision from the moment of weakness entirely. If a client cannot resist spending the bonus, the plan should automatically route the bonus into investments before the client sees it. If a client panics when the market drops, the rebalancing rules should be written down in advance, signed, and triggered by predetermined thresholds — not by how the news is making the client feel that morning. Design the environment, not the resolve."},
          {"type": "subheading", "content": "Automation as a bias antidote"},
          {"type": "list", "items": [
            "Automatic contributions to 401(k), IRA, brokerage — removes the monthly decision",
            "Auto-escalation — contribution rate increases by 1% each year on a set date",
            "Sweep accounts — anything above $X in checking moves to savings on the 1st",
            "Direct deposit splitting — bonuses or commissions routed directly to savings before they hit checking",
            "Automatic rebalancing on a fixed schedule or threshold, not a feeling"
          ]},
          {"type": "subheading", "content": "Pre-commitment devices"},
          {"type": "paragraph", "content": "A pre-commitment device is a decision the client makes when they are calm that constrains the decision they will be tempted to make when they are not. The classic example is the Investment Policy Statement — a written document that says 'I will not change my allocation in response to a single quarter's performance. If I want to make a change, I will wait 30 days and re-discuss.' Signed when the client is calm. Pulled out when the client wants to panic-sell."},
          {"type": "callout", "kind": "do", "content": "Every client over a certain asset threshold should have a one-page Investment Policy Statement signed at the start of the relationship. It is the single most useful tool for surviving market drawdowns."},
          {"type": "subheading", "content": "Framing — same fact, different feeling"},
          {"type": "paragraph", "content": "How information is framed changes how clients react to it, even when the underlying numbers are identical. A 90% survival probability feels safer than a 10% failure probability — even though they are the same. A $10,000 loss feels different described as 'a 5% drawdown in a portfolio that has averaged 8% over 15 years' than as 'losing $10,000.' Framing is not manipulation. It is presenting the same truth in a way the client can actually process. The lie would be omitting either side. The skill is in choosing which frame to lead with."},
          {"type": "glossary", "terms": [
            {"term": "Default framing", "definition": "Setting the default option to the desired behavior. Auto-enrollment in a 401(k) raises participation from ~60% to ~90% — same employees, same plan, different default."},
            {"term": "Loss framing", "definition": "Describing a choice in terms of what is at risk of being lost. Tends to motivate action because of loss aversion."},
            {"term": "Gain framing", "definition": "Describing the same choice in terms of what could be gained. Tends to feel less urgent but more sustainable."},
            {"term": "Bucket framing", "definition": "Mentally separating money by purpose — emergency bucket, retirement bucket, near-term goals bucket. Leverages mental accounting positively."}
          ]},
          {"type": "case_study", "title": "Designing for Marcus and Tasha", "scenario": "Marcus and Tasha agreed to save more after Modules 3 and 11. But three months in, the extra savings are not happening — they keep meaning to transfer money and never do. The apprentice does not call this a discipline problem. They restructure: bi-weekly automatic transfer of $400 from checking to a high-yield savings account labeled 'Emergency Fund' at a different bank than their checking. The money moves the day after each payday, before discretionary spending. Three months later, the emergency fund is at $2,400 with no further conversations.", "discussion": "Marcus and Tasha did not become more disciplined. The system became more forgiving of their actual discipline level. Notice also the labeling — 'Emergency Fund' at a different bank — uses mental accounting and friction to discourage casual withdrawal."},
          {"type": "callout", "kind": "warn", "content": "If a plan requires the client to make a recurring willpower-dependent decision, the plan will eventually fail. Engineer the willpower out."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "When Two People Have to Agree — Coaching Couples and Families",
        "summary": "Most household financial decisions involve more than one person. When stakeholders disagree, the coaching work doubles — and the wrong move can damage the marriage as much as the portfolio.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Money is one of the top three causes of divorce. By the time a couple is sitting across from you, there is often a long history of money fights, money silences, money resentments — and the conversation you are about to have is not really about asset allocation. It is about whether two people who love each other can build something together that they both believe in. Take the role seriously. You are not a marriage counselor, but you are doing some of the work."},
          {"type": "subheading", "content": "Common couple patterns to recognize"},
          {"type": "glossary", "terms": [
            {"term": "The CFO and the consumer", "definition": "One spouse handles all the money decisions, the other spouse spends without engagement. Eventually the CFO burns out or the consumer wakes up to a balance sheet they do not recognize."},
            {"term": "The saver and the spender", "definition": "One spouse is wired toward security, the other toward enjoyment. Neither is wrong. The plan has to honor both or it will break."},
            {"term": "The risk-seeker and the risk-avoider", "definition": "One spouse is comfortable with equity volatility, the other cannot sleep with it. A 70/30 portfolio works for neither — design something asymmetric."},
            {"term": "The yours/mine couple", "definition": "Separate accounts, separate everything, often after a prior marriage. Build a plan that respects the separation but creates joint accountability where needed."},
            {"term": "The silent spouse", "definition": "One spouse comes to every meeting and does not speak. Either disengaged or being overridden. Address it directly and gently."}
          ]},
          {"type": "subheading", "content": "Ground rules for the joint meeting"},
          {"type": "list", "items": [
            "Both spouses in the room for any consequential decision — no one-sided sign-offs on things that affect them both",
            "Ask each spouse questions directly, not just 'you two' — make sure both voices land in the record",
            "When one spouse interrupts the other, calmly redirect: 'I want to hear Maria finish that thought'",
            "Never side with one spouse against the other, even when you privately agree with one of them",
            "Surface disagreement explicitly — 'It sounds like you two see this differently. Let's slow down here.'",
            "If a couple is in active conflict, do not push to a decision in that meeting. Reschedule."
          ]},
          {"type": "subheading", "content": "Working with adult children, parents, and blended families"},
          {"type": "paragraph", "content": "The household is not always two people. Adult children may be involved in aging parents' decisions. Stepchildren and former spouses complicate estate planning. Sometimes a financially successful child is supporting a parent or a sibling. Each of these situations has emotional currents that long predate you. Your job is to map the dynamics without judging them, and to design a plan that does not require the family to suddenly become a different family."},
          {"type": "case_study", "title": "Marcus's mother", "scenario": "During the planning conversation, Marcus mentions that he has been sending his mother $400 a month for two years. Tasha looks surprised. She knew he helped sometimes but did not know it was monthly or that amount. The apprentice does not move past this. 'It sounds like this is the first time you two are talking about this number together. I want to make sure we plan with the real picture.' The apprentice asks Marcus to explain what the support is for, asks Tasha what she is feeling hearing it for the first time, and only then continues.", "discussion": "The apprentice did not avoid the moment because it was uncomfortable. They held the moment. The $4,800 a year matters for the cash flow plan — but the bigger issue is that Marcus and Tasha did not have a shared picture of their own money. Surfacing that gently, with care, is part of the work. A counselor who breezed past it would have built a financial plan that excluded reality."},
          {"type": "callout", "kind": "note", "content": "When you sense a couple has just disagreed on something for the first time in front of you, you have two options: rush past it or hold it. Hold it. The couple needs to talk about it eventually. They might as well do it with a calm professional in the room."},
          {"type": "subheading", "content": "Tying it back to the apprentice role"},
          {"type": "paragraph", "content": "Behavioral coaching is the difference between being a financial calculator and being a counselor. The numbers any apprentice can learn. The capacity to sit with another human being's fear, shame, euphoria, or resentment — without flinching, without judging, without trying to fix what is not yours to fix — that is the practice. Every client meeting is an opportunity to develop it."},
          {"type": "divider"},
          {"type": "paragraph", "content": "In the next module, we move from coaching the relationship to the structured tool that translates client risk capacity and tolerance into an actual portfolio decision: risk profiling and suitability."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "A client emails at 11pm wanting to move everything to cash after a bad quarter. The first move is to:", "options": ["Email back a chart showing long-term market returns", "Call in the morning and start with the emotion, not the data", "Process the trade overnight to honor client wishes", "Refer the client to a different advisor"], "correct": 1, "explanation": "Clients in fear cannot hear data until they feel heard. Start with the emotion. The data conversation follows."},
        {"id": "q2", "prompt": "Loss aversion describes which of the following?", "options": ["The tendency to lose money on most trades", "The pain of losing $1,000 feeling roughly twice as strong as the pleasure of gaining $1,000", "The risk of avoiding all investments", "A bias unique to inexperienced investors"], "correct": 1, "explanation": "Loss aversion is the asymmetry between the felt pain of loss and the felt pleasure of equivalent gain. It affects everyone, including sophisticated investors."},
        {"id": "q3", "prompt": "Which of the following is an example of a pre-commitment device?", "options": ["Telling the client to be more disciplined", "An Investment Policy Statement signed when the client is calm that constrains future panic decisions", "Reading market news every morning", "Setting more aggressive return targets"], "correct": 1, "explanation": "A pre-commitment device is a decision made in a calm state that constrains a decision the client will be tempted to make under stress. The IPS is the classic example."},
        {"id": "q4", "prompt": "Motivational interviewing's OARS framework stands for:", "options": ["Observe, Ask, Recommend, Sell", "Open questions, Affirmations, Reflections, Summaries", "Outline, Articulate, Reason, Solve", "Onboarding, Assessment, Review, Strategy"], "correct": 1, "explanation": "OARS — Open questions, Affirmations, Reflections, Summaries — is the core conversational toolkit of motivational interviewing."},
        {"id": "q5", "prompt": "A client says 'My friends are all buying crypto and making a fortune. I am missing out.' This is most likely:", "options": ["A rational reallocation request", "Anchoring bias", "Herding pressure", "Hyperbolic discounting"], "correct": 2, "explanation": "Herding — doing what others are doing because they are doing it — is the bias driving most 'everyone else is...' statements."},
        {"id": "q6", "prompt": "Auto-enrollment raises 401(k) participation rates from roughly 60% to 90% because:", "options": ["Employees become more financially literate", "The contribution rates increase automatically", "Setting the default to the desired behavior leverages how people respond to defaults", "Employers offer better matches"], "correct": 2, "explanation": "Default framing is one of the most powerful behavioral interventions. Most people accept the default, so designing the default is designing the outcome."},
        {"id": "q7", "prompt": "Which of the following best describes 'change talk' in motivational interviewing?", "options": ["The advisor telling the client what to change", "The client using language of desire, ability, reasons, need, or commitment toward change", "Switching topics during a conversation", "Discussing market changes"], "correct": 1, "explanation": "Change talk is the client's own language signaling motivation. The more change talk, the more likely behavior change. The advisor's job is to ask questions that elicit it."},
        {"id": "q8", "prompt": "During a joint meeting, one spouse interrupts the other every time the second spouse tries to speak. The most appropriate move is to:", "options": ["Let the dominant spouse finish, since they seem more engaged", "Side with the quieter spouse to even things out", "Calmly redirect: 'I want to hear Maria finish that thought'", "End the meeting and only meet with one spouse going forward"], "correct": 2, "explanation": "Both voices need to land in the record. Calmly redirecting without taking sides preserves your neutrality and protects the relationship."},
        {"id": "q9", "prompt": "Mental accounting refers to:", "options": ["The math of calculating portfolio returns", "Treating money differently based on its source or label", "Reviewing accounts mentally before sleep", "A type of double-entry bookkeeping"], "correct": 1, "explanation": "Mental accounting is the tendency to treat money differently depending on where it came from or what we call it. Bonus money gets spent, salary gets saved, refunds get blown."},
        {"id": "q10", "prompt": "A client says 'I should have started saving sooner. I should be further along by now.' This 'should' language most often indicates:", "options": ["Strong financial literacy", "Confirmation bias", "Shame about past financial choices", "A request for tax planning"], "correct": 2, "explanation": "'Should' statements about the past are almost always shame. The right move is to redirect to what is possible now, not to validate the should."},
        {"id": "q11", "prompt": "Devon wants a $90,000 equipment loan at 9.5% when he has $130,000 in business savings. After exploring, the apprentice learns Devon is afraid of repeating a 2020 cash crisis. The strongest next move is to:", "options": ["Tell Devon his fear is irrational and use the cash", "Refuse to discuss the loan", "Offer a structure — like a line of credit — that solves the cash protection without the high locked-in rate", "Process the loan as requested"], "correct": 2, "explanation": "You do not win by overriding the client's fear. You win by designing a structure that honors the underlying need (cash protection) without paying 9.5% locked in."},
        {"id": "q12", "prompt": "The behavioral premium of an advisor — the value of preventing client behavioral mistakes — is best described as:", "options": ["A marketing concept with no empirical support", "A meaningful portion of the value advisors deliver according to multiple industry studies", "A practice only used by fee-only advisors", "Only relevant for high-net-worth clients"], "correct": 1, "explanation": "Industry research from Vanguard, Russell, and others estimates behavioral coaching is a meaningful part of advisor value — often as much or more than investment selection."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 14;

-- ── module15_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 15 CONTENT
-- Risk Profiling & Suitability
-- ============================================================================
update public.modules set
  title = 'Risk Profiling & Suitability',
  competency_id = 'OJL-6',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Translate a client''s risk capacity, tolerance, and required return into a defensible suitability determination — and document it the way regulators expect.',
  learning_objectives = ARRAY[
    'Distinguish risk capacity, risk tolerance, and required return',
    'Administer and interpret a risk profiling questionnaire',
    'Reconcile mismatches between what a client says and what their situation requires',
    'Document a suitability determination that holds up to compliance review',
    'Communicate risk in terms clients actually feel, not just statistics'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Three Risks That Live in Every Client",
        "summary": "Every client has three different risk numbers — and one of the most common counselor mistakes is conflating them. Get them separated.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Ask three different planners 'how risky a portfolio should this client have' and you can get three different answers — not because anyone is wrong but because they are answering different questions. Risk in client work is not one number. It is three numbers that have to be reconciled. If you mix them up, you build the wrong portfolio for the right client, or worse, the right portfolio for the wrong client."},
          {"type": "subheading", "content": "The three risk dimensions"},
          {"type": "glossary", "terms": [
            {"term": "Risk capacity", "definition": "How much loss the client can financially absorb without breaking the plan. A function of time horizon, income stability, savings rate, and other resources. Objective. Calculable."},
            {"term": "Risk tolerance", "definition": "How much loss the client can emotionally absorb without breaking themselves. A function of personality, history, and current life stress. Subjective. Measured by questionnaire and conversation."},
            {"term": "Required return", "definition": "The annualized return the client's portfolio needs to deliver for the stated goals to be achievable. A function of starting assets, savings, time horizon, and target. Objective. Calculable from the financial plan."}
          ]},
          {"type": "callout", "kind": "key", "content": "Capacity says what the client can take. Tolerance says what the client can stand. Required return says what the client needs. The portfolio has to honor all three — and when they conflict, the conversation gets interesting."},
          {"type": "subheading", "content": "Worked example — Naomi at 32"},
          {"type": "paragraph", "content": "Naomi has a 32-year time horizon for retirement, stable W-2 income, six months of emergency reserves, and is saving 18% of gross income. Her risk capacity is high — even a 40% drawdown does not break the plan because she will not need the money for three decades and has cash flow to keep contributing through any drawdown. Her risk tolerance, based on questionnaire and the panic email from Module 14, is moderate — she felt real pain at 18% down. Her required return to hit a comfortable retirement is about 6% real. The portfolio decision has to thread the needle: capacity says go aggressive, tolerance says no more than she can stand, required return says she does not need to take maximum risk."},
          {"type": "subheading", "content": "Worked example — A 68-year-old retiree"},
          {"type": "paragraph", "content": "Now consider a 68-year-old retiree drawing 4.5% of a $1.2M portfolio annually. Risk capacity is lower than Naomi's — a 40% drawdown means selling assets to fund withdrawals at depressed prices, which can permanently impair the plan. Risk tolerance is high — this client lived through 1987, 2000, and 2008 and never sold. Required return is about 5% nominal to sustain the withdrawal rate. Here capacity is the binding constraint, not tolerance. Just because the client can stand more risk does not mean the plan can. The 60/40 portfolio is right not because the client is timid but because the plan cannot tolerate large equity drawdowns at this stage."},
          {"type": "callout", "kind": "warn", "content": "Common error: building portfolios based only on risk tolerance. A client who says 'I can handle anything' but who needs the money in 18 months for a down payment has high tolerance and zero capacity. The capacity wins. Always."},
          {"type": "subheading", "content": "The fourth quiet variable — risk perception"},
          {"type": "paragraph", "content": "Some practitioners add a fourth: risk perception, or how the client interprets the risk they are taking. Two clients with identical 70/30 portfolios can perceive their risk completely differently — one because they understand what they own, the other because they do not. Perception is what the counselor's communication shapes. The same portfolio that feels 'volatile and concerning' can feel 'doing exactly what it should' when the client understands the design. Education is part of risk management."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Questionnaire and What It Actually Measures",
        "summary": "Risk tolerance questionnaires are a compliance requirement and a starting point. They are not the answer — they are a prompt for a conversation.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most broker-dealers and RIAs require a documented risk tolerance questionnaire on file for every client. The instruments vary — Riskalyze (now Nitrogen), FinaMetrica, internal proprietary scales — but they generally try to do three things: measure stated risk tolerance under hypothetical scenarios, measure investment knowledge, and surface preferences about volatility versus growth. Used well, they are useful. Used badly, they are dangerous — because a client who scored 'aggressive' on a questionnaire and then sold at the bottom of a drawdown will be the first person the client's attorney points at."},
          {"type": "subheading", "content": "What good questionnaires try to measure"},
          {"type": "list", "items": [
            "Stated reaction to hypothetical drawdowns — would you sell, hold, or buy more if your portfolio fell 25%?",
            "Investment knowledge and experience — how long have you invested, what have you owned?",
            "Time horizon and liquidity needs — when do you need the money, how much, for what?",
            "Preference between volatility and growth — would you take a steady 5% or a volatile 10%?",
            "Income stability and other resources — how does this money fit the rest of your picture?"
          ]},
          {"type": "subheading", "content": "What questionnaires cannot measure"},
          {"type": "list", "items": [
            "How the client will actually behave when the loss is real instead of hypothetical",
            "How the client will behave when their spouse, parent, or coworker is panicking around them",
            "Whether the client understood the questions the way you intended",
            "Hidden context — a recent layoff, a divorce, a parent's illness — that shifts everything"
          ]},
          {"type": "callout", "kind": "do", "content": "Walk through the questionnaire with the client, do not just hand it to them. Watch which questions they hesitate on. Ask 'tell me more about why you picked that' on any answer that feels off. The conversation around the questionnaire is more valuable than the score."},
          {"type": "subheading", "content": "Interpreting the score"},
          {"type": "paragraph", "content": "Most questionnaires output a number or band — Conservative, Moderately Conservative, Moderate, Moderately Aggressive, Aggressive — that maps to a model portfolio. Treat the band as a starting point and a documentation artifact, not a final answer. If the questionnaire says Moderate but the client just received a $1.5M inheritance from a parent they lost three months ago, the right move may be to start more conservatively than the band suggests for the first year. The score does not know about the grief."},
          {"type": "case_study", "title": "The questionnaire that lied", "scenario": "Naomi takes a risk tolerance questionnaire and scores Aggressive. She answers every drawdown question with 'I would buy more.' Six months later she sends the panic email from Module 14 after an 18% drop. The questionnaire was not wrong on its terms — Naomi genuinely believed she would buy more. But she had never experienced a drawdown with real money. Stated tolerance and revealed tolerance can differ enormously. The advisor's note after the panic episode: 'Reassess as Moderately Aggressive at most. Build a 5-7% cash buffer to give her something to deploy during the next drawdown so she has agency.'", "discussion": "The questionnaire's mistake was not the score. It was being treated as the answer. Revealed behavior in the first real drawdown is more diagnostic than any questionnaire. Reassess and document the reassessment."},
          {"type": "callout", "kind": "note", "content": "Re-administer the risk tolerance questionnaire after major life events, after a significant drawdown the client experienced, and at minimum every two to three years. Tolerance is not a fixed trait."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Suitability — The Legal Standard, Plain English",
        "summary": "Suitability is not a vague aspiration. It is a regulatory requirement with specific elements. Know what it requires and what it does not.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Suitability is the foundational regulatory requirement for investment recommendations in the United States. FINRA Rule 2111 governs broker-dealer representatives. SEC Regulation Best Interest (Reg BI), effective June 2020, raised the standard for broker-dealers when recommending securities to retail customers — requiring that recommendations be in the customer's best interest at the time of the recommendation. RIAs and their representatives operate under a separate fiduciary standard under the Investment Advisers Act of 1940, which has historically been a higher standard than suitability — though the practical gap narrowed somewhat with Reg BI."},
          {"type": "callout", "kind": "key", "content": "Suitability is the floor. Fiduciary duty is the higher standard. Know which applies to you in the role you are operating. At GIC, the apprentice operates under the supervision of a fiduciary advisor — your work is held to the higher standard whether or not you personally hold the license that requires it."},
          {"type": "subheading", "content": "FINRA Rule 2111 — three suitability obligations"},
          {"type": "glossary", "terms": [
            {"term": "Reasonable-basis suitability", "definition": "The recommendation is reasonable for at least some investors. The product itself is not inherently unsuitable. Diligence on the product."},
            {"term": "Customer-specific suitability", "definition": "The recommendation is reasonable for this specific customer based on their profile — age, financial situation, tax status, investment experience, objectives, time horizon, liquidity needs, and risk tolerance."},
            {"term": "Quantitative suitability", "definition": "Even if individual recommendations are suitable, the pattern of recommendations — the frequency, volume, and turnover — is not excessive for the customer."}
          ]},
          {"type": "subheading", "content": "Reg BI — four obligations for broker-dealers"},
          {"type": "list", "items": [
            "Disclosure — provide certain disclosures before or at the time of the recommendation",
            "Care — exercise reasonable diligence, care, and skill",
            "Conflict of interest — establish and enforce written policies addressing conflicts",
            "Compliance — establish and enforce policies reasonably designed to achieve compliance with Reg BI"
          ]},
          {"type": "subheading", "content": "The Form CRS"},
          {"type": "paragraph", "content": "Reg BI introduced a required client relationship summary — Form CRS — that broker-dealers and RIAs must deliver to retail clients. It is meant to be a plain-English explanation of services, fees, conflicts, and standard of conduct. You should be able to walk a client through your firm's Form CRS in five minutes. Practice it."},
          {"type": "subheading", "content": "Documenting suitability"},
          {"type": "paragraph", "content": "Suitability lives or dies in the documentation. A recommendation that was suitable but undocumented is, from a compliance perspective, indistinguishable from one that was unsuitable. The file note for any recommendation should capture: what was recommended, why it was suitable given the client's profile, what alternatives were considered and why they were rejected, what disclosures were made, and what the client said in response. Do this consistently and a regulator can reconstruct your reasoning years later. Skip it and you cannot reconstruct your own reasoning a year later."},
          {"type": "case_study", "title": "The variable annuity recommendation that needed a paper trail", "scenario": "An apprentice's supervising advisor is recommending a deferred variable annuity for a 58-year-old client with $450,000 in qualified retirement assets. The annuity has a 1.65% M&E fee, a 2.10% rider fee for guaranteed lifetime income, and a 7-year surrender schedule. The apprentice drafts the suitability memo: client objective (income certainty in retirement), why this product (income rider provides longevity hedging the client values), alternatives considered (managed payout fund, bond ladder, deferred income annuity at age 70 — each evaluated and noted), all fees and surrender terms disclosed, client signed acknowledgment. The memo is six paragraphs.", "discussion": "If this client complains in three years that the fees ate her returns, the file shows that the alternatives were considered, the fees were disclosed, the client's stated objective was income certainty, and the product matched that objective. The memo is the difference between a defensible recommendation and a problem."},
          {"type": "callout", "kind": "do", "content": "If you would not feel comfortable explaining the recommendation to a regulator three years from now without the file in front of you, write a better file note now. Documentation is part of the recommendation, not paperwork after it."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "When Capacity and Tolerance Disagree",
        "summary": "The hardest counseling conversations happen when what the client can financially afford and what they can emotionally tolerate point in opposite directions. Here is how to work through it.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When capacity, tolerance, and required return all line up, the portfolio decision is easy. The work happens when they disagree. The four common mismatches are worth knowing by name because you will see each of them in client meetings."},
          {"type": "subheading", "content": "Mismatch 1 — high capacity, low tolerance"},
          {"type": "paragraph", "content": "The client has a long horizon, stable income, and plenty of resources, but cannot sleep with equity volatility. They are emotionally a 40/60 client in a financial situation that could support 80/20. If you build 80/20 to maximize math, they will sell at the bottom and lock in losses. If you build 40/60 to honor emotion, they may not hit their goals. The honest move: meet them where they are now — say 50/50 or 60/40 — and use education, smaller exposures, and time to gradually grow tolerance. Do not engineer for the portfolio they should have. Engineer for the portfolio they will actually hold."},
          {"type": "subheading", "content": "Mismatch 2 — low capacity, high tolerance"},
          {"type": "paragraph", "content": "The opposite case. The retiree with high stated tolerance whose plan cannot survive a 40% drawdown. The recent retiree who 'rode out 2008 fine' but is now in a withdrawal phase rather than an accumulation phase. Capacity wins. Even if the client wants more equity, the responsible counselor explains why the portfolio that fit during accumulation is not the portfolio that fits during withdrawal. Sequence-of-returns risk is the technical name. Educate, document, and constrain."},
          {"type": "subheading", "content": "Mismatch 3 — required return exceeds capacity"},
          {"type": "paragraph", "content": "The client wants to retire at 55 on $90,000 a year and currently has $400,000 saved with eight years to go. The required return to make that math work without further savings is implausibly high. You cannot fix this with a more aggressive portfolio — taking the risk required to chase that return creates an unacceptable probability of being permanently impaired. The right conversation is not about portfolio. It is about goals. Some combination of saving more, working longer, spending less in retirement, or accepting a lower probability of success is needed. The portfolio cannot solve a goal problem."},
          {"type": "callout", "kind": "warn", "content": "When required return exceeds reasonable capacity, the temptation is to recommend more aggressive investments to chase the math. Resist. You are setting the client up to fail in a drawdown. Instead, reset the goals."},
          {"type": "subheading", "content": "Mismatch 4 — capacity exceeds required return"},
          {"type": "paragraph", "content": "The pleasant case. A client has more resources, time, or income stability than they need for their goals. They could take 80/20 risk but only need 50/50 returns to be fine. Do not maximize what is unnecessary. A wealthy retiree who already has more than enough for the rest of their life does not benefit from chasing growth — the marginal dollar from upside does not change their life, while a large drawdown could meaningfully damage it. Discuss explicitly with the client whether they want growth for heirs, philanthropy, or other purposes — and let that conversation, not a return target, drive the allocation."},
          {"type": "case_study", "title": "Marcus and Tasha — required return reality check", "scenario": "Marcus and Tasha — early 30s, two kids — want to fully fund both college costs and retire at 60. After running the projections, the required return is 8.5% real to do everything without raising savings. That is implausible to plan around — it exceeds long-term equity real returns and would require taking risk that breaks tolerance. The apprentice does not propose a more aggressive portfolio. Instead they walk through the four levers: save more, retire later, spend less in retirement, or accept partially funding college (with the kids covering the gap through scholarships, in-state schools, or loans). Marcus and Tasha decide to raise savings by 3% and target 80% of college costs rather than 100%. The required return drops to 5.8% real — achievable.", "discussion": "Notice that the apprentice did not solve a goals problem with a portfolio recommendation. They surfaced the math, explained the levers, and let the clients choose. That is fiduciary work."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Talking About Risk So Clients Actually Feel It",
        "summary": "Statistics about standard deviation and Sharpe ratios do not move clients. Dollar amounts and lived scenarios do. Communicate risk the way clients hear it.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A 15% standard deviation on a portfolio means almost nothing to almost any client. 'Your portfolio could drop by $87,000 in a bad year' means everything. The skill is in translating statistical risk into experienced risk — turning percentages into dollars, charts into stories, and abstract probabilities into something the client can feel before they have to live through it."},
          {"type": "subheading", "content": "From percentages to dollars"},
          {"type": "paragraph", "content": "Every time you discuss potential drawdowns with a client, translate to dollars on their actual balance. A 30% drawdown on a $750,000 portfolio is $225,000 — and the client needs to sit with that number before agreeing to the allocation that produces it. If they flinch at the number, the allocation is wrong. If they nod calmly and say 'I have seen that before and it does not move me,' the allocation may be right. The point is not to scare the client. The point is to surface the actual experience the portfolio is signing them up for."},
          {"type": "subheading", "content": "Historical context — what the portfolio has done before"},
          {"type": "paragraph", "content": "Show clients the actual worst rolling 12-month and 36-month periods for portfolios similar to theirs. A 70/30 portfolio's worst 12-month period since 1976 was roughly -28% in 2008. That is what the portfolio did the last time things got bad. If the client cannot imagine signing for that, do not build that portfolio. If the client says 'I lived through it and added money,' you have useful information."},
          {"type": "subheading", "content": "Range framing"},
          {"type": "paragraph", "content": "Rather than a single expected return, show the client the range. 'Over 20 years, a portfolio like this has historically returned between X% and Y% per year on the worst and best rolling 20-year windows. The middle is around Z%.' This honors the truth that returns are not a constant and prevents the client from anchoring on the median as a promise."},
          {"type": "subheading", "content": "Probability of failure language"},
          {"type": "paragraph", "content": "Monte Carlo simulations output a probability that the plan succeeds — say, '88% probability the plan succeeds over the planning horizon.' Many clients hear 88% and feel reassured. Some clients hear 12% probability of failure and feel terrified — same number, different framing. Both framings are honest. Lead with the one that gives the client the most accurate emotional signal for their situation. If the client is risk-tolerant and may underprepare, lead with the failure framing. If the client is risk-averse and may overreact, lead with the success framing. Both numbers should be in the document."},
          {"type": "case_study", "title": "Explaining a 70/30 portfolio to a couple in their 40s", "scenario": "The apprentice is presenting a 70/30 portfolio to a couple with $560,000 invested. Rather than 'expected return 6.5%, standard deviation 11.2%,' the apprentice says: 'Based on history, this portfolio averages about 6 to 7 percent a year, but in a bad year it could drop by $90,000 to $170,000. The worst 12-month period for something like this since 1976 was about $156,000 down. The recovery from that took roughly three years. Can you sign up for that experience between now and retirement, knowing it will happen at least once or twice?'", "discussion": "Notice — dollars, history, recovery time, and an explicit invitation to commit. The couple either says yes with eyes open or says no and the apprentice goes back to design. Either outcome is better than building a portfolio the clients did not actually understand the risk of."},
          {"type": "callout", "kind": "key", "content": "If the client cannot sign for the drawdown number in calm conversation, they cannot hold the portfolio in the actual drawdown. Find the allocation they can sign for. That is the right one."},
          {"type": "subheading", "content": "Closing the suitability loop"},
          {"type": "paragraph", "content": "When risk is communicated this way and the client agrees to the allocation in writing, suitability is not a paperwork exercise. It is a documented record of an informed decision. That is what regulators want to see. That is what clients want to remember when the drawdown actually arrives. That is the goal of this entire module — not to predict the future, but to prepare the relationship for whatever future shows up."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: now that you have the right allocation, you have to present the full plan in a way the client can actually absorb. Plan Presentation & Communication."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Risk capacity is best described as:", "options": ["How much loss the client can emotionally absorb", "How much loss the client can financially absorb without breaking the plan", "The annualized return needed to hit goals", "The standard deviation of the portfolio"], "correct": 1, "explanation": "Capacity is the objective financial measure — what the plan can survive. Tolerance is the emotional measure. Required return is the math need."},
        {"id": "q2", "prompt": "A 24-year-old client with stable income, a 40-year horizon, and high stated comfort with volatility wants to invest a down payment they will use in 18 months. The right portfolio decision is:", "options": ["Aggressive equity allocation since they have high tolerance", "Conservative cash or short-term instruments since capacity for this dollar is low", "Match their stated tolerance regardless of horizon", "60/40 by default"], "correct": 1, "explanation": "Capacity wins. The dollar is needed in 18 months — that is zero capacity for equity drawdown, no matter what tolerance the client states."},
        {"id": "q3", "prompt": "FINRA Rule 2111 includes which three suitability obligations?", "options": ["Disclosure, care, and conflict of interest", "Reasonable-basis, customer-specific, and quantitative suitability", "Capacity, tolerance, and required return", "Fees, performance, and benchmarks"], "correct": 1, "explanation": "Rule 2111 specifies reasonable-basis (product itself), customer-specific (right for this client), and quantitative (pattern of recommendations not excessive) suitability."},
        {"id": "q4", "prompt": "Regulation Best Interest (Reg BI) became effective in:", "options": ["June 2017", "January 2019", "June 2020", "January 2022"], "correct": 2, "explanation": "Reg BI became effective in June 2020 and raised the standard for broker-dealer recommendations to retail customers."},
        {"id": "q5", "prompt": "Form CRS is:", "options": ["A risk tolerance questionnaire", "A required client relationship summary explaining services, fees, conflicts, and standard of conduct", "A custodial agreement", "A tax form"], "correct": 1, "explanation": "Form CRS is the plain-English client relationship summary that broker-dealers and RIAs must deliver to retail clients under Reg BI."},
        {"id": "q6", "prompt": "When required return significantly exceeds reasonable capacity, the right move is to:", "options": ["Recommend a more aggressive portfolio to chase returns", "Reset the goals through some combination of saving more, working longer, spending less, or accepting lower success probability", "Switch to alternative investments", "Tell the client to be patient"], "correct": 1, "explanation": "Portfolio cannot solve a goals problem. Surface the math, walk the client through the levers, and let them choose."},
        {"id": "q7", "prompt": "Sequence-of-returns risk is most relevant to:", "options": ["Young accumulators with long horizons", "Clients in or near withdrawal from the portfolio", "Tax-advantaged accounts only", "Fixed-income investors"], "correct": 1, "explanation": "Sequence risk matters most when withdrawals are being taken — early drawdowns paired with withdrawals can permanently impair the plan."},
        {"id": "q8", "prompt": "Naomi scored 'Aggressive' on her risk questionnaire but panicked after an 18% drawdown. The right interpretation is:", "options": ["The questionnaire was useless", "Stated tolerance and revealed tolerance can differ; reassess based on lived behavior and document the change", "Naomi should be reclassified as Conservative", "Risk questionnaires should not be used"], "correct": 1, "explanation": "Stated tolerance under hypothetical scenarios is not the same as revealed behavior in real drawdowns. Reassess and document the reassessment."},
        {"id": "q9", "prompt": "Communicating risk to clients is most effective when:", "options": ["Standard deviation and Sharpe ratios are emphasized", "Risk is translated into dollar amounts on the client's actual balance and into historical experienced drawdowns", "Only positive outcomes are highlighted", "Probability of failure is never mentioned"], "correct": 1, "explanation": "Dollars and historical experience move clients in a way statistics do not. The goal is for the client to feel the risk before they have to live through it."},
        {"id": "q10", "prompt": "Suitability documentation should capture, at minimum:", "options": ["The recommendation only", "What was recommended, why suitable for this client, alternatives considered, disclosures made, and client response", "The fee schedule", "Marketing materials"], "correct": 1, "explanation": "The file note should let a reviewer reconstruct the reasoning years later, including alternatives considered and rejected and disclosures made."},
        {"id": "q11", "prompt": "When capacity exceeds required return — the client has more resources or time than they need — the appropriate response is to:", "options": ["Automatically recommend more aggressive growth", "Discuss with the client whether growth for heirs, philanthropy, or other purposes is desired, and let purpose drive allocation", "Move to all cash since growth is unnecessary", "Maintain the standard model regardless"], "correct": 1, "explanation": "When unnecessary risk is not needed, the right conversation is about purpose. Excess capacity becomes a choice, not a default."},
        {"id": "q12", "prompt": "At GIC, an apprentice operating under the supervision of a fiduciary advisor is held to:", "options": ["The suitability standard only", "The higher fiduciary standard, regardless of personal licensing", "No regulatory standard", "Whatever the client chooses"], "correct": 1, "explanation": "The fiduciary standard governs the work product at GIC. Apprentices learn and operate to the higher standard from day one."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 15;

-- ── module16_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 16 CONTENT
-- Plan Presentation & Communication
-- ============================================================================
update public.modules set
  title = 'Plan Presentation & Communication',
  competency_id = 'OJL-7',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Present a complete financial plan in a way clients can absorb, remember, and act on — without drowning them in detail or hiding behind jargon.',
  learning_objectives = ARRAY[
    'Structure a plan presentation that leads with the client''s goals, not your analysis',
    'Build plan documents and slide decks that an intelligent non-expert can read alone',
    'Lead a presentation meeting with confidence, including for difficult news',
    'Handle questions, objections, and emotional reactions in real time',
    'Close the meeting with clear action steps, ownership, and follow-up dates'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Designing the Plan Document for the Client, Not the Planner",
        "summary": "Most financial plans are written for the planner who built them. The good ones are written for the client who has to read them — once, alone, sitting at the kitchen table.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A planning deliverable that the client cannot read alone has failed, no matter how technically excellent it is. The test for any plan document is: if the client looked at this six months from now without you in the room, could they tell what their situation is, what was recommended, and what their action items are? If yes, you have done the work. If no, you have produced a beautiful artifact that does not serve the client."},
          {"type": "subheading", "content": "The standard plan document structure"},
          {"type": "numbered", "items": [
            "Executive summary — one page, written last, captures the entire plan in a way a busy client can read in three minutes",
            "Goals as stated — what the client said they wanted, in their words and prioritized order",
            "Current financial position — net worth, cash flow, key balances, current account titles",
            "Key observations — what the analysis revealed, organized by topic not by spreadsheet",
            "Recommendations — clear, prioritized, with rationale and tradeoffs explained",
            "Implementation plan — who does what by when",
            "Appendices — full statements, projections, Monte Carlo runs, disclosure documents"
          ]},
          {"type": "callout", "kind": "key", "content": "Lead with goals, end with action. Everything in between is supporting the path from one to the other."},
          {"type": "subheading", "content": "The one-page executive summary"},
          {"type": "paragraph", "content": "The executive summary is the most important page of the document and should be written last. It captures, in order: who the client is (one sentence), what they came to plan for, what you found, what you recommend, and what happens next. A client should be able to read the executive summary alone and know whether to read the rest. If the summary cannot stand alone, the plan is not yet finished."},
          {"type": "subheading", "content": "Visual hierarchy and white space"},
          {"type": "list", "items": [
            "One major idea per page — do not pack pages with multiple topics",
            "Headings at the top of pages, not floating in the middle",
            "Tables and charts captioned with the takeaway, not just the data ('Net worth has grown 32% over three years' beats 'Net worth over time')",
            "Reading text at 11-12pt minimum — older clients especially should not have to squint",
            "Black ink on white pages for most content; reserve color for emphasis and brand consistency"
          ]},
          {"type": "subheading", "content": "Plain language commitment"},
          {"type": "paragraph", "content": "Every word of jargon in a plan document is a small invitation for the client to feel stupid or to disengage. Both are bad outcomes. Sweep through any draft and replace: 'asset allocation' becomes 'how your money is split between stocks, bonds, and other things'; 'tax-deferred' becomes 'taxes due later, not now'; 'Roth conversion' becomes 'paying tax now to make a chunk of your retirement money tax-free later.' Use industry terms only after you have established the plain English meaning, and only where the term itself is part of what the client needs to learn."},
          {"type": "callout", "kind": "do", "content": "Read the draft aloud as if you were the client. If you stumble on a sentence, rewrite it. If a sentence requires you to pause and explain to yourself, the client will not understand it either."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Presentation Meeting — Structure and Flow",
        "summary": "A good plan presentation is not just reading the document out loud. It is a designed experience that builds understanding, surfaces reactions, and ends in clear commitment.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The plan presentation meeting is usually 60 to 90 minutes. The temptation is to walk page by page through everything you produced. Resist. The client does not need a tour of your work. They need to understand their situation, understand your recommendations, and arrive at the end of the meeting with clarity about what to do next."},
          {"type": "subheading", "content": "The flow"},
          {"type": "numbered", "items": [
            "Reset the room (5 min) — reconnect, remind them why you are here, restate goals as they stated them",
            "Walk the current position (10-15 min) — net worth, cash flow, where their money is today",
            "Surface key findings (15 min) — three to five observations from the analysis, in order of importance",
            "Present recommendations (20-30 min) — what to do, in priority order, with rationale and tradeoffs",
            "Discuss and react (10-15 min) — open the floor, hear questions and objections, adjust where needed",
            "Close with action (5-10 min) — what happens next, who owns each step, when you talk again"
          ]},
          {"type": "subheading", "content": "Reset the room"},
          {"type": "paragraph", "content": "Open with the client's own goals in their own words, read back from the discovery meeting. This grounds the conversation in why you are here. Clients will sit through 75 minutes of analysis if they feel the analysis is in service of what they actually want. They will tune out in five minutes if they feel the meeting is about the planner's process."},
          {"type": "subheading", "content": "Walk the current position"},
          {"type": "paragraph", "content": "Before you present recommendations, the client and you need to share a picture of where they are now. Use the financial statements from Module 13. Walk net worth, walk cash flow, point out the biggest line items. Ask 'does this look like your situation?' and pause for the answer. Catching a missing $14,000 credit card balance in this conversation is much cheaper than discovering it after recommendations have been made."},
          {"type": "subheading", "content": "Surface key findings"},
          {"type": "paragraph", "content": "After current position, share three to five findings from your analysis. Not twenty. Three to five. Examples: 'You are over-allocated to a single employer's stock through your RSUs.' 'Your beneficiary designations are stale from before you got married.' 'You are funding a 529 before maxing the match on your 401(k).' Each finding sets up a recommendation. Each one should be a clean sentence the client can repeat to their spouse later."},
          {"type": "callout", "kind": "key", "content": "Findings are not the recommendations. They are the observations that justify the recommendations. Separating them keeps the logic clean."},
          {"type": "subheading", "content": "Present recommendations in priority order"},
          {"type": "paragraph", "content": "Lead with the highest-impact, easiest-to-implement recommendation. Build momentum. A client who agrees to three things in the first ten minutes is more likely to agree to the harder recommendation that comes after. A client who hears the hardest recommendation first may dig in and refuse everything that follows. Sequence intentionally."},
          {"type": "subheading", "content": "Tradeoffs explicitly named"},
          {"type": "paragraph", "content": "Every recommendation costs something. Maxing the 401(k) means less cash flow now. Paying off the auto loan early means less in the brokerage. A Roth conversion means a tax bill this year. Name the tradeoff every time. Clients who hear only the benefits become suspicious, or worse, surprised later when they see the cost. Clients who hear benefits and tradeoffs trust the recommendation more, even when they decline it."},
          {"type": "case_study", "title": "Marcus and Tasha at the presentation meeting", "scenario": "The apprentice opens with their stated goals: pay down debt, build emergency fund, fund college, retire at 60. Walks current position — including the $14,000 credit card balance surfaced in discovery. Three findings: (1) the rate on the credit card is the highest-cost thing in their financial picture; (2) Marcus's 401(k) match is being left on the table; (3) the 529 was started before either of those was addressed. Three recommendations in order: redirect the 529 contribution temporarily, capture the full match, attack the credit card aggressively. Tradeoff named: 529 will fall a year behind plan, recoverable later. Marcus and Tasha agree to all three in 45 minutes. The fourth and harder recommendation — raising the savings rate by 3% — comes after they have already said yes three times.", "discussion": "Notice the order. Easy wins first, hard ask last. Notice the explicit tradeoff. Notice that the recommendations all trace back to findings, which all trace back to stated goals. The presentation is not a sales pitch. It is a logical chain the clients can follow and own."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Delivering Difficult News",
        "summary": "Sometimes the analysis says things the client does not want to hear. The skill of delivering hard news without breaking trust is what separates apprentices from counselors.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Some of the most important sentences in this work are uncomfortable to say. 'You will not be able to retire at the age you planned.' 'The way you have been managing taxes has cost you significant money.' 'Your current allocation cannot survive a major drawdown.' 'The spending level you are describing is not sustainable.' Saying these things clearly, kindly, and with the next step ready is part of the practice. Hiding from them is malpractice."},
          {"type": "subheading", "content": "The structure of a difficult-news conversation"},
          {"type": "numbered", "items": [
            "Signal that something hard is coming — 'I want to walk through one finding that I think will be the most important conversation we have today'",
            "Deliver the news cleanly — no hedging, no jargon, no minimizing",
            "Give the client a moment — silence is appropriate; do not rush to fill it",
            "Acknowledge the emotion — name what you observe ('this is a lot to take in')",
            "Move to options — 'here are the levers we can pull' — never deliver bad news without a path forward",
            "Invite the client to choose the path — they decide, not you"
          ]},
          {"type": "subheading", "content": "Do not minimize"},
          {"type": "paragraph", "content": "When delivering hard news, the temptation is to soften it: 'It is probably not as bad as it sounds' or 'lots of clients are in this position.' These phrases protect the planner's discomfort, not the client. They also make the client distrust the data. Say it cleanly. The client can handle truth. They cannot handle a counselor who flinches."},
          {"type": "subheading", "content": "Do not catastrophize either"},
          {"type": "paragraph", "content": "The opposite mistake is loading the news with urgency that is not warranted. 'You are in serious trouble' when the client has time to course-correct creates fear without information. Calibrate to the actual situation: how big is the gap, what is the time horizon, what levers exist?"},
          {"type": "subheading", "content": "Always have the next step ready"},
          {"type": "paragraph", "content": "Never deliver bad news without options for what to do about it. If you have to say 'you cannot retire at 60 on your current trajectory,' you should be ready immediately with: 'Here are the four things we could do — work two more years, raise savings by X, lower spending target by Y, or accept higher probability of needing to adjust mid-retirement. We do not have to decide today.' The path forward turns a verdict into a problem the client can solve with you."},
          {"type": "case_study", "title": "The retiree who is overspending", "scenario": "A 71-year-old client has been drawing 7.5% of her portfolio annually for the last four years. The Monte Carlo run shows a 35% probability the plan fails by age 88. The apprentice does not soften: 'I want to walk through what we found, because it is important. At your current spending rate, our analysis shows about a 35% chance the portfolio runs short before age 88. I do not want you to find that out at 85. Here is what we can do: adjust spending by about $1,200 a month, sell the second car and reduce insurance and fuel, downsize the home in the next two years, or some combination of these. We have time to decide. Which of these is hardest to hear?' The client says the second car. The apprentice explores it without judgment.", "discussion": "Notice the clarity, the options, the pause, the invitation. The client is not lectured. The client is informed and then asked. By the end of the meeting the client has chosen a path that reduces spending by $850 a month — drawing from two of the three levers. The plan now projects 91% probability of success. The hard news became a solvable problem."},
          {"type": "callout", "kind": "do", "content": "If you cannot bring yourself to say the hard thing, you cannot do this job. Practice the sentences. Say them out loud before the meeting if you have to. The client deserves someone who can deliver truth with care."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Handling Questions, Objections, and Emotional Reactions",
        "summary": "The middle of a plan presentation is where it earns its keep. Real questions surface. Real objections come up. Real feelings arrive. Handle them well and the plan gets implemented.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If the client asks no questions during your presentation, they either understand everything or they have stopped engaging. The second is more likely. Build pauses into the presentation explicitly. 'Before I move on, what questions are coming up?' 'How is this landing for you?' Silence is not agreement. Silence is data."},
          {"type": "subheading", "content": "Types of questions and how to handle them"},
          {"type": "glossary", "terms": [
            {"term": "Clarifying questions", "definition": "The client wants to make sure they understood. Answer plainly and check that the answer landed. 'Did that make sense, or do you want me to explain it differently?'"},
            {"term": "Stress-test questions", "definition": "The client is testing the recommendation. 'What if the market drops 40%?' 'What if I lose my job?' Welcome these. Run the scenario if the data supports it."},
            {"term": "Skeptical questions", "definition": "The client is not convinced. 'Why this and not that?' Take the question seriously. If you do not have a good answer, do not bluff. 'That is a good question, let me get you a better answer before we decide.'"},
            {"term": "Emotional questions disguised as logical ones", "definition": "'But what if I want to retire earlier?' is sometimes a math question and sometimes an underlying anxiety. Listen to which."},
            {"term": "Sourced-elsewhere questions", "definition": "'My brother-in-law says I should buy gold.' Acknowledge the source, address the substance gently, do not insult the brother-in-law."}
          ]},
          {"type": "subheading", "content": "When clients object"},
          {"type": "paragraph", "content": "Objections are not the end of the conversation. They are the beginning. An objection means the client is engaged enough to push back — which is better than a silent nod followed by no implementation. The move when you hear an objection: slow down, do not defend, ask one open question."},
          {"type": "list", "items": [
            "'Tell me more about what is bothering you about that recommendation'",
            "'What would have to be true for that to feel like the right move?'",
            "'Help me understand what you are weighing'",
            "'Is there a piece of this I have not addressed yet?'"
          ]},
          {"type": "subheading", "content": "Adjusting in real time"},
          {"type": "paragraph", "content": "Sometimes the client raises something that genuinely changes the recommendation. The right response is not to defend the original plan. The right response is to incorporate the new information. 'Given what you just told me, I want to walk back to the recommendation on the 529 and think differently about it.' This is not weakness. This is fiduciary work — the recommendation should match the facts, and the facts just changed."},
          {"type": "subheading", "content": "When emotions surface"},
          {"type": "paragraph", "content": "Plan presentations can trigger emotion. A client may cry talking about a parent's terminal illness that affects estate plans. A spouse may get angry at the other spouse mid-meeting. A retiree may grieve realizing they have to keep working two more years. None of this is unprofessional. All of it is part of the work. Slow down, acknowledge what you observe ('I can see this is a lot'), let them have the moment, and continue when they are ready. Offer water. Offer to pause and resume later. Do not pretend you did not notice."},
          {"type": "callout", "kind": "warn", "content": "Never make a recommendation feel like a sales close. 'So can we get this implemented today?' lands wrong in a fiduciary relationship. The client should feel like the decision is theirs and the timeline serves them, not you."},
          {"type": "case_study", "title": "Devon pushes back on the line of credit", "scenario": "After the equipment financing conversation, the apprentice recommends Devon establish a $150,000 business line of credit at his bank to address the cash protection need. Devon resists: 'I do not want to owe the bank anything.' The apprentice does not argue. 'Tell me more about that — what is the feeling about owing the bank?' Devon describes a childhood watching his uncle's restaurant fail under bank debt. The apprentice acknowledges the experience, then offers a reframe: 'A line of credit you do not draw on costs you a small annual fee but creates optionality. It is not the same as debt — it is access to debt only if you decide to use it. What would feel different if you knew you could decide later?' Devon stays skeptical. The apprentice does not push. 'Let us hold the line of credit idea for now and come back to it after we work through the next set of recommendations. There is no rush.'", "discussion": "The apprentice noticed the emotion behind the objection, honored it, offered information, and then let go of the close. Devon will think about it. He may agree in the next meeting. He may not. Either way, the relationship and the rest of the plan are not at risk."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing the Meeting — Action, Ownership, Next Date",
        "summary": "A plan that ends with 'we will follow up soon' is a plan that does not get implemented. Close every meeting with specifics so the client knows exactly what happens next.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The last ten minutes of the meeting matter as much as the previous eighty. This is where commitment turns into action — or where action quietly evaporates because nobody specified who does what by when. Treat the closing of the meeting as a separate section of the agenda with its own time block."},
          {"type": "subheading", "content": "The action list — every item has three things"},
          {"type": "numbered", "items": [
            "What — a specific, concrete task in plain language",
            "Who owns it — exactly one person, named",
            "By when — a specific date, not 'soon' or 'this month'"
          ]},
          {"type": "paragraph", "content": "Examples that work: 'Tasha will pull last year's tax return and email a PDF to me by November 8.' 'I will draft the beneficiary change forms for both IRAs and send them for your signature by November 15.' 'Marcus will increase the 401(k) contribution from 6% to 9% in the employer's portal by November 22.' Each item is unambiguous. Each item has a single owner. Each item has a date. The whole list lives at the bottom of the executive summary and in your CRM."},
          {"type": "callout", "kind": "do", "content": "Read the action list aloud at the end of the meeting and ask the client to confirm each item. 'Tasha, you have the tax return by the 8th — does that work?' If they hesitate, find a better date now, not later."},
          {"type": "subheading", "content": "Document the meeting"},
          {"type": "paragraph", "content": "Within 24 hours, send a written meeting recap to the client that includes: what was discussed, what was decided, the action list with owners and dates, and the next meeting date. This serves three purposes: it gives the client a written reference, it triggers the action list (the recap email is often what makes the client actually do their tasks), and it creates a record for compliance. The recap should be plain English. Not a transcript. A clear summary."},
          {"type": "subheading", "content": "Set the next date before you leave the room"},
          {"type": "paragraph", "content": "The single biggest predictor of whether action items get done is whether a follow-up meeting is on both calendars. 'We will check in once you have done those things' is too vague. 'Let us put 30 minutes on the calendar for December 10 to review where you got' is concrete. Schedule it before the current meeting ends. Send the invite from the room if needed."},
          {"type": "subheading", "content": "Quality check — would the client tell their friend?"},
          {"type": "paragraph", "content": "After the meeting ends, ask yourself: if this client called their best friend tomorrow and said 'I just had my plan presentation,' would they describe a clear set of decisions and a path forward, or would they describe a confusing meeting with a lot of charts? The first is the goal. If you cannot picture the friend conversation going well, the meeting was not closed properly. Improve the close next time."},
          {"type": "case_study", "title": "Closing with Marcus and Tasha", "scenario": "After the 75-minute presentation, the apprentice spends the final 10 minutes on the action list. Six items: (1) Marcus increases 401(k) to 9% by Nov 22 in Fidelity portal; (2) Tasha pulls last year's tax return and emails to apprentice by Nov 8; (3) Tasha sets up auto-transfer of $400 bi-weekly to high-yield savings account by Nov 15; (4) Both sign updated beneficiary change forms for IRAs once apprentice sends by Nov 15; (5) Apprentice prepares 529 contribution pause memo and emails by Nov 12; (6) Both review and approve the written plan and sign the IPS by Nov 30. Next meeting set for December 14 at 4pm to review progress. Recap email sent the next morning. Five of six items completed by next meeting.", "discussion": "Not because Marcus and Tasha were unusually disciplined — because the action list was unambiguous, the owners were assigned, the dates were specific, and the recap arrived in writing. The structure produced the outcome."},
          {"type": "callout", "kind": "key", "content": "The presentation meeting does not end with a plan. It ends with the next action. Always."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: implementation. The plan has been presented and agreed to. Now somebody has to actually move the money, file the paperwork, change the beneficiaries, and coordinate with the CPA and attorney. Implementation & Coordination."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The single best test for a plan document is:", "options": ["The number of pages it contains", "Whether it includes Monte Carlo projections", "Whether the client can read it alone six months later and understand their situation, recommendations, and next steps", "Whether it uses industry-standard terminology throughout"], "correct": 2, "explanation": "A plan document that requires the planner present to be understood has failed. The standalone readability test is the right standard."},
        {"id": "q2", "prompt": "In a plan presentation, recommendations should be sequenced:", "options": ["Hardest first to get them out of the way", "In random order to keep the client engaged", "In priority order, with high-impact easy wins first to build momentum", "Alphabetically"], "correct": 2, "explanation": "Building momentum with easy agreements early makes harder recommendations later more likely to be accepted. Sequence intentionally."},
        {"id": "q3", "prompt": "When delivering difficult news, the right structure includes:", "options": ["Soften the news so the client does not get upset", "Signal something hard is coming, deliver cleanly, give a moment, acknowledge emotion, move to options, let client choose", "Move quickly past the hard part to keep momentum", "Avoid the hard news if possible"], "correct": 1, "explanation": "The structure protects both clarity and care. Never deliver bad news without options for what to do next."},
        {"id": "q4", "prompt": "A client says 'lots of clients must be in worse shape than us.' The planner's best response is to:", "options": ["Agree to make the client feel better", "Avoid the comparison and refocus on the client's specific situation and the path forward", "Compare to specific other clients", "Drop the difficult finding"], "correct": 1, "explanation": "Comparing to others, either to comfort or alarm, distracts from the client's actual situation. Refocus on what the analysis shows and the options available."},
        {"id": "q5", "prompt": "Every action item in a plan close should have:", "options": ["A category and a color code", "What, who owns it, and a specific date", "An expected return", "A signature"], "correct": 1, "explanation": "Specific task, single owner, concrete date. Without all three, action items decay."},
        {"id": "q6", "prompt": "When a client raises an objection during presentation, the most effective first move is to:", "options": ["Defend the recommendation with more data", "Slow down, do not defend, and ask one open question about the objection", "Move to the next topic", "Lower the recommendation"], "correct": 1, "explanation": "Objections are engagement. Open questions explore the underlying concern. Defense usually makes objections harder, not softer."},
        {"id": "q7", "prompt": "The plan document's executive summary should be:", "options": ["Written first, before the analysis", "Written last and able to stand alone as a summary the client can read in a few minutes", "Three or more pages with all detail", "Optional"], "correct": 1, "explanation": "The executive summary is written last because it captures the entire plan. It should be standalone-readable for the busy client."},
        {"id": "q8", "prompt": "In delivering difficult news, never:", "options": ["Be specific about the magnitude", "Deliver bad news without ready options for what to do about it", "Pause for the client to react", "Acknowledge the emotion"], "correct": 1, "explanation": "Bad news without options creates fear without agency. Always have the next-step levers ready before you open the conversation."},
        {"id": "q9", "prompt": "The standard plan document structure leads with:", "options": ["Detailed investment performance tables", "The client's goals as stated in their own words", "Disclosure documents", "The planner's credentials"], "correct": 1, "explanation": "Leading with client goals grounds everything that follows in the reason the work was done. Goals first, action last."},
        {"id": "q10", "prompt": "Within how long should a meeting recap be sent to the client after the presentation?", "options": ["A week", "24 hours", "30 days", "Only if requested"], "correct": 1, "explanation": "Within 24 hours preserves the freshness of the conversation and triggers the action list while commitment is high."},
        {"id": "q11", "prompt": "Tradeoffs in recommendations should be:", "options": ["Mentioned only if the client asks", "Named explicitly every time, including what the recommendation costs", "Hidden so the recommendation is more appealing", "Discussed only in the appendix"], "correct": 1, "explanation": "Naming the tradeoff every time builds trust and prevents surprises. Clients who hear both benefits and costs make better decisions and trust the counselor more."},
        {"id": "q12", "prompt": "If a client cries or shows strong emotion during a plan presentation, the right response is to:", "options": ["Pretend you did not notice and continue", "End the meeting immediately", "Slow down, acknowledge what you observe, let them have the moment, and continue when they are ready", "Tell them to stay focused on the numbers"], "correct": 2, "explanation": "Emotion is part of the work, not a disruption to it. Acknowledge gently, hold the moment, and continue when they are ready."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 16;

-- ── module17_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 17 CONTENT
-- Implementation & Coordination
-- ============================================================================
update public.modules set
  title = 'Implementation & Coordination',
  competency_id = 'OJL-8',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Move from agreed plan to executed plan — opening accounts, transferring assets, coordinating with the CPA and attorney, and tracking every moving piece without dropping any of them.',
  learning_objectives = ARRAY[
    'Sequence implementation steps in the right order to avoid avoidable mistakes',
    'Execute account opens, transfers, and rollovers cleanly',
    'Coordinate with external professionals — CPA, estate attorney, insurance broker',
    'Track implementation status across multiple workstreams without dropping items',
    'Recognize when an implementation step is going wrong and intervene early'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Implementation Is Where Plans Die",
        "summary": "Excellent plans that never get implemented are common. The implementation phase is operational, detail-heavy, and where most relationships either prove their value or quietly fail.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most clients who switch advisors do so not because the previous advisor gave bad advice but because the previous advisor never finished implementing the advice they gave. The plan landed in a binder. The action items decayed. The beneficiary update never happened. The 401(k) increase was set up incorrectly. The Roth conversion the client agreed to was never executed before year-end. Implementation is unglamorous, repetitive, deadline-driven work — and it is the work that determines whether the plan was real."},
          {"type": "callout", "kind": "key", "content": "A plan is not a recommendation. A plan is a sequence of completed actions. Until each action is done and documented, the plan is aspirational."},
          {"type": "subheading", "content": "Why implementation breaks down"},
          {"type": "list", "items": [
            "Too many items moving at once with no master list and no owner per item",
            "Sequence errors — a step happens before its prerequisite is done, creating rework",
            "Hand-offs without confirmation — assuming the client did their part, or the custodian processed the form, without verifying",
            "External professionals not looped in or looped in too late",
            "Tax deadlines missed because the calendar was not respected"
          ]},
          {"type": "subheading", "content": "The implementation tracker"},
          {"type": "paragraph", "content": "Every client should have a single implementation tracker — a document or CRM record listing every action item, owner, status, and completion date. This is not the action list from the presentation meeting. That list seeded the tracker. The tracker grows as the work surfaces sub-items (the beneficiary form needs notarization; the rollover requires a Letter of Acceptance from the receiving custodian; the Roth conversion has to happen before December 31 and after the client's CPA confirms the year's marginal bracket). The tracker is reviewed at every internal review of the relationship and updated weekly while implementation is active."},
          {"type": "subheading", "content": "Status discipline"},
          {"type": "paragraph", "content": "Each item on the tracker has a status. Useful states: Not Started, In Progress (with sub-state), Waiting On Client, Waiting On Custodian, Waiting On External Pro, Complete, Blocked. The 'Waiting On' states are the danger zones — items in 'Waiting On Client' for three weeks need a follow-up. Items in 'Waiting On Custodian' for ten business days need an escalation. The status is not just a label. It is a trigger for a specific next action."},
          {"type": "callout", "kind": "warn", "content": "An item that has been 'In Progress' for more than two weeks without sub-state explanation is almost always actually stuck. Investigate. Things do not unstick themselves."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Sequencing — What Has to Happen Before What",
        "summary": "Some implementation tasks have dependencies. Doing them out of order creates rework, missed deadlines, and avoidable client confusion. Learn the common sequences.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The order of implementation matters as much as the items themselves. A few classic sequence rules — break them and you create avoidable problems."},
          {"type": "subheading", "content": "Account opens before transfers"},
          {"type": "paragraph", "content": "If a recommendation involves transferring assets from one custodian to another, the receiving account has to exist before the transfer can be initiated. Sounds obvious. Gets missed routinely when the transfer paperwork goes out before the receiving account has been fully funded with its initial deposit and is in 'active' status. Open the account, fund it with a small initial deposit if required, confirm active status, then initiate the transfer."},
          {"type": "subheading", "content": "Beneficiaries updated immediately when accounts open"},
          {"type": "paragraph", "content": "Every new account — IRA, Roth, 401(k), brokerage, life insurance — has a beneficiary designation. Default beneficiary is usually 'estate' if you do not designate, which is the worst outcome for almost every client. Update beneficiaries the same day the account opens. Do not wait. People die unexpectedly. Beneficiaries trump wills. This is one of the most important and most neglected items in implementation."},
          {"type": "callout", "kind": "do", "content": "On every new account opened, the same-day checklist includes: beneficiaries designated, contingent beneficiaries designated, beneficiary percentages add to 100%, transfer-on-death (TOD) registration on taxable accounts where appropriate, and the client has a copy of the confirmed designation."},
          {"type": "subheading", "content": "Tax-aware sequencing within the calendar year"},
          {"type": "list", "items": [
            "Roth conversions should happen as early in the year as you can confirm the year's bracket, or as late as you can with enough lead time to settle before December 31",
            "Required Minimum Distributions (RMDs) must complete by December 31 (with the first one optionally by April 1 of the year after the client turns 73)",
            "Mega-backdoor Roth in-plan conversions are typically annual or per-pay-period; align with the plan's rules",
            "Tax-loss harvesting is most relevant in volatile years and must complete before December 31 with attention to wash-sale rules (30 days before or after)",
            "Charitable contributions — DAF funding, QCDs from IRAs — must complete and clear by December 31 to count for that tax year"
          ]},
          {"type": "subheading", "content": "Rollovers — direct vs indirect"},
          {"type": "paragraph", "content": "When moving money between retirement accounts — say a 401(k) at a former employer to an IRA — the direct rollover (also called a trustee-to-trustee transfer) is almost always the right choice. The check, if any, is made payable to the receiving custodian for benefit of the client. No tax withholding. No 60-day clock. An indirect rollover — where the check is made payable to the client and the client has 60 days to redeposit — triggers mandatory 20% federal tax withholding on pre-tax balances and requires the client to come up with that 20% from their own pocket to complete the full rollover. The IRS one-rollover-per-12-months rule also restricts indirect rollovers. Avoid indirect rollovers unless there is a specific reason."},
          {"type": "callout", "kind": "warn", "content": "If a rollover check arrives at the client's house made payable to the client, it is an indirect rollover. Stop the implementation, document the situation, and call the sending custodian to reissue properly. Depositing the check to the client's checking account starts the 60-day clock and the tax consequences. Time is of the essence."},
          {"type": "subheading", "content": "Insurance changes — apply before canceling"},
          {"type": "paragraph", "content": "If a client is replacing one insurance policy with another, the new policy must be issued and in force before the old policy is canceled. Otherwise the client may end up uninsured during the gap, or worse, develop a health condition that makes them uninsurable at the new policy. This is so basic it gets violated routinely. Issued, in force, premiums paid on the new policy — only then cancel the old."},
          {"type": "case_study", "title": "The rollover that took six weeks instead of two", "scenario": "An apprentice initiates a 401(k) rollover from a client's former employer to an IRA at the new custodian. The receiving IRA was opened but had no initial deposit. The former employer's plan custodian processed the rollover request, generated a check, and held it pending receipt of the new account being active. Two weeks later, nothing had happened. The apprentice discovered the receiving account was sitting in 'pending funding' status. They made a $25 initial deposit to activate the account, which took another four business days to clear. The rollover check was finally issued — but to the wrong address because the new custodian's record had a typo from the original form. Total elapsed time: six weeks. Avoidable.", "discussion": "Two errors compounded: not funding the receiving account at open, and not double-checking address fields on the receiving paperwork. Both are one-minute checks that prevent multi-week delays. Implementation is detail work. The details matter."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Coordinating With External Professionals",
        "summary": "Tax planning lives at the CPA. Estate planning lives at the attorney. Insurance lives at the broker. You orchestrate. Doing it well means clear hand-offs and shared records.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most clients have a roster of professionals — financial advisor, CPA or tax preparer, estate attorney, insurance broker, sometimes a business attorney or a banker. Each of these professionals has expertise the financial advisor does not have and authority over decisions the advisor cannot make. Implementation usually requires getting work done across this roster, with the client in the center and the advisor often as the coordinator."},
          {"type": "subheading", "content": "Get authorization first"},
          {"type": "paragraph", "content": "Before reaching out to a client's CPA or attorney, you need the client's written authorization to communicate with that professional. Most firms have a 'Authorization to Release Information' form for this. Without it, the CPA cannot legally discuss the client's tax situation with you, and the attorney cannot share estate documents. Get the authorization signed early in the relationship for everyone the client wants in the loop. It saves weeks of friction later."},
          {"type": "subheading", "content": "Working with the CPA"},
          {"type": "list", "items": [
            "Send the CPA a written summary of any tax-relevant moves before executing — Roth conversion, harvesting transaction, sizable charitable contribution, distribution from an inherited IRA",
            "Ask the CPA to confirm the projected tax impact in writing before you execute",
            "After execution, send the CPA the confirmation and 1099 reporting details",
            "Coordinate timing — March through April the CPA is unreachable; do not plan major moves with a tax deadline in tax season",
            "Year-end planning conversations should happen in October or early November, not December"
          ]},
          {"type": "subheading", "content": "Working with the estate attorney"},
          {"type": "list", "items": [
            "Estate documents — will, revocable trust, durable power of attorney, healthcare directive — usually need to be reviewed every 3-5 years or after any major life event",
            "When the attorney updates documents, request copies of the executed final versions for your file",
            "Beneficiary designations on retirement accounts and life insurance often need to be coordinated with the trust structure; do not assume the attorney did this — verify",
            "Account titling matters as much as beneficiaries; if the attorney recommends retitling assets into a trust, track which accounts are completed",
            "Be explicit about who is responsible for funding the trust — the attorney may draft the trust but funding is often the client's or advisor's responsibility"
          ]},
          {"type": "subheading", "content": "Working with the insurance professional"},
          {"type": "paragraph", "content": "If the client uses a separate insurance broker — common — coordinate on policy changes carefully. Beneficiary changes on life insurance need to match the estate plan. Disability and long-term care coverage assumptions in the financial plan need to match the actual policy terms (which the insurance broker has). Annuity decisions in particular benefit from a three-way conversation between client, advisor, and insurance broker so the client is not navigating product complexity alone."},
          {"type": "subheading", "content": "Shared documentation"},
          {"type": "paragraph", "content": "When professionals coordinate, share the relevant documents — with client consent — in a single shared folder or via direct exchange. Avoid forwarding chains. Avoid attaching documents the client did not approve to share. Each professional should be working from the same numbers; if estate plan projections are using one net worth figure and the financial plan is using a different one, decisions get made on inconsistent data."},
          {"type": "case_study", "title": "The Roth conversion that needed three people", "scenario": "A client wants to convert $80,000 from a Traditional IRA to a Roth in October. The financial advisor's apprentice runs the projection and identifies $80,000 as the amount that fills the 24% bracket without spilling into 32%. Before executing, the apprentice emails the client's CPA with the calculation. The CPA replies — appreciates the math, notes the client also has a large planned bonus arriving in November that will push the bracket boundary down by about $14,000. Revised conversion: $66,000. The apprentice updates the projection, gets the client's written approval for the new figure, executes the conversion in October. The 1099-R goes to the CPA in January. Tax filed cleanly.", "discussion": "Without the CPA loop, the apprentice would have over-converted by $14,000, generating an avoidable tax bill in the 32% bracket and a frustrated client. The CPA's information existed; the apprentice's coordination unlocked it. Coordination is not an extra step — it is part of the recommendation."},
          {"type": "callout", "kind": "key", "content": "If a recommendation has tax implications and you have not talked to the CPA, you have not finished the recommendation. If it has estate implications and you have not coordinated with the attorney, you are working blind."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "The Operational Mechanics — Forms, Signatures, Custodian Workflows",
        "summary": "The day-to-day of implementation is paperwork, signatures, and custodian-specific quirks. Knowing what each step actually requires saves time and prevents errors.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Every custodian — Schwab, Fidelity, Pershing, Goldman Sachs Custody Solutions, others — has its own forms, its own workflows, its own quirks. Multiply this by the dozens of operational tasks in a typical client relationship and the operational load gets significant. Master the basic toolkit and you can navigate any custodian's specifics."},
          {"type": "subheading", "content": "Common forms an apprentice will handle"},
          {"type": "glossary", "terms": [
            {"term": "New account application", "definition": "Opens a new account with the custodian. Requires identity verification (KYC), investment objectives, risk tolerance, source of funds, and signed agreements."},
            {"term": "ACAT transfer", "definition": "Automated Customer Account Transfer Service. The industry standard for transferring securities between brokerage accounts. Typically 5-10 business days."},
            {"term": "Letter of Acceptance (LOA)", "definition": "Document from the receiving custodian confirming they will accept the transfer. Required for some non-standard transfers."},
            {"term": "TOD (Transfer on Death) registration", "definition": "Allows a taxable account to pass directly to a named beneficiary outside probate."},
            {"term": "Beneficiary designation form", "definition": "Names primary and contingent beneficiaries for retirement accounts and insurance products. Must specify percentages totaling 100% within each category."},
            {"term": "Standing instruction / Letter of Authorization", "definition": "Allows recurring transfers or specific authority. Some are good only for one occurrence; some are durable."},
            {"term": "W-9 / W-8BEN", "definition": "Tax certification forms. W-9 for U.S. persons, W-8BEN for non-U.S. persons."},
            {"term": "Distribution form", "definition": "Authorizes a distribution from a retirement account. Specifies amount, tax withholding, payment method."}
          ]},
          {"type": "subheading", "content": "Signature mechanics"},
          {"type": "paragraph", "content": "Most custodians now accept e-signature via DocuSign or equivalent. A few specific forms still require wet signature or notarization — older life insurance policies, certain bank accounts, some retirement plan beneficiary changes when the client is married and the spouse must consent. Know which forms in your firm's typical workflow require wet signature or notarization, and warn the client at the start so they are not surprised by a notary trip."},
          {"type": "subheading", "content": "Spousal consent — easy to miss, expensive when missed"},
          {"type": "paragraph", "content": "Qualified retirement plans (ERISA 401(k)s, profit-sharing plans) require spousal consent for non-spouse beneficiary designations and certain distribution choices. The spouse's signature must be witnessed by a plan representative or notarized. Miss this step and the designation may not be valid. IRAs are not subject to the same federal spousal consent rule (though community property states have their own treatment). Know the rules that apply to the specific account type."},
          {"type": "subheading", "content": "Standard quality checks before submission"},
          {"type": "list", "items": [
            "All required fields completed — no blanks the custodian will reject the form for",
            "Date is current — most forms have a 30-90 day shelf life from signature date",
            "Account numbers match the actual accounts on the custodian's system, not a typo",
            "Dollar amounts and percentages internally consistent — 60/40/0 adds to 100, not 100 with a 5 hiding somewhere",
            "Names spelled exactly as on the account — Robert vs Bob, middle initial vs not",
            "Notary block completed if required — notary's signature, seal, expiration date all present"
          ]},
          {"type": "callout", "kind": "do", "content": "Have a second person on the team review any consequential form before submission. Two sets of eyes catch errors one set misses. The marginal time cost is minutes. The cost of a rejected form is days."},
          {"type": "case_study", "title": "The beneficiary form that did not count", "scenario": "An apprentice helps a client update the beneficiary on a 401(k) from 'estate' to 'spouse 100%.' The form is signed by the client and submitted. Three months later when the apprentice does a routine review, they pull up the plan portal and notice the designation still shows 'estate.' On investigation: the plan's beneficiary form requires spousal consent for the change to be valid, and the spousal consent line was blank. The plan administrator processed the form as 'incomplete — no change recorded' but did not notify the apprentice or client. The original beneficiary remained in effect.", "discussion": "Two failures: the form was submitted without spousal consent that was required, and the plan administrator's silent rejection was not detected because nobody verified the change took effect. Process fix: any consequential designation change should be confirmed by pulling the post-change record from the source system within a week of submission. Trust but verify."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing the Loop — Confirming Everything Actually Happened",
        "summary": "Submission is not completion. The implementation phase ends only when every action has been verified on the source system and documented. Closing the loop is the discipline that separates working plans from theatrical ones.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An apprentice's instinct is to mark an action 'done' when they submit it. The correct discipline is to mark it 'done' only when verified — when the change has appeared in the actual source system, when the beneficiary shows correctly in the plan portal, when the rollover has settled in the receiving account at the right amount, when the form has been processed by the custodian rather than rejected, when the trust has been funded with the asset rather than just listed in the trust document. Trust the system once. Verify the system always."},
          {"type": "subheading", "content": "Verification practices for common tasks"},
          {"type": "list", "items": [
            "Account opening — pull the new account record and confirm: title is correct, registration matches, beneficiaries are populated, all features (TOD, check-writing, debit access) are configured as intended",
            "Asset transfer — confirm the dollar amount that arrived matches what was sent (within reasonable cost-basis transfer accuracy); review the cost basis on transferred securities for accuracy",
            "Beneficiary change — pull the post-change designation page and confirm the new beneficiaries are present at the correct percentages",
            "Contribution change — confirm the change is reflected in the next pay period or contribution cycle, not just in the request",
            "Distribution — confirm the dollar amount received matches the requested amount and withholding; confirm tax withholding was correctly applied",
            "Roth conversion — confirm the converted amount left the traditional account and arrived in the Roth, with the correct tax-year coding for reporting"
          ]},
          {"type": "subheading", "content": "Document everything"},
          {"type": "paragraph", "content": "Every implementation action generates an artifact — a confirmation number, a screenshot, an email, a paper statement. File each one in the client folder with a date and a short description. This is not paranoia. This is the audit trail that protects the client and the firm if a question arises a year or five years later. 'I submitted that change' is not a defensible statement. 'Here is the confirmation showing the change was made on March 14 at 11:42am' is."},
          {"type": "subheading", "content": "Communicate completion to the client"},
          {"type": "paragraph", "content": "When an action is verified complete, tell the client. A simple email — 'The Roth conversion of $66,000 was completed on October 12; you will receive a 1099-R from the custodian in January. The CPA has been copied' — gives the client confidence that the work is happening and creates a record they can refer back to. The cumulative effect of these small communications is enormous over the course of a year. Clients who hear from their advisor about completed work feel taken care of. Clients who never hear anything assume nothing is happening."},
          {"type": "subheading", "content": "The implementation review at the end"},
          {"type": "paragraph", "content": "Once the implementation phase of a new plan or a major change is complete, hold a brief internal review: did every action item complete, what took longer than expected, what surfaced unexpected complications, what should we do differently next time. This is not a long meeting. Twenty minutes. The point is to keep getting better at the operational work, which compounds across hundreds of clients over a career."},
          {"type": "case_study", "title": "Closing out Marcus and Tasha's first 90 days", "scenario": "Of the six action items from the presentation meeting, five completed within the target dates. The sixth — the auto-transfer setup for $400 bi-weekly — was set up but the initial transfer date was set to the wrong day, missing the first paycheck cycle. The apprentice caught it because they had a tracker item to verify the first transfer hit. They corrected the date, the second cycle ran clean, and they emailed Tasha to confirm. Six of six items now verified complete. The apprentice writes a one-page summary for the client: what was done, current state of accounts, next review date.", "discussion": "Without the verification step, the missed first transfer would have surfaced months later as 'wait, we have less in the emergency fund than I expected.' The discipline of confirming each action on the source system caught the error within days. The summary email also doubled as a touchpoint that reinforced the client relationship."},
          {"type": "callout", "kind": "key", "content": "Implementation ends when verified, not when submitted. The verification habit, more than any other operational skill, separates apprentices who become trusted counselors from those who stay junior forever."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: the relationship does not end with implementation. Ongoing reviews, life events, and the long-term cadence of the planning relationship."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "An action item should be marked complete when:", "options": ["The form was submitted", "The client confirmed they did their part", "The change has been verified on the source system", "The follow-up meeting is scheduled"], "correct": 2, "explanation": "Submission is not completion. Verification on the actual system the change affects is the only valid completion signal."},
        {"id": "q2", "prompt": "On a new account, beneficiary designations should be:", "options": ["Updated within 30 days of opening", "Updated at the next annual review", "Updated the same day the account opens, with primary and contingent beneficiaries both designated", "Optional — wills cover everything"], "correct": 2, "explanation": "Beneficiaries trump wills. Default beneficiary on most accounts is 'estate,' which is the worst outcome. Update same-day, always."},
        {"id": "q3", "prompt": "Direct rollover versus indirect rollover — the direct rollover is preferred because:", "options": ["It is faster", "It avoids mandatory 20% tax withholding and the 60-day redeposit risk", "It costs less", "It is required by law"], "correct": 1, "explanation": "Direct rollovers move funds custodian-to-custodian without withholding and without the 60-day clock. Indirect rollovers trigger 20% mandatory federal withholding on pre-tax balances."},
        {"id": "q4", "prompt": "Before reaching out to a client's CPA to discuss their tax situation, you need:", "options": ["The CPA's business card", "Written authorization from the client to communicate with the CPA", "The client's verbal okay on the phone", "Nothing — CPAs can always discuss their clients"], "correct": 1, "explanation": "Written authorization (Authorization to Release Information) is required. Without it, the CPA legally cannot discuss the client's tax situation with you."},
        {"id": "q5", "prompt": "When replacing one insurance policy with another, the correct sequence is:", "options": ["Cancel the old policy first to save money during application", "Apply for the new policy, get it issued and in force with premiums paid, then cancel the old", "Submit both simultaneously", "Let the policies overlap for at least six months"], "correct": 1, "explanation": "Never leave the client uninsured during a gap. The new policy must be issued and in force before the old policy is canceled."},
        {"id": "q6", "prompt": "A Roth conversion intended for the current tax year must be completed:", "options": ["By April 15 of the following year", "By the client's tax filing deadline", "Before December 31 of the conversion year", "Within 60 days of starting the process"], "correct": 2, "explanation": "Roth conversions count for the tax year in which the conversion completes — funds must leave the traditional IRA and arrive in the Roth before December 31."},
        {"id": "q7", "prompt": "Qualified ERISA retirement plans like 401(k)s require spousal consent for:", "options": ["All distributions of any size", "Non-spouse beneficiary designations and certain distribution choices, with the spouse's signature witnessed or notarized", "Account opening", "Investment changes"], "correct": 1, "explanation": "ERISA spousal consent applies to non-spouse beneficiary designations and certain distribution elections. Missing the consent invalidates the change."},
        {"id": "q8", "prompt": "Implementation status of 'Waiting On Custodian' for ten business days should trigger:", "options": ["Continued patience", "Escalation — something is likely stuck and needs follow-up", "Automatic reassignment to another team member", "Marking the item complete"], "correct": 1, "explanation": "Items do not unstick themselves. Ten business days of waiting on a custodian is the threshold to escalate and find out what is blocking."},
        {"id": "q9", "prompt": "The Letter of Acceptance (LOA) is used in implementation to:", "options": ["Confirm a client's identity", "Document that the receiving custodian will accept a non-standard transfer", "Authorize standing instructions", "Acknowledge fee disclosures"], "correct": 1, "explanation": "An LOA from the receiving custodian confirms they will accept the inbound transfer, especially for non-standard assets or registrations."},
        {"id": "q10", "prompt": "Year-end tax planning conversations with the CPA should ideally happen:", "options": ["In December, just before deadlines", "In October or early November, before tax season pressure", "In April after returns are filed", "Anytime in the year"], "correct": 1, "explanation": "October/early November leaves enough time to execute moves before December 31 and avoids the March-April CPA unavailability."},
        {"id": "q11", "prompt": "If a rollover check arrives at the client's house made payable to the client, the right move is to:", "options": ["Deposit it to the client's checking account immediately", "Stop, document, and call the sending custodian to reissue the check made payable to the receiving custodian for the benefit of the client", "Cash it and use the proceeds for the rollover", "Hold it for 60 days"], "correct": 1, "explanation": "A check payable to the client is an indirect rollover. Reissue properly as a direct rollover to avoid the 20% withholding and 60-day clock."},
        {"id": "q12", "prompt": "The post-implementation review with the team should focus on:", "options": ["Assigning blame for any items that took longer than expected", "Identifying what surfaced unexpected complications and what to do differently next time", "Renegotiating client fees", "Marketing the firm's services"], "correct": 1, "explanation": "The review is a process improvement exercise — capture what surfaced, what slowed things down, and what should change going forward. Operational learning compounds across hundreds of clients."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 17;

-- ── module18_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 18 CONTENT
-- Ongoing Reviews & Life Events
-- ============================================================================
update public.modules set
  title = 'Ongoing Reviews & Life Events',
  competency_id = 'OJL-9',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Move from a one-time plan to a continuing relationship — building a review cadence, watching for life events that change the plan, and adapting without losing continuity.',
  learning_objectives = ARRAY[
    'Design a review cadence that matches client complexity and stage of life',
    'Lead an effective annual review that surfaces what has changed and what should change',
    'Recognize the life events that require plan changes — and the ones that do not',
    'Handle estate-relevant life events (death, divorce, disability) with care and competence',
    'Maintain continuity in the relationship across years and transitions'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "From One-Time Plan to Continuing Relationship",
        "summary": "The first 90 days deliver the plan. The next thirty years deliver the value. Building a relationship structure that lasts is the real work.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Financial planning is not a project with an end date. It is a relationship that lasts decades. The plan you build in year one is a snapshot. The plan that actually serves the client is the moving body of work that adapts as their life changes — new jobs, marriages, divorces, children, inheritances, business sales, health events, deaths. The counselor who sees clients only once a year and produces an annual report has built a thin relationship. The counselor who has rhythm with the client across the year, knows what is coming, and adapts as life happens has built something different."},
          {"type": "callout", "kind": "key", "content": "Plans do not fail because the math was wrong. Plans fail because life changed and nobody updated the plan."},
          {"type": "subheading", "content": "The continuing relationship has structure"},
          {"type": "paragraph", "content": "A well-structured ongoing relationship has at least three components: a scheduled review cadence (annual at minimum, more often for complex clients), trigger-based touchpoints (calls or meetings when something material changes), and ambient communication (regular brief updates, market context when warranted, year-end planning reminders). The cadence is set at the start and adjusted as the client's situation evolves. A 35-year-old accumulator with a stable W-2 does not need the same cadence as a 68-year-old business seller in transition."},
          {"type": "subheading", "content": "Typical cadences by client stage"},
          {"type": "list", "items": [
            "Early accumulator (20s-30s, simple situation) — annual review, ad hoc check-ins around major decisions",
            "Mid-career complex (40s-50s, multi-account, business owner, or pre-retirement) — semi-annual reviews, quarterly informal touch",
            "Pre-retirement (3-5 years before retirement) — semi-annual reviews with explicit retirement countdown, more frequent in the final year",
            "Recently retired (first 5 years) — semi-annual reviews to dial in the withdrawal strategy as it meets reality",
            "Mature retirement (steady-state) — annual review, more often if health or longevity events are surfacing",
            "Transition periods (divorce, business sale, recent widow/widower) — weekly to monthly for the duration of the transition, then taper"
          ]},
          {"type": "subheading", "content": "Cadence is not the same as 'check the boxes'"},
          {"type": "paragraph", "content": "An annual review that consists of a custodian-generated performance report and twenty minutes of small talk is not a review. It is theater. A real review surfaces what has changed in the client's life, what has changed in the plan, what needs to change going forward, and what the client should expect over the next year. If you cannot answer 'what did we accomplish in that meeting' with three specific things, the meeting was not used well."},
          {"type": "subheading", "content": "Building the relationship account"},
          {"type": "paragraph", "content": "Every interaction with a client is a small deposit or withdrawal from the relationship. Calls returned promptly are deposits. Forgotten birthdays of the client's children that the client mentioned years ago are withdrawals. Remembered details — the client's recent surgery, the kid who started college, the parent who passed — are large deposits. The cumulative effect over a decade is the difference between a counselor the client describes as 'my advisor who manages my money' and one they describe as 'someone I trust completely with everything.'"},
          {"type": "callout", "kind": "do", "content": "After every client interaction, take 60 seconds and add one or two human details to the CRM. The client's golden retriever's name. The kid's college. The travel plans they mentioned. A year from now you will remember to ask, and that question will be the most important thing you do that meeting."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Annual Review — Structure, Preparation, Execution",
        "summary": "An annual review well-led is more valuable than the first plan that produced it. Here is how to do one that actually moves the relationship and the plan forward.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The annual review is the most important single meeting in most client relationships. It is the moment where the past year is reckoned with and the next year is shaped. Done well, it generates clarity, surfaces issues early, and produces a refreshed action list. Done poorly, it becomes a perfunctory 'everything is on track' that papers over the actual situation."},
          {"type": "subheading", "content": "Preparation — what you do before the meeting"},
          {"type": "numbered", "items": [
            "Pull current financial statements — updated net worth and cash flow",
            "Run a fresh projection — has the trajectory changed from last year's expectations?",
            "Review the action items from the last meeting — what was done, what slipped, what is still open",
            "Review any communications during the year — what did the client tell you about that should inform the review?",
            "Pull any data the client may have shared — recent tax return, salary changes, new debts, life events",
            "Scan the markets and the macro — what context might the client be carrying into the meeting?",
            "Note any compliance, tax, or law changes that affect the client"
          ]},
          {"type": "subheading", "content": "Open the meeting on a personal note"},
          {"type": "paragraph", "content": "Do not lead with 'let me walk through your performance.' Lead with the client. 'How was your year overall — what stands out?' This opens space for the things you need to know about (a new job, a parent's illness, a kid's surprise college acceptance) that may not have surfaced in routine touches. Spend the first ten minutes here. If something significant has happened, you will need to restructure the rest of the meeting around it. Better to know early."},
          {"type": "subheading", "content": "The five-section agenda"},
          {"type": "numbered", "items": [
            "What changed for you this year? (10 min) — personal, professional, family, health",
            "Where you are now (10 min) — net worth, cash flow, progress against goals",
            "Did the plan do what it was supposed to? (15 min) — performance, withdrawals, savings, projections",
            "What needs to change for next year? (15 min) — recommendations driven by what was surfaced",
            "Action items and next meeting (10 min) — owners, dates, follow-up"
          ]},
          {"type": "subheading", "content": "Did the plan do what it was supposed to?"},
          {"type": "paragraph", "content": "This section is not 'how did the market do.' It is 'how did the plan do.' The plan was designed to accomplish certain things — fund savings, hit certain account balances, provide a certain income, maintain a certain risk level. Walk through whether each expected thing happened. If the client was supposed to save $24,000 to the IRA and Roth IRA combined and only $18,000 was saved, that is the conversation, not the S&P 500's return. Performance matters — but in context of the plan, not in isolation."},
          {"type": "subheading", "content": "What needs to change for next year?"},
          {"type": "paragraph", "content": "Based on what surfaced in sections 1 and 2 and what worked or did not work in section 3, make specific recommendations for the next year. Sometimes there are none — the plan is on track, the client's life is stable, the right move is to keep doing what is working. Sometimes there are many — a new job changes contribution capacity, a paid-off mortgage frees cash flow, a child's college is now four years closer. Whatever the recommendations, they should trace back to what was discussed in the meeting, not appear from nowhere."},
          {"type": "case_study", "title": "Marcus and Tasha's first annual review", "scenario": "One year after the initial plan presentation. Marcus and Tasha sit down with their apprentice for the annual review. The personal opening surfaces: Tasha's mother had a stroke six months ago — Tasha has been her caregiver and the family has spent ~$8,000 on home modifications and medical equipment. The financial section: credit card paid off, emergency fund at $7,200 (target was $9,000 — caregiving costs slowed progress), 401(k) contribution at 9% as planned, 529 still paused. Plan section: progress is real but slower than projected. Recommendations: continue paused 529 for another six months, hold emergency fund target steady (do not push to $12,000 yet), discuss long-term care planning for Tasha's mother as a separate workstream, surface the question of how the mother's care affects retirement timing.", "discussion": "Without the personal opening, the apprentice would have walked through numbers and recommended raising the 529 contribution — completely missing that Tasha is providing meaningful family caregiving. The recommendation set is now responsive to the actual life the clients are living, not to the spreadsheet."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Recognizing Life Events That Change the Plan",
        "summary": "Some life events require plan changes. Some do not. Knowing which is which — and acting promptly when one does — is core counselor judgment.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Life events fall on a spectrum. At one end are events that fundamentally change the plan: marriage, divorce, the birth of a child, death of a spouse, a major inheritance, a business sale, a significant disability, retirement itself. At the other end are events that feel big in the moment but do not actually require plan changes — a normal market drawdown, a missed bonus, a friend's bad financial advice. Calibrating which is which is judgment. Acting promptly when a real life event happens is non-negotiable."},
          {"type": "subheading", "content": "Major life events and what they typically require"},
          {"type": "glossary", "terms": [
            {"term": "Marriage", "definition": "Beneficiary review across all accounts, estate document update (will, POAs, healthcare directives), tax filing status review, insurance review (spouse covered, life insurance amounts), potential consolidation of accounts."},
            {"term": "Divorce", "definition": "QDRO for retirement plan division, beneficiary updates urgent, new will/trust, separate accounts re-established, cash flow reset for new household, often a year of close support."},
            {"term": "Birth/adoption of a child", "definition": "529 plan considered, life insurance review (term coverage often increases), guardian designation in will, possibly umbrella liability coverage."},
            {"term": "Death of a spouse", "definition": "Surviving-spouse rollovers, beneficiary cash flow assessment, Social Security survivor planning, estate administration, often six to twelve months of intensive support and decisions deferred where possible."},
            {"term": "Major inheritance", "definition": "Step-up basis valuation if inherited assets, qualified vs non-qualified inherited accounts each have own rules (SECURE Act 10-year window for most non-spouse inherited retirement accounts), tax planning urgent, behavioral support around the money."},
            {"term": "Business sale", "definition": "Tax planning (QSBS Section 1202, installment sales, earnouts), wealth management transition from concentrated business owner to diversified investor, estate planning review, often a multi-year project."},
            {"term": "Disability", "definition": "Disability insurance benefits coordination, Social Security disability if applicable, cash flow restructure, possible Special Needs Trust if permanent, estate plan review for capacity considerations."},
            {"term": "Retirement", "definition": "Cash flow transition from earned income to portfolio withdrawals, Social Security start decision, Medicare enrollment (turning 65), tax bracket management for early retirement years, withdrawal sequencing across account types."},
            {"term": "Job change", "definition": "Old 401(k) decision (leave, roll to new plan, roll to IRA), new benefits package review, salary change effect on savings rate, equity compensation if applicable, stock option/RSU treatment."}
          ]},
          {"type": "subheading", "content": "Events that look big but usually do not require plan changes"},
          {"type": "list", "items": [
            "A market drawdown — the plan was built assuming this would happen periodically",
            "A missed bonus — annual variability is part of the cash flow plan, not an anomaly unless persistent",
            "A friend's investment advice that conflicts with the plan — usually a conversation, not a plan change",
            "Short-term media noise (this election, this tax proposal, this crisis) — almost never requires a change in long-term allocation"
          ]},
          {"type": "callout", "kind": "warn", "content": "The hardest moment of judgment is when the client believes a non-event is an event and wants to change the plan. Push back gently. 'Let us not change the plan in response to this. Let us put it on the agenda for our next scheduled review and decide with a calmer head.'"},
          {"type": "subheading", "content": "When the client tells you about a life event"},
          {"type": "paragraph", "content": "When a client mentions a life event — even casually, even at the end of a meeting about something else — pause. Do not let it slip past. 'You mentioned your father moved in with you. Help me understand what is changing there.' Then schedule a dedicated conversation if the event warrants it. Some events warrant a meeting within a week. Some warrant a meeting within a month. Almost no event warrants 'we will get to that at the annual review' if the annual review is more than 90 days away."},
          {"type": "case_study", "title": "Devon's business sale", "scenario": "Devon, the small business owner from prior modules, calls the apprentice to mention he received an unsolicited offer to acquire his business at a price that would net him about $4.2M after taxes. The apprentice does not try to handle this in a phone call. They schedule a 90-minute meeting for that week, prepare by pulling Devon's financials and reviewing QSBS eligibility, recommend Devon engage a business attorney and a transaction-experienced CPA, and outline the multi-year wealth planning that will be needed if the sale proceeds. Devon's sale ultimately closes nine months later. The relationship and the plan are transformed.", "discussion": "Devon was a comfortable mid-six-figure client. Post-sale he is a wealth management client. The apprentice's recognition that this was a major life event — not a hypothetical to discuss whenever convenient — set up everything that followed. Speed and structure of response matter."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Handling Estate Events — Death, Disability, Divorce",
        "summary": "Three life events deserve their own treatment because of their emotional weight and operational complexity. Doing them well is what counselors are made for.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Death of a client, severe disability, and divorce are among the hardest situations a counselor will work through. The financial work is real and consequential. The human work alongside it — sitting with grief, navigating family dynamics, witnessing the worst chapters of someone's life — is real too. Be ready for both. Decline neither."},
          {"type": "subheading", "content": "When a client dies"},
          {"type": "numbered", "items": [
            "First contact is usually from the surviving spouse, an adult child, or the executor — within days of death",
            "Do not push for decisions in the first 30 days unless legally required (RMDs in year of death, certain tax-elective items)",
            "Death certificates — surviving family needs multiple originals; help guide where to order them",
            "Account-level work: each retirement account, brokerage, bank account, insurance policy has its own claims process; build a master tracker for the survivor",
            "Surviving spouse rollover — surviving spouse inheriting an IRA can typically roll it to their own IRA, treating it as their own (with their own RMD age and rules), which is usually preferred",
            "Non-spouse inherited retirement accounts — SECURE Act generally requires distribution within 10 years (with some exceptions), planning the withdrawal across the 10 years to manage tax brackets is part of the work",
            "Social Security survivor benefits — file with SSA, coordinate timing with the survivor's own benefits",
            "Estate administration coordinates with the attorney — probate where applicable, trust administration where applicable",
            "Cash flow reset for the survivor — household income often drops significantly; new plan needed"
          ]},
          {"type": "callout", "kind": "do", "content": "When a client dies, send a handwritten condolence note. Not an email. Not a card from the firm. From you, signed by you. The smallest gesture is the largest signal."},
          {"type": "subheading", "content": "When a client experiences a major disability"},
          {"type": "paragraph", "content": "Disability creates cash flow disruption (lost earned income), often new expenses (medical, equipment, home modifications, ongoing care), and sometimes capacity questions. Work in sequence: stabilize cash flow first (disability insurance benefits if any, possibly Social Security disability, drawing from emergency reserves), then assess the medium-term picture (return to work timeline, severity of impairment), then update the long-term plan. If capacity is impaired, the durable power of attorney becomes active — confirm it is in place and the agent knows. If a Special Needs Trust may be needed (for ongoing support without disqualifying from means-tested benefits), engage the attorney early."},
          {"type": "subheading", "content": "When clients divorce"},
          {"type": "paragraph", "content": "Divorce is the financial event most commonly mishandled by advisors. Both spouses were your clients. Now one or both will not be. The fiduciary duty does not disappear during the divorce. Common rules: stop making changes to joint accounts without both signatures, refer the spouses to separate counsel (yours and a separate advisor for the spouse who will leave), avoid being drawn into the legal or emotional fight, and prepare for the operational work — QDRO for retirement plan division, beneficiary updates that are now urgent, new wills, new accounts, new tax filing status."},
          {"type": "list", "items": [
            "QDRO (Qualified Domestic Relations Order) — the legal instrument required to divide an ERISA-qualified retirement plan in divorce; must be drafted by attorney and accepted by plan administrator",
            "Beneficiary updates are urgent — divorce does not automatically remove the ex-spouse from many beneficiary designations; update or face the possibility of the ex-spouse inheriting",
            "Tax filing status changes — joint to single, with attention to the year of divorce specifics",
            "New estate documents — old will likely names ex-spouse as executor and beneficiary",
            "Insurance review — life insurance for child support obligations, health insurance transition, disability if relevant",
            "Cash flow reset — household income usually drops, new fixed costs may rise"
          ]},
          {"type": "callout", "kind": "warn", "content": "Beneficiary designations on retirement accounts and life insurance survive divorce in most cases unless updated. Divorce decrees often require beneficiary changes — but the changes have to actually be made. People die between the decree and the update. Treat this as urgent."},
          {"type": "case_study", "title": "Tasha's mother — disability planning becomes real", "scenario": "Six months after the annual review, Tasha's mother's condition has progressed. Tasha and her siblings are deciding whether to bring in 24/7 home care, move her to a care facility, or have her move in with Tasha and Marcus permanently. The apprentice does not try to make this decision. They convene a session with Tasha, Marcus, and Tasha's siblings (with everyone's consent) to think through the financial implications of each scenario, identify what resources the mother has (Social Security, pension, small savings), surface what insurance coverage exists, and outline what Tasha and Marcus would need to take on financially. The family ultimately decides on a hybrid — daytime in-home care plus weekend support from siblings. The apprentice draws up a 24-month cash flow projection for the new arrangement and integrates it into Marcus and Tasha's plan.", "discussion": "The apprentice did not pretend to be a geriatric care expert. They were a planner who helped the family think through the financial consequences clearly. The family kept its own decision-making authority. The plan adapted to the new reality. Both human and operational work were done well."},
          {"type": "subheading", "content": "Sitting with the difficulty"},
          {"type": "paragraph", "content": "The temptation in hard life events is to retreat into spreadsheets and operational tasks because the operational tasks feel manageable and the human reality does not. Resist that impulse. Spreadsheets are part of the work, not all of it. The client needs both — competence at the operations and presence with the difficulty. If you can offer both, you become irreplaceable in the most important seasons of their life."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Continuity — Staying With the Client Across Decades",
        "summary": "The most valuable financial relationships are measured in decades. Building one requires intentional systems for memory, communication, and adaptation across years.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most advisors are with a client for a fraction of the client's financial life. The best advisors are with a client for the whole back half of it. Continuity is a system, not a feeling. The advisor who built systems for memory, communication, and adaptation early in their career has a different relationship at year fifteen than the advisor who relied on goodwill."},
          {"type": "subheading", "content": "The CRM as institutional memory"},
          {"type": "paragraph", "content": "Every client interaction generates information that may matter ten years later. The kid's name. The medical condition the spouse has. The vacation property in Oregon. The specific anxiety the client expressed about running out of money. The reason they switched advisors before you. None of this can be recalled reliably from human memory across a 20-year relationship and hundreds of other clients. The CRM is the place where the relationship's memory actually lives. Treat it that way. Add to it after every meeting. Read from it before every meeting. The few minutes invested compound enormously over the relationship."},
          {"type": "subheading", "content": "What goes in the CRM"},
          {"type": "list", "items": [
            "Family details — names, birthdays, relationships, anniversaries that matter",
            "Health information they have shared (with privacy and discretion)",
            "Career history and current role",
            "Hobbies, interests, what they look forward to",
            "Past financial mistakes or wounds they have referenced",
            "Stated values and what money is for them",
            "Specific anxieties — running out, leaving enough for kids, getting taxed",
            "Their preferred communication style and cadence",
            "Things they have told you about other professionals — CPA, attorney, doctor, contractor"
          ]},
          {"type": "callout", "kind": "do", "content": "Use the CRM's calendar features to remind yourself about meaningful dates — the client's late spouse's anniversary, the date a child was born, when the parent passed. A short message on the right date is one of the most meaningful things you can send."},
          {"type": "subheading", "content": "Adapting the relationship as the client ages"},
          {"type": "paragraph", "content": "A client in their 30s and the same client in their 70s may want very different things from the relationship. The younger version wanted to know they were on track. The older version may want reassurance, simplicity, and the sense that someone is looking out for them. Read the change. Slow your communication style. Use more visual aids, larger type, simpler documents. Consider whether adult children should be in some meetings (with consent). Watch for capacity decline — gently, over years — and plan ahead for what the relationship looks like if the client cannot make their own decisions."},
          {"type": "subheading", "content": "Handling counselor turnover"},
          {"type": "paragraph", "content": "Sometimes the advisor changes — an apprentice gets promoted, a counselor retires, a firm reorganizes. The transition is risky to the client relationship. Best practices: introduce the new counselor in person before the transition, have several joint meetings during the handoff, share notes openly with the client about what is in the CRM (transparency builds trust), and let the client know that the firm's commitment to them does not depend on a single individual. Done well, transitions strengthen the institutional relationship. Done badly, they end the relationship."},
          {"type": "subheading", "content": "Year-over-year continuity rituals"},
          {"type": "list", "items": [
            "Annual review at the same approximate time each year — predictability is a feature",
            "Year-end planning letter or email in early November with personalized recommendations",
            "Brief mid-year check-in call — 'just confirming everything is going as expected'",
            "Holiday acknowledgment in December — handwritten when possible",
            "Recognition of anniversaries the client values — never sales-y, always personal"
          ]},
          {"type": "subheading", "content": "Closing the OJL-A band"},
          {"type": "paragraph", "content": "You have now worked through the full client-facing band of competencies: discovery, goal-setting, document collection, financial statements, behavioral coaching, risk profiling, plan presentation, implementation, and ongoing reviews. Together these nine modules describe the practice of a counselor — the work that produces a real planning relationship rather than a sequence of transactions. The next band shifts to operations and investment work. But this band is where the relationship lives. Master it and the rest serves the relationship rather than substituting for it."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: OJL-B opens with Portfolio Construction — translating risk profile and plan into the actual portfolio."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The most appropriate review cadence for a 68-year-old recently-retired client in the first five years of retirement is:", "options": ["Annual review", "Semi-annual reviews to dial in the withdrawal strategy as it meets reality", "Monthly reviews", "Quarterly reviews only if performance is poor"], "correct": 1, "explanation": "Early retirement is a transition stage. Withdrawal strategies often need adjustment as theory meets practice. Semi-annual cadence allows responsive tuning."},
        {"id": "q2", "prompt": "When opening an annual review meeting, the most effective first move is to:", "options": ["Pull up the performance report and start with returns", "Walk through the action items from last year", "Open on a personal note — 'how was your year overall?' — to surface what has changed in their life", "Discuss markets and current events"], "correct": 2, "explanation": "Leading personally surfaces life changes that should shape the rest of the meeting. Performance data discussed without context of life events is less useful and can be misleading."},
        {"id": "q3", "prompt": "A non-spouse inherited retirement account under the SECURE Act (for most beneficiaries) generally must be distributed:", "options": ["Within one year", "Over the beneficiary's life expectancy", "Within ten years", "By the end of the calendar year of the death"], "correct": 2, "explanation": "The SECURE Act generally requires non-spouse inherited retirement accounts to be fully distributed within 10 years (with limited exceptions for certain eligible designated beneficiaries)."},
        {"id": "q4", "prompt": "A QDRO is used to:", "options": ["Designate retirement plan beneficiaries", "Divide an ERISA-qualified retirement plan in divorce", "Authorize a Roth conversion", "Transfer accounts between custodians"], "correct": 1, "explanation": "A Qualified Domestic Relations Order is the legal instrument that divides ERISA-qualified retirement plans pursuant to divorce."},
        {"id": "q5", "prompt": "When a client tells you casually at the end of a meeting that their father has moved in with them, the right response is to:", "options": ["Note it for the next annual review", "Pause, acknowledge it, and ask one open question to understand what is changing", "Move on, since the meeting was about something else", "Send a follow-up email asking them to schedule a separate meeting"], "correct": 1, "explanation": "Life events surface in casual mentions. Do not let them slip past. Acknowledge, ask, and schedule a dedicated conversation if warranted."},
        {"id": "q6", "prompt": "Beneficiary designations on retirement accounts and life insurance following a divorce:", "options": ["Are automatically updated by the divorce decree", "Survive divorce in most cases unless actively updated — treat as urgent", "Are voided by the divorce", "Become the responsibility of the attorney"], "correct": 1, "explanation": "Without active update, ex-spouse beneficiary designations often remain in effect. People die between decree and update. This is urgent."},
        {"id": "q7", "prompt": "The most appropriate response to a client who wants to dramatically change the plan in reaction to a normal market drawdown is to:", "options": ["Make the change immediately to honor client wishes", "Refuse to discuss the topic", "Push back gently — suggest holding the discussion for the next scheduled review with a calmer head", "Increase the equity allocation"], "correct": 2, "explanation": "Reactive plan changes during drawdowns are usually destructive. Delay the decision to a calmer moment without dismissing the client's concern."},
        {"id": "q8", "prompt": "A surviving spouse inheriting an IRA can usually:", "options": ["Only take a lump-sum distribution", "Roll the IRA into their own IRA, treating it as their own going forward (typically preferred)", "Must distribute within 10 years", "Must wait one year before doing anything"], "correct": 1, "explanation": "A surviving spouse has the unique option to roll an inherited IRA into their own, which restarts the rules under their own age and circumstances. Usually the preferred treatment."},
        {"id": "q9", "prompt": "When a client dies, the first 30 days should generally:", "options": ["Be used to liquidate the portfolio for tax purposes", "Not push for decisions unless legally required (RMDs in year of death, certain elections); focus on stabilizing and gathering information", "Be used to update all beneficiary designations on the surviving spouse's accounts", "Be skipped entirely until the executor is appointed"], "correct": 1, "explanation": "Grief impairs decision-making. Defer non-urgent decisions. Operational and information-gathering work happens early; consequential decisions wait."},
        {"id": "q10", "prompt": "The CRM in a long-term advisor-client relationship is best understood as:", "options": ["A compliance requirement", "The relationship's institutional memory — the place where details that may matter ten years later live", "A marketing tool", "Optional"], "correct": 1, "explanation": "Across 20-year relationships and hundreds of other clients, human memory cannot reliably retain the details that build trust. The CRM is the memory. Treat it accordingly."},
        {"id": "q11", "prompt": "A counselor who is being transitioned off a client relationship to another counselor at the firm should:", "options": ["Stop communicating with the client immediately", "Introduce the new counselor in person before the transition, have several joint meetings during the handoff, share notes openly", "Refer the client to a competing firm", "Wait for the client to ask about the change"], "correct": 1, "explanation": "Transitions are risky to retention. In-person introductions, joint meetings, and transparency about institutional knowledge protect the relationship and often strengthen it."},
        {"id": "q12", "prompt": "Devon receiving an unsolicited offer to acquire his business at a $4.2M after-tax price is best handled by:", "options": ["Discussing in the next quarterly check-in", "Scheduling a dedicated 90-minute meeting that week, engaging a transaction-experienced CPA and business attorney, and outlining multi-year wealth planning", "Recommending Devon accept the offer immediately", "Waiting until the next annual review"], "correct": 1, "explanation": "Major life events warrant prompt, structured response. Speed and the right professionals on the team early are how these situations get handled well."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 18;

-- ── module19_insurance_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 19 CONTENT
-- Insurance Planning
-- ============================================================================
update public.modules set
  title = 'Insurance Planning',
  competency_id = 'CORE-9',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'Build a complete safety net for your clients. This module covers the major insurance types every financial counselor must understand — from life and disability to property and liability — so you can identify gaps, explain options in plain English, and protect everything your clients are working to build.',
  learning_objectives = ARRAY[
    'Explain how insurance functions as a risk-transfer tool within a comprehensive financial plan.',
    'Identify and distinguish the major personal insurance categories: life, health, disability, property/casualty, and liability.',
    'Calculate a client''s life insurance need using both the income-replacement and DIME methods.',
    'Compare term and permanent life insurance structures and explain when each is appropriate for a client.',
    'Describe how disability insurance protects earned income, including elimination period, benefit period, and own-occupation definitions.',
    'Conduct a basic insurance needs analysis to identify coverage gaps across a client''s full picture.',
    'Explain how annuities function as insurance products and their role in retirement income planning.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Risk, Protection, and the Safety Net",
      "summary": "Why insurance belongs in every financial plan — and how to talk about it without sounding like you're selling something.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every financial plan has two sides: building wealth and protecting it. Most of the curriculum so far has been about building — accumulation, investment, cash flow, tax strategy. Insurance is about protection. It is the part of the plan that answers the question: what happens to everything we just built if something goes wrong?" },
        { "type": "callout", "kind": "key", "title": "The planner's job on insurance", "text": "You are not selling insurance. You are identifying risk and recommending coverage. There is a significant difference. An advisor who starts from the client's actual exposure and works to the appropriate solution will always serve the client better than one who starts from a product." },
        { "type": "heading", "text": "The four ways to handle risk" },
        { "type": "paragraph", "text": "Every risk a client faces can be handled in one of four ways. Your job is to identify which approach fits each risk — and to recognize that many clients are unconsciously using the wrong one." },
        { "type": "glossary", "terms": [
          { "term": "Risk Avoidance", "definition": "Eliminating exposure to a risk entirely. Example: not owning a boat to avoid boat-related liability. Not always practical." },
          { "term": "Risk Reduction", "definition": "Taking steps to make a bad outcome less likely or less severe. Example: installing smoke detectors, wearing a seatbelt, diversifying investments." },
          { "term": "Risk Retention", "definition": "Accepting the financial consequence of a risk yourself. A client with a $1,000 deductible is retaining the first $1,000 of any covered loss. Appropriate for small, manageable risks." },
          { "term": "Risk Transfer", "definition": "Shifting the financial consequence of a risk to another party — typically an insurance company — in exchange for a premium. Appropriate for low-probability, high-severity risks." }
        ]},
        { "type": "paragraph", "text": "Insurance is the primary mechanism of risk transfer in personal finance. The logic is straightforward: you pay a predictable, affordable premium to protect yourself against an unpredictable, unaffordable loss. A family that cannot absorb the financial impact of a premature death, a disability, or a major lawsuit should not be retaining those risks — they should be transferring them." },
        { "type": "heading", "text": "The planning hierarchy" },
        { "type": "paragraph", "text": "Insurance discussions belong in the financial plan alongside investment and tax planning — not as an afterthought. The conventional sequencing: build an emergency fund first (so small losses do not require insurance claims or debt), then secure core insurance coverage (life, disability, health, liability), then focus on accumulation and growth. A household that is heavily invested but uninsured has a structural vulnerability in their plan." },
        { "type": "callout", "kind": "note", "title": "The sleep-at-night test", "text": "A simple way to gauge whether coverage is adequate: ask the client, 'If your income stopped tomorrow, how long could your household maintain its current standard of living?' If the answer is less than six months without life or disability insurance in place, the plan has a gap." },
        { "type": "heading", "text": "The insurance review framework" },
        { "type": "paragraph", "text": "When reviewing a client's insurance picture, work through four questions: What could go wrong? How likely is it? How costly would it be? And is the client currently protected against it? The combination of high likelihood and high cost is where insurance is essential. High cost but low likelihood — think catastrophic disability or premature death — is still transfer territory. Low cost, low likelihood is a reasonable candidate for retention." },
        { "type": "activity", "title": "Risk Mapping Exercise", "prompt": "For a hypothetical 38-year-old client — married, two children, $120K household income, $280K mortgage, modest savings — work through the risk mapping framework.", "steps": [
          "List five significant financial risks this client faces.",
          "For each risk, classify it: high/low likelihood and high/low financial severity.",
          "For each high-severity risk, write one sentence describing how it should be handled (transfer, retain, reduce, avoid).",
          "Identify which risks are likely uninsured for most households in this situation.",
          "Which of the four risk categories — life, disability, property, liability — should be the highest priority for this client? Explain your reasoning."
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Life Insurance — The Income Replacement Foundation",
      "summary": "Who needs it, how much they need, and how to explain term vs. permanent without getting into a product debate.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "Life insurance exists to replace income that would be lost if the insured died prematurely. That is its core purpose. Every other consideration — cash value accumulation, estate planning, tax benefits — is secondary to that foundational function. Before advising on life insurance, get clear on this question: whose death would create a significant financial hardship for someone who depends on them?" },
        { "type": "heading", "text": "Who needs life insurance" },
        { "type": "list", "items": [
          "Anyone with dependents who rely on their income",
          "A household where the surviving partner could not maintain their standard of living on one income",
          "A business owner whose death would create financial disruption for co-owners or key clients",
          "Anyone with significant debts (mortgage, business loans) that a surviving family member could not carry",
          "A stay-at-home parent whose economic contribution (childcare, household management) would be costly to replace"
        ]},
        { "type": "callout", "kind": "note", "title": "Who may not need it", "text": "A single person with no dependents and sufficient assets to cover their final expenses. A retired couple with ample savings, Social Security, and no dependents. The need for life insurance diminishes as assets accumulate and dependents gain independence." },
        { "type": "heading", "text": "Calculating the need" },
        { "type": "subheading", "text": "The income replacement method" },
        { "type": "paragraph", "text": "The simplest approach: multiply the insured's annual income by a factor of 10 to 12. A client earning $90,000 would need $900,000 to $1,080,000 in coverage. This is a starting point — it does not account for specific debts, the surviving partner's income, or the number and ages of children. Use it to establish a baseline, then adjust." },
        { "type": "subheading", "text": "The DIME method" },
        { "type": "paragraph", "text": "DIME is more precise. It calculates four components and adds them together." },
        { "type": "glossary", "terms": [
          { "term": "D — Debt", "definition": "All outstanding debts the family would need to pay off, excluding the mortgage (handled separately). Credit cards, auto loans, student loans." },
          { "term": "I — Income", "definition": "Annual income multiplied by the number of years until the youngest child reaches financial independence (typically age 22)." },
          { "term": "M — Mortgage", "definition": "The remaining mortgage balance, so the family can stay in the home." },
          { "term": "E — Education", "definition": "Estimated future education costs for each child." }
        ]},
        { "type": "activity", "title": "DIME Calculation", "prompt": "Apply the DIME method to a real scenario.", "steps": [
          "Assume: client earns $80,000/year, has $18,000 in non-mortgage debt, $210,000 remaining on mortgage, two children aged 4 and 7, and estimates $60,000 per child in future education costs.",
          "Calculate D: total non-mortgage debt.",
          "Calculate I: income × years until youngest child (age 4) reaches 22 = 18 years.",
          "Calculate M: remaining mortgage.",
          "Calculate E: education cost × 2 children.",
          "Add all four components. How does this compare to the 10x income rule of thumb?"
        ]},
        { "type": "heading", "text": "Term vs. permanent life insurance" },
        { "type": "subheading", "text": "Term life insurance" },
        { "type": "paragraph", "text": "Term life insurance provides a death benefit for a fixed period — typically 10, 20, or 30 years — in exchange for a level annual premium. There is no cash value. If the insured outlives the term, the policy expires with no payout. Term is affordable, transparent, and appropriate for the majority of income-replacement needs. A 35-year-old in good health can typically purchase $500,000 of 20-year term coverage for $25–35 per month." },
        { "type": "subheading", "text": "Permanent life insurance" },
        { "type": "paragraph", "text": "Permanent policies (whole life, universal life, variable universal life) combine a death benefit with a cash value component that accumulates over time. Premiums are substantially higher than term for equivalent coverage. Permanent life can serve legitimate planning purposes — estate liquidity, certain business continuation scenarios, permanent insurance needs that outlast a term period — but it is also widely oversold as a retirement savings vehicle, which is rarely the best use of the premium dollar." },
        { "type": "callout", "kind": "warn", "title": "The permanent vs. term debate", "text": "The conventional wisdom — 'buy term and invest the difference' — is sound for most clients. The scenarios where permanent life makes clear sense are specific: a high-net-worth client with an estate tax concern, a business with a buy-sell agreement requiring permanent coverage, or a client with an uninsurable health condition who secured permanent coverage earlier. Outside of these, term usually wins on cost-efficiency." },
        { "type": "heading", "text": "Key policy elements every advisor must know" },
        { "type": "glossary", "terms": [
          { "term": "Death benefit", "definition": "The amount paid to beneficiaries upon the insured's death. Usually income-tax-free under IRC Section 101(a)." },
          { "term": "Premium", "definition": "The periodic payment to keep the policy in force. Level premiums are locked in for the term of the policy." },
          { "term": "Beneficiary", "definition": "The person or entity who receives the death benefit. Primary and contingent beneficiaries should be named and reviewed regularly." },
          { "term": "Rider", "definition": "An optional add-on to a policy that modifies coverage. Common riders include waiver of premium (premium waived if disabled), accelerated death benefit (access a portion of the death benefit during terminal illness), and child term rider." },
          { "term": "Cash value", "definition": "In permanent policies, the savings component that accumulates over time and can be borrowed against or surrendered. Does not exist in term policies." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The three most common life insurance mistakes", "text": "<strong>1. Underinsurance:</strong> Clients frequently carry 2–3x income when they need 10x. Audit the actual need, not the existing coverage. <strong>2. Wrong policy owner:</strong> In community property states and estate planning scenarios, who owns the policy matters. Get compliance or legal input when ownership is not straightforward. <strong>3. Outdated beneficiaries:</strong> Divorces, deaths, and family changes happen. A policy that still names an ex-spouse as beneficiary is a ticking problem. Review beneficiary designations annually." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Disability and Health — Protecting the Income Engine",
      "summary": "The insurance clients underestimate most — and why disability coverage deserves as much attention as life insurance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Consider this: the Social Security Administration estimates that a 20-year-old entering the workforce today has a 1-in-4 chance of becoming disabled before reaching retirement age. The Council for Disability Awareness reports that a 35-year-old is roughly five times more likely to be disabled for 90 days or longer than to die before age 65. Yet disability insurance is the coverage most clients either lack entirely or carry inadequately." },
        { "type": "callout", "kind": "key", "title": "The income engine", "text": "For most working households, the most valuable financial asset is not the investment portfolio — it is the client's ability to earn income. A 40-year-old earning $100,000 who works until 65 has $2.5 million of future earnings at stake. Disability insurance protects that asset." },
        { "type": "heading", "text": "Short-term vs. long-term disability" },
        { "type": "paragraph", "text": "<strong>Short-term disability</strong> typically covers 60–70% of income for a period of 3 to 6 months following an illness or injury that prevents work. Many employers offer this as a group benefit. <strong>Long-term disability</strong> picks up where short-term leaves off, covering a percentage of income — usually 60% — for a benefit period that may extend to age 65 or for a specified number of years. LTD is the more critical coverage for financial planning purposes." },
        { "type": "heading", "text": "Key disability policy provisions" },
        { "type": "glossary", "terms": [
          { "term": "Elimination period", "definition": "The waiting period between the onset of disability and when benefits begin. Common periods: 30, 60, 90, or 180 days. A longer elimination period lowers the premium — the client retains more short-term risk. The emergency fund should bridge the elimination period." },
          { "term": "Benefit period", "definition": "How long benefits will be paid if disability continues. Options range from 2 years to age 65. A 'to age 65' benefit period provides the most protection for a long-term disability." },
          { "term": "Own-occupation definition", "definition": "The insured is considered disabled if they cannot perform the duties of their specific occupation — even if they could work in another field. The gold standard for professional coverage." },
          { "term": "Any-occupation definition", "definition": "The insured is considered disabled only if they cannot perform any occupation for which they are reasonably qualified. Much harder to claim. Common in lower-cost group plans." },
          { "term": "Non-cancelable and guaranteed renewable", "definition": "The insurer cannot cancel the policy or increase premiums as long as premiums are paid. The most protective and most expensive type of LTD policy." }
        ]},
        { "type": "callout", "kind": "warn", "title": "Group disability has significant gaps", "text": "Many clients rely on employer-provided group LTD without realizing: (1) Group benefits are typically taxable if the employer paid the premiums. (2) The own-occupation definition is often limited to the first two years, then converts to any-occupation. (3) Highly compensated employees hit benefit caps — a 60% benefit on $200K income is $120K, but the plan may cap at $6,000/month. Individual policies fill these gaps." },
        { "type": "heading", "text": "Health insurance fundamentals" },
        { "type": "paragraph", "text": "As a financial counselor, you are not a health insurance agent — but you need to understand the basics, because health coverage decisions affect cash flow, out-of-pocket costs, and tax strategy in ways that belong in a financial plan." },
        { "type": "glossary", "terms": [
          { "term": "Premium", "definition": "The monthly cost of maintaining coverage, regardless of whether care is used." },
          { "term": "Deductible", "definition": "The amount the insured pays out-of-pocket before the insurance company begins sharing costs. Resets annually." },
          { "term": "Copay", "definition": "A fixed dollar amount paid for a specific service (e.g., $30 for a doctor visit), separate from the deductible." },
          { "term": "Coinsurance", "definition": "The percentage of costs the insured pays after meeting the deductible (e.g., 20% of a hospital bill)." },
          { "term": "Out-of-pocket maximum", "definition": "The most the insured will pay in a calendar year before the insurance covers 100% of in-network costs. Critical for financial planning — this is the true worst-case annual health expense." }
        ]},
        { "type": "heading", "text": "The HSA as a planning tool" },
        { "type": "paragraph", "text": "A Health Savings Account (HSA) is available to individuals enrolled in a qualifying High-Deductible Health Plan (HDHP). It is the only account in the tax code with a triple tax benefit: contributions are pre-tax, growth is tax-free, and qualified withdrawals for medical expenses are tax-free. HSAs have no 'use it or lose it' rule — balances carry over indefinitely and can be invested. Many financial planners treat the HSA as a stealth retirement account: maximize contributions, pay current medical expenses out of pocket, and let the HSA grow for retirement healthcare costs." },
        { "type": "activity", "title": "Out-of-Pocket Exposure Calculation", "prompt": "A client has a $5,000 individual deductible, 20% coinsurance, and a $9,000 out-of-pocket maximum. They are hospitalized and receive a $40,000 bill. Walk through their actual cost.", "steps": [
          "Step 1: The first $5,000 is entirely the client's (deductible).",
          "Step 2: The remaining $35,000 is split: client pays 20% = $7,000.",
          "Step 3: Client's total = $5,000 + $7,000 = $12,000.",
          "Step 4: Apply the out-of-pocket maximum: client pays no more than $9,000.",
          "Step 5: Final client cost = $9,000. How much does the emergency fund need to cover this scenario?",
          "Bonus: If this client had an HSA with $4,000 in it, what is their actual net cash outlay?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Property, Liability, and the Umbrella",
      "summary": "Protecting what clients own — and protecting them from what could be taken away.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Life and disability insurance protect the income stream. Property and liability insurance protect the balance sheet — the assets clients have already accumulated. A single uninsured or underinsured incident can undo years of careful financial planning. The goal in this area of the plan is to ensure the client has adequate coverage on what they own and adequate protection for their liability exposure." },
        { "type": "heading", "text": "Homeowners insurance" },
        { "type": "paragraph", "text": "A standard homeowners policy (HO-3) has four major components: <strong>Dwelling coverage</strong> pays to repair or rebuild the physical structure. <strong>Personal property coverage</strong> replaces belongings lost to covered perils. <strong>Liability coverage</strong> protects the homeowner if someone is injured on their property. <strong>Additional living expenses (ALE)</strong> covers temporary housing if the home is uninhabitable after a covered loss." },
        { "type": "callout", "kind": "warn", "title": "Replacement cost vs. actual cash value", "text": "Policies pay either replacement cost (what it costs to replace the item new) or actual cash value (replacement cost minus depreciation). Actual cash value coverage on a 10-year-old roof or 8-year-old appliances pays significantly less than replacement cost. For most clients, replacement cost coverage is worth the higher premium." },
        { "type": "heading", "text": "Renters insurance" },
        { "type": "paragraph", "text": "Renters insurance is one of the best values in personal insurance — typically $15–25 per month — and covers personal property and personal liability for renters who do not own their dwelling. A landlord's policy covers the building; it does not cover the tenant's belongings. Survey after survey finds that a majority of renters incorrectly believe their landlord's policy covers their possessions. It does not." },
        { "type": "heading", "text": "Auto insurance" },
        { "type": "paragraph", "text": "State minimums for auto liability coverage are nearly universally inadequate for a client with assets to protect. A state minimum of $25,000 per person / $50,000 per accident covers a fraction of what a serious auto accident can cost in medical bills, lost wages, and litigation. The coverage decision: how much liability to carry, what deductible makes sense given the emergency fund, and whether to add comprehensive and collision on owned vehicles." },
        { "type": "heading", "text": "Liability exposure — the underestimated risk" },
        { "type": "paragraph", "text": "High-net-worth clients are disproportionately at risk from personal liability claims. A dog bite, a slip-and-fall at a dinner party, an accident caused by a teenage driver — any of these can result in a judgment that exceeds standard homeowners or auto liability limits. Clients with significant assets are attractive targets for litigation, even when the underlying incident is minor." },
        { "type": "heading", "text": "The personal umbrella policy" },
        { "type": "paragraph", "text": "A personal umbrella policy provides liability coverage above and beyond the limits of homeowners and auto policies — typically $1 million, $2 million, or $5 million in additional coverage. The cost is remarkably affordable: $1 million of umbrella coverage typically costs $150–300 per year. For a client with meaningful assets, an umbrella policy is often the highest return-per-dollar of any insurance purchase they can make." },
        { "type": "callout", "kind": "do", "title": "The umbrella conversation", "text": "Every client with over $300,000 in assets, a teenage driver, a swimming pool, rental property, or professional visibility should be asked about their umbrella coverage. If they do not have one, the conversation is: 'For roughly $200 a year, I can add $1 million of liability protection above your existing policies. Can you think of a reason not to?'" },
        { "type": "heading", "text": "The insurance review process" },
        { "type": "list", "items": [
          "Review all policies annually — the same meeting where you review the financial plan.",
          "Confirm dwelling coverage keeps pace with replacement cost, not market value.",
          "Check that personal property riders cover high-value items (jewelry, art, electronics) specifically.",
          "Verify auto liability limits are at least $100K/$300K before adding an umbrella.",
          "Confirm umbrella coverage is in place if assets exceed $250K.",
          "Update beneficiary designations and policy ownership with major life changes."
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Annuities — Income Insurance for Retirement",
      "summary": "What annuities actually are, when they genuinely serve clients, and how to explain them without overselling.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "An annuity is a contract between an individual and an insurance company in which the individual transfers a sum of money to the insurer in exchange for guaranteed income payments — either immediately or in the future. At its core, an annuity is insurance against longevity risk: the risk of outliving your money." },
        { "type": "callout", "kind": "key", "title": "The retirement income floor concept", "text": "A sound retirement income plan begins with a floor: guaranteed income that covers essential expenses regardless of what markets do. Social Security provides part of this floor. A pension, if available, provides more. An annuity can fill the gap between what Social Security provides and what the client needs to cover non-discretionary spending." },
        { "type": "heading", "text": "Types of annuities" },
        { "type": "glossary", "terms": [
          { "term": "Fixed annuity", "definition": "Pays a guaranteed rate of interest during accumulation and a guaranteed income stream during distribution. Predictable. No market exposure. Low fees." },
          { "term": "Variable annuity", "definition": "Accumulation value grows or declines based on investment sub-accounts chosen by the owner. Higher potential return, higher risk, higher fees. Often includes guaranteed income riders." },
          { "term": "Fixed-indexed annuity (FIA)", "definition": "Interest credits are linked to the performance of a market index (like the S&P 500), subject to a cap and floor. Participation in market growth with protection against market loss. Moderate fees." },
          { "term": "Immediate annuity (SPIA)", "definition": "A single premium immediate annuity converts a lump sum into income payments that begin immediately (usually within 30 days). Simple, transparent, and useful for converting assets to guaranteed income." },
          { "term": "Deferred annuity", "definition": "Accumulates value over a deferral period before converting to income. Can be fixed, variable, or indexed during accumulation." },
          { "term": "Surrender charge", "definition": "A penalty for withdrawing funds from an annuity before the surrender charge period ends — typically 5–10 years. The penalty reduces over time. Locks up money." }
        ]},
        { "type": "heading", "text": "When annuities genuinely serve clients" },
        { "type": "list", "items": [
          "The client has a significant longevity concern — family history of living into their 90s and no pension.",
          "The client needs income certainty to cover essential expenses and Social Security falls short.",
          "The client has exhausted tax-advantaged contribution limits and wants tax-deferred growth.",
          "The client is converting a lump-sum distribution (pension, 401(k)) and needs guaranteed income.",
          "The client has anxiety about sequence-of-returns risk and values the behavioral benefit of guaranteed income."
        ]},
        { "type": "heading", "text": "When annuities do not serve clients" },
        { "type": "callout", "kind": "warn", "title": "The overselling problem", "text": "Annuities are among the most heavily commissioned products in financial services. Variable annuities with living benefits can carry total annual fees of 2.5–4%. These costs compound dramatically over time. An annuity that is sold primarily because of the commission rather than the client's genuine need is a breach of the advisor's obligation. Know the product, know the cost, and know the client's actual situation before recommending." },
        { "type": "list", "items": [
          "The client has sufficient guaranteed income already (Social Security + pension covers essential spending).",
          "The client needs liquidity — surrender charges make annuities unsuitable for money that might be needed.",
          "The client's primary goal is wealth accumulation with a long time horizon — lower-cost investments generally outperform after fees.",
          "The client is in poor health with a shortened life expectancy — longevity insurance has less value.",
          "The recommended product's fees are not justified by the guarantees provided."
        ]},
        { "type": "heading", "text": "What to review before recommending" },
        { "type": "numbered", "items": [
          "What specific risk is this annuity solving for this client?",
          "What are the total annual fees (MER, rider charges, sub-account expenses)?",
          "What is the surrender charge schedule, and does the client need liquidity within that window?",
          "Is the insurance company financially strong (A-rated or better)?",
          "Is there a simpler, lower-cost product that achieves the same goal?"
        ]},
        { "type": "divider" },
        { "type": "paragraph", "text": "Insurance planning is not a standalone conversation — it belongs in the financial plan alongside investment, tax, and retirement planning. A comprehensive annual review should include an insurance audit: confirming coverage is still adequate, beneficiary designations are current, and the overall protection picture reflects the client's life as it actually is today." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "text": "A client with $340,000 remaining on their mortgage, $22,000 in non-mortgage debt, two children (ages 5 and 9), earns $75,000/year, and estimates $55,000 per child in education costs. Using the DIME method, what is their approximate life insurance need?",
        "options": [
          "$1,497,000 (Debt $22K + Income $75K×13yr $975K + Mortgage $340K + Education $110K)",
          "$750,000 (10× income)",
          "$462,000 (Debt + Mortgage + Education only)",
          "$900,000 (12× income)"
        ],
        "correct": 0,
        "explanation": "DIME: D=$22,000 + I=$75,000×13 years until youngest (age 5) reaches 18=$975,000 + M=$340,000 + E=$110,000 = $1,447,000 approximately. The 10–12× rule of thumb gives $750–900K — significantly less than the actual calculated need."
      },
      {
        "id": "q2",
        "text": "What is the primary difference between own-occupation and any-occupation disability definitions?",
        "options": [
          "Own-occupation pays if you cannot perform your specific job; any-occupation pays only if you cannot work in any field you are qualified for",
          "Own-occupation has a shorter elimination period than any-occupation",
          "Any-occupation covers more conditions than own-occupation",
          "Own-occupation is only available through employer group plans"
        ],
        "correct": 0,
        "explanation": "Own-occupation is the stronger definition — a surgeon who cannot perform surgery is disabled even if they could teach. Any-occupation is far harder to qualify for and is common in lower-cost group plans."
      },
      {
        "id": "q3",
        "text": "A client has a $5,000 deductible and 20% coinsurance with a $9,000 out-of-pocket maximum. Their medical bill is $40,000. What is their actual cost?",
        "options": [
          "$9,000 — the out-of-pocket maximum caps their exposure",
          "$40,000 — they pay the full amount until the deductible is met",
          "$12,000 — deductible plus 20% of the remainder",
          "$5,000 — just the deductible"
        ],
        "correct": 0,
        "explanation": "Deductible: $5,000. Coinsurance on remaining $35,000: 20% = $7,000. Total before cap: $12,000. But the OOP maximum of $9,000 caps the exposure, so the client pays $9,000."
      },
      {
        "id": "q4",
        "text": "Which of the following BEST describes the appropriate use of a personal umbrella policy?",
        "options": [
          "Providing liability coverage above the limits of homeowners and auto policies for clients with significant assets",
          "Replacing homeowners and auto insurance for high-net-worth clients",
          "Covering medical expenses not covered by health insurance",
          "Insuring personal property not covered by a standard homeowners policy"
        ],
        "correct": 0,
        "explanation": "A personal umbrella provides an additional layer of liability protection above existing policies — typically $1M+ for $150–300/year. It does not replace underlying coverage and does not cover property or medical expenses."
      },
      {
        "id": "q5",
        "text": "Which scenario BEST describes an appropriate use of a permanent life insurance policy?",
        "options": [
          "A high-net-worth client with an estate tax concern who needs permanent insurance for estate liquidity",
          "A 30-year-old with two young children who needs income replacement coverage",
          "A client who wants to invest for retirement and prefers tax-advantaged growth",
          "A client whose employer group term life benefit has just ended"
        ],
        "correct": 0,
        "explanation": "Permanent life serves specific purposes: estate liquidity, business continuation, or clients who need permanent coverage. For income replacement or retirement accumulation, term plus dedicated investment accounts is typically more cost-efficient."
      },
      {
        "id": "q6",
        "text": "What is the primary tax advantage of a Health Savings Account (HSA)?",
        "options": [
          "Triple tax benefit: pre-tax contributions, tax-free growth, and tax-free qualified withdrawals",
          "Contributions are tax-deductible and withdrawals for any purpose are tax-free after age 65",
          "There is no tax advantage — HSAs simply allow pre-payment of medical expenses",
          "Employer contributions to HSAs are taxable income to the employee"
        ],
        "correct": 0,
        "explanation": "HSAs offer a triple tax benefit unique in the tax code. Contributions are pre-tax, growth is tax-free, and qualified medical expense withdrawals are tax-free. After 65, withdrawals for any purpose are taxed as ordinary income — similar to a traditional IRA."
      },
      {
        "id": "q7",
        "text": "A client's homeowners policy pays 'actual cash value' for personal property losses. Their 8-year-old flat-screen TV is stolen. What does this mean for their claim?",
        "options": [
          "They will receive the depreciated value of the TV, not the cost of a comparable new TV",
          "They will receive the full cost of replacing the TV with a new equivalent",
          "They will receive nothing because electronics are excluded from homeowners policies",
          "They will receive the original purchase price of the TV"
        ],
        "correct": 0,
        "explanation": "Actual cash value = replacement cost minus depreciation. An 8-year-old TV has depreciated significantly. Replacement cost coverage pays what it costs to buy a new equivalent — a meaningful difference worth the premium."
      },
      {
        "id": "q8",
        "text": "What is the primary purpose of a disability insurance elimination period?",
        "options": [
          "It is the waiting period before benefits begin, which the client's emergency fund should bridge",
          "It is the period during which the insurer can cancel the policy without cause",
          "It defines the maximum benefit period for which claims will be paid",
          "It is the time period within which the insured must file a claim after disability onset"
        ],
        "correct": 0,
        "explanation": "The elimination period is the waiting period (typically 30–180 days) before disability benefits begin. A longer elimination period lowers the premium. The client's emergency fund should be sufficient to cover living expenses during this window."
      },
      {
        "id": "q9",
        "text": "Which of the following BEST describes when an annuity is NOT appropriate for a client?",
        "options": [
          "The client needs liquidity within the next five years and the policy has a surrender charge schedule",
          "The client is concerned about outliving their assets",
          "The client's Social Security does not fully cover their essential monthly expenses",
          "The client wants guaranteed income they cannot outlive"
        ],
        "correct": 0,
        "explanation": "Annuities with surrender charges lock up capital for years. A client who may need access to those funds should not purchase an annuity with that money. Liquidity needs and surrender charge schedules must always be evaluated together."
      },
      {
        "id": "q10",
        "text": "Which of the four risk management strategies is MOST appropriate for a risk that is low-probability but catastrophically expensive?",
        "options": [
          "Risk transfer — purchase insurance to shift the financial consequence to an insurer",
          "Risk retention — accept the financial consequence yourself",
          "Risk avoidance — eliminate exposure to the risk entirely",
          "Risk reduction — take steps to make the outcome less severe"
        ],
        "correct": 0,
        "explanation": "Low-probability, high-severity risks are the classic case for risk transfer via insurance. The client cannot afford the consequence of the loss materializing, but the premium for protection is manageable. Retention would be catastrophic if the event occurred."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 19;
