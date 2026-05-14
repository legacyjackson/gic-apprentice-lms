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
