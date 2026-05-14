-- ================================================================
-- GIC LMS — MASTER SETUP PART 4
-- Run parts in order: 1 → 2 → 3 → 4 → 5
-- ================================================================


-- ── module19_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 19 CONTENT
-- Portfolio Construction
-- ============================================================================
update public.modules set
  title = 'Portfolio Construction',
  competency_id = 'OJL-10',
  ri_hours = 0,
  ojl_hours = 120,
  short_description = 'Translate a client''s risk profile, time horizon, and goals into a concrete portfolio — selecting building blocks, sizing positions, and writing it down in an Investment Policy Statement that holds.',
  learning_objectives = ARRAY[
    'Move from a risk profile to a target asset allocation defensibly',
    'Select the right building blocks — funds, ETFs, individual securities — for each sleeve',
    'Size positions to match conviction, risk, and tax efficiency',
    'Build a tax-aware portfolio across taxable, tax-deferred, and tax-free accounts',
    'Document the portfolio in an Investment Policy Statement that constrains future drift and emotion'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "From Risk Profile to Target Allocation",
        "summary": "The risk work in Module 15 produced a profile. Now translate that profile into specific percentages across asset classes — defensibly, with reasoning the client can follow.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A portfolio is a structure with a purpose. The purpose, established in earlier modules, is to fund the client's goals at a risk level the client can financially absorb and emotionally tolerate. Construction starts by translating that purpose into a target asset allocation — a written set of percentages across major asset classes that represents how the money should be split if the world were quiet and everything stayed at its target weight. The target allocation is the blueprint. Everything that follows in this module — security selection, position sizing, tax placement — exists to implement and maintain it."},
          {"type": "subheading", "content": "The major asset classes"},
          {"type": "glossary", "terms": [
            {"term": "U.S. equities", "definition": "Stocks of U.S. companies. Subdivided by size (large, mid, small cap) and style (value, blend, growth). The largest single component of most growth-oriented portfolios."},
            {"term": "International developed equities", "definition": "Stocks of companies in developed markets outside the U.S. — Europe, Japan, Canada, Australia. Adds geographic diversification and currency exposure."},
            {"term": "Emerging markets equities", "definition": "Stocks of companies in developing economies — China, India, Brazil, others. Higher expected return, higher volatility, additional political and currency risk."},
            {"term": "U.S. investment-grade bonds", "definition": "Debt of the U.S. government, agencies, and high-rated corporations. Core stabilizer in most portfolios. Sensitive to interest rates."},
            {"term": "High-yield bonds", "definition": "Below-investment-grade corporate debt. Higher yield, equity-like drawdown risk in stress periods."},
            {"term": "International bonds", "definition": "Sovereign and corporate debt outside the U.S. Often currency-hedged in portfolios to isolate the rate exposure."},
            {"term": "TIPS (Treasury Inflation-Protected Securities)", "definition": "Treasuries that adjust principal with CPI. The cleanest inflation hedge available to retail investors."},
            {"term": "Real estate / REITs", "definition": "Real estate investment trusts — public companies that own income-producing property. Hybrid characteristics: bond-like income, equity-like volatility."},
            {"term": "Commodities", "definition": "Broad-basket exposure to commodities through futures-based ETFs or specific commodity holdings. Inflation-correlated, low correlation to equities in some regimes."},
            {"term": "Cash and equivalents", "definition": "Money market funds, T-bills, short-term Treasuries. Liquidity, capital preservation, no growth in real terms over long horizons."}
          ]},
          {"type": "subheading", "content": "From risk band to allocation"},
          {"type": "paragraph", "content": "Most firms maintain a set of model allocations corresponding to risk bands — Conservative, Moderately Conservative, Moderate, Moderately Aggressive, Aggressive. The percentages at each band reflect the firm's house view on the risk-return trade-off. A representative set: Conservative 30/70 equity/fixed income; Moderately Conservative 45/55; Moderate 60/40; Moderately Aggressive 75/25; Aggressive 90/10. These are starting points, not destinations. Adjust based on the specifics of the client."},
          {"type": "subheading", "content": "Sub-allocations within equity and fixed income"},
          {"type": "paragraph", "content": "Within the equity sleeve, a typical split for a moderate U.S.-based investor: 60-65% U.S., 20-25% international developed, 10-15% emerging markets. Within the fixed income sleeve: 70% U.S. investment grade, 10-15% TIPS, 5-10% international bonds, 5-10% short-duration cash equivalents. High-yield, REITs, and commodities are often handled as optional satellite positions of 3-8% each rather than core sleeves. Numbers vary by firm and by client situation."},
          {"type": "callout", "kind": "key", "content": "There is no single correct allocation. Reasonable people in this profession disagree about every percentage. What matters is that the allocation is internally consistent, written down, justified by the client's situation, and held with discipline."},
          {"type": "subheading", "content": "Worked example — Naomi's target allocation"},
          {"type": "paragraph", "content": "Naomi: 32 years old, 32-year horizon, Moderately Aggressive after the panic-email reassessment from Module 15. Target allocation: 75% equity / 25% fixed income overall. Equity sleeve: 50% U.S. (broad market), 18% international developed, 7% emerging markets. Fixed income sleeve: 17% U.S. core bonds, 5% TIPS, 3% short-duration Treasury. No commodities, no REIT sleeve (REIT exposure embedded in broad U.S. market index is sufficient at her stage). 5% cash buffer carved out of the fixed income sleeve to give her something to deploy during drawdowns — Behavioral Finance principle from Module 14."},
          {"type": "callout", "kind": "do", "content": "Every percentage should have a sentence-long justification you can defend to the client. If you cannot articulate why a number is what it is, you cannot defend it under stress and the number is probably wrong."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Choosing Building Blocks — Funds, ETFs, Individual Securities",
        "summary": "The allocation says what to hold. The building blocks decide how to hold it. Active vs passive, fund vs ETF, broad vs targeted — each choice has cost, tax, and access implications.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Once the target allocation is set, each slice needs an implementation vehicle. The major choices are mutual funds, exchange-traded funds (ETFs), separately managed accounts (SMAs), and individual securities. Each has trade-offs around cost, tax efficiency, minimum investment, intraday trading, customization, and the active-versus-passive question. Selecting well across these dimensions is where construction earns or loses real basis points over decades."},
          {"type": "subheading", "content": "Passive vs active — the default and the exceptions"},
          {"type": "paragraph", "content": "The empirical evidence over multi-decade samples is overwhelming: after fees, most actively managed funds underperform their benchmarks. SPIVA reports from S&P Dow Jones Indices consistently show 80-90% of active large-cap U.S. funds underperforming over 15-year periods. This is not because active managers are unskilled. It is because of the math of fees — a 0.75% fee versus a 0.04% fee compounds across decades into a meaningful drag, and the manager has to outperform that drag before adding value. For most core sleeves of most portfolios, the default is broadly diversified, low-cost index funds or ETFs. Active management is an exception to be justified, not the default."},
          {"type": "subheading", "content": "Where active management may add value"},
          {"type": "list", "items": [
            "Less efficient markets — small-cap, certain international, emerging markets, high-yield credit — where active managers have a larger information edge",
            "Tax-managed strategies in taxable accounts where harvesting is part of the alpha",
            "Specific factor or thematic exposures the client wants and that are not well-served by broad indexes",
            "Liability-driven strategies in fixed income where matching cash flows to obligations matters more than tracking an index"
          ]},
          {"type": "subheading", "content": "ETFs vs mutual funds"},
          {"type": "glossary", "terms": [
            {"term": "ETF (Exchange-Traded Fund)", "definition": "Trades on an exchange like a stock. Generally more tax-efficient than mutual funds because of the in-kind creation/redemption mechanism, which limits capital gain distributions. Lower minimums, intraday pricing."},
            {"term": "Mutual fund", "definition": "Priced and traded once per day at the closing NAV. Can have load fees, redemption fees, and is subject to capital gains distributions from internal portfolio activity even if you have not sold."},
            {"term": "Open-end vs closed-end", "definition": "Open-end funds create and redeem shares at NAV. Closed-end funds have a fixed share count and trade on exchanges at premiums or discounts to NAV. Closed-end is a niche use case."},
            {"term": "SMA (Separately Managed Account)", "definition": "Direct ownership of individual securities managed by a third-party manager. Higher minimums (often $250K+), more customization, tax-loss harvesting available at the security level. Worth considering for taxable accounts above certain thresholds."}
          ]},
          {"type": "callout", "kind": "key", "content": "For taxable accounts, the tax efficiency advantage of ETFs over mutual funds compounds. For tax-deferred or tax-free accounts, the tax efficiency difference is moot — choose on cost, breadth, and tracking instead."},
          {"type": "subheading", "content": "Fee evaluation"},
          {"type": "paragraph", "content": "Total cost of ownership is more than the expense ratio. It includes: stated expense ratio, bid-ask spread for ETFs (matters less for high-volume names), tracking error against the benchmark, capital gains distributions, transaction costs at the custodian, and any wrap fees from the advisor. A fund with a 0.04% expense ratio and a 0.01% tracking error costs less to own than a fund with a 0.10% expense ratio and a 0.05% tracking error, all else equal. Compare carefully, especially for core sleeves where the holdings are similar across providers."},
          {"type": "subheading", "content": "Individual securities — when and where"},
          {"type": "paragraph", "content": "Most clients are well-served by funds and ETFs. Individual stock or bond holdings come into play when: the client has a large concentrated position (often employer stock) that needs to be managed down, the portfolio is large enough for direct indexing with SMA-level tax-loss harvesting, or specific bond maturities are needed to fund specific liabilities. Otherwise, individual securities introduce more idiosyncratic risk and oversight burden than they typically reward."},
          {"type": "case_study", "title": "Building Naomi's equity sleeve", "scenario": "For Naomi's 75% equity target on a $185,000 portfolio, the apprentice builds: VTI (Vanguard Total Stock Market ETF) for the 50% U.S. broad exposure, expense ratio 0.03%; VEA (Vanguard FTSE Developed Markets ETF) for the 18% international developed, 0.05%; VWO (Vanguard FTSE Emerging Markets ETF) for the 7% emerging, 0.07%. Total weighted equity-sleeve expense ratio: about 0.04%. The apprentice does not split U.S. into separate large/mid/small/value/growth slices — VTI covers all of that internally and rebalances between them naturally. Simpler is better when complexity does not add value.", "discussion": "Three ETFs cover Naomi's entire equity sleeve at a blended fee under 5 basis points. Five years from now if the portfolio grows past $1M, the apprentice might consider direct indexing for the U.S. portion to add tax-loss harvesting. At the current size, three ETFs is the right call."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Position Sizing and Concentration Management",
        "summary": "How much of any one thing? Position sizing determines whether a portfolio is diversified or just appears to be. Concentrated positions in particular need a deliberate plan.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A portfolio with thirty holdings can still be concentrated if two of them are 40% of the assets. Position sizing — how much of each holding — is where diversification actually lives. The sizing decision has two dimensions: how big any single position should be (sizing rules), and how much exposure to any single risk factor the portfolio should run (concentration management)."},
          {"type": "subheading", "content": "Sizing rules of thumb"},
          {"type": "list", "items": [
            "Broad market core ETFs — can be large positions, since they are themselves diversified across hundreds or thousands of securities (e.g., VTI alone is a defensible 50%+ position because it holds 4,000 stocks)",
            "Sector or thematic ETFs — typically capped at 5-10% of total portfolio each, because they concentrate risk",
            "Individual stocks — typically capped at 2-5% of total portfolio each in a managed account",
            "Concentrated employer stock positions — flag any position over 10% of net worth as requiring active management",
            "Single bond positions — small relative to total fixed income unless they are Treasuries (which carry only interest rate risk, not credit risk)"
          ]},
          {"type": "subheading", "content": "Concentration risk you may not see at first glance"},
          {"type": "paragraph", "content": "Position size in dollar terms is not the only concentration. Look through the holdings for shared underlying exposures. A client who holds VTI, QQQ, an actively managed large-growth fund, and direct shares of Apple may believe they have four diversified holdings; in reality they likely have four overlapping exposures to U.S. mega-cap technology. The look-through is where real concentration shows up. Most modern reporting platforms can produce a sector and factor exposure report — use it."},
          {"type": "subheading", "content": "Concentrated single-stock positions"},
          {"type": "paragraph", "content": "Many clients arrive with large positions in a single stock — most often their current or former employer through RSUs, stock options, ESPP, or founder shares. These positions need a deliberate plan because the risk is asymmetric: the stock that built the wealth can also destroy it. The plan typically combines diversification techniques, often coordinated with the CPA for tax management."},
          {"type": "glossary", "terms": [
            {"term": "Scheduled diversification", "definition": "Selling fixed dollar or share amounts on a fixed schedule — quarterly, annually — regardless of price. Removes timing emotion. Reduces concentration over years."},
            {"term": "Rule 10b5-1 plan", "definition": "A pre-arranged trading plan that allows insiders to sell stock without violating insider trading rules, by pre-committing to a schedule when they have no material non-public information."},
            {"term": "Exchange fund", "definition": "A pooled vehicle that allows investors with concentrated stock to swap into a diversified portfolio with deferred tax recognition. Typically 7-year lock-up; high minimums; complex."},
            {"term": "Hedging strategies", "definition": "Protective puts or collars (long put + short call) to cap downside on a concentrated position. Costs premium or caps upside. More common at higher asset levels."},
            {"term": "Charitable contribution of appreciated stock", "definition": "Donating low-basis stock to a Donor-Advised Fund or directly to charity. Avoids capital gains tax and produces a charitable deduction. The fastest way to diversify with a tax benefit if the client is charitably inclined."}
          ]},
          {"type": "case_study", "title": "Naomi's RSU concentration", "scenario": "Naomi works at a public tech company. Her vested RSUs are worth $94,000 — about 51% of her $185,000 invested portfolio. That is a concentration problem regardless of how she feels about her employer. The apprentice does not push for an immediate sale (tax cost, behavioral resistance, employee loyalty). Instead: establish a Rule 10b5-1 plan to sell the equivalent of one upcoming vest each quarter, redirecting proceeds into the broader portfolio. Over four quarters, the concentration declines materially without forcing a single emotional decision. The apprentice also reviews the cost basis on the lots to identify any near-term harvesting opportunities should the stock decline.", "discussion": "Notice the design: scheduled, pre-committed, neither dramatic nor passive. Diversification becomes a system rather than a decision. By year-end Naomi's employer exposure is closer to 25% and on a glide path to 15%."},
          {"type": "callout", "kind": "warn", "content": "A 'we will sell when the stock is up' or 'we will sell after the next vest' diversification plan is not a plan. It is a deferred decision masquerading as one. Schedule it or hedge it."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Asset Location — The Tax-Aware Portfolio Across Account Types",
        "summary": "The same dollars held in a taxable account, a Traditional IRA, and a Roth IRA do not behave the same after tax. Asset location optimizes which holdings go in which account to add basis points over decades.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Asset allocation answers 'what should I own.' Asset location answers 'where should I own it.' For a client with assets across taxable brokerage, Traditional 401(k)/IRA, and Roth accounts, placing the right holdings in the right account types adds 15-30 basis points of after-tax return per year in some studies — a meaningful effect over a 30-year horizon. This is one of the highest-leverage operational decisions in portfolio construction."},
          {"type": "subheading", "content": "The three buckets and their tax characteristics"},
          {"type": "glossary", "terms": [
            {"term": "Taxable accounts", "definition": "Ordinary brokerage. Interest, non-qualified dividends, and short-term capital gains taxed at ordinary rates. Qualified dividends and long-term capital gains taxed at preferential rates (0/15/20% federal). Cost basis tracked. Step-up at death."},
            {"term": "Tax-deferred accounts (Traditional)", "definition": "401(k), Traditional IRA, 403(b), and others. Contributions usually pre-tax. No tax on growth. Withdrawals taxed as ordinary income. RMDs starting at age 73."},
            {"term": "Tax-free accounts (Roth)", "definition": "Roth 401(k), Roth IRA, Roth conversions. Contributions after-tax. No tax on growth. Qualified withdrawals tax-free. No RMDs for original Roth IRA owner."}
          ]},
          {"type": "subheading", "content": "Location principles"},
          {"type": "list", "items": [
            "Highest-growth assets go in Roth — Roth has the longest effective time horizon (no RMDs) and tax-free withdrawals, so maximize compounding here",
            "Tax-inefficient income-generating assets — high-yield bonds, REITs, actively managed funds with high turnover — go in tax-deferred where the ordinary-income drag is invisible until withdrawal",
            "Tax-efficient assets — broad equity index ETFs with low turnover, municipal bonds, individual stocks held long term — go in taxable, where the qualified dividend and long-term capital gain treatment is favorable",
            "International equities can argue both ways — they generate foreign tax credits useful in taxable accounts, but pay ordinary-income-rate dividends; firm policies vary",
            "Treat the household portfolio as one portfolio across all accounts when measuring overall allocation — do not over-diversify within each account if the whole picture is already diversified"
          ]},
          {"type": "subheading", "content": "Worked example — Marcus and Tasha's location"},
          {"type": "paragraph", "content": "Marcus and Tasha have: $42,000 in his 401(k) (pre-tax), $18,000 in her IRA (Traditional), $11,000 in his Roth IRA, and $24,000 in their taxable joint brokerage. Total $95,000 with a 70/30 target. Location strategy: the Roth IRA goes 100% equity — fastest-growing dollars in the most tax-favored bucket. The taxable brokerage goes 100% tax-efficient broad U.S. and international equity ETFs — qualified dividends, long-term gains, no high-turnover funds. The Traditional IRAs and 401(k) absorb the entirety of the fixed income allocation plus the remaining equity to balance to 70/30 at the household level. Net result: same 70/30 risk exposure, but optimized so that the high-growth assets are in the tax-free bucket and the tax-inefficient assets are in the tax-deferred bucket."},
          {"type": "subheading", "content": "Limitations and caveats"},
          {"type": "paragraph", "content": "Asset location is a long-horizon optimization. The benefits compound over decades but can be invisible quarter to quarter. The technique can also be over-applied — sometimes the simplicity of similar allocations across accounts is worth more than the optimization, particularly for smaller clients where the dollar impact is modest. And client behavior matters: if seeing the taxable account drop 30% in a drawdown while the Roth is up causes panic-selling, the theoretical optimization is destroyed by the actual behavior. Always weigh."},
          {"type": "callout", "kind": "key", "content": "Asset location is a household-level decision. Think of all accounts as one portfolio. Allocate at the household, locate at the account."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "The Investment Policy Statement — Writing the Portfolio Down",
        "summary": "Everything in this module exists to produce an IPS — a written document that defines what the portfolio is, why it is built that way, and what will and will not change it. The IPS is the single most useful artifact in long-term portfolio management.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The Investment Policy Statement is a written agreement between the advisor and the client describing the portfolio's objectives, constraints, target allocation, rebalancing rules, performance benchmarks, and the circumstances under which the policy will be reviewed or changed. It is one to three pages. It is signed by both the client and the advisor. It is the single most valuable document for protecting the portfolio from panic, drift, and ad hoc decision-making over time."},
          {"type": "subheading", "content": "What an IPS contains"},
          {"type": "numbered", "items": [
            "Statement of purpose — what this portfolio is for in plain language",
            "Time horizon — typically the longer of the goal horizon or life expectancy",
            "Return objective — required return for the goals to be achievable",
            "Risk tolerance and risk capacity — both, articulated separately",
            "Target asset allocation — percentages by asset class, with permitted ranges (e.g., 'U.S. equity: 50% target, 45-55% range')",
            "Rebalancing policy — calendar-based, threshold-based, or hybrid; specific rules",
            "Tax considerations — relevant account types and location decisions",
            "Liquidity needs — known cash needs over the next 24 months",
            "Prohibited investments or constraints — any client-specific restrictions (no tobacco, no fossil fuel, no individual stock, etc.)",
            "Performance benchmark — what the portfolio is measured against",
            "Review frequency — at minimum annually; more often during transitions",
            "Signatures and date"
          ]},
          {"type": "subheading", "content": "Permitted ranges — the rebalancing trigger"},
          {"type": "paragraph", "content": "A target allocation without a range is impossible to manage. The market moves percentages every day; if the target is 60% equity, the portfolio will rarely be exactly 60% equity. The IPS specifies an acceptable range around each target — say 55-65% for the 60% equity target — and triggers rebalancing when the range is breached. Common defaults: ±5 percentage points for major asset classes, ±3 for sub-classes. Tighter ranges generate more rebalancing trades (and tax events in taxable accounts); looser ranges allow more drift before action. Pick once, write it down, follow it."},
          {"type": "subheading", "content": "Rebalancing methodology"},
          {"type": "paragraph", "content": "Rebalancing can be calendar-based (quarterly, semi-annually, annually), threshold-based (when an asset class breaches its range), or hybrid (check on schedule and rebalance only if outside range). Empirical research shows the hybrid approach tends to outperform pure calendar rebalancing because it captures the discipline of regular review without forcing trades when none are needed. Annual review with 5% threshold for major classes is a common starting policy."},
          {"type": "callout", "kind": "key", "content": "Rebalancing has two functions: maintaining the risk profile (the more important one), and a small return contribution from systematically selling what is up and buying what is down (the rebalancing bonus). The first is non-negotiable. The second is a bonus."},
          {"type": "subheading", "content": "What the IPS prevents"},
          {"type": "paragraph", "content": "The IPS exists to constrain future decisions made under stress. When the client sends the panic email from Module 14, the IPS is pulled out and read aloud: 'Your IPS says you will not change your allocation in response to a single quarter's performance. If you want to make a change, we will wait 30 days and re-discuss.' The pre-commitment is the constraint. The IPS is the document that makes the pre-commitment real."},
          {"type": "subheading", "content": "Reviewing and updating the IPS"},
          {"type": "paragraph", "content": "The IPS is reviewed at every annual review. It is updated when a material life event changes the underlying facts — retirement starts, a major inheritance arrives, time horizon meaningfully shifts. It is not updated because the client feels nervous about the market or because their friend's portfolio is performing better. Distinguish carefully. The friction of formally amending a signed document is part of what makes the IPS effective."},
          {"type": "case_study", "title": "Naomi's first IPS", "scenario": "After the construction work in this module, the apprentice drafts a 2-page IPS for Naomi. Statement of purpose: 'Long-term retirement accumulation over a 32-year horizon, with a 5-year emergency cushion in the cash sleeve.' Target allocation: 75% equity (50% U.S., 18% intl developed, 7% emerging), 25% fixed income (17% U.S. core bonds, 5% TIPS, 3% short-duration Treasury), with ±5% permitted range on equity and ±3% on sub-classes. Rebalancing: annual review with threshold trigger at the band breaches; in-kind rebalancing preferred in the Roth and tax-deferred accounts. Prohibited: no individual stock purchases (employer-stock concentration managed under separate 10b5-1 plan). Performance benchmark: 75% MSCI ACWI / 25% Bloomberg U.S. Aggregate Bond Index. Review annually, or after any qualifying life event. Both Naomi and the apprentice sign. The IPS is filed in her client folder and a copy goes to her.", "discussion": "Two pages. Five months of thinking encoded into a durable artifact. When Naomi's next panic email arrives, the apprentice opens this document instead of arguing. Naomi argues with her own past decisions, which is much harder than arguing with the advisor."},
          {"type": "callout", "kind": "do", "content": "Every client over a meaningful asset threshold has an IPS. Sign it at the start of the relationship and update on schedule. If you cannot write an IPS for a portfolio, the portfolio is not yet finished being designed."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Investment Research & Due Diligence. The building blocks chosen here did not arrive by accident — research and diligence sit behind every fund, every manager, and every strategy added to a portfolio."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The primary purpose of a target asset allocation is to:", "options": ["Maximize return over the next quarter", "Establish a written blueprint for how the portfolio should be split if everything stayed at target", "Match the S&P 500", "Avoid all losses"], "correct": 1, "explanation": "The target allocation is the blueprint — a written set of percentages that represents the intended structure. Everything else in construction implements and maintains it."},
        {"id": "q2", "prompt": "SPIVA research consistently shows that over 15-year periods, most actively managed large-cap U.S. funds:", "options": ["Outperform their benchmarks", "Underperform their benchmarks net of fees", "Match their benchmarks exactly", "Have no measurable benchmark"], "correct": 1, "explanation": "80-90% of active large-cap U.S. funds underperform over 15 years, largely due to fee drag. For most core sleeves, low-cost index funds are the default and active is the exception."},
        {"id": "q3", "prompt": "ETFs are generally more tax-efficient than mutual funds because:", "options": ["They have lower expense ratios always", "The in-kind creation/redemption mechanism limits capital gain distributions", "They never invest in dividend-paying stocks", "ETF holders pay no taxes"], "correct": 1, "explanation": "In-kind creation/redemption allows ETFs to flush low-basis lots without triggering taxable distributions to fund holders. Mutual funds lack this mechanism and often distribute capital gains."},
        {"id": "q4", "prompt": "A Rule 10b5-1 plan allows insiders to:", "options": ["Avoid all taxes on stock sales", "Pre-commit to a trading schedule when they have no material non-public information, allowing future sales without violating insider trading rules", "Sell unlimited amounts of stock at any time", "Hedge currency exposure"], "correct": 1, "explanation": "10b5-1 plans are the standard mechanism for systematic diversification of concentrated insider stock positions while maintaining compliance with securities law."},
        {"id": "q5", "prompt": "In asset location optimization, the highest-growth assets generally go in:", "options": ["Taxable brokerage", "Traditional IRA / 401(k)", "Roth accounts", "Cash"], "correct": 2, "explanation": "Roth accounts grow tax-free with no RMDs — the longest effective compounding horizon. Highest-growth assets here maximize the tax-free benefit."},
        {"id": "q6", "prompt": "Tax-inefficient income-generating assets like high-yield bonds and REITs are generally best placed in:", "options": ["Taxable accounts for the dividends", "Tax-deferred accounts where the ordinary-income drag is invisible until withdrawal", "Roth accounts only", "Outside any account"], "correct": 1, "explanation": "These assets generate ordinary-income-rate distributions. Placing them in tax-deferred accounts shields the drag from current taxation."},
        {"id": "q7", "prompt": "A reasonable position-size cap for a single individual stock (other than concentrated employer equity being actively managed) in a managed portfolio is typically:", "options": ["20-30% per stock", "10-15% per stock", "2-5% per stock", "Whatever the client prefers"], "correct": 2, "explanation": "Individual stock exposure is typically capped at 2-5% per name to limit idiosyncratic risk. Concentrations beyond that flag for active management."},
        {"id": "q8", "prompt": "Permitted ranges around a target allocation exist primarily to:", "options": ["Allow the advisor to outperform the benchmark", "Provide a clear rebalancing trigger when an asset class drifts outside the range", "Reduce the number of holdings", "Comply with FINRA rules"], "correct": 1, "explanation": "The range turns a target into a managed range. Drift outside the range triggers rebalancing; drift inside is tolerated."},
        {"id": "q9", "prompt": "Rebalancing has two functions — maintaining the risk profile, and a small return contribution. The more important of the two is:", "options": ["The return contribution", "Maintaining the risk profile", "Generating tax losses", "Reducing fees"], "correct": 1, "explanation": "Without rebalancing, equity drift takes a 60/40 portfolio to 75/25 over a strong equity decade — and the client is now in a portfolio they did not sign up for. Risk maintenance is the primary function."},
        {"id": "q10", "prompt": "The Investment Policy Statement is best described as:", "options": ["A marketing document", "A pre-commitment artifact written when the client is calm, used to constrain future decisions made under stress", "A regulatory filing", "An optional summary"], "correct": 1, "explanation": "The IPS turns calm-state thinking into a durable constraint. Its value is highest precisely when the client is tempted to abandon the plan."},
        {"id": "q11", "prompt": "When a client holds VTI, QQQ, an active large-growth fund, and direct Apple shares, the most important diligence is to:", "options": ["Add an emerging-markets ETF", "Look through the holdings for shared underlying exposures — likely concentrated in U.S. mega-cap tech", "Sell everything and start over", "Add small-cap exposure"], "correct": 1, "explanation": "Position count is not diversification. Look-through reveals the real concentration — in this case, likely heavy U.S. mega-cap tech exposure repeated across four wrappers."},
        {"id": "q12", "prompt": "The IPS should be updated:", "options": ["Every quarter as markets move", "Whenever the client feels nervous", "When a material life event changes the underlying facts — retirement, large inheritance, time horizon shift", "Only by regulators"], "correct": 2, "explanation": "The IPS changes when the facts change, not when feelings change. The friction of formally amending the document is part of what makes it effective at constraining reactive decisions."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 20;

-- ── module20_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 20 CONTENT
-- Investment Research & Due Diligence
-- ============================================================================
update public.modules set
  title = 'Investment Research & Due Diligence',
  competency_id = 'OJL-11',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Evaluate funds, managers, and strategies with the depth a fiduciary owes the work — examining costs, structure, performance in context, and the operational realities behind the marketing.',
  learning_objectives = ARRAY[
    'Read a fund prospectus, fact sheet, and annual report critically',
    'Evaluate fund performance in proper context — benchmarks, peer groups, time periods',
    'Assess manager and firm quality beyond returns',
    'Recognize fee structures and conflicts of interest in product offerings',
    'Document a defensible recommendation for adding or removing a holding'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Reading a Fund Document Critically",
        "summary": "Prospectuses, fact sheets, and annual reports contain the answers to most diligence questions. Learn what to look for and what to ignore.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Every mutual fund and ETF publishes a stack of regulatory documents — prospectus, statement of additional information (SAI), summary prospectus, fact sheet, semi-annual and annual reports. Most clients never open them. Most advisors who add funds to client portfolios do not read them carefully either. That is a problem. A fiduciary recommendation requires you to have actually read the documents, understood the structure, and identified what could go wrong. This lesson teaches what to look for in each."},
          {"type": "subheading", "content": "The summary prospectus — a starting point"},
          {"type": "paragraph", "content": "The summary prospectus is the SEC-mandated short-form document — typically 4-8 pages — that distills the full prospectus. It covers: investment objective, fees and expenses (with the standardized fee table), principal investment strategies, principal risks, past performance, portfolio management team, purchase/sale information, and tax information. Read this first. It will tell you most of what you need to know about the fund's design."},
          {"type": "subheading", "content": "What to look at in the fee table"},
          {"type": "glossary", "terms": [
            {"term": "Expense ratio", "definition": "The annual operating expenses as a percent of fund assets. The most-quoted single number. Compare to peer funds and to index alternatives."},
            {"term": "12b-1 fees", "definition": "Annual marketing and distribution fees, embedded in the expense ratio. Common in load funds, less so in institutional share classes. Generally a flag for retail-oriented share classes with worse economics."},
            {"term": "Front-end load", "definition": "A sales charge paid at purchase, reducing the amount invested. Common in A-share mutual funds. Almost always avoidable through institutional share classes or no-load alternatives."},
            {"term": "Back-end load / CDSC", "definition": "Contingent deferred sales charge — paid on exit, usually declining over a holding period. Common in B-share mutual funds."},
            {"term": "Redemption fees", "definition": "Short-term trading fees, designed to deter rapid trading. Less concerning than loads since they protect long-term shareholders."},
            {"term": "Expense reimbursement / waiver", "definition": "A temporary fee reduction by the manager. Read the expiration date — net expense ratio today may be higher in two years if the waiver expires."}
          ]},
          {"type": "subheading", "content": "Investment objective and strategy — what is the fund actually trying to do?"},
          {"type": "paragraph", "content": "The objective is usually one sentence. 'Seeks long-term capital appreciation.' The strategy section is more useful — it tells you how. 'Invests primarily in mid-cap U.S. growth stocks using a fundamental research process emphasizing earnings growth and management quality.' Read carefully. The strategy should match how you intend to use the fund in the portfolio. A 'tactical' or 'unconstrained' strategy may drift across asset classes in ways that disrupt the asset allocation."},
          {"type": "subheading", "content": "Principal risks — what could go wrong"},
          {"type": "paragraph", "content": "This section is required to list the meaningful risks. Read it for category-specific risks (emerging markets country risk, currency, derivatives exposure, credit risk in fixed income, concentration risk in sector funds) and for any unusual risks specific to the fund (use of leverage, illiquid holdings, securities lending). If the risk list is unusually long or contains items you do not recognize, dig further or pass."},
          {"type": "callout", "kind": "warn", "content": "Pay particular attention if the prospectus permits significant use of derivatives, leverage, or short selling in what otherwise appears to be a traditional fund. Marketing materials may not emphasize these, but the prospectus must disclose them."},
          {"type": "subheading", "content": "The annual report and management discussion"},
          {"type": "paragraph", "content": "The annual report includes the full portfolio of holdings, audited financial statements, and the manager's discussion of recent performance and positioning. The manager's discussion is sometimes substantive and sometimes formulaic. Read several years of these in sequence to see whether the manager explains performance honestly (acknowledges what went wrong and learned from it) or defensively (blames external factors, takes credit for what worked, deflects on what did not). A consistent pattern of honest reflection is a positive signal."},
          {"type": "case_study", "title": "Three funds, one weekend", "scenario": "The apprentice is evaluating three candidates for the international developed equity sleeve: VEA (Vanguard FTSE Developed Markets ETF), IDV (iShares International Select Dividend ETF), and an actively managed international fund pitched by a wholesaler with strong recent returns. Reading the documents: VEA — 0.05% expense ratio, holds ~4,000 stocks across developed markets, tracks FTSE Developed All Cap ex US Index, no leverage, no derivatives. IDV — 0.49% expense ratio, holds ~100 stocks, concentrated in high-dividend developed-market companies, sector concentration in financials and utilities, currency-unhedged. Active fund — 0.95% expense ratio, 1.5% front-end load on A shares (institutional class available at 0.85%), uses currency forwards for hedging, 90 stock portfolio, recent 3-year outperformance preceded by 5 years of underperformance, manager joined the fund 18 months ago.", "discussion": "The apprentice's read: VEA matches the role (broad international developed exposure) at the lowest cost with no hidden risk. IDV is a different bet (high-dividend factor tilt) — fine for a different purpose, not for the broad-exposure slot. The active fund's recent outperformance is tempting but the manager change is significant and the long-term record is mixed. Decision: VEA. The diligence supports the choice."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Performance Evaluation — Returns in Context",
        "summary": "Raw return numbers are nearly meaningless without context. Real evaluation requires the right benchmark, the right peer group, the right time period, and an honest reckoning with what can be explained by luck.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If a fund returned 14% last year, is that good? Bad? Average? The answer depends on what the fund is trying to do, what its benchmark did, what comparable funds did, and what risks were taken to produce that return. Performance evaluation is one of the easiest things to do badly. Done well, it filters out luck from skill and prevents the chasing of recent winners — which is one of the most costly behaviors in advisory work."},
          {"type": "subheading", "content": "The right benchmark"},
          {"type": "paragraph", "content": "Every fund should be measured against a benchmark that represents the universe it invests in. A U.S. large-cap fund is benchmarked to the S&P 500 or Russell 1000, not to the MSCI ACWI. A short-term Treasury fund is benchmarked to a short-Treasury index, not the Bloomberg U.S. Aggregate. Funds often disclose their benchmark in the prospectus. Some active funds compare themselves to flattering benchmarks — be alert. The benchmark should match the actual investment universe."},
          {"type": "subheading", "content": "Peer group comparison"},
          {"type": "paragraph", "content": "Beyond the benchmark, the fund should be compared to peer funds doing similar things. Morningstar categories, Lipper categories, and similar services group funds by strategy and style. A fund that outperformed its benchmark may have underperformed its peer group — meaning other funds in the same style did even better. Both comparisons matter."},
          {"type": "subheading", "content": "Time periods — short is misleading, long is necessary"},
          {"type": "list", "items": [
            "1-year returns — almost always noise, particularly for active funds; do not chase",
            "3-year returns — beginning to be meaningful but still heavily influenced by the starting and ending points",
            "5-year returns — useful but still benefit from rolling-period analysis",
            "10-year returns — meaningful but watch for survivorship bias (funds that did badly were closed and disappeared from the record)",
            "Rolling-period analysis — show the worst, best, and median rolling 3- and 5-year periods; tells you what the fund has done across many environments not just two endpoints"
          ]},
          {"type": "callout", "kind": "key", "content": "Recent strong performance is the single most common reason inappropriate funds get added to portfolios. The discipline of demanding long-term track records and rolling-period analysis filters out luck-driven winners."},
          {"type": "subheading", "content": "Risk-adjusted returns"},
          {"type": "glossary", "terms": [
            {"term": "Sharpe ratio", "definition": "Excess return over the risk-free rate divided by standard deviation. Higher is better. Useful for comparing similar-style funds."},
            {"term": "Sortino ratio", "definition": "Like Sharpe but only penalizes downside deviation. Better for asymmetric return profiles."},
            {"term": "Alpha", "definition": "Return in excess of what the fund's exposure to broad factors would predict. Persistent positive alpha is rare; chase it cautiously."},
            {"term": "Beta", "definition": "Sensitivity to the benchmark's movements. Beta of 1.1 means the fund moves about 10% more than the benchmark in either direction."},
            {"term": "Tracking error", "definition": "Standard deviation of the difference between fund returns and benchmark returns. Lower is better for index funds; for active funds, it indicates how much the manager deviates from the benchmark."},
            {"term": "Capture ratio", "definition": "How much of the benchmark's upside and downside the fund captured. Up capture of 105% and down capture of 90% would be a very strong profile."}
          ]},
          {"type": "subheading", "content": "Behavior in stress periods"},
          {"type": "paragraph", "content": "A fund's performance in normal markets is less diagnostic than its performance in stress. How did the fund do in Q4 2018, March 2020, calendar 2022? These were periods where positioning and discipline were tested. A fund that fell more than its benchmark in stress periods is taking more risk than the benchmark — which may be intentional or may be hidden leverage. A fund that fell less is exhibiting some defensive characteristic that should be understood. Either way, stress-period behavior is the data that matters."},
          {"type": "case_study", "title": "The 'great' active fund that was not", "scenario": "A wholesaler pitches an active small-cap fund with a 3-year annualized return of 16.4%, beating its benchmark by 280 basis points. The apprentice digs in. Peer group: the median small-cap fund returned 14.8% over the same 3-year window — the pitched fund's outperformance vs benchmark is partly the asset class, not the manager. Rolling-period analysis: the fund's worst 3-year period since inception was -12% annualized; its best 3-year was the one being pitched. The 10-year track record under the same manager: 0.9% annualized excess return over benchmark, with periods of significant underperformance. The recent 3-year returns reflect a favorable environment for the manager's style, not durable alpha.", "discussion": "The pitched 3-year number was real. It was also not representative of long-run performance. Without the peer group and rolling-period analysis, the apprentice might have added a fund whose excess return is most likely to mean-revert toward zero or below — at a 0.95% expense ratio."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Manager and Firm Quality",
        "summary": "Numbers tell part of the story. The people behind the numbers tell the rest. Evaluating manager and firm quality requires reading beyond marketing.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A fund is operated by people — portfolio managers, analysts, traders, and the firm that employs them. The quality of these people and the institution they work in is a major component of whether the strategy will be executed well over time. Marketing materials emphasize the team's credentials, awards, and tenure. Diligence requires looking at structural and behavioral factors that marketing rarely highlights."},
          {"type": "subheading", "content": "Manager tenure and continuity"},
          {"type": "list", "items": [
            "How long has the current portfolio manager been on the fund?",
            "Has the team changed in the past 3 years? If yes, performance attribution to the current team is unclear",
            "Is the manager named, or is the fund managed by an anonymous committee?",
            "If the manager retired or left, what was the transition plan and how was it communicated?",
            "Has the manager invested their own money in the fund? Annual reports disclose this — meaningful alignment matters"
          ]},
          {"type": "subheading", "content": "Firm structure and incentives"},
          {"type": "glossary", "terms": [
            {"term": "Asset gathering vs investment focus", "definition": "Firms that prioritize asset growth over investment results may launch funds chasing recent trends, close funds when they get too large to manage well, or run sales-driven product cycles. Investment-focused firms typically run fewer products and steward capacity carefully."},
            {"term": "Capacity discipline", "definition": "Some strategies — particularly in less-liquid market segments — have natural capacity limits. Firms that close strategies to new money when they near capacity are exhibiting fiduciary discipline. Firms that keep gathering past capacity are not."},
            {"term": "Compensation structure", "definition": "Long-term performance fees aligned with fund returns tend to produce better long-term outcomes than asset-based fees alone. Annual report and SAI may disclose compensation philosophy."},
            {"term": "Employee ownership", "definition": "Firms substantially owned by employees often have different incentive structures than firms owned by parent banks or private equity. Both can work; understand the structure."},
            {"term": "Regulatory history", "definition": "SEC enforcement actions, FINRA disciplinary matters, and significant litigation should be checked via Form ADV, BrokerCheck, and SEC EDGAR. Not all problems are disqualifying — read what happened."}
          ]},
          {"type": "subheading", "content": "Form ADV — the diligence document for advisers"},
          {"type": "paragraph", "content": "Every SEC-registered investment adviser files a Form ADV — Part 1 (business and disciplinary information) and Part 2 (the 'brochure' describing services, fees, conflicts, and investment philosophy). These are public on the SEC's IAPD website. Part 2 is the more readable document; read it for any manager or sub-advisor whose strategy you are recommending. It tells you who the firm is, what they do, how they get paid, what conflicts they have, and what regulatory history exists."},
          {"type": "callout", "kind": "do", "content": "Before recommending any actively managed strategy, read the manager's Form ADV Part 2. It is free, takes 20 minutes, and tells you what marketing materials will not."},
          {"type": "subheading", "content": "Cultural signals"},
          {"type": "paragraph", "content": "Some signals are harder to quantify but real. How does the firm communicate during difficult periods? What language do they use about risk? Do they publish thoughtful, candid commentary, or pure marketing? How do they handle a fund that has underperformed — defend it, close it, or quietly let it linger? Several years of reading a firm's commentary tells you something about how they think. Trust this signal alongside the numbers."},
          {"type": "case_study", "title": "Naomi's emerging markets pick", "scenario": "For the 7% emerging markets sleeve, the apprentice considers two options: VWO (Vanguard FTSE Emerging Markets ETF, 0.07% expense ratio, passive) and an actively managed EM fund from a respected boutique firm (0.85% expense ratio, strong 10-year record). Reading the boutique's ADV Part 2 and annual reports: the lead manager has been on the strategy 14 years, owns substantial personal money in the fund, the firm closed a strategy to new money in 2022 when capacity was reached (positive signal), and the annual reports are unusually candid about both wins and losses. Diligence supports the active manager. But: at Naomi's portfolio size, the after-fee gap between paying 0.78% more for active versus 0.07% passive would need ~80 bps of annualized alpha to break even, which even great managers struggle to deliver consistently after taxes in a taxable account. Decision for now: VWO. Revisit if portfolio grows substantially or moves to tax-advantaged-only EM allocation.", "discussion": "Notice — the active fund passed manager and firm diligence. It still did not win the allocation because of size and tax considerations. Diligence informs the decision; it does not dictate it."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Conflicts of Interest and Fee Structures",
        "summary": "Most investment products are sold, not bought. Knowing how each product line gets paid for and what conflicts that creates is fundamental fiduciary diligence.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A surprising number of investment recommendations across the industry are influenced — sometimes consciously, often unconsciously — by how the recommending entity gets paid. Fiduciary work requires understanding the fee economics of every product you consider, identifying where conflicts could exist, and either avoiding the conflict or disclosing and managing it. The Department of Labor's evolving fiduciary rules and Reg BI both reflect a regulatory push toward transparency here. Industry practice still varies."},
          {"type": "subheading", "content": "How fund companies make money"},
          {"type": "list", "items": [
            "Asset-based management fees on AUM — the foundational revenue model",
            "Performance fees on absolute returns or excess over benchmark — common in alternatives, less common in mutual funds",
            "Distribution fees including 12b-1 — paid by the fund to platforms and intermediaries for shelf space and trail commissions",
            "Revenue sharing — direct payments from fund companies to broker-dealers or RIA platforms for placement on preferred lists",
            "Trailers and finder's fees — recurring payments to placing entities; declining in transparent platforms but still present"
          ]},
          {"type": "subheading", "content": "How recommending entities get paid"},
          {"type": "glossary", "terms": [
            {"term": "Fee-only RIA", "definition": "Compensation comes only from clients in the form of advisory fees. No commissions, no trailers, no third-party payments. Cleanest fiduciary structure."},
            {"term": "Fee-based", "definition": "Charges both advisory fees and earns commissions on certain products. Can be fiduciary on the advisory side and suitability-standard on the brokerage side. Read carefully."},
            {"term": "Commission-based broker-dealer", "definition": "Compensation comes from product sales — loads, 12b-1 fees, mark-ups, insurance commissions. Reg BI raised the standard but the structural conflicts remain."},
            {"term": "Wirehouse rep", "definition": "Broker associated with a large national firm. May offer fee-based advisory accounts and commission-based brokerage accounts to the same client."},
            {"term": "Insurance agent / dual-registered", "definition": "May earn commissions on annuities and life insurance alongside advisory fees. Annuity commissions in particular can be substantial — read the product carefully."}
          ]},
          {"type": "subheading", "content": "Red flags in product recommendations"},
          {"type": "list", "items": [
            "A product is recommended that pays significantly higher compensation than alternatives, with no clearly explained client benefit",
            "Share class chosen carries higher embedded fees than a cleaner share class available on the same platform",
            "Proprietary products preferred over comparable third-party offerings without explicit justification",
            "Insurance products (variable annuities, indexed universal life) recommended where simpler tax-advantaged investing would solve the same client need",
            "Frequent recommendations to switch funds in a way that generates new commissions ('churning')",
            "Rollovers from low-fee employer plans into higher-fee advisor-managed IRAs without clear net benefit"
          ]},
          {"type": "callout", "kind": "warn", "content": "Rollover recommendations from a low-cost employer 401(k) into an advisor-managed IRA receive elevated scrutiny under DOL rules because the conflict is structural. Document specifically why the rollover is in the client's best interest given the fees, options, and protections at stake."},
          {"type": "subheading", "content": "Disclosure is not enough on its own"},
          {"type": "paragraph", "content": "Disclosing a conflict satisfies a regulatory requirement but does not satisfy a fiduciary duty. A conflict that is disclosed and recommended anyway must also be justified — the client must be better off with the conflicted recommendation than with the unconflicted alternative. If they would be equally well-served by the cleaner option, choose the cleaner option. Disclosure is a floor, not a license."},
          {"type": "case_study", "title": "The variable annuity question", "scenario": "A wholesaler proposes a deferred variable annuity for a client's $300K in non-qualified savings. The product has a 1.65% mortality and expense fee, a 2.10% rider fee for a guaranteed lifetime withdrawal benefit, 11 subaccount funds with their own underlying expense ratios, and a 7-year surrender schedule. The wholesaler emphasizes 'guaranteed income' and 'tax deferral.' The apprentice analyzes the proposal: total all-in cost is roughly 3.85% per year for the first 7 years. The 'tax deferral' benefit applies on top of an already-taxable bucket, but qualified dividends and long-term capital gains in the alternative low-cost ETF portfolio would be taxed at preferred rates while the annuity withdrawals will be at ordinary rates. The lifetime income benefit is real but expensive — the same outcome could be achieved with a deferred income annuity at age 75 for a fraction of the lifetime cost. The wholesaler's commission on the proposed product is approximately 6% of premium.", "discussion": "The apprentice does not recommend the product. The diligence memo documents the analysis: cost stack, tax treatment of distributions vs alternative, alternative income vehicles, commission disclosure. The client is presented with the choice transparently. The client passes. Documentation is filed for compliance and for the client record."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Documenting Investment Decisions",
        "summary": "Every investment decision — additions, removals, replacements — should leave a clear paper trail. Documentation is part of the fiduciary work, not paperwork after it.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "If a regulator, a client, or a colleague asked you three years from now why a particular fund is in the portfolio, what was considered, and what alternatives were rejected — could you reconstruct the answer from your files? If not, the decision is undefendable in retrospect, regardless of how good the decision was at the time. Documentation is the artifact of the diligence, and the diligence is incomplete without it."},
          {"type": "subheading", "content": "The investment decision memo"},
          {"type": "paragraph", "content": "For any consequential portfolio decision — adding a new holding, removing an existing one, replacing one fund with another — produce a short memo that captures the analysis. The memo should be brief (one to two pages) and specific. Generic justifications ('high quality manager,' 'strong long-term performance') are not useful. Specific justifications backed by data are."},
          {"type": "subheading", "content": "What the memo contains"},
          {"type": "numbered", "items": [
            "What is being decided — the specific addition, removal, or replacement",
            "What role this position plays in the portfolio — which sleeve, which purpose",
            "What was evaluated — funds considered, with relevant numbers",
            "Why this choice — the specific reasons, including cost, structure, manager, performance in context, and alignment with the portfolio's needs",
            "Why not the alternatives — what was rejected and why",
            "Risks of the decision — what could go wrong with this choice",
            "When to revisit — under what conditions would we reconsider",
            "Sign-off and date"
          ]},
          {"type": "subheading", "content": "Ongoing monitoring documentation"},
          {"type": "paragraph", "content": "Decisions are not one-time events. Once a holding is in the portfolio, ongoing monitoring is required. The firm should have a written policy describing what is reviewed (performance vs benchmark and peers, manager continuity, capacity, fees, any material changes), how often (quarterly, semi-annually, or annually depending on the firm's standard), and what triggers escalation (material underperformance, manager change, regulatory issue, strategy drift). Document the monitoring in a standard format so any reviewer can see what has been examined."},
          {"type": "subheading", "content": "Replacement decisions"},
          {"type": "paragraph", "content": "Removing or replacing a holding deserves the same documentation as adding one. The hardest replacements are those triggered by emotion — a fund had a bad year and you are tempted to replace it. Discipline: was the bad year explainable by the strategy's expected behavior, by manager continuity issues, by something structurally broken in the firm? Or was it just the kind of stretch that happens to good managers periodically? Replace for structural reasons. Hold through painful periods that are consistent with the strategy."},
          {"type": "callout", "kind": "key", "content": "The hardest discipline in research is patience. Most underperformance in good funds is temporary, and most chases of recent outperformance are followed by disappointment. The decision file is what protects you from your own urgency."},
          {"type": "subheading", "content": "Team review of decisions"},
          {"type": "paragraph", "content": "At firms with multiple advisors or analysts, investment decisions should be reviewed by more than one person before implementation. The second reviewer is not there to rubber-stamp — they are there to ask 'what did you miss?' and 'why this and not that?' This both improves decision quality and provides institutional memory for what was considered. At smaller firms, building the second-reviewer function with a senior peer or external consultant is worth the effort."},
          {"type": "case_study", "title": "The decision memo for Naomi's portfolio", "scenario": "After completing the construction in Module 19 and the diligence in this module, the apprentice writes a 1.5-page memo: 'Recommended Holdings — Naomi K. Initial Portfolio Construction.' For each holding: purpose, why this fund, what was considered and rejected, expense ratio, key risks, monitoring triggers. The memo is reviewed by the supervising advisor, signed, and filed. A summary version of the same content is in plain language in Naomi's IPS for her file.", "discussion": "Five years from now if Naomi or a regulator asks why she owns these specific funds, the answer is on file with the analysis that produced it. The memo is short — but it is complete. Discipline scales."},
          {"type": "callout", "kind": "do", "content": "Treat documentation as the lower bound of diligence — work that was not documented might as well not have been done. The memo is part of the recommendation."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Asset Allocation & Rebalancing. The portfolio is built. Now the discipline of maintaining its design across years of market movement."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The summary prospectus typically contains all of the following EXCEPT:", "options": ["Fees and expenses", "Past performance", "Principal risks", "Detailed portfolio holdings transactions for the year"], "correct": 3, "explanation": "Detailed transactional holdings appear in the annual report and Statement of Additional Information, not the summary prospectus."},
        {"id": "q2", "prompt": "A fund's 1-year return is generally:", "options": ["The most important performance metric", "Almost always noise, particularly for active funds, and should not drive selection", "A reliable indicator of long-term skill", "More important than expense ratio"], "correct": 1, "explanation": "Short-term returns are dominated by luck and starting/ending points. Long-term, rolling-period analysis is required to filter signal from noise."},
        {"id": "q3", "prompt": "Tracking error measures:", "options": ["Total return", "Standard deviation of the difference between fund returns and benchmark returns", "Manager skill", "Total expenses"], "correct": 1, "explanation": "Tracking error indicates how much a fund deviates from its benchmark. Low for index funds; informative for active funds about manager deviation from the benchmark."},
        {"id": "q4", "prompt": "Form ADV Part 2 contains:", "options": ["A fund's past performance", "Plain-language disclosure of an investment adviser's services, fees, conflicts, and investment philosophy", "A list of all client accounts", "Trade execution records"], "correct": 1, "explanation": "Form ADV Part 2 is the 'brochure' — the readable diligence document for SEC-registered advisers. Required reading before recommending any manager."},
        {"id": "q5", "prompt": "12b-1 fees are:", "options": ["A type of capital gain", "Annual marketing and distribution fees embedded in the fund's expense ratio", "Front-end sales loads", "Performance fees"], "correct": 1, "explanation": "12b-1 fees compensate platforms and distributors. They appear in the expense ratio and indicate retail-oriented share classes with worse economics than institutional alternatives."},
        {"id": "q6", "prompt": "When evaluating a fund's stress-period performance, you should look at:", "options": ["Only its peak-to-trough decline", "How it performed in Q4 2018, March 2020, and calendar 2022 relative to its benchmark", "Only its average return", "The Sharpe ratio alone"], "correct": 1, "explanation": "Stress periods reveal positioning and discipline. A fund that fell more than its benchmark may carry hidden risk; one that fell less has some defensive characteristic worth understanding."},
        {"id": "q7", "prompt": "A fund whose lead manager just changed 18 months ago, with a strong 3-year performance record under the new manager, should be evaluated with:", "options": ["Full credit for the 3-year record", "Recognition that performance attribution to the current manager is unclear and the longer track record may not be the new manager's", "Disqualification regardless of details", "Greater confidence than longer-tenured managers"], "correct": 1, "explanation": "Performance under a previous manager is not the current manager's record. Evaluate the new manager on their own merits and require a longer track record to develop conviction."},
        {"id": "q8", "prompt": "Rollover recommendations from a low-cost employer 401(k) to an advisor-managed IRA:", "options": ["Are always in the client's best interest", "Receive elevated scrutiny under DOL rules because of structural conflict and should be specifically justified", "Require no documentation", "Are prohibited"], "correct": 1, "explanation": "The fee economics typically benefit the advisor; the client must benefit on net. Document the specific reasons the rollover is best for the client given fees, options, and protections."},
        {"id": "q9", "prompt": "Disclosing a conflict of interest:", "options": ["Fully satisfies fiduciary duty", "Is a regulatory requirement but does not by itself satisfy fiduciary duty — the recommendation must still be best for the client", "Eliminates the conflict", "Is optional under Reg BI"], "correct": 1, "explanation": "Disclosure is a floor, not a ceiling. A conflicted recommendation must still be in the client's best interest, not merely disclosed."},
        {"id": "q10", "prompt": "Capacity discipline at an investment management firm refers to:", "options": ["Limiting employee headcount", "Closing strategies to new money when they near natural capacity limits, even at the cost of fee revenue", "Restricting client access", "Reducing fund holdings"], "correct": 1, "explanation": "Firms that close strategies at capacity exhibit fiduciary discipline over asset gathering. It is a positive signal in manager diligence."},
        {"id": "q11", "prompt": "When considering whether to replace an underperforming fund, the discipline is to ask:", "options": ["Did the fund underperform last year?", "Is the underperformance explainable by the strategy's expected behavior, or is something structurally broken in the manager or firm?", "Has any peer fund done better recently?", "Will the client be happy if we change?"], "correct": 1, "explanation": "Replace for structural reasons (manager change, firm trouble, strategy drift). Hold through painful periods that are consistent with the strategy's expected behavior."},
        {"id": "q12", "prompt": "The investment decision memo for a new holding should include:", "options": ["Only the chosen fund's positive attributes", "What was decided, why this choice, why not the alternatives, risks, when to revisit, with sign-off", "Just the expense ratio", "Marketing materials from the fund company"], "correct": 1, "explanation": "A defensible memo captures the full reasoning so that, years later, a reviewer can reconstruct what was considered and why this was the choice."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 21;

-- ── module21_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 21 CONTENT
-- Asset Allocation & Rebalancing
-- ============================================================================
update public.modules set
  title = 'Asset Allocation & Rebalancing',
  competency_id = 'OJL-12',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Maintain a portfolio''s design across years of market movement — choosing a rebalancing methodology, executing trades tax-aware, and adjusting allocations as the client''s life evolves.',
  learning_objectives = ARRAY[
    'Compare strategic, tactical, and dynamic asset allocation approaches',
    'Implement calendar-based, threshold-based, and hybrid rebalancing methodologies',
    'Execute rebalancing trades in a tax-aware manner across account types',
    'Adjust target allocations across the life cycle without overreacting to short-term events',
    'Maintain documentation of allocation changes and the reasoning behind them'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Strategic, Tactical, and Dynamic Allocation",
        "summary": "There are three philosophies of how to set and adjust asset allocation. Most retail planning lives at the strategic end of the spectrum, but understanding all three is part of the work.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Asset allocation is the most-studied decision in portfolio management, and the most consequential. Multiple academic studies — most famously Brinson, Hood, and Beebower (1986) — have estimated that asset allocation explains the majority of the variation in long-term portfolio returns. The follow-on debate about whether the figure is 90%+ or closer to 40% misses the more practical point: how you allocate matters more than which specific funds you pick within an allocation. Three broad philosophies define how practitioners approach the allocation question."},
          {"type": "subheading", "content": "Strategic asset allocation"},
          {"type": "paragraph", "content": "Strategic allocation sets a long-term target based on the client's situation — goals, time horizon, risk capacity and tolerance, return needs — and maintains that target with discipline through market cycles. The allocation changes when the underlying client situation changes (retirement, major inheritance, time horizon shift), not when the planner forms a market view. Strategic allocation is the dominant philosophy in retail planning because it is consistent with fiduciary duty, supported by empirical evidence, and avoids the trap of timing markets badly."},
          {"type": "subheading", "content": "Tactical asset allocation"},
          {"type": "paragraph", "content": "Tactical allocation deviates from a strategic baseline based on short- to medium-term market views — overweighting an asset class that appears attractive on valuation or momentum grounds, underweighting one that appears expensive or vulnerable. Tactical deviations are typically constrained — say ±10% from the strategic target — and meant to add modest returns through skillful timing. Empirical evidence on tactical allocation skill is mixed. Most retail tactical strategies have not beaten their strategic benchmark after costs."},
          {"type": "subheading", "content": "Dynamic asset allocation"},
          {"type": "paragraph", "content": "Dynamic allocation systematically adjusts based on rules — a glide path that grows more conservative as retirement approaches, a volatility target that reduces equity exposure when realized volatility spikes, or factor exposures that change with macro conditions. Target-date funds are the most common form of dynamic allocation. The defining feature is that the allocation changes are systematic and rules-based, not discretionary."},
          {"type": "callout", "kind": "key", "content": "For most clients in most situations, a disciplined strategic allocation with periodic rebalancing outperforms attempts to be tactical. Humility about market timing is a feature of good planning, not a weakness."},
          {"type": "subheading", "content": "Glide paths"},
          {"type": "paragraph", "content": "A glide path is a pre-specified schedule of how the allocation changes over time, usually as retirement approaches. A common pattern: 90/10 in the 30s, gliding down to 60/40 at age 60, then 40/60 at age 70, with continued small reductions into the late 70s. Glide paths can be embedded in target-date funds or implemented manually across the portfolio. The advantage is automatic risk reduction as the time horizon shortens; the cost is loss of customization to the individual client's situation."},
          {"type": "subheading", "content": "Equity glide paths in retirement — the contrarian view"},
          {"type": "paragraph", "content": "Wade Pfau and Michael Kitces have published research arguing that, for some retirees, an equity allocation that rises through retirement — starting lower at the retirement date when sequence-of-returns risk is highest, then rising as the portfolio survives the early withdrawal years — outperforms a conventional declining glide path. The intuition is that the most fragile moment of a retirement portfolio is the first decade; once that is past, longer horizons can absorb more risk. This is not the standard approach, but it is part of the modern conversation about glide path design."},
          {"type": "case_study", "title": "Choosing the philosophy for Marcus and Tasha", "scenario": "Marcus and Tasha are 35 and 33, with a 30-year retirement horizon and a 15-year college funding horizon for their two children. The apprentice recommends a strategic asset allocation: 80/20 for retirement assets, 60/40 for the 529s (which will be drawn down starting in 8 years). No tactical deviations. A glide path is set for the retirement allocation: 80/20 holds until age 50, then begins gliding 1 percentage point per year toward 60/40 by age 70. The 529 glide path is sharper because the time horizon is shorter — 60/40 today, becoming 40/60 five years before the first child's enrollment, then 20/80 in the year before enrollment.", "discussion": "The apprentice did not attempt to forecast equity returns or time the next recession. They built a strategic structure with rules for how it evolves. Marcus and Tasha know what to expect for the next 35 years, and the structure does not depend on the apprentice (or any successor) being a good market timer."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Rebalancing Methodology — Calendar, Threshold, Hybrid",
        "summary": "Once an allocation is set, the work shifts to maintaining it. The three main methodologies have measurable differences in trading frequency, tax cost, and effectiveness.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Markets move every day. Asset class returns differ. A portfolio that starts the year at 60/40 will not end the year at 60/40 — it will be 65/35 if equities outperformed, 54/46 if bonds did. Rebalancing is the practice of bringing the portfolio back toward its target. The methodology — when and by how much — has been studied extensively."},
          {"type": "subheading", "content": "Calendar-based rebalancing"},
          {"type": "paragraph", "content": "Rebalance to target on a fixed schedule — quarterly, semi-annually, or annually. Annual is the most common in retail planning because it generates fewer taxable events in taxable accounts and aligns with the natural rhythm of annual reviews. Quarterly rebalancing can produce slightly better risk control but introduces more trading and more potential tax cost. Calendar-only methodology will sometimes trade unnecessarily (rebalancing a portfolio that is barely off target) and sometimes fail to act (waiting for the next scheduled date even after significant drift)."},
          {"type": "subheading", "content": "Threshold-based rebalancing"},
          {"type": "paragraph", "content": "Rebalance when any asset class moves outside a specified band around its target — typically ±5 percentage points for major asset classes and ±3 for sub-classes. Threshold-based rebalancing responds to actual drift and tends to trade only when drift is meaningful. The downside is operational — somebody has to be watching for breaches. In practice, threshold methodology requires either software monitoring or a disciplined periodic check."},
          {"type": "subheading", "content": "Hybrid rebalancing"},
          {"type": "paragraph", "content": "Check on a regular schedule (typically quarterly or annually) and rebalance only if outside the threshold band. This is the methodology most institutional and many sophisticated retail practitioners use because it captures the discipline of regular review without forcing trades when none are needed. A 2015 Vanguard research paper concluded that annual checks with 5% bands produced similar risk control as more frequent rebalancing at meaningfully lower cost."},
          {"type": "callout", "kind": "key", "content": "Default starting policy for most retail clients: annual review with 5% threshold for major asset classes and 3% for sub-classes. Adjust based on tax sensitivity and operational capability."},
          {"type": "subheading", "content": "What rebalancing actually does"},
          {"type": "paragraph", "content": "Two effects, in order of importance. First — and primarily — rebalancing maintains the risk profile the client signed up for. A 60/40 portfolio that has drifted to 70/30 is now a different portfolio with different risk than was agreed. Without rebalancing, drift accumulates: a 60/40 portfolio left untouched through the 2010s would have ended the decade closer to 80/20 simply from equity outperformance. The client would now be in a portfolio they did not choose. Risk maintenance is the non-negotiable function."},
          {"type": "paragraph", "content": "Second — and a smaller effect — rebalancing produces a modest 'rebalancing bonus' from systematically selling what is up and buying what is down. The magnitude is small, often 10-30 basis points per year, and depends on volatility and correlation between asset classes. It can also be zero or negative over some periods. Do not oversell the rebalancing bonus to clients. Sell the risk-management function, which is the real reason."},
          {"type": "subheading", "content": "How to rebalance — sell or use new contributions"},
          {"type": "paragraph", "content": "There are two ways to rebalance. The first is to sell from overweighted asset classes and buy underweighted ones — a 'transactional' rebalance. The second is to redirect new contributions or distributions toward underweighted classes, drifting the allocation back to target over time without selling anything. The second method is preferable in taxable accounts because it avoids realizing gains. In tax-advantaged accounts, either is fine. A portfolio with regular cash flows can stay reasonably close to target through contribution-direction alone if the cash flows are large enough relative to drift."},
          {"type": "case_study", "title": "Naomi's first rebalancing event", "scenario": "Eight months after construction, Naomi's portfolio shows drift: U.S. equity at 56% vs 50% target (within 5% band), international developed at 14% vs 18% target (outside the 3% sub-class threshold), emerging at 5% vs 7% (outside the 3% threshold), fixed income proportions also within bands. The apprentice triggers a sub-class rebalance: sell ~3% of U.S. equity in Naomi's Roth IRA (no tax cost), buy international developed and emerging to restore targets. Total trade: $11,000. No tax cost. Risk profile back at target.", "discussion": "Notice — the apprentice executed in the Roth to avoid tax. They did not over-trade the taxable account. The risk profile is restored. The IPS specified the bands; the bands triggered the action; the action was tax-aware. Process produced the outcome."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Tax-Aware Rebalancing",
        "summary": "Rebalancing in tax-deferred accounts has no tax cost. Rebalancing in taxable accounts can be expensive. The skill is in achieving the rebalance with minimal tax friction.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "A rebalancing trade in a taxable account that sells appreciated holdings triggers capital gains tax. The tax cost can erode much or all of the rebalancing bonus and, for clients in high brackets, can make naive rebalancing actively harmful. Tax-aware rebalancing methodology addresses this without sacrificing the risk-management function."},
          {"type": "subheading", "content": "Order of operations for tax efficiency"},
          {"type": "numbered", "items": [
            "First, rebalance in tax-advantaged accounts (IRA, 401(k), Roth) where trades have no tax cost",
            "Second, direct new contributions toward underweight asset classes to drift the allocation back without selling",
            "Third, direct dividends and distributions from overweight classes to underweight classes (turn off automatic reinvestment when needed)",
            "Fourth, if income from the portfolio is being taken anyway, take it preferentially from overweight asset classes",
            "Fifth, only when the above are insufficient, sell in taxable accounts — and even then, preferentially harvest losses or sell lots with the highest cost basis"
          ]},
          {"type": "subheading", "content": "The 'rebalance in the IRA' technique"},
          {"type": "paragraph", "content": "If the household has $200K in a taxable brokerage and $200K in an IRA, and the portfolio is overweight equity, the apprentice does not need to sell equity in the taxable account. Instead, sell equity and buy bonds inside the IRA — same effect on overall allocation, zero tax cost. This requires viewing the household portfolio as a single allocation across accounts (per Module 19) rather than rebalancing each account independently."},
          {"type": "subheading", "content": "Tax lot selection"},
          {"type": "paragraph", "content": "When selling securities in a taxable account, the cost basis method determines which specific tax lots are sold. Common methods: FIFO (first-in, first-out, oldest lots first), LIFO (last-in, first-out), and Specific Identification (you choose which lots). For tax-aware rebalancing, Specific Identification is generally the best method — it allows selling lots with higher cost basis (less gain) or with losses (offsetting other gains). Most custodians default to FIFO; switch to Specific ID for taxable accounts where rebalancing happens."},
          {"type": "callout", "kind": "do", "content": "On any taxable account where active management will occur, set the default cost basis method to Specific Identification, not FIFO. This single setting can save thousands in taxes over a portfolio's life."},
          {"type": "subheading", "content": "Wash-sale awareness"},
          {"type": "paragraph", "content": "If you sell a security at a loss in a taxable account and buy a 'substantially identical' security within 30 days before or after the sale (in any account, including IRAs and a spouse's accounts), the loss is disallowed under the wash-sale rule. Wash-sale rules apply to rebalancing trades too. If you sell VTI at a loss to harvest, you cannot buy VTI back within 30 days. You can buy a similar-but-not-substantially-identical fund (say, ITOT instead of VTI), or wait 31 days. Track this carefully. Wash-sale violations are easy to inadvertently trigger across linked accounts."},
          {"type": "subheading", "content": "Long-term vs short-term capital gains"},
          {"type": "paragraph", "content": "If selling is required in a taxable account, prefer long-term gains over short-term gains where possible. Long-term gains (assets held more than one year) are taxed at preferential rates (0/15/20% federal); short-term gains are taxed at ordinary rates. A tax lot that is 11 months and 3 weeks old can become long-term if you wait three more weeks; if the timing allows and the drift is not extreme, the wait is worth thousands of dollars in many situations."},
          {"type": "subheading", "content": "Worked example — Devon's rebalance scenario"},
          {"type": "paragraph", "content": "Devon's household portfolio is overweight equity by 8 percentage points after a strong equity year. His taxable brokerage holds appreciated equity ETF positions with substantial gains. His SEP-IRA holds bonds. Rather than sell equity in the taxable account (triggering long-term gains), the apprentice sells bonds in the SEP-IRA and buys equity inside the SEP-IRA. Wait — that increases equity, not decreases. Correct move: sell equity inside the SEP-IRA (no tax cost) and buy bonds inside the SEP-IRA. Net effect on the household portfolio: equity down, bonds up, no taxable event. The taxable account stays untouched; rebalancing happens in the tax-advantaged sleeve."},
          {"type": "callout", "kind": "key", "content": "When rebalancing across a household with multiple account types, the question is not 'what trades happen in each account' but 'what trades happen at all, and where do they have the lowest tax cost.' Always think at the household level."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Adjusting Allocation Across the Life Cycle",
        "summary": "Allocations should evolve as clients age and their goals shift. The hard part is making the changes for the right reasons and at the right pace.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An asset allocation that is right for a 32-year-old accumulator is not right for the same person at 65, and is definitely not right at 80. But the changes should happen for the right reasons (time horizon shortening, capacity changing, goals evolving) and at the right pace (gradual, in advance of need, not in reaction to recent markets). This lesson covers how to think about life cycle allocation changes."},
          {"type": "subheading", "content": "When to make allocation changes"},
          {"type": "list", "items": [
            "Major life events that change the underlying facts — marriage, divorce, birth of child, death of spouse, significant inheritance, business sale, retirement",
            "Time horizon meaningfully shortening — within 5-7 years of a known cash need (retirement, college, home purchase)",
            "Risk capacity changing — job loss reducing income stability, health condition altering longevity expectations, large change in fixed expenses",
            "Risk tolerance demonstrably and persistently changing — a single panic episode does not constitute a tolerance change; a pattern of distress over multiple market events does",
            "Goals fundamentally shifting — early retirement decision, decision to extend working years, large new philanthropic objective"
          ]},
          {"type": "subheading", "content": "When NOT to make allocation changes"},
          {"type": "list", "items": [
            "After a strong year in any asset class ('We should add more emerging markets, they were up 22% last year')",
            "After a weak year in any asset class ('Let's reduce equity, the market is down 18%')",
            "Because a friend, neighbor, or media commentator suggested a change",
            "Because of an upcoming election or geopolitical event (almost always a fool's errand)",
            "Because the client is briefly anxious without a fundamental change in their situation"
          ]},
          {"type": "subheading", "content": "Pre-retirement glide path"},
          {"type": "paragraph", "content": "The 5-10 years before retirement are the most consequential glide path period. Sequence-of-returns risk peaks at and just after retirement — a large drawdown in the early years of withdrawal can permanently impair the plan. A typical pre-retirement glide path: starting from say 70/30 at age 55, reduce equity by 1 percentage point per year through age 65, ending at 60/40 (or lower depending on the specific plan). The pre-retirement glide creates a 'bond tent' — a build-up of fixed income exposure heading into retirement, which is partially drawn down during the early withdrawal years."},
          {"type": "subheading", "content": "In-retirement allocation"},
          {"type": "paragraph", "content": "Once retirement is underway, allocation evolves more slowly. A 65-year-old retiree at 60/40 may stay at 60/40 through their early 70s, then drift down to 50/50 or 45/55 by their late 70s. Maintaining sufficient equity exposure is important — a 30-year retirement requires real growth to outpace inflation. Going too conservative too quickly is a real failure mode for retirees."},
          {"type": "callout", "kind": "warn", "content": "The most common allocation mistake in retirement is overshooting toward conservatism. A 65-year-old at 30/70 may feel safer but is taking enormous inflation risk over a 25-30 year horizon. Equity is not optional in retirement — its share is."},
          {"type": "subheading", "content": "Late-life allocation and capacity questions"},
          {"type": "paragraph", "content": "In the final stage of a long retirement, allocation may need to shift in response to capacity concerns. If a client in their late 80s is showing cognitive decline, complex investments become harder to manage. Simplification is a value of its own at this stage. A portfolio of three broad ETFs is easier for an aging client (or a surrogate decision-maker, or an executor) to oversee than a portfolio of 30 holdings. Sometimes the right allocation change is a simplification, not a directional shift in risk."},
          {"type": "case_study", "title": "Marcus and Tasha — the year of the bond tent decision", "scenario": "Marcus is now 48. He has discussed wanting to retire at 60. The apprentice walks through the pre-retirement glide path: starting at 75/25, glide down 1 percentage point per year over the next decade, ending at 65/35 at retirement. The apprentice documents the rationale in the IPS update. Tasha at 46 has similar timing but slightly different risk tolerance — she wants a steeper glide. Negotiated landing: both move to 75/25 today as the household, glide to 65/35 over the next twelve years, with a year-by-year schedule written into the IPS.", "discussion": "The schedule is durable. It does not depend on the apprentice being a market timer. The clients know exactly what to expect each year. When markets move, the schedule does not change — only the underlying facts can change it."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Documenting Allocation Changes and Rebalancing Activity",
        "summary": "Every allocation change, every rebalancing event, every IPS update should leave a paper trail. The documentation is the institutional memory that protects the plan and the relationship.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "An allocation decision that is not documented is a decision that cannot be defended later. Years from now, a client asking 'why did we shift to 65/35 when I was 55?' or a regulator asking 'what was the rationale for the rebalancing trade on March 14?' deserves an answer that can be reconstructed from the file. The documentation discipline from Module 20 (investment decisions) extends to allocation changes and rebalancing activity."},
          {"type": "subheading", "content": "The allocation change memo"},
          {"type": "paragraph", "content": "Any change to the target allocation should be accompanied by a short memo capturing: what changed, why it changed (the specific fact in the client's situation that drove the change), what was considered, the resulting new target allocation, and the date and signatures. Update the IPS to reflect the change. Send the client a summary letter or email confirming the change and the reasoning."},
          {"type": "subheading", "content": "Rebalancing trade documentation"},
          {"type": "paragraph", "content": "Each rebalancing event should generate a record: the pre-trade allocation, the trades executed, the post-trade allocation, the rationale (which band was breached, what was the methodology), and any tax considerations. Most CRM and portfolio management systems automate much of this. The apprentice's job is to make sure the automation is on and the records are accurate."},
          {"type": "subheading", "content": "Annual rebalancing review"},
          {"type": "paragraph", "content": "Once a year — typically at the annual review with the client — the apprentice should pull a record of all rebalancing activity for the year, review whether the methodology worked as intended, and consider whether the bands or the methodology need adjustment. Did the threshold bands trigger too often? Too rarely? Were taxes managed effectively? Were there missed rebalancing opportunities? This review is part of the firm's continuous improvement, distinct from the client review but informing it."},
          {"type": "subheading", "content": "Behavioral discipline around documentation"},
          {"type": "paragraph", "content": "The temptation when markets are turbulent is to skip the documentation — 'just get the trades done.' Resist. The trades themselves take five minutes. The five additional minutes to document why creates the audit trail that protects the relationship. Time pressure is precisely when documentation matters most because it is the only record that the decision was deliberate and reasoned rather than reactive."},
          {"type": "callout", "kind": "do", "content": "Make the documentation step part of the trade workflow, not an afterthought. If the documentation has not been completed, the trade is not considered finished — same discipline as verifying completion in Module 17."},
          {"type": "subheading", "content": "Communication with the client"},
          {"type": "paragraph", "content": "Some firms communicate every rebalancing trade to clients in writing; others communicate only at annual reviews. The choice depends on client preference and firm policy. At minimum, any change to the target allocation or any significant rebalancing event (substantial dollar amount, significant tax impact, or out-of-cycle timing) should be communicated to the client promptly. Clients who learn about consequential changes in their portfolio months after the fact lose trust quickly. Clients who hear from their advisor as things happen build it."},
          {"type": "case_study", "title": "The year-end rebalancing letter", "scenario": "Each December, the apprentice writes a short year-end letter to each client recapping the year's rebalancing activity. For Naomi: '2025 year-end summary — your portfolio was rebalanced in March (sub-class drift in international developed and emerging markets, restored within bands) and in October (full annual rebalance back to target). Total taxable gains realized this year: $0 (all rebalancing executed in tax-advantaged accounts). Your target allocation of 75/25 remains unchanged. The next scheduled annual review is February 12.' Two paragraphs. Standard format across all clients. Time per client: 10 minutes.", "discussion": "Naomi knows what happened. The record exists in her file and in her email. The firm's institutional memory matches her own. Trust compounds, year over year, from small disciplines like this."},
          {"type": "callout", "kind": "key", "content": "Documentation is part of the work, not a chore added to it. The same minute spent capturing the why now saves an hour reconstructing it later."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Performance Reporting. How to measure and communicate what the portfolio actually did, honestly and clearly."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Strategic asset allocation is best described as:", "options": ["Active trading based on market views", "Setting a long-term target based on the client's situation and maintaining it with discipline through cycles", "Algorithmic trading based on momentum", "Switching to cash during downturns"], "correct": 1, "explanation": "Strategic allocation is the dominant retail approach — set the target from the client's situation, maintain it, change only when the underlying facts change."},
        {"id": "q2", "prompt": "Brinson, Hood, and Beebower's research is most often cited for showing that:", "options": ["Stock picking is the primary driver of returns", "Asset allocation explains the majority of variation in long-term portfolio returns", "Market timing reliably adds value", "Active management beats passive over time"], "correct": 1, "explanation": "BHB and subsequent studies put asset allocation at the center of return variation. The exact percentage is debated, but the practical implication — allocation matters more than security selection — is well established."},
        {"id": "q3", "prompt": "Hybrid rebalancing methodology is best described as:", "options": ["Rebalancing every month regardless of drift", "Checking on a regular schedule and rebalancing only if outside the threshold band", "Never rebalancing", "Rebalancing only after market crashes"], "correct": 1, "explanation": "Hybrid combines the discipline of scheduled review with the efficiency of acting only when drift is meaningful. Common default: annual check with 5% bands."},
        {"id": "q4", "prompt": "The primary function of rebalancing is to:", "options": ["Generate a rebalancing bonus", "Maintain the risk profile the client agreed to", "Time market tops and bottoms", "Maximize tax losses"], "correct": 1, "explanation": "Risk maintenance is the non-negotiable function. The rebalancing bonus exists but is secondary; do not oversell it to clients."},
        {"id": "q5", "prompt": "The first place to rebalance, all else equal, is:", "options": ["The taxable brokerage account", "Tax-advantaged accounts (IRA, 401(k), Roth) where trades have no tax cost", "By cash withdrawal", "Through margin trading"], "correct": 1, "explanation": "Tax-advantaged accounts allow rebalancing trades with zero tax cost. Always exhaust this option before selling in taxable accounts."},
        {"id": "q6", "prompt": "The wash-sale rule disallows a loss on a security if:", "options": ["The security is sold and bought back the same day", "A 'substantially identical' security is bought within 30 days before or after the sale, in any linked account", "The security is held more than one year", "The security pays a dividend"], "correct": 1, "explanation": "The 30-day window applies in both directions and across linked accounts (including IRAs and a spouse's accounts). Tracking this is essential during loss harvesting."},
        {"id": "q7", "prompt": "On a taxable account where active management will occur, the default cost basis method should be set to:", "options": ["FIFO", "LIFO", "Specific Identification, to allow choosing which tax lots to sell", "Average cost"], "correct": 2, "explanation": "Specific Identification lets you sell lots with the highest cost basis (smaller gains) or with losses to offset gains. The most tax-efficient method for active accounts."},
        {"id": "q8", "prompt": "A pre-retirement glide path — gradually reducing equity exposure in the years leading up to retirement — primarily addresses:", "options": ["Inflation risk", "Sequence-of-returns risk, which peaks at and just after retirement", "Interest rate risk", "Currency risk"], "correct": 1, "explanation": "A large drawdown in the early withdrawal years can permanently impair a retirement plan. The glide path reduces this risk by lowering equity exposure heading into and through the first years of withdrawal."},
        {"id": "q9", "prompt": "The most common allocation mistake in retirement is:", "options": ["Holding too much equity", "Overshooting toward conservatism, taking inflation risk over a 25-30 year horizon", "Rebalancing too often", "Holding international stocks"], "correct": 1, "explanation": "Going too conservative too quickly creates massive inflation risk across a long retirement. Equity is not optional in retirement — its share is."},
        {"id": "q10", "prompt": "An allocation change should generally NOT be made because:", "options": ["The client retired", "An asset class had a strong recent year and the client wants more", "The client received a large inheritance", "Time horizon meaningfully shortened"], "correct": 1, "explanation": "Performance-chasing is a destructive allocation behavior. Change allocation for changes in underlying facts (life events, time horizon, capacity, goals) — not for short-term performance."},
        {"id": "q11", "prompt": "If you sell VTI at a loss in a taxable account to harvest, you can:", "options": ["Buy VTI back the next day in your IRA", "Buy a similar-but-not-substantially-identical fund (like ITOT) immediately, or wait 31 days to buy VTI again", "Buy any fund you want immediately with no restriction", "Cannot harvest at all"], "correct": 1, "explanation": "Wash-sale rule applies across accounts including IRAs. Substitute with a non-substantially-identical fund or wait 31 days."},
        {"id": "q12", "prompt": "Documentation of a rebalancing event should include:", "options": ["Only the trade tickets", "Pre-trade allocation, trades executed, post-trade allocation, methodology rationale, and tax considerations", "Just the date", "Only what the client requested"], "correct": 1, "explanation": "Complete documentation lets a reviewer reconstruct the decision and confirm it followed the IPS. Treat documentation as part of the trade workflow."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 22;

-- ── module22_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 22 CONTENT
-- Performance Reporting
-- ============================================================================
update public.modules set
  title = 'Performance Reporting',
  competency_id = 'OJL-13',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Measure and communicate what the portfolio actually did — with the right return calculations, the right benchmarks, the right time periods, and reporting that clients can actually use.',
  learning_objectives = ARRAY[
    'Calculate and interpret time-weighted and money-weighted returns correctly',
    'Choose and explain benchmarks that fit the portfolio''s purpose',
    'Build performance reports that put returns in proper context',
    'Communicate performance honestly during both strong and weak periods',
    'Understand the GIPS framework and its principles even when not formally compliant'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Two Returns That Are Not the Same",
        "summary": "Time-weighted return and money-weighted return measure different things. Confusing them — or quoting one when you should be quoting the other — is a common but consequential error.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When a client asks 'how did my portfolio do this year,' there are two different correct answers depending on what they actually want to know. Time-weighted return tells you how the investment strategy performed, neutralizing the effect of when the client added or withdrew money. Money-weighted return tells you what the client's actual experience was, including the effects of their contribution and withdrawal timing. Both numbers matter. Knowing which to use when is part of the work."},
          {"type": "subheading", "content": "Time-weighted return (TWR)"},
          {"type": "paragraph", "content": "Time-weighted return measures the compound rate of growth of the portfolio over a period, independent of the timing of cash flows in or out. It is calculated by breaking the period into sub-periods (each ending with a cash flow), calculating the return for each sub-period, and chain-linking them. TWR is the industry standard for evaluating the performance of an investment strategy or manager, because it strips out the effects of when the client happened to add or withdraw money — effects the manager did not control."},
          {"type": "subheading", "content": "Money-weighted return (MWR) / Internal Rate of Return (IRR)"},
          {"type": "paragraph", "content": "Money-weighted return is the constant rate that would make the present value of all cash flows (contributions, withdrawals, and the ending balance) equal to the starting balance. It is the IRR of the cash flow stream. MWR reflects the client's actual dollar experience — if they made a large contribution right before a strong period, MWR will be higher than TWR; if they contributed right before a drop, MWR will be lower. MWR is the right number for answering 'what did my money actually earn for me' from the client's perspective."},
          {"type": "subheading", "content": "When TWR and MWR diverge"},
          {"type": "paragraph", "content": "If a client started the year with $200K, contributed $300K in February, then experienced an 18% portfolio drawdown in March followed by recovery to flat by year-end, the time-weighted return for the year might be 0% (the strategy ended where it began). But the money-weighted return would be significantly negative — most of the client's dollars were exposed to the drawdown after the February contribution. Both numbers are correct. They answer different questions."},
          {"type": "glossary", "terms": [
            {"term": "Time-weighted return (TWR)", "definition": "Compound growth rate of the portfolio independent of cash flow timing. Industry standard for strategy/manager performance."},
            {"term": "Money-weighted return (MWR)", "definition": "Internal rate of return of the actual cash flow stream. Reflects the client's dollar-experienced return."},
            {"term": "Modified Dietz", "definition": "Approximation of TWR that weights cash flows by the time they were in the portfolio. Less precise than true TWR but easier to calculate; widely used in practice."},
            {"term": "Daily-weighted return", "definition": "TWR calculated with daily portfolio valuations, the most accurate retail approach. Standard in modern reporting platforms."}
          ]},
          {"type": "callout", "kind": "key", "content": "Report TWR alongside benchmarks (it is the apples-to-apples comparison). Show MWR to the client when discussing what their actual experience was. Confusing the two is one of the most common reporting errors."},
          {"type": "subheading", "content": "Annualizing returns"},
          {"type": "paragraph", "content": "Returns over multi-year periods are usually presented as annualized. Annualizing a multi-year return means converting it into the equivalent constant annual rate that would compound to the same total. The formula: (1 + total return)^(1/years) - 1. A 33.1% three-year cumulative return annualizes to (1.331)^(1/3) - 1 = 10.0% per year. Annualizing only makes sense for periods of one year or longer; do not annualize a 3-month return — it suggests a precision that does not exist."},
          {"type": "case_study", "title": "Naomi's first-year performance number", "scenario": "Naomi's account is up 9.4% time-weighted for the year. But she contributed $24,000 over the year, including a large $18,000 contribution after a 4% drop in early October. The market then recovered strongly through year-end. Her money-weighted return for the year is 12.7% — the October contribution was unusually well-timed by accident. The apprentice reports both numbers in her year-end statement: 'Portfolio strategy performance (time-weighted): 9.4%. Your actual dollar-weighted experience: 12.7%. The dollar-weighted figure was higher this year because your October contribution caught a strong recovery; this can work in the other direction in other years.' Both numbers, with context.", "discussion": "The apprentice did not pick the flattering number. They explained both and the reason for the difference. Naomi knows what each means. She knows the 12.7% was partly luck. Honest reporting builds the trust that lets the relationship survive a year where MWR is below TWR."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Choosing the Right Benchmark",
        "summary": "A return without a benchmark is just a number. A benchmark turns it into information — but only if the benchmark is the right one.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Performance reporting without benchmarks is performance reporting without context. A 7% return looks good against a 3% benchmark and disappointing against a 12% benchmark. The benchmark choice can be the single most consequential decision in a performance report — and it deserves the same care as the portfolio construction. Get this wrong and you mislead the client either toward false comfort or false alarm."},
          {"type": "subheading", "content": "Single-asset benchmarks"},
          {"type": "paragraph", "content": "Individual asset class sleeves are benchmarked against the index that represents the asset class: U.S. broad equity against the Russell 3000 or CRSP US Total Market; large-cap U.S. against the S&P 500; international developed against MSCI EAFE or FTSE Developed; emerging against MSCI Emerging Markets; U.S. investment-grade bonds against the Bloomberg U.S. Aggregate. The benchmark should match the asset class universe, not the popular index. The S&P 500 is famous but misleading as a benchmark for a U.S. total market fund — the total market index includes mid- and small-caps the S&P 500 omits."},
          {"type": "subheading", "content": "Blended benchmarks"},
          {"type": "paragraph", "content": "A portfolio is rarely a single asset class — so a single-index benchmark is not appropriate for the portfolio as a whole. The right benchmark is a blended one that mirrors the target allocation. For a 75/25 portfolio: 75% in a global equity index (e.g., MSCI ACWI) and 25% in a U.S. aggregate bond index, rebalanced on the same schedule the portfolio uses. The blended benchmark answers 'how did a passive portfolio with the same allocation do?' — which is the relevant comparison."},
          {"type": "callout", "kind": "key", "content": "Compare your client's portfolio to a blended benchmark that mirrors the target allocation, not to the S&P 500. The S&P 500 comparison is misleading because the portfolio is not 100% S&P 500."},
          {"type": "subheading", "content": "Peer group comparisons"},
          {"type": "paragraph", "content": "Beyond the index benchmark, comparing the portfolio to peer groups doing similar things adds context. For example, the Morningstar Allocation 70-85% Equity category contains hundreds of allocation funds with broadly similar risk profiles. The portfolio's return relative to this peer group answers 'how did our 75/25 do compared to other 75/25-ish portfolios.' Peer comparisons should be used with care — peer groups include funds with different fees, strategies, and tax treatments — but they add useful triangulation."},
          {"type": "subheading", "content": "Benchmark mismatches that mislead"},
          {"type": "list", "items": [
            "Comparing a 60/40 portfolio to the S&P 500 (or vice versa) — different risk profiles, the comparison is not informative",
            "Comparing an actively managed fund to a benchmark that excludes the fund's actual style — a small-cap value fund compared to the S&P 500 will tell you nothing about the manager's skill",
            "Using a peer group that does not match the portfolio's strategy — Morningstar Conservative Allocation peer group does not fit a Moderately Aggressive portfolio",
            "Choosing a benchmark that flatters the portfolio over the chosen time period — survivorship bias in benchmark selection is a real form of bias"
          ]},
          {"type": "subheading", "content": "Benchmark for the client's plan vs benchmark for the strategy"},
          {"type": "paragraph", "content": "There are actually two benchmarks worth considering. The first is the portfolio's strategy benchmark — the blended index that matches the allocation. The second is the client's plan benchmark — the return the financial plan assumed in projections. If the plan projected 5% real returns and the portfolio is delivering 7% real, the plan is ahead of trajectory regardless of how the portfolio did versus the index. Both numbers matter for different purposes: strategy benchmark answers 'are we beating a passive version of our allocation,' plan benchmark answers 'is the plan on track.'"},
          {"type": "case_study", "title": "Devon's mixed report card", "scenario": "Devon's portfolio returned 8.2% for the year. The apprentice prepares three comparisons: (1) Versus the blended benchmark (60% MSCI ACWI / 40% Bloomberg U.S. Aggregate), the benchmark returned 8.9% — the portfolio modestly underperformed by 70 bps. (2) Versus the Morningstar Moderate Allocation peer group median return of 7.8% — the portfolio outperformed by 40 bps. (3) Versus the plan's assumed long-term real return of 4.5%, the portfolio's 8.2% nominal in a year of ~2.5% inflation means about 5.7% real — ahead of plan trajectory. The apprentice reports all three with context: passive index slightly ahead this year, peer group slightly behind, plan on track. Devon now has a multidimensional picture.", "discussion": "Reporting only the benchmark comparison would have been a partial truth. Reporting only the peer group would have been a different partial truth. Reporting only versus the plan would have been a third. All three together is the honest picture."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Building the Performance Report",
        "summary": "A performance report is a document the client will use. Design it for clarity, completeness, and the conversation it should prompt at the annual review.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A good performance report tells the client what their portfolio did, what comparable benchmarks did, what context surrounds those numbers, and what the apprentice's interpretation is. A bad performance report just lists numbers. The difference is design and intentionality — the report should be the artifact the client refers to throughout the year to understand what is happening with their money."},
          {"type": "subheading", "content": "What a complete performance report contains"},
          {"type": "numbered", "items": [
            "Account summary — beginning balance, ending balance, contributions, withdrawals, market growth, fees",
            "Returns — period returns (quarter, year-to-date, trailing 1/3/5/10 years, since inception), both time-weighted and money-weighted",
            "Benchmark comparison — blended benchmark return for each period",
            "Asset allocation snapshot — current allocation versus target, with permitted ranges shown",
            "Account-level breakdown — performance by account for clients with multiple accounts",
            "Income — dividends, interest, distributions received over the period",
            "Fees paid — both advisory fees and underlying fund expenses where reportable",
            "Commentary — apprentice's plain-language interpretation, including context for any unusual results"
          ]},
          {"type": "subheading", "content": "Trailing periods to report"},
          {"type": "paragraph", "content": "Standard trailing periods: current quarter, year-to-date, trailing 1-year, 3-year annualized, 5-year annualized, 10-year annualized, and since-inception annualized. Always show the corresponding benchmark return for each period. Trailing 1-year is the period clients fixate on most — and it is often the least diagnostic. Make sure longer periods are equally visible. If the portfolio has been managed less than 3 years, do not annualize — show cumulative since inception."},
          {"type": "subheading", "content": "Format and visual design"},
          {"type": "list", "items": [
            "Numbers in tables, never paragraphs",
            "Show portfolio and benchmark side by side in the same row, with the difference column",
            "Use colors sparingly — red for negative, black or dark blue for positive; consistent",
            "Group accounts in a household summary first, then individual accounts",
            "Headers and footers consistent across reports for institutional feel",
            "Date range and report-as-of date prominent on every page"
          ]},
          {"type": "subheading", "content": "The commentary section"},
          {"type": "paragraph", "content": "Numbers alone do not communicate. A short commentary — typically a single page or less — interprets the numbers for the client. What worked this period and why? What did not and why? What is your view of the portfolio's positioning going into the next period? Is there anything to do? This is where the apprentice's voice and judgment show. The commentary should be candid: if the portfolio underperformed, say so and explain why. Honesty in weak periods builds the credibility to be believed in strong ones."},
          {"type": "callout", "kind": "do", "content": "Read your commentary draft as if you were the client. If a sentence is defensive or evasive, rewrite it. Clients can tell the difference between candid explanation and corporate-speak. Candor wins."},
          {"type": "subheading", "content": "Reporting cadence"},
          {"type": "paragraph", "content": "Standard reporting cadence is quarterly with a more substantial annual report at year-end. Some clients prefer monthly statements (often supplied by the custodian) plus a quarterly advisor commentary. Some larger or more complex clients receive monthly or even weekly performance updates. Set the cadence in the engagement and stick to it. Predictability matters."},
          {"type": "case_study", "title": "Naomi's year-end report", "scenario": "The apprentice produces Naomi's first annual performance report — a 6-page document. Page 1: account summary and one-year return numbers (TWR 9.4%, MWR 12.7%, blended benchmark 9.6%, plan benchmark 5.0% real / 7.5% nominal — all on the page). Page 2: allocation snapshot showing current 76/24 vs target 75/25, all within bands. Page 3: account-level breakdown across her Roth IRA, taxable brokerage, and 401(k). Page 4: income and fee summary. Pages 5-6: commentary — 'Strategy slightly trailed the broader index this year by 20 bps, primarily due to international developed lagging U.S. equities; this is consistent with global allocation behavior over short periods. Your dollar-weighted return was substantially higher than time-weighted because your large October contribution caught a year-end rally. Allocation remains within target ranges. No changes recommended.' Footer on every page: date, page number, contact info, regulatory disclosure.", "discussion": "Naomi now has a document she can read alone. The numbers are honest. The commentary is candid. If she calls with a question, the report supports the conversation rather than requiring it. Year over year, the format stays the same — predictability accrues to trust."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Communicating Performance — Strong, Weak, and Mediocre Years",
        "summary": "How you talk about performance in different conditions is part of the relationship work. Strong years require humility; weak years require honesty; mediocre years require the courage to be boring.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Performance reporting is partly a communication discipline. The numbers are what they are; how you frame them shapes how the client experiences the relationship. Three different communication challenges arise across the cycle — strong periods, weak periods, and the long stretches in between when nothing dramatic happens but the work continues."},
          {"type": "subheading", "content": "Strong years — the humility problem"},
          {"type": "paragraph", "content": "After a strong year, the temptation is to claim credit. Resist. Most of the return came from the asset classes the client owns, not from any decision you made. If the portfolio matched its blended benchmark, the return is the benchmark's. If the portfolio beat the benchmark by 50 bps, attribute that carefully — was it manager selection, rebalancing timing, currency exposure? Be specific about what you actually did and avoid implying you predicted the rally. Clients who hear advisors claim credit for market returns lose trust the next time markets disappoint."},
          {"type": "subheading", "content": "Weak years — the honesty problem"},
          {"type": "paragraph", "content": "After a weak year, the temptation is to defend, explain away, or distract from the numbers. Resist. The portfolio did what it did. Explain why honestly — was it the asset class environment (most stocks were down), was it a specific position, was the allocation appropriate but the timing painful? Acknowledge the client's experience. Connect the result to the plan: 'A year like this is built into the long-term assumptions. The plan does not require positive returns every year. The plan requires us to stay invested through years like this so the long-term compounding can happen.' Reaffirm the IPS and the discipline of the framework."},
          {"type": "callout", "kind": "key", "content": "The relationship is built or broken in weak years. Be present, be honest, be calm, and be clear. Clients remember how their advisor handled the bad years far more than how they performed in the good ones."},
          {"type": "subheading", "content": "Mediocre years — the boredom problem"},
          {"type": "paragraph", "content": "Most years are mediocre — the portfolio gained or lost something modest, nothing dramatic happened. The temptation in mediocre years is to manufacture significance — find some metric that looks impressive, talk about positioning changes that did not actually happen, or pad the report with macro commentary. Resist. A short, calm report saying 'the portfolio did what it was designed to do; nothing material to discuss; we will see you at the annual review' is the right report. Boring is often the goal. Clients who get drama from their advisor every quarter eventually stop trusting any of it."},
          {"type": "subheading", "content": "Specific language techniques"},
          {"type": "list", "items": [
            "Lead with what happened factually, then interpretation — 'The portfolio returned 7.2% this year. Three things drove that...' beats 'In a challenging environment...'",
            "Attribute returns to factors, not to your skill — 'U.S. large-cap equities led' rather than 'we benefited from our positioning'",
            "Acknowledge the client's likely experience before walking through the numbers — 'I know watching the portfolio drop in March was hard'",
            "Always close with what comes next — schedules, action items, or the affirmation that nothing changes",
            "Avoid hedging language ('relatively', 'somewhat', 'in line with') that signals uncertainty about the framing"
          ]},
          {"type": "subheading", "content": "When the client wants to change the plan based on performance"},
          {"type": "paragraph", "content": "Some clients see good performance and want to add risk; others see bad performance and want to reduce it. Both are performance-chasing. The reporting conversation is the appropriate venue to gently push back on either impulse. 'Your portfolio did what it was designed to do this year. The plan does not change because of this year's result. Let us revisit at the annual review if you are seeing something that suggests the plan itself needs to evolve.' The IPS is the framework that makes this conversation possible. Without it, every quarter is a renegotiation."},
          {"type": "case_study", "title": "The painful 2022 conversation", "scenario": "A hypothetical: 2022 — both equities and bonds had bad years simultaneously, a 60/40 portfolio could be down 15-17%. The apprentice's communication to clients: '2022 was one of the most difficult years for diversified portfolios in many decades. Both stocks and bonds declined together, which is unusual. Your portfolio is down approximately 16% — in line with the blended benchmark. No allocation changes were made during the year; the IPS allocation remained appropriate for your situation. The plan's long-term projection includes years like this — it does not require positive returns every year to succeed over a 25-year horizon. The discipline of the plan asks us to remain invested through this period so the eventual recovery contributes to compounding. I am available to discuss further; an in-person review can be scheduled if helpful.' Calm, factual, plan-anchored, with availability for more conversation.", "discussion": "The communication does not minimize. It does not catastrophize. It connects the result to the framework. The clients who get this from their advisor in a bad year are the clients who stay through the next year — and who tell their friends about the advisor who handled the hard year well."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "GIPS and Performance Standards",
        "summary": "The Global Investment Performance Standards govern how performance is calculated and presented at scale. Even for clients you report on individually, the principles are worth knowing.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The Global Investment Performance Standards (GIPS) are a voluntary set of ethical principles for calculating and presenting investment performance, developed by the CFA Institute. Many institutional asset managers and increasingly some RIAs claim GIPS compliance because it signals a commitment to honest, consistent, and verifiable performance reporting. Even firms that do not claim formal GIPS compliance benefit from understanding the principles — they reflect industry consensus on what honest performance reporting looks like."},
          {"type": "subheading", "content": "GIPS core principles"},
          {"type": "list", "items": [
            "Fair representation — performance should be presented in a way that fairly represents what the strategy actually produced",
            "Full disclosure — material information about how returns were calculated, what was included or excluded, and what risks were taken should be disclosed",
            "Composite reporting — performance is reported on composites of all similar accounts, not cherry-picked individual ones",
            "Consistent methodology — calculations follow defined methodologies applied consistently across periods",
            "Verification — third-party verification is encouraged but not required to claim compliance"
          ]},
          {"type": "subheading", "content": "Composites — the heart of GIPS"},
          {"type": "paragraph", "content": "A composite is a group of all discretionary accounts managed in a similar strategy. GIPS requires that firms report the composite's performance — the aggregate of all accounts following that strategy, including ones that did poorly or were closed — rather than the performance of a chosen subset. This prevents the cherry-picking that would otherwise be possible. If a firm has 50 accounts in its 'Moderate Growth Strategy,' the strategy's GIPS performance is the asset-weighted return of all 50 accounts, with disclosed dispersion. Clients evaluating a strategy can see how the strategy actually performed across all clients, not just the best ones."},
          {"type": "subheading", "content": "Why GIPS matters even for non-claiming firms"},
          {"type": "paragraph", "content": "Most retail RIAs do not formally claim GIPS compliance because the operational requirements are substantial. But the principles still apply morally: do not selectively report flattering account results; do not change calculation methodology to look better; disclose what is being measured and what is not; do not pitch one client's results as the strategy's typical experience if the client was unusually fortunate. A retail advisor who internalizes these principles produces more honest performance reporting even without formal compliance."},
          {"type": "subheading", "content": "Common reporting practices that violate GIPS principles"},
          {"type": "list", "items": [
            "Showing a 'representative account' that is the best-performing one, not the typical one",
            "Excluding accounts that performed poorly from the composite",
            "Changing the time period being reported to show a more flattering result",
            "Showing gross-of-fees returns without disclosing that all-in fees are substantially higher than the model suggests",
            "Backtesting a strategy and presenting the backtest as historical performance without clear disclosure"
          ]},
          {"type": "subheading", "content": "Gross vs net of fees"},
          {"type": "paragraph", "content": "Performance can be reported gross of fees (before advisory fees are deducted) or net of fees (after fees). GIPS requires net-of-fees reporting in most contexts because that is what the client actually experienced. Some marketing materials show gross-of-fees figures with smaller-font net-of-fees disclosure — this is technically allowed but misleading in spirit. The honest practice is to lead with net-of-fees and to be transparent about what fees were included."},
          {"type": "case_study", "title": "The composite vs the showcase account", "scenario": "An apprentice is asked to prepare marketing materials describing the firm's 'Moderate Growth Strategy.' The supervising advisor is tempted to show their best client account — a high-net-worth account that has compounded at 11% annually for five years — as the 'representative example.' The apprentice does the GIPS-aligned thing instead: pulls the composite return across all 28 accounts in the strategy, finds the asset-weighted return is 8.7% annualized over five years (the showcase account was an outlier), and presents that with disclosed dispersion. The composite number is not as eye-catching, but it is honest. It is also the number the firm can defend in any future dispute or audit.", "discussion": "Marketing pressure pulls toward the flattering number. Discipline pulls toward the honest one. The apprentice's job is to hold the discipline. Over time, honesty in reporting attracts the clients who are looking for honesty — and those are the clients worth having."},
          {"type": "callout", "kind": "key", "content": "If you are tempted to pick a flattering data point, ask yourself: would I be comfortable defending this presentation in front of a regulator and a disappointed client three years from now? If no, find the more honest presentation."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Trading & Execution. From the decisions made in this module and the prior ones, somebody has to actually place the trades. The mechanics matter."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Time-weighted return is the right metric when:", "options": ["The client wants to know their actual dollar experience", "Evaluating the performance of the investment strategy or manager, independent of cash flow timing", "Calculating tax liability", "Forecasting future returns"], "correct": 1, "explanation": "TWR strips out the effects of when cash flows happened — appropriate for evaluating a strategy or comparing to a benchmark. MWR reflects the client's dollar experience."},
        {"id": "q2", "prompt": "Money-weighted return is best understood as:", "options": ["The compound growth rate of a unit of money", "The internal rate of return of the actual cash flow stream — the client's dollar-experienced return", "A weighted average of strategy returns", "A measure of risk"], "correct": 1, "explanation": "MWR (the IRR of the cash flow stream) tells the client what their money actually earned given the timing of their contributions and withdrawals."},
        {"id": "q3", "prompt": "The right benchmark for a 60/40 portfolio is generally:", "options": ["The S&P 500", "A blended benchmark like 60% global equity index / 40% U.S. aggregate bond index", "Cash", "The Dow Jones Industrial Average"], "correct": 1, "explanation": "Blended benchmarks mirror the portfolio's actual allocation. Single-index benchmarks like the S&P 500 are misleading for any portfolio that is not 100% in that index."},
        {"id": "q4", "prompt": "Annualizing returns is appropriate for:", "options": ["Any period including months and quarters", "Periods of one year or longer", "Only periods of five years or longer", "Only the inception-to-date period"], "correct": 1, "explanation": "Annualizing periods shorter than one year suggests a precision that does not exist. Annualize only for periods of one year or longer."},
        {"id": "q5", "prompt": "When the portfolio underperforms its benchmark, the most appropriate communication is to:", "options": ["Avoid mentioning the comparison", "Explain honestly what happened, connect the result to the plan, and reaffirm the framework", "Switch to a different benchmark that looks better", "Recommend immediate allocation changes"], "correct": 1, "explanation": "Honesty in weak periods builds the credibility to be believed in strong ones. Honest explanation plus plan-anchored framing is the discipline."},
        {"id": "q6", "prompt": "Reporting cadence for most retail clients is typically:", "options": ["Daily", "Quarterly with a more substantial annual report", "Only when the client requests", "Every five years"], "correct": 1, "explanation": "Quarterly reporting with annual deep review is the standard retail cadence. Predictability matters more than precision."},
        {"id": "q7", "prompt": "A composite in GIPS terminology is:", "options": ["A single best-performing account used for marketing", "A group of all discretionary accounts managed in a similar strategy, reported in aggregate", "A blend of multiple benchmarks", "A summary calculation method"], "correct": 1, "explanation": "Composites prevent cherry-picking. Reporting the asset-weighted return of all accounts in a strategy shows what the strategy actually delivered to clients."},
        {"id": "q8", "prompt": "After a strong year for the broader market, an advisor who claims credit for the returns:", "options": ["Strengthens client trust", "Risks losing trust the next time markets disappoint, because the implicit claim of skill was misleading", "Has done their job", "Should ask for higher fees"], "correct": 1, "explanation": "Most market returns come from market exposure, not from advisor decisions. Claiming credit for market returns sets up an impossible standard and erodes trust when markets reverse."},
        {"id": "q9", "prompt": "GIPS generally requires performance to be reported:", "options": ["Gross of fees only", "Net of fees in most contexts, because that is the client's actual experience", "Either, at the firm's discretion", "Annualized over 20 years"], "correct": 1, "explanation": "Net-of-fees reporting reflects what the client actually earned. Gross-of-fees is allowed in some contexts but only with clear disclosure."},
        {"id": "q10", "prompt": "Reporting Naomi's 12.7% money-weighted return without explaining it was higher than the 9.4% time-weighted return because of a well-timed contribution would be:", "options": ["Perfectly appropriate", "Misleading by omission — the higher number reflects luck of contribution timing, not strategy performance", "Required by GIPS", "Forbidden by FINRA"], "correct": 1, "explanation": "Both numbers are true. Reporting only the flattering one without explanation misleads the client about what to expect going forward."},
        {"id": "q11", "prompt": "A mediocre year — small return, nothing dramatic — is best communicated with:", "options": ["Manufactured significance and macro commentary", "A short, calm report saying the portfolio did what it was designed to do", "Recommendations for major changes to add interest", "No report at all"], "correct": 1, "explanation": "Boring is often the goal. Clients who receive drama every quarter eventually stop trusting any of it."},
        {"id": "q12", "prompt": "Showing a 'representative account' in marketing materials that is actually the firm's best-performing account is:", "options": ["Standard industry practice", "A violation of GIPS principles and misleading in spirit even if technically allowed", "Required if the account is real", "Acceptable with no disclosure"], "correct": 1, "explanation": "Composite-based reporting prevents cherry-picking. Showing an outlier as 'representative' misrepresents the typical client's experience."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 23;

-- ── module23_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 23 CONTENT
-- Trading & Execution
-- ============================================================================
update public.modules set
  title = 'Trading & Execution',
  competency_id = 'OJL-14',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Place trades correctly the first time — knowing the order types, understanding the execution mechanics, managing the risks that show up in the seconds between intent and fill.',
  learning_objectives = ARRAY[
    'Choose the right order type for the situation — market, limit, stop, and variations',
    'Understand bid-ask spreads, liquidity, and the costs of trading',
    'Execute multi-leg trades like rebalances and trade lists in proper sequence',
    'Handle trade errors and corrections with discipline',
    'Recognize the regulatory framework governing trading — best execution, soft dollars, trade aggregation'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Order Types and When to Use Each",
        "summary": "The choice of order type can mean a difference of dollars per share — or, in extreme cases, much more. Know the menu and the situations where each is appropriate.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "When you submit a trade, the order type tells the market how and when you want it executed. The wrong order type at the wrong time can cost real money, fail to execute, or in volatile conditions produce surprising results. Most retail trading uses three to four order types; understanding the others is part of the trader's toolkit even if rarely used."},
          {"type": "subheading", "content": "Market order"},
          {"type": "paragraph", "content": "A market order is an instruction to buy or sell immediately at the best available price. It guarantees execution but not price. For highly liquid securities — large-cap ETFs, mega-cap stocks, U.S. Treasury futures — market orders typically execute very close to the displayed bid or ask. For less liquid securities, market orders can result in significant slippage, particularly during fast markets. The most common practical use is for small to moderate-sized trades in liquid securities where the priority is certainty of execution."},
          {"type": "subheading", "content": "Limit order"},
          {"type": "paragraph", "content": "A limit order specifies the maximum price you will pay (buy limit) or the minimum price you will accept (sell limit). It guarantees price but not execution — if the market never reaches your limit, the order does not fill. For less liquid securities, individual stocks, or trades where price precision matters, limit orders are the default choice. They protect against slippage but accept the risk of not getting filled."},
          {"type": "subheading", "content": "Stop order and stop-limit order"},
          {"type": "glossary", "terms": [
            {"term": "Stop order (stop-loss)", "definition": "An order that becomes a market order when the security reaches a specified 'stop' price. Used to limit losses on existing positions. In fast-moving markets, can fill significantly below the stop price."},
            {"term": "Stop-limit order", "definition": "Combines a stop trigger with a limit. When the stop price is reached, a limit order is placed (not a market order). Better price control than a stop order but can fail to fill in a fast-moving market."},
            {"term": "Trailing stop", "definition": "A stop price that adjusts as the security moves favorably — e.g., a stop 10% below the security's high, which moves up as the security rises but stays put when it falls. Useful for systematic profit-taking with downside protection."},
            {"term": "Marketable limit order", "definition": "A limit order priced at or beyond the current market — buys at the ask, sells at the bid — to ensure immediate execution while still capping the price. Common best practice for liquid securities."}
          ]},
          {"type": "subheading", "content": "Time-in-force qualifiers"},
          {"type": "list", "items": [
            "Day — order is good only for the current trading day; cancels at close if unfilled (the default for most orders)",
            "Good-til-cancelled (GTC) — order remains open until filled or explicitly cancelled, typically with a maximum duration (60-180 days)",
            "Immediate-or-cancel (IOC) — fill what is available immediately at the limit price; cancel the rest",
            "Fill-or-kill (FOK) — fill the entire order immediately or cancel completely; no partial fills",
            "Market-on-close (MOC) — execute as a market order at the close, used to capture closing prices for index tracking purposes"
          ]},
          {"type": "subheading", "content": "Choosing the order type — a decision framework"},
          {"type": "paragraph", "content": "For most retail rebalancing trades in liquid ETFs and mutual funds, the practical defaults are: market orders for mutual funds (which trade once a day at NAV anyway), and marketable limit orders for ETFs (cap your price at or slightly through the current market to control slippage while still getting filled). Use plain limit orders for less liquid securities or for trades where you can afford to wait. Use stops with caution — they have failure modes in flash crashes and volatile opens."},
          {"type": "callout", "kind": "warn", "content": "Avoid placing market orders in less liquid securities outside of normal market hours, or in the first or last few minutes of the trading session when spreads are typically wider. The slippage on a thinly traded position with a market order at the open can be material."},
          {"type": "case_study", "title": "Two ways to sell the same ETF", "scenario": "An apprentice needs to sell $24,000 of a U.S. small-cap value ETF in Naomi's Roth IRA. The ETF trades at a bid of $94.12 / ask of $94.18 with average daily volume of 380,000 shares. Option A: market order — fills at approximately the ask for the buy side and the bid for the sell side, depending on market depth at the moment. Option B: marketable limit at $94.14 (between bid and ask) — likely to fill at midpoint if a counterparty appears, otherwise sits and waits at slightly worse than the bid. The apprentice chooses the marketable limit at $94.14 — it caps the worst-case price and often executes at midpoint. The execution comes in at $94.13, saving about $0.04/share versus the bid. Across 254 shares, that is roughly $10 saved. Small per trade. Adds up across hundreds of trades over a year.", "discussion": "Marketable limit orders give up nothing meaningful (executions are nearly as certain as market orders for liquid names) and protect against slippage. Once you build the habit, every trade benefits."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Bid-Ask Spreads, Liquidity, and Execution Costs",
        "summary": "Trades are not free. The visible commission is often a small part of the real cost; the larger part lives in the bid-ask spread and market impact. Understanding both is essential.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most retail brokers now charge $0 commission on stock and ETF trades. This does not mean trading is free. The bid-ask spread, market impact, and implicit costs of execution remain real. For frequent traders or large trades, these costs can dwarf any explicit commission. Understanding where the costs live is the foundation of trading well."},
          {"type": "subheading", "content": "The bid-ask spread"},
          {"type": "paragraph", "content": "The bid is the highest price a buyer is currently willing to pay; the ask (or offer) is the lowest price a seller is currently willing to accept. The difference is the bid-ask spread. For highly liquid securities, the spread might be a single penny on a $200 stock — practically nothing. For thinly traded securities or wide-spread ETFs, the spread can be 50 basis points or more — meaning that buying and immediately selling would cost you half a percent before any commission."},
          {"type": "subheading", "content": "Factors that affect spreads"},
          {"type": "list", "items": [
            "Trading volume — higher daily volume generally means tighter spreads",
            "Market capitalization — large-cap stocks generally have tighter spreads than small-caps",
            "ETF underlying liquidity — an ETF holding liquid underlying securities has tighter spreads than one holding less liquid underlyings",
            "Time of day — spreads are wider at the open and close, tighter in the middle of the day",
            "Market volatility — spreads widen during stress periods as market makers price in risk",
            "Specific market events — earnings, economic data releases, geopolitical events can spike spreads briefly"
          ]},
          {"type": "subheading", "content": "Market impact"},
          {"type": "paragraph", "content": "Market impact is the price movement caused by your own trade. Buying 100 shares of a mega-cap stock moves the price by essentially nothing. Buying $5M of a thinly traded small-cap ETF can move the price by 50 basis points or more — your purchase is a meaningful percentage of the day's volume. Market impact is roughly proportional to the size of the trade relative to the security's average daily volume."},
          {"type": "glossary", "terms": [
            {"term": "ADV (Average Daily Volume)", "definition": "The average daily trading volume in shares or dollars over a recent period. A trade of more than 5-10% of ADV starts to have meaningful market impact."},
            {"term": "VWAP (Volume-Weighted Average Price)", "definition": "The average price weighted by volume over a defined period. Used as a benchmark for execution quality on large trades."},
            {"term": "TWAP (Time-Weighted Average Price)", "definition": "The average price over time. Slicing a large order into equal-sized pieces over a fixed time window."},
            {"term": "Iceberg order", "definition": "An order where only a small portion is visible to the market at any time, with the rest hidden — used to execute large orders without revealing total size."},
            {"term": "Algorithmic execution", "definition": "Trade execution managed by algorithms (e.g., VWAP, TWAP, implementation shortfall) that slice large orders to minimize market impact. Standard for institutional execution."}
          ]},
          {"type": "subheading", "content": "Reducing trading costs"},
          {"type": "list", "items": [
            "For liquid securities, use marketable limit orders rather than market orders",
            "Trade during periods of tighter spreads — typically mid-day rather than open or close",
            "For large trades, slice the order into smaller pieces over time or use an execution algorithm",
            "For ETFs with wide spreads, check whether the underlying basket is liquid — sometimes the ETF can be created/redeemed at NAV through an authorized participant, bypassing the spread (institutional access)",
            "Avoid trading immediately around major news releases when spreads widen",
            "For thinly traded securities, consider whether the trade is necessary at all — illiquid positions are often not worth establishing"
          ]},
          {"type": "callout", "kind": "key", "content": "Zero commission is a marketing term. The real costs of trading live in the spread and the market impact. Every trade should be sized and timed with these in mind."},
          {"type": "subheading", "content": "Cost analysis for rebalancing trades"},
          {"type": "paragraph", "content": "When evaluating whether to rebalance, consider the total cost. A rebalance that requires selling $50K of a thinly traded fund with a 30 bps spread costs $150 in spread alone, plus any market impact, plus tax cost if in a taxable account. If the drift being corrected is small, the rebalance can cost more than it saves. This is one reason the threshold-based methodology from Module 21 is preferred — small drifts within the band are not worth trading on."},
          {"type": "case_study", "title": "The thinly traded ETF problem", "scenario": "An apprentice is evaluating whether to use a niche ESG-focused ETF in a client portfolio. The ETF has $80M in AUM, average daily volume of 18,000 shares (about $720K daily), and a typical spread of 28 bps. Compared to a similar broader ESG ETF with $5B in AUM, 200,000 shares daily volume, and a 4 bps spread. For the client's $40K position, the niche ETF carries roughly $112 in round-trip spread cost versus $16 for the broader option — and any future rebalancing trades carry the same proportional cost differential. The expense ratios are similar. Decision: the broader ETF. The niche fund's marketing-promise differentiation does not survive the trading-cost analysis.", "discussion": "Total cost of ownership includes trading. A fund with a 5 bps expense ratio and a 30 bps spread costs more to actually use than a fund with a 10 bps expense ratio and a 3 bps spread. Diligence at the fund level continues at the execution level."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Executing Multi-Leg and Block Trades",
        "summary": "Rebalances often require multiple coordinated trades — selling some positions, buying others, possibly across multiple accounts. Sequence and coordination matter.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most consequential trading activity is not a single trade. A rebalance might require 8 trades across 3 accounts. A reallocation following an IPS update might require 20 trades. Adding a new position while removing two others is a multi-leg transaction. Executing these well requires deliberate sequencing, coordination, and attention to the time gaps between legs."},
          {"type": "subheading", "content": "Sell first, buy second — or simultaneously?"},
          {"type": "paragraph", "content": "When swapping one fund for another in the same account, two approaches: (1) sell the old fund first, wait for settlement, then buy the new fund (T+2 settlement period creates a 2-day gap where the proceeds are in cash and not earning return); (2) sell and buy simultaneously, with the proceeds covering the purchase via settlement netting. Modern custodians generally allow simultaneous trades on the same settlement date, which is preferred to minimize time out of the market. For inter-account swaps (selling in IRA, buying in taxable), the timing has to be more carefully managed because the proceeds do not flow between accounts."},
          {"type": "subheading", "content": "Mutual fund vs ETF coordination"},
          {"type": "paragraph", "content": "Mutual funds price once a day at the closing NAV. ETFs trade continuously throughout the day. When swapping a mutual fund for an ETF, you can either: (1) sell the mutual fund today (priced at today's close), and buy the ETF tomorrow when the mutual fund proceeds are available; or (2) coordinate so that both trades happen on the same day with awareness that the mutual fund will price at the end-of-day NAV while the ETF will price at the time of trade. Most modern custodial platforms allow same-day buy of an ETF using anticipated mutual fund proceeds. Confirm with the specific custodian."},
          {"type": "subheading", "content": "Block trades"},
          {"type": "paragraph", "content": "A block trade is a large trade negotiated outside the standard exchange order flow, typically because the size would have significant market impact. For retail-scale work, true block trades are uncommon; for institutional managers handling tens of millions in a single trade, blocks are routine. The apprentice's awareness here is mostly recognizing when a position is large enough that it should not be executed via a single market order — and either slicing it or escalating to the firm's institutional trading desk."},
          {"type": "subheading", "content": "Trade lists and bulk execution"},
          {"type": "paragraph", "content": "When implementing a portfolio change across many client accounts simultaneously, the firm generates a trade list — every trade across every account, organized by security and total share count. The trade list allows the trading desk to aggregate executions, getting a single average price across all accounts (a fairer outcome than executing each account separately at different prices throughout the day). The apprentice's role: produce a clean trade list with correct sizes, verify it against the intended changes, and review the execution report after fills are complete."},
          {"type": "callout", "kind": "do", "content": "Always review the trade list against the intended portfolio change before submission. A misplaced decimal point in a share count is the most common and most expensive error in retail trading."},
          {"type": "subheading", "content": "Same-day vs across-day execution"},
          {"type": "paragraph", "content": "For coordinated rebalances across multiple accounts, executing the full set on the same trading day is preferable because it ensures all accounts get similar market conditions. Splitting executions across multiple days exposes accounts to different markets and can produce dispersion between client outcomes that is hard to explain. If a multi-day execution is necessary (because of size), be explicit about why and document the decision."},
          {"type": "case_study", "title": "Marcus and Tasha's reallocation execution", "scenario": "After the year of the bond tent decision, Marcus and Tasha's IPS calls for moving from 80/20 to 75/25 in their household portfolio. Implementation: $58K of equity ETFs need to be sold across three accounts, $58K of bond ETFs need to be bought across the same accounts. The apprentice generates a trade list, reviews it against the IPS change for accuracy, executes all trades on the same morning (mid-day window for tightest spreads) using marketable limit orders, and reviews the fill report at end of day. Average execution price across the equity sells was within 2 bps of the day's VWAP; bond buys were within 1 bp. Total spread cost: about $42. Documentation: trade list, execution report, allocation pre- and post-trade, IPS change memo. Complete in one trading day.", "discussion": "Nothing dramatic happened. That is the point. Good execution is unspectacular and reliable. The trade list discipline, the timing discipline, and the post-execution review combined to deliver a clean implementation."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Trade Errors and Corrections",
        "summary": "Trade errors happen. The professional response — fast detection, honest disclosure, proper correction, and process improvement — is what separates good firms from bad ones.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Even in well-run firms, trade errors occur. A wrong ticker is entered. A share count has an extra zero. An order is placed in the wrong account. A buy is entered as a sell. The cost of these errors can range from negligible to substantial. How the firm handles them — speed of detection, integrity of disclosure, fairness of correction, and improvement of the process — defines the firm's character."},
          {"type": "subheading", "content": "Common trade errors"},
          {"type": "list", "items": [
            "Wrong ticker — entering a similar but different symbol (VTI vs VTV, IVV vs IEV)",
            "Wrong side — buy entered as sell or vice versa",
            "Wrong share count — extra digit, missing digit, or wrong by a factor of ten",
            "Wrong account — trade entered in client A's account when it was intended for client B",
            "Stale prices on limit orders — limit set hours ago no longer makes sense in current market",
            "Forgotten orders — a limit order entered days ago fills in an unexpected market move",
            "Wash-sale violations — a sale at loss followed by a buy of substantially identical security within 30 days"
          ]},
          {"type": "subheading", "content": "Detection — the same-day review"},
          {"type": "paragraph", "content": "Most trade errors are caught by same-day review. End-of-day, every trade should be matched against the order it was supposed to fill: ticker right, side right, account right, share count right, price reasonable. The five-minute review catches the wrong-ticker error before settlement; the wrong-account error before the client sees an unfamiliar position on their statement; the share-count error before the next morning's news creates market movement that compounds the cost."},
          {"type": "callout", "kind": "do", "content": "End-of-day trade review is non-negotiable. Without it, errors fester until they surface as client complaints or compliance issues — by which time the cost of correction is much higher."},
          {"type": "subheading", "content": "Correction process"},
          {"type": "paragraph", "content": "When an error is detected, the firm's correction process kicks in. The general principle: make the client whole. The client should not bear the cost of the error. If the error caused a loss versus the intended trade, the firm absorbs that loss. If the error happened to produce a gain versus the intended outcome, the firm typically takes the position into a firm error account and the client is restored to where they would have been. The specifics are governed by firm policy and applicable regulations."},
          {"type": "subheading", "content": "Disclosure"},
          {"type": "paragraph", "content": "The client should be informed of the error, what caused it, what the correction was, and any impact on their account. Hiding errors is both unethical and a regulatory violation under fiduciary duty. The communication should be calm and factual: 'On Thursday, an order was entered in your account that did not match the intended trade. We caught the error during end-of-day review on Friday morning. The position has been corrected and your account is in the position we intended. No cost to you. We have updated our review procedure to add a second check on similar orders to prevent recurrence.' Then move on."},
          {"type": "subheading", "content": "Process improvement"},
          {"type": "paragraph", "content": "After every meaningful error, the firm should conduct a brief review: what happened, why was it not caught earlier, what process change would prevent recurrence. The goal is not to assign blame but to improve. The most common process improvements: adding a second-set-of-eyes check on certain trade types, adding software validation that flags unusual orders, building checklists for specific recurring error types. Errors are expensive; not learning from them is more expensive."},
          {"type": "subheading", "content": "Documentation"},
          {"type": "paragraph", "content": "Every trade error generates a record: the original error, the detection, the correction, the client disclosure, and the process improvement. Maintain this record for compliance purposes and for institutional learning. Patterns in error types reveal systemic issues — for example, repeated wrong-ticker errors might point to a process that does not require ticker confirmation, which is a fixable system problem rather than an individual one."},
          {"type": "case_study", "title": "The Friday-morning catch", "scenario": "An apprentice executed a rebalance Thursday afternoon. End-of-day review Thursday completed quickly because of a tight schedule; the apprentice planned to do a more careful review Friday morning. Friday morning the second-look catches that one of the buy orders went into the wrong client account — Marcus and Tasha got 12 shares of a fund that was intended for a different client. The fund's price moved $0.43 between Thursday afternoon and Friday morning, working out to about $5 in mismatched exposure. The apprentice immediately: (1) journals the position to the correct client account, (2) absorbs the $5 differential in the firm's error account, (3) emails Marcus and Tasha a brief, calm note about the error and correction, (4) notes the incident in the firm's error log, and (5) proposes adding a 'final account verification' as a separate step in the trade workflow.", "discussion": "Friday's catch versus a Monday discovery via client complaint would have been the difference between $5 and a damaged trust relationship. The discipline of same-day review (or in this case, next-morning when the schedule slipped) is what keeps small errors from becoming big ones. The disclosure email is short, honest, and forward-looking. Marcus and Tasha respond with appreciation for the transparency."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Best Execution, Soft Dollars, and the Regulatory Framework",
        "summary": "Trading is regulated. The framework governing best execution, soft dollars, trade aggregation, and conflicts is part of the apprentice's required knowledge.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "The regulatory and ethical framework around trading is meaningful and consequential. Most apprentices will not be in roles where they are personally making best-execution decisions, but understanding the framework is required because the firm's practices in these areas affect every client. This lesson covers the major concepts at a level appropriate for an apprentice."},
          {"type": "subheading", "content": "Best execution"},
          {"type": "paragraph", "content": "Best execution is the obligation to seek the most favorable terms reasonably available for client transactions. It is not the same as 'lowest commission' or 'best price' — it includes consideration of speed, certainty of execution, settlement reliability, market impact, and other factors. SEC and FINRA rules require broker-dealers and advisers to have policies designed to achieve best execution and to periodically review whether execution quality is being maintained. For an apprentice, the practical implications are: use the firm's approved trading venues and methods, do not deviate without authorization, and recognize that 'best execution' is a process and policy obligation more than a guarantee on any single trade."},
          {"type": "subheading", "content": "Trade aggregation"},
          {"type": "paragraph", "content": "When multiple client accounts trade the same security on the same day, the firm may aggregate the orders and execute them as a single block at an average price, then allocate the shares back to each account. This is called trade aggregation or block-and-allocate. It produces a fair, uniform price across accounts rather than a lottery of who got which fills. Firms are expected to have written aggregation policies that prevent favoritism — no account or strategy gets preferred treatment in the allocation."},
          {"type": "subheading", "content": "Soft dollars"},
          {"type": "glossary", "terms": [
            {"term": "Soft dollars", "definition": "Commissions or fees paid to a broker that include implicit payment for research, technology, or other services beyond pure execution. Section 28(e) of the 1934 Securities Exchange Act creates a 'safe harbor' for soft dollar arrangements that meet specific criteria."},
            {"term": "Hard dollars", "definition": "Cash payments for services, separate from trade execution commissions. Typically more transparent than soft dollars."},
            {"term": "Section 28(e) safe harbor", "definition": "Allows an investment manager to use client commissions to obtain research or brokerage services that provide 'lawful and appropriate assistance' to the manager's investment decision-making, without breaching fiduciary duty — subject to specific conditions."},
            {"term": "Commission Sharing Arrangement (CSA)", "definition": "A structured form of soft dollars where commissions paid to one broker can be directed to a research provider, with clearer accounting."}
          ]},
          {"type": "subheading", "content": "Conflicts in trading practices"},
          {"type": "list", "items": [
            "Front-running — trading for personal benefit ahead of client orders. Strictly prohibited.",
            "Allocation favoritism — directing better fills to higher-fee clients, proprietary accounts, or favored accounts. Prohibited.",
            "Excessive trading (churning) — generating trades primarily to generate commissions rather than to serve the client. Suitability and fiduciary violation.",
            "Trading away from approved venues to obtain personal benefits (kickbacks, soft dollar credits for personal use). Prohibited.",
            "Misuse of soft dollars — using soft-dollar credits for services that do not meet the Section 28(e) standard. Regulatory violation."
          ]},
          {"type": "subheading", "content": "Personal trading policies"},
          {"type": "paragraph", "content": "Most firms have personal trading policies governing what employees can trade, when, and with what disclosure. Common restrictions: blackout periods around client trades in the same security, pre-clearance requirements for individual stock purchases, holding period requirements, and prohibition on certain instruments or strategies. The apprentice will be subject to the firm's personal trading policy from day one. Read it carefully and follow it scrupulously. Personal trading violations are one of the most common pathways to professional discipline."},
          {"type": "callout", "kind": "warn", "content": "Personal trading policy violations damage careers permanently in this industry. When in doubt, ask compliance before trading personally. The friction of asking is much smaller than the cost of an enforcement action."},
          {"type": "subheading", "content": "Trade documentation and recordkeeping"},
          {"type": "paragraph", "content": "Regulatory rules require comprehensive recordkeeping of trades — order entry, execution, allocation, confirmation, and any communications related to the trade. SEC Rule 17a-4 specifies retention periods for broker-dealer records (generally 3-6 years, some longer). The Investment Advisers Act has its own recordkeeping requirements for RIAs. The apprentice's day-to-day involvement is ensuring trade documentation is complete and filed — incomplete trade documentation creates compliance exposure even when the underlying trade was perfectly executed."},
          {"type": "case_study", "title": "The trade aggregation question", "scenario": "An apprentice is preparing to execute a rebalance across 12 client accounts that all hold the same target U.S. equity ETF. The firm's policy: aggregate all 12 orders into a single block trade, execute at the best available terms during the firm's standard execution window, then allocate the shares back to each client at the same average price. The apprentice generates the trade list, the trading desk executes the block, and the allocation runs automatically based on each account's target share count. All 12 clients receive shares at the same execution price. The apprentice's role: generate the correct trade list, verify the allocation matches each account's target, and confirm the execution report.", "discussion": "Aggregation produces fairness — no account got a better or worse fill than any other based on the order they happened to be processed in. The apprentice's discipline is feeding clean data into a process that is structurally fair. The systems do most of the work; the apprentice ensures the inputs are correct."},
          {"type": "callout", "kind": "key", "content": "Trading is heavily regulated for good reason — the structural conflicts and opportunities for abuse are real. The framework exists to protect clients. Operate within it as if you were always being audited, because eventually you will be."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Tax-Loss Harvesting — using the tools developed here to systematically generate tax savings while maintaining the portfolio's design."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "A market order is best described as:", "options": ["An order with a specified maximum or minimum price", "An order to execute immediately at the best available price, guaranteeing execution but not price", "An order that activates when a stop price is breached", "An order valid only on the closing auction"], "correct": 1, "explanation": "Market orders guarantee execution by trading immediately at whatever the market offers. Price is whatever is available; in fast or illiquid markets that can produce slippage."},
        {"id": "q2", "prompt": "A marketable limit order is:", "options": ["A market order with a fee waiver", "A limit order priced at or beyond the current market to ensure near-immediate execution while capping price", "An order that only fills outside market hours", "A type of stop order"], "correct": 1, "explanation": "Marketable limits combine quick execution (priced through the market) with price control (the limit caps slippage). Standard best practice for liquid securities."},
        {"id": "q3", "prompt": "The bid-ask spread is best described as:", "options": ["The commission charged by the broker", "The difference between the highest price a buyer is willing to pay and the lowest price a seller is willing to accept", "The price movement over a single day", "The fee for using margin"], "correct": 1, "explanation": "The spread is implicit trading cost — buying takes the ask and selling takes the bid, so the round-trip cost is the spread plus any market impact."},
        {"id": "q4", "prompt": "When a trade size exceeds roughly what percentage of a security's average daily volume, market impact becomes meaningful?", "options": ["1-2%", "5-10%", "25%", "50% or more"], "correct": 1, "explanation": "Trades above 5-10% of ADV start to move the price meaningfully. Larger trades require slicing, algorithmic execution, or block negotiation."},
        {"id": "q5", "prompt": "Trade aggregation (block-and-allocate) is used to:", "options": ["Hide trade size from regulators", "Combine multiple client orders into a single execution, then allocate shares at the average price, producing a fair uniform price across accounts", "Reduce client tax liability", "Avoid commission fees"], "correct": 1, "explanation": "Aggregation prevents favoritism across accounts by ensuring all clients receive the same average price for the same security on the same day."},
        {"id": "q6", "prompt": "The Section 28(e) safe harbor relates to:", "options": ["Personal trading by employees", "Soft dollar arrangements — allowing client commissions to obtain research or brokerage services without breaching fiduciary duty under specific conditions", "Trade settlement timing", "Margin requirements"], "correct": 1, "explanation": "Section 28(e) of the 1934 Act provides the framework for permissible soft dollar arrangements between investment managers and brokers."},
        {"id": "q7", "prompt": "Best execution under SEC and FINRA rules requires firms to:", "options": ["Guarantee the lowest price on every trade", "Maintain policies and review processes designed to obtain the most favorable terms reasonably available across multiple dimensions including price, speed, certainty, and impact", "Use only the largest broker-dealers", "Eliminate all commissions"], "correct": 1, "explanation": "Best execution is a process and policy obligation considering multiple factors, not a guarantee on any single trade."},
        {"id": "q8", "prompt": "When a trade error is detected, the general principle for the client is:", "options": ["The client bears the cost since they signed the agreement", "Make the client whole — the client should not bear the cost of the firm's error", "Refer the matter to litigation", "Ignore small errors"], "correct": 1, "explanation": "Fiduciary duty requires that clients be made whole from errors. The firm absorbs the cost; the client is restored to the position they should have been in."},
        {"id": "q9", "prompt": "Same-day end-of-day trade review is important because:", "options": ["Regulators require it on the day of trade", "Most trade errors are catchable at end-of-day; errors not caught quickly compound in cost and damage", "It reduces commission", "It is voluntary best practice"], "correct": 1, "explanation": "Speed of detection determines the cost of correction. The 5-minute end-of-day review prevents small errors from becoming large client problems."},
        {"id": "q10", "prompt": "Front-running — trading for personal benefit ahead of client orders in the same security — is:", "options": ["Allowed if disclosed", "Strictly prohibited and a serious regulatory violation", "Permitted in retirement accounts", "Required by best execution rules"], "correct": 1, "explanation": "Front-running breaches fiduciary duty and is a serious enforcement matter. Personal trading policies are designed to prevent it."},
        {"id": "q11", "prompt": "A 60/40 client portfolio worth $800K is over-weighted equity by 5 percentage points after a strong year. Selling equity in the taxable account would realize $42K of long-term gains. The most tax-efficient rebalancing action is to:", "options": ["Sell equity in the taxable account immediately", "Rebalance in the tax-deferred or Roth accounts where the trade has no tax cost", "Wait until the next year", "Add new contributions only"], "correct": 1, "explanation": "Order of operations from Module 21: first rebalance in tax-advantaged accounts. The taxable account is preserved; the household allocation is restored without realizing the gain."},
        {"id": "q12", "prompt": "Personal trading policy violations by employees of investment firms are:", "options": ["Generally minor matters", "One of the most common pathways to professional discipline; should be treated with maximum care including pre-clearance when uncertain", "Only enforced against senior staff", "Permitted if no client harm occurs"], "correct": 1, "explanation": "Enforcement actions for personal trading violations are common and career-damaging. When in doubt, pre-clear with compliance — the friction is small versus the cost of a violation."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 24;

-- ── module24_content.sql ──

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

-- ── module25_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 25 CONTENT
-- Account Administration & Custody
-- ============================================================================
update public.modules set
  title = 'Account Administration & Custody',
  competency_id = 'OJL-16',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Understand the custodial infrastructure that holds client assets — what custodians actually do, how account registrations work, what protections exist, and the day-to-day administration that keeps everything running clean.',
  learning_objectives = ARRAY[
    'Distinguish the roles of advisor, custodian, and broker-dealer',
    'Choose the right account registration for each client situation',
    'Understand SIPC, FDIC, and other investor protections',
    'Manage account-level details — money movement, ACH, beneficiaries, authority levels',
    'Recognize the operational risks that live in account administration and how to control them'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Who Holds the Money — Advisor, Custodian, Broker-Dealer",
        "summary": "Many clients believe their advisor holds their money. They do not. Understanding who does — and why that separation matters — is the foundation of operational competence.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When a client invests through an RIA, three different entities are typically involved: the advisor (the firm that recommends and manages the portfolio), the custodian (the firm that holds the assets and processes transactions), and the broker-dealer (the firm that executes trades, sometimes the same entity as the custodian). The separation of these roles is not arbitrary — it is a structural protection. The advisor recommends; the custodian holds and verifies; nobody touches the client's money in isolation. Understanding the architecture protects clients and prevents the kinds of fraud that have ended advisor careers."},
          {"type": "subheading", "content": "The advisor's role"},
          {"type": "paragraph", "content": "Registered Investment Advisers are typically registered with either the SEC (if assets under management exceed $100M) or with state securities regulators (below that threshold). They provide advice, build portfolios, execute trades on the client's behalf through the custodian, and bill fees. The advisor does not hold the client's assets directly. Statements come from the custodian, not the advisor — this is a structural protection against fraud."},
          {"type": "subheading", "content": "The custodian's role"},
          {"type": "paragraph", "content": "Custodians — Schwab, Fidelity, Pershing, Goldman Sachs Custody Solutions, and others — hold the securities, process trades, send statements, handle corporate actions, distribute dividends, and report tax information. They are typically broker-dealers themselves and are subject to SEC and FINRA oversight. The custodian's records are the official record of what the client owns. If the advisor's reporting and the custodian's reporting differ, the custodian's records prevail."},
          {"type": "subheading", "content": "Why the separation matters — Madoff and lessons learned"},
          {"type": "paragraph", "content": "Bernie Madoff's fraud worked partly because he ran both the advisory firm and the custodian — clients received statements from Madoff Securities showing assets that did not exist. After Madoff, the industry doubled down on the principle that custody should be independent of advice. When a client receives a statement from Schwab (not from their RIA) showing their actual securities, that statement is the truth. The RIA's portfolio management software is reconciled against custodial data, not the other way around. The separation is the structural defense against most fraud patterns."},
          {"type": "callout", "kind": "key", "content": "When in doubt about whether something is right, look at the custodial statement, not the advisor's report. The custodial statement is the official record."},
          {"type": "subheading", "content": "The broker-dealer's role"},
          {"type": "paragraph", "content": "Broker-dealers execute trades. At many custodians, the same legal entity serves as custodian and as broker-dealer (Schwab and Fidelity are both). At others, there is more separation. When trades are placed, the executing broker may differ from the custodian (especially for less liquid securities or larger institutional trades). The Trade Confirmation generated for each trade names the executing broker; the custodial statement reflects the resulting position. For retail RIA work using major custodians, advisor, custodian, and broker-dealer often appear in a clean three-way relationship that simplifies the model."},
          {"type": "subheading", "content": "Authority levels — what the advisor can do without client permission"},
          {"type": "list", "items": [
            "Discretionary authority — advisor can place trades within the IPS without per-trade client consent (the most common model)",
            "Limited trading authority — advisor can trade but only with explicit per-trade client consent",
            "Limited withdrawal authority — advisor can withdraw fees from the account per the advisory agreement, but cannot withdraw to anywhere else",
            "Full transaction authority — rare in retail RIA, allows advisor to direct distributions to client-specified destinations; tightly controlled with paperwork",
            "Account opening authority — typically client must sign for new accounts, even with discretionary authority over existing ones"
          ]},
          {"type": "subheading", "content": "Custodial selection considerations"},
          {"type": "paragraph", "content": "Larger RIAs typically work with a single primary custodian or a small number. The choice affects: trading commissions and pricing, technology integration (CRM, portfolio management software), product availability (mutual funds, alternatives, structured products), service quality and operational support, minimum account sizes for the custodian platform, and fee structure (some custodians charge platform fees on top of advisor fees, others bundle). The choice is significant. Apprentices typically operate within the firm's existing custodial relationship rather than choosing one."},
          {"type": "case_study", "title": "The fraud that didn't happen", "scenario": "A client receives a phone call from someone claiming to be from her advisor's office, saying her advisor has changed firms and her account needs to be transferred — to a new custodian she has never heard of, with instructions to wire funds. The client calls her actual advisor to verify. The advisor confirms: no transfer is happening, no wire instructions were authorized, the call was fraudulent. The advisor walks her through verifying the custodial statement directly with the custodian (Schwab in this case) — her assets are intact at the custodian. Police are notified.", "discussion": "The structural separation prevented loss. The client knew the custodial relationship existed — her statements came from Schwab, not from the advisor — and that knowledge let her test the fraudulent call by going to the custodian directly. Clients who understand the custody architecture are harder to defraud."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Account Registrations — Getting the Title Right",
        "summary": "How an account is titled determines who owns it, who can access it, how it passes at death, and how it is treated for tax purposes. Getting the registration wrong is one of the most expensive mistakes in retail finance.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Account registration is the legal title of the account — who owns it, in what capacity, and with what rights. Most clients give little thought to registration ('whatever is easiest'), but the choice has consequences that cascade through tax, estate, creditor, and family-law contexts. The correct registration depends on the client's situation, state law, and goals. Knowing the major types and when each fits is fundamental operational knowledge."},
          {"type": "subheading", "content": "Individual accounts"},
          {"type": "glossary", "terms": [
            {"term": "Individual account", "definition": "A taxable brokerage account titled to one person. Simple. Passes through the owner's will or trust at death (no automatic transfer feature)."},
            {"term": "Joint Tenants with Rights of Survivorship (JTWROS)", "definition": "Two owners with equal rights; at first owner's death, the entire account passes automatically to the surviving owner outside probate. Common between spouses."},
            {"term": "Tenants in Common (TIC)", "definition": "Two or more owners with specified percentages; each owner's share passes through their own estate at death, not automatically to the other owner. Used when joint owners want their share to go elsewhere than the co-owner."},
            {"term": "Community Property", "definition": "Specific to community property states (California and 8 others); spouses each have a 50% interest in property acquired during marriage. Has tax basis advantages at first spouse's death (full step-up on both halves in some configurations)."},
            {"term": "Joint Tenants by the Entirety", "definition": "A form of joint ownership available only to married couples in some states. Has creditor protection advantages: neither spouse's individual creditors can attach the account; only joint creditors of both spouses can."}
          ]},
          {"type": "subheading", "content": "Trust accounts"},
          {"type": "paragraph", "content": "Accounts titled in the name of a trust are held according to the trust's terms. The trustee — named in the trust document — has authority over the account. Trust accounts can be: revocable (the grantor can change or revoke the trust; for the grantor's lifetime the account is taxed as their own); irrevocable (cannot be changed once established; separate tax entity); testamentary (created by will at death). Account titling typically reads 'John Smith, Trustee of the Smith Family Living Trust dated 3/15/2018.' Get the title exact — the custodian requires the title to match the trust document precisely."},
          {"type": "subheading", "content": "Retirement accounts"},
          {"type": "list", "items": [
            "Traditional IRA — individually owned, contributions usually pre-tax, withdrawals taxed as ordinary income",
            "Roth IRA — individually owned, contributions after-tax, qualified withdrawals tax-free",
            "Rollover IRA — created to receive a rollover from a 401(k) or other qualified plan; same as Traditional IRA for most purposes but may have advantages for future rollback to a new employer plan",
            "SEP IRA — Simplified Employee Pension; self-employment retirement plan with higher contribution limits than personal IRA",
            "SIMPLE IRA — for small businesses with up to 100 employees; lower contribution limits than 401(k)",
            "401(k) — employer-sponsored qualified retirement plan; varies by plan",
            "Inherited IRA (Beneficiary IRA) — special account type holding inherited retirement assets; SECURE Act rules govern distribution"
          ]},
          {"type": "subheading", "content": "Custodial and minor accounts"},
          {"type": "list", "items": [
            "UTMA/UGMA — Uniform Transfers/Gifts to Minors Act accounts; assets owned by the minor with an adult custodian until the age of majority (18 or 21 depending on state and account type)",
            "529 plans — state-sponsored education savings accounts with tax advantages",
            "Coverdell ESA — Education Savings Account; less commonly used since 529 limits expanded",
            "Custodial Roth IRA — Roth IRA for a minor with earned income; custodian until majority"
          ]},
          {"type": "subheading", "content": "Business and entity accounts"},
          {"type": "list", "items": [
            "Sole proprietorship — typically uses individual or DBA registration; assets are the owner's personally",
            "LLC accounts — owned by the LLC entity; titled in the LLC name; signing authority defined by operating agreement",
            "Corporate accounts — owned by the corporation; signing authority per board resolution",
            "Partnership accounts — owned by the partnership; authority per partnership agreement"
          ]},
          {"type": "callout", "kind": "warn", "content": "Getting the registration wrong at account opening is much cheaper to fix than discovering it years later when the client dies or divorces or gets sued. Take the extra five minutes at opening to confirm the registration is correct."},
          {"type": "subheading", "content": "Transfer-on-Death (TOD) and Payable-on-Death (POD)"},
          {"type": "paragraph", "content": "TOD on a brokerage account or POD on a bank account names a beneficiary who will receive the account directly at the owner's death, bypassing probate. TOD/POD is a powerful tool for simple estate planning — passes assets outside probate, supersedes the will for those specific assets — but requires care. The named beneficiary must be kept current. TOD does not avoid estate tax. TOD beneficiaries must be coordinated with the rest of the estate plan; uncoordinated TOD can produce inheritances that contradict the will's intent."},
          {"type": "case_study", "title": "The registration that didn't match the trust", "scenario": "Devon and his wife established a Family Living Trust in 2018. The attorney drafted the trust expecting Devon's brokerage account to be titled in the name of the trust. Five years later when reviewing the estate plan, the apprentice notices: the brokerage account is still titled in Devon's individual name. The trust was created but the asset was never re-titled into it. If Devon died, the brokerage account would pass through his will (not the trust), going through probate, potentially with different beneficiaries than the trust's terms. The fix takes 45 minutes — Devon and the apprentice complete the custodian's retitling paperwork, the account moves to trust registration, and the trust now actually holds the asset it was designed to hold.", "discussion": "Estate plans are only as good as their funding. The trust document is one half; the retitled accounts are the other. Without re-registration, the estate plan was a paper exercise. This is the kind of operational miss that estate attorneys assume their clients (or advisors) will handle and that often does not get done."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "SIPC, FDIC, and Other Investor Protections",
        "summary": "Clients want to know their money is safe. Knowing what is actually protected — and what is not — lets you answer the question correctly.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Several different protection regimes apply to different types of financial accounts. None of them are a guarantee against investment loss; all of them protect against specific failure scenarios. Confusing them — or implying broader protection than exists — is a regulatory and ethical issue. Know the scope of each."},
          {"type": "subheading", "content": "SIPC — Securities Investor Protection Corporation"},
          {"type": "paragraph", "content": "SIPC is a nonprofit funded by member broker-dealers and provides protection if a member broker-dealer fails (financial failure of the brokerage itself), not against market losses. Coverage: up to $500,000 per customer per separate capacity, including a $250,000 sublimit for cash. SIPC restores securities and cash held by the failed broker-dealer to customers. Most major custodians carry supplemental insurance beyond SIPC's limits through commercial insurers — Lloyd's of London is commonly named — extending protection to substantially higher amounts (often hundreds of millions per account)."},
          {"type": "subheading", "content": "FDIC — Federal Deposit Insurance Corporation"},
          {"type": "paragraph", "content": "FDIC insures bank deposits up to $250,000 per depositor per insured bank per ownership category. Applies to checking, savings, CDs, and money market deposit accounts at FDIC-insured banks — not to money market funds (different product even though similar name), brokerage cash balances at non-bank custodians, or investment securities. A married couple with proper account structuring can have substantially more than $250,000 protected at a single bank by using different ownership categories (individual, joint, trust, retirement)."},
          {"type": "subheading", "content": "NCUA — National Credit Union Administration"},
          {"type": "paragraph", "content": "NCUA provides FDIC-equivalent insurance for credit unions, with the same $250,000 per depositor per insured credit union per ownership category limit."},
          {"type": "subheading", "content": "What is NOT protected"},
          {"type": "list", "items": [
            "Investment losses from market movements — SIPC explicitly does not protect against market risk",
            "Losses from bad advice or unsuitable recommendations — separate remedies through arbitration or court",
            "Money market funds (not bank deposit money market accounts) — these are SEC-regulated investment products without SIPC cash sublimit protection, though they have stable-NAV regulation",
            "Cryptocurrency holdings on most platforms — no SIPC, no FDIC, regulatory framework still developing",
            "Commodities futures accounts — covered by SIPC only in limited ways; CFTC has its own regime",
            "Insurance products — covered by state insurance guaranty associations, which vary by state and product type"
          ]},
          {"type": "subheading", "content": "Communicating protections accurately"},
          {"type": "paragraph", "content": "Clients often ask 'is my money insured?' The honest answer is layered: their cash at a bank is FDIC-insured up to limits; their cash and securities at a brokerage are SIPC-protected against broker-dealer failure up to limits, often with supplemental coverage beyond; nothing protects them against investment losses from market movements; bad advice is a separate accountability path through fiduciary duty and dispute resolution. Avoid any phrasing that suggests their investment values are 'safe' or 'protected' in a market-loss sense — they are not."},
          {"type": "callout", "kind": "warn", "content": "Telling a client their investments are 'protected' or 'safe' in any blanket way is a compliance issue and an ethical one. Be precise about what each insurance regime actually covers."},
          {"type": "subheading", "content": "Cash sweep arrangements"},
          {"type": "paragraph", "content": "Most brokerages sweep uninvested cash into one of several vehicles: money market funds (not FDIC-insured but SIPC-cash-sublimit protected and stable-NAV regulated), bank deposit sweep programs (FDIC-insured up to limits, often spread across multiple partner banks to extend coverage), or money market deposit accounts (FDIC-insured up to single-bank limits). The choice affects yield, insurance coverage, and access. Most retail clients have a default sweep vehicle that may not be optimal — particularly for cash balances above FDIC single-bank limits. Reviewing sweep arrangements at account setup is part of competent administration."},
          {"type": "case_study", "title": "The cash sweep question", "scenario": "A retired client has $620,000 sitting in their brokerage account's cash sweep — a single-bank FDIC sweep at the custodian. Only $250,000 is insured at that bank. The apprentice flags this in the next review: 'Your current cash sweep covers $250K of the $620K under FDIC. The remaining $370K is uninsured. We have three options: (1) move to a multi-bank sweep program at this custodian that spreads cash across multiple banks for higher coverage, (2) keep the FDIC-insured portion here and move excess to a money market fund for SIPC-cash protection within limits, or (3) deploy the cash into the portfolio per the IPS — most of this cash is sitting idle and could be invested.' The client opts for the multi-bank sweep on operating cash plus deployment of excess into the portfolio.", "discussion": "Without the apprentice flagging this, the client could have lost insurance protection on $370K without knowing. Account administration includes noticing things like this. Cash sweep arrangements are easy to ignore — and the cost of ignoring them shows up only in tail-risk scenarios."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Money Movement — ACH, Wires, Journals, and Standing Instructions",
        "summary": "Money has to move in and out of accounts. Each method has its own speed, cost, risk profile, and proper use. Getting money movement right is operational discipline.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Routine account operations involve frequent money movement — depositing contributions, distributing income, paying advisory fees, transferring between accounts, sending withdrawals to clients. The methods used carry different speeds, costs, irreversibility, and fraud risks. Choosing the right method for each situation, and verifying movement before considering it complete, is daily operational work."},
          {"type": "subheading", "content": "Common money movement methods"},
          {"type": "glossary", "terms": [
            {"term": "ACH (Automated Clearing House)", "definition": "Electronic bank-to-bank transfer. Typically 1-3 business days. Free at most custodians. Reversible within a window. Standard method for client contributions, withdrawals, and recurring transfers."},
            {"term": "Wire transfer", "definition": "Same-day electronic transfer. Fee-based (typically $15-30 outgoing). Generally irreversible once sent. Used for large transfers, time-sensitive transfers, and any transfer to a non-bank destination."},
            {"term": "Journal", "definition": "Internal transfer between accounts at the same custodian. Same-day, free, and the cleanest method for moving assets between client accounts within one custodian."},
            {"term": "Check", "definition": "Paper or electronic check. Slowest method (mail time plus deposit time). Still used for some scenarios; mostly displaced by ACH and wire."},
            {"term": "Standing instruction / Letter of Authorization", "definition": "Pre-authorized recurring transfer instructions on file with the custodian. Allows automated movement (monthly contributions, scheduled withdrawals) without per-transaction approval."}
          ]},
          {"type": "subheading", "content": "ACH for routine flows"},
          {"type": "paragraph", "content": "ACH is the standard method for most retail money movement: scheduled monthly contributions, distributions from retirement accounts, advisory fee deductions, and one-time client-requested deposits or withdrawals. The mechanics: a one-time client-signed authorization on file with the custodian links a verified external bank account; subsequent ACH instructions can be initiated by the client or by the advisor (within the scope of authority granted). ACH transactions are reversible for a window — typically 60 days for consumer accounts under NACHA rules — which provides some protection against fraud but also means the transfer is not 'final' immediately."},
          {"type": "subheading", "content": "Wires for large or time-sensitive transfers"},
          {"type": "paragraph", "content": "Wires are used when speed matters (settlement on a real estate purchase) or when ACH limits are exceeded (some banks limit ACH amounts) or when the destination is not a regular bank account (a title company escrow, an attorney's IOLTA account). Wire fees are not trivial — outgoing wires typically cost $15-30; international wires cost more. Wires are irreversible. Once sent, the money is gone. This irreversibility is the source of most wire fraud losses — once a fraudster has tricked a victim into sending a wire to the wrong account, the recovery options are limited."},
          {"type": "callout", "kind": "warn", "content": "Wire instructions changed in an email are a common fraud pattern. If wire instructions arrive by email — even from a known counterparty (CPA, attorney, title company) — verbally verify them by phone using a previously-known number before initiating. The five-minute call has prevented many six- and seven-figure fraud losses."},
          {"type": "subheading", "content": "Journals between accounts at the same custodian"},
          {"type": "paragraph", "content": "When moving assets between accounts at the same custodian — between a client's spouse's account, between their taxable and IRA, between household member accounts — a journal is the cleanest method. Same-day, free, and bypasses the external banking system. The custodian handles tax-reporting implications appropriately. Use journals whenever the destination is internal to the custodian; default to ACH or wire only when external transfer is necessary."},
          {"type": "subheading", "content": "Standing instructions — efficient but require monitoring"},
          {"type": "paragraph", "content": "Standing instructions automate recurring transfers — the $400 bi-weekly auto-save we set up for Marcus and Tasha in Module 17. These are valuable for behavioral reasons (the transfer happens without the client having to remember) but require periodic verification: confirm the transfer is actually executing as expected; confirm the destination details have not changed; confirm the amount is still appropriate for the client's situation. Standing instructions also need to be terminated cleanly when no longer wanted — leaving a standing instruction running after it should have ended is a common operational error."},
          {"type": "subheading", "content": "Verification — confirm money actually arrived"},
          {"type": "paragraph", "content": "An initiated transfer is not a completed transfer. Always verify the money arrived where it was supposed to go and in the amount expected. For ACH, wait for the settled date (typically T+2 to T+3) before considering the transfer complete. For wires, confirm receipt on the destination side (often via a confirmation from the receiving bank). For journals, the same-day verification is straightforward — the source account is debited and the destination is credited within hours. The verification step is identical in principle to the post-trade verification from Module 17 — submission is not completion."},
          {"type": "case_study", "title": "The wire that almost went to the fraudster", "scenario": "Devon's controller emails the apprentice with updated wire instructions for the firm's quarterly distribution — different routing and account numbers than the prior quarter. The email looks legitimate, comes from the controller's known email address. The apprentice does not initiate the wire. Instead, calls the controller's direct office line (not the number in the email). The controller picks up — and is surprised. He never sent that email. His email had been compromised. The wire instructions in the email were fraudulent — the destination account belonged to a fraud ring. The apprentice's verification call stopped a $185,000 wire to criminals.", "discussion": "Email-based wire fraud is one of the largest current threat patterns. The protocol of verbally verifying any wire instruction change via known phone numbers is not paranoia. It is the industry standard for a reason. The five-minute call is worth it every single time."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Operational Risk in Account Administration",
        "summary": "Account administration is operational work, and operational work has its own risks. Knowing where errors and fraud typically arise lets you control them.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The most expensive failures in retail advisory operations are usually not investment mistakes but operational ones — wrong account numbers, missing beneficiary updates, fraudulent wires, expired authorizations, mishandled distributions. The losses can be financial (the client loses money) or reputational (the firm loses trust) or regulatory (compliance failure becomes enforcement matter). Operational risk management is a discipline of identifying the failure modes and building processes that catch them before they cost."},
          {"type": "subheading", "content": "Common operational failure modes"},
          {"type": "list", "items": [
            "Beneficiary designations left stale through major life events (divorce, remarriage, death of designated beneficiary)",
            "Account titles not updated when the client's life circumstances change (single → married, individual → trust)",
            "Standing instructions running after they should have been terminated",
            "Authorization paperwork expired without renewal (some authorizations are time-limited)",
            "Custodial defaults left at suboptimal settings (FIFO cost basis on a taxable account, automatic DRIP on a position being managed for diversification)",
            "Linked external accounts no longer in use but still authorized for ACH",
            "Email-based fraud directing wires to fraudulent destinations",
            "Mistaken sending of personal information (PII) to wrong recipients",
            "Adviser personal trading conducted in violation of firm policy"
          ]},
          {"type": "subheading", "content": "The annual administrative review"},
          {"type": "paragraph", "content": "Once a year — typically at the annual review with the client or shortly before it — conduct an administrative review of every account in the household: titles and registrations match current circumstances; beneficiaries are current and percentages add to 100% for each category; standing instructions still appropriate; external bank account links still in use; cost basis method set correctly; insurance protections (FDIC sweep, SIPC limits) understood and appropriate. This review takes 15-20 minutes per household and catches dozens of small issues that compound over years."},
          {"type": "subheading", "content": "Process controls for the highest-risk operations"},
          {"type": "glossary", "terms": [
            {"term": "Two-person verification for large transfers", "definition": "Any wire over a firm-defined threshold (commonly $25K or $50K) requires verification by a second person before execution. Catches typos and detects social engineering."},
            {"term": "Call-back verification for new payment instructions", "definition": "Any new or changed payment instructions verified verbally with the client (not the email sender) using a known phone number. Industry standard for wire fraud prevention."},
            {"term": "Periodic beneficiary review", "definition": "Beneficiary designations reviewed at every annual client review and after every life event. Documented in the file."},
            {"term": "External account verification", "definition": "Linked external bank accounts re-verified annually; any not used in 12+ months are unlinked to reduce attack surface."},
            {"term": "Standing instruction expiration", "definition": "Time-limited standing instructions where appropriate, with automatic expiration prompting review and renewal."}
          ]},
          {"type": "subheading", "content": "Documentation as risk control"},
          {"type": "paragraph", "content": "Every administrative action — title change, beneficiary update, new authorization, standing instruction creation or termination — generates a record. The record protects the client (the change is what was intended) and protects the firm (we can prove what was authorized and when). Treat documentation as part of the action, not as paperwork after. The discipline from Module 17 extends to all administrative work."},
          {"type": "callout", "kind": "do", "content": "Every administrative change you make in a client account should generate (1) the actual change in the custodial system, (2) confirmation that the change took effect, (3) a record in the firm's CRM, and (4) communication to the client where appropriate. Submission is not completion; documentation is not optional."},
          {"type": "subheading", "content": "When something goes wrong"},
          {"type": "paragraph", "content": "When an operational error occurs — fraudulent wire, mishandled distribution, missing beneficiary — the response follows the same protocol as trade errors (Module 23): detect fast, disclose honestly, make the client whole, document, and improve the process. Operational errors are typically more visible to the client than investment errors (a wrong allocation might be invisible for years; a wrong wire shows up immediately). The transparency and speed of response defines the firm's character in these moments."},
          {"type": "case_study", "title": "The annual administrative review for Naomi", "scenario": "At Naomi's first annual review, the apprentice spends 20 minutes on administration in addition to the planning review. Findings: account titles current. Beneficiaries: primary beneficiary on Roth IRA still 'estate' (default from original opening — never updated). Contingent beneficiaries blank. The apprentice flags this immediately as the most important administrative item — updates Naomi's Roth IRA designations during the meeting (primary: her sister; contingent: her parents 50/50). External bank links: two old bank accounts linked from her prior employer's payroll, neither in current use — unlinked. Cost basis method: FIFO default on her taxable brokerage — switched to Specific Identification per Module 21 guidance. Standing instructions: monthly $1,500 to the Roth IRA, set up correctly. 20-minute review caught two material items and several smaller ones.", "discussion": "None of these were investment issues. All of them affect Naomi's outcomes. The beneficiary update alone could have been catastrophic in an unlikely-but-possible early-death scenario. The annual administrative review is what catches what the other reviews miss."},
          {"type": "callout", "kind": "key", "content": "Account administration is unglamorous, repetitive, detail-oriented work. It is also where the largest avoidable losses live. Build the systems and run them with discipline."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Reconciliation & Operations Controls — the broader operational discipline that account administration sits within."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "In a typical RIA setup, the advisor:", "options": ["Holds the client's assets directly", "Provides advice and manages the portfolio while the custodian holds the assets — the separation is a structural fraud protection", "Also serves as the custodian", "Has no role in trading"], "correct": 1, "explanation": "Separation of advice and custody is a structural protection against fraud. Statements come from the custodian, not the advisor. This separation was hardened industry-wide after Madoff."},
        {"id": "q2", "prompt": "SIPC protection covers:", "options": ["Market losses on investments", "Broker-dealer failure up to $500,000 per customer per separate capacity (with a $250,000 cash sublimit)", "All forms of fraud", "Bank deposit losses"], "correct": 1, "explanation": "SIPC restores securities and cash held by failed member broker-dealers. It explicitly does not protect against investment losses from market movements."},
        {"id": "q3", "prompt": "FDIC insurance applies to:", "options": ["Money market mutual funds", "Brokerage cash balances at all custodians", "Bank deposits at FDIC-insured banks up to $250,000 per depositor per insured bank per ownership category", "Cryptocurrency holdings"], "correct": 2, "explanation": "FDIC covers bank deposits (checking, savings, CDs, bank money market deposit accounts) up to the limit per ownership category. Money market mutual funds are not FDIC-insured."},
        {"id": "q4", "prompt": "JTWROS (Joint Tenants with Rights of Survivorship) means:", "options": ["Each owner has a specified percentage that passes through their own estate", "Two owners with equal rights; at first owner's death, the account passes automatically to the surviving owner outside probate", "Property is community-owned by spouses", "The account is held in trust"], "correct": 1, "explanation": "JTWROS includes automatic survivorship — most common between spouses. Differs from Tenants in Common, where each owner's share passes through their own estate."},
        {"id": "q5", "prompt": "When wire instructions arrive by email — even from a known counterparty — the proper protocol is to:", "options": ["Initiate the wire immediately to maintain efficiency", "Verbally verify by phone using a previously-known number before initiating, regardless of how legitimate the email appears", "Reply to the email asking for confirmation", "Forward to compliance for approval"], "correct": 1, "explanation": "Email-based wire fraud is a leading current threat pattern. Verbal verification on a known number catches social engineering attacks that visual inspection of the email does not."},
        {"id": "q6", "prompt": "A Transfer-on-Death (TOD) designation on a brokerage account:", "options": ["Eliminates estate tax on the assets", "Names a beneficiary who receives the account directly at death, bypassing probate, superseding the will for those specific assets", "Requires court approval", "Cannot be changed once established"], "correct": 1, "explanation": "TOD is a probate-avoidance tool. It does not avoid estate tax, and it supersedes the will for those assets — so it must be coordinated with the overall estate plan."},
        {"id": "q7", "prompt": "A revocable living trust that names the grantor as trustee, with an account titled in the trust's name, is treated for tax purposes during the grantor's lifetime as:", "options": ["A separate tax entity with its own EIN and return", "The grantor's own account, taxed as theirs", "Tax-exempt", "An IRA"], "correct": 1, "explanation": "Revocable trusts are 'grantor trusts' for the grantor's lifetime — all income flows through to the grantor's individual return. After death the trust may become irrevocable and a separate tax entity."},
        {"id": "q8", "prompt": "ACH transfers between bank accounts are typically:", "options": ["Same-day, irreversible", "1-3 business days, reversible within a window, free at most custodians", "Free but only available for accounts under $10,000", "Faster than wires"], "correct": 1, "explanation": "ACH is the workhorse of routine money movement — slower than wires but reversible (within a window) and typically free."},
        {"id": "q9", "prompt": "Bernie Madoff's fraud was made possible partly because:", "options": ["He used licensed custodians", "He ran both the advisory firm and custody operations, allowing fabricated statements", "He was a fee-only advisor", "He invested only in ETFs"], "correct": 1, "explanation": "The lack of independent custody let Madoff produce statements showing assets that did not exist. The industry response was structural separation of custody from advice."},
        {"id": "q10", "prompt": "An annual administrative review of a client household should check, at minimum:", "options": ["Only the investment performance", "Account titles, beneficiaries, standing instructions, external account links, cost basis defaults, and applicable insurance protections", "Only the fees charged", "Only the tax situation"], "correct": 1, "explanation": "Administrative review is operational, not investment. Catching stale beneficiaries, expired authorizations, suboptimal defaults, and unused external account links prevents downstream problems."},
        {"id": "q11", "prompt": "Telling a client their investments are 'safe' or 'protected' is:", "options": ["Standard reassurance language", "A compliance and ethical issue because no investment is protected against market losses; precise language about specific insurance regimes is required", "Required by SEC rules", "Appropriate for conservative portfolios"], "correct": 1, "explanation": "Blanket safety language is misleading. SIPC and FDIC cover specific failures, not market losses; bad advice is a separate remedy path. Be precise about what each covers."},
        {"id": "q12", "prompt": "An estate plan with a revocable living trust where the brokerage account is still titled in the individual's name (never re-titled into the trust) means:", "options": ["The trust still controls the account", "The trust is funded automatically at death", "The account is not in the trust and will pass through probate via the will, not the trust", "Nothing — there is no difference"], "correct": 2, "explanation": "Trust funding requires actual re-titling of assets. A trust document without re-titled assets is a paper exercise; the assets pass through the probate process under the will."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 26;
