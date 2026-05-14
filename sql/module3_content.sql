-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 3 CONTENT
-- Credit, Debt, and Lending
-- ============================================================================
-- Updates module 3 metadata + content. Status remains 'draft' until Cathy
-- Jackson-Gent approves via the admin UI. Safe to re-run; uses UPDATE.
-- ============================================================================

update public.modules set
  title = 'Credit, Debt, and Lending',
  competency_id = 'CORE-3',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How credit works, how debt structures differ, and how an advisor distinguishes strategic borrowing from destructive borrowing.',
  learning_objectives = ARRAY[
    'Explain the five FICO score factors and how each can be improved.',
    'Distinguish revolving from installment debt and secured from unsecured debt.',
    'Read an APR disclosure correctly and compute the true cost of a loan.',
    'Compare avalanche, snowball, and consolidation strategies — and pick the right one for a given client.',
    'Identify when borrowing serves the plan and when it undermines it.',
    'Walk a client through a credit report and explain what to fix and what to leave alone.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "How Credit Actually Works",
      "summary": "Credit scores, reports, and the levers that move them.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Credit is one of the most important financial systems most clients interact with — and one of the most misunderstood. A Wealth Solutions Counselor doesn't need to be a credit repair specialist, but does need to explain credit clearly, identify what's helping and hurting a client's score, and know when to refer out." },

        { "type": "heading", "text": "The credit score" },
        { "type": "paragraph", "text": "Most U.S. credit decisions use a <strong>FICO score</strong> (300–850) or the competing <strong>VantageScore</strong>. Both predict the same thing: likelihood the borrower will pay back what's owed. Higher score = better rates, more options, lower deposits. Below ~620 = subprime, materially worse terms. Above ~740 = prime, best terms generally available." },

        { "type": "callout", "kind": "key", "title": "The five FICO factors", "text": "<strong>Payment history (35%)</strong>, <strong>amounts owed / utilization (30%)</strong>, <strong>length of credit history (15%)</strong>, <strong>credit mix (10%)</strong>, <strong>new credit (10%)</strong>. Memorize this. It explains almost every score-related question a client will ever ask." },

        { "type": "subheading", "text": "Payment history (35%)" },
        { "type": "paragraph", "text": "On-time payments build score; late payments wreck it. A single 30-day-late payment can drop a prime score by 50–100 points. Late payments hang on a credit report for seven years, though their weight fades over time." },

        { "type": "subheading", "text": "Amounts owed / credit utilization (30%)" },
        { "type": "paragraph", "text": "Specifically, <em>revolving</em> utilization — credit card balances as a percentage of credit limits. A client with $2,000 owed across cards with $10,000 in limits has 20% utilization." },
        { "type": "callout", "kind": "do", "title": "The utilization target", "text": "Keep total revolving utilization under 30%. Under 10% is better for top scores. This is the single fastest score lever a client can pull — paying down a card by a few hundred dollars can move a score within one billing cycle." },

        { "type": "subheading", "text": "Length of credit history (15%)" },
        { "type": "paragraph", "text": "Average age of accounts matters. Older accounts help; new accounts shorten the average and ding the score temporarily. This is why closing an old credit card can <em>lower</em> a score even though intuition says the opposite." },

        { "type": "subheading", "text": "Credit mix (10%)" },
        { "type": "paragraph", "text": "Having both revolving (credit cards) and installment (auto loan, mortgage, student loan) accounts demonstrates broader credit competence. Don't take on debt just to improve mix — the gain is small. But if the mix is unbalanced and other factors are clean, this is the explanation." },

        { "type": "subheading", "text": "New credit (10%)" },
        { "type": "paragraph", "text": "Hard inquiries (when a lender pulls credit for an application) lower the score slightly and stay on the report for two years. One or two are fine. Several in a short period look like financial distress and add up. Note: rate-shopping for the same loan type within ~14–45 days typically counts as a single inquiry." },

        { "type": "divider" },

        { "type": "heading", "text": "The credit report" },
        { "type": "paragraph", "text": "The score is a summary. The <strong>credit report</strong> is the underlying data, produced by three bureaus: Equifax, Experian, and TransUnion. By federal law, every consumer can pull their three reports for free weekly at <em>AnnualCreditReport.com</em>. Doing so does not affect the score (it's a soft inquiry)." },
        { "type": "paragraph", "text": "A credit report contains:" },
        { "type": "list", "items": [
          "<strong>Personal info</strong> — name, address history, employers.",
          "<strong>Accounts</strong> — every open and recently closed credit account, with balances, limits, payment status, and open dates.",
          "<strong>Public records</strong> — bankruptcies (still appear), some judgments and tax liens (mostly removed since 2017, but check).",
          "<strong>Inquiries</strong> — hard and soft pulls of the report."
        ]},

        { "type": "callout", "kind": "warn", "title": "What to check immediately", "text": "Identity theft and reporting errors are common. When you review a client's report, watch for: accounts the client doesn't recognize, addresses they've never lived at, payment lates the client disputes, balances that look wrong. The <em>fix</em> is filing a dispute with the bureau (free, online), but the <em>spotting</em> is the advisor's job." },

        { "type": "activity", "title": "Pull and read your own report", "prompt": "You cannot competently walk a client through this until you've done it yourself.", "steps": [
          "Go to AnnualCreditReport.com and request your three reports (one from each bureau — they're free).",
          "Read each one. Look for errors, unfamiliar accounts, or addresses you don't recognize.",
          "Note the differences between bureaus. They often have slightly different data.",
          "Identify which of the five FICO factors are working for you and which against. Where could you most easily improve?",
          "Save the experience. This is how the conversation feels for a client — you'll be more useful having done it."
        ]}
      ]
    },

    {
      "id": "lesson-2",
      "title": "Types of Debt and How They Differ",
      "summary": "Revolving vs. installment, secured vs. unsecured, and why the structure matters.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "All debt is not the same. Two dimensions describe most consumer debt — <em>how it's structured</em> (revolving vs. installment) and <em>what backs it</em> (secured vs. unsecured). The cross between them determines pricing, risk, and the right advisor move." },

        { "type": "heading", "text": "Revolving vs. installment" },
        { "type": "glossary", "terms": [
          { "term": "Revolving debt", "definition": "A line of credit with a limit. The borrower can draw, repay, and re-draw. Minimum monthly payments, interest accrues on the unpaid balance. Examples: credit cards, home equity lines of credit (HELOCs), some personal lines." },
          { "term": "Installment debt", "definition": "A fixed loan amount with a scheduled repayment period and (usually) fixed payments. The balance can't be re-drawn. Examples: mortgages, auto loans, most student loans, personal loans." }
        ]},
        { "type": "paragraph", "text": "Revolving debt is more flexible and more dangerous. The flexibility is what makes it useful in emergencies; the danger is that without discipline, balances grow indefinitely. Installment debt is rigid in the opposite direction — you can't borrow more without applying again, but the schedule guarantees the debt ends." },

        { "type": "heading", "text": "Secured vs. unsecured" },
        { "type": "glossary", "terms": [
          { "term": "Secured debt", "definition": "Backed by collateral the lender can seize if payments stop. Examples: mortgages (house), auto loans (car), HELOCs (house). Lower interest rates because the lender's downside is protected." },
          { "term": "Unsecured debt", "definition": "Not backed by collateral. The lender's only recourse is the borrower's promise and the credit/legal system. Examples: credit cards, most personal loans, most student loans, medical debt. Higher interest rates to compensate for the higher risk." }
        ]},
        { "type": "callout", "kind": "key", "title": "Why this matters in a plan", "text": "When a household is in distress, secured debt comes first in the payment priority — losing the house or the car is catastrophic. Unsecured debt has more flexibility in workout, settlement, or even bankruptcy. The order in which a household sacrifices and which debts get paid in a crunch follows this logic." },

        { "type": "divider" },

        { "type": "heading", "text": "Typical interest ranges (general benchmarks, vary by market)" },
        { "type": "list", "items": [
          "<strong>30-year fixed mortgage</strong> — historically 3–8%, varies enormously by rate environment. Secured, installment, lowest rates.",
          "<strong>Auto loans</strong> — 4–10% for prime credit, higher for subprime. Secured, installment.",
          "<strong>Federal student loans</strong> — set by Congress annually, often 4–8%. Mostly unsecured but with special status (extremely hard to discharge in bankruptcy).",
          "<strong>HELOCs</strong> — typically variable rate, near or slightly above prime. Secured by the home.",
          "<strong>Personal loans</strong> — 6–15% for prime credit, much higher for subprime. Unsecured installment.",
          "<strong>Credit cards</strong> — 15–30% APR is typical. Unsecured revolving. Rates are <em>not</em> set by inflation or central bank in any direct way — they are set by issuer profitability and credit risk."
        ]},

        { "type": "case_study",
          "title": "The household with five debts",
          "scenario": "A household carries: $12,000 credit card at 22% APR, $18,000 auto loan at 6.5%, $34,000 student loans at 5%, $310,000 mortgage at 4%, $8,000 medical debt at 0%. They have $400/month available beyond minimums and want to know what to do.",
          "discussion": "<p>Mathematically, the credit card at 22% is the highest-cost debt by a wide margin. Every dollar applied there earns a guaranteed 22% return on capital — far better than almost any investment. <strong>Avalanche logic says credit card first</strong>.</p><p>But notice the others: the medical debt at 0% can wait (as long as it's not being sent to collections). The mortgage at 4% probably should not be accelerated — that money outperforms a 4% mortgage rate by most reasonable definitions. The auto loan at 6.5% is borderline; depends on the client's expected portfolio return and emotional preference for being debt-free.</p><p>The full ranked recommendation is: <strong>1) Pay credit card to zero — fastest mathematical win.</strong> <strong>2) Build/restore emergency fund.</strong> <strong>3) Address auto loan or invest the surplus — depends on client preference.</strong> <strong>4) Mortgage and student loans on schedule unless rates rise.</strong> <strong>5) Medical debt — monitor, negotiate if possible, but not a priority while interest-free.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Interest Rates, APR, and the True Cost of Borrowing",
      "summary": "Reading the disclosure correctly — and finding the real number.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "When a lender quotes a rate, the client hears one number. The actual cost can be very different. A competent advisor reads the disclosure carefully and explains what the client is actually paying — not what's on the marketing page." },

        { "type": "heading", "text": "Interest rate vs. APR" },
        { "type": "glossary", "terms": [
          { "term": "Interest rate", "definition": "The cost of borrowing the principal, expressed as a percentage. The headline number on most loans." },
          { "term": "APR (Annual Percentage Rate)", "definition": "The interest rate plus most fees that are required to obtain the loan, expressed as an annual rate. APR is always equal to or higher than the interest rate. Required by the Truth in Lending Act for most consumer loans." },
          { "term": "APY (Annual Percentage Yield)", "definition": "Used for deposit accounts, not loans. Reflects compounding frequency on what the bank pays you." },
          { "term": "Points", "definition": "Fees paid at closing, expressed as a percentage of the loan. One point = 1% of loan amount. Buying points lowers the interest rate; whether it's worth it depends on how long the borrower keeps the loan." }
        ]},

        { "type": "callout", "kind": "key", "title": "The rule of thumb", "text": "<strong>Always compare loans by APR, not by quoted interest rate.</strong> The APR includes the fees. A loan with a low rate and high fees can have the same or higher APR than a loan with a higher rate and no fees." },

        { "type": "heading", "text": "Reading a mortgage disclosure" },
        { "type": "paragraph", "text": "Federal Truth in Lending and TRID rules require lenders to give borrowers a standardized <strong>Loan Estimate</strong> within three days of application and a <strong>Closing Disclosure</strong> at least three days before closing. Both spell out interest rate, APR, fees, payment, and total cost of credit." },
        { "type": "subheading", "text": "What an advisor should check" },
        { "type": "list", "items": [
          "<strong>Interest rate and APR</strong> — the gap between them tells you how much of the price is fees. A small gap (10–30 bps) is normal; a large gap (50+ bps) means meaningful closing costs.",
          "<strong>Loan term</strong> — 30-year vs. 15-year vs. 20-year. Longer terms have lower payments and higher total interest.",
          "<strong>Type</strong> — fixed-rate or ARM? If ARM, how does it adjust and when?",
          "<strong>Points</strong> — are points being purchased? Is the buydown worth it given the expected holding period?",
          "<strong>Origination fees, lender credits, third-party fees</strong> — itemized on the disclosure. Are any negotiable?",
          "<strong>PMI</strong> — required when down payment is below 20% on a conventional loan. Confirm whether and when it falls off.",
          "<strong>Escrows</strong> — taxes and insurance held in escrow. Confirm the monthly amount and that the estimate is reasonable for the property."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Credit card interest in particular" },
        { "type": "paragraph", "text": "Credit card APRs work differently from installment loan APRs. Interest accrues <em>daily</em> on the unpaid balance. There's a grace period — typically 21+ days between statement and due date — during which no interest accrues <em>if</em> the previous balance was paid in full." },
        { "type": "callout", "kind": "warn", "title": "The grace period trap", "text": "Once a balance is carried, the grace period disappears until the balance is fully paid off again, including the most recent month's purchases. New purchases start accruing interest immediately. Many clients don't realize this; they think only the carried balance is charged interest. Worth explaining clearly." },

        { "type": "subheading", "text": "Why minimum payments are toxic" },
        { "type": "paragraph", "text": "A credit card minimum payment is typically the larger of $25 or about 2% of the balance. On a $5,000 balance at 22% APR, the minimum payment is roughly $100/month. Paying only the minimum:" },
        { "type": "list", "items": [
          "Takes approximately <strong>22 years</strong> to pay off the $5,000.",
          "Total interest paid: roughly <strong>$7,000</strong>.",
          "Total amount repaid: roughly <strong>$12,000</strong> on the original $5,000 balance."
        ]},
        { "type": "callout", "kind": "key", "title": "The math that motivates clients", "text": "Walk a client through this calculation. \"Minimum payment\" sounds responsible; the math shows it isn't. The same client paying $200/month instead of $100 would clear the balance in roughly 3 years and pay less than $2,000 in interest. That's a behavior-change conversation made possible by the math, not by lecturing." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Debt Paydown Strategies",
      "summary": "Avalanche, snowball, consolidation, and refinance — when each one fits.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Once a client has multiple debts and some surplus to apply, the strategy question becomes: <em>which one first?</em> The advisor's job is to walk through the options honestly, pick the one most likely to succeed given the client, and document the rationale." },

        { "type": "heading", "text": "Strategy 1 — Avalanche" },
        { "type": "paragraph", "text": "Pay minimums on all debts. Apply every extra dollar to the <strong>highest-interest-rate</strong> debt until it's gone. Then roll that payment into the next-highest, and so on." },
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Mathematically optimal. Best for clients who are motivated by logic and willing to grind. Saves the most interest. The default recommendation when the only consideration is total cost." },
        { "type": "callout", "kind": "warn", "title": "Watch out for", "text": "Can be demoralizing if the highest-rate debt is also the largest balance — the client makes payments for months without seeing a balance disappear. Behavioral fatigue is real and breaks plans." },

        { "type": "heading", "text": "Strategy 2 — Snowball" },
        { "type": "paragraph", "text": "Pay minimums on all debts. Apply every extra dollar to the <strong>smallest-balance</strong> debt until it's gone. Then roll that payment into the next-smallest." },
        { "type": "callout", "kind": "do", "title": "Best for", "text": "Clients who need momentum. Wiping out a debt — any debt — produces a behavioral payoff that keeps the plan moving. For clients who've tried and failed at paydown before, snowball is often the better recommendation even though it costs slightly more in total interest." },
        { "type": "callout", "kind": "note", "title": "The honest math", "text": "Research suggests the snowball method results in higher rates of follow-through and ultimate success than avalanche, despite costing slightly more in interest. The cheapest debt-paydown plan is the one the client actually completes." },

        { "type": "heading", "text": "Strategy 3 — Consolidation" },
        { "type": "paragraph", "text": "Combine multiple debts into a single new loan at a lower rate. Most commonly: rolling several credit cards into a personal loan, or using a balance transfer card with a 0% introductory rate." },
        { "type": "subheading", "text": "When consolidation makes sense" },
        { "type": "list", "items": [
          "The new rate is materially lower than the weighted average rate of the existing debts.",
          "The client has the discipline not to run up the original cards again. (This is the trap that ruins most consolidations.)",
          "The consolidation product itself doesn't carry hidden fees that erode the savings.",
          "The repayment term doesn't extend so far that total interest paid is higher despite the lower rate."
        ]},
        { "type": "callout", "kind": "warn", "title": "The most common failure mode", "text": "Client consolidates credit cards into a personal loan, then runs the cards back up over the next year. Now they have the personal loan <em>and</em> the cards. Total debt is higher than where they started. Consolidation must be paired with a credit-behavior change — sometimes literally cutting up the cards — or it makes things worse." },

        { "type": "heading", "text": "Strategy 4 — Refinance" },
        { "type": "paragraph", "text": "Replace an existing installment loan with a new one at better terms. Most common: mortgages and student loans." },
        { "type": "subheading", "text": "The refinance calculation" },
        { "type": "paragraph", "text": "Refinance is a math problem with two main inputs:" },
        { "type": "list", "items": [
          "<strong>Monthly savings</strong> = old payment − new payment.",
          "<strong>Closing costs</strong> = total cost of doing the refinance (often 2–5% of loan amount on mortgages).",
          "<strong>Break-even months</strong> = closing costs ÷ monthly savings."
        ]},
        { "type": "paragraph", "text": "If the client plans to stay in the home longer than the break-even period, the refinance pays for itself. If they're likely to move before break-even, it doesn't. Anything beyond break-even is pure savings." },
        { "type": "callout", "kind": "do", "title": "The rule of thumb", "text": "A 1% rate reduction typically justifies refinance if the client will hold the loan 3+ more years. Smaller rate reductions can still work if closing costs are low (or rolled into the loan) and the time horizon is long. Always run the actual numbers — rules of thumb aren't recommendations." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "Picking the right strategy",
          "scenario": "Devon (small business owner from Module 1) has: $14,000 in credit cards (avg 23% APR), $7,000 personal loan at 11%, $22,000 auto loan at 6.5%, and $1,500 medical debt at 0%. He has $600/month available beyond minimums.",
          "discussion": "<p>Pure avalanche says credit cards first (highest rate). Pure snowball says medical debt first (smallest balance), then personal loan, then auto, then cards. Consolidation could work if Devon qualifies for a personal loan at, say, 9% to clear the cards.</p><p>Real recommendation: <strong>hybrid</strong>. Start with the medical debt — it's small enough that the $600/month would clear it in 3 months, building momentum and removing a billing relationship. Then attack credit cards aggressively while exploring a consolidation loan or balance transfer card. If a 0% balance transfer is available with a reasonable fee, consider it — but only after Devon agrees to stop using the cards. This gets the snowball motivation AND the avalanche savings, which is often the right combination for a small business owner whose energy is more constrained than their income.</p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Strategic Debt vs. Destructive Debt",
      "summary": "Borrowing that serves the plan, and borrowing that quietly destroys it.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "\"All debt is bad\" is a slogan, not a financial philosophy. Some debt is the cheapest path to a goal a client could not otherwise reach in any reasonable timeframe. Some debt is a slow leak that compounds against the client for years. The advisor's job is knowing the difference and being able to explain it." },

        { "type": "heading", "text": "What makes debt strategic" },
        { "type": "list", "items": [
          "<strong>The asset being financed appreciates or generates cash flow.</strong> A mortgage finances a house that historically appreciates and provides shelter (saving rent). A business loan finances assets that generate revenue.",
          "<strong>The interest rate is materially below the expected return on alternatives.</strong> Borrowing at 3% to invest in something expected to return 7% is, in expectation, profitable — though risk and behavior complicate the picture.",
          "<strong>The term is appropriate to the asset.</strong> Match financing term to the useful life of what's being financed. 30-year mortgages on 30+ year assets, 5-year auto loans on cars driven 5+ years.",
          "<strong>The interest is tax-deductible</strong> (where applicable). Mortgage interest, student loan interest in certain ranges, business loan interest."
        ]},

        { "type": "heading", "text": "What makes debt destructive" },
        { "type": "list", "items": [
          "<strong>Financing depreciating consumption.</strong> Carrying credit card debt for vacations, dining, clothing. The experience is gone; the debt remains.",
          "<strong>Rates that exceed reasonable returns.</strong> 22% credit card debt is a guaranteed −22% on whatever cash isn't applied to it. No reasonable investment strategy beats paying off high-rate revolving debt.",
          "<strong>Structures that resist payoff.</strong> Payday loans, rent-to-own, certain title loans — designed to maximize rollover fees and trap borrowers.",
          "<strong>Borrowing to maintain a lifestyle that income doesn't support.</strong> If a household is going further into debt every month, the structure is broken. More borrowing makes it worse, not better."
        ]},

        { "type": "callout", "kind": "key", "title": "The advisor reframe", "text": "Don't ask \"is debt bad?\" Ask: \"<em>what is this debt accomplishing, at what cost, and is there a cheaper way to accomplish the same thing?</em>\" That question converts a moral debate into a planning conversation." },

        { "type": "divider" },

        { "type": "heading", "text": "The borrowing-to-invest question" },
        { "type": "paragraph", "text": "Wealth Solutions Counselor often encounter the question: <em>should I pay off my mortgage faster or invest the extra?</em> The math says invest if expected returns exceed mortgage rate; the behavior says pay down debt if the client sleeps better that way. Both are defensible. Document the reasoning either way." },

        { "type": "case_study",
          "title": "When the math and the behavior diverge",
          "scenario": "A 50-year-old client with $200,000 mortgage at 3.5%, 20 years remaining, has $50,000 of after-tax cash she's considering applying to the mortgage. Her expected after-tax portfolio return is 6%. She is risk-averse and disliked the 2022 market.",
          "discussion": "<p>Math says invest the $50,000. Expected return 6% vs. 3.5% borrowing cost — about 2.5 percentage points of arbitrage, compounded for 20 years. Material difference.</p><p>Behavior says know your client. If she will panic-sell in the next downturn, the 6% expected return is fictional; she'll capture a much lower realized return. If she would sleep better with the mortgage smaller, the psychological return on the mortgage paydown is real.</p><p>The honest recommendation: <strong>split it.</strong> $25,000 to the mortgage, $25,000 to a taxable brokerage. She gets meaningful debt reduction and meaningful investment exposure. Document the trade-off in writing so when she's evaluating the decision in 5 years, she remembers what we were optimizing for. <em>This is the kind of recommendation a calculator can't generate but a counselor can.</em></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which of the following is the largest factor in a FICO score?",
        "options": [
          "Length of credit history (15%)",
          "New credit (10%)",
          "Payment history (35%)",
          "Credit mix (10%)"
        ],
        "correct": 2,
        "explanation": "Payment history is 35% — the largest single factor. Amounts owed (utilization) is second at 30%. Everything else trails."
      },
      {
        "id": "q2",
        "prompt": "What is the recommended maximum revolving credit utilization for a good FICO score?",
        "options": [
          "Below 50%",
          "Below 30%, ideally below 10%",
          "Below 75%",
          "Utilization doesn't affect the score."
        ],
        "correct": 1,
        "explanation": "Keep utilization under 30%; under 10% is better for top scores. It's the single fastest lever a client can pull — paying down a card can move a score within one billing cycle."
      },
      {
        "id": "q3",
        "prompt": "A client wants to know whether closing an old, unused credit card will help or hurt their score. The correct answer is:",
        "options": [
          "Always helps; less available credit looks better to lenders.",
          "Likely hurts: it shortens average account age and reduces total available credit, which raises utilization.",
          "Doesn't matter to the score either way.",
          "Helps if the card has an annual fee, hurts otherwise."
        ],
        "correct": 1,
        "explanation": "Closing an old card shortens average credit history (length factor, 15%) and lowers total available revolving credit, which raises utilization on remaining balances (amounts owed, 30%). Both effects pull the score down — the opposite of what most clients expect."
      },
      {
        "id": "q4",
        "prompt": "Which best describes the difference between interest rate and APR?",
        "options": [
          "They are the same thing.",
          "APR is the interest rate plus most required fees, expressed annually. APR is always equal to or higher than the interest rate.",
          "APR is what the bank actually charges; interest rate is the marketing number.",
          "APR is for deposits, interest rate is for loans."
        ],
        "correct": 1,
        "explanation": "APR captures fees that are required to obtain the loan — origination, points, certain closing costs. Always compare loans by APR, not by quoted interest rate, because two loans with the same rate can have very different total cost depending on fees."
      },
      {
        "id": "q5",
        "prompt": "A client has $5,000 of credit card debt at 22% APR and is making only minimum payments (about $100/month). Approximately how long will it take to pay off the balance?",
        "options": [
          "About 5 years",
          "About 10 years",
          "About 22 years",
          "About 40 years"
        ],
        "correct": 2,
        "explanation": "Roughly 22 years, with about $7,000 in total interest paid on the original $5,000 balance. Walking a client through this calculation is one of the most behavior-changing conversations in personal finance."
      },
      {
        "id": "q6",
        "prompt": "Which debt-paydown strategy is mathematically optimal?",
        "options": [
          "Snowball — smallest balance first.",
          "Avalanche — highest interest rate first.",
          "Consolidation — combine all debts into one.",
          "Refinance — replace existing debt with a new loan."
        ],
        "correct": 1,
        "explanation": "Avalanche (highest rate first) saves the most interest mathematically. But snowball often produces better real-world results because momentum aids follow-through. The cheapest plan is the one the client actually completes."
      },
      {
        "id": "q7",
        "prompt": "When does consolidation typically make sense?",
        "options": [
          "Always — fewer payments is always better.",
          "When the new rate is materially lower, the term doesn't blow out, and the client agrees not to run up the old accounts.",
          "When the client wants to feel less stressed about debt.",
          "When the consolidation lender offers it; lenders only offer it when it's beneficial."
        ],
        "correct": 1,
        "explanation": "Consolidation works when the new rate is materially lower than the weighted average, the term doesn't extend so far that total interest paid is higher, and (critically) the client commits to not running up the original accounts. The most common failure mode is consolidating credit cards into a personal loan and then re-running the cards."
      },
      {
        "id": "q8",
        "prompt": "For a refinance, the break-even calculation is:",
        "options": [
          "New rate × loan amount",
          "Closing costs ÷ monthly savings",
          "Old rate − new rate",
          "Monthly savings × 12"
        ],
        "correct": 1,
        "explanation": "Break-even months = closing costs ÷ monthly savings. If the client plans to hold the loan longer than the break-even period, the refinance pays for itself. Beyond that, it's pure savings."
      },
      {
        "id": "q9",
        "prompt": "Which of the following is most consistent with 'strategic' borrowing?",
        "options": [
          "Carrying a balance on a credit card to maintain a credit history.",
          "A mortgage on a primary residence with a fixed rate, manageable payment, and an appropriate term.",
          "A payday loan to cover a short-term cash gap.",
          "A personal loan at 14% to take a family vacation."
        ],
        "correct": 1,
        "explanation": "A reasonable mortgage finances an asset that appreciates and provides shelter, at a relatively low rate, with tax-deductible interest. The other examples either finance depreciating consumption or come with structurally bad terms."
      },
      {
        "id": "q10",
        "prompt": "A client has $200,000 left on a 3.5% mortgage and $50,000 of cash. Her expected after-tax portfolio return is 6%. She is risk-averse. What is the most defensible advisor recommendation?",
        "options": [
          "Pay off the mortgage entirely.",
          "Invest all $50,000; math beats behavior every time.",
          "Split — apply part to the mortgage and invest the rest. Document the reasoning so the trade-off is captured.",
          "Refinance the mortgage and invest both proceeds."
        ],
        "correct": 2,
        "explanation": "Math suggests investing (6% expected vs 3.5% borrowing). Behavior suggests paying down for a risk-averse client. The honest recommendation often splits the difference and documents the trade-off, so the client (and a future reviewer) can see what was optimized for and why."
      },
      {
        "id": "q11",
        "prompt": "Where should a client pull their credit report for free?",
        "options": [
          "Through any free credit monitoring app.",
          "Through AnnualCreditReport.com — the official federally-mandated free source.",
          "Through their bank.",
          "By calling each credit bureau directly."
        ],
        "correct": 1,
        "explanation": "AnnualCreditReport.com is the official site mandated by federal law. All three bureaus' reports are available free, and pulling them does not affect the score (soft inquiry). Apps may have ulterior motives or display partial data."
      },
      {
        "id": "q12",
        "prompt": "What is the most common failure mode when consolidating credit card debt into a personal loan?",
        "options": [
          "Personal loan rates rise unexpectedly.",
          "The borrower runs up the original credit cards again, ending with more total debt than they started.",
          "Personal loans have prepayment penalties.",
          "Credit bureaus penalize consolidation."
        ],
        "correct": 1,
        "explanation": "This is the structural risk of consolidation. The personal loan clears the cards, but the cards are still open with zero balances — and very accessible. Without a behavior change (often literally cutting up the cards), the cards refill within months, and the household now has both the loan and the new card debt."
      },
      {
        "id": "q13",
        "prompt": "Why does a credit card 'grace period' disappear once a balance is carried?",
        "options": [
          "Because the issuer is being punitive.",
          "Because interest is charged daily on the outstanding balance, and once any balance is carried, new purchases also accrue interest immediately until everything is paid in full.",
          "Because federal law removes it.",
          "Because the credit bureau changes the reporting status."
        ],
        "correct": 1,
        "explanation": "Grace period only applies when the previous balance was paid in full. Once any balance is carried, new purchases accrue interest from the transaction date — no grace. Many clients don't realize this and assume only the carried balance is being charged. Worth explaining clearly when reviewing credit card statements."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 3;

-- ============================================================================
-- DONE. Module remains 'draft' until Cathy Jackson-Gent approves via admin UI.
-- ============================================================================
