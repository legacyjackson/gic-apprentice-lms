-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 1 CONTENT
-- Financial Literacy & Planning
-- ============================================================================
-- Loads substantive lesson content + assessment quiz into module 1.
-- Status remains 'draft' until Cathy Jackson-Gent approves via the admin UI.
--
-- Run this AFTER supabase_setup.sql.
-- Safe to re-run; uses UPDATE.
-- ============================================================================

update public.modules set
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Money Language",
      "summary": "The vocabulary every advisor must speak fluently.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Before you can build a plan, you have to be able to <strong>name what you're looking at</strong>. Money has its own working vocabulary, and a Wealth Solutions Counselor uses these words with the same precision a physician uses anatomical terms. Get the words wrong, and the plan will be wrong." },
        { "type": "paragraph", "text": "This lesson covers the terms you'll use in your first client conversation and every one after. Pay close attention: many sound similar but carry very different meaning when a client is making a real decision with real money." },

        { "type": "heading", "text": "Income: gross vs. net" },
        { "type": "paragraph", "text": "<strong>Gross income</strong> is what someone earns before any deductions. <strong>Net income</strong> — sometimes called take-home pay — is what actually lands in the bank account after taxes, retirement contributions, health insurance, and other withholdings." },
        { "type": "callout", "kind": "key", "title": "Why this matters", "text": "Clients almost always quote you their gross figure when asked what they earn. Almost every budgeting and cash-flow conversation must happen in net terms. Always confirm which number you're working with — and write it down." },

        { "type": "heading", "text": "Expenses: fixed vs. variable" },
        { "type": "paragraph", "text": "<strong>Fixed expenses</strong> are roughly the same amount every month — rent or mortgage, car payment, insurance premiums, subscriptions. <strong>Variable expenses</strong> move from month to month — groceries, gas, eating out, entertainment, gifts." },
        { "type": "paragraph", "text": "There's a third category worth naming early: <strong>periodic</strong> or <strong>irregular</strong> expenses. These are real expenses that don't show up monthly — annual insurance premiums, property taxes, car registration, holiday gifts, back-to-school costs. Most household budgeting failures trace back to ignoring these." },

        { "type": "heading", "text": "The balance sheet vocabulary" },
        { "type": "glossary", "terms": [
          { "term": "Asset", "definition": "Anything of economic value that the client owns. Examples: cash, retirement accounts, the home, a paid-off car, a business stake." },
          { "term": "Liability", "definition": "A debt the client owes. Examples: mortgage balance, auto loan, credit card balance, student loans." },
          { "term": "Net worth", "definition": "Total assets minus total liabilities. The single most useful long-term scorecard in personal finance." },
          { "term": "Equity", "definition": "The portion of an asset the client actually owns free of debt. Home value minus mortgage balance equals home equity." },
          { "term": "Liquidity", "definition": "How quickly an asset can be turned into spendable cash without significant loss. Checking accounts are highly liquid; a home or retirement account is not." }
        ]},

        { "type": "heading", "text": "Debt and capacity" },
        { "type": "glossary", "terms": [
          { "term": "Debt-to-income ratio (DTI)", "definition": "Total monthly debt payments divided by gross monthly income, expressed as a percentage. Lenders use it to judge borrowing capacity; advisors use it as an early-warning indicator of household stress." },
          { "term": "Front-end DTI", "definition": "Housing-related debt payments only (mortgage or rent + taxes + insurance) divided by gross monthly income. Conventional lending generally prefers this below 28%." },
          { "term": "Back-end DTI", "definition": "All monthly debt payments divided by gross monthly income. Conventional lending generally prefers this below 36% — though loan programs vary. Above 43% becomes a structural concern." },
          { "term": "Revolving debt", "definition": "Debt with a flexible balance and minimum payments — credit cards, lines of credit. Interest typically accrues monthly on the unpaid balance." },
          { "term": "Installment debt", "definition": "Debt with a fixed payment schedule and end date — auto loans, mortgages, most student loans. Predictable but rigid." }
        ]},

        { "type": "callout", "kind": "warn", "title": "Two words clients confuse", "text": "<strong>Solvent</strong> and <strong>liquid</strong> are not the same. A client can be solvent (positive net worth) but illiquid (everything tied up in the house and 401(k)) and still face a real crisis when the water heater breaks. Make sure you can explain the difference simply." },

        { "type": "divider" },

        { "type": "heading", "text": "Practice your fluency" },
        { "type": "activity", "title": "Translate gross to net", "prompt": "A client tells you, \"I make $90,000 a year.\" Before you can do anything useful, you need to estimate their actual take-home pay. Walk through this exercise:", "steps": [
          "Assume the client is single, lives in California, and contributes 6% of salary to a traditional 401(k).",
          "Roughly: federal income tax (22% marginal bracket effective ~15%), Social Security (6.2%), Medicare (1.45%), California state income tax (~6% effective).",
          "Don't forget the 401(k) contribution comes off the top of gross — that's $5,400/year reducing both taxable income and take-home.",
          "Estimate the net monthly figure. Compare to your first instinct.",
          "Note: this is a rough exercise. Real net pay depends on health premiums, HSA, dental, life insurance, garnishments, and many other factors. Always work from real pay stubs when planning."
        ] },

        { "type": "callout", "kind": "do", "title": "Habit to build now", "text": "When a client states an income figure, your next question is almost always, \"Is that gross or net?\" Train your reflex on this — it's the single fastest tell that you know what you're doing." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Net Worth Snapshot",
      "summary": "The first real picture every plan needs.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every plan begins with two pictures: what the client owes and what the client owns. The difference is <strong>net worth</strong> — and it is the most useful single number in personal finance." },
        { "type": "callout", "kind": "key", "title": "The formula", "text": "<strong>Net Worth = Total Assets − Total Liabilities</strong>" },

        { "type": "heading", "text": "Why this number matters" },
        { "type": "paragraph", "text": "Income and spending tell you about flow. Net worth tells you about <em>position</em>. A client earning $250,000 with a -$80,000 net worth is in a different situation than a client earning $65,000 with a $200,000 net worth. The plan must respond to position, not just income." },
        { "type": "paragraph", "text": "Tracked over time, net worth becomes the most honest scorecard a household has. Markets move, salaries change, surprises happen — but year over year, net worth answers a single question: are we building, or are we slipping?" },

        { "type": "heading", "text": "Categorizing assets" },
        { "type": "paragraph", "text": "When building a net worth statement, group assets by liquidity:" },
        { "type": "list", "items": [
          "<strong>Cash & cash equivalents</strong> — checking, savings, money market, CDs, short-term Treasuries. Use the current balance.",
          "<strong>Investment accounts (non-retirement)</strong> — taxable brokerage, individual stocks, mutual funds, ETFs. Use the most recent statement value.",
          "<strong>Retirement accounts</strong> — 401(k), 403(b), IRA, Roth IRA, SEP, Solo 401(k). Use current market value, not contributions.",
          "<strong>Real estate</strong> — primary home, rental property, land. Use a defensible market value (recent comps, Zillow as a starting point, formal appraisal for high-stakes situations).",
          "<strong>Business interests</strong> — ownership in a private business. This is the hardest to value. Use the most recent qualified valuation or annotate \"value uncertain.\"",
          "<strong>Personal property</strong> — vehicles, jewelry, collectibles. Use replacement value cautiously; many advisors omit minor personal property entirely to keep the statement honest."
        ]},

        { "type": "callout", "kind": "warn", "title": "Common mistake", "text": "Some advisors list the home at its <em>purchase price</em>. Others list it at the <em>Zestimate</em>. Both can mislead. Use a defensible recent comparable, and always note the source and date in the working papers." },

        { "type": "heading", "text": "Categorizing liabilities" },
        { "type": "list", "items": [
          "<strong>Mortgage(s)</strong> — current principal balance, not original loan amount.",
          "<strong>Auto loans</strong> — current payoff balance.",
          "<strong>Student loans</strong> — split federal vs. private; both go on the statement.",
          "<strong>Credit cards</strong> — total balances carried, regardless of whether the client \"pays them off every month.\" If a balance is on the statement, list it.",
          "<strong>Home equity lines of credit (HELOCs)</strong> — current drawn balance, not the credit limit.",
          "<strong>Personal loans, medical debt, tax debt</strong> — all included."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Worked example: Naomi" },
        { "type": "case_study",
          "title": "Net worth at age 34",
          "scenario": "Naomi is 34, single, an analyst at a Bay Area firm. She's earned consistently for 11 years and feels like she should be \"farther along.\" She's hired your firm for a second opinion.",
          "discussion": "<p><strong>Assets</strong></p><ul><li>Checking: $4,200</li><li>High-yield savings: $18,000</li><li>Roth IRA: $42,000</li><li>401(k) (employer plan): $112,000</li><li>Taxable brokerage: $9,500</li><li>2019 Honda Civic (paid off): $14,000</li><li><strong>Total assets: $199,700</strong></li></ul><p><strong>Liabilities</strong></p><ul><li>Credit card (carrying balance): $3,400</li><li>Federal student loans: $26,800</li><li><strong>Total liabilities: $30,200</strong></li></ul><p><strong>Net worth: $169,500</strong></p><p>Notice what this picture tells you that a salary figure alone cannot: Naomi has built real position. She is not behind. The conversation moving forward isn't \"how do we save more\" — it's \"what are we building toward?\" That reframe is the whole reason we compute net worth before anything else.</p>"
        },

        { "type": "activity", "title": "Build your own net worth statement", "prompt": "Before you can guide clients through this, do it for yourself. Apprentices who skip this step describe the exercise to clients abstractly; the ones who've done it speak with quiet authority.", "steps": [
          "Open a spreadsheet. Create two columns: Assets, Liabilities.",
          "List every account, by name and current balance, in the correct column. Don't estimate — pull the most recent statement.",
          "Add it up. Calculate net worth.",
          "Save the file. Date it. You'll do this again in 6 months and learn more from comparing the two snapshots than from any market commentary.",
          "Optional: note one observation about your own position that surprised you. Apprentices who can name surprise in themselves can recognize it in clients."
        ]},

        { "type": "callout", "kind": "note", "title": "Working papers reminder", "text": "When you build a net worth statement for a client, save the source documents alongside the spreadsheet — pay stubs, statements, valuations. The statement is the summary; the working papers are the audit trail. Always keep both." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "The Cash Flow Statement",
      "summary": "Money in, money out, and the gap that decides everything.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "If net worth tells you the client's <em>position</em>, the cash flow statement tells you the client's <em>direction</em>. It is the most action-oriented document in personal finance because almost every recommendation you'll ever make changes a line item on it." },
        { "type": "callout", "kind": "key", "text": "<strong>Monthly Cash Flow = Monthly Income − Monthly Expenses</strong><br/>A positive figure is <em>surplus</em>. A negative figure is <em>deficit</em>. The surplus is the fuel for every plan." },

        { "type": "heading", "text": "Building the income side" },
        { "type": "list", "items": [
          "<strong>Earned income</strong> — wages, salary, self-employment income, bonuses, commissions. Use <strong>net</strong> figures (take-home pay), not gross.",
          "<strong>Investment income</strong> — dividends, interest, rental income (after expenses).",
          "<strong>Other reliable income</strong> — child support received, alimony, Social Security, pension payments, disability benefits.",
          "<strong>Irregular income</strong> — RSU vests, annual bonuses, side income. List these separately and consider averaging across the year."
        ]},
        { "type": "callout", "kind": "warn", "title": "On bonuses and commissions", "text": "If a client's compensation includes significant variable comp, you have two options: (1) build a base-only cash flow and treat variable comp as a separate windfall plan, or (2) build an average-monthly cash flow using a 12-month rolling figure. Option 1 is more conservative and is the default for most planning work." },

        { "type": "heading", "text": "Building the expense side" },
        { "type": "subheading", "text": "Fixed expenses (predictable, monthly)" },
        { "type": "list", "items": [
          "Housing: rent or mortgage payment, property taxes (escrowed or not), HOA dues, homeowners or renters insurance.",
          "Transportation: auto loan payment, auto insurance, registration averaged monthly.",
          "Insurance: health insurance premiums (if not pre-tax through payroll), disability, life, umbrella.",
          "Debt service: minimum payments on credit cards, student loans, personal loans.",
          "Subscriptions and recurring services."
        ]},
        { "type": "subheading", "text": "Variable expenses (changes monthly)" },
        { "type": "list", "items": [
          "Food: groceries, dining out, coffee, work lunches.",
          "Utilities: electricity, gas, water, internet, phone (some are quasi-fixed, some seasonal).",
          "Transportation: gas, parking, public transit, ride-share, maintenance.",
          "Personal: clothing, household goods, haircuts, gym, hobbies, gifts.",
          "Healthcare out-of-pocket: copays, medications, dental, vision."
        ]},
        { "type": "subheading", "text": "Periodic expenses (annualize and divide by 12)" },
        { "type": "list", "items": [
          "Annual insurance premiums not paid monthly.",
          "Property taxes if not escrowed.",
          "Holiday gifts.",
          "Travel and vacations.",
          "Back-to-school costs.",
          "Vehicle registration.",
          "Membership renewals."
        ]},

        { "type": "callout", "kind": "do", "title": "The rule of thumb", "text": "If a client's stated monthly expenses look unrealistically low, you've almost certainly missed the periodic category. Total a client's annual periodic expenses, divide by 12, and add it to monthly outflows. The picture usually shifts dramatically." },

        { "type": "heading", "text": "Surplus, deficit, and the truth" },
        { "type": "paragraph", "text": "Once you've built both sides honestly, the answer comes out:" },
        { "type": "list", "items": [
          "<strong>Surplus</strong>: income exceeds expenses. This is the raw material for every saving, investing, and debt-paydown plan you'll ever recommend.",
          "<strong>Break-even</strong>: income equals expenses. The household is treading water — any surprise becomes a crisis.",
          "<strong>Deficit</strong>: expenses exceed income. The household is sinking, usually quietly. The first job of the plan is to find the gap and close it."
        ]},

        { "type": "case_study",
          "title": "Marcus and Tasha",
          "scenario": "Marcus and Tasha are a married couple in their early 40s. Combined gross income is $148,000. They tell you confidently that they save \"$1,000 a month.\" After working through their actual cash flow with you, the picture is different: net combined income $9,200/month, fixed expenses $5,800, variable expenses $2,400, and annualized periodic expenses (taxes, insurance, vacation, gifts) averaging $1,100/month. Real monthly surplus: −$100.",
          "discussion": "Marcus and Tasha aren't lying. They are saving $1,000 each month — into a high-yield savings account. But they're also withdrawing from it intermittently to cover the surprises they didn't plan for. The net is roughly zero. The work of the plan is not to lecture them about their spending. It's to <strong>name the missing $1,100/month periodic line</strong>, build a sinking-fund habit, and let the real surplus emerge. That's a much more productive conversation than \"you should save more.\""
        },

        { "type": "activity", "title": "Build your own cash flow statement", "prompt": "Same instruction as last lesson: do it for yourself first.", "steps": [
          "Pull the last three months of bank and credit card statements.",
          "Categorize every line into fixed, variable, or periodic.",
          "Average across the three months to get a typical monthly figure.",
          "Add a row for periodic expenses (annual total / 12).",
          "Compute your real monthly surplus or deficit.",
          "Compare your real number to what you would have guessed before the exercise."
        ]}
      ]
    },

    {
      "id": "lesson-4",
      "title": "Three Budget Frameworks",
      "summary": "Zero-based, 50/30/20, and sinking funds — when each one fits.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Budgeting is the most over-mentioned and least understood topic in personal finance. The truth is there's no single \"right\" framework — there are three useful ones, and the skill is matching the right framework to the right client." },

        { "type": "heading", "text": "Framework 1 — Zero-based budgeting" },
        { "type": "paragraph", "text": "Every dollar of income gets a job before the month begins. If income is $5,000, you assign all $5,000 — to rent, food, insurance, savings, debt paydown, fun money — until nothing is unaccounted for. The total of every category equals income exactly. Hence \"zero-based.\"" },
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Clients in debt-paydown mode, clients who feel \"money disappears,\" clients who need to feel in control, clients on tight margins. High-engagement clients thrive on this. It is the gold standard for changing behavior fast." },
        { "type": "callout", "kind": "warn", "title": "Watch out for", "text": "It's labor-intensive. Some clients hate it within 30 days and quit budgeting entirely. Don't impose it on a client who tells you they want a \"set it and forget it\" approach." },

        { "type": "heading", "text": "Framework 2 — 50/30/20" },
        { "type": "paragraph", "text": "A percentage framework popularized by Senator Elizabeth Warren and her daughter in <em>All Your Worth</em>:" },
        { "type": "list", "items": [
          "<strong>50%</strong> of take-home pay to needs: housing, food, utilities, insurance, transportation, minimum debt payments.",
          "<strong>30%</strong> to wants: dining out, entertainment, hobbies, subscriptions, travel.",
          "<strong>20%</strong> to savings and debt payoff above the minimums: emergency fund, retirement, paying down credit cards faster than the minimum."
        ]},
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Middle- and higher-income clients who don't want category-level tracking. Anyone whose needs already fit comfortably in 50%. Excellent starting framework for clients who've never budgeted." },
        { "type": "callout", "kind": "warn", "title": "Watch out for", "text": "Doesn't work in high cost-of-living areas where rent alone is 40% of net pay — the math breaks. In those cases, you may need to compress \"wants\" or adjust the percentages honestly. Don't force the framework to fit; adapt it." },

        { "type": "heading", "text": "Framework 3 — Sinking funds" },
        { "type": "paragraph", "text": "Rather than budgeting only the current month, sinking funds budget across the year. For every known periodic expense — annual insurance, property taxes, holidays, vacations, vehicle registration — the client divides the annual amount by 12 and contributes monthly to a dedicated sub-account. When the bill arrives, the money is already there." },
        { "type": "callout", "kind": "key", "text": "Sinking funds are not really a complete budget framework — they're a <strong>tool</strong> that works alongside either of the others. But because most household budget failures trace back to ignoring periodic expenses, naming the sinking fund pattern explicitly is one of the highest-leverage things a counselor can teach." },

        { "type": "subheading", "text": "Common sinking fund categories" },
        { "type": "list", "items": [
          "Annual insurance premiums (homeowners, umbrella, life term)",
          "Property tax (if not escrowed by mortgage servicer)",
          "Vehicle: registration, tires, scheduled maintenance",
          "Travel and vacation",
          "Gifts: holidays, birthdays, weddings, baby showers",
          "Pet expenses (vet, boarding)",
          "Annual subscriptions (Amazon Prime, professional dues)",
          "Home maintenance reserve (typically 1% of home value/year)"
        ]},

        { "type": "divider" },

        { "type": "case_study",
          "title": "Choosing the right framework",
          "scenario": "Three different clients meet with you in one week. Naomi (analyst, single, $90k, no debt, methodical) wants to optimize her savings rate. Marcus and Tasha (married, kids, $148k combined, modest surplus, feel overwhelmed) want clarity. Devon (small business owner, irregular income $80–$160k, three kids, behind on retirement) wants control.",
          "discussion": "<p>Naomi gets <strong>50/30/20</strong>. She doesn't need a daily framework — she needs a structural target. We confirm her needs fit in 50%, set her wants budget honestly, and lock 25–30% (not 20%) for savings and investing.</p><p>Marcus and Tasha get a hybrid: <strong>50/30/20 with a sinking-fund layer</strong>. The frustration in their household isn't about discipline — it's about surprises. We name every periodic expense, build six sinking funds, and the chaos drops within two months.</p><p>Devon gets <strong>zero-based budgeting</strong>. His income volatility plus his catch-up retirement work means every dollar needs a job. We use his lowest reliable monthly income as the baseline and create a windfall plan for the higher months. It's more work — and exactly the right tool for his situation.</p>"
        },

        { "type": "callout", "kind": "key", "title": "The counselor's question", "text": "Don't ask \"which framework do you want?\" Most clients don't know. Ask: <em>\"When you think about money day-to-day, do you want to feel in control of every dollar, or do you want a structure you can mostly forget about?\"</em> Their answer points you to the right framework." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Emergency Fund",
      "summary": "How much, where, and what it really protects.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "The emergency fund is the most basic and most misunderstood building block in personal finance. Get this one piece right and almost everything downstream becomes easier." },
        { "type": "callout", "kind": "key", "title": "What it really is", "text": "An emergency fund is <strong>cash reserved to keep the household intact when income drops or an unexpected expense hits</strong>. It is not a savings account for vacations. It is not an investment account. It is structural insurance against the months you didn't plan for." },

        { "type": "heading", "text": "Sizing the fund" },
        { "type": "paragraph", "text": "The standard rule of thumb is <strong>3 to 6 months of essential expenses</strong>. Notice two important details:" },
        { "type": "list", "items": [
          "<strong>Essential expenses, not total expenses.</strong> If a household spends $7,000/month total but only $5,000/month is truly essential (housing, food, utilities, insurance, minimum debt payments, transportation), then 3-6 months is $15,000–$30,000, not $21,000–$42,000.",
          "<strong>The 3–6 month range exists because client situations differ.</strong> The right number depends on who they are."
        ]},

        { "type": "subheading", "text": "When to lean toward 3 months" },
        { "type": "list", "items": [
          "Stable W-2 employment in a steady industry",
          "Dual-income household where both incomes are stable",
          "Strong professional network, would expect quick re-employment if needed",
          "Robust disability and health insurance",
          "No dependents or low fixed obligations"
        ]},

        { "type": "subheading", "text": "When to lean toward 6 months (or more)" },
        { "type": "list", "items": [
          "Self-employed or commission-based income",
          "Single-income household",
          "Industry or role susceptible to layoffs",
          "Approaching or in retirement (consider 12+ months of expenses in cash)",
          "Significant fixed obligations: mortgage, children's tuition, family support",
          "Health conditions that could affect work capacity"
        ]},

        { "type": "heading", "text": "Where to keep it" },
        { "type": "paragraph", "text": "An emergency fund must be safe and liquid. That's it. Investment returns are not the goal — being able to reach the money fast, in full, without loss, is the goal." },
        { "type": "list", "items": [
          "<strong>High-yield savings account (HYSA)</strong> — the default choice. FDIC-insured up to limits. Same-day access via transfer. Modest interest.",
          "<strong>Money market account</strong> — similar to HYSA at most institutions. Check whether yours has check-writing or debit access, and confirm FDIC insurance.",
          "<strong>Treasury bills, short-term</strong> — for sophisticated clients with larger funds, T-bills via TreasuryDirect or a brokerage can offer competitive yields with similar safety. Less liquid (must wait for sale settlement).",
          "<strong>Checking account</strong> — only for the working capital portion (one to two months). Beyond that, the money should earn at least HYSA interest."
        ]},
        { "type": "callout", "kind": "warn", "title": "Where NOT to keep it", "text": "Not in a brokerage account invested in stocks or bond funds. Not in a Roth IRA \"because contributions can be withdrawn anytime\" — that strategy raids retirement and creates tax-reporting work, and most clients won't remember to replace it. Not in a CD beyond what you're willing to let lock up. Emergency means <em>available right now</em>." },

        { "type": "heading", "text": "When to build vs. invest" },
        { "type": "paragraph", "text": "A common dilemma: a client has $3,000 to allocate. Should it go to the emergency fund or the Roth IRA? The order most planners follow:" },
        { "type": "numbered", "items": [
          "<strong>Minimum debt payments current.</strong> Make every required payment first. Late fees and credit damage swamp any other consideration.",
          "<strong>Build a starter emergency fund: $1,000–$2,500.</strong> Just enough to absorb the standard surprises (car repair, medical copay, broken appliance).",
          "<strong>Capture employer 401(k) match.</strong> A free 50% or 100% return on contributions, up to the match cap. Almost always worth more than other priorities.",
          "<strong>High-interest debt paydown (credit cards, often anything 7%+).</strong> Mathematically beats most investing.",
          "<strong>Build emergency fund to full 3–6 months.</strong>",
          "<strong>Retirement and other tax-advantaged accounts.</strong>",
          "<strong>Taxable investing.</strong>"
        ]},

        { "type": "callout", "kind": "note", "title": "Why this order", "text": "Notice the starter fund comes before debt paydown. The reason: without any cash buffer, the first surprise puts the client back on the credit card and undoes the work. The starter fund is what makes the rest of the plan stick." },

        { "type": "case_study",
          "title": "Naomi reconsiders",
          "scenario": "Naomi has $18,000 in high-yield savings and feels she has \"too much in cash.\" She wants to invest most of it.",
          "discussion": "Naomi's essential monthly expenses are approximately $3,100 (rent $1,750 in a roommate situation, food, utilities, transportation, insurance, student loan minimum). Three months of essentials is $9,300; six months is $18,600. Her $18,000 puts her right at the upper end of the standard range. With stable W-2 employment in a strong industry, dual-income parents nearby, and good benefits, she could reasonably target the lower end. <strong>Recommendation</strong>: Move $9,000 of the $18,000 into a taxable brokerage account allocated to a low-cost diversified portfolio. Keep $9,000 in HYSA. Revisit in 12 months. Notice how the conversation moved from a feeling (\"too much cash\") to a defended number (\"three months essentials, leaning low because of your situation\")."
        }
      ]
    },

    {
      "id": "lesson-6",
      "title": "The Six-Step Planning Workflow",
      "summary": "Discovery to review: the repeatable arc of every engagement.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client engagement, no matter how complex or simple, follows the same six-step arc. The CFP Board codifies this as the standard practice of financial planning. As a counselor, internalizing it means you always know where you are in a relationship and what comes next." },

        { "type": "heading", "text": "Step 1 — Understand the client's situation" },
        { "type": "paragraph", "text": "Sometimes called <em>discovery</em>. This is where you gather quantitative data (income, expenses, balance sheet, tax returns, statements) <strong>and</strong> qualitative data (goals, values, fears, family dynamics, time horizon, risk attitude). The qualitative work is harder and matters more." },
        { "type": "callout", "kind": "do", "title": "What good discovery looks like", "text": "More listening than talking. Open questions over closed ones. Permission asked before getting personal. Notes captured in your own words so you can write them up afterward. Clear next steps documented before the meeting ends." },

        { "type": "heading", "text": "Step 2 — Identify and select goals" },
        { "type": "paragraph", "text": "Most clients arrive with a vague goal (\"I want to be okay in retirement\") and you'll need to help them surface specific, time-bound ones (\"I want to retire at 65 with $80,000/year of inflation-adjusted income that lasts through age 95\"). Clients rarely arrive with their goals pre-clarified. Helping them do that work is half of planning." },

        { "type": "heading", "text": "Step 3 — Analyze the client's current course of action" },
        { "type": "paragraph", "text": "Given everything you know about their situation and goals, does the path they're on get them there? You're running projections: retirement income vs. expected need, cash flow vs. emergency fund target, debt trajectory vs. milestones, insurance coverage vs. exposure." },
        { "type": "paragraph", "text": "This is the math step. Be honest. If the numbers say the current path isn't working, the next step exists to address that." },

        { "type": "heading", "text": "Step 4 — Develop recommendations" },
        { "type": "paragraph", "text": "Recommendations are not generic best practices. They are <em>specific actions</em> for <em>this client</em> that close the gap between their current trajectory and their goals." },
        { "type": "callout", "kind": "key", "title": "Anatomy of a recommendation", "text": "A good recommendation contains: <strong>(1)</strong> the action, <strong>(2)</strong> the rationale tied to the client's goal, <strong>(3)</strong> the trade-offs, and <strong>(4)</strong> alternatives considered. \"Increase 401(k) contribution to 12%\" is a sentence. A recommendation explains why, what it costs in current income, and what was considered instead." },

        { "type": "heading", "text": "Step 5 — Implement the recommendations" },
        { "type": "paragraph", "text": "This is where planning either becomes real or becomes a binder on the shelf. Implementation is operational: forms filed, contributions changed, accounts opened, beneficiaries updated, documents reviewed by the right professionals (attorney for estate work, CPA for tax matters)." },
        { "type": "callout", "kind": "warn", "title": "Where implementation fails", "text": "When recommendations leave the client's office and the next contact is a year later, most of them don't happen. Build implementation into the engagement: check-in calls, written next-step lists, due dates, accountability." },

        { "type": "heading", "text": "Step 6 — Monitor and review" },
        { "type": "paragraph", "text": "Plans are not events. They are living documents that respond to changes in the client's life (new job, marriage, divorce, child, inheritance, illness, retirement) and changes in the world (markets, tax law, regulation). A standard cadence: annual full review with quarterly check-ins. More often when life is moving fast." },

        { "type": "divider" },

        { "type": "activity", "title": "Map the workflow onto a real client", "prompt": "Take the Marcus and Tasha case from Lesson 3. Walk through where they are in the six-step workflow.", "steps": [
          "Step 1: What do you still need to know about them? List five qualitative questions you didn't ask.",
          "Step 2: They said \"we want to save more.\" What's the actual goal you'd help them name? Write it as a specific, time-bound statement.",
          "Step 3: Run their current numbers. Are they on track to anything?",
          "Step 4: Write one specific recommendation, with rationale and trade-off.",
          "Step 5: What needs to happen this week, this month, this quarter for that recommendation to be real?",
          "Step 6: What's the review cadence you'd propose, and why?"
        ]}
      ]
    },

    {
      "id": "lesson-7",
      "title": "Professional Standards",
      "summary": "PII, documentation, and the audit trail that protects everyone.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Counseling is a regulated profession even when it isn't licensed. You handle Social Security numbers, account statements, family secrets, and life decisions worth hundreds of thousands of dollars. The standards in this lesson are not optional and they apply on day one." },

        { "type": "heading", "text": "Personally identifiable information (PII)" },
        { "type": "paragraph", "text": "PII is any data that can identify a specific individual. The categories you'll encounter daily:" },
        { "type": "list", "items": [
          "<strong>Direct identifiers</strong> — full name, SSN, date of birth, driver's license, passport, home address, email, phone.",
          "<strong>Financial identifiers</strong> — account numbers, routing numbers, brokerage account IDs, credit card numbers.",
          "<strong>Sensitive personal data</strong> — health information, family records, beneficiary designations, immigration status."
        ]},

        { "type": "callout", "kind": "key", "title": "The minimum-necessary principle", "text": "Collect only the PII you need to do the work. Don't ask for an SSN to open a planning relationship; you need it to open accounts. Don't collect last year's full tax return when you only need the W-2. The less you handle, the less can leak." },

        { "type": "heading", "text": "Storage and handling rules" },
        { "type": "list", "items": [
          "<strong>No PII in email or chat.</strong> Use the firm's secure portal. If a client emails you a statement, you respond to the email but do not leave the document attached in your reply.",
          "<strong>No PII on personal devices.</strong> Firm laptop only, with disk encryption.",
          "<strong>No printed PII left unattended.</strong> Lock-and-shred. If you print a tax return, it does not leave your desk and it goes through the shredder before you leave for the day.",
          "<strong>Verbal disclosure.</strong> Don't read account numbers aloud in a client meeting if the spouse hasn't been disclosed, in a conference room with the door open, or anywhere the conversation can be overheard."
        ]},

        { "type": "heading", "text": "Documentation discipline" },
        { "type": "paragraph", "text": "Every client interaction generates a record. The standard:" },
        { "type": "list", "items": [
          "<strong>Capture the meeting</strong> in your own words within 24 hours: date, time, attendees, what was discussed, what was decided, what comes next.",
          "<strong>Note the source</strong> for every number that lands in a plan. \"Income: $148,000 (per 2024 W-2, dated 1/31/2025).\" Not just the number.",
          "<strong>Document recommendations and rationale.</strong> Why you recommended what you did, and what alternatives you considered. This is the file the firm's compliance team — or, in a worst case, regulators — will read.",
          "<strong>Note objections and approvals.</strong> If the client declines a recommendation, document it. If a supervisor approves an exception, document it."
        ]},

        { "type": "heading", "text": "The audit trail" },
        { "type": "paragraph", "text": "An audit trail means: someone two years from now can pick up the file and reconstruct what happened and why. Your future self will be this person, and so will compliance, and possibly so will the client's attorney or a regulator. Build the trail as you go — it cannot be reconstructed later." },

        { "type": "callout", "kind": "do", "title": "The end-of-day discipline", "text": "Five minutes at the end of each day: are my notes from today's meetings in the system? Are open items on my task list? Are physical documents secured? This habit is the difference between a counselor who looks professional and one who is." },

        { "type": "heading", "text": "When to escalate" },
        { "type": "paragraph", "text": "Some moments require immediate supervisor involvement. Memorize them:" },
        { "type": "list", "items": [
          "Client makes a request that feels outside policy or compliance.",
          "Client discloses something that suggests impairment, abuse, or coercion.",
          "Client wants to do something that doesn't fit their stated risk tolerance or suitability.",
          "Client requests a transaction in an account they don't legally control.",
          "Anything involving suspected identity theft, fraud, or unusual money movement.",
          "Any moment you don't know what to do — escalate. The cost of escalation is small; the cost of not escalating can be large."
        ]},

        { "type": "callout", "kind": "key", "title": "The frame for everything in this lesson", "text": "Compliance is not paperwork that gets in the way of helping clients. Compliance is <strong>how</strong> the help happens. The discipline that protects PII is the same discipline that protects the relationship. The audit trail that compliance wants is the same record the client wants when they ask, six months later, what we discussed and why." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A client tells you they earn $90,000 a year. Before you do anything useful with that number, what should you confirm?",
        "options": [
          "Whether they have any side income.",
          "Whether the figure is gross or net.",
          "Whether they have direct deposit.",
          "Whether they expect a raise this year."
        ],
        "correct": 1,
        "explanation": "Almost every cash flow and budgeting decision happens in net (take-home) terms. Clients almost always quote gross. Confirming which number you're working with is the first reflex of a competent counselor."
      },
      {
        "id": "q2",
        "prompt": "Which expense category is the most common reason household budgets fail?",
        "options": [
          "Fixed monthly expenses like rent.",
          "Variable expenses like groceries.",
          "Periodic (irregular) expenses like annual insurance and holiday gifts.",
          "Subscription services."
        ],
        "correct": 2,
        "explanation": "Periodic expenses don't show up monthly but are real. Households that don't annualize and budget for them are repeatedly surprised. Sinking funds exist specifically to solve this."
      },
      {
        "id": "q3",
        "prompt": "Net worth is best described as:",
        "options": [
          "Monthly income minus monthly expenses.",
          "Total assets minus total liabilities.",
          "Gross income for the year.",
          "The market value of investments."
        ],
        "correct": 1,
        "explanation": "Net worth measures position: what the household owns minus what it owes. Income and expenses measure flow, not position."
      },
      {
        "id": "q4",
        "prompt": "A client is solvent but illiquid. What does this mean in practice?",
        "options": [
          "They have positive net worth but most of it is tied up in assets that can't be quickly converted to cash.",
          "They have more debt than assets.",
          "They have plenty of cash but a low credit score.",
          "Their income exceeds their expenses but only barely."
        ],
        "correct": 0,
        "explanation": "Solvent means positive net worth; liquid means easy access to cash. A client with most of their wealth in a home and a 401(k) can be solvent but face a real crisis when the water heater breaks."
      },
      {
        "id": "q5",
        "prompt": "Under the 50/30/20 framework, what does the 30% category cover?",
        "options": [
          "Needs: housing, food, utilities, insurance.",
          "Savings and debt payoff beyond minimums.",
          "Wants: dining out, entertainment, hobbies, subscriptions.",
          "Taxes and other government obligations."
        ],
        "correct": 2,
        "explanation": "50% needs, 30% wants, 20% savings/debt-payoff above minimums. The 30% is discretionary spending — what the client would call \"the fun stuff\" or things they could cut if they had to."
      },
      {
        "id": "q6",
        "prompt": "A client has irregular self-employment income and feels overwhelmed by their finances. Which budgeting framework is generally the best fit?",
        "options": [
          "50/30/20 — it's simpler.",
          "Zero-based budgeting — every dollar gets a job.",
          "Sinking funds only.",
          "Encourage them to skip budgeting and just save what's left at month-end."
        ],
        "correct": 1,
        "explanation": "Zero-based budgeting is the gold standard for clients with income volatility or who feel out of control. Every dollar of (conservative baseline) income is assigned a purpose. Higher-income months become windfall planning."
      },
      {
        "id": "q7",
        "prompt": "The standard rule of thumb for emergency fund size is:",
        "options": [
          "1–2 months of gross income.",
          "Six weeks of total expenses.",
          "3–6 months of essential expenses.",
          "$10,000 regardless of household."
        ],
        "correct": 2,
        "explanation": "Three to six months of essential (not total) expenses. The range exists because client situations differ: stable W-2 employment leans lower; self-employment, single income, or older clients lean higher."
      },
      {
        "id": "q8",
        "prompt": "Why is a 'starter' emergency fund ($1,000–$2,500) typically built BEFORE aggressively paying down high-interest credit card debt?",
        "options": [
          "Because savings always earns more than credit cards charge.",
          "Because without any cash cushion, the next surprise forces the client back onto the credit card and undoes the paydown work.",
          "Because IRS rules require it.",
          "Because credit cards charge fees on accounts with no savings."
        ],
        "correct": 1,
        "explanation": "Without a cushion, the first surprise (car repair, medical copay) puts the client back on the card. The starter fund is the structural piece that makes the rest of the plan stick."
      },
      {
        "id": "q9",
        "prompt": "Where is the appropriate place to keep emergency fund money?",
        "options": [
          "A taxable brokerage account invested in a balanced portfolio.",
          "A Roth IRA, because contributions can be withdrawn.",
          "A high-yield savings account or similar FDIC-insured product.",
          "A long-term certificate of deposit."
        ],
        "correct": 2,
        "explanation": "An emergency fund must be safe and liquid. High-yield savings accounts are the standard: FDIC insured, same-day access, modest interest. Investment returns are explicitly not the goal."
      },
      {
        "id": "q10",
        "prompt": "Which of the following is the correct order of the CFP Board's six-step planning workflow?",
        "options": [
          "Recommend → Analyze → Implement → Monitor → Goals → Understand.",
          "Understand the situation → Identify goals → Analyze current course → Develop recommendations → Implement → Monitor.",
          "Implement → Recommend → Goals → Analyze → Monitor → Understand.",
          "Goals → Recommend → Understand → Analyze → Implement → Monitor."
        ],
        "correct": 1,
        "explanation": "The six steps are: (1) Understand the client's situation, (2) Identify and select goals, (3) Analyze the current course of action, (4) Develop recommendations, (5) Implement, (6) Monitor and review."
      },
      {
        "id": "q11",
        "prompt": "A complete recommendation, per the standard of practice, includes:",
        "options": [
          "Just the action.",
          "The action and the cost.",
          "The action, the rationale tied to the goal, the trade-offs, and alternatives considered.",
          "Whatever fits on one page."
        ],
        "correct": 2,
        "explanation": "A recommendation isn't an instruction — it's an argument. It contains the specific action, why it's the right action given the client's goal, what trade-offs it requires, and what alternatives you considered. This is also what makes a recommendation defensible later."
      },
      {
        "id": "q12",
        "prompt": "Which of the following is consistent with professional handling of personally identifiable information (PII)?",
        "options": [
          "Sending a client's tax return back to them as an email attachment.",
          "Reading account numbers aloud in an open conference room.",
          "Following the minimum-necessary principle — collecting only the PII actually required for the work.",
          "Storing client documents on a personal home laptop for convenience."
        ],
        "correct": 2,
        "explanation": "Minimum-necessary is the rule: collect only what's needed. The other three answers describe direct violations of standard PII handling: no PII over insecure email, no audible disclosure in non-private spaces, no firm data on personal devices."
      },
      {
        "id": "q13",
        "prompt": "Naomi (age 34, $90k W-2 salary, stable industry, dual-income parents nearby, 18 months in current role) has $18,000 in high-yield savings. Her essential monthly expenses are $3,100. Which is the most defensible recommendation?",
        "options": [
          "Move all $18,000 into a taxable brokerage account immediately.",
          "Increase HYSA to $30,000 before any investing.",
          "Keep roughly $9,000–$10,000 in HYSA (3 months essentials, leaning low given her stability) and invest the remainder in a diversified taxable portfolio.",
          "Use $18,000 to pay down her student loans."
        ],
        "correct": 2,
        "explanation": "Three to six months of essentials puts her range at $9,300–$18,600. Given her stable W-2 employment, strong industry, and support network, leaning toward the lower end of the range is defensible. The exercise turns a feeling (\"too much cash\") into a defended number."
      },
      {
        "id": "q14",
        "prompt": "A client asks you about a transaction that involves an account owned by their elderly parent, who is not in the meeting and hasn't been disclosed. What's the correct response?",
        "options": [
          "Help them, since they're family.",
          "Refuse and end the meeting immediately.",
          "Pause, decline to proceed without the account owner's involvement, and escalate to a supervisor.",
          "Suggest they send the parent's account credentials over email so you can review."
        ],
        "correct": 2,
        "explanation": "Pause, decline, escalate. Requests involving an account the client doesn't legally control require immediate supervisor involvement. The cost of escalation is small; the cost of doing nothing can be large, including elder financial abuse situations."
      },
      {
        "id": "q15",
        "prompt": "Which statement best captures the right relationship between compliance discipline and serving clients well?",
        "options": [
          "Compliance is paperwork that slows down real client work.",
          "Compliance is how the help happens — the same discipline that protects PII is the discipline that protects the relationship.",
          "Compliance only matters in audits.",
          "Compliance is the supervisor's job, not the counselor's."
        ],
        "correct": 1,
        "explanation": "Compliance and good client service are the same thing, not opposites. The notes that protect PII are the notes the client wants when they ask six months later what was discussed. The audit trail compliance requires is the same record that lets you serve the client well over time."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 1;

-- ============================================================================
-- DONE.
-- This module remains in 'draft' status until Cathy Jackson-Gent approves it
-- through the admin UI. Apprentices won't see it until then. Administrators
-- will see the "Drafted · Awaiting Review" badge on the module.
-- ============================================================================
