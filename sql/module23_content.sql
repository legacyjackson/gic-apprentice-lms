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
