-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 24 CONTENT
-- Tax-Loss Harvesting
-- ============================================================================
update public.modules set
  title = 'Tax-Loss Harvesting',
  competency_id = 'OJL-15',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Systematically realize tax losses to offset gains and income — while maintaining the portfolio''s design, respecting wash-sale rules, and quantifying the benefit honestly.',
  learning_objectives = ARRAY[
    'Identify harvestable losses across client portfolios',
    'Execute harvesting trades that avoid wash-sale violations',
    'Choose appropriate substitute securities to maintain market exposure',
    'Calculate the realistic after-tax benefit of harvesting for a specific client',
    'Document the harvest and communicate it usefully to the client and the CPA'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "What Tax-Loss Harvesting Is — and What It Is Not",
        "summary": "Harvesting realizes losses to offset gains and income. Done well, it adds basis points of after-tax return over decades. Done badly, it triggers wash-sale disallowance and embarrassing client conversations.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Tax-loss harvesting is the practice of selling securities at a loss to realize the loss for tax purposes, while simultaneously buying a similar-but-not-substantially-identical security to maintain market exposure. The realized loss offsets capital gains elsewhere in the portfolio, and up to $3,000 per year of net capital losses can offset ordinary income (with the unused balance carrying forward). Done systematically over decades, harvesting adds an estimated 0.20% to 0.85% per year of after-tax return depending on the portfolio and tax situation — meaningful compounding over a long horizon."},
          {"type": "subheading", "content": "What harvesting actually accomplishes"},
          {"type": "list", "items": [
            "Offsets realized capital gains in the current year, reducing taxes owed",
            "Offsets up to $3,000 of ordinary income per year if losses exceed gains",
            "Generates a loss carryforward for use in future tax years (indefinitely for federal purposes)",
            "Creates a deferral benefit — the tax savings happen now, while the eventual tax cost (because the new lower-basis replacement security will have a larger gain when sold) happens later"
          ]},
          {"type": "subheading", "content": "What harvesting does NOT do"},
          {"type": "paragraph", "content": "Harvesting is a tax deferral, not a tax elimination. The substitute security purchased after the harvest has a lower cost basis than the original, so when it is eventually sold, the gain will be larger. The benefit is time value — paying the tax later instead of now. The total benefit depends on the difference between today's tax rate and the future tax rate, the time between the harvest and the eventual sale, and any step-up basis at death that could eliminate the deferred gain entirely. The marketing pitch 'harvesting saves you taxes' is sloppy. The honest pitch is 'harvesting defers taxes and creates value through the time gap.'"},
          {"type": "callout", "kind": "key", "content": "Harvesting moves the tax bill from now to later. The value is the time-value of the deferred tax dollars, plus the option value of basis step-up at death. Communicate it this way."},
          {"type": "subheading", "content": "Where harvesting works best"},
          {"type": "list", "items": [
            "Taxable accounts only — there is no benefit in tax-deferred or Roth accounts",
            "Higher-bracket clients — the value of a deferred tax dollar scales with the bracket",
            "Portfolios with regular contributions — fresh lots provide opportunities and cushion against wash-sale issues",
            "Diversified portfolios using broad ETFs — many similar-but-not-identical substitutes exist",
            "Long-horizon clients — more time for the deferral benefit to compound and more chance of basis step-up"
          ]},
          {"type": "subheading", "content": "Where harvesting works less well or not at all"},
          {"type": "list", "items": [
            "Tax-advantaged accounts — IRA, 401(k), Roth — no benefit",
            "Clients in 0% capital gains bracket — no tax to offset",
            "Clients planning to gift appreciated stock to charity (DAF) anyway — the loss harvest competes with the charitable strategy",
            "Concentrated single-stock portfolios with few substitutable holdings",
            "Portfolios where the tracking error of substitution is unacceptably large"
          ]},
          {"type": "case_study", "title": "Naomi's first harvest year", "scenario": "Naomi's taxable brokerage holds VTI purchased at $245 per share now trading at $228. The lot has an unrealized loss of about $4,300 across 252 shares. Naomi has no realized gains this year and $87K of ordinary income. The apprentice harvests: sell all 252 shares of VTI at $228, simultaneously buy ITOT (iShares Core S&P Total US Stock Market ETF) at approximately the same dollar amount. ITOT is similar to VTI but tracks a different index (S&P U.S. Total Market vs CRSP US Total Market) — not substantially identical, so wash-sale rule is satisfied. Naomi now has a $4,300 realized capital loss. $3,000 offsets ordinary income this year (tax savings at her 24% federal + 9.3% CA marginal bracket ≈ $999). The remaining $1,300 carries forward.", "discussion": "The portfolio's market exposure is essentially unchanged — VTI and ITOT both track essentially all U.S. publicly traded stocks. The tax savings is real this year. The new ITOT lot has a basis $4,300 lower than the old VTI, meaning if Naomi later sells ITOT, the gain will be $4,300 larger. Until that future sale (or step-up at death), the deferred tax dollars compound in her portfolio."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Wash-Sale Rule — The Most-Violated Tax Rule in Retail",
        "summary": "The wash-sale rule disallows losses when a substantially identical security is purchased within a 30-day window. Knowing the rule cold is non-negotiable for anyone harvesting.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "IRC §1091 disallows a loss on the sale of a security if the taxpayer purchases a substantially identical security within 30 days before or after the sale. The disallowed loss is added to the basis of the replacement security — so it is not lost forever, just deferred until the replacement is sold (and the replacement is sold without re-triggering wash-sale). The rule is straightforward in concept and surprisingly easy to violate in practice. Wash-sale violations are one of the most common findings in custodian-prepared 1099s."},
          {"type": "subheading", "content": "The 61-day window"},
          {"type": "paragraph", "content": "The wash-sale window is 61 days total: 30 days before the sale, the day of the sale, and 30 days after. If you sell VTI at a loss on June 15, you cannot buy substantially identical VTI between May 16 and July 15 without triggering wash-sale. The window applies regardless of the order — buying before the sale triggers wash-sale just as surely as buying after."},
          {"type": "subheading", "content": "What 'substantially identical' means"},
          {"type": "paragraph", "content": "The IRS has never defined 'substantially identical' with bright-line precision, which creates real planning uncertainty. The general consensus practitioner interpretation: identical CUSIPs are clearly substantially identical (selling VTI and buying VTI back); two ETFs tracking the same index from different providers (Vanguard VOO and iShares IVV both tracking S&P 500) are widely treated as substantially identical even though the CUSIPs differ; two ETFs tracking different indices but similar exposure (VTI tracking CRSP vs ITOT tracking S&P Total Market) are generally treated as not substantially identical because the indices and underlying methodology differ. Reasonable people disagree on edge cases. Conservative practice errs on the side of meaningful differentiation."},
          {"type": "subheading", "content": "Where the rule reaches"},
          {"type": "callout", "kind": "warn", "content": "The wash-sale rule applies across all accounts you control, including IRAs and your spouse's accounts. Selling VTI at a loss in your taxable brokerage while your IRA automatically buys VTI as part of a rebalance — wash-sale. Selling at a loss in your account while your spouse buys the same security in their account — wash-sale. Track this carefully."},
          {"type": "subheading", "content": "Common ways apprentices accidentally trigger wash-sale"},
          {"type": "list", "items": [
            "Forgetting that automatic dividend reinvestment is happening on the security being harvested — disable DRIP before the harvest and for 31 days after",
            "Forgetting that the client's spouse holds the same security in another account",
            "Forgetting that the client's IRA holds the same security and the auto-rebalance is scheduled in the wash-sale window",
            "Selling a fund and buying a different share class of the same fund — treated as substantially identical",
            "Selling a mutual fund and buying the ETF version run by the same fund company tracking the same index — risky territory, generally avoided",
            "Selling one ETF tracking S&P 500 and buying another ETF tracking S&P 500 — both track the same index, treated as substantially identical by most practitioners"
          ]},
          {"type": "subheading", "content": "Building a clean substitution list"},
          {"type": "paragraph", "content": "Most firms maintain an internal substitution list — pairs of ETFs that are similar enough for portfolio purposes but different enough (different index, different methodology) to be defensible as not substantially identical. Example pairs commonly used: VTI (CRSP US Total Market) and ITOT (S&P US Total Market); VOO (S&P 500) and SCHX (Dow Jones US Large-Cap Total Stock Market); VEA (FTSE Developed All Cap ex US) and IEFA (MSCI EAFE); VWO (FTSE Emerging Markets) and IEMG (MSCI Emerging Markets IMI); BND (Bloomberg US Aggregate Bond) and AGG (Bloomberg US Aggregate Bond — note: same index, generally treated as identical, so this is not a good pair) — use SCHZ or another distinct-index alternative instead. Build the substitution list with diligence; reuse it consistently across clients."},
          {"type": "callout", "kind": "do", "content": "Before harvesting, run a check across all the client's accounts (and spouse's accounts where applicable) for any purchase of the security being sold in the 30 days before or scheduled in the next 30 days. The check is one minute. The cost of missing one is hours of unwinding."},
          {"type": "case_study", "title": "The wash-sale that ate the harvest", "scenario": "An apprentice harvests $8,400 of losses by selling VTI in Marcus and Tasha's taxable brokerage on March 12. The apprentice immediately buys ITOT as the replacement. Wash-sale rule appears satisfied. But: Marcus's 401(k) at his employer has an automatic monthly contribution that purchases a small slice of VTI through the plan's brokerage window on March 18. Discovery: $400 of the harvest's $8,400 loss is disallowed because of the partial wash-sale from the 401(k) purchase. The disallowed loss adds to the basis of the 401(k) shares, but the loss in the taxable account is only $8,000 instead of the planned $8,400.", "discussion": "The mistake was failing to check the 401(k)'s automatic activity in the wash-sale window. Process fix: every harvest workflow includes a check across all linked accounts, including employer plans, for any planned or automatic activity in the 31-day window. Small process change, prevents a recurring failure mode."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Executing the Harvest — Mechanics, Substitutes, and Timing",
        "summary": "Harvesting is a workflow. Done as a workflow, it scales. Done ad hoc, it generates errors. Master the steps.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A harvest is a multi-step trade: identify the lot to sell, choose the substitute, check for wash-sale conflicts, execute the sale, execute the replacement purchase, document the activity, and notify the CPA where appropriate. Each step has its own discipline. Treating harvesting as a casual operation produces errors; treating it as a workflow produces consistent results."},
          {"type": "subheading", "content": "Step 1 — Identifying harvestable lots"},
          {"type": "paragraph", "content": "Modern portfolio management software identifies harvestable lots automatically — any tax lot whose current market value is below its cost basis is a candidate. The harvest threshold (the minimum dollar loss worth harvesting) depends on transaction costs and operational time. Common thresholds: $1,000 minimum loss per lot for retail-scale operations, lower thresholds at firms with automated systems. Below the threshold, the operational time exceeds the tax benefit."},
          {"type": "subheading", "content": "Step 2 — Choosing the substitute"},
          {"type": "paragraph", "content": "Pull from the firm's approved substitution list (see Lesson 2). The substitute should: track a different index than the original, have low correlation tracking error to the original over historical periods (so the portfolio's market exposure does not meaningfully change), have a comparable expense ratio, and have adequate liquidity. Document which substitute was used and why, so future harvests in the same name can reverse or rotate."},
          {"type": "subheading", "content": "Step 3 — Wash-sale conflict check"},
          {"type": "paragraph", "content": "Check the 31-day window across all client accounts including spouse accounts and employer plans. Confirm no automatic purchase of the security being sold is scheduled. Disable DRIP on the security being sold. Confirm no recent purchase (within 30 days before) of the security being sold. Document the check."},
          {"type": "subheading", "content": "Step 4 — Execution"},
          {"type": "paragraph", "content": "Sell the harvestable lot using Specific Identification (so the correct lot is sold, not a FIFO default). Buy the substitute simultaneously or as soon as the sale settles. Use marketable limit orders to minimize spread cost (see Module 23). The total time out of market should be minimal — ideally seconds for ETFs, the same trading day for mutual funds."},
          {"type": "subheading", "content": "Step 5 — Documentation"},
          {"type": "paragraph", "content": "Record: lot sold (security, share count, cost basis, sale price, realized loss), substitute purchased (security, share count, purchase price, new basis), wash-sale check completed, date, supervising review if required. The documentation serves both compliance and the CPA. If the client's CPA prepares their return, the realized losses should be communicated to the CPA before year-end so the CPA's projection accounts for them."},
          {"type": "subheading", "content": "Timing — when to harvest"},
          {"type": "list", "items": [
            "Throughout the year when losses present, not only at year-end (year-end-only harvesting misses opportunities and loses the 30-day flexibility)",
            "Most aggressively during volatile periods (March 2020, October 2022 type environments) when many lots are underwater",
            "Less aggressively when most of the portfolio is in significant gains (fewer lots to harvest, lower opportunity)",
            "Avoid the 31-day window before known purchases (year-end contributions, scheduled IPS-driven rebalancing)",
            "Coordinate with year-end gains realization — if a client also needs to realize gains for spending or charitable purposes, harvests can offset those gains"
          ]},
          {"type": "callout", "kind": "key", "content": "Year-round harvesting captures opportunities that year-end harvesting misses. The market drops 12% in March; many lots are harvestable. By December the market has recovered; those lots are gone. The discipline of opportunistic harvesting throughout the year produces more value than concentrated year-end activity."},
          {"type": "subheading", "content": "Direct indexing — the institutional version"},
          {"type": "paragraph", "content": "For larger taxable accounts (often $250K-$1M+ minimum depending on the provider), direct indexing replaces a broad-market ETF with direct ownership of the underlying stocks — typically 200-500 names tracking an index. The harvesting opportunity at the individual stock level is far greater than at the ETF level because individual stocks have more dispersion. Direct indexing strategies harvest continuously, often producing 50-150 bps of additional realized losses per year. The strategy has minimum size, complexity, and management fee considerations — typically 0.20-0.50% on top of the underlying expenses. Worth considering for clients with $500K+ in taxable assets and high marginal tax brackets."},
          {"type": "case_study", "title": "Marcus's mid-year harvest", "scenario": "In late August, U.S. equities are down 12% from their peak. Marcus's taxable account holds VTI with multiple tax lots; three lots are currently below their cost basis with total unrealized loss of $6,200. The apprentice executes the harvest: sells the three losing lots of VTI, simultaneously buys ITOT in the same dollar amount. Disables DRIP on both VTI and ITOT through year-end. Marks the 31-day calendar window where VTI cannot be purchased back. Documents the trade. The $6,200 realized loss is communicated to the family's CPA, who notes it for their year-end projection. By November the market has recovered most of the way; the $6,200 harvested loss is locked in regardless of subsequent market direction.", "discussion": "The opportunity existed for a window of weeks. A year-end-only approach would have missed it because by December the lots were no longer underwater. Year-round discipline captures these episodic windows."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Quantifying the Benefit Honestly",
        "summary": "Sales pitches about tax-loss harvesting often inflate the benefit. The honest math is more modest but still meaningful — communicate it correctly.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Tax-loss harvesting is sometimes marketed as adding 1-2% per year of after-tax return — a number that is true only under specific assumptions and often not durable. The honest range across academic and industry research is closer to 0.20% to 0.85% per year of after-tax return, depending on the client's tax situation, the portfolio's structure, and the time horizon. Knowing how to compute the actual benefit for a specific client is part of the work."},
          {"type": "subheading", "content": "The four variables that determine the benefit"},
          {"type": "list", "items": [
            "The current marginal tax rate on the offset (capital gains rate if offsetting gains; ordinary rate if offsetting income)",
            "The future tax rate when the deferred gain is eventually realized (often the same, but could be different if the client's bracket changes or if step-up at death applies)",
            "The time gap between today's tax savings and the future tax cost — longer is more valuable",
            "The discount rate (or alternatively, the rate of return on the deferred tax dollars while they remain invested)"
          ]},
          {"type": "subheading", "content": "The basic math"},
          {"type": "paragraph", "content": "A harvest of $10,000 of losses for a client in a 32.3% combined federal and state long-term capital gains bracket saves $3,230 in current-year taxes. If those tax dollars remain invested for 20 years at a 6% real return, they grow to about $10,366. If the deferred gain is eventually realized at the same 32.3% rate, the future tax cost is $3,230 on the original $10,000 of deferred loss — same nominal amount. But you have had use of the $3,230 for 20 years. The present value benefit is approximately the difference between today's $3,230 and the present value of the future $3,230 — a function of the discount rate."},
          {"type": "callout", "kind": "key", "content": "If today's tax rate equals the future tax rate, harvesting provides time value of money on the deferred dollars. If today's rate is higher than the future rate, harvesting adds bracket arbitrage. If the future tax never happens because of step-up at death, harvesting provides full elimination of the deferred tax."},
          {"type": "subheading", "content": "The step-up at death dimension"},
          {"type": "paragraph", "content": "Under current U.S. law, assets held in a taxable account at the owner's death receive a 'step-up' in basis to the fair market value at the date of death (with some exceptions for certain assets). If a harvest defers a gain that is never realized because the client holds the substitute security until death, the deferred tax is effectively eliminated. This is the highest-value case for harvesting — older clients in poor health with significant appreciated assets in taxable accounts benefit most. The honest framing for clients is that harvesting is more valuable in some scenarios than others."},
          {"type": "subheading", "content": "When the harvest benefit is small or negligible"},
          {"type": "list", "items": [
            "Client is in 0% capital gains bracket — harvest produces no current-year benefit",
            "Client expects to be in a higher tax bracket in the future (e.g., currently retired with low income but expecting RMDs) — deferral may actually cost",
            "The harvest happens late in life and the substitute will be sold soon after (defeats the deferral)",
            "Tracking error of the substitute is material and produces investment loss exceeding tax benefit",
            "Transaction costs of the harvest exceed the tax benefit (low for ETFs, can be meaningful for less liquid securities)"
          ]},
          {"type": "subheading", "content": "Communicating realistic expectations"},
          {"type": "paragraph", "content": "When discussing harvesting with a client, give a number range based on their specific situation, not a marketed average. 'In your tax bracket and given your time horizon, we expect harvesting to add roughly 0.30 to 0.50 percent per year of after-tax return over long periods. The benefit is greater in volatile years (more harvestable losses) and during periods of market drawdowns. Some years there will be little to harvest; other years substantial amounts.' Set expectations honestly. Over-promised harvest benefits create client disappointment in benign years."},
          {"type": "case_study", "title": "Estimating the benefit for Naomi", "scenario": "Naomi: 32 years old, projected to be in high tax brackets through retirement, expected to hold the substitute securities long-term, possible (but distant) step-up at death scenario. The apprentice estimates: the expected harvesting benefit over a 30-year horizon ranges from approximately 0.25% to 0.50% per year of after-tax return, depending heavily on market volatility patterns. Most of the benefit comes from the deferral period being long. The apprentice does not promise a specific number; instead they say 'this is one of several small efficiencies we will pursue. The combined effect of these efficiencies — harvesting, asset location, careful rebalancing, and tax-aware withdrawal in retirement — is meaningful over decades. No single one of them is dramatic year to year.'", "discussion": "The framing is honest. The benefit is real but modest. Combined with other tax-aware practices, the cumulative effect over decades is substantial. None of them on their own justify a marketing claim. Together they justify the work."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Documenting, Communicating, and Maintaining the Discipline",
        "summary": "Harvesting is a recurring discipline. The documentation and communication around it are what allow the discipline to scale and what protect the client and the firm.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A single harvest is a transaction. A harvesting practice is a system — a set of recurring checks, executions, communications, and records that produce consistent value across years and clients. Building the system requires attention to documentation, client communication, CPA coordination, and ongoing monitoring."},
          {"type": "subheading", "content": "The harvest record"},
          {"type": "paragraph", "content": "Every harvest produces a record that lives in the client's file and the firm's harvest log. The record contains: date of harvest, security sold (ticker, share count, cost basis, sale price, realized loss), substitute purchased (ticker, share count, purchase price, new basis), wash-sale check completed and confirmed clean, supervising review (if required by firm policy), and any notes about the rationale or unusual circumstances. The record is part of the trade documentation discipline established in Module 23."},
          {"type": "subheading", "content": "Annual harvest summary"},
          {"type": "paragraph", "content": "At year-end, prepare a summary of harvesting activity for each client: total realized losses for the year, count of harvest events, current loss carryforward, and projected use of losses in the current year's tax return (offsetting gains, $3,000 ordinary income limit, carryforward to next year). Communicate this summary to the client and to their CPA. The CPA needs the data for tax preparation; the client benefits from seeing the cumulative work."},
          {"type": "subheading", "content": "CPA coordination — make harvesting visible"},
          {"type": "paragraph", "content": "CPAs sometimes see harvest activity as a 'surprise' when 1099s arrive showing many small realized losses. Surprise is bad for the relationship. Communicate during the year: a brief email after any material harvest event ('We executed a tax-loss harvest in the Smith account on June 14, realizing $12,400 of losses') gives the CPA visibility into what is coming and lets them plan for it. Treat the CPA as a partner in the tax work, not as a downstream recipient of paperwork."},
          {"type": "callout", "kind": "do", "content": "Send the CPA a brief notification after any harvest exceeding the firm's communication threshold (commonly $5K of realized losses). Build the habit. CPAs reciprocate by flagging tax events that benefit harvest opportunities."},
          {"type": "subheading", "content": "Client communication"},
          {"type": "paragraph", "content": "Clients should understand that harvesting is happening, what it accomplished for them this year, and what its limits are. A short year-end note: 'During 2025 we executed 11 harvest events in your taxable account, realizing $34,800 of capital losses. These losses fully offset $14,200 of realized gains earlier in the year and $3,000 of ordinary income, with $17,600 carrying forward to 2026. Estimated current-year tax benefit at your bracket: approximately $9,400.' Concrete numbers, plain language, in the year-end report. Clients who understand the work value it; clients who do not see it tend to forget what their advisor does between meetings."},
          {"type": "subheading", "content": "Monitoring the substitute substitution chain"},
          {"type": "paragraph", "content": "Over years of harvesting, the substitute used in one harvest becomes the original held until the next harvest, which then needs a different substitute. This creates a chain: VTI → ITOT → SCHB → VTI (after 31+ days from the prior VTI sale). Track the chain so that you do not inadvertently swap into a security recently sold within the wash-sale window. The firm's harvest log should support this lookback."},
          {"type": "subheading", "content": "Avoid the harvest trap — letting tax tail wag the investment dog"},
          {"type": "paragraph", "content": "Harvesting is a tax efficiency tool, not an investment strategy. The portfolio's design comes first. If harvesting would require switching into a substitute that does not fit the portfolio's intended exposure, do not harvest — the tax savings is not worth the portfolio drift. Similarly, do not delay rebalancing to wait for harvesting opportunities; the risk-management function of rebalancing is more important than the tax-efficiency function of harvesting. When tax and investment goals conflict, investment usually wins. Discipline."},
          {"type": "callout", "kind": "warn", "content": "If you find yourself selecting investments based on harvesting potential rather than portfolio fit, the priorities are inverted. Investment design comes first. Harvesting operates within the portfolio's design, not above it."},
          {"type": "case_study", "title": "The end-of-year harvest review with Devon", "scenario": "At year-end, the apprentice prepares Devon's harvest summary. Total harvesting activity for the year: 8 events, $42,300 in realized losses. These losses offset $18,000 of realized gains from a rebalancing transaction earlier in the year, fully cover the $3,000 ordinary income offset, and leave $21,300 of carryforward to next year. Estimated current-year tax savings at Devon's 35% federal + 9.3% CA bracket on capital gains: approximately $8,030 plus another $1,330 from the ordinary income offset. The apprentice communicates this to Devon's CPA in November and to Devon in the year-end report. The CPA confirms the loss amounts match the broker's reporting and the carryforward is correctly tracked.", "discussion": "Year-round discipline produced $42K in realized losses. The benefit to Devon is real, concrete, and documented. Without the discipline, the same losses might have existed on paper but never been realized. Process produced outcome."},
          {"type": "callout", "kind": "key", "content": "Tax-loss harvesting is a small, consistent, year-after-year practice. None of any single year's harvest is dramatic. The cumulative value across decades is substantial. Build the system; trust the system; communicate the work."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Account Administration & Custody — the operational infrastructure that holds all of this work together."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Tax-loss harvesting is best described as:", "options": ["A way to eliminate taxes entirely", "A tax deferral strategy that moves the tax bill from now to later, with the benefit coming from time-value and potentially basis step-up at death", "A strategy for avoiding wash-sale rules", "A type of options strategy"], "correct": 1, "explanation": "Harvesting defers, not eliminates. The benefit comes from time-value of the deferred dollars and the option value of step-up at death."},
        {"id": "q2", "prompt": "The wash-sale rule window is:", "options": ["30 days after the sale only", "30 days before, the day of, and 30 days after the sale — 61 days total", "60 days after the sale", "The same calendar year"], "correct": 1, "explanation": "IRC §1091 covers the 61-day window. Buying substantially identical securities before, on, or after the sale within this window triggers wash-sale."},
        {"id": "q3", "prompt": "The wash-sale rule applies to:", "options": ["Only the same taxable account where the sale occurred", "All accounts the taxpayer controls, including IRAs and the spouse's accounts", "Only IRAs", "Only mutual funds, not ETFs"], "correct": 1, "explanation": "Wash-sale reaches across all controlled accounts including IRAs and spouse accounts. Tracking this is essential."},
        {"id": "q4", "prompt": "The maximum amount of net capital losses that can offset ordinary income in a single tax year (under current law) is:", "options": ["$1,000", "$3,000", "$5,000", "Unlimited"], "correct": 1, "explanation": "Up to $3,000 of net capital losses per year can offset ordinary income; the unused balance carries forward indefinitely for federal purposes."},
        {"id": "q5", "prompt": "Selling VTI at a loss and immediately buying VOO (S&P 500 ETF) is generally:", "options": ["A clean harvest with no wash-sale concern", "Risky — both track broad U.S. equity but the indices differ; consult firm policy and substitution list", "Definitely a wash-sale because both are ETFs", "Required by best execution rules"], "correct": 1, "explanation": "VTI tracks CRSP US Total Market, VOO tracks S&P 500 — different indices and methodologies. Most practitioners treat as not substantially identical, but firms vary; rely on the firm's substitution list."},
        {"id": "q6", "prompt": "Direct indexing strategies for taxable accounts typically:", "options": ["Eliminate all taxes", "Hold the underlying stocks of an index directly (often 200-500 names), enabling harvesting at the individual stock level for greater opportunity than ETF-level harvesting", "Are available only to institutional investors", "Use options to hedge"], "correct": 1, "explanation": "Direct indexing's harvesting advantage comes from the dispersion of individual stocks within an index — at the ETF level the whole basket moves together, but individual stocks scatter."},
        {"id": "q7", "prompt": "Harvesting works best for clients who are:", "options": ["In low tax brackets and short horizons", "In higher tax brackets, have long horizons, and hold taxable accounts", "Only in retirement", "Only in Roth IRAs"], "correct": 1, "explanation": "Higher bracket = more value per loss harvested. Longer horizon = more deferral compounding. Taxable accounts = the only place harvesting works (no benefit in IRAs/Roth/401k)."},
        {"id": "q8", "prompt": "Realistic long-run after-tax return contribution from tax-loss harvesting for an appropriate client is approximately:", "options": ["2-3% per year reliably", "0.20-0.85% per year, depending on tax situation, volatility, and time horizon", "10% per year in volatile markets", "Zero in all cases"], "correct": 1, "explanation": "Academic and industry research puts the realistic range around 0.20-0.85% per year. Higher claims are typically marketing exaggeration."},
        {"id": "q9", "prompt": "The substitute security used after a harvest should:", "options": ["Track the same index as the original to preserve exposure", "Track a different index with similar but not substantially identical exposure to maintain portfolio design without triggering wash-sale", "Be in a completely different asset class", "Be the cheapest available regardless of fit"], "correct": 1, "explanation": "The substitute must be different enough to avoid wash-sale (different index/methodology) but similar enough to preserve the portfolio's intended exposure."},
        {"id": "q10", "prompt": "Year-round harvesting is preferred to year-end-only harvesting because:", "options": ["Year-end harvesting is illegal", "Many harvest opportunities arise and disappear during the year as markets move; year-end may have nothing harvestable even though earlier in the year there was substantial opportunity", "Year-end is too crowded", "Year-end produces wash-sale violations"], "correct": 1, "explanation": "Markets are volatile. A March drawdown creates harvest opportunities that may not exist in December. Year-round discipline captures these episodic windows."},
        {"id": "q11", "prompt": "When harvesting, automatic dividend reinvestment (DRIP) on the security being sold should be:", "options": ["Left on to maintain consistency", "Disabled before the harvest and for at least 31 days after, to prevent inadvertent wash-sale through the reinvestment", "Increased", "Switched to a different security"], "correct": 1, "explanation": "DRIP buying the harvested security within the 31-day window triggers wash-sale. Disable DRIP as part of the harvest workflow."},
        {"id": "q12", "prompt": "Coordinating with the client's CPA on harvesting activity is best handled by:", "options": ["Only sending 1099s at year-end", "Communicating during the year about material harvest events so the CPA has visibility into the tax situation rather than learning from 1099s", "Letting the CPA discover the activity from broker records", "Avoiding CPA communication entirely"], "correct": 1, "explanation": "CPAs as partners during the year produce better tax outcomes than CPAs as downstream paperwork recipients. Brief notifications of material harvests build the working relationship."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 25;
