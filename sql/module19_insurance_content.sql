-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 19 CONTENT
-- Insurance Planning
-- ============================================================================
update public.modules set
  title = 'Insurance Planning',
  competency_id = 'CORE-9',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'Build a complete safety net for your clients. This module covers the major insurance types every financial counselor must understand — from life and disability to property and liability — so you can identify gaps, explain options in plain English, and protect everything your clients are working to build.',
  learning_objectives = ARRAY[
    'Explain how insurance functions as a risk-transfer tool within a comprehensive financial plan.',
    'Identify and distinguish the major personal insurance categories: life, health, disability, property/casualty, and liability.',
    'Calculate a client''s life insurance need using both the income-replacement and DIME methods.',
    'Compare term and permanent life insurance structures and explain when each is appropriate for a client.',
    'Describe how disability insurance protects earned income, including elimination period, benefit period, and own-occupation definitions.',
    'Conduct a basic insurance needs analysis to identify coverage gaps across a client''s full picture.',
    'Explain how annuities function as insurance products and their role in retirement income planning.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Risk, Protection, and the Safety Net",
      "summary": "Why insurance belongs in every financial plan — and how to talk about it without sounding like you're selling something.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every financial plan has two sides: building wealth and protecting it. Most of the curriculum so far has been about building — accumulation, investment, cash flow, tax strategy. Insurance is about protection. It is the part of the plan that answers the question: what happens to everything we just built if something goes wrong?" },
        { "type": "callout", "kind": "key", "title": "The planner's job on insurance", "text": "You are not selling insurance. You are identifying risk and recommending coverage. There is a significant difference. An advisor who starts from the client's actual exposure and works to the appropriate solution will always serve the client better than one who starts from a product." },
        { "type": "heading", "text": "The four ways to handle risk" },
        { "type": "paragraph", "text": "Every risk a client faces can be handled in one of four ways. Your job is to identify which approach fits each risk — and to recognize that many clients are unconsciously using the wrong one." },
        { "type": "glossary", "terms": [
          { "term": "Risk Avoidance", "definition": "Eliminating exposure to a risk entirely. Example: not owning a boat to avoid boat-related liability. Not always practical." },
          { "term": "Risk Reduction", "definition": "Taking steps to make a bad outcome less likely or less severe. Example: installing smoke detectors, wearing a seatbelt, diversifying investments." },
          { "term": "Risk Retention", "definition": "Accepting the financial consequence of a risk yourself. A client with a $1,000 deductible is retaining the first $1,000 of any covered loss. Appropriate for small, manageable risks." },
          { "term": "Risk Transfer", "definition": "Shifting the financial consequence of a risk to another party — typically an insurance company — in exchange for a premium. Appropriate for low-probability, high-severity risks." }
        ]},
        { "type": "paragraph", "text": "Insurance is the primary mechanism of risk transfer in personal finance. The logic is straightforward: you pay a predictable, affordable premium to protect yourself against an unpredictable, unaffordable loss. A family that cannot absorb the financial impact of a premature death, a disability, or a major lawsuit should not be retaining those risks — they should be transferring them." },
        { "type": "heading", "text": "The planning hierarchy" },
        { "type": "paragraph", "text": "Insurance discussions belong in the financial plan alongside investment and tax planning — not as an afterthought. The conventional sequencing: build an emergency fund first (so small losses do not require insurance claims or debt), then secure core insurance coverage (life, disability, health, liability), then focus on accumulation and growth. A household that is heavily invested but uninsured has a structural vulnerability in their plan." },
        { "type": "callout", "kind": "note", "title": "The sleep-at-night test", "text": "A simple way to gauge whether coverage is adequate: ask the client, 'If your income stopped tomorrow, how long could your household maintain its current standard of living?' If the answer is less than six months without life or disability insurance in place, the plan has a gap." },
        { "type": "heading", "text": "The insurance review framework" },
        { "type": "paragraph", "text": "When reviewing a client's insurance picture, work through four questions: What could go wrong? How likely is it? How costly would it be? And is the client currently protected against it? The combination of high likelihood and high cost is where insurance is essential. High cost but low likelihood — think catastrophic disability or premature death — is still transfer territory. Low cost, low likelihood is a reasonable candidate for retention." },
        { "type": "activity", "title": "Risk Mapping Exercise", "prompt": "For a hypothetical 38-year-old client — married, two children, $120K household income, $280K mortgage, modest savings — work through the risk mapping framework.", "steps": [
          "List five significant financial risks this client faces.",
          "For each risk, classify it: high/low likelihood and high/low financial severity.",
          "For each high-severity risk, write one sentence describing how it should be handled (transfer, retain, reduce, avoid).",
          "Identify which risks are likely uninsured for most households in this situation.",
          "Which of the four risk categories — life, disability, property, liability — should be the highest priority for this client? Explain your reasoning."
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Life Insurance — The Income Replacement Foundation",
      "summary": "Who needs it, how much they need, and how to explain term vs. permanent without getting into a product debate.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "Life insurance exists to replace income that would be lost if the insured died prematurely. That is its core purpose. Every other consideration — cash value accumulation, estate planning, tax benefits — is secondary to that foundational function. Before advising on life insurance, get clear on this question: whose death would create a significant financial hardship for someone who depends on them?" },
        { "type": "heading", "text": "Who needs life insurance" },
        { "type": "list", "items": [
          "Anyone with dependents who rely on their income",
          "A household where the surviving partner could not maintain their standard of living on one income",
          "A business owner whose death would create financial disruption for co-owners or key clients",
          "Anyone with significant debts (mortgage, business loans) that a surviving family member could not carry",
          "A stay-at-home parent whose economic contribution (childcare, household management) would be costly to replace"
        ]},
        { "type": "callout", "kind": "note", "title": "Who may not need it", "text": "A single person with no dependents and sufficient assets to cover their final expenses. A retired couple with ample savings, Social Security, and no dependents. The need for life insurance diminishes as assets accumulate and dependents gain independence." },
        { "type": "heading", "text": "Calculating the need" },
        { "type": "subheading", "text": "The income replacement method" },
        { "type": "paragraph", "text": "The simplest approach: multiply the insured's annual income by a factor of 10 to 12. A client earning $90,000 would need $900,000 to $1,080,000 in coverage. This is a starting point — it does not account for specific debts, the surviving partner's income, or the number and ages of children. Use it to establish a baseline, then adjust." },
        { "type": "subheading", "text": "The DIME method" },
        { "type": "paragraph", "text": "DIME is more precise. It calculates four components and adds them together." },
        { "type": "glossary", "terms": [
          { "term": "D — Debt", "definition": "All outstanding debts the family would need to pay off, excluding the mortgage (handled separately). Credit cards, auto loans, student loans." },
          { "term": "I — Income", "definition": "Annual income multiplied by the number of years until the youngest child reaches financial independence (typically age 22)." },
          { "term": "M — Mortgage", "definition": "The remaining mortgage balance, so the family can stay in the home." },
          { "term": "E — Education", "definition": "Estimated future education costs for each child." }
        ]},
        { "type": "activity", "title": "DIME Calculation", "prompt": "Apply the DIME method to a real scenario.", "steps": [
          "Assume: client earns $80,000/year, has $18,000 in non-mortgage debt, $210,000 remaining on mortgage, two children aged 4 and 7, and estimates $60,000 per child in future education costs.",
          "Calculate D: total non-mortgage debt.",
          "Calculate I: income × years until youngest child (age 4) reaches 22 = 18 years.",
          "Calculate M: remaining mortgage.",
          "Calculate E: education cost × 2 children.",
          "Add all four components. How does this compare to the 10x income rule of thumb?"
        ]},
        { "type": "heading", "text": "Term vs. permanent life insurance" },
        { "type": "subheading", "text": "Term life insurance" },
        { "type": "paragraph", "text": "Term life insurance provides a death benefit for a fixed period — typically 10, 20, or 30 years — in exchange for a level annual premium. There is no cash value. If the insured outlives the term, the policy expires with no payout. Term is affordable, transparent, and appropriate for the majority of income-replacement needs. A 35-year-old in good health can typically purchase $500,000 of 20-year term coverage for $25–35 per month." },
        { "type": "subheading", "text": "Permanent life insurance" },
        { "type": "paragraph", "text": "Permanent policies (whole life, universal life, variable universal life) combine a death benefit with a cash value component that accumulates over time. Premiums are substantially higher than term for equivalent coverage. Permanent life can serve legitimate planning purposes — estate liquidity, certain business continuation scenarios, permanent insurance needs that outlast a term period — but it is also widely oversold as a retirement savings vehicle, which is rarely the best use of the premium dollar." },
        { "type": "callout", "kind": "warn", "title": "The permanent vs. term debate", "text": "The conventional wisdom — 'buy term and invest the difference' — is sound for most clients. The scenarios where permanent life makes clear sense are specific: a high-net-worth client with an estate tax concern, a business with a buy-sell agreement requiring permanent coverage, or a client with an uninsurable health condition who secured permanent coverage earlier. Outside of these, term usually wins on cost-efficiency." },
        { "type": "heading", "text": "Key policy elements every advisor must know" },
        { "type": "glossary", "terms": [
          { "term": "Death benefit", "definition": "The amount paid to beneficiaries upon the insured's death. Usually income-tax-free under IRC Section 101(a)." },
          { "term": "Premium", "definition": "The periodic payment to keep the policy in force. Level premiums are locked in for the term of the policy." },
          { "term": "Beneficiary", "definition": "The person or entity who receives the death benefit. Primary and contingent beneficiaries should be named and reviewed regularly." },
          { "term": "Rider", "definition": "An optional add-on to a policy that modifies coverage. Common riders include waiver of premium (premium waived if disabled), accelerated death benefit (access a portion of the death benefit during terminal illness), and child term rider." },
          { "term": "Cash value", "definition": "In permanent policies, the savings component that accumulates over time and can be borrowed against or surrendered. Does not exist in term policies." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The three most common life insurance mistakes", "text": "<strong>1. Underinsurance:</strong> Clients frequently carry 2–3x income when they need 10x. Audit the actual need, not the existing coverage. <strong>2. Wrong policy owner:</strong> In community property states and estate planning scenarios, who owns the policy matters. Get compliance or legal input when ownership is not straightforward. <strong>3. Outdated beneficiaries:</strong> Divorces, deaths, and family changes happen. A policy that still names an ex-spouse as beneficiary is a ticking problem. Review beneficiary designations annually." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Disability and Health — Protecting the Income Engine",
      "summary": "The insurance clients underestimate most — and why disability coverage deserves as much attention as life insurance.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Consider this: the Social Security Administration estimates that a 20-year-old entering the workforce today has a 1-in-4 chance of becoming disabled before reaching retirement age. The Council for Disability Awareness reports that a 35-year-old is roughly five times more likely to be disabled for 90 days or longer than to die before age 65. Yet disability insurance is the coverage most clients either lack entirely or carry inadequately." },
        { "type": "callout", "kind": "key", "title": "The income engine", "text": "For most working households, the most valuable financial asset is not the investment portfolio — it is the client's ability to earn income. A 40-year-old earning $100,000 who works until 65 has $2.5 million of future earnings at stake. Disability insurance protects that asset." },
        { "type": "heading", "text": "Short-term vs. long-term disability" },
        { "type": "paragraph", "text": "<strong>Short-term disability</strong> typically covers 60–70% of income for a period of 3 to 6 months following an illness or injury that prevents work. Many employers offer this as a group benefit. <strong>Long-term disability</strong> picks up where short-term leaves off, covering a percentage of income — usually 60% — for a benefit period that may extend to age 65 or for a specified number of years. LTD is the more critical coverage for financial planning purposes." },
        { "type": "heading", "text": "Key disability policy provisions" },
        { "type": "glossary", "terms": [
          { "term": "Elimination period", "definition": "The waiting period between the onset of disability and when benefits begin. Common periods: 30, 60, 90, or 180 days. A longer elimination period lowers the premium — the client retains more short-term risk. The emergency fund should bridge the elimination period." },
          { "term": "Benefit period", "definition": "How long benefits will be paid if disability continues. Options range from 2 years to age 65. A 'to age 65' benefit period provides the most protection for a long-term disability." },
          { "term": "Own-occupation definition", "definition": "The insured is considered disabled if they cannot perform the duties of their specific occupation — even if they could work in another field. The gold standard for professional coverage." },
          { "term": "Any-occupation definition", "definition": "The insured is considered disabled only if they cannot perform any occupation for which they are reasonably qualified. Much harder to claim. Common in lower-cost group plans." },
          { "term": "Non-cancelable and guaranteed renewable", "definition": "The insurer cannot cancel the policy or increase premiums as long as premiums are paid. The most protective and most expensive type of LTD policy." }
        ]},
        { "type": "callout", "kind": "warn", "title": "Group disability has significant gaps", "text": "Many clients rely on employer-provided group LTD without realizing: (1) Group benefits are typically taxable if the employer paid the premiums. (2) The own-occupation definition is often limited to the first two years, then converts to any-occupation. (3) Highly compensated employees hit benefit caps — a 60% benefit on $200K income is $120K, but the plan may cap at $6,000/month. Individual policies fill these gaps." },
        { "type": "heading", "text": "Health insurance fundamentals" },
        { "type": "paragraph", "text": "As a financial counselor, you are not a health insurance agent — but you need to understand the basics, because health coverage decisions affect cash flow, out-of-pocket costs, and tax strategy in ways that belong in a financial plan." },
        { "type": "glossary", "terms": [
          { "term": "Premium", "definition": "The monthly cost of maintaining coverage, regardless of whether care is used." },
          { "term": "Deductible", "definition": "The amount the insured pays out-of-pocket before the insurance company begins sharing costs. Resets annually." },
          { "term": "Copay", "definition": "A fixed dollar amount paid for a specific service (e.g., $30 for a doctor visit), separate from the deductible." },
          { "term": "Coinsurance", "definition": "The percentage of costs the insured pays after meeting the deductible (e.g., 20% of a hospital bill)." },
          { "term": "Out-of-pocket maximum", "definition": "The most the insured will pay in a calendar year before the insurance covers 100% of in-network costs. Critical for financial planning — this is the true worst-case annual health expense." }
        ]},
        { "type": "heading", "text": "The HSA as a planning tool" },
        { "type": "paragraph", "text": "A Health Savings Account (HSA) is available to individuals enrolled in a qualifying High-Deductible Health Plan (HDHP). It is the only account in the tax code with a triple tax benefit: contributions are pre-tax, growth is tax-free, and qualified withdrawals for medical expenses are tax-free. HSAs have no 'use it or lose it' rule — balances carry over indefinitely and can be invested. Many financial planners treat the HSA as a stealth retirement account: maximize contributions, pay current medical expenses out of pocket, and let the HSA grow for retirement healthcare costs." },
        { "type": "activity", "title": "Out-of-Pocket Exposure Calculation", "prompt": "A client has a $5,000 individual deductible, 20% coinsurance, and a $9,000 out-of-pocket maximum. They are hospitalized and receive a $40,000 bill. Walk through their actual cost.", "steps": [
          "Step 1: The first $5,000 is entirely the client's (deductible).",
          "Step 2: The remaining $35,000 is split: client pays 20% = $7,000.",
          "Step 3: Client's total = $5,000 + $7,000 = $12,000.",
          "Step 4: Apply the out-of-pocket maximum: client pays no more than $9,000.",
          "Step 5: Final client cost = $9,000. How much does the emergency fund need to cover this scenario?",
          "Bonus: If this client had an HSA with $4,000 in it, what is their actual net cash outlay?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Property, Liability, and the Umbrella",
      "summary": "Protecting what clients own — and protecting them from what could be taken away.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Life and disability insurance protect the income stream. Property and liability insurance protect the balance sheet — the assets clients have already accumulated. A single uninsured or underinsured incident can undo years of careful financial planning. The goal in this area of the plan is to ensure the client has adequate coverage on what they own and adequate protection for their liability exposure." },
        { "type": "heading", "text": "Homeowners insurance" },
        { "type": "paragraph", "text": "A standard homeowners policy (HO-3) has four major components: <strong>Dwelling coverage</strong> pays to repair or rebuild the physical structure. <strong>Personal property coverage</strong> replaces belongings lost to covered perils. <strong>Liability coverage</strong> protects the homeowner if someone is injured on their property. <strong>Additional living expenses (ALE)</strong> covers temporary housing if the home is uninhabitable after a covered loss." },
        { "type": "callout", "kind": "warn", "title": "Replacement cost vs. actual cash value", "text": "Policies pay either replacement cost (what it costs to replace the item new) or actual cash value (replacement cost minus depreciation). Actual cash value coverage on a 10-year-old roof or 8-year-old appliances pays significantly less than replacement cost. For most clients, replacement cost coverage is worth the higher premium." },
        { "type": "heading", "text": "Renters insurance" },
        { "type": "paragraph", "text": "Renters insurance is one of the best values in personal insurance — typically $15–25 per month — and covers personal property and personal liability for renters who do not own their dwelling. A landlord's policy covers the building; it does not cover the tenant's belongings. Survey after survey finds that a majority of renters incorrectly believe their landlord's policy covers their possessions. It does not." },
        { "type": "heading", "text": "Auto insurance" },
        { "type": "paragraph", "text": "State minimums for auto liability coverage are nearly universally inadequate for a client with assets to protect. A state minimum of $25,000 per person / $50,000 per accident covers a fraction of what a serious auto accident can cost in medical bills, lost wages, and litigation. The coverage decision: how much liability to carry, what deductible makes sense given the emergency fund, and whether to add comprehensive and collision on owned vehicles." },
        { "type": "heading", "text": "Liability exposure — the underestimated risk" },
        { "type": "paragraph", "text": "High-net-worth clients are disproportionately at risk from personal liability claims. A dog bite, a slip-and-fall at a dinner party, an accident caused by a teenage driver — any of these can result in a judgment that exceeds standard homeowners or auto liability limits. Clients with significant assets are attractive targets for litigation, even when the underlying incident is minor." },
        { "type": "heading", "text": "The personal umbrella policy" },
        { "type": "paragraph", "text": "A personal umbrella policy provides liability coverage above and beyond the limits of homeowners and auto policies — typically $1 million, $2 million, or $5 million in additional coverage. The cost is remarkably affordable: $1 million of umbrella coverage typically costs $150–300 per year. For a client with meaningful assets, an umbrella policy is often the highest return-per-dollar of any insurance purchase they can make." },
        { "type": "callout", "kind": "do", "title": "The umbrella conversation", "text": "Every client with over $300,000 in assets, a teenage driver, a swimming pool, rental property, or professional visibility should be asked about their umbrella coverage. If they do not have one, the conversation is: 'For roughly $200 a year, I can add $1 million of liability protection above your existing policies. Can you think of a reason not to?'" },
        { "type": "heading", "text": "The insurance review process" },
        { "type": "list", "items": [
          "Review all policies annually — the same meeting where you review the financial plan.",
          "Confirm dwelling coverage keeps pace with replacement cost, not market value.",
          "Check that personal property riders cover high-value items (jewelry, art, electronics) specifically.",
          "Verify auto liability limits are at least $100K/$300K before adding an umbrella.",
          "Confirm umbrella coverage is in place if assets exceed $250K.",
          "Update beneficiary designations and policy ownership with major life changes."
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Annuities — Income Insurance for Retirement",
      "summary": "What annuities actually are, when they genuinely serve clients, and how to explain them without overselling.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "An annuity is a contract between an individual and an insurance company in which the individual transfers a sum of money to the insurer in exchange for guaranteed income payments — either immediately or in the future. At its core, an annuity is insurance against longevity risk: the risk of outliving your money." },
        { "type": "callout", "kind": "key", "title": "The retirement income floor concept", "text": "A sound retirement income plan begins with a floor: guaranteed income that covers essential expenses regardless of what markets do. Social Security provides part of this floor. A pension, if available, provides more. An annuity can fill the gap between what Social Security provides and what the client needs to cover non-discretionary spending." },
        { "type": "heading", "text": "Types of annuities" },
        { "type": "glossary", "terms": [
          { "term": "Fixed annuity", "definition": "Pays a guaranteed rate of interest during accumulation and a guaranteed income stream during distribution. Predictable. No market exposure. Low fees." },
          { "term": "Variable annuity", "definition": "Accumulation value grows or declines based on investment sub-accounts chosen by the owner. Higher potential return, higher risk, higher fees. Often includes guaranteed income riders." },
          { "term": "Fixed-indexed annuity (FIA)", "definition": "Interest credits are linked to the performance of a market index (like the S&P 500), subject to a cap and floor. Participation in market growth with protection against market loss. Moderate fees." },
          { "term": "Immediate annuity (SPIA)", "definition": "A single premium immediate annuity converts a lump sum into income payments that begin immediately (usually within 30 days). Simple, transparent, and useful for converting assets to guaranteed income." },
          { "term": "Deferred annuity", "definition": "Accumulates value over a deferral period before converting to income. Can be fixed, variable, or indexed during accumulation." },
          { "term": "Surrender charge", "definition": "A penalty for withdrawing funds from an annuity before the surrender charge period ends — typically 5–10 years. The penalty reduces over time. Locks up money." }
        ]},
        { "type": "heading", "text": "When annuities genuinely serve clients" },
        { "type": "list", "items": [
          "The client has a significant longevity concern — family history of living into their 90s and no pension.",
          "The client needs income certainty to cover essential expenses and Social Security falls short.",
          "The client has exhausted tax-advantaged contribution limits and wants tax-deferred growth.",
          "The client is converting a lump-sum distribution (pension, 401(k)) and needs guaranteed income.",
          "The client has anxiety about sequence-of-returns risk and values the behavioral benefit of guaranteed income."
        ]},
        { "type": "heading", "text": "When annuities do not serve clients" },
        { "type": "callout", "kind": "warn", "title": "The overselling problem", "text": "Annuities are among the most heavily commissioned products in financial services. Variable annuities with living benefits can carry total annual fees of 2.5–4%. These costs compound dramatically over time. An annuity that is sold primarily because of the commission rather than the client's genuine need is a breach of the advisor's obligation. Know the product, know the cost, and know the client's actual situation before recommending." },
        { "type": "list", "items": [
          "The client has sufficient guaranteed income already (Social Security + pension covers essential spending).",
          "The client needs liquidity — surrender charges make annuities unsuitable for money that might be needed.",
          "The client's primary goal is wealth accumulation with a long time horizon — lower-cost investments generally outperform after fees.",
          "The client is in poor health with a shortened life expectancy — longevity insurance has less value.",
          "The recommended product's fees are not justified by the guarantees provided."
        ]},
        { "type": "heading", "text": "What to review before recommending" },
        { "type": "numbered", "items": [
          "What specific risk is this annuity solving for this client?",
          "What are the total annual fees (MER, rider charges, sub-account expenses)?",
          "What is the surrender charge schedule, and does the client need liquidity within that window?",
          "Is the insurance company financially strong (A-rated or better)?",
          "Is there a simpler, lower-cost product that achieves the same goal?"
        ]},
        { "type": "divider" },
        { "type": "paragraph", "text": "Insurance planning is not a standalone conversation — it belongs in the financial plan alongside investment, tax, and retirement planning. A comprehensive annual review should include an insurance audit: confirming coverage is still adequate, beneficiary designations are current, and the overall protection picture reflects the client's life as it actually is today." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "text": "A client with $340,000 remaining on their mortgage, $22,000 in non-mortgage debt, two children (ages 5 and 9), earns $75,000/year, and estimates $55,000 per child in education costs. Using the DIME method, what is their approximate life insurance need?",
        "options": [
          "$1,497,000 (Debt $22K + Income $75K×13yr $975K + Mortgage $340K + Education $110K)",
          "$750,000 (10× income)",
          "$462,000 (Debt + Mortgage + Education only)",
          "$900,000 (12× income)"
        ],
        "correct": 0,
        "explanation": "DIME: D=$22,000 + I=$75,000×13 years until youngest (age 5) reaches 18=$975,000 + M=$340,000 + E=$110,000 = $1,447,000 approximately. The 10–12× rule of thumb gives $750–900K — significantly less than the actual calculated need."
      },
      {
        "id": "q2",
        "text": "What is the primary difference between own-occupation and any-occupation disability definitions?",
        "options": [
          "Own-occupation pays if you cannot perform your specific job; any-occupation pays only if you cannot work in any field you are qualified for",
          "Own-occupation has a shorter elimination period than any-occupation",
          "Any-occupation covers more conditions than own-occupation",
          "Own-occupation is only available through employer group plans"
        ],
        "correct": 0,
        "explanation": "Own-occupation is the stronger definition — a surgeon who cannot perform surgery is disabled even if they could teach. Any-occupation is far harder to qualify for and is common in lower-cost group plans."
      },
      {
        "id": "q3",
        "text": "A client has a $5,000 deductible and 20% coinsurance with a $9,000 out-of-pocket maximum. Their medical bill is $40,000. What is their actual cost?",
        "options": [
          "$9,000 — the out-of-pocket maximum caps their exposure",
          "$40,000 — they pay the full amount until the deductible is met",
          "$12,000 — deductible plus 20% of the remainder",
          "$5,000 — just the deductible"
        ],
        "correct": 0,
        "explanation": "Deductible: $5,000. Coinsurance on remaining $35,000: 20% = $7,000. Total before cap: $12,000. But the OOP maximum of $9,000 caps the exposure, so the client pays $9,000."
      },
      {
        "id": "q4",
        "text": "Which of the following BEST describes the appropriate use of a personal umbrella policy?",
        "options": [
          "Providing liability coverage above the limits of homeowners and auto policies for clients with significant assets",
          "Replacing homeowners and auto insurance for high-net-worth clients",
          "Covering medical expenses not covered by health insurance",
          "Insuring personal property not covered by a standard homeowners policy"
        ],
        "correct": 0,
        "explanation": "A personal umbrella provides an additional layer of liability protection above existing policies — typically $1M+ for $150–300/year. It does not replace underlying coverage and does not cover property or medical expenses."
      },
      {
        "id": "q5",
        "text": "Which scenario BEST describes an appropriate use of a permanent life insurance policy?",
        "options": [
          "A high-net-worth client with an estate tax concern who needs permanent insurance for estate liquidity",
          "A 30-year-old with two young children who needs income replacement coverage",
          "A client who wants to invest for retirement and prefers tax-advantaged growth",
          "A client whose employer group term life benefit has just ended"
        ],
        "correct": 0,
        "explanation": "Permanent life serves specific purposes: estate liquidity, business continuation, or clients who need permanent coverage. For income replacement or retirement accumulation, term plus dedicated investment accounts is typically more cost-efficient."
      },
      {
        "id": "q6",
        "text": "What is the primary tax advantage of a Health Savings Account (HSA)?",
        "options": [
          "Triple tax benefit: pre-tax contributions, tax-free growth, and tax-free qualified withdrawals",
          "Contributions are tax-deductible and withdrawals for any purpose are tax-free after age 65",
          "There is no tax advantage — HSAs simply allow pre-payment of medical expenses",
          "Employer contributions to HSAs are taxable income to the employee"
        ],
        "correct": 0,
        "explanation": "HSAs offer a triple tax benefit unique in the tax code. Contributions are pre-tax, growth is tax-free, and qualified medical expense withdrawals are tax-free. After 65, withdrawals for any purpose are taxed as ordinary income — similar to a traditional IRA."
      },
      {
        "id": "q7",
        "text": "A client's homeowners policy pays 'actual cash value' for personal property losses. Their 8-year-old flat-screen TV is stolen. What does this mean for their claim?",
        "options": [
          "They will receive the depreciated value of the TV, not the cost of a comparable new TV",
          "They will receive the full cost of replacing the TV with a new equivalent",
          "They will receive nothing because electronics are excluded from homeowners policies",
          "They will receive the original purchase price of the TV"
        ],
        "correct": 0,
        "explanation": "Actual cash value = replacement cost minus depreciation. An 8-year-old TV has depreciated significantly. Replacement cost coverage pays what it costs to buy a new equivalent — a meaningful difference worth the premium."
      },
      {
        "id": "q8",
        "text": "What is the primary purpose of a disability insurance elimination period?",
        "options": [
          "It is the waiting period before benefits begin, which the client's emergency fund should bridge",
          "It is the period during which the insurer can cancel the policy without cause",
          "It defines the maximum benefit period for which claims will be paid",
          "It is the time period within which the insured must file a claim after disability onset"
        ],
        "correct": 0,
        "explanation": "The elimination period is the waiting period (typically 30–180 days) before disability benefits begin. A longer elimination period lowers the premium. The client's emergency fund should be sufficient to cover living expenses during this window."
      },
      {
        "id": "q9",
        "text": "Which of the following BEST describes when an annuity is NOT appropriate for a client?",
        "options": [
          "The client needs liquidity within the next five years and the policy has a surrender charge schedule",
          "The client is concerned about outliving their assets",
          "The client's Social Security does not fully cover their essential monthly expenses",
          "The client wants guaranteed income they cannot outlive"
        ],
        "correct": 0,
        "explanation": "Annuities with surrender charges lock up capital for years. A client who may need access to those funds should not purchase an annuity with that money. Liquidity needs and surrender charge schedules must always be evaluated together."
      },
      {
        "id": "q10",
        "text": "Which of the four risk management strategies is MOST appropriate for a risk that is low-probability but catastrophically expensive?",
        "options": [
          "Risk transfer — purchase insurance to shift the financial consequence to an insurer",
          "Risk retention — accept the financial consequence yourself",
          "Risk avoidance — eliminate exposure to the risk entirely",
          "Risk reduction — take steps to make the outcome less severe"
        ],
        "correct": 0,
        "explanation": "Low-probability, high-severity risks are the classic case for risk transfer via insurance. The client cannot afford the consequence of the loss materializing, but the premium for protection is manageable. Retention would be catastrophic if the event occurred."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 19;
