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
