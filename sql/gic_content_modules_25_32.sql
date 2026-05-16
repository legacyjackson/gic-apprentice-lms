-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 25–32
-- Module 30 = AI for Reporting (supplemental)
-- Modules 31-32 = GIC Work Process #29-30
-- ============================================================================

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Needs Analysis Framework",
      "summary": "The structured process for gathering investment objectives, constraints, and risk profile under advisor supervision.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A suitability needs analysis is the professional foundation for every investment recommendation. It answers the question: given who this client is, what they need, and what they can handle — what investment strategy is appropriate? Conducted under supervision, you are learning the process so you can eventually conduct it independently." },
        { "type": "heading", "text": "The five components of a complete needs analysis" },
        { "type": "numbered", "items": [
          "<strong>Investment objective:</strong> what is the money for? Growth, income, capital preservation, or a combination? By when does the client need it?",
          "<strong>Time horizon:</strong> when will the client need to access the funds? Short-term (under 3 years), medium-term (3-10 years), long-term (10+ years)?",
          "<strong>Risk profile:</strong> combining the questionnaire results with the financial capacity assessment and the required return calculation",
          "<strong>Constraints:</strong> liquidity needs, tax situation, legal restrictions (trusts, ERISA), ethical preferences, unique circumstances",
          "<strong>Current holdings:</strong> what does the client already own? How does the new account fit into the total portfolio?"
        ]},
        { "type": "callout", "kind": "key", "title": "The IPS as the documented output", "text": "The Investment Policy Statement (IPS) is the document that captures the completed needs analysis. It describes the objective, time horizon, risk parameters, and constraints — and becomes the ongoing reference for investment decisions. Some firms use a standardized template; others customize. Either way, the IPS is the written evidence that the analysis was done." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Gathering Investment Objectives Under Supervision",
      "summary": "The questions that distinguish between what a client says they want and what they actually need.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment objectives are often stated vaguely. 'I want to grow my money' is not an investment objective — it is an aspiration. Your job is to translate the aspiration into a specific, plannable target." },
        { "type": "case_study", "title": "Translating Vague Objectives", "scenario": "A client says: 'I want to invest this $200,000 conservatively but still get a good return.' What does this actually mean? What questions do you ask?", "discussion": "'Conservative' and 'good return' are subjective and often contradictory. You need to know: What does 'conservative' mean to them — not losing principal? Not losing more than 10%? What is 'a good return' — more than the bank? More than inflation? More than the S&P 500? And what is this money for — is it their only savings, or is it supplemental? Is this account for retirement, a major purchase, or inheritance? Each answer changes what strategy is actually appropriate." },
        { "type": "callout", "kind": "do", "title": "The translation questions", "text": "'When you say conservative, what does that mean to you in practical terms?' 'If this account were down 15% in a given year, how would you feel?' 'What is this money supposed to do for you — is it for income now, for growth over time, or as a reserve you hope to never need?' These questions transform vague preferences into plannable specifications." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Constraints That Shape the Analysis",
      "summary": "The factors beyond risk tolerance that narrow the universe of appropriate strategies.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Constraints are the boundaries within which the investment strategy must operate. A strategy that ignores constraints — even a technically excellent strategy — is not suitable for the client it ignores them for." },
        { "type": "glossary", "terms": [
          { "term": "Liquidity constraint", "definition": "The client needs to access a portion of the portfolio within a specific timeframe. Illiquid investments (real estate, private equity, long-duration bonds) may be inappropriate." },
          { "term": "Tax constraint", "definition": "The client's tax situation affects which account types and investment structures are appropriate. A high-income client in a taxable account may benefit from municipal bonds; the same securities in a tax-deferred account provide no additional benefit." },
          { "term": "Legal constraint", "definition": "Trust documents, ERISA rules, court orders, or beneficiary restrictions that limit how assets can be invested." },
          { "term": "Unique circumstances", "definition": "Client-specific factors: concentrated employer stock (don't add more of the same sector), ethical investing preferences, specific securities to exclude (for legal or personal reasons)." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The constraint you cannot see", "text": "Clients do not always volunteer constraints. A client who has a significant concentrated position in their employer's stock — but does not mention it during discovery — may end up in a portfolio that compounds rather than diversifies their risk. Always ask: 'Are there any investments you already hold that we should know about when building this strategy? Any restrictions on what you can or cannot own?'" }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting the Needs Analysis",
      "summary": "The format that satisfies both compliance requirements and the advisor's practical needs.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The needs analysis documentation is the professional record that connects who the client is to what you recommended. A regulator should be able to read it and understand both the recommendation and the reasoning — without asking you to explain it." },
        { "type": "list", "items": [
          "Client identification and account type",
          "Investment objective: stated in specific terms (growth, income, preservation — with time horizon)",
          "Risk assessment: questionnaire result, capacity assessment, required return calculation",
          "Constraints identified: liquidity, tax, legal, unique circumstances",
          "Current holdings context: how this account fits with the client's total portfolio",
          "Recommended strategy and asset allocation: with explicit rationale connecting the strategy to the above",
          "Client acknowledgment: that the client reviewed and understood the recommendation",
          "Date and advisor signature"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Building Toward Independent Practice",
      "summary": "What it looks like to conduct a needs analysis without supervision — and what you still need to develop.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "This module is about conducting supervised needs analyses. The goal is to build toward independent practice — the ability to lead this process without requiring the advisor to be present for every step. That transition requires both skill and trust, and both take time to develop." },
        { "type": "callout", "kind": "key", "title": "The three markers of readiness", "text": "You are ready to conduct a needs analysis with less supervision when: (1) you consistently ask the right follow-up questions without prompting, (2) your documentation is complete and defensible the first time without revision, and (3) your recommendations connect clearly to the analysis — the advisor can see the reasoning without asking you to explain it." },
        { "type": "activity", "title": "Self-Assessment Exercise", "prompt": "Reflect honestly on your current capability in each dimension of the needs analysis process.", "steps": [
          "List the five components of a complete needs analysis and rate your confidence in each from 1-5.",
          "Identify the one component you find most difficult and write two specific things you could do to strengthen it.",
          "Think about the last needs analysis you supported. What would you do differently now?",
          "Write down two questions you would ask about the process that you have not yet asked your supervising advisor."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What are the five components of a complete suitability needs analysis?", "options": ["Investment objective, time horizon, risk profile, constraints, and current holdings context", "Return expectation, account type, fee tolerance, time horizon, and age", "Risk questionnaire, income level, tax bracket, goals, and account balance", "Objective, benchmark, rebalancing policy, performance expectations, and monitoring frequency"], "correct": 0, "explanation": "All five components must be documented. A needs analysis that captures risk tolerance but ignores constraints, or that documents the objective without the time horizon, is incomplete." },
      { "id": "q2", "text": "A client says they want their money invested 'conservatively but with a good return.' What is the advisor's best next step?", "options": ["Ask clarifying questions to translate both terms into specific, plannable parameters", "Select a moderate-risk strategy as a compromise between the two preferences", "Document 'conservative with growth objective' and proceed to allocation", "Explain that conservative and good return are mutually exclusive"], "correct": 0, "explanation": "Both terms are subjective. The advisor must understand what each means to this specific client before any strategy can be appropriate." },
      { "id": "q3", "text": "What is an Investment Policy Statement (IPS)?", "options": ["The documented output of the needs analysis — capturing objective, time horizon, risk parameters, and constraints as the reference for ongoing investment decisions", "A legally binding contract between the client and the investment manager", "A marketing document describing the firm's investment approach", "The performance benchmark for the client's portfolio"], "correct": 0, "explanation": "The IPS is the documented needs analysis. It provides the framework for all future investment decisions and serves as evidence that the analysis was conducted properly." },
      { "id": "q4", "text": "A high-income client is opening a taxable brokerage account. Which constraint is most relevant to the investment strategy?", "options": ["Tax constraint — the client's high income makes tax-efficient investments (like municipal bonds) potentially appropriate", "Liquidity constraint — high-income clients typically need immediate access to funds", "Legal constraint — high-income clients often have trust restrictions", "No special constraint — income level does not affect investment strategy"], "correct": 0, "explanation": "Tax efficiency is a critical consideration for high-income clients in taxable accounts. Tax-exempt municipal bonds may provide higher after-tax returns than taxable equivalents at high marginal rates." },
      { "id": "q5", "text": "A client has $400,000 in their employer's stock from a vested equity plan. They don't mention it during discovery. Why is this a problem?", "options": ["An advisor who recommends additional technology or sector exposure without knowing about the concentration will inadvertently compound rather than diversify the client's risk", "It is not a problem — the vested equity plan is not relevant to the advisory account", "The omission means the client is not fully committed to the engagement", "It creates a compliance issue because all assets must be disclosed"], "correct": 0, "explanation": "Hidden concentrated positions are a common source of unintended portfolio risk. A client already concentrated in tech through their employer stock should have that considered when building their investment portfolio." },
      { "id": "q6", "text": "What three markers indicate that an associate is ready to conduct needs analyses with less supervision?", "options": ["Consistently asking the right follow-up questions, documentation that is complete and defensible the first time, and recommendations that clearly connect to the analysis", "Passing the Series 65, completing 100 supervised analyses, and receiving a positive client review", "Five years of experience, no compliance violations, and advisor endorsement", "Completing all 32 apprenticeship modules, passing the final exam, and receiving firm certification"], "correct": 0, "explanation": "These three behavioral markers — questioning depth, documentation quality, and reasoning clarity — are the practical evidence that the skill has been developed, regardless of time or examination status." },
      { "id": "q7", "text": "Why must the needs analysis documentation include both the recommendation AND the rationale?", "options": ["A regulator must be able to understand why the recommendation was suitable without the advisor explaining it in person", "Rationale is required by FINRA Rule 2111", "Rationale is needed to calculate the appropriate advisory fee", "Documentation without rationale is only acceptable for accounts under $100,000"], "correct": 0, "explanation": "The fiduciary standard requires that the advisor can demonstrate their reasoning, not just their conclusion. If the documentation only says 'recommended balanced portfolio,' a regulator cannot determine whether the recommendation was appropriate." },
      { "id": "q8", "text": "Which type of constraint arises from trust documents, ERISA rules, or court orders?", "options": ["Legal constraint — formal restrictions on how assets can be invested that override advisor and client preferences", "Unique circumstances constraint", "Tax constraint", "Liquidity constraint"], "correct": 0, "explanation": "Legal constraints are imposed externally by legal instruments or regulations. They cannot be overridden by client preference or advisor judgment — the investment strategy must comply with them regardless of other considerations." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 25;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Wealth Management Actually Is",
      "summary": "True wealth management integrates every element of a client's financial life — not just investments.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Wealth management is often used as a synonym for investment management. It is not. Investment management is one component of wealth management. A true wealth management engagement integrates investments, tax planning, estate planning, insurance, cash flow, and goal planning into a single coherent strategy — where decisions in one area are made with full awareness of their impact on the others." },
        { "type": "callout", "kind": "key", "title": "The integration premium", "text": "A client who has an investment advisor, a CPA, and an estate attorney — but none of these professionals talk to each other — is not receiving wealth management. They are receiving siloed advice. The advisor who coordinates across disciplines adds value that no single specialist can." },
        { "type": "heading", "text": "The six planning dimensions" },
        { "type": "list", "items": [
          "<strong>Cash flow and budgeting</strong> — the foundation that funds every other goal",
          "<strong>Investment management</strong> — growing and protecting assets in alignment with goals and risk profile",
          "<strong>Tax planning</strong> — minimizing lifetime tax liability through strategic decisions across income, accounts, and transactions",
          "<strong>Risk management and insurance</strong> — protecting what has been built from events that could destroy it",
          "<strong>Estate planning</strong> — ensuring assets transfer according to the client's wishes, efficiently and at appropriate cost",
          "<strong>Retirement and income planning</strong> — ensuring the portfolio sustains the client's lifestyle for life"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Coordinating the Planning Team",
      "summary": "Your coordination role when the wealth management plan involves attorneys, CPAs, and insurance professionals.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A comprehensive wealth management plan often requires professionals beyond the financial advisor: an estate planning attorney to draft the documents, a CPA for tax strategy, an insurance specialist for coverage review. The advisor's role is to coordinate these specialists — gathering their inputs, ensuring they have the client information they need, and integrating their recommendations into the plan." },
        { "type": "list", "items": [
          "<strong>Before the attorney referral:</strong> prepare a complete financial summary — net worth, asset ownership structure, beneficiary designations, existing documents",
          "<strong>Before the CPA engagement:</strong> provide 2-3 years of tax returns, projected income for the current year, major planned transactions (Roth conversion, business sale, real estate)",
          "<strong>After specialist meetings:</strong> debrief the advisor and document key recommendations in the client file",
          "<strong>Ongoing:</strong> ensure the financial plan reflects the legal and tax structure — account ownership, trust funding, beneficiary alignment"
        ]},
        { "type": "callout", "kind": "do", "title": "The coordination memo", "text": "When a client is working with multiple professionals, prepare a one-page coordination memo: what each professional is doing, what information has been shared with each, and what decisions are pending. This document prevents gaps and duplicated effort across the team." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Building a Comprehensive Plan Under Supervision",
      "summary": "Assembling the inputs and producing a plan that addresses the full financial picture.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Building a comprehensive financial plan requires assembling information from many sources: financial documents, tax returns, estate documents, insurance policies, Social Security estimates, and the client's stated goals. The assembly process is as important as the analysis — an incomplete input produces an incomplete plan." },
        { "type": "activity", "title": "Plan Input Checklist Exercise", "prompt": "For a hypothetical married couple approaching retirement, build the complete information gathering checklist required to produce a comprehensive wealth management plan.", "steps": [
          "List every document needed from the investment dimension (accounts, statements, current allocation).",
          "List every document needed from the tax dimension (returns, basis records, retirement account types).",
          "List every document needed from the estate dimension (will, trust, beneficiaries, power of attorney).",
          "List every document needed from the insurance dimension (life, disability, long-term care, property).",
          "List every estimate or projection needed (Social Security, pension, home equity, business value).",
          "How many total documents is this? What is the typical completion rate from clients in the first 30 days?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Identifying Planning Opportunities and Gaps",
      "summary": "The planning gap analysis — finding what is missing, what is misaligned, and what could be better.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A comprehensive plan review looks for three things: gaps (something important that is missing), inefficiencies (something that exists but could work better), and risks (something that creates exposure if an adverse event occurs). Each dimension of the plan has its own set of gaps to look for." },
        { "type": "list", "items": [
          "<strong>Investment:</strong> Is the allocation appropriate for the time horizon and risk profile? Is the cost structure competitive?",
          "<strong>Tax:</strong> Are tax-advantaged accounts being maximized? Is there a tax diversification opportunity (Traditional vs. Roth)?",
          "<strong>Estate:</strong> Are documents current and funded? Do beneficiary designations match the estate plan?",
          "<strong>Insurance:</strong> Is the coverage adequate? Are there gaps in disability, liability, or long-term care?",
          "<strong>Cash flow:</strong> Is the savings rate sufficient to fund goals? Is there high-interest debt that should be prioritized?"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Updating Plans When Life Changes",
      "summary": "The events that require plan revision and the workflow for doing it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A financial plan is not a static document. It is a living description of the client's strategy, and it must evolve as the client's life evolves. The advisor who proactively updates the plan when life changes happen retains clients; the advisor who waits for the client to bring up the change loses the relationship." },
        { "type": "list", "items": [
          "<strong>Marriage or domestic partnership:</strong> update beneficiaries, combine or coordinate financial plans, review insurance coverage",
          "<strong>Birth or adoption of a child:</strong> update estate documents (guardian designation), start education savings, review life insurance",
          "<strong>Divorce:</strong> update beneficiaries on all accounts immediately, revise financial plan for single-income household, review QDRO if applicable",
          "<strong>Job change or major income change:</strong> update cash flow projections, review retirement savings rate, evaluate new benefits",
          "<strong>Inheritance:</strong> reassess goals and required return, review investment strategy, consider estate planning implications"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What distinguishes wealth management from investment management?", "options": ["Wealth management integrates investments, tax, estate, insurance, cash flow, and goals into a coordinated strategy; investment management focuses on portfolio construction and performance", "Wealth management is for clients with more than $1 million in assets", "Wealth management includes insurance sales; investment management does not", "They are different terms for the same service"], "correct": 0, "explanation": "Investment management is one component of wealth management. The wealth management premium comes from coordinating across all planning dimensions — so decisions in one area account for their impact on the others." },
      { "id": "q2", "text": "What information should be prepared before referring a client to an estate planning attorney?", "options": ["Net worth statement, asset ownership structure, existing estate documents, and beneficiary designations across all accounts", "Only the client's contact information and a summary of their goals", "The client's tax return from the prior year", "A list of the attorney's fees and the client's budget for legal services"], "correct": 0, "explanation": "The attorney needs the financial picture to create appropriate legal documents. Sending a client without this information wastes the attorney's time and produces documents that may not match the financial plan." },
      { "id": "q3", "text": "A client has a financial advisor, a CPA, and an estate attorney — but none of them coordinate. What is the risk?", "options": ["Siloed advice — each professional may make recommendations without knowing how they interact with the others' work, creating gaps and conflicts", "Duplication — all three will produce the same plan", "The client pays too many professional fees", "There is no risk — independent advice is always more objective"], "correct": 0, "explanation": "Without coordination, a Roth conversion recommended by the advisor may be undone by the tax impact that the CPA would have flagged, or estate documents may not match the financial account structure. Integration is the value of wealth management." },
      { "id": "q4", "text": "Which planning gap is most commonly overlooked in a comprehensive plan review?", "options": ["Insurance gaps — particularly disability and long-term care coverage — which clients are least likely to volunteer information about", "Investment allocation drift", "Retirement account contribution limits", "Estate document currency"], "correct": 0, "explanation": "Insurance is the planning dimension clients are least engaged with and least likely to raise proactively. Advisors must ask specifically about disability, long-term care, and liability coverage in every comprehensive review." },
      { "id": "q5", "text": "A client gets divorced. What is the most urgent financial planning action?", "options": ["Update beneficiary designations on all accounts immediately — before any other planning changes", "Revise the investment strategy for a single-income household", "Begin the QDRO process for retirement account division", "Review the estate documents and update the will"], "correct": 0, "explanation": "Beneficiary designations override the will. An ex-spouse still named as beneficiary on a retirement account or life insurance policy will receive those assets at death, regardless of the divorce. This must be updated immediately." },
      { "id": "q6", "text": "What is a 'coordination memo' and when is it used?", "options": ["A one-page document tracking what each professional is doing, what information has been shared, and what decisions are pending — used when the client works with multiple specialists", "A compliance document required when the advisor refers a client to an attorney or CPA", "A client-facing summary of the comprehensive financial plan", "An internal communication between the advisor and compliance department"], "correct": 0, "explanation": "The coordination memo prevents gaps and duplication across a multi-professional team. It is a project management tool for the advisor serving as the primary coordinator of the client's financial team." },
      { "id": "q7", "text": "What triggers a comprehensive plan update versus a routine annual review?", "options": ["A significant life event — marriage, divorce, death, birth, job change, inheritance, health event — that materially changes the client's situation, goals, or constraints", "A calendar date — plans are updated annually regardless of whether anything has changed", "A change in market conditions or economic outlook", "Any time a client's portfolio value changes by more than 10%"], "correct": 0, "explanation": "Life events — not calendar dates — are the primary drivers of plan updates. Annual reviews are the scheduled minimum; life events require interim updates regardless of when the last review occurred." },
      { "id": "q8", "text": "Which dimension of the financial plan requires the most coordination with professionals outside the advisory firm?", "options": ["Estate planning — requiring an attorney for document drafting and potentially a CPA for tax implications of estate structures", "Investment management — requiring custodian coordination", "Cash flow planning — requiring budget software and client data", "Retirement planning — requiring Social Security Administration data"], "correct": 0, "explanation": "Estate planning requires legally executed documents drafted by an attorney. Unlike other planning dimensions where the advisor can complete most of the work internally, estate documents require outside legal expertise." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 26;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building Product Knowledge Systematically",
      "summary": "Why product knowledge is a professional obligation and how to build it efficiently.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "An advisor who does not understand the products in their clients' portfolios cannot serve those clients well. Product knowledge is not a nice-to-have — it is the foundation of every recommendation, every client conversation about their holdings, and every due diligence decision." },
        { "type": "callout", "kind": "key", "title": "The product knowledge standard", "text": "You should be able to explain any product in a client's portfolio in plain language, answer basic questions about how it works and what it costs, and describe the circumstances under which it is and is not appropriate — without looking it up. This standard applies to every product the firm uses, not just the ones you selected." },
        { "type": "heading", "text": "Building your knowledge base" },
        { "type": "list", "items": [
          "Start with the products already in client portfolios — these are the ones you will be asked about first",
          "For each fund or ETF, read the summary prospectus and the most recent fact sheet",
          "For individual securities, read the most recent 10-K and listen to the most recent earnings call",
          "For fixed income, understand the credit rating, duration, yield, and call provisions",
          "Set a goal: know one product deeply each week until the firm's core product set is covered"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Equities in Depth",
      "summary": "Large cap, small cap, growth, value, international — the distinctions that matter for portfolio construction.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Equities are the growth engine of most long-term portfolios. Understanding the sub-categories of equities — and why the distinctions matter — allows you to evaluate whether a client's equity exposure is appropriate and well-diversified." },
        { "type": "glossary", "terms": [
          { "term": "Large cap", "definition": "Companies with market capitalization generally above $10 billion. More stable, more liquid, typically lower growth potential than smaller companies. The S&P 500 is the primary large-cap benchmark." },
          { "term": "Small cap", "definition": "Companies with market capitalization generally between $300 million and $2 billion. Higher growth potential, higher volatility, less analyst coverage. Russell 2000 is the primary small-cap benchmark." },
          { "term": "Value investing", "definition": "Selecting stocks trading below their intrinsic value based on fundamentals. Lower P/E ratios, higher dividend yields. Tends to outperform in certain market cycles." },
          { "term": "Growth investing", "definition": "Selecting companies with above-average growth rates, typically at premium valuations. Higher P/E ratios. Tends to outperform in low-interest-rate environments." },
          { "term": "International developed markets", "definition": "Equities in developed economies outside the US: Western Europe, Japan, Australia. Provides geographic diversification; currency risk is a factor." },
          { "term": "Emerging markets", "definition": "Equities in developing economies: China, India, Brazil, etc. Higher growth potential, higher volatility, additional political and currency risk." }
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Fixed Income in Depth",
      "summary": "Government, corporate, municipal — the choices and what drives them.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Fixed income provides income, reduces portfolio volatility, and serves as a counterweight to equities. Understanding the major categories of fixed income — and the trade-offs between them — is essential for evaluating bond portfolio construction." },
        { "type": "list", "items": [
          "<strong>US Treasury bonds:</strong> backed by the full faith and credit of the US government. Zero credit risk. Benchmark for all other fixed income. Yields set the risk-free rate.",
          "<strong>Investment-grade corporate bonds:</strong> rated BBB/Baa or above. Higher yield than Treasuries (credit spread) in exchange for credit risk.",
          "<strong>Municipal bonds:</strong> issued by states and local governments. Interest is federal tax-exempt (and often state tax-exempt). Most valuable to investors in high tax brackets.",
          "<strong>High-yield bonds:</strong> rated below BBB/Baa. Significantly higher yields. Significant default risk. Behave more like equities than like high-quality bonds during market stress."
        ]},
        { "type": "callout", "kind": "key", "title": "The muni bond after-tax calculation", "text": "A municipal bond yielding 3.5% tax-exempt is worth 3.5% / (1 - marginal tax rate) on a taxable equivalent basis. For a client in the 37% federal bracket: 3.5% / 0.63 = 5.56% taxable equivalent. A comparable taxable bond yielding less than 5.56% is less attractive than the muni for this client." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Alternative Investments and Specialty Products",
      "summary": "REITs, commodities, private equity — when they fit, when they don't, and what to watch for.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Alternative investments are broadly defined as anything outside of publicly traded stocks and bonds. They are often presented as portfolio diversifiers or return enhancers. Some deliver on this promise. Many do not — particularly when their fees, liquidity constraints, and actual correlation to other assets are examined honestly." },
        { "type": "glossary", "terms": [
          { "term": "REITs (Real Estate Investment Trusts)", "definition": "Publicly traded companies that own income-producing real estate. Required to distribute 90% of taxable income. Provides real estate exposure with liquidity. Not the same as owning direct real estate." },
          { "term": "Private equity", "definition": "Investment in private (non-publicly traded) companies, typically through a fund structure. High minimum investment, long lock-up periods (7-10+ years), illiquid. Historically higher returns than public equities, but with higher fees and illiquidity risk." },
          { "term": "Commodities", "definition": "Physical goods: gold, oil, agricultural products. Often used as an inflation hedge or portfolio diversifier. Can be accessed through futures, ETFs, or commodity-producing company equities." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The liquidity-return trade-off", "text": "Alternative investments often justify higher fees and complexity with the promise of higher returns. Before recommending any alternative, ask: Does this client have a genuine need for this exposure that cannot be met more cheaply and more liquidly through traditional assets? If the answer is no, traditional assets are almost always preferable." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Staying Current on Products",
      "summary": "The ongoing habit of product knowledge maintenance that professional practice requires.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Product knowledge is not a one-time achievement — it requires ongoing maintenance. Funds change management. Fee structures evolve. New products launch. Existing products are restructured or liquidated. The advisor who learned the product universe three years ago and stopped paying attention is operating with stale information." },
        { "type": "list", "items": [
          "Review fund annual reports and prospectus updates when they are issued",
          "Read the firm's research on products it uses or is considering using",
          "Attend product webinars from fund managers — at least quarterly for core holdings",
          "Track management changes: a fund manager departure is a material event requiring re-evaluation",
          "Review the firm's approved product list annually — products are added and removed"
        ]},
        { "type": "callout", "kind": "do", "title": "The 15-minute daily habit", "text": "15 minutes each morning: scan one piece of fund research, read one earnings summary for a major holding, or read one market commentary. Over a year, this produces 65+ hours of product and market knowledge — and it comes in digestible daily portions rather than indigestible annual cramming." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the taxable equivalent yield of a 3.5% tax-exempt municipal bond for a client in the 35% federal tax bracket?", "options": ["5.38% — calculated as 3.5% divided by (1 - 0.35)", "4.85%", "3.5% — the yield is the same regardless of tax status", "2.28% — calculated as 3.5% multiplied by (1 - 0.35)"], "correct": 0, "explanation": "Taxable equivalent yield = tax-exempt yield / (1 - marginal rate). 3.5% / 0.65 = 5.38%. Any taxable bond yielding less than 5.38% is less attractive than this muni for a client in the 35% bracket." },
      { "id": "q2", "text": "What distinguishes a REIT from direct real estate ownership?", "options": ["REITs are publicly traded and liquid; direct real estate is illiquid and requires active management", "REITs are tax-exempt; direct real estate produces fully taxable income", "REITs provide more stable returns than direct real estate", "Direct real estate is available to all investors; REITs require accreditation"], "correct": 0, "explanation": "The key practical distinction is liquidity and management. REITs trade on exchanges like stocks and require no property management. Direct real estate involves illiquid assets requiring hands-on oversight." },
      { "id": "q3", "text": "What should trigger a re-evaluation of an actively managed mutual fund in a client's portfolio?", "options": ["A management change — the manager who produced the historical track record has left the fund", "A period of underperformance in a single quarter", "The fund exceeds $1 billion in assets under management", "The fund's expense ratio increases by 0.01%"], "correct": 0, "explanation": "An actively managed fund's track record is attributed to its management team. A management change is a material event that makes the historical record less predictive of future results." },
      { "id": "q4", "text": "Which fixed income category typically behaves most like equities during a market stress event?", "options": ["High-yield bonds — their correlation to equities increases significantly during market dislocations", "US Treasury bonds", "Investment-grade corporate bonds", "Municipal bonds"], "correct": 0, "explanation": "High-yield bonds (junk bonds) are issued by companies with elevated default risk. During market stress, investors sell risky assets broadly — creating correlation between high-yield bonds and equities that undermines the diversification premise." },
      { "id": "q5", "text": "Before recommending an alternative investment, what is the key question to ask?", "options": ["Can the same exposure be achieved more cheaply and with better liquidity through traditional assets? If yes, why use the alternative?", "Has the alternative produced positive returns in the past three years?", "Is the alternative on the firm's approved product list?", "Does the client meet the accredited investor standard?"], "correct": 0, "explanation": "The first question is whether the alternative solves a real problem that traditional assets cannot. Many alternatives are sold on complexity and promise rather than on genuine portfolio need. Liquidity and cost should be the starting point." },
      { "id": "q6", "text": "What distinguishes value investing from growth investing?", "options": ["Value focuses on stocks trading below intrinsic value with lower P/E ratios; growth focuses on companies with above-average growth rates at premium valuations", "Value investing targets small-cap companies; growth investing targets large-cap companies", "Value investing uses fundamental analysis; growth investing uses technical analysis", "Value investors hold for longer periods than growth investors"], "correct": 0, "explanation": "The core distinction is valuation approach. Value investors seek cheap stocks relative to fundamentals. Growth investors accept premium prices for superior growth rates. Both styles have periods of outperformance and underperformance." },
      { "id": "q7", "text": "What is the primary risk that distinguishes emerging markets equities from developed international equities?", "options": ["Higher political instability, currency risk, and less developed regulatory systems — in addition to the standard market risk", "Emerging markets are more expensive to own due to higher transaction costs", "Emerging markets do not pay dividends", "Emerging markets are less liquid than developed international markets"], "correct": 0, "explanation": "Emerging markets carry political risk (government instability, nationalization risk), currency risk (exchange rate volatility against the dollar), and regulatory risk (less developed legal protections for foreign investors)." },
      { "id": "q8", "text": "What is the most efficient daily habit for maintaining product knowledge?", "options": ["15 minutes each morning reading one piece of fund research, market commentary, or earnings summary — compounding to 65+ hours of learning annually", "Weekly two-hour product research sessions", "Monthly product knowledge assessments", "Annual review of all fund prospectuses"], "correct": 0, "explanation": "Daily habits compound. 15 minutes per day totals over 65 hours per year — far more than any weekly or monthly session of comparable length. The daily cadence also keeps knowledge current rather than allowing large gaps to develop." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 27;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Relationship Calendar",
      "summary": "Systematic touchpoints that build loyalty — not the relationship moments you remember, but the ones you schedule.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client loyalty is built through consistency, not through moments of brilliance. A client who hears from their advisor at predictable, appropriate intervals — and who never has to wonder whether their advisor is paying attention — is a client who stays." },
        { "type": "heading", "text": "The standard touchpoint calendar" },
        { "type": "list", "items": [
          "<strong>Annual review meeting</strong> — comprehensive, scheduled, non-negotiable for every client",
          "<strong>Quarterly check-in</strong> — brief call or message: how are you, anything changed, here's where the portfolio stands",
          "<strong>Market event communication</strong> — when something significant happens in the market that affects client portfolios, proactive communication before clients call to ask",
          "<strong>Birthday and anniversary acknowledgment</strong> — personal, brief, consistent",
          "<strong>Life event response</strong> — a note when you learn of a marriage, birth, death, or retirement. The advisor who acknowledges life events is the advisor the client calls when financial decisions follow those events."
        ]},
        { "type": "callout", "kind": "key", "title": "Proactive vs. reactive service", "text": "Reactive service means clients call you when they have a question or concern. Proactive service means you reach out before they have to. Proactive advisors have clients who feel cared for. Reactive advisors have clients who feel like account numbers." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Proactive Outreach — The Triggers That Drive It",
      "summary": "What events in the world and in a client's life should prompt an advisor to reach out.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Proactive outreach is triggered by events — not by a calendar date. The advisor who reaches out to clients when the Fed raises rates, when a client's industry experiences disruption, or when a client mentioned they are thinking about selling their business — that advisor is demonstrating attentiveness that generic scheduled calls cannot replicate." },
        { "type": "list", "items": [
          "<strong>Market events:</strong> significant rate changes, volatility spikes, sector disruptions relevant to client holdings or employment",
          "<strong>Tax deadline proximity:</strong> April 15, December 31 — trigger conversations about tax-loss harvesting, Roth conversions, charitable giving",
          "<strong>Life milestones:</strong> a child turning 16 (college planning), a client turning 59½ (retirement account access), approaching 65 (Medicare enrollment)",
          "<strong>Known upcoming decisions:</strong> clients who mentioned a business sale, a home purchase, an inheritance — follow up when the timing is approaching",
          "<strong>Economic changes affecting specific clients:</strong> a client who works in tech during a tech sector decline"
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Handling Service Requests Professionally",
      "summary": "The response standard and workflow for client service requests.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client service requests — account changes, money movements, paperwork, questions — are the moments when advisory relationships are stressed or strengthened. A request handled quickly, completely, and with clear communication about status builds confidence. A request that disappears into a black hole destroys it." },
        { "type": "callout", "kind": "do", "title": "The 24-hour response standard", "text": "Every client service request receives a response within 24 business hours — even if the response is only: 'I received your request. I'm working on it. Here is what I expect to have for you and by when.' Acknowledgment is not resolution, but it is proof that the request was received and is being handled." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Identifying and Retaining At-Risk Clients",
      "summary": "The signals that a client may be considering leaving — and what to do about it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client attrition is expensive. Acquiring a new client costs five to seven times as much as retaining an existing one. Recognizing the early signals of client dissatisfaction — and responding before the client has decided to leave — is one of the most economically valuable skills in an advisory practice." },
        { "type": "list", "items": [
          "Reduced communication: a client who used to call regularly stops calling",
          "Unanswered calls and emails that the client previously responded to promptly",
          "Questions about fees: suddenly asking how fees are calculated and what they are paying for",
          "Questions about performance in isolation: comparing to the S&P 500 without context",
          "Withdrawal of assets: partial liquidations without a stated purpose",
          "Negative feedback: direct expressions of dissatisfaction, even if mild"
        ]},
        { "type": "callout", "kind": "do", "title": "The retention conversation", "text": "'I've noticed we haven't connected recently, and I want to make sure we're meeting your expectations. Is there anything about our relationship or our service that you feel could be better?' Direct, honest, and proactive. Most at-risk clients will either share their concern (giving you a chance to address it) or be reassured by the question itself." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "The Referral Relationship",
      "summary": "How satisfied clients become the best source of new clients — and how to facilitate that professionally.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Referrals are the highest-quality source of new clients for most advisory practices. A client who refers someone they know is providing an implicit endorsement that reduces the sales cycle, increases the likelihood of a strong relationship, and typically results in a client who is easier to serve." },
        { "type": "callout", "kind": "key", "title": "The appropriate way to ask for referrals", "text": "'If you know anyone who might benefit from the kind of work we do together — someone who is navigating a financial transition or who doesn't currently have the level of planning support you have — I'd welcome the introduction.' This is specific, non-pressured, and positions the referral as an act of generosity to the referred person." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the difference between proactive and reactive client service?", "options": ["Proactive service means reaching out before clients have to ask; reactive service means responding when clients initiate contact", "Proactive service is more expensive but not necessarily more effective", "Reactive service is preferred by most clients who don't want unsolicited contact", "There is no meaningful difference in client satisfaction outcomes between the two approaches"], "correct": 0, "explanation": "Proactive service demonstrates that the advisor is paying attention and cares about the client relationship. Reactive service leaves clients feeling like account numbers rather than valued relationships." },
      { "id": "q2", "text": "A client turns 59½ this year. What proactive outreach is most appropriate?", "options": ["A conversation about retirement account access — withdrawals from retirement accounts are now available without the 10% early withdrawal penalty", "A conversation about required minimum distributions, which begin at 59½", "A review of Medicare enrollment, which begins at 59½", "No special outreach — 59½ is not a significant financial milestone"], "correct": 0, "explanation": "Age 59½ is the threshold for penalty-free withdrawals from retirement accounts. For clients approaching retirement or needing income, this is an important milestone worth acknowledging proactively." },
      { "id": "q3", "text": "What is the 24-hour response standard for client service requests?", "options": ["Every request receives a response — even if just an acknowledgment — within 24 business hours", "Every request is fully resolved within 24 hours", "Simple requests are answered within 24 hours; complex requests within one week", "Responses are provided when the advisor's schedule permits"], "correct": 0, "explanation": "Acknowledgment within 24 hours demonstrates that the request was received and is being handled. Full resolution may take longer, but silence beyond 24 hours creates anxiety and erodes trust." },
      { "id": "q4", "text": "Which client behavior is the strongest early signal of potential attrition?", "options": ["Sudden questions about fees and what they are paying for — after previously not raising the topic", "Reduced portfolio contributions during a period of personal financial constraint", "Declining a meeting to review their annual performance report", "Asking for a copy of their account statements"], "correct": 0, "explanation": "Fee questions that arise suddenly — without an obvious trigger — often signal that the client is evaluating whether the relationship is worth continuing. This is an early warning that warrants a proactive retention conversation." },
      { "id": "q5", "text": "Why are referral clients typically easier to serve than clients acquired through other channels?", "options": ["They come pre-qualified by someone who knows both them and the advisor — reducing the trust-building phase and creating a client who generally fits the advisor's profile", "They require less documentation because the referring client vouches for them", "They are typically wealthier and therefore have simpler financial situations", "They have lower service expectations because they came through a personal introduction"], "correct": 0, "explanation": "A referral client has already received an endorsement of the advisor from someone they trust. This shortens the relationship-building timeline and typically produces clients who are more engaged and easier to work with." },
      { "id": "q6", "text": "What triggers a proactive market-event communication to clients?", "options": ["Any significant market event that affects client portfolios or that clients are likely to see reported in the news and wonder about", "Only events that require portfolio action", "Quarterly earnings announcements from major companies", "Any time the S&P 500 moves more than 1% in a day"], "correct": 0, "explanation": "The standard is: if clients are likely to see it in the news and wonder how it affects them, proactive communication prevents unnecessary anxiety and demonstrates professional attention." },
      { "id": "q7", "text": "What is the most professional way to ask a client for a referral?", "options": ["A specific, non-pressured statement that positions the referral as being helpful to the referred person — not a favor to the advisor", "Asking directly whether the client knows anyone who needs an advisor", "Offering a fee discount in exchange for successful referrals", "Including a referral request in every quarterly communication"], "correct": 0, "explanation": "The professional referral ask focuses on whether the client knows someone who could benefit from this type of planning support — making it an act of generosity rather than a sales ask." },
      { "id": "q8", "text": "Why is client retention economically more valuable than client acquisition?", "options": ["Acquiring a new client costs five to seven times more than retaining an existing one — making retention one of the highest-ROI activities in an advisory practice", "Existing clients pay higher fees than new clients", "Regulatory requirements make it more difficult to add new clients than to retain existing ones", "New clients require more compliance documentation than existing clients"], "correct": 0, "explanation": "The cost of client acquisition — marketing, meetings, onboarding — significantly exceeds the cost of retention. Every existing client retained is more economically valuable than acquiring a new one to replace them." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 28;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "From Risk Profile to Portfolio",
      "summary": "Translating the suitability assessment into a concrete, defensible portfolio.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Portfolio construction is where the theoretical work of discovery, suitability assessment, and allocation modeling becomes the client's actual investment experience. The construction decision must connect clearly and explicitly to everything that came before it." },
        { "type": "heading", "text": "The model portfolio library" },
        { "type": "paragraph", "text": "Most advisory firms use model portfolios: pre-constructed allocation targets for different risk categories. The construction process for a client account typically involves selecting the appropriate model, then populating it with specific securities or funds. Understanding how models are built helps you apply them correctly and explain them to clients." },
        { "type": "callout", "kind": "key", "title": "The documentation requirement", "text": "Every portfolio construction decision must be documented: which model was selected, why that model fits this client, and how the specific securities or funds were chosen to implement the model. This documentation is both a compliance requirement and a service standard — it allows the advisor to explain the portfolio to the client at any future meeting." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Diversification in Practice",
      "summary": "What real diversification looks like — and why owning more funds doesn't guarantee it.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Diversification is the practice of spreading investment exposure across assets that do not all move together — so that a decline in one does not produce a proportional decline in the whole portfolio. This sounds simple. In practice, achieving genuine diversification requires attention to correlation, not just count." },
        { "type": "glossary", "terms": [
          { "term": "Correlation", "definition": "A statistical measure of how two assets move relative to each other. Ranges from -1 (perfectly inverse) to +1 (perfectly aligned). True diversification requires low or negative correlation between portfolio components." },
          { "term": "Diversification on paper vs. in practice", "definition": "A portfolio with 20 different US large-cap growth funds may appear diversified but holds essentially the same underlying stocks. True diversification requires genuinely different exposures: different asset classes, geographies, sectors, and styles." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The correlation trap during market stress", "text": "Correlations between many asset classes increase during market crises — assets that appeared diversified in normal conditions fall together. The assets that tend to hold their value during stress: short-term government bonds, cash, gold. True crisis diversification requires these anchors, not just more equities." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Portfolio Characteristics",
      "summary": "The numbers that describe a portfolio's risk, cost, and income profile.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every portfolio has a set of measurable characteristics that describe its aggregate properties. These characteristics allow the advisor to compare the portfolio to its targets and to communicate the portfolio's profile to the client in clear terms." },
        { "type": "glossary", "terms": [
          { "term": "Weighted average expense ratio", "definition": "The portfolio's total cost as a percentage of assets, calculated by weighting each holding's expense ratio by its portfolio weight. A portfolio that is 60% in a 0.05% ETF and 40% in a 0.80% fund has a weighted average of 0.35%." },
          { "term": "Portfolio yield", "definition": "The aggregate income (dividends, interest) generated by the portfolio as a percentage of its value. Relevant for income-focused clients." },
          { "term": "Beta", "definition": "A measure of the portfolio's volatility relative to its benchmark. Beta of 1.0 means it moves with the market. Beta of 0.8 means it moves 80% as much as the market." },
          { "term": "Portfolio duration", "definition": "For fixed income components: the weighted average duration, measuring sensitivity to interest rate changes." }
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Modeling a Rebalancing Trade",
      "summary": "How to identify drift, calculate required trades, and prepare the rebalancing recommendation.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Rebalancing is one of the most regular and concrete portfolio construction tasks in advisory practice. It restores the intended allocation after market movement has caused drift. The process of identifying drift, modeling the trades, and documenting the rationale is a standard associate task." },
        { "type": "activity", "title": "Rebalancing Exercise", "prompt": "A client's target allocation is 60% equities / 40% fixed income. After a strong equity market, the portfolio is now 70% equities / 30% fixed income. Portfolio value: $500,000.", "steps": [
          "Calculate the dollar amount of equity overweight: 70% actual vs. 60% target = 10% × $500,000 = $50,000 overweight in equities.",
          "Identify which equity position(s) to reduce: start with highest-gain positions for tax efficiency in taxable accounts, or any position in rebalancing threshold.",
          "Calculate where the proceeds go: $50,000 must move to fixed income to restore the target.",
          "Model the trades: list the specific buy and sell orders.",
          "Consider tax implications: if this is a taxable account, calculate the estimated capital gain from selling the equity positions.",
          "Prepare a rebalancing memo for the advisor's review and approval."
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Documentation and Investment Rationale",
      "summary": "Every construction decision needs a written rationale that makes the reasoning visible.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The investment rationale memo is the document that connects the portfolio construction decision to the client's needs. It is not a marketing document — it is a professional record of why this portfolio was built this way for this client." },
        { "type": "list", "items": [
          "Client: name and account",
          "Date of construction/change",
          "What changed and why: what was the trigger for this construction decision?",
          "How the construction relates to the investment policy statement: does it match the target allocation?",
          "Specific fund or security selection rationale: why these holdings vs. alternatives?",
          "Tax considerations: any decisions made with tax efficiency in mind?",
          "Advisor approval: signature indicating review"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "A portfolio holds 15 different US large-cap growth mutual funds. Is this portfolio well-diversified?", "options": ["No — owning multiple funds in the same category provides minimal diversification because they hold largely the same underlying stocks", "Yes — 15 funds is more than the minimum for diversification", "It depends on how different the fund managers' approaches are", "Yes, as long as the funds have different names and management teams"], "correct": 0, "explanation": "True diversification requires genuinely different exposures. Multiple large-cap growth funds typically hold the same top 50-100 stocks. Diversification requires different asset classes, geographies, and styles — not just more funds." },
      { "id": "q2", "text": "A portfolio is 60% in a 0.04% index ETF and 40% in a 0.90% active fund. What is the weighted average expense ratio?", "options": ["0.384% — (0.60 × 0.04%) + (0.40 × 0.90%)", "0.47% — the simple average of 0.04% and 0.90%", "0.90% — the most expensive fund determines the portfolio cost", "0.04% — the index fund dominates by weight"], "correct": 0, "explanation": "Weighted average expense ratio = (0.60 × 0.04%) + (0.40 × 0.90%) = 0.024% + 0.36% = 0.384%. Each fund's cost is weighted by its share of the portfolio." },
      { "id": "q3", "text": "What is 'beta' in the context of portfolio characteristics?", "options": ["A measure of portfolio volatility relative to the benchmark — beta of 1.0 means it moves with the market; 0.8 means it moves 80% as much", "The target return objective for the portfolio", "The weighted average duration of the fixed income component", "The portfolio's maximum drawdown over the past year"], "correct": 0, "explanation": "Beta measures systematic risk relative to the benchmark. A beta below 1.0 indicates lower volatility than the market; above 1.0 indicates higher volatility. It is a key portfolio risk characteristic." },
      { "id": "q4", "text": "In a rebalancing trade for a taxable account, which equity positions should generally be sold first?", "options": ["Positions with the highest gains — reducing the overweight while realizing the gain that would eventually be taxed anyway", "Positions with the smallest gains to minimize taxable events", "The largest position by dollar value regardless of tax impact", "Positions that have been held the longest regardless of gain size"], "correct": 0, "explanation": "Tax-aware rebalancing often means selling the most appreciated positions first since the gain will eventually be realized. However, tax-loss harvesting opportunities and holding period (short vs. long-term gain) should also be considered." },
      { "id": "q5", "text": "What is the primary purpose of the investment rationale memo?", "options": ["To create a written record connecting the portfolio construction decision to the client's needs and the investment policy statement", "To market the portfolio strategy to the client for approval", "To satisfy the custodian's requirement for documentation of trade decisions", "To compare the portfolio's performance to its benchmark"], "correct": 0, "explanation": "The rationale memo is a professional and compliance document. It makes the advisor's reasoning visible and auditable — demonstrating that the construction decision was deliberate and connected to the client's documented needs." },
      { "id": "q6", "text": "What happens to correlations between many asset classes during a market crisis?", "options": ["Correlations increase — many assets that appeared diversified in normal conditions fall together during stress", "Correlations decrease — assets become more independent during crisis periods", "Correlations remain stable — they reflect long-term structural relationships that do not change", "Correlations only change between equities and fixed income, not within asset classes"], "correct": 0, "explanation": "The correlation trap in crises: investors sell broadly when fear rises, causing assets that normally move independently to fall together. Government bonds and cash tend to hold value, making them the reliable crisis diversifiers." },
      { "id": "q7", "text": "A client's target allocation is 60/40 and the current allocation is 70/30 on a $500,000 portfolio. What dollar amount must move from equities to fixed income?", "options": ["$50,000 — 10% drift × $500,000", "$25,000 — 5% of the overweight position", "$100,000 — the entire equity overweight must be liquidated", "$10,000 — only the amount above the rebalancing threshold"], "correct": 0, "explanation": "The drift is 10 percentage points (70% actual vs. 60% target). 10% × $500,000 = $50,000 must be moved from equities to fixed income to restore the target allocation." },
      { "id": "q8", "text": "Why must every portfolio construction decision be documented in a rationale memo?", "options": ["To create an auditable record that demonstrates the decision was deliberate and connected to the client's investment policy — satisfying both compliance and service requirements", "To satisfy FINRA Rule 2111 which requires written documentation of all investment recommendations", "To establish a benchmark against which portfolio performance will be measured", "Because clients must approve all construction decisions in writing before implementation"], "correct": 0, "explanation": "Documentation serves both compliance (demonstrating due diligence in a regulatory examination) and service (allowing the advisor to explain the portfolio coherently at any future meeting)." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 29;

-- Module 30: AI for Reporting content is already written in module30_ai_content.sql
-- Skipping to avoid overwriting existing content

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Economic Cycle and Markets",
      "summary": "How the four phases of the economic cycle drive sector and asset class performance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Markets do not move randomly. Over time, they respond to the same economic forces in recognizable patterns. Understanding the economic cycle — expansion, peak, contraction, trough — provides a framework for monitoring market conditions and contextualizing what you observe in client portfolios." },
        { "type": "glossary", "terms": [
          { "term": "Expansion", "definition": "GDP growth is positive and accelerating. Employment is rising. Corporate earnings are growing. Equities typically perform well. Consumer spending is strong. Early expansion favors cyclical sectors." },
          { "term": "Peak", "definition": "Growth rate is at its highest point before decelerating. Inflation may be rising. The Fed may be tightening. Late-cycle sectors (energy, materials) may outperform." },
          { "term": "Contraction (recession)", "definition": "GDP growth is negative for two or more consecutive quarters. Unemployment rising. Corporate earnings declining. Defensive sectors (utilities, healthcare, consumer staples) typically outperform." },
          { "term": "Trough", "definition": "The low point of the cycle before recovery begins. Interest rates are typically low. Early-cycle sectors and growth assets often begin to outperform as recovery expectations build." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The cycle timing problem", "text": "The economic cycle is a useful framework for understanding market behavior in hindsight. It is much less reliable for making specific investment decisions in real time. Nobody rings a bell at the peak or the trough. Use the cycle to provide context for what you observe — not to predict what will happen next." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Reading Market Data",
      "summary": "The key data series, what they measure, and where to find them.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Market monitoring requires knowing where to look for data and how to interpret what you find. The same number can mean different things depending on the trend, the direction of change, and the economic context." },
        { "type": "glossary", "terms": [
          { "term": "Equity indices", "definition": "S&P 500 (large-cap US), Russell 2000 (small-cap US), MSCI ACWI (global), MSCI Emerging Markets. Each measures a different slice of the equity universe." },
          { "term": "Treasury yields", "definition": "The interest rate on US government bonds at different maturities. The 10-year Treasury yield is the most widely watched benchmark rate in the world." },
          { "term": "VIX (Volatility Index)", "definition": "Often called the 'fear gauge.' Measures the market's expectation of volatility over the next 30 days. Above 30 indicates elevated fear. Below 15 indicates complacency." },
          { "term": "Credit spreads", "definition": "The difference in yield between corporate bonds and equivalent Treasury bonds. Widening spreads indicate increasing fear of corporate default. Tight spreads indicate confidence." }
        ]},
        { "type": "callout", "kind": "key", "title": "The yield curve: still the most important chart", "text": "The spread between the 2-year and 10-year Treasury yield (the 2-10 spread) has predicted most US recessions when it inverts (2-year yield exceeds 10-year yield). Monitor it weekly. When it inverts, acknowledge the signal while avoiding the prediction: 'Historically, this has preceded recessions. The timing is uncertain.'" }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Sector Analysis",
      "summary": "The 11 GICS sectors, what drives each, and how to compare sector performance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Sector analysis helps explain why a portfolio performed differently from the broad market and identifies concentration risks. Knowing what macro factors drive each sector allows you to contextualize performance and anticipate how different economic environments affect client portfolios." },
        { "type": "list", "items": [
          "<strong>Financials:</strong> interest rate sensitive. Banks benefit from rising rates (wider net interest margin). Insurance benefits from higher investment income.",
          "<strong>Technology:</strong> growth-oriented. Benefits from low interest rates (longer-duration earnings). Sensitive to rate increases.",
          "<strong>Healthcare:</strong> defensive. Demand is relatively stable regardless of economic cycle.",
          "<strong>Consumer Staples:</strong> defensive. Food, beverage, household products. Stable demand, lower growth.",
          "<strong>Consumer Discretionary:</strong> cyclical. Autos, retail, restaurants. Demand rises in expansions, falls in contractions.",
          "<strong>Energy:</strong> driven by commodity prices. Benefits from inflation and supply constraints.",
          "<strong>Utilities:</strong> defensive, high dividend yield. Sensitive to interest rates (compete with bonds for income investors)."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Preparing the Market Trend Summary",
      "summary": "The one-page format that turns monitoring into advisor-ready information.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The market trend summary is the output of your monitoring work — a concise briefing that gives the advisor what they need to have informed client conversations. It is not a comprehensive market analysis. It is the most important things the advisor needs to know, stated clearly and briefly." },
        { "type": "list", "items": [
          "<strong>Equity market summary:</strong> major index returns for the period, in 2 sentences",
          "<strong>Fixed income summary:</strong> yield changes, credit spread movement, in 1-2 sentences",
          "<strong>Economic data highlights:</strong> the 1-2 most significant data releases (jobs report, CPI, Fed decision)",
          "<strong>Sector performance:</strong> notable outperformers and underperformers and why",
          "<strong>What to watch next:</strong> upcoming data releases or events that may be relevant to client portfolios"
        ]},
        { "type": "callout", "kind": "warn", "title": "What NOT to include", "text": "Predictions. Specific market calls. Dramatic language ('markets are in crisis'). Reassurances that you cannot back up ('markets always recover'). The summary should inform, not alarm or falsely comfort." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "During a contraction phase of the economic cycle, which sectors typically outperform?", "options": ["Defensive sectors: utilities, healthcare, and consumer staples — whose demand is relatively stable regardless of the economy", "Cyclical sectors: consumer discretionary, industrials, and materials", "Technology, which benefits from companies increasing efficiency spending during downturns", "Financials, which benefit from the credit demand that increases during contractions"], "correct": 0, "explanation": "Defensive sectors produce goods and services people need regardless of economic conditions. During contractions, their relative stability makes them outperformers compared to cyclical sectors whose revenues decline with economic activity." },
      { "id": "q2", "text": "What does a VIX reading above 30 indicate?", "options": ["Elevated market fear — investors expect significant volatility over the next 30 days", "Unusual market calm — low volatility expected", "The market is overvalued relative to earnings", "Interest rates are expected to rise substantially"], "correct": 0, "explanation": "The VIX is the market's expectation of 30-day volatility. Above 30 typically indicates elevated fear and uncertainty. Below 15 indicates market complacency. The VIX tends to spike during market crises." },
      { "id": "q3", "text": "Why is the 2-year/10-year Treasury yield spread (the 2-10 spread) closely watched?", "options": ["Inversion of this spread — when the 2-year yield exceeds the 10-year — has historically preceded most US recessions", "It determines the Federal Reserve's next policy decision", "It measures the premium for holding long-term corporate bonds over government bonds", "It is the primary benchmark for adjustable-rate mortgage pricing"], "correct": 0, "explanation": "The 2-10 inversion has preceded every recession since the 1970s, though with variable lead times. It is the most widely cited yield curve indicator for recession prediction." },
      { "id": "q4", "text": "Why should the economic cycle framework be used for context rather than for specific investment predictions?", "options": ["Nobody rings a bell at the peak or trough — the cycle is identifiable in hindsight but not precisely in real time, making timing calls unreliable", "The economic cycle has not been a reliable indicator of market performance since 2000", "Regulatory rules prohibit using macroeconomic forecasts in investment recommendations", "The cycle is too complex for most clients to understand"], "correct": 0, "explanation": "The economic cycle provides a useful conceptual framework for understanding market behavior patterns. As a timing tool for investment decisions, it is unreliable because the turning points are only identified clearly after they have occurred." },
      { "id": "q5", "text": "Which market data measures the additional yield investors require to hold corporate bonds versus equivalent Treasury bonds?", "options": ["Credit spreads — widening spreads indicate increasing default risk concerns; tightening spreads indicate confidence", "The VIX — which measures equity market volatility expectations", "The yield curve slope — which measures the difference between short and long-term government rates", "Duration — which measures the sensitivity of bonds to rate changes"], "correct": 0, "explanation": "Credit spreads measure the risk premium for corporate credit. Widening spreads signal that the market is becoming more concerned about corporate defaults — often preceding or coinciding with economic deterioration." },
      { "id": "q6", "text": "What drives Financial sector outperformance in a rising interest rate environment?", "options": ["Banks' net interest margin (the spread between what they earn on loans and what they pay on deposits) typically widens when rates rise", "Higher rates reduce loan defaults, improving bank profitability", "Financial companies benefit from the increased demand for hedging products during rate cycles", "Rising rates reduce insurance company liabilities"], "correct": 0, "explanation": "Net interest margin is the primary profitability driver for banks. When short-term rates rise, banks' borrowing costs (deposits) typically adjust more slowly than their lending rates, widening the margin." },
      { "id": "q7", "text": "What belongs in a market trend summary prepared for an advisor?", "options": ["Equity and fixed income returns for the period, significant economic data highlights, sector performance, and upcoming events to watch — all stated concisely", "Comprehensive analysis of every data point released during the period", "Specific investment recommendations triggered by the market conditions", "Predictions about where markets will go over the next quarter"], "correct": 0, "explanation": "The market trend summary is a concise briefing, not a comprehensive analysis. It gives the advisor the most important context for client conversations without requiring them to process everything themselves." },
      { "id": "q8", "text": "Which type of language should be excluded from client market communications?", "options": ["Dramatic language, specific market predictions, and false reassurances like 'markets always recover'", "Plain language explanations of market events", "Contextual comparisons to benchmark performance", "Historical data about how similar market environments have unfolded"], "correct": 0, "explanation": "Dramatic language amplifies fear. Predictions create liability. False reassurances undermine credibility. Market communications should inform and contextualize — not alarm, predict, or falsely comfort." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 31;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Research Brief Format",
      "summary": "The structure that turns research into actionable advisor intelligence.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The research brief is the final deliverable of your research process. It condenses hours of information gathering into the five minutes an advisor needs to make an informed decision or conduct an informed client conversation. Its quality reflects the quality of your thinking — not the volume of your reading." },
        { "type": "numbered", "items": [
          "<strong>Executive summary (2 sentences):</strong> what is the finding and what should the advisor do with it?",
          "<strong>Context (2-3 sentences):</strong> why does this matter now? What prompted the research?",
          "<strong>Key findings (3-5 bullet points):</strong> the data that supports the conclusion, sourced and dated",
          "<strong>Risks / counterarguments (2-3 bullet points):</strong> what could be wrong? What would change the conclusion?",
          "<strong>Recommendation / implication (1-2 sentences):</strong> specifically what should the advisor consider doing in response?"
        ]},
        { "type": "callout", "kind": "key", "title": "Write the executive summary last", "text": "The executive summary is the first thing the advisor reads but it should be the last thing you write. Only after you have completed the full analysis do you know what the two most important sentences are. Writing it first produces a summary of what you intended to find rather than what you actually found." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Drafting Client Communications",
      "summary": "Emails, letters, and market commentary that are professional, compliant, and readable.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client communications are simultaneously relationship tools and compliance documents. They must be accurate, professional, and appropriate — and they must reflect the firm's voice rather than the individual writer's casual register." },
        { "type": "list", "items": [
          "<strong>Email:</strong> subject line states the purpose; first sentence states the most important point; paragraphs are short; close with a clear next step or action",
          "<strong>Client letters:</strong> use the firm's letterhead and approved format; include required compliance disclosures at the end; do not guarantee future performance or returns",
          "<strong>Market commentary:</strong> factual, contextual, no predictions; 200-300 words maximum; ends with how this connects to client strategy"
        ]},
        { "type": "callout", "kind": "warn", "title": "Compliance review requirements", "text": "Any client communication that discusses specific securities, investment strategies, or performance must go through the firm's compliance review before it is sent. This includes market commentaries, emails referencing a specific trade or recommendation, and any communication that could be construed as investment advice." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Internal Advisor Notes",
      "summary": "Writing for the advisor — what they need to know quickly and how to give it to them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Internal advisor notes are a different genre from client communications. They are written for someone with deep expertise who needs specific information quickly — not for someone who needs to be educated about the topic. Write to your audience." },
        { "type": "list", "items": [
          "Lead with the action or recommendation — not the background",
          "Assume the advisor knows the basics — do not over-explain concepts they already understand",
          "Be specific about what you need from them: approval? input? a decision?",
          "Include the deadline if there is one",
          "Attach supporting documents rather than summarizing them extensively in the note"
        ]},
        { "type": "activity", "title": "Communication Format Exercise", "prompt": "For each scenario below, identify the appropriate communication format and write the first paragraph.", "steps": [
          "Scenario A: You need the advisor to approve a rebalancing trade before the market opens tomorrow. Format? Key elements?",
          "Scenario B: A client called while the advisor was in a meeting and left a message asking about the impact of rising rates on their bond portfolio. You need to relay the question and provide relevant context. Format?",
          "Scenario C: You have completed research on a fund that the advisor asked you to evaluate. The fund is not a strong fit. Format? How do you lead?",
          "Scenario D: A client's birthday is tomorrow and the advisor wants a brief, personal note sent. Format and tone?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Building Your Communication Template Library",
      "summary": "The 10 communications you write most often deserve a template — here's how to build one.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every professional who writes regularly develops a set of recurring communication types — the post-meeting follow-up, the document request, the performance review email, the market update, the birthday note. Building and maintaining a template library for these recurring formats saves time and produces more consistent quality." },
        { "type": "numbered", "items": [
          "Identify your 10 most frequently written communications",
          "For each, write the best version you can — including required compliance language, the right tone, and the structure that works",
          "Save it as a template with clear field markers for personalization: [CLIENT NAME], [DATE], [SPECIFIC TOPIC]",
          "Review templates annually — regulatory requirements change, the firm's language standards may evolve",
          "Share templates with colleagues — a good template improves team-wide quality"
        ]},
        { "type": "callout", "kind": "do", "title": "Personalization within templates", "text": "A template should handle the structure and the required language. The personalization — the specific client detail, the reference to their situation, the acknowledgment of what was discussed — that is what makes a template feel personal rather than generic. Templates set the floor; personalization raises it." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why should the executive summary of a research brief be written last?", "options": ["Only after completing the full analysis do you know what the two most important sentences are — writing it first produces a summary of your intentions, not your findings", "Executive summaries require compliance review, which happens after the analysis", "The advisor reads the executive summary first, so it needs to be formatted last", "Writing it last ensures consistency with the conclusion section"], "correct": 0, "explanation": "The executive summary distills the most important insight. Before the analysis is complete, you don't yet know what that insight is. Writing it first leads you to confirm your initial assumption rather than report what you found." },
      { "id": "q2", "text": "Which client communication type must go through compliance review before being sent?", "options": ["Any communication discussing specific securities, investment strategies, or performance — which could be construed as investment advice", "All client emails regardless of content", "Only written letters — emails are exempt from pre-approval requirements", "Communications to clients with more than $1 million in assets"], "correct": 0, "explanation": "Content that references specific securities, strategies, or performance is subject to compliance review because it constitutes investment-related communication with potential liability implications." },
      { "id": "q3", "text": "When writing an internal advisor note requesting approval for a rebalancing trade, what should come first?", "options": ["The action needed and the deadline — not the background or context", "An explanation of why rebalancing is necessary and the supporting analysis", "The specific trades being proposed with their tax implications", "A summary of the client's account history and portfolio objectives"], "correct": 0, "explanation": "Internal notes to advisors should lead with what is needed and by when. The advisor is an expert who doesn't need context explained — they need to know quickly what decision or action is required." },
      { "id": "q4", "text": "What is the maximum recommended length for a client market commentary?", "options": ["200-300 words — concise enough to be read in full, long enough to provide genuine context", "1-2 pages — comprehensive coverage demonstrates advisor expertise", "500 words — enough to fully explain the market environment", "No limit — clients appreciate thorough analysis"], "correct": 0, "explanation": "Client market commentaries that exceed 300 words risk losing the reader. The goal is to be read and understood, not comprehensive. The 200-300 word constraint forces clarity." },
      { "id": "q5", "text": "What are the five components of a well-structured research brief?", "options": ["Executive summary, context, key findings, risks/counterarguments, and recommendation/implication", "Background, methodology, analysis, conclusion, and references", "Investment thesis, supporting data, competing views, risk factors, and price target", "Summary, holdings analysis, performance attribution, risk metrics, and outlook"], "correct": 0, "explanation": "These five components ensure the brief moves from conclusion (executive summary) through evidence (findings and risks) to action (recommendation). The structure makes the brief usable even if the reader only has two minutes." },
      { "id": "q6", "text": "What makes a communication template 'feel personal' rather than generic?", "options": ["Personalization beyond the template: specific client details, references to their situation, and acknowledgments of what was discussed — added to the template's structural framework", "Using the client's first name in the salutation", "Avoiding any templated language whatsoever", "Sending it at a time of day specific to the client's time zone"], "correct": 0, "explanation": "Templates handle structure and required language. Personalization — the specific detail that tells the client you were paying attention — transforms a template into a genuine communication." },
      { "id": "q7", "text": "When a research finding is negative — the fund you evaluated is not a good fit — how should the internal advisor note lead?", "options": ["State the conclusion directly: 'After reviewing [Fund], I recommend we do not use it for these reasons...' — then explain", "Begin with the fund's positive attributes before presenting the concerns", "Present the findings neutrally and allow the advisor to draw their own conclusion", "Start with an explanation of the research methodology before presenting findings"], "correct": 0, "explanation": "Advisors need clear, direct communication — including when the answer is no. Leading with the conclusion and then the reasoning is far more efficient than making the reader infer the conclusion from the data." },
      { "id": "q8", "text": "How frequently should communication templates be reviewed and updated?", "options": ["Annually — regulatory requirements, firm language standards, and best practices evolve and templates must reflect current standards", "Only when a specific error or problem is identified", "When a new advisor joins the team and wants to update the approach", "Every five years as part of the firm's strategic planning cycle"], "correct": 0, "explanation": "Templates contain regulatory language, disclosure requirements, and professional standards that change over time. Annual review ensures templates remain compliant and reflect current best practices." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 32;
