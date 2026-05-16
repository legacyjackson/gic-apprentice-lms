-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 9–16
-- Aligned to GIC Work Process titles and practical on-the-job tasks.
-- ============================================================================

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Understanding Risk — Three Numbers, Not One",
      "summary": "Suitability depends on three distinct risk concepts. Confusing them is the most common error in risk assessment.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client has three different 'risk numbers,' and they rarely align perfectly. The advisor's job is to understand all three, surface the conflicts, and make a defensible suitability determination that serves the client's actual situation — not just what they said they want." },
        { "type": "glossary", "terms": [
          { "term": "Risk capacity", "definition": "The financial ability to absorb investment losses without jeopardizing financial goals. Determined by income, assets, time horizon, and obligations. Objective." },
          { "term": "Risk tolerance", "definition": "The psychological comfort with investment volatility and potential loss. Highly subjective. Changes with market conditions and life circumstances." },
          { "term": "Required return", "definition": "The return rate needed to achieve the client's stated goals given their savings rate and time horizon. Mathematically derived. Sets a floor for risk." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The conflict that must be resolved", "text": "A client who says 'I want to be conservative' (tolerance) but needs 8% returns to fund retirement (required return) is not actually able to be conservative. The advisor must surface this conflict and help the client make an informed choice — not simply document the stated preference and ignore the math." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Administering the Risk Questionnaire",
      "summary": "The questionnaire is a tool, not a compliance form. How you conduct it determines how useful the results are.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The risk questionnaire is the most commonly administered tool in financial services and the most commonly misused. When administered as a form-filling exercise, it produces compliance documentation. When administered as a structured conversation, it produces genuine insight into how a client thinks about risk." },
        { "type": "heading", "text": "How to administer the questionnaire effectively" },
        { "type": "numbered", "items": [
          "Explain the purpose: 'This helps us understand how you think about investment risk so we can build a portfolio that fits you — not just your financial situation, but your comfort level.'",
          "Read each question aloud rather than handing the form to the client.",
          "Ask follow-up questions when answers seem inconsistent or extreme: 'You said you'd be comfortable with a 30% drop — can you tell me what that would feel like in practice?'",
          "Note where the client hesitates or changes their answer.",
          "Document not just the answers but your observations about the quality of the responses."
        ]},
        { "type": "callout", "kind": "warn", "title": "Red flag answers to investigate", "text": "'I've never lost money in the market' — may indicate limited investment experience. 'I don't care about risk, I just want to make money' — may not understand what risk means. 'My last advisor put me in something conservative' — may be guiding answers based on past experience rather than current reality. Each of these requires a follow-up conversation." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Interpreting Risk Results and Handling Conflicts",
      "summary": "What to do when the questionnaire result and the client's situation don't match.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The questionnaire produces a risk category — conservative, moderate, aggressive. This is the starting point, not the conclusion. The next step is comparing the questionnaire result to the client's financial situation, their goals, and their required return to identify any conflicts." },
        { "type": "case_study", "title": "The Conflict Resolution Conversation", "scenario": "A 55-year-old client with $300,000 in savings scores 'conservative' on the risk questionnaire. They want to retire at 65 with $5,000/month in income and have a $2,800/month Social Security benefit confirmed. The gap ($2,200/month) requires withdrawals of about $264,000/year from a projected portfolio — far more than conservative growth would support.", "discussion": "This is not a conservative situation. The math requires growth. The advisor must have a direct conversation: 'Based on your retirement goals and your current savings, a fully conservative portfolio is unlikely to produce the income you need. Here is what a conservative portfolio would produce — and here is the gap. We have three options: accept more investment risk, save more, or adjust the retirement goal. Which of these are you willing to explore?'" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting Suitability Determinations",
      "summary": "The documentation must stand on its own — a regulator should be able to read it and understand why the recommendation was suitable.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The suitability determination is not just a questionnaire result filed in the client folder. It is a documented professional judgment that connects the client's situation, goals, and risk profile to the investment recommendation. The documentation must show the reasoning — not just the conclusion." },
        { "type": "list", "items": [
          "Client's investment objective and time horizon",
          "Questionnaire results and risk category",
          "Any conflicts identified and how they were resolved",
          "The investment recommendation and the rationale",
          "Client's acknowledgment of the recommendation and any concerns expressed"
        ]},
        { "type": "callout", "kind": "do", "title": "The documentation test", "text": "If a regulator reads the suitability documentation three years from now, can they understand why this recommendation was suitable for this client at this time? If the answer is yes, the documentation is adequate. If it just says 'client scored moderate, recommended balanced portfolio,' the documentation is insufficient." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Ongoing Suitability and Reassessment",
      "summary": "Suitability is not a one-time event. Life changes — and the portfolio must change with it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A suitability determination is current as of the date it was made. When a client's circumstances change — job loss, inheritance, divorce, approaching retirement, health event — the suitability determination must be revisited." },
        { "type": "list", "items": [
          "Major life events: marriage, divorce, death of a spouse, birth of a child",
          "Significant financial changes: job loss, inheritance, major debt, retirement",
          "Health changes that affect life expectancy or care costs",
          "Market events that have dramatically changed portfolio value relative to goals",
          "Changes in time horizon as retirement approaches"
        ]},
        { "type": "callout", "kind": "key", "title": "The annual review as a suitability check", "text": "Every annual review meeting should include a suitability check: 'Has your financial situation, goals, or risk tolerance changed in the past year?' The answer to this question determines whether the current investment strategy remains appropriate — and must be documented." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the difference between risk capacity and risk tolerance?", "options": ["Risk capacity is the financial ability to absorb losses (objective); risk tolerance is the psychological comfort with volatility (subjective)", "Risk capacity is determined by age; risk tolerance is determined by income", "Risk capacity applies to stocks; risk tolerance applies to bonds", "They are different terms for the same concept"], "correct": 0, "explanation": "Risk capacity is objective — it's about what the financial situation can absorb. Risk tolerance is subjective — it's about what the client can emotionally handle. Both must be assessed." },
      { "id": "q2", "text": "A client scores 'conservative' on the risk questionnaire but their retirement goals require an 8% return. What should the advisor do?", "options": ["Surface the conflict and present three options: accept more risk, save more, or adjust the retirement goal", "Default to the questionnaire result and document 'conservative' strategy", "Recommend a moderate strategy as a compromise without further discussion", "Refer the client to a different advisor who specializes in conservative portfolios"], "correct": 0, "explanation": "The questionnaire result is a starting point, not the conclusion. When it conflicts with the required return, the advisor must have an honest conversation about the tradeoffs." },
      { "id": "q3", "text": "When a client says 'I've never lost money in the market' during a risk questionnaire, what is the best response?", "options": ["Ask a follow-up question to understand their investment history and whether they have experience with a significant market decline", "Accept the statement and note their conservative orientation", "Explain that all investments carry risk as a required disclosure", "Move on to the next question to avoid making the client uncomfortable"], "correct": 0, "explanation": "This statement is a red flag that may indicate limited investment experience. A follow-up question explores whether the client truly understands investment risk or has simply been fortunate." },
      { "id": "q4", "text": "What is 'required return' in the context of risk assessment?", "options": ["The return rate needed to achieve the client's goals given their current savings rate and time horizon", "The minimum return required by the client's employment contract", "The benchmark return for the client's industry sector", "The return rate needed to outperform inflation"], "correct": 0, "explanation": "Required return is mathematically derived from the client's savings, time horizon, and goals. It sets a floor below which the investment strategy cannot fall without jeopardizing the goals." },
      { "id": "q5", "text": "What must suitability documentation show beyond just the questionnaire result?", "options": ["The reasoning that connects the client's situation and risk profile to the specific investment recommendation", "The client's full financial history and account statements", "The advisor's credentials and professional background", "A comparison of the recommended strategy to all available alternatives"], "correct": 0, "explanation": "Documentation must show the reasoning, not just the conclusion. A regulator reading it should understand why this recommendation was suitable for this specific client at this specific time." },
      { "id": "q6", "text": "Which life event most clearly requires a suitability reassessment?", "options": ["A client receives a significant inheritance that doubles their investable assets", "A client changes their email address", "A client's portfolio performance exceeds its benchmark", "A client relocates to a different state"], "correct": 0, "explanation": "A significant inheritance changes risk capacity, goals, time horizon, and possibly required return — all core suitability factors. The existing strategy must be evaluated against the new situation." },
      { "id": "q7", "text": "Why should risk questionnaires be conducted as structured conversations rather than written forms?", "options": ["Conversational administration allows for follow-up questions on inconsistent or extreme answers that would be lost on a written form", "Written forms are not accepted as compliance documentation", "Clients complete written forms inaccurately when unsupervised", "Regulatory rules prohibit written risk questionnaires"], "correct": 0, "explanation": "When clients complete forms independently, hesitations, changes of mind, and inconsistencies are invisible. A structured conversation allows the advisor to observe and probe for genuine understanding." },
      { "id": "q8", "text": "At a minimum, how often should a client's suitability determination be reviewed?", "options": ["Annually at the scheduled review meeting, and additionally whenever a significant life event occurs", "Every five years as part of the planning cycle", "Only when the client requests a change", "When market conditions change significantly"], "correct": 0, "explanation": "Annual review is the minimum baseline. Life events — not market events — are the primary trigger for interim suitability reassessment." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 9;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Asset Allocation Actually Does",
      "summary": "Asset allocation is the primary driver of portfolio risk and return — more important than any individual investment selection.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A foundational study by Brinson, Hood, and Beebower found that asset allocation explains more than 90% of a portfolio's variability in return over time. Individual security selection and market timing account for the rest. This finding has been replicated many times. The implication for advisors: getting the allocation right matters far more than picking the right stocks." },
        { "type": "heading", "text": "The core asset classes" },
        { "type": "glossary", "terms": [
          { "term": "Equities (stocks)", "definition": "Ownership stakes in businesses. Historically highest long-term return among major asset classes. Also highest volatility. Appropriate for long time horizons." },
          { "term": "Fixed income (bonds)", "definition": "Loans to governments or corporations that pay interest. Lower expected return than equities, lower volatility. Income-producing. Reduces portfolio volatility when combined with equities." },
          { "term": "Cash and equivalents", "definition": "Money market, CDs, T-bills. Lowest return, zero credit risk, highest liquidity. Used for short-term needs and as a stability buffer, not for growth." },
          { "term": "Alternative investments", "definition": "Real estate, commodities, private equity, hedge funds. May provide diversification benefits but often have liquidity constraints, higher costs, and complexity." }
        ]},
        { "type": "callout", "kind": "key", "title": "The allocation decision is the most important investment decision", "text": "Whether a client is 80% in equities or 40% in equities determines more about their portfolio's behavior than any other choice. This decision must be tied directly to the suitability assessment — risk capacity, risk tolerance, time horizon, and required return — not to market opinion." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Building an Allocation Model",
      "summary": "How to move from a risk profile to a concrete allocation target.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most advisory firms use model portfolios: pre-built allocation targets for different risk categories. The process is to match the client to the appropriate model, then populate the model with specific funds or securities. Understanding how models are built helps you apply them correctly." },
        { "type": "heading", "text": "Sub-asset class diversification" },
        { "type": "list", "items": [
          "<strong>Within equities:</strong> domestic vs. international, large cap vs. small cap, growth vs. value, sector allocation",
          "<strong>Within fixed income:</strong> government vs. corporate, investment grade vs. high yield, short-term vs. long-term, nominal vs. inflation-protected",
          "<strong>Geographic diversification:</strong> developed markets vs. emerging markets"
        ]},
        { "type": "callout", "kind": "warn", "title": "Over-diversification is also a problem", "text": "Owning 47 funds does not make a portfolio more diversified if those funds hold many of the same underlying securities. True diversification means exposure to genuinely uncorrelated asset classes — not simply owning more products." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Portfolio Drift and Rebalancing",
      "summary": "Markets move. Portfolios drift from their targets. Rebalancing restores the intended risk level.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A portfolio that starts at 60% equity and 40% fixed income will drift over time as equities and bonds produce different returns. After a strong equity market, the portfolio might be 75% equity — far more risk than the client's profile supports. Rebalancing restores the target allocation." },
        { "type": "heading", "text": "The rebalancing trigger decision" },
        { "type": "list", "items": [
          "<strong>Calendar rebalancing</strong> — rebalance at fixed intervals (quarterly, annually). Simple, predictable, low cost. May miss large drifts between intervals.",
          "<strong>Threshold rebalancing</strong> — rebalance when any asset class drifts beyond a set percentage (e.g., ±5% from target). More precise, potentially more trades.",
          "<strong>Hybrid approach</strong> — review quarterly but rebalance only when a threshold is exceeded. Most common in practice."
        ]},
        { "type": "callout", "kind": "key", "title": "Tax-aware rebalancing", "text": "In taxable accounts, selling appreciated positions to rebalance triggers capital gains. Tax-aware rebalancing uses four techniques: (1) redirect new contributions to underweight asset classes, (2) use dividends and interest to rebalance, (3) rebalance within tax-advantaged accounts first, (4) harvest losses to offset gains." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Updating Allocations for Life Changes",
      "summary": "A portfolio built for a 45-year-old is wrong for the same person at 62. Allocations must evolve.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Asset allocation is not set and forgotten. As clients age, approach retirement, or experience life changes, the appropriate allocation changes. The advisor's job is to identify when an allocation update is needed and execute it thoughtfully." },
        { "type": "list", "items": [
          "<strong>Approaching retirement (5-7 years out)</strong> — begin reducing equity allocation, increase fixed income and cash for near-term income",
          "<strong>At retirement</strong> — the portfolio shifts from accumulation to distribution mode; sequence-of-returns risk becomes primary concern",
          "<strong>After a job loss</strong> — liquidity becomes more critical; may need to reduce risk temporarily",
          "<strong>After an inheritance</strong> — reassess goals, time horizon, and required return; the allocation that fit before may not fit the new situation"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Allocation Decisions to Clients",
      "summary": "The best allocation in the world doesn't work if the client abandons it during a downturn.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client behavior is the biggest risk in portfolio management. Research consistently shows that the average investor earns significantly less than the funds they invest in — because they sell during downturns and buy during run-ups. The advisor's job is to build a portfolio the client can stick with, then help them stick with it." },
        { "type": "callout", "kind": "do", "title": "Set expectations before volatility, not during it", "text": "When allocating: 'A portfolio like this has historically declined 20-25% in a bad year. That translates to about $X in your specific account. When that happens — and it will happen at some point — our plan is to [stay the course/rebalance/add to equities]. I want you to know this in advance so it doesn't feel like a crisis when it happens.'" }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Research by Brinson, Hood, and Beebower found that asset allocation explains what percentage of portfolio return variability?", "options": ["More than 90%", "About 50%", "About 70%", "About 30%"], "correct": 0, "explanation": "The landmark study found that asset allocation — not security selection or market timing — explains the majority of a portfolio's return variability over time." },
      { "id": "q2", "text": "A portfolio that started at 60% equity has grown to 75% equity after a strong market. What is required?", "options": ["Rebalancing to restore the target allocation and the intended risk level", "Increasing the client's risk profile to match the new allocation", "No action, since equity gains are always in the client's interest", "Converting the gains to cash to lock in returns"], "correct": 0, "explanation": "Drift above the equity target means the portfolio carries more risk than the client's profile supports. Rebalancing restores the intended allocation." },
      { "id": "q3", "text": "Which rebalancing approach triggers a rebalance when any asset class drifts beyond a set percentage from target?", "options": ["Threshold rebalancing", "Calendar rebalancing", "Tactical rebalancing", "Strategic rebalancing"], "correct": 0, "explanation": "Threshold rebalancing triggers a rebalance when drift exceeds a specified tolerance band (e.g., ±5%). More precise than calendar rebalancing but potentially generates more trades." },
      { "id": "q4", "text": "What is the first and most tax-efficient technique for rebalancing a taxable portfolio?", "options": ["Redirect new contributions and dividends to underweight asset classes before selling anything", "Sell overweight positions and repurchase underweight positions simultaneously", "Transfer assets to a tax-advantaged account before rebalancing", "Harvest all capital losses before making any rebalancing trades"], "correct": 0, "explanation": "Redirecting cash inflows avoids triggering taxable events while gradually restoring balance. It is the lowest-cost, most tax-efficient rebalancing technique." },
      { "id": "q5", "text": "Why does owning 47 different funds not necessarily result in a diversified portfolio?", "options": ["Many funds may hold the same underlying securities, creating concentration despite the appearance of diversification", "Regulatory rules limit the number of funds in a diversified portfolio", "Each additional fund increases correlation, reducing diversification", "Fund of funds structures eliminate the diversification benefit"], "correct": 0, "explanation": "True diversification requires genuinely uncorrelated exposures. Many domestic equity funds hold the same large-cap stocks. Multiplying products does not multiply diversification." },
      { "id": "q6", "text": "When should an advisor begin reducing equity allocation for a client approaching retirement?", "options": ["5-7 years before the planned retirement date", "At the moment of retirement", "At age 65 regardless of planned retirement date", "Only when the client requests a more conservative approach"], "correct": 0, "explanation": "The glide path toward lower equity allocation should begin well before retirement to reduce sequence-of-returns risk — the danger of a major decline in the years immediately before or after retirement." },
      { "id": "q7", "text": "What does research on investor behavior show about actual investor returns compared to fund returns?", "options": ["The average investor earns significantly less than the funds they invest in due to buying high and selling low", "Investors who actively trade consistently outperform buy-and-hold investors", "Average investors approximately match fund returns over long periods", "Active traders earn the same returns as passive investors after fees"], "correct": 0, "explanation": "Investor behavior — selling during downturns and buying during run-ups — systematically produces returns below the funds themselves. This behavior gap is one of the most well-documented findings in behavioral finance." },
      { "id": "q8", "text": "What is the best time to discuss expected portfolio volatility with a client?", "options": ["When allocating — before volatility occurs, not during a downturn when emotions are high", "During a market downturn when the discussion is most relevant", "At the annual review meeting every year", "Only when the client asks about it"], "correct": 0, "explanation": "Clients who have been told to expect a 20-25% decline react very differently than those who weren't. Pre-setting expectations prevents panic selling and keeps clients in their long-term strategy." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 10;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Stocks — Ownership, Return, and Risk",
      "summary": "What owning a stock actually means, how returns are generated, and where the risk comes from.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A stock is an ownership interest in a business. When you own a share of a company, you own a proportional claim on its earnings, assets, and future growth. This is fundamentally different from lending money (a bond) — you share in both the upside and the downside." },
        { "type": "glossary", "terms": [
          { "term": "Dividend", "definition": "A cash distribution from a company's earnings to shareholders. Not guaranteed and can be reduced or eliminated. Component of total return." },
          { "term": "Capital appreciation", "definition": "Increase in stock price over time. The other component of total return. Drives most of the long-term return for growth-oriented stocks." },
          { "term": "Market capitalization", "definition": "Total market value of a company's outstanding shares (share price × shares outstanding). Used to classify stocks as large cap, mid cap, or small cap." },
          { "term": "Price-to-earnings ratio (P/E)", "definition": "Stock price divided by earnings per share. A basic measure of valuation. Higher P/E = higher growth expectations or potential overvaluation." }
        ]},
        { "type": "callout", "kind": "key", "title": "Why equities belong in long-term portfolios", "text": "Over any 20-year rolling period in modern market history, the US equity market has produced positive real returns. Short-term volatility is the price of long-term growth. Clients who exit equities during downturns pay twice: once for the decline, and again by missing the recovery." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Bonds — How They Work and Why They Matter",
      "summary": "The mechanics of fixed income and why bonds behave differently from stocks.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A bond is a loan. The investor lends money to a government or corporation, which promises to pay interest (the coupon) at regular intervals and return the principal at maturity. Bonds provide income, reduce portfolio volatility, and serve as a counterweight to equities in a diversified portfolio." },
        { "type": "callout", "kind": "key", "title": "The most important bond concept: price and yield move inversely", "text": "When interest rates rise, existing bond prices fall — because bonds paying lower rates become less attractive than new bonds paying higher rates. When interest rates fall, existing bond prices rise. This is not intuitive to most clients. It is the source of most bond-related client confusion." },
        { "type": "glossary", "terms": [
          { "term": "Coupon", "definition": "The annual interest payment expressed as a percentage of face value. A $1,000 bond with a 4% coupon pays $40/year." },
          { "term": "Duration", "definition": "A measure of a bond's sensitivity to interest rate changes. Higher duration = higher price change for a given rate move. Long-term bonds have higher duration than short-term bonds." },
          { "term": "Credit rating", "definition": "An assessment of the issuer's ability to repay. Investment grade (BBB/Baa and above) vs. high yield/junk (BB/Ba and below). Lower rating = higher yield = higher default risk." },
          { "term": "Yield to maturity", "definition": "The total return if the bond is held to maturity, accounting for coupon payments and any difference between purchase price and face value." }
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Funds — ETFs vs. Mutual Funds",
      "summary": "The two dominant investment vehicles in most client portfolios. Know the real differences.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients invest in funds rather than individual securities. The two dominant structures are mutual funds and exchange-traded funds (ETFs). Understanding the structural differences helps advisors match the right vehicle to the client's needs." },
        { "type": "list", "items": [
          "<strong>Mutual funds:</strong> priced once daily at NAV; bought/sold directly from the fund company; may have minimum investments; may have sales loads; can be active or index-based",
          "<strong>ETFs:</strong> trade throughout the day like stocks; generally lower expense ratios; highly tax-efficient due to in-kind redemption mechanism; minimum purchase is one share; no sales loads"
        ]},
        { "type": "callout", "kind": "key", "title": "The expense ratio compounds relentlessly", "text": "A 1% difference in annual expense ratio costs $100,000 in a $1M portfolio over 30 years at 7% growth — the difference is approximately $760,000. The first question when evaluating any fund: what does it cost, and is the cost justified by what it provides?" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Reading the Fund Documents",
      "summary": "The prospectus, fact sheet, and performance report each tell a different part of the story.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every fund has required disclosures. The summary prospectus is the legally mandated document covering key fund facts. The fact sheet is the marketing-friendly summary. The annual report covers the full year's activity. Know which document answers which question." },
        { "type": "list", "items": [
          "<strong>Expense ratio</strong> — what you pay annually as a percentage of assets. The most important single number in fund evaluation.",
          "<strong>Turnover ratio</strong> — how frequently the fund trades. High turnover = higher costs and potentially more taxable distributions.",
          "<strong>Benchmark</strong> — what index the fund is measured against. An actively managed small-cap fund should be compared to a small-cap index, not the S&P 500.",
          "<strong>Manager tenure</strong> — for active funds, how long the current management has been in place. A great 10-year record means less if the manager who produced it left 2 years ago.",
          "<strong>Performance in down markets</strong> — how the fund performed during the 2008-09 and 2020 downturns tells you more about risk than any up-market period."
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Comparing Products for a Client",
      "summary": "The comparison framework that leads to defensible, client-appropriate product recommendations.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every product comparison for a client should answer five questions: Does it fit the allocation target? What does it cost? How liquid is it? What are the tax implications? Is it suitable for this specific client?" },
        { "type": "activity", "title": "Product Comparison Exercise", "prompt": "Compare two large-cap equity funds for a 52-year-old client in a taxable account who values tax efficiency.", "steps": [
          "Fund A: Active large-cap growth mutual fund. Expense ratio 0.89%. Turnover 120%. 10-year return 11.2%. Tracks S&P 500 closely.",
          "Fund B: Large-cap index ETF. Expense ratio 0.03%. Turnover 4%. 10-year return 10.8%. Mirrors S&P 500.",
          "Calculate the cost difference over 10 years on $100,000 assuming 10% annual return.",
          "Explain why the turnover difference matters for a taxable account.",
          "Which fund is more appropriate for this client? Write a one-paragraph recommendation with rationale."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What are the two components of total return for a stock investor?", "options": ["Dividends and capital appreciation", "Coupon payments and face value return", "Expense ratio savings and index replication", "Rental income and property appreciation"], "correct": 0, "explanation": "Stocks generate return through dividends (income distributions) and capital appreciation (price increase). Both together constitute total return." },
      { "id": "q2", "text": "What happens to existing bond prices when interest rates rise?", "options": ["Bond prices fall because existing bonds paying lower rates become less attractive than new higher-rate bonds", "Bond prices rise because higher rates increase coupon payments", "Bond prices are unaffected by interest rate changes", "Bond prices temporarily fall then recover to face value"], "correct": 0, "explanation": "The inverse relationship between bond prices and interest rates is the foundational bond concept. Higher rates make existing lower-rate bonds less valuable." },
      { "id": "q3", "text": "A $1,000 face value bond with a 5% coupon pays how much in annual interest?", "options": ["$50 per year (5% × $1,000)", "$500 per year", "$50 total over the bond's life", "It depends on the current market interest rate"], "correct": 0, "explanation": "The coupon payment is the coupon rate multiplied by the face value. 5% × $1,000 = $50 per year, regardless of what the bond is trading at in the market." },
      { "id": "q4", "text": "What is the primary tax efficiency advantage of ETFs over mutual funds?", "options": ["ETF's in-kind redemption mechanism typically avoids distributing capital gains that mutual fund redemptions can trigger", "ETFs are exempt from capital gains tax under current law", "ETF dividends are taxed at a lower rate than mutual fund dividends", "ETFs have a lower expense ratio that reduces taxable income"], "correct": 0, "explanation": "When investors redeem mutual fund shares, the fund may sell securities and distribute capital gains to all remaining shareholders. ETFs redeem through in-kind exchanges with authorized participants, generally avoiding this taxable event." },
      { "id": "q5", "text": "Why does manager tenure matter when evaluating an actively managed fund?", "options": ["A strong long-term track record is less meaningful if the manager who produced it is no longer running the fund", "Longer-tenured managers have lower expense ratios", "Manager tenure determines the fund's risk category", "Regulatory rules require a minimum manager tenure for fund qualification"], "correct": 0, "explanation": "Past performance is attributed to the team that produced it. If the fund manager who generated the 10-year track record left 2 years ago, the historical record has limited predictive value." },
      { "id": "q6", "text": "A 1% difference in annual expense ratio on a $1,000,000 portfolio growing at 7% annually results in approximately how much cost difference over 30 years?", "options": ["Approximately $760,000 in foregone portfolio value", "Approximately $10,000 per year in direct fees", "Approximately $300,000 total over 30 years", "The difference is negligible over long periods"], "correct": 0, "explanation": "The expense ratio reduces compounded growth every year. On a $1M portfolio at 7%, the difference between 0% and 1% annual fees compounds to approximately $760,000 over 30 years." },
      { "id": "q7", "text": "Why is a fund's performance during down markets more informative than its up-market performance?", "options": ["Down-market performance reveals how the fund manages risk, which is the more differentiating characteristic among otherwise similar funds", "Regulators require down-market performance disclosure", "Down-market performance is more accurately measured than up-market performance", "All funds perform similarly during up markets"], "correct": 0, "explanation": "Many funds can perform well when markets are rising. How a fund performs during significant declines — 2008-09, 2020 — reveals its true risk characteristics and how clients will actually experience holding it." },
      { "id": "q8", "text": "A high portfolio turnover ratio in an actively managed fund held in a taxable account primarily indicates what risk?", "options": ["Higher likelihood of taxable capital gain distributions to all shareholders", "Higher probability of investment losses", "Lower diversification due to concentrated positions", "Greater vulnerability to interest rate changes"], "correct": 0, "explanation": "High turnover means frequent buying and selling, which generates realized gains that are distributed to all shareholders — even those who didn't sell. In a taxable account, this creates a tax liability the investor did not choose." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 11;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building a Market Monitoring Habit",
      "summary": "What to watch, how often, and how to distinguish signal from noise.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Market monitoring is a professional discipline, not a market-watching hobby. The goal is not to be aware of every headline — it is to track the economic and market factors that actually affect client portfolios and to identify when something material enough to act on has changed." },
        { "type": "heading", "text": "Key economic indicators to monitor" },
        { "type": "glossary", "terms": [
          { "term": "GDP growth rate", "definition": "Measures the rate of economic expansion or contraction. Sustained negative GDP growth signals recession. Released quarterly." },
          { "term": "CPI (Consumer Price Index)", "definition": "Measures inflation. Rising inflation typically leads to higher interest rates, which affect both stocks and bonds. Released monthly." },
          { "term": "Unemployment rate", "definition": "Measures labor market health. Low unemployment supports consumer spending. Very low unemployment can signal inflationary pressure." },
          { "term": "Federal Funds Rate", "definition": "The interest rate the Federal Reserve sets for overnight lending between banks. The primary policy lever affecting borrowing costs throughout the economy." },
          { "term": "Yield curve", "definition": "The spread between short-term and long-term Treasury yields. An inverted yield curve (short rates > long rates) has preceded most recessions." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The noise problem", "text": "Financial media generates daily content. Most of it is noise — information that does not affect client portfolios or planning decisions. Your discipline is to identify the signal: actual changes in economic conditions that warrant a portfolio review or client communication." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Monitoring Portfolio Performance",
      "summary": "How to access performance data, identify what is driving results, and recognize when action is needed.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance monitoring is not watching the market — it is watching your clients' actual portfolios relative to their goals and their benchmarks. These are different activities. A portfolio that is down 5% in a quarter is a problem or it is not, depending entirely on what the market did and what the client's benchmark returned." },
        { "type": "list", "items": [
          "Access the portfolio management system daily for accounts with significant activity or special monitoring requirements",
          "Review performance reports at each quarter end: absolute return, benchmark comparison, attribution",
          "Flag accounts where the portfolio has drifted beyond the rebalancing threshold",
          "Identify positions that have declined significantly relative to peers or benchmark",
          "Note any accounts approaching withdrawal needs where cash positioning may need to be reviewed"
        ]},
        { "type": "activity", "title": "Performance Review Exercise", "prompt": "Review this hypothetical portfolio performance scenario and prepare the advisor brief.", "steps": [
          "Q3 portfolio return: +4.2%. Benchmark (60/40 blend): +5.8%. Difference: -1.6%.",
          "Identify whether this is a meaningful underperformance or within normal range.",
          "Equity component returned +6.1% vs. equity benchmark +7.4%. Fixed income returned +0.8% vs. +2.1%.",
          "Which component drove the underperformance? What additional information would you need to determine why?",
          "Write a two-paragraph advisor brief explaining the performance in terms suitable for a client conversation."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Review Trigger System",
      "summary": "Building a systematic approach to knowing when to act — and when to hold steady.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The discipline of market monitoring is not just watching — it is knowing what you are watching for and having a clear framework for what triggers action. Without this framework, monitoring either becomes reactive panic or passive inaction." },
        { "type": "list", "items": [
          "<strong>Allocation drift trigger</strong> — any asset class has moved beyond the rebalancing threshold",
          "<strong>Underperformance trigger</strong> — a position has meaningfully underperformed its category benchmark for 3+ consecutive quarters",
          "<strong>Client life event trigger</strong> — a client has experienced a major life change that affects suitability",
          "<strong>Market structural change</strong> — an event material enough to warrant reviewing planning assumptions (rate regime change, recession confirmation)"
        ]},
        { "type": "callout", "kind": "key", "title": "Do NOT trigger on", "text": "Daily market fluctuations. A down month. A single weak earnings report. Media predictions. These are noise. Trading on noise increases costs and reduces returns. The trigger system exists to filter out the noise and respond only to genuine signals." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Preparing a Market Update for Clients",
      "summary": "The one-page format that informs without alarming and demonstrates professional competence.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A client market update serves two purposes: keeping clients informed and preventing panic-driven decisions. Done well, it demonstrates the advisor's knowledge and reassures clients that someone is watching their portfolio. Done poorly, it amplifies fear or comes across as marketing." },
        { "type": "list", "items": [
          "<strong>What happened</strong> — 2-3 sentences on the most significant market events of the period",
          "<strong>What it means for clients</strong> — how this affected the types of portfolios your clients hold",
          "<strong>What we are doing (if anything)</strong> — specific to actual portfolio actions, not vague reassurance",
          "<strong>What to watch next</strong> — the one or two factors most relevant to the outlook"
        ]},
        { "type": "callout", "kind": "warn", "title": "Language to avoid in market communications", "text": "'Don't panic' — plants the idea of panic. 'The markets are volatile' — states the obvious without adding value. 'We believe the market will recover' — an opinion, not a commitment. 'This is a buying opportunity' — may not be true and creates liability." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Communicating Performance to Clients",
      "summary": "How to present a down quarter without losing client confidence — and how to present an up quarter without setting unrealistic expectations.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance communication is the moment when theory meets emotion. Clients may intellectually understand that portfolios fluctuate, but when they see their account down $40,000, the intellectual understanding evaporates. Your role is to reframe the loss in context and reinforce the long-term plan." },
        { "type": "callout", "kind": "do", "title": "The context framework for down periods", "text": "Three questions to answer: (1) What did the market do? (Their portfolio decline in context.) (2) Did the portfolio do what it was supposed to do relative to its benchmark? (3) Has anything changed that warrants revising the plan? If the answers are 'similar to the market,' 'yes,' and 'no' — the message is: this is the portfolio behaving normally. Stay the course." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "An inverted yield curve (short-term rates higher than long-term rates) is historically associated with what economic signal?", "options": ["Recession — it has preceded most US recessions in modern economic history", "Rapid economic growth", "High inflation", "A Federal Reserve rate cut"], "correct": 0, "explanation": "An inverted yield curve signals that the market expects economic slowdown. It has preceded most US recessions in the post-war era, making it one of the most closely watched economic indicators." },
      { "id": "q2", "text": "A portfolio returned +4.2% while its benchmark returned +5.8%. How should this be characterized?", "options": ["Underperformance of 1.6% relative to benchmark — context determines whether this is meaningful", "Outperformance, because the absolute return was positive", "Unacceptable performance that requires immediate portfolio changes", "In-line performance within normal variance"], "correct": 0, "explanation": "Benchmark-relative performance of -1.6% means the portfolio underperformed. Whether this is meaningful depends on the time period, the components driving it, and whether it is within the normal range for the portfolio type." },
      { "id": "q3", "text": "Which of the following should NOT trigger a portfolio review action?", "options": ["A single bad week in equity markets driven by a one-time news event", "Allocation drift beyond the rebalancing threshold", "Three consecutive quarters of meaningful benchmark underperformance", "A client's approaching retirement that changes their cash flow needs"], "correct": 0, "explanation": "Daily and weekly market fluctuations are noise. Portfolio reviews should be triggered by structural changes: drift, sustained underperformance, or client circumstances — not short-term volatility." },
      { "id": "q4", "text": "What is the primary purpose of a client market update communication?", "options": ["Keeping clients informed and preventing panic-driven decisions by providing professional context", "Demonstrating the advisor's investment prediction capabilities", "Meeting the quarterly reporting requirement", "Explaining every transaction made in the client's portfolio"], "correct": 0, "explanation": "Market updates serve clients by providing context that prevents emotional decision-making. They reinforce the long-term plan and demonstrate that the advisor is attentive." },
      { "id": "q5", "text": "When presenting a down quarter to a client, what three questions provide the most useful context?", "options": ["What did the market do? Did the portfolio perform as expected vs. benchmark? Has anything changed that warrants revising the plan?", "What was the portfolio return? What should the return have been? When will it recover?", "Why did the market decline? When will it recover? What should we sell?", "What positions caused the decline? Should we reduce equity exposure? Is this the advisor's fault?"], "correct": 0, "explanation": "These three questions frame down-market performance in context: relative to the market, relative to the benchmark, and relative to the long-term plan. They answer the client's real question: 'Is this a problem?'" },
      { "id": "q6", "text": "Why should the phrase 'don't panic' be avoided in client market communications?", "options": ["It plants the idea of panic in the client's mind, potentially increasing rather than reducing anxiety", "It implies the advisor is panicking", "It is not allowed in regulated client communications", "It is overused and therefore ineffective"], "correct": 0, "explanation": "Telling someone not to panic introduces the concept of panic. More effective language focuses on context and the plan: 'This is the portfolio behaving as designed.' 'Our strategy accounts for periods like this.'" },
      { "id": "q7", "text": "What does a high CPI reading typically signal for fixed income portfolios?", "options": ["Potential for rising interest rates, which would cause bond prices to decline", "Higher coupon payments on existing bonds", "Reduced volatility in bond portfolios", "Improved credit quality across bond issuers"], "correct": 0, "explanation": "High inflation typically leads the Federal Reserve to raise interest rates. Higher interest rates cause existing bond prices to fall, creating losses in fixed income portfolios." },
      { "id": "q8", "text": "In a market update, what is the most important thing to clarify when describing what the firm is doing in response to market conditions?", "options": ["Be specific about actual portfolio actions taken, rather than vague reassurances like 'we are monitoring closely'", "Emphasize that the firm predicted the market conditions in advance", "Focus on future market predictions and expected recovery timelines", "List all the funds in the portfolio and their individual performance"], "correct": 0, "explanation": "Specific actions (rebalanced to target allocation, added to fixed income) demonstrate professional engagement. Vague language like 'monitoring closely' communicates nothing and erodes confidence." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 12;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Makes Research Credible",
      "summary": "Not all research is equal. Learn to evaluate sources before using their conclusions.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial research ranges from rigorous academic work to thinly disguised product marketing. As an advisor associate preparing investment research summaries, your first job is to evaluate the source and identify any conflicts of interest before using a research conclusion." },
        { "type": "glossary", "terms": [
          { "term": "Sell-side research", "definition": "Research produced by investment banks and brokerage firms that sell securities. Potential conflict: researchers may be incentivized to rate stocks positively to support investment banking relationships." },
          { "term": "Buy-side research", "definition": "Research produced by investment managers for internal portfolio decision-making. Generally more objective; not published for public use." },
          { "term": "Independent research", "definition": "Research produced by firms with no investment banking or product sales relationship to the securities covered. Generally considered more objective." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The rating distribution problem", "text": "Studies consistently show that sell-side analysts issue far more Buy ratings than Sell ratings — typically 55-60% Buy, 35-40% Hold, and only 5-10% Sell. A Sell rating from a sell-side analyst is extremely rare and therefore highly meaningful. A Buy rating from the same source is nearly the baseline." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Gathering Research Efficiently",
      "summary": "The 30-minute research workflow that produces what you need without drowning in data.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Research efficiency is a professional skill. The goal is not to read everything — it is to find the most relevant, authoritative information on a specific question as quickly as possible. This requires knowing where to look and what to look for." },
        { "type": "list", "items": [
          "<strong>Morningstar</strong> — fund analysis, analyst ratings, portfolio X-ray, manager research. Best for fund evaluation.",
          "<strong>FactSet / Bloomberg</strong> — real-time data, earnings estimates, economic data. Best for securities research and market data.",
          "<strong>SEC EDGAR</strong> — company filings: 10-K (annual), 10-Q (quarterly), 8-K (material events), proxy. Primary source for company-level research.",
          "<strong>Federal Reserve</strong> — economic data, monetary policy statements, FOMC minutes. Primary source for macro and rate research.",
          "<strong>CFA Institute / academic journals</strong> — methodology and foundational research. Use for understanding concepts, not breaking news."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Research Summary Structure",
      "summary": "The format that produces actionable briefs advisors can actually use.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A research summary is a professional deliverable. Its job is to give an advisor the information they need to make a decision in five minutes, without requiring them to read everything you read. Structure it so the most important conclusions are immediately accessible." },
        { "type": "numbered", "items": [
          "<strong>Executive summary</strong> — two sentences. What is the conclusion and what does it mean for client portfolios?",
          "<strong>Key facts</strong> — the 3-5 most important data points. Sourced and dated.",
          "<strong>Investment thesis or risk</strong> — what is the opportunity or concern being described?",
          "<strong>Risks or counterarguments</strong> — what could be wrong? What would change the conclusion?",
          "<strong>Recommendation or implication</strong> — what should the advisor consider doing in response?"
        ]},
        { "type": "callout", "kind": "do", "title": "Verify before including", "text": "Every statistic, forecast, and data point in a research summary must be verifiable from the source you cite. Do not include numbers you cannot trace to a primary source. An inaccurate research brief is worse than no research brief." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Writing the Research Brief",
      "summary": "The professional voice and analytical discipline that distinguishes useful research from data dumps.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "There is a difference between summarizing research and analyzing it. A summary lists what was found. An analysis interprets what it means and draws conclusions. The research brief for an advisor should do both: tell them what the data shows and tell them what it means for their clients." },
        { "type": "callout", "kind": "key", "title": "The advisor audience", "text": "You are writing for someone who is intelligent, busy, and highly knowledgeable. They do not need you to explain what a P/E ratio is. They need you to tell them whether the current P/E of a specific sector is historically high, what that historically means, and whether it is relevant to portfolio decisions today." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Filing and Retrieval",
      "summary": "Research that cannot be found later was not worth doing.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment research files serve two purposes: supporting current decisions and documenting the basis for past decisions. Compliance examinations can ask why a specific holding was purchased or why a position was liquidated. The research file is your answer." },
        { "type": "list", "items": [
          "Name files clearly: date, subject, source (e.g., '2026-04-15_Q1_EconomicOutlook_FederalReserve')",
          "Organize by topic and date, not by when you produced the summary",
          "Keep source documents alongside your summaries",
          "Note the date research was gathered — stale research used as current is a compliance risk"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why is a 'Sell' rating from a sell-side analyst particularly noteworthy?", "options": ["Sell ratings are rare — typically less than 10% of all ratings — making them a stronger signal than the common Buy rating", "Sell ratings trigger automatic regulatory review", "Sell-side analysts are prohibited from issuing Sell ratings without special approval", "Sell ratings are only issued for securities the firm does not cover"], "correct": 0, "explanation": "Because sell-side analysts issue very few Sell ratings relative to Buy ratings, a Sell is a much stronger signal than typical. The base rate matters when interpreting research ratings." },
      { "id": "q2", "text": "For evaluating a mutual fund's performance history and analyst rating, which primary research source is most useful?", "options": ["Morningstar", "SEC EDGAR", "Federal Reserve publications", "Bloomberg earnings estimates"], "correct": 0, "explanation": "Morningstar specializes in fund analysis, ratings, and portfolio analytics. It is the primary resource for fund evaluation work." },
      { "id": "q3", "text": "In a research summary, what belongs in the executive summary section?", "options": ["Two sentences: the conclusion and what it means for client portfolios", "All key data points with sources", "A comprehensive review of all research gathered", "The risks and counterarguments to the main thesis"], "correct": 0, "explanation": "The executive summary must be immediately actionable. Two sentences: what the research shows and what it means. Advisors should be able to understand the bottom line without reading further." },
      { "id": "q4", "text": "What is the difference between summarizing research and analyzing it?", "options": ["A summary lists findings; an analysis interprets what the findings mean and draws conclusions relevant to decisions", "Summarizing is for clients; analyzing is for internal use only", "Summarizing requires citing sources; analyzing does not", "Analysis is only performed by senior advisors; associates summarize"], "correct": 0, "explanation": "The value of a research brief is in the analysis layer — the interpretation that converts raw data into actionable insight. A data dump without interpretation does not help the advisor make a decision." },
      { "id": "q5", "text": "For finding a company's annual report and quarterly filings, which source is most authoritative?", "options": ["SEC EDGAR — the official repository for all public company regulatory filings", "The company's investor relations website", "Financial news sources like Bloomberg or Reuters", "Morningstar's company analysis page"], "correct": 0, "explanation": "SEC EDGAR contains the official regulatory filings — 10-K, 10-Q, 8-K — that are the primary source documents for company-level research. Other sources summarize or comment on these filings." },
      { "id": "q6", "text": "Why must research files include the date the research was gathered?", "options": ["Stale research used as current is a compliance risk — market conditions change and old data can lead to poor decisions", "Regulatory rules require dating all research documents", "The advisor uses the date to determine the research fee", "SEC filing dates must match internal research dates"], "correct": 0, "explanation": "Research from six months ago may no longer reflect current conditions. Knowing when research was gathered allows users to evaluate its currency and avoid using outdated conclusions." },
      { "id": "q7", "text": "Which of the following describes the difference between sell-side and buy-side research?", "options": ["Sell-side is produced by banks/brokerages with potential conflicts; buy-side is produced by investment managers for internal use and is generally more objective", "Sell-side research is available for free; buy-side research is subscription-only", "Sell-side research covers stocks; buy-side research covers bonds", "Sell-side is more accurate; buy-side is more timely"], "correct": 0, "explanation": "The distinction is independence and conflict of interest. Sell-side firms may have investment banking relationships with the companies they cover. Buy-side research serves only the portfolio decision-making process." },
      { "id": "q8", "text": "What is the naming convention best practice for research files?", "options": ["Date, subject, and source — e.g., '2026-04-15_Q1_EconomicOutlook_FederalReserve'", "Subject only, in alphabetical order", "Sequential numbering assigned by the CRM system", "The advisor's initials followed by the topic"], "correct": 0, "explanation": "A naming convention that includes date, subject, and source allows research to be found quickly and confirms its currency and origin without opening the file." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 13;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Regulatory Framework You Work In",
      "summary": "Who regulates financial advisors, what they regulate, and why compliance exists.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial services is one of the most heavily regulated industries because the consequences of failures are severe — clients lose retirement savings, trust collapses, and the broader financial system can be damaged. Compliance is not bureaucratic friction — it is the institutional response to real harm that occurred when advisors operated without it." },
        { "type": "glossary", "terms": [
          { "term": "SEC (Securities and Exchange Commission)", "definition": "Federal agency that regulates registered investment advisors (RIAs) managing over $100 million in assets. Establishes the fiduciary standard for RIAs." },
          { "term": "FINRA (Financial Industry Regulatory Authority)", "definition": "Self-regulatory organization that oversees broker-dealers and their registered representatives. Applies the suitability standard." },
          { "term": "State regulators", "definition": "Regulate RIAs below the SEC threshold and other financial professionals. Requirements vary by state." },
          { "term": "Fiduciary standard", "definition": "The requirement to act in the client's best interest, not merely recommend something suitable. Applies to RIAs and their associated persons." }
        ]},
        { "type": "callout", "kind": "key", "title": "The personal liability question", "text": "Compliance failures are not just firm problems. Individual advisors and associates can face personal sanctions: fines, suspensions, and permanent bars from the industry. Understanding compliance requirements is self-protection as much as client protection." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Books and Records Requirements",
      "summary": "What must be retained, for how long, and in what format. The foundation of regulatory compliance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The SEC's books and records rules (Rule 204-2 under the Investment Advisers Act) require RIAs to maintain extensive records for specific time periods. These records exist so that regulators can reconstruct the firm's activities and client communications during any examination period." },
        { "type": "list", "items": [
          "<strong>Client agreements and contracts</strong> — five years from termination of the relationship",
          "<strong>Client communications</strong> — all written communications, including emails and texts — five years",
          "<strong>Performance records</strong> — the underlying data supporting any performance claims — five years",
          "<strong>Trade records</strong> — records of all securities transactions — five years",
          "<strong>Financial records</strong> — the firm's own financial statements — five years"
        ]},
        { "type": "callout", "kind": "warn", "title": "Electronic communication retention", "text": "Email, text messages, and any other business communication about client affairs is a business record. Using personal email or text for client communications is a compliance violation. If you communicate with a client through any channel, that communication must be retained. Most firms have specific policies — know yours." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "The Compliance Calendar",
      "summary": "The annual, quarterly, and personal compliance obligations every associate must know.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Compliance is not a single event — it is a continuous set of obligations with specific deadlines. Missing a compliance deadline is itself a compliance violation. Build the calendar into your workflow before you need it." },
        { "type": "list", "items": [
          "<strong>Annual (firm-level):</strong> Form ADV update filing (within 90 days of fiscal year end), annual compliance review, continuing education credits, annual privacy notice to clients",
          "<strong>Annual (personal):</strong> Complete required training modules, review and attest to compliance manual, outside business activity disclosure updates",
          "<strong>Quarterly:</strong> Personal securities transaction reporting, review of client account activity for supervisory purposes",
          "<strong>As needed:</strong> Pre-clearance for personal securities trades, outside business activity approvals, gift and entertainment reporting"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting Client Interactions for Compliance",
      "summary": "What 'it's in the file' actually means and the standard for documented advice.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every piece of advice given to a client should be traceable to a documented basis. Not because clients will sue you — though that is always possible — but because the documentation habit forces you to think clearly about why a recommendation is appropriate before making it." },
        { "type": "callout", "kind": "do", "title": "When to document immediately", "text": "When a client asks about a specific investment and you answer. When a client expresses a complaint or concern. When a recommendation is made that deviates from the model portfolio. When a client declines a recommendation. These moments create both the most value and the most risk. Documentation is how you protect both." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Handling Complaints and Exceptions",
      "summary": "The professional and compliant way to handle client complaints, errors, and exception requests.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Complaints and errors are inevitable in a financial advisory practice. They are not the end of the world — but how they are handled determines whether they become regulatory problems. The key is documentation and escalation, not defensiveness or concealment." },
        { "type": "list", "items": [
          "Log every complaint in the firm's complaint register, regardless of how minor it seems",
          "Notify the compliance department of any complaint that involves potential financial harm",
          "Never promise to resolve a complaint without compliance approval for the resolution",
          "Document errors as soon as they are discovered — do not wait to see if the client notices",
          "Follow the firm's error correction policy exactly — including supervisor approval for corrections"
        ]},
        { "type": "callout", "kind": "warn", "title": "The concealment trap", "text": "An advisor who tries to fix an error quietly — without documentation, without telling compliance — creates two problems: the original error and the cover-up. Regulators are far more lenient about disclosed errors corrected promptly than about undisclosed errors discovered in an examination." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Which regulatory body applies the fiduciary standard to registered investment advisors?", "options": ["The SEC (Securities and Exchange Commission)", "FINRA", "State insurance regulators", "The Federal Reserve"], "correct": 0, "explanation": "The SEC regulates RIAs and requires them to meet the fiduciary standard — acting in the client's best interest at all times." },
      { "id": "q2", "text": "Under SEC books and records rules, how long must a registered investment advisor retain client communications?", "options": ["Five years", "Two years", "Seven years", "Three years"], "correct": 0, "explanation": "Rule 204-2 under the Investment Advisers Act generally requires RIAs to retain books and records, including client communications, for five years." },
      { "id": "q3", "text": "Why is using personal email for client communications a compliance violation?", "options": ["Business communications with clients are required business records that must be retained — personal email typically cannot be captured by firm retention systems", "Personal email is less secure than firm email", "Clients prefer not to receive personal email from advisors", "The firm's email system provides better client service features"], "correct": 0, "explanation": "Books and records rules require retaining all business communications. Personal email channels are generally outside the firm's retention system, making compliance with this rule impossible." },
      { "id": "q4", "text": "When should a compliance complaint log entry be created?", "options": ["For every complaint, regardless of how minor it seems at the time", "Only for complaints that the client puts in writing", "Only for complaints that involve potential monetary damages", "After the compliance department has reviewed the situation"], "correct": 0, "explanation": "Every complaint must be logged. A complaint that seems minor today may become significant later. Selective logging creates compliance exposure." },
      { "id": "q5", "text": "What happens to an individual advisor who discovers an error and tries to correct it quietly without documentation or compliance notification?", "options": ["They create two problems: the original error and a concealment issue that may be treated more harshly than the error itself", "They demonstrate good judgment in resolving client issues efficiently", "They protect the firm from unnecessary regulatory attention", "They fulfill their duty to correct mistakes promptly"], "correct": 0, "explanation": "Concealment of errors is treated more seriously than the errors themselves. Prompt disclosure and correction, following the firm's procedures, is always the right path." },
      { "id": "q6", "text": "What is the annual compliance obligation that must be filed with the SEC within 90 days of fiscal year end?", "options": ["Form ADV update — the firm's registration document that discloses services, fees, conflicts, and disciplinary history", "Form CRS — the client relationship summary", "Form U4 — the individual registration form", "The firm's audited financial statements"], "correct": 0, "explanation": "Form ADV is the RIA's registration document. It must be updated annually and filed with the SEC. Clients must receive the updated ADV Part 2 annually." },
      { "id": "q7", "text": "When a client declines a recommendation made by the advisor, what should happen?", "options": ["The declination should be documented in the client file, noting the recommendation made and the client's decision to decline", "No documentation is needed since no transaction occurred", "The advisor should note it only if the recommendation involved securities", "The client should sign a waiver acknowledging the declination"], "correct": 0, "explanation": "Documenting declined recommendations protects the advisor. If a client later claims they were not given certain advice, the documentation establishes that the recommendation was made and the client chose not to follow it." },
      { "id": "q8", "text": "Personal securities transaction reporting by advisor associates is typically required on what basis?", "options": ["Quarterly, for all personal securities transactions in reportable accounts", "Annually only", "Only for transactions in securities the firm recommends to clients", "Only if the transaction involves securities in client portfolios"], "correct": 0, "explanation": "Most RIAs require associates to report personal securities transactions quarterly. This allows the compliance department to monitor for front-running and conflicts of interest." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 14;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Performance Measurement Fundamentals",
      "summary": "Two different return calculations, two different purposes. Know which one to use when.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance reporting requires using the right calculation for the right purpose. The two primary measures — time-weighted return and money-weighted return — tell different stories. Using the wrong one misleads clients and creates compliance risk." },
        { "type": "glossary", "terms": [
          { "term": "Time-weighted return (TWR)", "definition": "Measures the portfolio's return independently of the timing and size of cash flows. Shows how the investment strategy performed. Required for GIPS-compliant performance presentation. Comparable across managers." },
          { "term": "Money-weighted return (MWR / IRR)", "definition": "Accounts for the timing and size of client cash flows. Shows the individual client's actual return given when they added or withdrew money. Not comparable across managers." }
        ]},
        { "type": "callout", "kind": "key", "title": "Which return answers which question", "text": "TWR answers: 'How did the investment strategy perform?' MWR answers: 'What return did THIS CLIENT actually earn?' A client who invested a large amount at the market peak will have a different MWR than a client who invested the same amount before the peak — even though both experienced the same TWR." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Generating Performance Reports",
      "summary": "The step-by-step process for pulling accurate reports from the portfolio management system.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Performance reports must be generated consistently, using the same methodology each time, verified for accuracy before they reach the client. The process seems simple; the errors that creep in are not." },
        { "type": "numbered", "items": [
          "Log in to the portfolio management system and select the client account",
          "Choose the reporting period — quarter-end, year-end, or inception-to-date",
          "Select the appropriate benchmark — must match the account's investment strategy",
          "Generate the performance report",
          "Verify: check that account value on the report matches the custodian statement. Check that the benchmark selected matches the actual strategy. Check that the reporting period dates are correct.",
          "Flag any anomalies for resolution before sending"
        ]},
        { "type": "callout", "kind": "warn", "title": "The most common reporting error", "text": "Using the wrong benchmark. Comparing a 60/40 portfolio to the S&P 500 makes the portfolio look bad in strong equity markets and good in down markets — neither comparison is meaningful. Always confirm the benchmark matches the portfolio's actual strategy before finalizing the report." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Benchmarking Portfolio Performance",
      "summary": "What an appropriate benchmark is, why it matters, and how to explain it to clients.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A benchmark is the standard against which a portfolio's performance is measured. It must represent a realistic alternative to what the client is invested in — otherwise the comparison is meaningless or, worse, misleading." },
        { "type": "list", "items": [
          "A 100% US large-cap equity portfolio should be benchmarked against the S&P 500",
          "A 60/40 balanced portfolio should be benchmarked against a 60/40 blended index",
          "A global equity portfolio should be benchmarked against MSCI ACWI or similar",
          "A fixed income portfolio should be benchmarked against the Bloomberg US Aggregate Bond Index or appropriate subset"
        ]},
        { "type": "callout", "kind": "do", "title": "The benchmark explanation for clients", "text": "'The benchmark is the simplest, lowest-cost way to get the same type of exposure you have. If we're invested in US large-cap stocks, the S&P 500 index represents what you'd earn from just owning that market passively. Beating it means we added value. Trailing it means we need to understand why.'" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "The Performance Snapshot Format",
      "summary": "What belongs in a client-facing performance report — and what to leave out.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A client-facing performance snapshot is not a full accounting statement. It is a clear, readable summary of how the portfolio performed over specific periods. Its purpose is to inform, not to overwhelm." },
        { "type": "list", "items": [
          "<strong>Account value as of the report date</strong>",
          "<strong>Performance for the quarter, year-to-date, and trailing 1/3/5-year periods</strong>",
          "<strong>Benchmark return for each same period</strong>",
          "<strong>Beginning and ending value for the period with net contributions/withdrawals</strong>",
          "<strong>Asset allocation as of the report date</strong>"
        ]},
        { "type": "callout", "kind": "key", "title": "What to leave out", "text": "Individual position performance, individual lot details, detailed transaction history, internal rate of return calculations, hypothetical projections. These belong in the full accounting statement or in a separate advisor review, not in the client snapshot." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Performance in Context",
      "summary": "Performance means nothing without context. Here's how to provide it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A number without context is just a number. +8.2% means nothing unless you know what the benchmark returned, what the market environment was, and whether it is consistent with the portfolio's expected range of outcomes." },
        { "type": "callout", "kind": "do", "title": "The three-part performance narrative", "text": "1. What happened in the market: 'The first quarter was volatile — global equities declined 6% as interest rate concerns increased.' 2. How the portfolio performed in context: 'Your portfolio declined 4.8%, performing better than the benchmark, which fell 5.9%.' 3. Forward perspective: 'Nothing in the quarter changes our assessment of the strategy, and we remain positioned as agreed.'" }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Which return calculation is required for GIPS-compliant performance presentation and is comparable across investment managers?", "options": ["Time-weighted return (TWR)", "Money-weighted return (MWR)", "Simple return", "Annualized return"], "correct": 0, "explanation": "TWR eliminates the impact of cash flow timing and size, making it the appropriate measure for evaluating how an investment strategy performed. It is comparable across managers." },
      { "id": "q2", "text": "Two clients hold identical portfolios with identical TWRs, but different money-weighted returns. What explains this?", "options": ["They added or withdrew money at different times — the timing of cash flows affects MWR but not TWR", "They held the portfolio for different time periods", "One client paid higher advisory fees", "The portfolio management system calculated the returns differently"], "correct": 0, "explanation": "MWR is sensitive to the timing of contributions and withdrawals. A client who invested heavily before a decline will have a worse MWR than one who invested after the decline, even if the portfolio strategy was identical." },
      { "id": "q3", "text": "What is the most common performance reporting error?", "options": ["Using the wrong benchmark — comparing a balanced portfolio to the S&P 500", "Using quarterly rather than annual return periods", "Including withdrawals in the performance calculation", "Reporting net-of-fees returns without disclosing the fee"], "correct": 0, "explanation": "Benchmark selection is critical. Comparing a 60/40 portfolio to a 100% equity benchmark creates a misleading comparison in both up and down markets." },
      { "id": "q4", "text": "What is the appropriate benchmark for a portfolio that is 60% US equities and 40% US bonds?", "options": ["A blended benchmark of 60% S&P 500 / 40% Bloomberg US Aggregate Bond Index", "The S&P 500 alone", "The Bloomberg US Aggregate Bond Index alone", "The Dow Jones Industrial Average"], "correct": 0, "explanation": "The benchmark must reflect the portfolio's actual strategy. A 60/40 portfolio requires a 60/40 blended benchmark to make the performance comparison meaningful." },
      { "id": "q5", "text": "Before delivering a performance report to a client, what verification steps must be completed?", "options": ["Confirm account value matches custodian statement, verify benchmark matches actual strategy, verify reporting period dates are correct", "Verify the report was generated by a licensed associate", "Confirm the client has reviewed the disclosures", "Send the report to compliance for pre-approval"], "correct": 0, "explanation": "These three verification steps catch the most common reporting errors. An inaccurate performance report creates compliance risk and damages client trust." },
      { "id": "q6", "text": "What information belongs in a client performance snapshot?", "options": ["Account value, quarterly and YTD returns, benchmark comparison, asset allocation — simple and readable", "Every individual position's purchase price, current value, and unrealized gain/loss", "A detailed transaction history for the reporting period", "Hypothetical future projections based on current performance"], "correct": 0, "explanation": "The performance snapshot serves clients who want to understand how their portfolio did. Excessive detail obscures the key information and reduces the document's utility." },
      { "id": "q7", "text": "A portfolio returned +8.2% while its benchmark returned +5.8%. How should this be described in a client communication?", "options": ["The portfolio outperformed its benchmark by 2.4 percentage points during the period", "The portfolio doubled the benchmark return", "The portfolio was up 8.2% while the market was up 5.8%", "Both options 1 and 3 are acceptable"], "correct": 0, "explanation": "Outperformance in absolute terms (2.4 percentage points above benchmark) is the precise, professional way to describe benchmark-relative performance. 'Doubled the benchmark' is imprecise and potentially misleading." },
      { "id": "q8", "text": "When presenting a quarter where the portfolio was down 4.8% against a benchmark down 5.9%, what is the key message?", "options": ["The portfolio declined less than its benchmark, demonstrating relative outperformance during a difficult market", "The portfolio lost money and the strategy needs to be reconsidered", "The portfolio's absolute loss is the primary metric to focus on", "The benchmark decline makes the portfolio's decline acceptable"], "correct": 0, "explanation": "Context is everything in performance communication. A portfolio that declines 4.8% when its benchmark declines 5.9% has performed well in relative terms. The client needs to understand that the comparison makes a loss meaningful, not just uncomfortable." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 15;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Chart of Accounts — Structure and Purpose",
      "summary": "The organizational framework that makes every financial record legible and every report accurate.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The chart of accounts is the master list of every account the firm uses to record its financial activity. It is the foundation of the accounting system — without it, financial records have no consistent structure, reports cannot be produced, and audits become nightmares." },
        { "type": "glossary", "terms": [
          { "term": "Asset accounts", "definition": "Resources the firm owns: cash, accounts receivable, prepaid expenses, equipment. Numbered in the 1000s in most systems." },
          { "term": "Liability accounts", "definition": "Obligations the firm owes: accounts payable, accrued expenses, deferred revenue. Numbered in the 2000s." },
          { "term": "Equity accounts", "definition": "The owners' interest in the firm: paid-in capital, retained earnings. Numbered in the 3000s." },
          { "term": "Revenue accounts", "definition": "Income sources: advisory fees, financial planning fees. Numbered in the 4000s." },
          { "term": "Expense accounts", "definition": "Costs of operating the business: salaries, rent, technology, marketing, professional services. Numbered in the 5000s+." }
        ]},
        { "type": "callout", "kind": "key", "title": "Why classification accuracy matters", "text": "Every transaction must be classified correctly when entered. A misclassified expense reduces the accuracy of the income statement and can affect tax reporting. A misclassified asset overstates the firm's financial position. The chart of accounts is only useful if transactions are coded to it correctly and consistently." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Transaction Classification",
      "summary": "Correctly categorizing every financial transaction — the discipline that makes everything else work.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every financial transaction must be assigned to the correct account in the chart of accounts when it is recorded. Getting this right requires understanding both the account structure and the nature of each transaction." },
        { "type": "list", "items": [
          "<strong>Advisory fee income</strong> — Revenue: Advisory fees (4100). Received from custodian or client, recorded as earned.",
          "<strong>Employee salaries</strong> — Expense: Compensation (5100). Recorded at the time the payroll obligation is incurred.",
          "<strong>Software subscriptions</strong> — Expense: Technology (5300). Monthly prepaid amounts may need to be amortized.",
          "<strong>Client entertaining</strong> — Expense: Marketing and business development (5500). Subject to gift and entertainment limits.",
          "<strong>Office equipment purchase</strong> — Asset: Equipment (1400). Must be capitalized and depreciated over useful life, not expensed immediately."
        ]},
        { "type": "callout", "kind": "warn", "title": "The capitalization vs. expense decision", "text": "A purchase that provides benefit over multiple years (equipment, software licenses, leasehold improvements) should generally be capitalized as an asset and depreciated, not expensed immediately. Expensing a $15,000 server as a supply purchase in one year significantly understates the firm's asset base and overstates the current year expense." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Accounts Receivable and Payable",
      "summary": "Tracking what clients owe and what the firm owes — the cash flow of the practice.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "For an advisory firm, accounts receivable primarily represents advisory fees earned but not yet collected. Accounts payable represents vendor invoices and other obligations not yet paid. Both must be tracked accurately to understand the firm's true financial position." },
        { "type": "callout", "kind": "do", "title": "The AR aging report", "text": "Review the accounts receivable aging report weekly. Invoices in the 0-30 day column are current. The 31-60 day column requires attention. Anything beyond 60 days requires direct action — the firm is providing services without collecting the fee, which creates cash flow problems and potential write-off risk." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Month-End Closing Procedures",
      "summary": "The systematic process that ensures financial records are complete and accurate before reports are produced.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The month-end close is the period where all transactions for the month are finalized, adjusted, and confirmed before financial reports are generated. Skipping or rushing the close produces inaccurate reports that management decisions and tax filings will rely on." },
        { "type": "numbered", "items": [
          "Post all transactions for the month — ensure no activity is missing or unrecorded",
          "Reconcile all bank accounts — compare accounting system balances to bank statements",
          "Record accruals — expenses incurred but not yet invoiced, revenue earned but not yet received",
          "Reconcile investment accounts — confirm custodian balances match internal records",
          "Review trial balance — total debits must equal total credits",
          "Generate preliminary financial statements — review for obvious errors before finalizing"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Supporting the Accountant and Auditor",
      "summary": "What the CPA needs at tax time and what the auditor will request — how to be prepared.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The CPA preparing the firm's tax return and the auditor reviewing the firm's financial statements both need the same thing: organized, accurate records they can rely on. Your job is to have those records ready before they ask." },
        { "type": "list", "items": [
          "Bank statements reconciled and filed for all 12 months",
          "Expense support documents: receipts, invoices for all material transactions",
          "Payroll records: W-2s, 1099s, payroll journals",
          "Advisory fee schedules and billing records",
          "Asset and depreciation schedules for capitalized items",
          "Prior year tax return for reference"
        ]},
        { "type": "callout", "kind": "do", "title": "The pre-tax package", "text": "By January 31 each year, prepare a complete organized package of everything the CPA will need — even before they ask. Accountants who receive organized, complete information produce better work faster. Those who chase records produce rushed work that requires more review." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Advisory fees received from the custodian should be classified in which account type?", "options": ["Revenue — advisory fee income (typically account 4100)", "Asset — accounts receivable", "Liability — deferred revenue", "Equity — retained earnings"], "correct": 0, "explanation": "Advisory fees are the firm's primary revenue source. When received, they are posted to the appropriate revenue account. If earned but not yet collected, they are recorded as accounts receivable." },
      { "id": "q2", "text": "A $12,000 server purchased for the firm's network should be treated as what?", "options": ["A capitalized asset, depreciated over its useful life — not expensed immediately", "An operating expense in the period of purchase", "A prepaid expense to be amortized monthly", "A liability until the purchase is fully paid"], "correct": 0, "explanation": "Equipment that provides benefit over multiple years must be capitalized and depreciated. Expensing it immediately overstates the period's expenses and understates the firm's asset base." },
      { "id": "q3", "text": "An accounts receivable aging report shows an invoice in the '61-90 day' column. What action is required?", "options": ["Direct action to collect — the fee is significantly overdue and represents a cash flow and write-off risk", "Normal monitoring — 61-90 days is within normal payment terms", "Write off the invoice as uncollectible", "Issue a credit memo and rebill the client"], "correct": 0, "explanation": "Invoices beyond 60 days require direct follow-up. The firm is providing services without collecting the fee, which creates cash flow problems and increases the likelihood of write-off." },
      { "id": "q4", "text": "What is the purpose of recording accruals during the month-end close?", "options": ["To record expenses incurred but not yet invoiced and revenue earned but not yet received, ensuring the period's financial statements are complete", "To reverse incorrect entries from prior periods", "To reconcile the bank statement to the accounting records", "To calculate the depreciation for capitalized assets"], "correct": 0, "explanation": "Accrual accounting requires recording economic events when they occur, not when cash changes hands. Accruals ensure the income statement reflects all activity in the period." },
      { "id": "q5", "text": "Which step in the month-end close confirms that the accounting system is mathematically balanced?", "options": ["Reviewing the trial balance — total debits must equal total credits", "Reconciling bank accounts to bank statements", "Generating the preliminary balance sheet", "Reviewing the accounts receivable aging report"], "correct": 0, "explanation": "The trial balance is the mathematical proof of double-entry accounting. If debits don't equal credits, there is an error in the accounting records that must be found and corrected." },
      { "id": "q6", "text": "What is the most important accounting document to have ready before meeting with the CPA for tax preparation?", "options": ["Prior year tax return, reconciled bank statements, payroll records, expense support documents, and the advisory fee schedule", "Only the current year bank statements", "The audited financial statements from the prior year", "The firm's accounts payable aging report"], "correct": 0, "explanation": "The CPA needs complete, organized information to prepare an accurate tax return. Missing documents slow the process and increase the risk of errors or omissions." },
      { "id": "q7", "text": "Employee salaries should be recorded in the accounting system at what point?", "options": ["When the payroll obligation is incurred — when employees earn the wages, not necessarily when payment is made", "When the paycheck is issued", "When the employee cashes the check", "At the end of each fiscal quarter"], "correct": 0, "explanation": "Under accrual accounting, salary expense is recorded when employees earn wages, not when payroll is processed. This may require an accrual entry at period end if the payroll period spans the month boundary." },
      { "id": "q8", "text": "What distinguishes expense accounts from liability accounts in the chart of accounts?", "options": ["Expenses represent costs consumed in the period to generate revenue; liabilities represent obligations to pay in the future", "Expenses are tax-deductible; liabilities are not", "Expenses appear on the balance sheet; liabilities appear on the income statement", "Expenses are numbered in the 2000s; liabilities in the 5000s"], "correct": 0, "explanation": "Expenses are income statement accounts that reflect resources consumed during the period. Liabilities are balance sheet accounts representing future obligations. The distinction affects both reporting and decision-making." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 16;
