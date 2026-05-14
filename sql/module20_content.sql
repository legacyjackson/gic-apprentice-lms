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
where module_number = 20;
