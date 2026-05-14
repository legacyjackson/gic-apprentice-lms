-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 7 CONTENT
-- Retirement Planning Foundations
-- ============================================================================

update public.modules set
  title = 'Retirement Planning Foundations',
  competency_id = 'CORE-7',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The math, accounts, and tradeoffs behind every retirement plan — accumulation, distribution, and the risks that derail both.',
  learning_objectives = ARRAY[
    'Compute a retirement income need and a corresponding nest-egg target.',
    'Compare 401(k), IRA, Roth, SEP, Solo 401(k), and SIMPLE structures and recommend the right vehicle for a given client.',
    'Explain sequence-of-returns risk and how to mitigate it near and into retirement.',
    'Apply the 4% withdrawal rule, identify its assumptions, and adapt it when those assumptions don''t fit.',
    'Articulate the Social Security claim-timing decision and its trade-offs.',
    'Build a defensible Monte Carlo-style projection or interpret one produced by planning software.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Retirement Equation",
      "summary": "Time, return, savings rate, and withdrawal — the four levers, and what they actually do.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every retirement plan reduces to four variables: how much the client saves, for how long, at what rate of return, and how much they withdraw later. Holding any three constant, the fourth is determined. A counselor's job is to make the client see which of those levers they can move, and what each move costs." },

        { "type": "callout", "kind": "key", "title": "The accumulation question", "text": "<strong>How big a nest egg does this client need, and what monthly savings rate gets them there by their target retirement age?</strong>" },

        { "type": "heading", "text": "Step 1 — Estimate retirement spending" },
        { "type": "paragraph", "text": "Start with current spending. Subtract things that disappear in retirement (commuting, work clothes, mortgage if paid off, retirement contributions themselves). Add things that may grow (healthcare before Medicare, travel, hobbies). Most clients spend roughly <strong>70–85% of their pre-retirement net spending</strong> in retirement — but the range is wide, and the only honest way to estimate is to look at their actual current spending and adjust line by line." },
        { "type": "callout", "kind": "warn", "title": "The 80% rule of thumb is too rough", "text": "Pre-retirees with high mortgage payments that will be paid off, high commuting costs, and big retirement contributions might need 60% of current income. Pre-retirees who plan extensive travel, have ongoing mortgage, or expect to support adult children might need 100%+. Do the work; don't apply the rule blindly." },

        { "type": "heading", "text": "Step 2 — Subtract guaranteed income sources" },
        { "type": "paragraph", "text": "Many clients have income streams in retirement that aren't from their portfolio:" },
        { "type": "list", "items": [
          "<strong>Social Security</strong> — covered in detail later; varies by claim age and earnings history.",
          "<strong>Pension</strong> — defined-benefit plan, often from public-sector or older private-sector employment.",
          "<strong>Annuities</strong> — purchased income streams.",
          "<strong>Rental income</strong> — net of expenses.",
          "<strong>Part-time work</strong> — many retirees continue some level of paid work, at least for the first decade."
        ]},
        { "type": "paragraph", "text": "The <strong>income gap</strong> — annual spending minus guaranteed income — is what the portfolio must cover." },

        { "type": "heading", "text": "Step 3 — Translate the gap into a nest-egg target" },
        { "type": "paragraph", "text": "The standard rule: use a <strong>safe withdrawal rate</strong> to convert annual income need into total portfolio size. A 4% withdrawal rate corresponds to multiplying annual need by 25:" },
        { "type": "list", "items": [
          "Annual gap of $40,000 → $40,000 × 25 = $1,000,000 portfolio target",
          "Annual gap of $60,000 → $60,000 × 25 = $1,500,000 portfolio target",
          "Annual gap of $100,000 → $100,000 × 25 = $2,500,000 portfolio target"
        ]},
        { "type": "callout", "kind": "note", "title": "The 4% rule's caveats", "text": "Originally derived from Bengen (1994) and Trinity Study research. Assumes a balanced portfolio, 30-year horizon, and inflation-adjusted withdrawals. Has held up reasonably across most historical periods but is not a guarantee. For longer retirements (early retirees), more conservative (3.0–3.5%). For shorter (late retirees), can be higher. Detailed treatment later in the module." },

        { "type": "heading", "text": "Step 4 — Back into a savings rate" },
        { "type": "paragraph", "text": "Given current savings, years to retirement, and expected return, compute the monthly contribution required to hit the target. Use the future-value-of-an-annuity formula from Module 2, or a financial calculator." },

        { "type": "case_study",
          "title": "Walking through Marcus and Tasha",
          "scenario": "Marcus and Tasha, early 40s, want to retire at 65. Current household spending: $108,000/year ($9,000/month). Expected retirement spending: ~$90,000/year (mortgage gone, no work expenses, slightly more travel). Combined Social Security at 67 estimated at $50,000/year. Current retirement savings: $250,000. Current combined retirement contributions: $1,800/month.",
          "discussion": "<p><strong>Income gap in retirement:</strong> $90,000 spending − $50,000 SS = $40,000 from portfolio.</p><p><strong>Nest egg target:</strong> $40,000 × 25 = $1,000,000 (in today's dollars).</p><p><strong>Years to retirement:</strong> 23 (from age 42 to 65).</p><p><strong>Projection at current pace:</strong> $250,000 grows for 23 years at 7% real = ~$1,180,000. Plus contributions of $1,800/month for 23 years at 7% = ~$1,140,000. Total: ~$2,320,000 (in today's dollars). <strong>They are comfortably on track</strong> if those assumptions hold.</p><p>This is the kind of analysis that turns a 'we want to save more' goal into a defensible plan. The numbers say they don't need to save more — they need to <em>not screw it up</em>: stay invested through downturns, manage health-related risks, get insurance right, avoid lifestyle creep that pushes retirement spending past $90K.</p>"
        }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Retirement Accounts: The Vehicles",
      "summary": "Workplace plans, IRAs, self-employed plans — what fits whom and why.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax-advantaged retirement accounts are the structural foundation of nearly every retirement plan. Knowing the rules — contribution limits, eligibility, withdrawal terms — well enough to recommend the right vehicle is core competence." },

        { "type": "heading", "text": "Workplace plans" },

        { "type": "subheading", "text": "401(k) and 403(b)" },
        { "type": "paragraph", "text": "Workplace defined-contribution plans. 401(k) is private sector; 403(b) is nonprofit and education. Mechanically very similar. Employee contributions are pre-tax (Traditional) or after-tax (Roth, if offered). Employer match is common." },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: $23,500 employee. Catch-up $7,500 if age 50+. New super catch-up of about $11,250 for ages 60–63 under SECURE 2.0.",
          "<strong>Employer match</strong>: free money. Capture the full match before anything else.",
          "<strong>Vesting</strong>: employer contributions may have a vesting schedule (typically 3–6 years to fully vest). Important for clients considering a job change.",
          "<strong>Investment menu</strong>: limited to the plan's selected fund lineup. Quality varies enormously by employer.",
          "<strong>Withdrawals before 59½</strong>: generally subject to ordinary income tax plus 10% penalty. Exceptions exist (rule of 55 if separating from service)."
        ]},

        { "type": "subheading", "text": "457(b)" },
        { "type": "paragraph", "text": "State and local government, plus some nonprofits. Similar to 401(k) with two important differences: no 10% early-withdrawal penalty after separation from service at any age, and contributions can be stacked with 401(k) for clients with access to both (e.g., teachers in some states)." },

        { "type": "subheading", "text": "TSP (Thrift Savings Plan)" },
        { "type": "paragraph", "text": "Federal employees and uniformed services. Among the lowest-cost workplace plans in existence. Treats Traditional and Roth contributions similarly to private-sector 401(k)." },

        { "type": "divider" },

        { "type": "heading", "text": "Individual retirement accounts" },

        { "type": "subheading", "text": "Traditional IRA" },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: $7,000 ($8,000 if 50+).",
          "<strong>Deductibility</strong>: full deduction if neither spouse is covered by a workplace plan. Phaseout if covered: $79K–$89K single, $126K–$146K MFJ (2024 figures, approximate; check current).",
          "<strong>Tax treatment</strong>: deductible contribution (if eligible), tax-deferred growth, taxable withdrawals as ordinary income."
        ]},

        { "type": "subheading", "text": "Roth IRA" },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: same as Traditional — $7,000 ($8,000 if 50+).",
          "<strong>Income limits</strong>: contribution phases out at $150K–$165K single, $236K–$246K MFJ (2025 approximate).",
          "<strong>Tax treatment</strong>: after-tax contribution, tax-free growth, tax-free qualified withdrawals.",
          "<strong>Contribution withdrawal</strong>: contributions (not earnings) can be withdrawn at any time, tax- and penalty-free. This makes the Roth IRA quietly liquid.",
          "<strong>No RMDs</strong> during the original owner's lifetime."
        ]},
        { "type": "callout", "kind": "key", "title": "The backdoor Roth", "text": "Clients above the Roth IRA income limit can still effectively contribute by: (1) making a nondeductible Traditional IRA contribution, (2) immediately converting to Roth. As long as the client has no other pre-tax IRA balances (the pro-rata rule), the conversion is largely tax-free. Legal as of this writing; worth executing for high earners." },

        { "type": "heading", "text": "Self-employed plans" },

        { "type": "subheading", "text": "SEP-IRA" },
        { "type": "paragraph", "text": "Simplified Employee Pension. Employer-only contributions up to about 25% of compensation, capped at $70,000 (2025). Cheap and easy to administer. Best for solo self-employed or very small businesses with no employees." },

        { "type": "subheading", "text": "Solo 401(k)" },
        { "type": "paragraph", "text": "For self-employed with no employees other than a spouse. Combines employee contributions (same $23,500 limit as workplace 401(k)) with employer profit-sharing (up to ~25% of compensation), total capped at about $70,000. Often offers higher contribution capacity than SEP at the same income level. Many Solo 401(k)s now offer Roth contributions and a mega backdoor Roth strategy." },

        { "type": "subheading", "text": "SIMPLE IRA" },
        { "type": "paragraph", "text": "For small employers (under 100 employees). Lower contribution limit ($16,000 in 2025 plus $3,500 catch-up). Required employer match or contribution. Less common; SEP and 401(k) generally preferred when feasible." },

        { "type": "callout", "kind": "do", "title": "The matching framework", "text": "<strong>W-2 employee with workplace 401(k):</strong> contribute at least up to the match, then maximize Roth IRA, then increase 401(k) toward the limit. <strong>Self-employed with no employees:</strong> Solo 401(k) typically optimal. <strong>Self-employed with employees:</strong> SEP-IRA for simplicity if employees are few, regular 401(k) if practical to administer. <strong>Government employee:</strong> 457(b) plus IRA for tax diversification; TSP if federal." },

        { "type": "divider" },

        { "type": "heading", "text": "Rollovers and consolidation" },
        { "type": "paragraph", "text": "When clients leave jobs, their workplace plans can be rolled to an IRA without tax. Common counselor work:" },
        { "type": "list", "items": [
          "<strong>401(k) to IRA rollover</strong> — direct rollover preferred (the money moves trustee-to-trustee without coming to the client). Avoids withholding and potential 60-day-rollover headaches.",
          "<strong>Roth 401(k) to Roth IRA</strong> — also tax-free.",
          "<strong>When to leave it</strong> — sometimes the old 401(k) has better/cheaper funds, creditor protection, or an in-service rollover restriction that means it can't be moved. Audit before recommending rollover.",
          "<strong>Backdoor Roth complications</strong> — clients executing backdoor Roth need to keep pretax IRA balances at zero. Rolling an old 401(k) into a Traditional IRA can ruin their backdoor Roth strategy. Sometimes the right move is rolling 401(k) into a current 401(k), or leaving it."
        ]}
      ]
    },

    {
      "id": "lesson-3",
      "title": "Sequence-of-Returns Risk",
      "summary": "Why the order of good and bad years matters — and what to do about it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two retirees can have identical average returns over their retirement years and dramatically different outcomes. The difference is when the bad years happen. Bad years early in retirement, while the portfolio is being drawn down, are devastating. The same bad years late in retirement are almost harmless." },

        { "type": "callout", "kind": "key", "title": "The core mechanic", "text": "When the portfolio is in <em>accumulation</em>, a downturn is opportunity — contributions buy more shares at lower prices. When the portfolio is in <em>distribution</em>, a downturn is destruction — withdrawals lock in losses, leaving less to recover when markets rebound." },

        { "type": "heading", "text": "The numerical demonstration" },
        { "type": "paragraph", "text": "Two retirees, each with $1 million, withdrawing $50,000/year, retiring with average annual return of 7% over the retirement period." },

        { "type": "subheading", "text": "Retiree A — bad returns at the start" },
        { "type": "list", "items": [
          "Year 1: −20% return. Portfolio: $1,000,000 × 0.80 − $50,000 = $750,000.",
          "Year 2: −10% return. Portfolio: $750,000 × 0.90 − $50,000 = $625,000.",
          "Years 3–30: average ~9% per year recovery.",
          "Roughly 25 years before the portfolio depletes."
        ]},

        { "type": "subheading", "text": "Retiree B — bad returns at the end" },
        { "type": "list", "items": [
          "Years 1–28: average ~9% per year.",
          "Year 29: −20% return.",
          "Year 30: −10% return.",
          "Portfolio still has substantial balance at age 95."
        ]},

        { "type": "paragraph", "text": "Same average return. Same withdrawals. Very different outcomes. This is sequence-of-returns risk." },

        { "type": "callout", "kind": "warn", "title": "When the risk is highest", "text": "The five years before retirement and the first ten years of retirement are the danger zone. A bear market in this window can permanently damage a retiree's portfolio — there's no time to wait it out without withdrawing during the trough." },

        { "type": "heading", "text": "Mitigating the risk" },

        { "type": "subheading", "text": "1. Glide path — reduce equity exposure entering retirement" },
        { "type": "paragraph", "text": "Most target-date funds reduce equity allocation as the target date approaches. By age 65, a typical target-date fund might hold 50–60% stocks and 40–50% bonds. Less aggressive = less drawdown risk in the danger zone." },

        { "type": "subheading", "text": "2. Cash reserves and the bucket strategy" },
        { "type": "paragraph", "text": "Hold 1–3 years of expenses in cash. In a downturn, draw from cash rather than selling equities at depressed prices. Refill the cash bucket from equities in good years. Some advisors expand this to three buckets: cash (1–2 years), bonds (next 3–7 years), stocks (8+ years)." },

        { "type": "subheading", "text": "3. Flexible withdrawals" },
        { "type": "paragraph", "text": "The 4% rule assumes fixed real withdrawals regardless of market conditions. In practice, retirees who reduce spending in bear-market years (skip the big vacation, postpone the new car) significantly increase plan durability. Even a 10–15% temporary spending reduction has outsize effect." },

        { "type": "subheading", "text": "4. Guaranteed income floor" },
        { "type": "paragraph", "text": "If Social Security, pension, and (sometimes) a single-premium immediate annuity (SPIA) cover essential expenses, the portfolio only needs to fund discretionary spending. The retiree can absorb portfolio drawdowns without changing their basic standard of living." },

        { "type": "subheading", "text": "5. Delay retirement or work part-time" },
        { "type": "paragraph", "text": "Working one extra year, or part-time for several years, reduces the years of withdrawal needed and shrinks the sequence-risk window. For retirees willing and able, this is the most powerful mitigation available." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "A 2008 retiree",
          "scenario": "A retiree who retired in late 2007 with $1 million in a 60/40 portfolio and a 4% withdrawal rate watched the portfolio drop nearly 30% by early 2009 while still drawing $40,000/year. How does this play out?",
          "discussion": "<p>At the trough, the portfolio is well below $700,000. Continuing $40,000 withdrawals is now ~6% of the depressed portfolio — a much higher real withdrawal rate than the 4% rule assumes. If the retiree maintained the withdrawal schedule rigidly, the plan has a meaningful probability of failure across the full 30-year retirement.</p><p>Mitigations that saved many such retirees: (1) flexibility — reducing spending during 2008–2010 by 10–20%; (2) cash buffers — drawing from cash rather than equities during the worst years; (3) Social Security being available to cushion the gap; (4) recovery — markets rebounded substantially by 2013, and a portfolio that survived to 2013 was largely restored.</p><p>The structural lesson: <strong>build flexibility into the plan up front</strong>. The retiree who locks in fixed real withdrawals and never reduces spending is most exposed to sequence risk. The retiree who built a cash buffer, kept some equity exposure, and is willing to flex spending almost always comes out the other side.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Social Security: Timing and Trade-offs",
      "summary": "The decision most clients make poorly, and the analysis that gets it right.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Social Security claim timing is one of the most consequential single decisions a retiree makes. Claim at 62 and benefits are permanently reduced. Claim at full retirement age (currently 67 for most clients) and you get the baseline benefit. Wait until 70 and benefits are permanently increased. The math, and a few often-missed structural considerations, decide the right answer." },

        { "type": "heading", "text": "The basic math" },
        { "type": "paragraph", "text": "Each year of delay between age 62 and full retirement age increases the benefit by roughly 6–7% per year. Each year of delay beyond FRA up to age 70 adds an additional 8% per year. The total difference between claiming at 62 and claiming at 70 is roughly <strong>76% more lifetime monthly benefit</strong>." },

        { "type": "subheading", "text": "Approximate benefit at each age" },
        { "type": "list", "items": [
          "<strong>Claim at 62</strong>: ~70% of full benefit (early-claim reduction of 30%)",
          "<strong>Claim at 67 (FRA for most current clients)</strong>: 100% of full benefit",
          "<strong>Claim at 70</strong>: ~124% of full benefit (delayed-retirement credits)"
        ]},

        { "type": "callout", "kind": "key", "title": "The break-even age", "text": "Compare cumulative benefits. Claiming early gives more checks earlier; claiming later gives larger checks. Break-even between claiming at 62 vs. 67 is typically around age 78–79. Break-even between 67 vs. 70 is typically around age 82–83. <strong>Clients who expect to live past these ages are mathematically better off waiting. Clients who don't, aren't.</strong>" },

        { "type": "heading", "text": "Factors that argue for claiming earlier" },
        { "type": "list", "items": [
          "<strong>Health</strong> — serious health issues, low expected longevity.",
          "<strong>Need</strong> — no other income, can't afford to wait.",
          "<strong>Spousal coordination</strong> — sometimes one spouse claims early to provide income while the other delays.",
          "<strong>Behavioral</strong> — some clients value the certainty of income they receive over a larger income they might not live to collect."
        ]},

        { "type": "heading", "text": "Factors that argue for claiming later" },
        { "type": "list", "items": [
          "<strong>Longevity</strong> — family history of long life, current good health.",
          "<strong>Higher-earning spouse</strong> — delaying the higher earner's benefit also increases the surviving spouse's benefit after the first death (survivor benefit is based on the higher earner's claim).",
          "<strong>Tax planning</strong> — delaying Social Security creates room for Roth conversions in the meantime at low rates.",
          "<strong>Longevity insurance</strong> — Social Security is the cheapest longevity insurance available. Higher benefits in the years a retiree is most likely to need them are structurally valuable."
        ]},

        { "type": "callout", "kind": "do", "title": "The default for healthy clients", "text": "For most healthy clients with adequate resources to bridge the gap, delaying Social Security — at least to FRA, and often to 70 — is the right default. The higher inflation-adjusted income later in life is structurally valuable, and it's the cheapest longevity insurance available. Document when departing from this default and why." },

        { "type": "divider" },

        { "type": "heading", "text": "Spousal and survivor benefits" },
        { "type": "list", "items": [
          "<strong>Spousal benefit</strong>: at FRA, equals up to 50% of the spouse's primary insurance amount (PIA). Available even if the lower-earning spouse never worked.",
          "<strong>Survivor benefit</strong>: equals 100% of the deceased spouse's benefit at the time of death (or what it would have been at FRA if they died before claiming). The surviving spouse gets the higher of the two benefits — not both.",
          "<strong>Divorced spouse benefit</strong>: marriage lasted at least 10 years, current unmarried, ex-spouse is at least 62. Up to 50% of ex's PIA. Doesn't affect ex-spouse's benefit."
        ]},

        { "type": "heading", "text": "Working while claiming" },
        { "type": "paragraph", "text": "Claiming before FRA while still working triggers earnings-test reductions: $1 of benefit withheld for every $2 of earnings above an annual exempt amount (~$23,400 in 2025). The amount returns to you later in higher benefits at FRA, but in the meantime, claiming-while-working can reduce or eliminate the check entirely. Often a reason to delay." },

        { "type": "case_study",
          "title": "Two-earner couple, planning Social Security",
          "scenario": "Both spouses are 64, both worked similar careers, both have estimated FRA benefits of about $30,000/year. Combined retirement spending need: $90,000/year. Portfolio: $1.5M. Both in good health, family longevity into mid-80s.",
          "discussion": "<p>Several reasonable strategies:</p><p><strong>Both delay to 70</strong> — maximizes lifetime benefit (~$48K each at age 70). Requires bridge income from portfolio for 6 years. Best longevity insurance. Best survivor benefit. Default for two healthy spouses.</p><p><strong>One claims early, one delays</strong> — provides some income immediately, larger benefit later. Often used when one spouse has health concerns.</p><p><strong>Both claim at FRA</strong> — middle ground. Avoids the cost of delay for those uncomfortable bridging from portfolio.</p><p>For this couple, recommendation depends on tolerance for portfolio drawdown in the bridge years and view on longevity. Default: delay both. Document the reasoning. Revisit if health or markets change materially.</p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Distribution Phase",
      "summary": "Drawing the money down — withdrawal rates, tax sequencing, and managing the spend.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Accumulation gets the attention; distribution is harder. Once a client retires, the questions get more complex: how much can they safely spend, in what order do they draw from accounts, when do they take RMDs, how do they manage taxes across the rest of their life? Distribution is where the planning shifts from saving to deploying." },

        { "type": "heading", "text": "Safe withdrawal rates" },
        { "type": "paragraph", "text": "The 4% rule (covered earlier) remains the most-cited starting point. Refinements:" },
        { "type": "list", "items": [
          "<strong>Retirement length matters.</strong> 4% works for 30-year retirements. For 40+ year retirements (early retirees), drop to 3.0–3.5%.",
          "<strong>Portfolio composition matters.</strong> 4% assumes a diversified stock/bond portfolio. Too conservative (all bonds) supports lower withdrawals; too aggressive (all stocks) is volatile.",
          "<strong>Flexibility increases safe rate.</strong> A retiree willing to reduce spending in bad years can sustainably withdraw 4.5–5%.",
          "<strong>Guaranteed income reduces portfolio strain.</strong> If Social Security + pension cover 50% of spending, the portfolio is supporting less of the burden and effective rates are different."
        ]},

        { "type": "heading", "text": "Withdrawal sequencing" },
        { "type": "paragraph", "text": "When a retiree has multiple account types — taxable, traditional, Roth — the order of withdrawal materially affects total taxes paid over retirement. The conventional ordering (with significant nuance):" },
        { "type": "numbered", "items": [
          "<strong>Required minimum distributions first.</strong> RMDs from traditional accounts are mandatory starting at 73 (rising to 75 by 2033). Penalty for missing is harsh. Take them.",
          "<strong>Taxable accounts next.</strong> Each year, sell long-term holdings as needed to fill the spending gap. Take advantage of low LTCG brackets when total income is modest. Use tax-loss harvesting to offset gains.",
          "<strong>Traditional IRA/401(k) before Roth.</strong> Generally. The reasoning: traditional withdrawals are taxed; Roth withdrawals aren't. Burning through traditional first uses up your bracket capacity at moderate rates rather than letting it grow into RMDs at potentially higher rates.",
          "<strong>Roth last.</strong> Roth grows tax-free and has no RMDs. Letting it grow as long as possible maximizes tax-free wealth. Also: Roth is the most beneficiary-friendly asset to leave to heirs."
        ]},
        { "type": "callout", "kind": "warn", "title": "The conventional ordering is not always right", "text": "For some clients — especially those with very large traditional balances facing massive future RMDs — partial Roth conversions during the bridge years (early retirement, before Social Security and RMDs) are more valuable than strictly following conventional ordering. The right answer depends on bracket math at every age. Planning software helps, but the advisor's job is checking the model against reality." },

        { "type": "heading", "text": "Tax considerations through retirement" },
        { "type": "list", "items": [
          "<strong>Pre-Social Security, pre-RMD window (e.g., 65–72)</strong>: often the lowest-tax years of retirement. Excellent window for Roth conversions and capital gains realization in the 0% LTCG bracket.",
          "<strong>Post-RMD (age 73+)</strong>: traditional withdrawals plus Social Security plus pensions pile up income. Higher brackets. Less planning flexibility.",
          "<strong>Survivor years</strong>: when one spouse passes, surviving spouse files single — brackets compress sharply. Marginal rates can jump even though income hasn't changed. Plan ahead with Roth conversions while both spouses are alive."
        ]},

        { "type": "heading", "text": "Medicare and IRMAA" },
        { "type": "paragraph", "text": "At 65, clients enroll in Medicare. Premiums have a tiered structure based on income (IRMAA — Income-Related Monthly Adjustment Amount). High-income retirees pay more, sometimes dramatically more, for Medicare Part B and Part D." },
        { "type": "list", "items": [
          "IRMAA looks at modified AGI from <em>two years prior</em> (2025 premiums based on 2023 income).",
          "Roth conversions, large capital gains, and one-time income events can spike a year's income and trigger higher premiums two years later.",
          "Cliffs exist at specific income thresholds — being $1 over a threshold can cost $1,000+ in higher annual premiums.",
          "Form SSA-44 allows appeal of IRMAA for life-changing events (retirement itself qualifies)."
        ]},
        { "type": "callout", "kind": "do", "title": "The plan that doesn't surprise the client", "text": "Map IRMAA brackets onto the retirement plan from day one. Coordinate Roth conversions, Social Security timing, and capital gains realization to manage AGI around the brackets. Many retirees discover the cost of IRMAA only after they've triggered it — the advisor's job is to see it coming and adjust." },

        { "type": "divider" },

        { "type": "heading", "text": "Monte Carlo and the projection question" },
        { "type": "paragraph", "text": "Most retirement planning software now runs <strong>Monte Carlo simulations</strong> — generating hundreds or thousands of randomized return sequences to estimate the probability that a given plan succeeds. A 'success rate' of 85% means the plan worked in 85% of simulated paths." },
        { "type": "callout", "kind": "note", "title": "What success rate to aim for", "text": "100% is typically too conservative — it forces unnecessarily low spending. 50% is too aggressive — too high a failure risk. Most planners target 75–90% success. Lower success rates can be appropriate when (1) the retiree has flexibility to reduce spending if needed, (2) there are non-portfolio resources to fall back on, (3) the alternative is unacceptable scrimping in retirement." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A client has annual retirement spending of $80,000, expected Social Security of $30,000, and no pension. What's the rough nest-egg target using the 4% rule?",
        "options": [
          "$500,000",
          "$1,250,000",
          "$2,000,000",
          "$3,200,000"
        ],
        "correct": 1,
        "explanation": "Income gap: $80,000 − $30,000 = $50,000. Nest egg = $50,000 × 25 = $1,250,000. The portfolio must support only the gap between spending and guaranteed income, not the full spending number."
      },
      {
        "id": "q2",
        "prompt": "What is sequence-of-returns risk?",
        "options": [
          "The risk that returns will be negative on average.",
          "The risk that the ORDER of returns (bad years early in retirement while withdrawing) damages a portfolio far more than the same returns occurring later.",
          "The risk that returns vary year to year.",
          "The risk that the client doesn't follow the plan."
        ],
        "correct": 1,
        "explanation": "Two retirees with the same average return can have very different outcomes depending on when the bad years happen. Withdrawals during a drawdown lock in losses and reduce the base from which the portfolio can recover. Bad years early are far more damaging than bad years late."
      },
      {
        "id": "q3",
        "prompt": "Roughly how much larger is a Social Security benefit if claimed at 70 vs. 62?",
        "options": [
          "About 10% larger",
          "About 30% larger",
          "About 76% larger",
          "About 200% larger"
        ],
        "correct": 2,
        "explanation": "Claim at 62 = ~70% of full benefit. Claim at 70 = ~124% of full benefit. 124/70 ≈ 1.77 — about 76% more lifetime monthly income for the patient claimant."
      },
      {
        "id": "q4",
        "prompt": "Which is the strongest reason a healthy client with adequate bridge resources should consider delaying Social Security past full retirement age?",
        "options": [
          "Tax advantages of delaying are large.",
          "Higher benefits are inflation-adjusted and represent the cheapest longevity insurance available; for higher-earning spouse, also raises the survivor benefit.",
          "It's required by law for high earners.",
          "Markets will be lower then."
        ],
        "correct": 1,
        "explanation": "Delayed-retirement credits add ~8% per year of inflation-adjusted lifetime income — extraordinarily valuable longevity insurance. For couples, the higher earner's delay also raises the survivor benefit, protecting the longer-living spouse."
      },
      {
        "id": "q5",
        "prompt": "What is the conventional withdrawal sequencing in retirement (after RMDs)?",
        "options": [
          "Roth → Traditional → Taxable",
          "Taxable → Traditional → Roth",
          "All accounts proportionally each year",
          "Traditional → Taxable → Roth"
        ],
        "correct": 1,
        "explanation": "Conventional: required minimums first, then taxable, then traditional, then Roth. Taxable funds use lower-rate LTCG brackets, traditional uses up bracket capacity at moderate rates, Roth grows tax-free as long as possible. Not always the optimal — Roth conversions in the bridge years often improve on this."
      },
      {
        "id": "q6",
        "prompt": "Why is the early-retirement, pre-RMD window so valuable for tax planning?",
        "options": [
          "Brackets are lower than they'll be later when Social Security and RMDs both fill them. Excellent window for Roth conversions and realizing capital gains at low rates.",
          "Tax rates are temporarily lower by law.",
          "The IRS doesn't audit during this period.",
          "It's the only time Roth conversions are legal."
        ],
        "correct": 0,
        "explanation": "Early retirement before Social Security, before RMDs, can be the lowest-tax window of a client's lifetime. Use it to do Roth conversions, harvest gains in the 0% LTCG bracket, and reduce future tax pressure."
      },
      {
        "id": "q7",
        "prompt": "What is IRMAA?",
        "options": [
          "An IRS retirement account.",
          "Medicare's Income-Related Monthly Adjustment Amount — higher-income retirees pay higher Medicare Part B and Part D premiums; looks at AGI from two years prior.",
          "An annuity product.",
          "A type of Social Security benefit."
        ],
        "correct": 1,
        "explanation": "IRMAA tiers Medicare premiums by income, using AGI from two years prior. Roth conversions, capital gains, and large one-time income events can spike a year's MAGI and trigger higher premiums two years later. Cliffs exist — $1 over a threshold can cost $1,000+ annually."
      },
      {
        "id": "q8",
        "prompt": "What's the right move for a client who has both a workplace 401(k) match and is otherwise on the fence about contributions?",
        "options": [
          "Skip the 401(k) and contribute to an IRA instead.",
          "Always contribute at least up to the full employer match — it's an immediate guaranteed return that almost always outranks other priorities.",
          "Wait until pay raises arrive.",
          "Use a Roth IRA only."
        ],
        "correct": 1,
        "explanation": "The match is free money — typically a 50% or 100% return on contributions up to a cap. Almost no other use of those dollars produces a comparable risk-free return. Capture the match first; everything else is secondary."
      },
      {
        "id": "q9",
        "prompt": "What is the backdoor Roth, and who uses it?",
        "options": [
          "An illegal tax shelter.",
          "A two-step process — make a nondeductible Traditional IRA contribution, then convert to Roth — that effectively allows high earners (above the Roth income limit) to contribute to a Roth.",
          "A Roth IRA available only to government employees.",
          "An emergency-withdrawal feature."
        ],
        "correct": 1,
        "explanation": "Legal as of this writing. Critical caveat: only works cleanly if the client has no other pretax IRA balances (the pro-rata rule). Common move for high earners; should be checked annually against current tax law."
      },
      {
        "id": "q10",
        "prompt": "A retiree's portfolio drops 25% in the first year of retirement. They are still drawing the originally planned $50K/year. What is the best advisor move?",
        "options": [
          "Sell stocks immediately to reduce risk.",
          "Have an honest conversation about flexibility — temporarily reducing withdrawals or drawing from cash reserves rather than depressed equities. Sequence-of-returns risk is acute right now.",
          "Reassure the client that returns will average out.",
          "Recommend buying more stocks at the dip."
        ],
        "correct": 1,
        "explanation": "Sequence risk is most acute in the first decade of retirement. Flexibility (reducing spending, drawing from cash) preserves the portfolio for recovery. Selling equities into the depressed market and replacing with bonds locks in losses. Reassurance alone misses the structural risk."
      },
      {
        "id": "q11",
        "prompt": "What is the bucket strategy in retirement planning?",
        "options": [
          "Diversifying across multiple investment platforms.",
          "Holding cash/short-term assets for near-term spending and longer-duration assets for later spending — so a market drop doesn't force selling equities at depressed prices.",
          "Holding only one asset class.",
          "Spreading withdrawals across the calendar year."
        ],
        "correct": 1,
        "explanation": "The classic three-bucket: cash (1–2 years of spending), bonds (next 3–7 years), stocks (8+ years). In a downturn, draw from cash and bonds; let stocks recover. Refill the cash bucket from stocks in good years. Mitigates sequence risk structurally."
      },
      {
        "id": "q12",
        "prompt": "What is a reasonable target for Monte Carlo simulation 'success rate' in a retirement plan?",
        "options": [
          "100% — anything less is too risky.",
          "50% — coin flip is fine.",
          "75–90% — high enough to be confident, low enough to avoid unnecessary spending restrictions.",
          "Success rates are meaningless."
        ],
        "correct": 2,
        "explanation": "100% can force unrealistically low spending. 50% is too risky. Most planners target 75–90%, lower when retirees have flexibility to adapt if results trail expectation. Always pair the number with a plan for what changes if the projection trends bad."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 7;

-- ============================================================================
-- DONE.
-- ============================================================================
