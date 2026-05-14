-- ============================================================================
-- GIC APPRENTICE LMS — MASTER SETUP  (PART 2 of 2)
-- Sections 9–13: Module 19 (Insurance), modules 20–29, module 30 (AI),
--                modules 31–32, and the final comprehensive exam.
-- Run AFTER Part 1 has completed successfully.
-- ============================================================================


-- ── module19_insurance_content.sql ──

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

-- ── module26_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 26 CONTENT
-- Reconciliation & Operations Controls
-- ============================================================================
update public.modules set
  title = 'Reconciliation & Operations Controls',
  competency_id = 'OJL-17',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Reconcile what the firm''s systems say with what the custodian''s records say — daily, monthly, and annually — and build the operational controls that catch errors before they become incidents.',
  learning_objectives = ARRAY[
    'Perform daily, monthly, and annual reconciliation between firm and custodial records',
    'Identify and resolve common reconciliation breaks',
    'Calculate and apply advisory fees accurately',
    'Process corporate actions correctly',
    'Build segregation-of-duties and audit-trail controls appropriate to the firm''s size'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Reconciliation — Why It Exists and What It Catches",
        "summary": "Reconciliation is the discipline of comparing what the firm thinks it has to what the custodian says it has — and chasing down every difference. It is the operational backbone of trustworthy reporting.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A firm's internal portfolio management system (PMS) tracks positions, transactions, cash flows, performance, and fees. The custodian's system tracks the same things. The two systems should always agree. They sometimes do not — due to delayed feeds, manual entries, corporate actions, fee accruals, or genuine errors. Reconciliation is the practice of comparing the two records, identifying every difference, and resolving each one. Done daily, reconciliation catches errors when they are cheap to fix. Done poorly or rarely, errors compound and reports lose credibility."},
          {"type": "subheading", "content": "What reconciliation catches"},
          {"type": "list", "items": [
            "Trades placed but not reflected in the PMS (or vice versa)",
            "Position quantity discrepancies — a corporate action processed differently in the two systems",
            "Cost basis differences — particularly after wash-sale adjustments, return-of-capital distributions, or transfers in from external accounts",
            "Cash balance differences — a fee accrued in the PMS but not yet debited at the custodian (or vice versa)",
            "Income discrepancies — a dividend posted on different dates in the two systems",
            "Pricing discrepancies — particularly for less liquid securities where the PMS and custodian use different pricing sources",
            "Account-level discrepancies — accounts that exist in one system but not the other (transfers in or out, account closures)"
          ]},
          {"type": "subheading", "content": "Daily reconciliation"},
          {"type": "paragraph", "content": "At the start of every business day, the firm's operations team (or, at smaller firms, the apprentice or operations-aware advisor) compares the prior day's positions and transactions between the PMS and the custodian. Modern PMS platforms automate most of this — they ingest the custodian's feed each night and produce an exception report showing only items that did not auto-reconcile. The work is in resolving the exceptions, not in checking every position manually. Common patterns: a manual trade entered yesterday and not yet flowing through correctly; a corporate action that posted overnight; a fee accrual not yet matched against the custodian's debit."},
          {"type": "subheading", "content": "Monthly reconciliation"},
          {"type": "paragraph", "content": "At month-end, a more comprehensive reconciliation: full position match, cash match, fee accrual match, performance calculation tie-out. The monthly reconciliation produces the foundation for client statements and performance reporting (Module 22). Any unresolved breaks at month-end must be documented and tracked to resolution — they cannot be ignored or hidden. At many firms, the operations team produces a monthly reconciliation report that is signed off by the compliance officer or operations manager."},
          {"type": "subheading", "content": "Annual reconciliation"},
          {"type": "paragraph", "content": "At year-end, on top of the monthly reconciliation, there is a comprehensive tax-level reconciliation: realized gains/losses match between PMS and custodian; cost basis for each lot matches; income types match (dividends, qualified dividends, interest, return of capital); tax-reportable transactions match. The custodian's 1099 reports are the official tax documents — the PMS records should agree. Discrepancies must be resolved before tax-reporting season begins, both because corrections after tax filing are expensive and because mismatched records destroy CPA workflows."},
          {"type": "callout", "kind": "key", "content": "The custodian's records are the official truth. If the PMS disagrees, fix the PMS — not the other way around. Clients see the custodian's statement; their reality is what the custodian says it is."},
          {"type": "subheading", "content": "Tools and automation"},
          {"type": "paragraph", "content": "Most modern advisory firms use a portfolio management system (Orion, Tamarac, Black Diamond, Addepar, others) that automates the bulk of reconciliation through automated feeds from the custodian. The technology handles the routine; humans handle the exceptions. An exception is any item that did not auto-reconcile. The discipline is in the exception workflow: investigate, identify the cause, correct in the appropriate system, document the resolution. Exceptions that linger are operational debt — they accumulate until they become incidents."},
          {"type": "case_study", "title": "The cost basis discrepancy", "scenario": "An apprentice notices a daily reconciliation exception: cost basis on a tax lot of VTI in Naomi's taxable account is $245 per share in the PMS but $241 per share at the custodian. The difference is $4 per share across 252 shares — $1,008 of cost basis difference. Investigation: VTI paid a small return-of-capital distribution earlier in the year. The custodian's system reduced cost basis by the ROC amount; the PMS did not pick up the adjustment correctly. The apprentice initiates a basis adjustment in the PMS to align with the custodian's record, documents the reason, and reports the exception type to the operations manager for systemic review (because the issue likely affected other accounts with the same security).", "discussion": "A $1,008 cost basis difference seems trivial — until tax-loss harvesting decisions or capital gains calculations depend on it. The same systemic issue across 50 accounts is meaningful. Daily reconciliation caught the issue when it was a single-account fix; without the discipline, it would have surfaced at tax time across many accounts."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Common Reconciliation Breaks and How to Resolve Them",
        "summary": "Knowing the typical break patterns lets you triage exceptions quickly. Most breaks fall into a few recurring categories with well-understood resolution paths.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Reconciliation exceptions are not all created equal. Some are routine and self-resolving by the next day. Some require active intervention. Some indicate a deeper systemic issue. Triaging exceptions efficiently means recognizing the pattern, applying the standard resolution, and escalating only what genuinely needs investigation."},
          {"type": "subheading", "content": "Timing breaks — usually self-resolving"},
          {"type": "paragraph", "content": "Most reconciliation breaks are timing differences that resolve themselves within 1-2 business days. A trade placed late on Friday may post to the custodian's system Saturday and to the PMS's automated feed Monday morning. A dividend ex-date may produce the dividend in the PMS on the ex-date but at the custodian on the pay-date. These breaks resolve themselves — but you should still note them as expected breaks so they do not get lost in the exception report."},
          {"type": "subheading", "content": "Corporate actions — the largest single category of breaks"},
          {"type": "glossary", "terms": [
            {"term": "Cash dividend", "definition": "A simple distribution of cash to shareholders. Reconciles easily in most systems."},
            {"term": "Stock dividend", "definition": "Additional shares of the same security distributed as a dividend. Requires the PMS to add the new shares at the correct basis."},
            {"term": "Stock split", "definition": "Existing shares split into a larger number; per-share price adjusted proportionally. Position quantity and cost basis per share both change."},
            {"term": "Reverse split", "definition": "Existing shares consolidated into a smaller number; per-share price adjusted up. Often associated with fractional share roundings."},
            {"term": "Spin-off", "definition": "A company distributes shares of a subsidiary to existing shareholders. Cost basis allocation between the original and spun-off security is required."},
            {"term": "Merger", "definition": "Two companies combine; shares of the acquired company become shares of the acquirer or cash. Tax treatment varies."},
            {"term": "Return of capital (ROC)", "definition": "A distribution that is treated as a return of the investor's basis rather than income. Reduces the cost basis of the position rather than being taxed as a dividend."},
            {"term": "Tender offer", "definition": "An offer to buy shares from existing holders at a stated price. Acceptance requires action; declination is the default."}
          ]},
          {"type": "subheading", "content": "How corporate actions create breaks"},
          {"type": "paragraph", "content": "Custodians typically process corporate actions on their announced effective dates with their own data sources. PMS platforms ingest corporate action data from third-party feeds (sometimes the same provider, sometimes different) that may have slight timing or methodology differences. A return of capital distribution might be classified as a dividend by the PMS until the security's annual tax characterization is finalized. A spin-off might post differently based on different basis allocation methodologies. Most of these resolve when the tax year's final classifications are published — but until then, reconciliation requires monitoring and sometimes manual adjustment."},
          {"type": "subheading", "content": "Cash breaks"},
          {"type": "paragraph", "content": "Cash differences between PMS and custodian are usually small but worth tracking. Common sources: advisory fee accruals (PMS books the fee as it is earned; custodian debits when the fee is actually charged); interest accrual timing on bonds (PMS uses straight-line; custodian uses actual coupon dates); ACH transfers in flight (the PMS may have recorded the transfer at initiation; the custodian recognizes it on settlement); pending distributions (a trade in process where cash will arrive). Cash breaks usually resolve within days; sustained cash breaks indicate a more meaningful issue."},
          {"type": "subheading", "content": "Position breaks — the highest-priority category"},
          {"type": "paragraph", "content": "A position quantity discrepancy — the firm thinks the client owns 252 shares of VTI, the custodian shows 250 — is the most serious type of break. It can indicate a real operational error: a trade that did not actually execute, a transfer error, a manual entry mistake. Investigate position breaks immediately. Do not let a position quantity break sit overnight without explanation. Either the client's wealth is mismeasured (you are reporting positions they do not own or missing positions they do) or there is an operational failure that will surface in some other way."},
          {"type": "callout", "kind": "warn", "content": "Any position quantity break that cannot be explained within the trading day is an escalation event. Document, investigate, involve operations and compliance — do not move on until resolved."},
          {"type": "subheading", "content": "Resolving the break — fix in the right system"},
          {"type": "paragraph", "content": "When a break is identified and the cause understood, the fix goes in the system that was wrong. If the PMS missed an entry, post the entry in the PMS to align with the custodian. If the custodian's data feed had a glitch, work with the custodian to correct (rare but possible). Do not adjust the PMS to mask a real issue. The audit trail should show what was changed, when, by whom, and why. PMS platforms log these adjustments automatically."},
          {"type": "case_study", "title": "Marcus and Tasha's spin-off", "scenario": "A company Marcus owns through a single-stock position spins off a subsidiary. Each share of the parent company also receives a fractional share of the spin-off. The custodian processes the corporate action: original position retained, new spin-off position created, cost basis allocated 87% to original and 13% to spin-off (per the company's IRS Form 8937 guidance). The PMS, however, uses a third-party data provider that initially allocates 90/10. Daily reconciliation flags the basis discrepancy. The apprentice researches the company's filing, confirms the 87/13 allocation is correct per IRS guidance, and adjusts the PMS to align with the custodian. Documents the source (company's Form 8937) and the resolution. Reports the data feed discrepancy to the operations manager for review with the third-party provider.", "discussion": "Corporate actions are operationally complex. Reconciliation catches the discrepancies; research identifies the correct treatment; fix in the appropriate system; document the source. The audit trail months later shows exactly what was decided and why."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Advisory Fee Calculation and Application",
        "summary": "How and when advisory fees get charged is governed by the advisory agreement and the firm's billing process. Getting fees right — and reconciling them precisely — is fundamental operational integrity.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Advisory fees are how the firm gets paid. The advisory agreement specifies the fee schedule, billing frequency, calculation method, and authorization for the custodian to debit the fee directly from client accounts. Calculating fees accurately, applying them correctly, and reconciling them against the firm's expectations is one of the most-watched operational controls — both because fee errors generate immediate client complaints when overcharged and immediate revenue loss when undercharged."},
          {"type": "subheading", "content": "Fee structures"},
          {"type": "list", "items": [
            "Tiered AUM percentage — different rates apply to different brackets of AUM (e.g., 1.00% on first $1M, 0.75% on next $4M, 0.50% above $5M)",
            "Flat percentage — single rate across all AUM",
            "Fixed dollar — flat annual fee regardless of asset level (common in financial planning)",
            "Project or hourly — used for specific engagements (estate planning project, one-time financial plan)",
            "Performance fee — fee tied to performance above a benchmark; subject to SEC rules requiring qualified clients and specific structure",
            "Bundled vs unbundled — fee covers all services or itemized by service"
          ]},
          {"type": "subheading", "content": "Calculation method"},
          {"type": "paragraph", "content": "The advisory agreement specifies the calculation method. Common: fees calculated quarterly based on the average daily balance over the prior quarter; fees calculated based on the period-end balance; fees calculated based on the period-start balance; fees calculated as a daily accrual based on each day's balance. Different methods produce slightly different fee amounts for the same client. Whatever the method, it must be applied consistently and disclosed clearly."},
          {"type": "subheading", "content": "Pro-rating for partial periods"},
          {"type": "paragraph", "content": "When clients are added or terminated mid-period, the fee for the period is pro-rated. New client added on day 20 of a 90-day quarter pays 70/90ths of the quarterly fee. Terminated client gets the same treatment in reverse — billed only for the days they were a client during the period. Pro-rating must be documented in the advisory agreement and applied consistently."},
          {"type": "subheading", "content": "Fee debits from client accounts"},
          {"type": "paragraph", "content": "Most RIAs are authorized in the advisory agreement to instruct the custodian to debit fees directly from client accounts. The custodian processes the debit on the scheduled date; the client sees the debit on their statement. The custodian sends an automated 'fee debit' notification to the client (or to the advisor for relay) confirming the fee amount and source account. This is one of the limited-authority transactions allowed without per-event client consent — but the authority must be clearly granted in the advisory agreement and the firm must have processes to ensure fees are calculated correctly."},
          {"type": "callout", "kind": "warn", "content": "Overcharging clients on fees, even by small amounts, is one of the most common findings in SEC and state regulatory exams. The error usually comes from incorrect fee schedule application, not bad intent — but the consequence (restitution, fines, reputational damage) is real. Reconcile fees carefully every billing cycle."},
          {"type": "subheading", "content": "Fee reconciliation"},
          {"type": "paragraph", "content": "Each billing cycle, the firm should reconcile: the expected fee (calculated from the agreement and AUM); the fee invoice generated by the system; the fee debited at the custodian; the revenue recognized in the firm's accounting. All four numbers should agree. Discrepancies require investigation: is the AUM source correct, is the rate schedule current, are pro-rations correct, did the custodian process the debit correctly. The fee reconciliation is typically run by operations or compliance, with sign-off after every billing cycle."},
          {"type": "subheading", "content": "Form ADV Part 2 alignment"},
          {"type": "paragraph", "content": "The fee schedule actually applied must match the fee disclosure in the firm's Form ADV Part 2. If the firm has different rate cards for different client segments, all of them must be disclosed. If fees are negotiable, the practice and basis must be disclosed. A regulator comparing a client's actual billed fees against the firm's Form ADV looking for unexplained discrepancies is a common audit pattern. Keep alignment tight."},
          {"type": "case_study", "title": "The pro-ration that nobody caught", "scenario": "A client terminated the relationship on March 15. The firm's quarterly billing process ran on March 31 and billed the full quarter's fee for January 1 - March 31. The client noticed: 'I terminated mid-March, why is the fee for the full quarter?' The apprentice investigated: the billing system was not configured to apply pro-ration for the termination month. Total over-billing: $1,234. Resolution: the firm refunded the over-billed amount immediately, communicated transparently with the client (who appreciated the prompt fix and stayed within the firm's friend network), and updated the billing configuration to handle terminations correctly going forward. The compliance officer also reviewed the prior 12 months of terminations to identify other clients who may have been similarly over-billed; found two other instances and processed refunds.", "discussion": "The error was small in any single case but systemic across the firm. Without the client's question and the apprentice's investigation, the issue would have persisted. Process fix: terminations now trigger an automatic pro-rated billing calculation; compliance reviews terminations monthly. The cost of operational fix is much lower than the cost of an SEC finding."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Processing Corporate Actions and Income",
        "summary": "Corporate actions and income distributions require active operational management. Mishandling them creates tax errors, reporting errors, and client confusion.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Securities held in client accounts generate a steady stream of events that require operational handling: dividends, interest, return of capital distributions, stock splits, spin-offs, mergers, tender offers, rights offerings. Some of these are passive (the custodian processes automatically and the PMS reflects the result). Others require election decisions (a tender offer, a merger consideration choice between cash or stock). All require accurate reflection in records, correct tax treatment, and clear client communication where appropriate."},
          {"type": "subheading", "content": "Passive corporate actions"},
          {"type": "paragraph", "content": "Most corporate actions are passive — the custodian processes them automatically and the PMS picks up the result. Cash dividends post to the client's cash balance. Stock dividends create new shares. Stock splits adjust position quantities and per-share basis. Return of capital reduces basis. These do not require advisor action. They do require reconciliation (Lesson 2) to ensure the PMS reflects what the custodian shows."},
          {"type": "subheading", "content": "Active corporate actions — election decisions"},
          {"type": "paragraph", "content": "Some corporate actions present the client with a choice: accept a tender offer or hold the shares; choose cash or stock in a merger; exercise or sell warrants; participate in or skip a rights offering. The custodian notifies the firm of the action with a deadline. The firm has to decide (within authority granted) or coordinate with the client to decide. Defaults vary: tender offers default to non-participation (you keep the shares); rights offerings default to non-exercise (the rights expire); merger elections often default to a specific option per the merger documents."},
          {"type": "subheading", "content": "Income distributions and tax characterization"},
          {"type": "paragraph", "content": "Income distributions from securities — dividends, interest, capital gain distributions from funds — are characterized for tax purposes by the security issuer or fund company. Same dollar amount can be characterized differently depending on its source. Common characterizations: ordinary dividends, qualified dividends (preferential tax treatment), short-term capital gain distributions (ordinary rates), long-term capital gain distributions (preferential rates), tax-exempt interest (federal-tax-free), foreign-source income (eligible for foreign tax credit), and return of capital (basis reduction, not income). Characterizations are finalized in January when the tax-year reporting completes, sometimes resulting in reclassification of distributions made during the year."},
          {"type": "subheading", "content": "January reclassifications"},
          {"type": "paragraph", "content": "Many mutual funds and ETFs reclassify some of their distributions in January, after the fact. A distribution paid as 'dividend' during the year may be reclassified to return of capital or to a different capital gain treatment when the fund's final tax allocations are determined. The reclassification can change client tax outcomes — sometimes significantly. The reconciliation process must pick up these reclassifications and update PMS records accordingly. CPAs preparing client returns need the final 1099 reflecting reclassifications, not the in-year preliminary characterizations."},
          {"type": "subheading", "content": "Dividends and DRIP"},
          {"type": "paragraph", "content": "Dividend reinvestment plans (DRIP) automatically reinvest cash dividends in additional shares of the dividend-paying security. Set per account and per security at the custodian. Two considerations: tax-loss harvesting requires turning off DRIP on the security being harvested (to prevent wash-sale through the reinvestment, per Module 24); systematic rebalancing benefits from turning off DRIP and letting dividends accumulate in cash to be directed toward underweight allocations. Many client accounts have DRIP enabled by default; reviewing and adjusting DRIP settings is part of account setup and annual review."},
          {"type": "subheading", "content": "Communicating corporate actions to clients"},
          {"type": "paragraph", "content": "Some corporate actions warrant client communication; many do not. Threshold: communicate to the client when the action requires a decision (tender offer with potential financial impact, merger with election choice), when the action materially changes the holding (large special dividend, significant spin-off), or when the action will be visible on the client's statement in a way that may prompt questions. Routine dividends and small distributions do not require communication. Use judgment; over-communicating creates noise, under-communicating creates surprises."},
          {"type": "case_study", "title": "The unexpected reclassification", "scenario": "In December, Devon's portfolio shows $14,200 in distributions from a REIT ETF, categorized at that point as 'qualified dividends.' In late January, the fund company issues final tax allocations: the $14,200 is actually 38% qualified dividends, 41% ordinary non-qualified dividends, 16% return of capital, and 5% long-term capital gains. The PMS picks up the reclassification through the custodian's updated reporting. Devon's tax outlook changes meaningfully — what looked like all preferential-rate income includes substantial ordinary rate income. The apprentice notifies Devon and his CPA: 'The REIT ETF distribution characterization has been finalized differently than initially reported. Your final 1099 will reflect $5,400 in qualified dividends instead of $14,200, with the remainder in ordinary dividends, ROC, and capital gain distributions. Tax impact is approximately $1,800 higher than the December projection. Updated planning attached.'", "discussion": "REITs and certain other funds reclassify substantially in January. Without picking up the reclassification, Devon's tax projection would have been materially wrong. The CPA needs the final 1099 to file correctly. The apprentice's role: detect the reclassification, communicate the impact, update plans accordingly. Operational discipline matters at tax time."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Operations Controls and Segregation of Duties",
        "summary": "Operations controls are how a firm prevents errors and fraud through structural process design. Even at small firms, the principles can be applied with discipline.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "A firm's operational integrity depends on more than individual diligence — it depends on the structural controls that catch errors before they propagate. Segregation of duties (no one person controls the entire chain of a high-risk operation), independent review (a second set of eyes on consequential items), and audit trails (every action documented) are the three pillars of operational control. At larger firms, these are formalized by entire operations departments. At smaller firms, the principles still apply — implemented with discipline rather than scale."},
          {"type": "subheading", "content": "Segregation of duties — the principle"},
          {"type": "paragraph", "content": "Segregation of duties means that no single person should control all phases of a sensitive operation. The classic example: the person who authorizes a payment should not also be the person who initiates it, and neither should be the person who reconciles the bank statement. If all three are the same person, that person can divert funds and cover it up. With segregation, the diversion would require collusion across multiple people — much harder to execute and easier to detect."},
          {"type": "subheading", "content": "Common segregations in advisory operations"},
          {"type": "list", "items": [
            "Trade authorization vs trade execution — the apprentice may prepare the trade; the trader executes; the operations team reconciles",
            "Fee calculation vs fee review — the system calculates; operations or compliance reviews; finance recognizes revenue",
            "Account opening vs disbursement authority — the person who opens an account should not be the same person who authorizes withdrawals from it",
            "Wire initiation vs wire approval — wires above a threshold require approval from a second person",
            "Personal trading vs trade execution — anyone who places client trades has constrained personal trading per firm policy"
          ]},
          {"type": "subheading", "content": "Independent review"},
          {"type": "paragraph", "content": "Beyond segregation, certain operations should have independent review even if not strictly segregated. Examples: a senior advisor reviewing all new account openings before they go live; compliance reviewing all fee calculations periodically; operations reviewing all corporate action elections; trading reviewing all suitability documentation on certain product types. Independent review is not bureaucracy — it is the structural mechanism for catching errors that the originator missed."},
          {"type": "subheading", "content": "Audit trails"},
          {"type": "paragraph", "content": "Every significant action — trade, transfer, fee debit, account change, document update — should generate a record showing who did it, when, and why. Modern PMS and CRM systems automate audit trails for actions performed within them. Actions performed outside (manual paperwork, phone calls, emails) need to be recorded manually. The audit trail serves three purposes: regulatory compliance, dispute resolution, and continuous improvement. Years later, the audit trail is what allows the firm to reconstruct what happened and why."},
          {"type": "subheading", "content": "Compliance calendar"},
          {"type": "paragraph", "content": "Most firms maintain a compliance calendar — scheduled recurring reviews, filings, and certifications. Examples: quarterly Form ADV updates if applicable; annual Form ADV re-filing; annual review of all client suitability documents; quarterly review of personal trading; semi-annual review of soft dollar arrangements; annual review of business continuity plan. Apprentices typically do not own the compliance calendar but may contribute to specific items. Knowing the cadence and respecting the deadlines is part of professionalism."},
          {"type": "subheading", "content": "Operational risk assessment"},
          {"type": "paragraph", "content": "Periodically — annually for most firms — the firm should conduct an operational risk assessment: what are the operations we perform, where are the failure modes, what controls do we have, and where are the gaps? The assessment is the structured version of the question 'what could go wrong here, and what would we do if it did.' Outputs include process improvements, control additions, and training priorities. Small firms can do this in a few hours; large firms have entire teams dedicated to it. Either way, the discipline keeps controls aligned with evolving risk."},
          {"type": "subheading", "content": "Errors as learning opportunities"},
          {"type": "paragraph", "content": "When an operational error occurs, the response should include not only the immediate correction (Module 23, Module 17) but a structured retrospective: what happened, why was it not caught, what process change would prevent recurrence. The retrospective should be blameless — focused on system improvement, not individual fault. Errors that lead to better systems are better than errors that lead to silence. The firm's error log, reviewed quarterly, reveals patterns: which operations produce the most errors, which controls are working, where new controls are needed."},
          {"type": "callout", "kind": "key", "content": "Strong operations are not the absence of errors — they are the system that detects errors quickly, corrects them cleanly, and continuously improves to reduce their frequency. Treat every error as data about how to improve."},
          {"type": "case_study", "title": "Building controls at a growing firm", "scenario": "A small RIA has grown from 1 advisor to 3 in 18 months, adding an operations associate and an apprentice. The founder previously handled all operations personally; segregation of duties was structurally impossible with one person. With the team in place, the founder works with the operations associate to build the first formal controls: trades placed by advisors are reviewed end-of-day by operations; fee calculations are reviewed quarterly by compliance (which they outsource to a consultant); wires over $50K require two-person approval; the apprentice runs daily reconciliation with senior review of any exception over $5K. The firm documents the controls in a written operations manual.", "discussion": "None of this is exotic. All of it is the standard playbook applied at the firm's scale. The investment in formalization pays back in fewer errors, faster detection of any that occur, and a defensible compliance posture as the firm grows further. Operational maturity is what enables scale."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Compliance Workflows. The regulatory framework that governs day-to-day operations and the documentation that proves we are operating within it."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "When the firm's portfolio management system and the custodian's records disagree, the appropriate response is to:", "options": ["Use whichever number is higher", "Investigate, identify the cause, and fix the system that is wrong — custodial records are the official truth", "Average the two", "Use the PMS number for client reports"], "correct": 1, "explanation": "Custodian records are the official truth. Reconciliation aligns the PMS to the custodian, with documented adjustments."},
        {"id": "q2", "prompt": "Daily reconciliation catches errors when:", "options": ["They are cheapest to fix; lingering errors compound and surface as larger incidents", "There is nothing else to do", "Required by SEC rules", "Only at year-end"], "correct": 0, "explanation": "Speed of detection determines cost of correction. Daily reconciliation flags exceptions while they are still single-account fixes."},
        {"id": "q3", "prompt": "A return of capital (ROC) distribution affects the security's:", "options": ["Tax bracket", "Cost basis — it is treated as a return of the investor's basis rather than income, reducing basis", "Dividend yield", "Sector classification"], "correct": 1, "explanation": "ROC reduces basis rather than producing current income. When the security is eventually sold, the gain is larger because of the basis reduction."},
        {"id": "q4", "prompt": "January reclassifications by mutual funds and ETFs can affect:", "options": ["Only the fund company", "Client tax outcomes — distributions paid during the year may be re-characterized when final tax allocations are determined, changing whether amounts were dividends, ROC, capital gains, etc.", "Only IRA accounts", "Only foreign investments"], "correct": 1, "explanation": "January reclassifications can materially change client tax outcomes. CPAs need final 1099s reflecting the reclassifications; preliminary in-year characterizations are not final."},
        {"id": "q5", "prompt": "A position quantity discrepancy between PMS and custodian is:", "options": ["A routine timing break that can wait", "A high-priority break that should be investigated immediately and not left overnight without explanation", "Always the custodian's fault", "Usually a tax-only issue"], "correct": 1, "explanation": "Position discrepancies can indicate real operational failures — missing trades, transfer errors, manual mistakes. Escalation is appropriate when not resolved same-day."},
        {"id": "q6", "prompt": "Most advisory fees are calculated and debited based on:", "options": ["Client request each quarter", "Authority granted in the advisory agreement, with the custodian processing the debit on the scheduled date based on the firm's calculation", "Custodian discretion", "Performance only"], "correct": 1, "explanation": "Direct debit authority is granted in the advisory agreement and processed by the custodian. The firm calculates the fee; the custodian debits; the client sees both."},
        {"id": "q7", "prompt": "Overcharging clients on advisory fees, even small amounts, is:", "options": ["Generally minor and unenforced", "One of the most common findings in SEC and state regulatory exams; restitution and penalties are real", "Required for revenue maintenance", "Disclosed in marketing materials"], "correct": 1, "explanation": "Fee errors are a recurring regulatory finding. Even when unintentional, the consequence is restitution, fines, and reputational damage."},
        {"id": "q8", "prompt": "Segregation of duties means:", "options": ["Each advisor specializes in one area", "No single person should control all phases of a sensitive operation — separation creates a check that requires collusion to defeat", "All trades go through one person for consistency", "Different fees for different services"], "correct": 1, "explanation": "Segregation makes single-person fraud or error harder by ensuring multiple people see different parts of a process. Standard control in financial operations."},
        {"id": "q9", "prompt": "When a client terminates the advisory relationship mid-quarter, the fee for that quarter should be:", "options": ["Charged in full per the agreement", "Pro-rated for the days the client was actually a client during the period, per the advisory agreement", "Waived entirely", "Increased to cover transition costs"], "correct": 1, "explanation": "Pro-ration is the standard practice and must be documented in the advisory agreement. Failing to pro-rate is a common over-billing pattern flagged in exams."},
        {"id": "q10", "prompt": "Tender offers in client accounts where no election is made typically default to:", "options": ["Acceptance of the offer", "Non-participation — the client keeps the shares", "Cash exchange at the lowest offered price", "Court determination"], "correct": 1, "explanation": "Tender offers require affirmative election to participate. Without election, the client retains the shares."},
        {"id": "q11", "prompt": "Audit trails for operational actions serve which purposes?", "options": ["Only regulatory compliance", "Regulatory compliance, dispute resolution, and continuous improvement", "Internal marketing", "Tax preparation only"], "correct": 1, "explanation": "Audit trails enable reconstruction of what happened, defense in disputes, and pattern analysis for process improvement. Multi-purpose discipline."},
        {"id": "q12", "prompt": "After an operational error, the most valuable response is:", "options": ["Identifying who to blame", "A blameless retrospective focused on what process change would prevent recurrence, plus immediate client correction", "Hiding the error from compliance", "Reducing the affected client's fees as compensation"], "correct": 1, "explanation": "Blameless retrospectives produce systemic improvements. Blame produces silence and recurrence. Combine the immediate client correction with the structural fix."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 27;

-- ── module27_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 27 CONTENT
-- Compliance Workflows
-- ============================================================================
update public.modules set
  title = 'Compliance Workflows',
  competency_id = 'OJL-18',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Operate within the regulatory framework that governs advisory practice — books and records, advertising rules, supervision, exams, and the day-to-day compliance disciplines that protect clients and the firm.',
  learning_objectives = ARRAY[
    'Identify the major regulatory regimes that govern RIA and broker-dealer practice',
    'Maintain books and records that satisfy SEC, FINRA, and state requirements',
    'Apply the SEC Marketing Rule to communications and advertising',
    'Operate within supervisory frameworks and respond to inquiries',
    'Prepare for and participate in regulatory examinations'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "The Regulatory Landscape",
        "summary": "Multiple regulators govern advisory practice. Knowing which one applies to which activity — and what each one cares about — is the foundation of compliance.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Advisory and brokerage practice in the United States sits within a layered regulatory structure. The same firm and the same activity can be subject to multiple regulators at once. Understanding which regulator governs which activity, what each one cares about, and how their requirements interact is foundational. Compliance is not a single set of rules — it is a multi-dimensional framework that practitioners learn to operate within instinctively over years."},
          {"type": "subheading", "content": "The major regulators"},
          {"type": "glossary", "terms": [
            {"term": "SEC (Securities and Exchange Commission)", "definition": "Federal regulator of securities markets, broker-dealers above certain thresholds, registered investment advisers with AUM above $100M (or operating in 15+ states), public company disclosures, and securities laws including the 1933 Act, 1934 Act, and Investment Advisers Act of 1940."},
            {"term": "FINRA (Financial Industry Regulatory Authority)", "definition": "Self-regulatory organization (SRO) for broker-dealers. Sets rules, conducts exams, administers licensing exams (Series 7, 63, 65, 66, etc.), and disciplines members. Not a government agency but operates under SEC oversight."},
            {"term": "State securities regulators", "definition": "Regulate registered investment advisers below $100M AUM (state-registered RIAs) and have authority over broker-dealer activity within their state. Coordinated through NASAA (North American Securities Administrators Association)."},
            {"term": "CFPB (Consumer Financial Protection Bureau)", "definition": "Federal regulator of consumer financial products and services — primarily relevant to banking, lending, and consumer credit rather than investment advice."},
            {"term": "DOL (Department of Labor)", "definition": "Regulates retirement plans under ERISA, including rules around rollovers and fiduciary conduct toward retirement assets. Active rulemaking history around fiduciary standards."},
            {"term": "MSRB (Municipal Securities Rulemaking Board)", "definition": "Self-regulatory body for municipal securities. Relevant for firms dealing in muni bonds."},
            {"term": "CFTC (Commodity Futures Trading Commission)", "definition": "Regulates futures and derivatives markets. Relevant for firms dealing in commodity futures."}
          ]},
          {"type": "subheading", "content": "RIA vs Broker-Dealer regulation"},
          {"type": "paragraph", "content": "The two primary regulatory tracks for retail-facing investment professionals are RIA and broker-dealer. RIAs operate under the Investment Advisers Act of 1940 and applicable state laws, with fiduciary duty to clients. Broker-dealers operate under the Securities Exchange Act of 1934 and FINRA rules, with Reg BI (best interest) standard for retail recommendations. Many firms operate dual registrations — both an RIA and a broker-dealer entity, sometimes with overlapping personnel. The same person may give advice under fiduciary duty (RIA hat) and recommend products under Reg BI (BD hat) to the same client. The complexity is real."},
          {"type": "subheading", "content": "Registration thresholds"},
          {"type": "list", "items": [
            "Investment advisers with $100M+ AUM register with SEC (federal)",
            "Investment advisers below $100M AUM generally register with state regulators",
            "Investment advisers operating in 15+ states may opt for SEC registration regardless of AUM",
            "Broker-dealers register with SEC and FINRA federally; also register in each state where they do business",
            "Individual representatives must pass relevant licensing exams and register through Form U4 with the firm's appropriate regulator"
          ]},
          {"type": "subheading", "content": "Investment Adviser Representatives (IAR)"},
          {"type": "paragraph", "content": "Individuals who provide advice on behalf of an RIA are Investment Adviser Representatives. They must pass either the Series 65 exam, or hold a Series 7 plus Series 66 combination, unless they hold a qualifying professional designation (CFP, ChFC, CFA, etc.) that may exempt them in certain states. Apprentices typically work toward and pass the Series 65 during the apprenticeship, often within the first 12-18 months. The exam is not trivial but is achievable with systematic study."},
          {"type": "subheading", "content": "What each regulator cares about"},
          {"type": "list", "items": [
            "SEC — books and records, marketing rule compliance, Form ADV accuracy, conflicts of interest disclosure, custody and safety of client assets, performance reporting, supervision, anti-fraud rules",
            "FINRA — best execution, sales practices, supervision, advertising review, personal trading, communications with the public, training and licensing",
            "State regulators — registration, Form ADV alignment, fee transparency, client complaints, exam findings, anti-fraud, suitability/fiduciary alignment",
            "DOL — rollover recommendations from retirement plans, fiduciary conduct toward retirement assets, prohibited transaction exemptions"
          ]},
          {"type": "callout", "kind": "key", "content": "Compliance is not adversarial. The regulators and the firm have the same goal: protect clients and maintain the integrity of the market. Treat compliance as a partner discipline, not as friction."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Books and Records — What Must Be Kept and for How Long",
        "summary": "Books and records rules specify what records firms must maintain, in what form, and for how long. Failing to meet the requirements is one of the most common regulatory findings.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "The federal securities laws and state regulations require firms to maintain comprehensive records of their activities. Rule 204-2 under the Investment Advisers Act lays out the books-and-records requirements for RIAs; SEC Rule 17a-4 covers broker-dealers. Most retention periods are 5-7 years; some are longer. The requirements are detailed and not optional. Books-and-records deficiencies are among the most common findings in regulatory exams because the rules cover so much."},
          {"type": "subheading", "content": "Required records — RIA highlights"},
          {"type": "list", "items": [
            "Journal of all cash receipts and disbursements, including securities transactions",
            "General and auxiliary ledgers reflecting asset, liability, reserve, capital, income, and expense accounts",
            "Memoranda of every order given for the purchase or sale of securities (whether executed or not), with appropriate detail",
            "All check books, bank statements, cancelled checks, cash reconciliations",
            "All bills or statements relating to the business",
            "All trial balances, financial statements, internal audit working papers",
            "Originals of all written communications received and copies of all written communications sent relating to investment recommendations or advice given",
            "Lists of advised accounts and required client identifying information",
            "Records of every transaction in the firm's proprietary accounts",
            "Copies of advertisements, brochures, and other marketing materials with required supporting documentation",
            "Personal securities transaction records for access persons (employees with access to nonpublic client info)",
            "Code of ethics and records related to its administration"
          ]},
          {"type": "subheading", "content": "Retention periods"},
          {"type": "paragraph", "content": "Most records must be kept for 5 years from the end of the fiscal year in which the record was created — with the first 2 years in an 'easily accessible' place. Some records have longer retention requirements: organizational documents, partnership agreements, articles of incorporation, and similar foundational documents must be kept for at least 3 years after termination of the entity. Records related to written ESG/responsibility marketing have specific retention. Records of conditions giving rise to disqualification of personnel may be kept indefinitely."},
          {"type": "subheading", "content": "Electronic records and storage"},
          {"type": "paragraph", "content": "Modern firms store most records electronically. SEC and FINRA rules permit electronic record storage but require: the records be preserved exclusively in non-rewriteable, non-erasable format (WORM — Write Once Read Many) or equivalent; the records be readily accessible and producible during their retention period; the firm have systems for backing up and protecting the records; the firm be able to produce records to regulators on request in usable form. Most cloud-based record systems used in financial services are designed to satisfy these requirements; firms should verify that the specific systems they use meet the rule's requirements."},
          {"type": "subheading", "content": "Email and electronic communications"},
          {"type": "paragraph", "content": "Email and other electronic business communications must be captured and retained per the same books-and-records rules. FINRA and SEC have penalized many firms — sometimes for hundreds of millions of dollars — for off-channel communications (text messages, encrypted apps, personal email) that were used for business purposes but not captured. Modern firms typically use email archiving systems (Smarsh, Global Relay, others) that capture all business email; some also capture text messages and chat platforms. The principle: every business communication is a record subject to the rules. Personal channels for business use are violations."},
          {"type": "callout", "kind": "warn", "content": "Using personal text, WhatsApp, Signal, or any non-archived channel for business communications is a serious compliance violation that has produced hundreds of millions in fines across the industry. Use only firm-approved channels for client communications."},
          {"type": "subheading", "content": "Client records"},
          {"type": "paragraph", "content": "Client-specific records include the advisory agreement, suitability documentation, IPS, fee billing records, performance reports, all written communications, meeting notes, and any other records of the relationship. These must be maintained for the same retention periods. When a client relationship terminates, the records remain — not destroyed at termination, but retained per the books-and-records timeline."},
          {"type": "subheading", "content": "Records during examinations"},
          {"type": "paragraph", "content": "During an SEC or state exam, records will be requested. The firm has obligations to produce records promptly and in usable form. The exam request may include very specific records (all emails between Advisor A and Client B between dates X and Y), specific reports (all advisory fees billed in 2023 over $10,000), or broad samples. A well-maintained records system can respond efficiently; a poorly-maintained one cannot. Many exam findings are not about underlying conduct but about the firm's ability to produce records — a deficiency in itself."},
          {"type": "case_study", "title": "The text-message problem", "scenario": "A small RIA discovers during an internal review that several advisors have been using personal text messages with clients — coordinating meetings, answering quick questions, occasionally discussing portfolio matters. None of these messages are captured in the firm's email archive. The total volume over the past year is estimated at several hundred messages. The firm's compliance officer raises this immediately. Remediation: issue firm-approved mobile communication tools that integrate with the archiving system; train all staff that personal channels are off-limits for business; conduct a sampling review of the discovered text messages for any substantive client matters that need to be preserved as records; self-report to the firm's regulator depending on severity.", "discussion": "Self-reporting a discovered issue, combined with prompt remediation, is far preferred to the regulator finding it independently. The industry has been hit with hundreds of millions in fines over text-message issues; firms that surface and remediate proactively fare much better."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "The SEC Marketing Rule",
        "summary": "The SEC's Marketing Rule (effective November 2022) replaced the prior advertising rule and significantly changed how RIAs can market. Knowing it is essential for anyone preparing client-facing material.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Rule 206(4)-1 under the Investment Advisers Act — known as the Marketing Rule — replaced the prior advertising rule effective November 4, 2022. It modernized the rules around advertising, testimonials, endorsements, third-party ratings, and performance presentation. It is comprehensive, principles-based, and now governs essentially all RIA communications intended to obtain or retain advisory clients. Apprentices who prepare any client-facing material need to know it cold."},
          {"type": "subheading", "content": "What counts as an 'advertisement'"},
          {"type": "paragraph", "content": "Under the Marketing Rule, an advertisement is any direct or indirect communication by an investment adviser to more than one person (or to one or more persons if it includes hypothetical performance) that offers the adviser's services or new investment advisory services. It also includes any endorsement or testimonial for which an adviser provides compensation. The definition is broad and intentionally so — it captures website content, email blasts, social media posts, presentations, written marketing materials, and many other communications."},
          {"type": "subheading", "content": "General prohibitions"},
          {"type": "list", "items": [
            "Untrue statements of material fact or omissions of material fact necessary to prevent statements from being misleading",
            "Statements the adviser does not have a reasonable basis to believe it can substantiate",
            "Statements that imply the adviser would not otherwise reach without substantial qualifications that are not also presented",
            "Statements that fail to provide fair and balanced treatment of material risks and limitations",
            "Statements about specific investment advice the adviser provided in a way that is not fair and balanced",
            "Otherwise materially misleading information in any way"
          ]},
          {"type": "subheading", "content": "Testimonials and endorsements"},
          {"type": "paragraph", "content": "The Marketing Rule permits testimonials (from clients) and endorsements (from non-clients) — both prohibited under the prior rule — subject to specific conditions. Required disclosures include: whether the speaker is a client or non-client; whether cash or non-cash compensation was paid; and material conflicts of interest. Compensated testimonials and endorsements require a written agreement and adviser oversight. There are detailed rules around what counts as a testimonial vs an endorsement and what counts as a third-party rating."},
          {"type": "subheading", "content": "Performance advertising"},
          {"type": "paragraph", "content": "Performance presentations in marketing must follow detailed requirements: gross and net performance both presented with equal prominence; specific time periods (1-, 5-, and 10-year, or since inception for shorter records); use of related performance (similar accounts) with appropriate disclosures; restrictions on hypothetical performance (which requires policies designed to ensure relevance to the intended audience); restrictions on extracted performance (showing just one slice of a strategy); and various other technical requirements. Anyone preparing performance marketing without compliance review is operating in a high-risk area."},
          {"type": "callout", "kind": "warn", "content": "Performance advertising under the Marketing Rule is detailed and technical. Have compliance review any performance content before publication. Errors here are easy to make and expensive to correct."},
          {"type": "subheading", "content": "Hypothetical performance"},
          {"type": "paragraph", "content": "Hypothetical performance — including model performance, backtested performance, and targeted/projected performance — is allowed but requires specific policies and procedures, plus disclosures including the criteria used to select the audience and the inherent limitations of hypothetical performance. Importantly, hypothetical performance generally cannot be included in advertisements aimed at the general public (e.g., publicly accessible websites); it must be appropriately targeted to recipients for whom it is relevant."},
          {"type": "subheading", "content": "Third-party ratings and awards"},
          {"type": "paragraph", "content": "Using third-party ratings or awards (Forbes 'Top Advisors,' Barron's lists, etc.) in marketing requires specific disclosures: the date the rating was given; the period covered; the third party that did the rating; whether and how the adviser paid for it; the criteria used. These ratings are often industry-marketing rather than independent assessments — using them without disclosure is a violation."},
          {"type": "subheading", "content": "Social media"},
          {"type": "paragraph", "content": "Social media posts by the firm or by individual advisors that meet the advertisement definition are subject to the Marketing Rule. Firms typically maintain social media policies that govern what advisors can post (often requiring pre-clearance for substantive content), how interactions are handled, and how the content is archived. Liking or sharing third-party content can sometimes constitute adoption of that content as the adviser's own marketing — a subtle trap. Apprentices should review the firm's social media policy carefully and ask compliance before posting anything client-facing."},
          {"type": "case_study", "title": "The website update that triggered compliance", "scenario": "An apprentice is asked to draft updated content for the firm's website 'About Us' page. The draft includes language about the firm's performance ('Our clients' portfolios have outperformed the broader market over the past five years') and a couple of client quotes praising the firm. The apprentice routes the draft to compliance before publishing. Compliance flags multiple issues: the performance claim needs specific support, presentation, and disclosures per the Marketing Rule; the client quotes are testimonials that require disclosure of whether the clients are compensated and any conflicts of interest. The draft is reworked: performance claim removed (the supporting documentation would have been extensive); testimonials retained with required disclosures clearly displayed. The page goes live two weeks later in compliant form.", "discussion": "The apprentice's instinct to route to compliance before publishing was correct. The original draft, posted without review, could have generated a violation. Build the habit: any client-facing communication beyond routine correspondence goes through compliance review."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Supervision, Personal Trading, and the Code of Ethics",
        "summary": "Supervision rules require firms to oversee the conduct of their personnel. Personal trading rules constrain employees with access to client information. Together they form the structural integrity of advisory practice.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An advisory firm is not just a collection of individuals — it is a regulated entity with responsibility for the conduct of everyone working under its umbrella. Supervision rules require firms to design and implement reasonable procedures for overseeing personnel; personal trading rules constrain certain employees from trading in ways that could conflict with clients; the firm's Code of Ethics codifies the standards expected of everyone. Together these form the structural integrity of the firm's operations."},
          {"type": "subheading", "content": "Supervision under SEC and FINRA rules"},
          {"type": "paragraph", "content": "SEC Rule 206(4)-7 requires RIAs to adopt and implement written compliance policies and procedures reasonably designed to prevent violations of the Advisers Act. FINRA Rule 3110 requires broker-dealers to establish supervisory systems including written procedures, designated supervisors, and reasonable supervision of associated persons. Both rules require an annual review of the compliance program's effectiveness. The Chief Compliance Officer (CCO) typically owns this work; everyone else operates within the framework the CCO maintains."},
          {"type": "subheading", "content": "Personal trading and Access Persons"},
          {"type": "paragraph", "content": "Access Persons are employees who have access to nonpublic information about client transactions or holdings. Apprentices are typically Access Persons from day one. Access Persons are subject to personal trading restrictions designed to prevent front-running, conflicts, and the appearance of impropriety. Common requirements: pre-clearance of certain personal trades; quarterly reporting of all personal securities transactions; annual reporting of all securities holdings; restrictions on trading in securities the firm is buying or selling for clients; restrictions on participation in IPOs and limited offerings."},
          {"type": "callout", "kind": "warn", "content": "Personal trading violations are one of the most common pathways to professional discipline for individuals in advisory roles. The cost of pre-clearing a personal trade is two minutes. The cost of an enforcement action is career-ending. Pre-clear when uncertain."},
          {"type": "subheading", "content": "The Code of Ethics"},
          {"type": "paragraph", "content": "Rule 204A-1 under the Advisers Act requires RIAs to adopt a written Code of Ethics. The Code must include: standards of business conduct reflecting the firm's fiduciary duty; provisions for compliance with applicable federal securities laws; reporting of personal securities transactions by Access Persons; reporting of violations of the Code; review and certification by each Access Person of receipt of the Code and its amendments. Most firm Codes go beyond the minimum to articulate the firm's values and expected conduct."},
          {"type": "subheading", "content": "Conflicts of interest disclosure and management"},
          {"type": "paragraph", "content": "Form ADV Part 2 requires disclosure of conflicts of interest. The Code of Ethics requires their management. Common conflicts: receiving compensation from product sponsors; receiving non-cash compensation (gifts, travel) from vendors or referral sources; outside business activities by employees; political contributions in 'pay to play' contexts; family relationships with clients or vendors. Each must be disclosed in Form ADV (in appropriately specific terms) and managed through the firm's policies. Annual training typically reinforces the conflicts framework."},
          {"type": "subheading", "content": "Whistleblower and reporting policies"},
          {"type": "paragraph", "content": "Firms must have channels for personnel to report suspected violations without retaliation. The SEC's whistleblower program provides financial incentives for outside reporting of securities law violations, but the firm's internal channels should be the first line. A culture where personnel feel able to raise concerns to compliance — or where appropriate, to an independent body — is part of healthy operations. The CCO's accessibility matters."},
          {"type": "subheading", "content": "Gifts, entertainment, and outside activities"},
          {"type": "list", "items": [
            "Most firms have gift limits — both for giving to clients/prospects and for receiving from vendors/referral sources (e.g., $100 per year per recipient/source, or modest entertainment)",
            "Outside business activities (board memberships, side businesses, teaching, writing for compensation) typically require pre-approval and may need disclosure on Form ADV",
            "Political contributions can trigger 'pay to play' issues for advisers working with state and local government plans; many firms have pre-clearance for any political activity",
            "Personal investment in private offerings, alternative funds, or other limited investments often requires pre-clearance"
          ]},
          {"type": "subheading", "content": "Training and certification"},
          {"type": "paragraph", "content": "Most firms require annual training on the Code of Ethics, anti-money laundering (AML), cybersecurity, suitability, and other topics. Annual certifications from each employee — that they have read the Code, understand it, and certify their compliance — are part of the routine. Apprentices complete the same trainings as senior staff; the apprenticeship is not a partial-membership status when it comes to compliance."},
          {"type": "case_study", "title": "The pre-clearance that prevented a problem", "scenario": "An apprentice receives an email from a friend who runs a small startup, asking the apprentice to invest $5,000 as a friends-and-family round in the startup's seed financing. The apprentice is excited about the opportunity. Before sending money, the apprentice consults the firm's personal trading policy: limited offerings (which the seed round is) require pre-clearance. The apprentice submits a pre-clearance request to compliance with details on the issuer, the offering structure, the relationship to the apprentice. Compliance reviews: no firm client has a relationship with the startup; no conflict identified; investment within the firm's Access Person personal investment limits; approval granted with the requirement to report annually. The apprentice invests with documentation in place.", "discussion": "Without pre-clearance, the apprentice could have unknowingly created a conflict (if the startup later became a client or a counterparty) or violated the policy (if limited offerings were restricted). The pre-clearance step took 30 minutes and converted a risky decision into a documented and authorized one. Build the habit early."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Examinations and Regulatory Inquiries",
        "summary": "Examinations by the SEC, state regulators, and FINRA are routine for advisory firms. Knowing what to expect and how to prepare is part of operational maturity.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Registered investment advisers and broker-dealers are subject to periodic regulatory examinations. The SEC examines RIAs through its Division of Examinations (EXAMS); FINRA examines broker-dealers; state regulators examine state-registered RIAs and have authority over broker activity in their states. Exam frequency varies — large RIAs may see SEC exams every few years, smaller ones less often. Each exam follows a structured process. Preparing well makes the process manageable; preparing poorly makes it expensive."},
          {"type": "subheading", "content": "The exam process"},
          {"type": "numbered", "items": [
            "Notification — the regulator notifies the firm (typically by letter or email) that an examination will occur, with a list of initial document requests",
            "Initial document production — the firm produces requested records, typically over a 2-4 week window",
            "On-site or remote phase — examiners review documents, interview personnel, ask follow-up questions over days or weeks",
            "Follow-up requests — additional documents and clarifications as the examiners' understanding develops",
            "Exit conference — examiners summarize their preliminary findings and any concerns",
            "Deficiency letter (if any) — formal letter listing identified deficiencies and requesting remediation",
            "Firm response — the firm responds to the deficiency letter with planned and completed remediation",
            "Closure — the exam closes with no findings, with deficiencies remediated, or in serious cases with referral to enforcement"
          ]},
          {"type": "subheading", "content": "What examiners typically look at"},
          {"type": "list", "items": [
            "Form ADV — is it accurate, complete, and consistent with actual practice?",
            "Fees — are fees calculated correctly, disclosed in Form ADV, and applied per the advisory agreement?",
            "Books and records — is everything required being kept, in proper form, and producible on request?",
            "Marketing materials — do communications comply with the Marketing Rule?",
            "Performance reporting — are performance calculations accurate and disclosed properly?",
            "Trading practices — best execution, allocation fairness, soft dollars, personal trading",
            "Compliance program — is there a written program, is it implemented, is it reviewed annually?",
            "Cybersecurity — are reasonable safeguards in place for client information?",
            "Conflicts of interest — are they disclosed in Form ADV and managed?",
            "Custody — does the firm have custody as defined, and if so does it meet the custody rule requirements?"
          ]},
          {"type": "subheading", "content": "Common findings — what to avoid"},
          {"type": "list", "items": [
            "Fee calculation errors (over-billing, incorrect pro-rations, undisclosed fee changes)",
            "Form ADV inconsistencies (description of fees doesn't match actual practice, conflicts not disclosed, AUM misstated)",
            "Books and records gaps (missing emails, missing meeting notes, incomplete trade documentation)",
            "Marketing rule violations (testimonials without disclosure, performance presentations without required elements, hypothetical performance issues)",
            "Inadequate compliance program (no annual review, no current procedures, untrained personnel)",
            "Custody rule violations (inadvertent custody without surprise audit)",
            "Personal trading policy violations or inadequate review"
          ]},
          {"type": "subheading", "content": "Preparing for examinations — ongoing readiness"},
          {"type": "paragraph", "content": "The best preparation for an examination is ongoing operational discipline. Firms that maintain clean records, follow their stated policies, document everything as it happens, and review their compliance program annually are ready for exams whenever they come. Firms that scramble when an exam notice arrives are signaling deeper issues. The discipline of operating as-if-being-examined is the right baseline."},
          {"type": "subheading", "content": "Apprentices in exams"},
          {"type": "paragraph", "content": "Examiners may interview apprentices and other staff to understand how the firm actually operates. The right approach: answer questions truthfully, do not speculate beyond what you know, do not embellish, do not minimize, do not hide anything that should be known. If you do not know an answer, say so. If you need to check a record, say so. Compliance and senior leadership typically prepare staff before interviews — listen to that preparation. Examiners are not adversaries; they are doing their job. Cooperate professionally."},
          {"type": "callout", "kind": "do", "content": "In any exam interview, the goal is accuracy, not advocacy. Answer what is asked, in scope, truthfully. Do not volunteer beyond the question. Do not speculate. Defer to compliance on anything you are not certain about."},
          {"type": "subheading", "content": "Responding to deficiencies"},
          {"type": "paragraph", "content": "When an exam produces deficiencies, the firm responds with a remediation plan: what was found, what the firm did or will do to fix it, by when, and what controls will prevent recurrence. Take deficiencies seriously even when they seem technical. Patterns of unaddressed deficiencies escalate. Most deficiencies are resolved at the exam-letter level; serious or unaddressed deficiencies can escalate to enforcement actions, with consequences ranging from censure to fines to license revocation."},
          {"type": "case_study", "title": "The exam that found three things", "scenario": "A small RIA is examined by the SEC for the first time. The exam takes six weeks. Three findings in the deficiency letter: (1) Form ADV described a fee schedule that did not exactly match the actual fee invoices for several clients; (2) the firm's compliance program had not been reviewed in writing in the past 18 months; (3) some emails from a departed former advisor had been retained outside the firm's archived system. The firm responds within 30 days: Form ADV corrected and reconciled against billing; compliance program annual review completed and dated; emails retrieved from former-advisor's local archive and added to the central archive. The firm also self-audits the prior 24 months for any similar gaps. The exam closes with the deficiencies remediated and no further action.", "discussion": "None of the findings were intentional misconduct. All were operational gaps — exactly what exams typically find. The firm's prompt, complete, transparent response converted a stressful event into a process improvement. Many firms experience this; not all respond as well. Cooperation and remediation matter."},
          {"type": "callout", "kind": "key", "content": "Compliance is the structural framework that lets the firm do the actual work of helping clients well. Treat it as integral to the practice, not as overhead."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Cybersecurity & Data Protection — the protection of client information that has become one of the most consequential operational disciplines in modern advisory practice."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Registered investment advisers with $100M or more in AUM generally register with:", "options": ["State regulators only", "The SEC", "FINRA", "The Department of Labor"], "correct": 1, "explanation": "The $100M AUM threshold separates state-registered RIAs from SEC-registered RIAs. Some smaller RIAs operating in 15+ states may also register with the SEC."},
        {"id": "q2", "prompt": "FINRA is best described as:", "options": ["A government agency", "A self-regulatory organization for broker-dealers operating under SEC oversight", "An insurance company", "A trade association without regulatory authority"], "correct": 1, "explanation": "FINRA is an SRO — not a government agency but functioning as a regulator under SEC oversight. It administers exams, sets rules, conducts exams, and disciplines members."},
        {"id": "q3", "prompt": "Books-and-records retention periods under SEC Rule 204-2 for RIAs are generally:", "options": ["1 year", "2 years", "5 years from the end of the fiscal year in which the record was created, with the first 2 years easily accessible", "Indefinite"], "correct": 2, "explanation": "5-year retention is the standard for most records, with the first 2 years required to be easily accessible. Some records have longer requirements."},
        {"id": "q4", "prompt": "Using personal text messages, WhatsApp, or other non-archived channels for business communications is:", "options": ["Permissible if disclosed", "A serious compliance violation that has produced hundreds of millions in industry fines; only firm-approved archived channels should be used", "Required for client convenience", "Acceptable for client preferences"], "correct": 1, "explanation": "Off-channel communications violate books-and-records rules. The industry has been heavily penalized for this. All business communications must use archived channels."},
        {"id": "q5", "prompt": "The SEC Marketing Rule (Rule 206(4)-1, effective November 2022):", "options": ["Prohibits all marketing by RIAs", "Replaced the prior advertising rule and modernized rules around testimonials, endorsements, performance, and third-party ratings, subject to detailed conditions", "Applies only to print advertising", "Applies only to broker-dealers"], "correct": 1, "explanation": "The Marketing Rule modernized the framework, permitting testimonials and endorsements with required disclosures and detailed conditions for performance and hypothetical performance presentation."},
        {"id": "q6", "prompt": "Under the Marketing Rule, testimonials from clients in advertisements require disclosure of:", "options": ["Nothing — testimonials are unrestricted", "Whether the speaker is a client or non-client, whether compensation was paid, and material conflicts of interest", "Only the client's full name", "Only past performance"], "correct": 1, "explanation": "Testimonials are permitted but require specific disclosures: status (client vs non-client), compensation, and conflicts. Compensated testimonials also require written agreements and adviser oversight."},
        {"id": "q7", "prompt": "Access Persons under personal trading rules are:", "options": ["Only senior partners", "Employees who have access to nonpublic information about client transactions or holdings — apprentices typically qualify from day one", "Only persons holding Series 65", "Persons outside the firm"], "correct": 1, "explanation": "Access Persons is broadly defined and includes essentially anyone with access to client info. Apprentices typically are Access Persons immediately."},
        {"id": "q8", "prompt": "Pre-clearance of personal trades by Access Persons exists to:", "options": ["Slow down employees", "Prevent front-running, conflicts, and the appearance of impropriety; the 2-minute process prevents career-ending violations", "Generate fees for compliance", "Restrict employees from investing"], "correct": 1, "explanation": "Pre-clearance is structural prevention of personal trading violations. The friction is small versus the cost of a violation."},
        {"id": "q9", "prompt": "Rule 204A-1 requires RIAs to adopt:", "options": ["A custody plan", "A written Code of Ethics with specific required elements including standards of conduct and personal trading reporting", "A marketing budget", "An audit committee"], "correct": 1, "explanation": "The Code of Ethics is a required document under Rule 204A-1 with specific minimum content including conduct standards, personal trading reporting, and violation reporting."},
        {"id": "q10", "prompt": "During a regulatory examination interview, the right approach is to:", "options": ["Advocate for the firm and minimize any issues", "Answer truthfully, in scope, defer to compliance on anything uncertain, and not embellish or speculate", "Refuse to answer most questions", "Volunteer extensive information beyond the questions asked"], "correct": 1, "explanation": "Examiners want accuracy. Cooperate professionally, answer truthfully, do not speculate, and defer when uncertain. This is the right baseline for any interview."},
        {"id": "q11", "prompt": "Common exam findings include:", "options": ["Only intentional fraud", "Operational gaps — fee calculation errors, Form ADV inconsistencies, books and records gaps, marketing rule issues — that are not malicious but are deficiencies", "Only major investment losses", "Only insufficient profits"], "correct": 1, "explanation": "Most exam findings are operational rather than intentional misconduct. The discipline is in preventing the gaps through ongoing operational rigor."},
        {"id": "q12", "prompt": "The best preparation for a regulatory examination is:", "options": ["Last-minute document gathering when the notice arrives", "Ongoing operational discipline — maintaining clean records, following stated policies, documenting as you go, and reviewing the compliance program annually", "Hiring an outside law firm", "Reducing client communications"], "correct": 1, "explanation": "Firms that operate as-if-being-examined are ready whenever exams arrive. Last-minute preparation signals deeper issues."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 28;

-- ── module28_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 28 CONTENT
-- Cybersecurity & Data Protection
-- ============================================================================
update public.modules set
  title = 'Cybersecurity & Data Protection',
  competency_id = 'OJL-19',
  ri_hours = 0,
  ojl_hours = 60,
  short_description = 'Protect client data, money, and trust against the threats that target financial advisors specifically — wire fraud, account takeover, phishing, and the human-engineering attacks that exploit relationships.',
  learning_objectives = ARRAY[
    'Identify the most common attack vectors targeting financial advisors and their clients',
    'Apply authentication, encryption, and access control best practices to daily work',
    'Recognize and stop wire fraud and impersonation attempts before money moves',
    'Respond to a suspected breach following firm protocol and regulatory requirements',
    'Educate clients on the security practices that protect them outside the firm'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Why Financial Advisors Are a Target",
        "summary": "Financial advisor firms hold money, client trust, and the ability to move both. That combination makes them one of the most attractive targets in the economy.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A criminal looking for the highest-value, lowest-friction target in the financial system rarely picks a retail bank — banks have spent billions on fraud detection. They pick the small-to-mid-sized RIA or independent broker-dealer where one apprentice with email access can be tricked into wiring $80,000 to a fraudulent account. Every advisor firm should assume they are being probed continuously. The question is not whether you will be attacked but whether your defenses will hold the attack you cannot see coming."},
          {"type": "callout", "kind": "key", "content": "The threat model for a financial advisor is not random hackers. It is patient, sophisticated attackers who study your firm, your clients, and your communication patterns — often for weeks — before making a single move."},
          {"type": "subheading", "content": "The attack surface"},
          {"type": "list", "items": [
            "Email — by far the most common attack vector; phishing, business email compromise (BEC), impersonation",
            "Voice — vishing calls impersonating clients, custodians, or firm executives",
            "Text/SMS — smishing, often combined with email to add legitimacy",
            "Client portals and login pages — credential stuffing, session hijacking",
            "Physical — laptops, paper documents, office access, dumpster diving",
            "Vendor and supply chain — your custodian's portal, your CRM, your file-sharing tool",
            "Insider threat — employees with access, contractors, departing staff"
          ]},
          {"type": "subheading", "content": "The specific attacks you will see"},
          {"type": "glossary", "terms": [
            {"term": "Business Email Compromise (BEC)", "definition": "Attacker gains access to or convincingly spoofs an email account inside the firm or at a client. Uses it to authorize a wire, change beneficiary, or request sensitive documents. Highest-dollar attack in finance."},
            {"term": "Spear phishing", "definition": "Targeted phishing using information specific to the target — name, role, recent activity. Distinguishable from mass phishing by personalization."},
            {"term": "Account takeover (ATO)", "definition": "Attacker gains login credentials and accesses a client's brokerage or banking account, often to wire funds or change settings."},
            {"term": "Wire fraud via impersonation", "definition": "Attacker impersonates a client (or staff) and instructs a wire to a fraudulent account. Often follows email compromise."},
            {"term": "Ransomware", "definition": "Malware that encrypts firm data and demands payment for the decryption key. Increasingly common in financial services."},
            {"term": "Pretexting", "definition": "Constructing a false story to get the target to share information or take action — 'I'm the new compliance officer at Schwab and I need to verify...' "},
            {"term": "Credential stuffing", "definition": "Using usernames/passwords leaked from breaches at other sites to try logins on financial sites — works because people reuse passwords."}
          ]},
          {"type": "case_study", "title": "The Friday afternoon wire", "scenario": "An apprentice receives an email at 3:30pm on a Friday from a long-standing client. 'I need to wire $87,000 to my contractor today for a home renovation deposit. Account info attached. Please process immediately so it goes out before the cutoff. I'm in meetings the rest of the day so just confirm by email when done.' The email is from the client's actual email address. The signature is correct. The language is plausible. The wiring instructions look professional. The apprentice processes the wire.", "discussion": "The wire went to an attacker. The client's email was compromised three weeks earlier. The attacker had been reading the email traffic, learning the communication style, and waiting for an opportunity. Friday afternoon was selected because it delays discovery — the client won't see the unsent reply or notice the missing funds until Monday. By then, the money is overseas. Loss: $87,000. The apprentice did everything email-asked them to do. They did not verify out-of-band. That is the failure."},
          {"type": "callout", "kind": "warn", "content": "Any wire instruction received only via email is suspect by default. The cost of a five-minute phone call to verify is nothing. The cost of not making the call can be career-ending."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Authentication, Encryption, and Access Controls",
        "summary": "The technical foundations that prevent most attacks — covered at a level every apprentice needs to actually use, not just nod along to.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most security incidents in financial advisor firms are not exotic. They are basic controls that were missing or applied inconsistently. Strong authentication, encrypted communications, and disciplined access controls block the vast majority of attempts. The fancy attacks make headlines; the basics prevent the headlines."},
          {"type": "subheading", "content": "Multi-factor authentication (MFA) — non-negotiable"},
          {"type": "paragraph", "content": "Every login that touches client data or firm systems should require at least two factors: something you know (password) plus something you have (authenticator app, hardware key, or push notification). SMS-based 2FA is better than nothing but is vulnerable to SIM-swap attacks and should be replaced with app-based or hardware-key factors wherever the option exists. The order of preference: hardware security key (YubiKey, Titan) > authenticator app (Authy, Google Authenticator, 1Password) > push notification > SMS."},
          {"type": "list", "items": [
            "Email account — MFA required, preferably hardware key",
            "Custodian portals — MFA required",
            "CRM — MFA required",
            "VPN — MFA required",
            "Cloud storage (Google Drive, Dropbox, OneDrive) — MFA required",
            "Personal accounts that touch work — also MFA, especially personal email that receives password resets"
          ]},
          {"type": "subheading", "content": "Password hygiene"},
          {"type": "paragraph", "content": "Long, unique, machine-generated passwords stored in a password manager. Never reuse a password across accounts — credential stuffing makes that catastrophic if any one site is breached. The password manager is the single most impactful security investment most people can make. Pick one (1Password, Bitwarden, Dashlane), use it for everything, lock it behind a strong master password and MFA."},
          {"type": "subheading", "content": "Encryption — at rest and in transit"},
          {"type": "list", "items": [
            "Laptop/device disk encryption — FileVault on Mac, BitLocker on Windows; on by default for new devices, verify it is on yours",
            "Email — TLS in transit is the minimum; for sensitive content, use encrypted portals or PGP-signed attachments",
            "File sharing with clients — never email attachments containing SSNs, account numbers, or signed forms; use the firm's secure document portal",
            "Mobile devices — passcode, biometric lock, remote wipe capability enabled",
            "Backups — encrypted, with the encryption key stored separately from the backup"
          ]},
          {"type": "subheading", "content": "Access controls — least privilege"},
          {"type": "paragraph", "content": "An apprentice should have access to exactly the systems and clients required for their work — not more. Custodian master accounts, payroll, vendor management systems, and other sensitive areas typically should not be in an apprentice's access list. When access is needed temporarily, it is granted temporarily and removed afterward. Departing staff have access revoked the same day. Inactive accounts are flagged and removed quarterly. Audit logs are reviewed periodically."},
          {"type": "callout", "kind": "do", "content": "Once a quarter, walk through your own access list and ask: do I still need this? If not, ask for it to be removed. The smaller your access footprint, the less damage an attacker who compromises your account can do."},
          {"type": "subheading", "content": "Phishing awareness as a continuous skill"},
          {"type": "paragraph", "content": "Phishing emails are designed to bypass your conscious attention — they create urgency, invoke authority, or appeal to helpfulness so you click before you think. Train yourself to pause on any email that creates urgency, asks you to click a link to verify credentials, comes from an unexpected sender about a sensitive topic, has a slightly-off email address (paypa1.com instead of paypal.com), or asks you to bypass normal processes. Hover over links before clicking. When in doubt, report it. False alarms are fine. Falling for a real phish is not."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Wire Fraud and the Verification Discipline",
        "summary": "Wire fraud is the single highest-loss event most advisor firms face. The defense is verification — slow, sometimes annoying, always non-negotiable.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The FBI's Internet Crime Complaint Center (IC3) reports billions of dollars annually in business email compromise and wire fraud losses, with financial services consistently among the top-targeted sectors. A successful wire fraud at a small advisory firm can be an extinction event — both for the client and potentially for the firm's reputation. There is one defense that works: out-of-band verification of every wire instruction, every time."},
          {"type": "subheading", "content": "The verification protocol"},
          {"type": "numbered", "items": [
            "Any wire request received via email or text must be verbally verified by calling the client at a known phone number — not a number provided in the email",
            "Known phone number means the number in your CRM that was established before this request — not a new number, not a number in the email signature, not what the client mentions in a follow-up message",
            "Confirm the dollar amount, the receiving institution, the routing and account numbers, and the purpose of the wire — all verbally",
            "If you cannot reach the client, do not process the wire — full stop. The wire can wait. Money lost cannot be recovered",
            "Document the verification call — date, time, who was called, what was confirmed",
            "For wires above certain thresholds (typically $50,000 or as firm policy specifies), require a second team member to also verify"
          ]},
          {"type": "callout", "kind": "key", "content": "If you only learn one thing from this module: never wire money based only on a written request. Voice verification, every time, no exceptions, even when the client gets impatient."},
          {"type": "subheading", "content": "Common social engineering patterns to recognize"},
          {"type": "list", "items": [
            "Urgency — 'I need this done today, by end of day, in the next hour'",
            "Confidentiality — 'Do not mention this to my spouse/business partner/anyone'",
            "Bypass — 'I know we usually verify by phone, but I'm in meetings; just process it'",
            "Authority — 'The senior advisor already approved this on the phone, just push it through'",
            "Plausibility — small details (recent vacation, family member's name, recent purchase) intended to confirm legitimacy",
            "Friday afternoon timing — delays discovery over the weekend",
            "Slight email address variations — clientname@gmail.com vs clientname@gmai1.com"
          ]},
          {"type": "subheading", "content": "What to do when you suspect fraud"},
          {"type": "numbered", "items": [
            "Stop the transaction immediately — do not process, do not engage with the suspicious party further",
            "Notify your supervisor or compliance officer immediately, by voice, not email (the email may also be compromised)",
            "If a wire has already been initiated, contact the sending bank within minutes to request a recall — recall windows can be as short as a few hours",
            "Contact the client at a known phone number to confirm whether the request was legitimate",
            "Document everything — every email, every timestamp, every call",
            "Report to authorities: FBI IC3 (ic3.gov) for federal reporting; FINRA if applicable; state regulators per your firm's protocol",
            "If client information was potentially exposed, the firm's breach notification protocol begins"
          ]},
          {"type": "case_study", "title": "The wire that was stopped", "scenario": "A second apprentice at the same firm receives a similar Friday-afternoon wire request three months after the prior incident. This time the firm has revised protocol: no wire is processed without voice verification regardless of urgency. The apprentice calls the client at the number in the CRM. The client answers, surprised: 'I didn't send any wire request. I'm not doing any renovations.' The apprentice immediately escalates. Investigation reveals the client's email had been compromised the week before — the attacker had been monitoring. Loss prevented: $112,000.", "discussion": "Same attack pattern. Different outcome. The only variable that changed was protocol. Voice verification is the entire defense against the highest-loss attack the firm faces. Make it sacred. Annoying clients with a 90-second phone call is the trade-off. The client whose money was protected will thank you. The one whose money you wired without verifying will not."},
          {"type": "callout", "kind": "warn", "content": "Clients sometimes complain about verification calls. 'You should know it's me by now.' Smile, agree it's a hassle, complete the verification. The most important moment to verify is the moment when the client is most annoyed by it — that emotional pressure is sometimes engineered to bypass you."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Privacy, the GLBA, and Regulation S-P",
        "summary": "Federal privacy law has specific requirements for how advisor firms handle client information. Knowing the rules protects clients and keeps the firm in compliance.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "The Gramm-Leach-Bliley Act (GLBA) and the SEC's Regulation S-P together establish the federal framework for how financial institutions, including investment advisors and broker-dealers, must handle nonpublic personal information (NPI) about their clients. These are not advisory guidelines. They are enforceable requirements with civil penalties, examination findings, and reputational consequences for non-compliance."},
          {"type": "subheading", "content": "What is NPI?"},
          {"type": "paragraph", "content": "Nonpublic personal information includes any information about a client that is not publicly available and was obtained in connection with providing a financial service. Names, addresses, Social Security numbers, account numbers, balances, transaction history, financial conditions, and any inferences drawn from such information are all NPI. The default is privacy — assume any information about a client is NPI unless you can specifically establish it is public."},
          {"type": "subheading", "content": "Reg S-P key requirements"},
          {"type": "list", "items": [
            "Initial privacy notice to clients at the start of the relationship explaining the firm's information practices",
            "Annual privacy notice (with some exceptions under the FAST Act for firms whose policies have not changed and who do not share with non-affiliated third parties)",
            "Opt-out rights for certain disclosures to non-affiliated third parties",
            "Safeguards Rule — written policies and procedures reasonably designed to protect customer records and information",
            "Disposal Rule — proper destruction of consumer report information when no longer needed",
            "Breach notification — Reg S-P amendments effective 2025 require notice to affected individuals within 30 days of becoming aware of a breach involving sensitive customer information (with limited exceptions)"
          ]},
          {"type": "callout", "kind": "note", "content": "The 2024 SEC amendments to Reg S-P significantly strengthened breach notification requirements. Firms must now have incident response programs in place and notify affected individuals within 30 days when sensitive customer information has been or is reasonably likely to have been accessed or used without authorization."},
          {"type": "subheading", "content": "State privacy laws add another layer"},
          {"type": "paragraph", "content": "California (CCPA/CPRA), Virginia (VCDPA), Colorado (CPA), Connecticut, and others have enacted state privacy laws that may apply in addition to federal requirements. The New York Department of Financial Services Part 500 (the Cybersecurity Regulation) applies to firms covered by NYDFS. For firms serving clients in multiple states, the patchwork matters. Know which states apply to your client base."},
          {"type": "subheading", "content": "Daily practices that comply"},
          {"type": "list", "items": [
            "Never discuss client information in public spaces (coffee shops, airplanes, restaurants) where it can be overheard",
            "Lock your screen when stepping away from your desk",
            "Shred paper documents containing NPI rather than throwing them in regular trash",
            "Use the firm's secure document portal for any client paperwork transmission — not personal email, not personal cloud storage",
            "When sharing a screen with a colleague, ensure no other client's information is visible",
            "Be cautious with voicemails to clients — leave generic call-back requests, not specifics",
            "When clients are introduced to each other (referrals, events), get explicit consent before sharing any identifying information"
          ]},
          {"type": "subheading", "content": "Vendor and third-party considerations"},
          {"type": "paragraph", "content": "When your firm uses third-party vendors that may access NPI — CRM providers, planning software, document management, file storage — the firm is responsible for vendor security. This is typically managed through vendor due diligence questionnaires, written agreements with confidentiality and security requirements, and ongoing monitoring. For an apprentice, the practical implication is: do not introduce a new tool that touches client data without compliance/IT review, even if it would be convenient."},
          {"type": "case_study", "title": "The convenient cloud folder", "scenario": "An apprentice has been emailing scanned client documents to themselves and storing them in a personal Google Drive folder for easier access from home. Discovered during a compliance review. The firm's official document storage is encrypted with audit logs and access controls; the personal Google Drive is not. The apprentice's intent was efficiency, not malice. Compliance still has to: log the incident, assess scope of NPI potentially exposed, evaluate notification requirements, remediate the storage, and discipline the conduct. The apprentice receives written warning and remedial training.", "discussion": "The temptation to use familiar consumer tools (personal email, personal cloud, personal text) for work is constant. Resist it always. The firm's tools exist for compliance reasons. Going around them — even for convenience, even with good intentions — creates real legal exposure for the firm and the client."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Incident Response and Client Education",
        "summary": "When something goes wrong, the firm's response in the first 24 hours determines whether a problem becomes a crisis. And the best long-term defense is clients who themselves know what to watch for.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Cybersecurity incidents are not theoretical for advisor firms — they are routine. Most firms will experience some form of incident within any given year, ranging from a single phishing email someone almost clicked to a confirmed compromise. The difference between a routine incident and a catastrophe is the response. Plan it before you need it."},
          {"type": "subheading", "content": "The first 24 hours after a suspected incident"},
          {"type": "numbered", "items": [
            "Contain — immediately isolate affected systems or accounts (disable the compromised email, force password resets, revoke sessions)",
            "Document — preserve evidence; do not delete the phishing email or the suspicious activity logs",
            "Escalate — notify the firm's incident response lead (CISO, compliance officer, or designated principal) immediately",
            "Assess scope — what data, what clients, what time window, what systems",
            "Notify outside counsel and the cyber insurance carrier per firm protocol — engaging counsel early may help preserve attorney-client privilege over the investigation",
            "Engage forensics — outside firms specialized in incident response are usually needed; do not try to investigate complex incidents alone",
            "Plan notifications — clients, custodians, regulators per applicable timelines"
          ]},
          {"type": "callout", "kind": "warn", "content": "The first hour matters most. A compromised email account being used to send fraudulent wire instructions to clients can do enormous damage in 60 minutes. Containment beats investigation in the immediate term."},
          {"type": "subheading", "content": "Regulatory notification obligations"},
          {"type": "list", "items": [
            "SEC Reg S-P (as amended) — 30-day notification to affected individuals for breaches of sensitive customer information",
            "State breach notification laws — vary by state; some require notification within shorter windows (e.g., 30, 45, or 60 days)",
            "FINRA Rule 4530 — broker-dealers must report certain events including significant security breaches",
            "NYDFS Part 500 — applicable firms must notify NYDFS within 72 hours of a cybersecurity event",
            "GDPR — if any EU resident data was affected, 72-hour notification to the supervisory authority",
            "FBI IC3 — voluntary but encouraged reporting; helps track patterns and may aid recovery"
          ]},
          {"type": "subheading", "content": "Client notification done right"},
          {"type": "paragraph", "content": "When client notification is required, the notice should be clear, specific, and actionable. Tell the client what happened, what data was affected, what the firm has done in response, what the client should do (monitor accounts, change passwords, place fraud alerts), and where to call with questions. Do not minimize. Do not over-promise. Have legal review every notification before sending."},
          {"type": "subheading", "content": "Educating clients on their own security"},
          {"type": "paragraph", "content": "The firm's security is only as strong as the security of the channels you use to communicate with clients. A client whose personal email is compromised is a wire fraud waiting to happen, no matter how secure your systems are. Routine client education topics — covered in onboarding and at least annually:"},
          {"type": "list", "items": [
            "Enable MFA on personal email, custodian portals, and any account that touches money",
            "Use a password manager; never reuse passwords",
            "Watch for phishing — especially emails appearing to come from custodians or the firm; verify by calling, never by clicking",
            "Be skeptical of urgent requests, especially around wires or account changes",
            "Update operating system and applications regularly; do not run software past its end-of-life",
            "Do not access financial accounts on public Wi-Fi without a VPN",
            "Freeze credit at the three bureaus if not actively borrowing — it costs nothing and prevents new-account fraud",
            "Designate trusted contacts at custodians and with the advisor — a person the firm can call if something looks unusual"
          ]},
          {"type": "subheading", "content": "Closing thoughts on security"},
          {"type": "paragraph", "content": "Security is not a project. It is a practice. Every email read with awareness, every wire verified, every password rotated, every quarterly access review — these are the small reps that build the muscle. The firm that has been doing this for years before a major attack hits is in a different position than the firm that started after the attack. Be the first kind."},
          {"type": "case_study", "title": "Devon's account takeover attempt", "scenario": "Devon receives a text message: 'Schwab fraud alert: confirm recent login from Lagos, Nigeria? Reply Y to confirm or call 1-800-555-2341.' Devon does neither — he calls his apprentice directly at the firm's main number. The apprentice contacts Schwab's actual fraud line on Devon's behalf; no such alert was issued by Schwab. The text was a smishing attempt designed to get Devon to call a fraudulent number where attackers would walk him through 'verifying his account' — actually capturing his credentials and a 2FA code in real time. The apprentice walks Devon through reporting the text, confirms his actual account shows no anomalies, and uses the event to refresh Devon's broader security practices.", "discussion": "Devon's training paid off. Two years earlier, the same client might have called the number in the text. Instead he called the firm — a known number, a known person. The relationship was the defense. That is what client education buys you: a phone call to you instead of a phone call to the attacker."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: with operations and security in place, the final stretch — how to actually build a sustainable practice as a counselor. Module 29: Practice Management & Business Development."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "An apprentice receives an email from a long-standing client requesting an urgent wire on a Friday afternoon. The right next action is:", "options": ["Process the wire to meet the cutoff", "Call the client at the phone number in the CRM to verify the wire instruction verbally", "Reply to the email asking for confirmation", "Have a colleague review the email and process if it looks legitimate"], "correct": 1, "explanation": "Voice verification at a known phone number is the entire defense against wire fraud. Email confirmations and second email reviews do not help — the email may already be compromised."},
        {"id": "q2", "prompt": "The strongest form of multi-factor authentication available is generally:", "options": ["SMS-based codes", "Push notification on a phone", "Hardware security key like a YubiKey", "A password with a special character"], "correct": 2, "explanation": "Hardware security keys are the strongest factor — resistant to phishing, SIM swap, and remote attack. Order of preference: hardware key > authenticator app > push notification > SMS."},
        {"id": "q3", "prompt": "Business Email Compromise (BEC) typically involves:", "options": ["Mass spam emails sent to millions of recipients", "An attacker accessing or convincingly spoofing a real email account to authorize fraudulent actions", "Malware infecting a computer", "Phishing for credit card numbers"], "correct": 1, "explanation": "BEC is targeted attack via real or spoofed business email accounts to authorize wires, beneficiary changes, or sensitive data requests. Highest-dollar attack vector in finance."},
        {"id": "q4", "prompt": "Under the 2024 amendments to SEC Regulation S-P, firms must notify affected individuals of a breach of sensitive customer information within:", "options": ["72 hours", "30 days", "60 days", "Six months"], "correct": 1, "explanation": "Reg S-P as amended requires 30-day notification (with limited exceptions) when sensitive customer information has been or is reasonably likely to have been accessed without authorization."},
        {"id": "q5", "prompt": "An apprentice has been storing scanned client documents in their personal Google Drive for convenience. This practice:", "options": ["Is acceptable since Google has good security", "Creates significant compliance exposure for the firm and should not be done — firm's secure systems must be used for client NPI", "Is acceptable if the documents are password-protected", "Is acceptable if the apprentice deletes them after each use"], "correct": 1, "explanation": "Personal cloud storage bypasses the firm's compliance controls regardless of vendor security. NPI must stay within firm-approved, audited systems."},
        {"id": "q6", "prompt": "When clients complain about voice verification calls before wires, the appropriate response is to:", "options": ["Stop requiring the calls for that client", "Process the wire without verification this once", "Acknowledge the inconvenience and complete the verification regardless — annoyance is sometimes engineered by attackers to bypass controls", "Have a colleague process the wire instead"], "correct": 2, "explanation": "Emotional pressure to bypass verification is itself a social engineering signal. The most important time to verify is when there is pressure not to."},
        {"id": "q7", "prompt": "Nonpublic Personal Information (NPI) under GLBA and Reg S-P includes:", "options": ["Only Social Security numbers", "Only account numbers and balances", "Any non-public information about a client obtained in connection with providing a financial service, including names, addresses, financial conditions, and inferences", "Only information the client has marked confidential"], "correct": 2, "explanation": "NPI is broadly defined — essentially any client information that is not publicly available and was obtained while providing financial services."},
        {"id": "q8", "prompt": "If a phishing email is received and identified before any harm is done, the right action is to:", "options": ["Delete it and move on", "Forward it widely to warn colleagues", "Report it to the firm's security/IT team and do not click any links or reply", "Reply asking the sender to stop"], "correct": 2, "explanation": "Report through proper channels so security can investigate, block similar messages, and track patterns. Do not engage with the sender or forward widely."},
        {"id": "q9", "prompt": "The first priority after detecting an active security incident is:", "options": ["Identify who is responsible", "Contain the incident — isolate affected systems, disable compromised accounts, prevent further damage", "Notify clients", "Write a press statement"], "correct": 1, "explanation": "Containment in the first hour limits damage. Investigation and notification come after containment."},
        {"id": "q10", "prompt": "An apprentice should perform an access review of their own systems and permissions:", "options": ["Only when joining the firm", "Quarterly — actively asking 'do I still need this access?' and reducing footprint", "Only when required by audit", "Never — IT handles this"], "correct": 1, "explanation": "Quarterly self-review of access reduces the blast radius if the account is ever compromised. Least privilege is an ongoing practice, not a one-time setup."},
        {"id": "q11", "prompt": "Devon receives a suspicious text claiming to be from Schwab with a phone number to call. The best action is to:", "options": ["Call the number in the text to clear it up", "Reply to confirm or deny", "Ignore the text and call the advisor or Schwab at known phone numbers", "Click any link to investigate"], "correct": 2, "explanation": "Never use phone numbers or links provided in unsolicited messages. Always use known, independently-sourced contact methods to verify."},
        {"id": "q12", "prompt": "A firm's security is best understood as:", "options": ["A one-time setup that lasts indefinitely", "An ongoing practice of small consistent actions — MFA, verification calls, access reviews, training, incident response readiness", "Primarily the responsibility of the IT vendor", "A regulatory checkbox to be minimized"], "correct": 1, "explanation": "Security is built by small disciplined practices repeated daily. The firm that did the reps before the attack is in a different position than the one that started after."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 29;

-- ── module30_ai_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 30 CONTENT
-- AI for Reporting, Automation, and Client Relationships
-- ============================================================================
update public.modules set
  title = 'AI for Reporting, Automation, and Client Relationships',
  competency_id = 'OJL-21',
  ri_hours = 8,
  ojl_hours = 40,
  short_description = 'AI is reshaping how financial advisors work. This module prepares Wealth Solutions Counselors to use AI tools for client reporting, workflow automation, and relationship management — while maintaining the accuracy standards and fiduciary responsibility every practitioner owes every client.',
  learning_objectives = ARRAY[
    'Explain how AI tools are currently being used in financial planning, reporting, and client communication.',
    'Use an AI assistant to draft client reports, meeting summaries, and financial education content.',
    'Identify the limitations and ethical considerations when using AI tools with client data.',
    'Demonstrate a repeatable workflow for using AI to automate routine administrative tasks.',
    'Apply AI tools to improve client relationship management, follow-up cadence, and personalized outreach.',
    'Evaluate AI-generated financial content for accuracy and compliance before sharing with clients.',
    'Describe the regulatory context for AI-generated content under SEC and FINRA supervision.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "AI in Financial Services — What's Actually Happening",
      "summary": "Cut through the hype. Here is what AI tools are actually doing in advisory practices today.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The financial services industry is in the middle of a genuine shift. AI tools are not replacing advisors — they are changing what advisors spend their time on. The practices growing fastest right now are the ones using AI to handle the administrative and documentation work so their people can focus on what only humans can do: build relationships, exercise judgment, and deliver advice clients trust." },
        { "type": "callout", "kind": "key", "title": "The right frame", "text": "AI amplifies your judgment. It does not replace it. Every output it produces is your responsibility before it reaches a client. Think of it as a fast, capable junior analyst who needs supervision." },
        { "type": "heading", "text": "What AI is actually being used for" },
        { "type": "paragraph", "text": "Across advisory firms of all sizes, the most common AI use cases right now are practical and unsexy: drafting meeting summaries, generating first drafts of client letters, summarizing long documents, writing marketing emails, transcribing calls, and automating follow-up sequences. The technology doing most of this work is called a large language model — a system trained on massive amounts of text that generates coherent, contextually relevant responses to prompts." },
        { "type": "list", "items": [
          "<strong>Writing assistants</strong> — draft emails, reports, summaries, and educational content from a prompt",
          "<strong>Transcription and summarization</strong> — convert recorded meetings into notes and action items",
          "<strong>CRM and workflow automation</strong> — trigger follow-ups, move pipeline stages, log activities",
          "<strong>Document analysis</strong> — extract key data from statements, tax returns, and intake forms",
          "<strong>Meeting prep</strong> — summarize client history, flag open items, suggest talking points",
          "<strong>Scheduling and admin</strong> — handle appointment booking, reminders, and intake workflows"
        ]},
        { "type": "heading", "text": "What AI cannot do" },
        { "type": "paragraph", "text": "AI tools do not know your client. They do not have fiduciary obligations. They cannot make suitability determinations, account for emotional context, or replace a conversation. An AI that writes a beautiful retirement income analysis is producing a draft — not a recommendation. The advisor reviews it, contextualizes it, takes responsibility for it, and delivers it." },
        { "type": "callout", "kind": "warn", "title": "AI hallucinations are real", "text": "Large language models will confidently state incorrect tax rates, outdated regulations, fabricated statistics, and nonexistent laws. This is called hallucination. In any field this is a problem. In financial services, it is a liability. Every factual claim in AI-generated content must be verified before it leaves your hands." },
        { "type": "heading", "text": "The regulatory context" },
        { "type": "paragraph", "text": "The SEC and FINRA have both issued guidance making clear that AI-generated content is still advisor-supervised content. If an AI writes a client communication, the firm is responsible for its accuracy, suitability, and compliance — exactly as if the advisor wrote it personally. The tools are new. The responsibilities are not." },
        { "type": "glossary", "terms": [
          { "term": "Large Language Model (LLM)", "definition": "An AI system trained on large amounts of text that generates human-like responses to prompts. ChatGPT, Claude, and Gemini are examples." },
          { "term": "Hallucination", "definition": "When an AI model generates confident, plausible-sounding content that is factually incorrect. Common with statistics, regulations, and citations." },
          { "term": "Prompt", "definition": "The instruction or question you give an AI tool. Better prompts produce more useful, accurate outputs." },
          { "term": "Automation", "definition": "Using software to perform tasks that would otherwise require manual human action — triggered by a rule, event, or schedule." }
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Drafting Reports and Client Communications with AI",
      "summary": "A practical workflow for using AI to produce first drafts — and the review process that makes them safe to send.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "The highest-value AI use case for most advisors is not exotic. It is this: instead of staring at a blank screen for twenty minutes, you spend five minutes prompting an AI and ten minutes editing the result. The quality goes up. The time goes down. The advisor is still fully in the loop — they just entered the process at the editing stage instead of the blank-page stage." },
        { "type": "heading", "text": "The meeting summary workflow" },
        { "type": "numbered", "items": [
          "Obtain client consent to record the meeting (required — document it in your CRM).",
          "Record the meeting or take structured notes.",
          "Feed the transcript or notes to an AI assistant with a clear prompt.",
          "Review the AI summary for accuracy, completeness, and anything sensitive.",
          "Edit, add your judgment, and send to the client as a follow-up.",
          "Log the final version in your CRM as the official meeting record."
        ]},
        { "type": "callout", "kind": "key", "title": "A prompt that works", "text": "\"Summarize the following client meeting notes into a professional follow-up email. Include: (1) key topics discussed, (2) decisions made, (3) action items with who is responsible, (4) next meeting date if mentioned. Tone: warm and professional. Do not include specific dollar amounts or account numbers. Length: under 300 words.\" — The more specific your prompt, the better the output." },
        { "type": "heading", "text": "Client-facing financial reports" },
        { "type": "paragraph", "text": "Quarterly reports, annual reviews, and financial plan summaries are time-intensive to produce. AI can generate a first draft of the narrative sections — the explanation of what happened, what changed, and what the plan calls for next — from structured data you provide. You review the numbers, verify every factual claim, and add the context only you have." },
        { "type": "callout", "kind": "warn", "title": "Never feed account data into public AI tools", "text": "Entering client names, account numbers, balances, or Social Security numbers into a public AI tool is a privacy violation and potentially a regulatory breach. Use anonymized data (Client A, $X balance) or tools with enterprise data agreements. More on this in Lesson 5." },
        { "type": "heading", "text": "Educational content and newsletters" },
        { "type": "paragraph", "text": "Client newsletters, market commentary, and financial education emails are legitimate AI use cases — with the same review requirement. An AI can generate a clear explanation of how rising interest rates affect bond prices, or a plain-English summary of a tax law change. Your job is to verify it is accurate, that it does not constitute personalized advice, and that it reflects your firm's voice." },
        { "type": "heading", "text": "Prompt engineering for financial content" },
        { "type": "paragraph", "text": "The single biggest factor in the quality of AI output is the quality of your prompt. Generic prompts produce generic results. Specific, structured prompts produce usable first drafts. The elements of a good prompt: specify the audience (\"a client who is 58, near retirement, moderately conservative\"), specify the purpose (\"explain Roth conversion strategy\"), specify the format (\"under 200 words, no jargon\"), and specify what to avoid (\"do not recommend specific products\")." },
        { "type": "heading", "text": "The review checklist before anything reaches a client" },
        { "type": "numbered", "items": [
          "Verify every number, percentage, and statistic against a primary source.",
          "Check that no specific investment, product, or strategy is being recommended to a specific person.",
          "Confirm there are no references to tax rules, contribution limits, or regulations without verifying they are current.",
          "Read the tone — is it appropriate for this client and this situation?",
          "Check that no client PII (names, account numbers, SSNs) was included in the output."
        ]},
        { "type": "activity", "title": "Write a Meeting Summary Prompt", "prompt": "Practice prompt engineering for a real use case. Write a prompt for an AI assistant to generate a post-meeting summary for a client who just completed their annual review.", "steps": [
          "Specify the audience: who is this client (age range, situation — no real names)?",
          "Specify what was covered: investment review, insurance gap, beneficiary update discussion.",
          "Specify the format: email, under 300 words, 3 action items listed.",
          "Specify what to exclude: specific account numbers, investment recommendations.",
          "Submit the prompt to an AI tool if available, then list 5 things you would check before sending the result."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Workflow Automation for the Modern Advisor",
      "summary": "Identify which tasks can be automated, and build the workflows that free you to do what humans do best.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Research consistently finds that financial advisors spend 30–40% of their time on administrative tasks: scheduling, data entry, follow-up emails, document routing, and status tracking. These tasks are necessary. Most of them do not require a licensed professional to do them. Automation is the discipline of redirecting that time." },
        { "type": "heading", "text": "The automation inventory" },
        { "type": "paragraph", "text": "Before you automate anything, audit what you actually do. For one week, track your tasks in two columns: <strong>Human judgment required</strong> (advice, discovery conversations, complex decisions) and <strong>Rule-based or repetitive</strong> (sending a reminder, moving a file, logging an activity). The second column is your automation target list." },
        { "type": "callout", "kind": "do", "title": "High-value automation candidates", "text": "Appointment confirmation and reminders · New client intake form → CRM entry · Birthday and anniversary messages · Post-meeting follow-up email sequence · Document checklist reminders · Annual review scheduling trigger · Compliance document expiration alerts" },
        { "type": "heading", "text": "CRM automation" },
        { "type": "paragraph", "text": "Modern CRM platforms (Salesforce, Redtail, Wealthbox, HubSpot) have built-in automation engines. You define a trigger — a client turns 70½, a prospect submits an intake form, a meeting is logged — and the system takes an action: sending an email, creating a task, updating a field, notifying a team member. These workflows run without human intervention once built." },
        { "type": "heading", "text": "Document processing" },
        { "type": "paragraph", "text": "AI-powered document processing tools can extract key data from client statements, tax returns, and intake forms — pulling balances, account types, contribution amounts, and filing status into structured fields without manual data entry. This eliminates a significant source of error and frees up substantial time during onboarding and annual review preparation." },
        { "type": "heading", "text": "Building a simple intake automation" },
        { "type": "numbered", "items": [
          "Client submits intake form (digital).",
          "Form submission triggers CRM record creation with all form data populated.",
          "Automated welcome email sends within 5 minutes with next steps.",
          "Calendar invite for discovery call populates based on advisor availability.",
          "Task is created for advisor to review intake before the call.",
          "Document checklist email sends 24 hours before the discovery call."
        ]},
        { "type": "paragraph", "text": "Every step above can run without any manual action after initial setup. The advisor's time enters the process when judgment is required — during the discovery call itself." },
        { "type": "activity", "title": "Map Your Automation Opportunities", "prompt": "Audit one week of your own tasks (or a hypothetical advisor week) to find automation candidates.", "steps": [
          "List 10 tasks an advisor performs in a typical week.",
          "For each, write whether it requires licensed judgment or is rule-based.",
          "Circle the rule-based tasks.",
          "For two of them, sketch the trigger → action logic: what starts the automation, and what does it do?",
          "Identify which tool in a typical advisory tech stack could run each automation."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "AI and Client Relationship Management",
      "summary": "How to use AI to be more present, more prepared, and more consistent — without losing the human element clients came for.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The best client relationships in advisory practices are built on consistency: consistent follow-through, consistent communication, consistent attention to what matters to each client. AI makes consistency easier at scale. A practice with 200 clients can deliver the same attentiveness as one with 30 — if the advisor uses the right tools and keeps the human at the center." },
        { "type": "heading", "text": "Meeting preparation" },
        { "type": "paragraph", "text": "Before every client meeting, an advisor should know: what was discussed last time, what action items are open, what has changed in the client's life or portfolio, and what the agenda is today. AI can generate a pre-meeting brief from CRM notes, past meeting summaries, and account data — in two minutes instead of twenty. The advisor reviews it, adds context, and walks into the meeting fully prepared." },
        { "type": "callout", "kind": "key", "title": "The preparation dividend", "text": "Clients notice when their advisor remembers details. 'How is your daughter's college search going?' is a human moment — but it only happens if you remembered. AI-generated pre-meeting briefs surface those details from your notes so you can show up as the advisor clients want." },
        { "type": "heading", "text": "Personalized outreach at scale" },
        { "type": "paragraph", "text": "Quarterly newsletters, market commentary, and educational content can be personalized by client segment. An AI can generate a version of your market update written for near-retirees, and a different version for young accumulators, from the same source material. The advisor reviews both. The client receives something that feels relevant to them." },
        { "type": "heading", "text": "The authenticity line" },
        { "type": "paragraph", "text": "Clients come to an advisor because they want a human relationship with someone they trust. That relationship is the product. AI should make you more available and more consistent — not less genuine. The line is crossed when clients feel managed rather than known. Automated messages that feel form-letter generic, AI responses sent directly to clients without human review, or communication that does not match the tone of your actual relationship — these erode the trust you built." },
        { "type": "list", "items": [
          "<strong>Works well:</strong> AI drafts a birthday message that you personalize before sending",
          "<strong>Works well:</strong> AI prepares a meeting brief you use to have a better conversation",
          "<strong>Works well:</strong> AI generates educational content you review and send under your name",
          "<strong>Backfires:</strong> AI sends automated 'personal' messages without your review",
          "<strong>Backfires:</strong> AI responds directly to client questions without advisor oversight",
          "<strong>Backfires:</strong> Generic mass emails dressed up as personalized outreach"
        ]},
        { "type": "callout", "kind": "do", "title": "The rule of thumb", "text": "If a client would feel deceived knowing AI drafted it first — rethink the workflow. If they would feel served by knowing you had better preparation tools — that is the goal." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Ethics, Accuracy, and the Guardrails Every Practitioner Needs",
      "summary": "Your fiduciary duty applies to every communication you send — regardless of who or what drafted it first.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The efficiency gains from AI are real. So are the risks. This lesson is about building the habits that let you capture the benefits without creating liability, violating client privacy, or producing content you cannot stand behind." },
        { "type": "heading", "text": "AI hallucinations in financial content" },
        { "type": "paragraph", "text": "Large language models generate text by predicting what words should follow other words, based on patterns in their training data. They do not look things up. They do not have access to current regulations unless specifically designed to. When asked about the 2024 Roth IRA contribution limit, a model might confidently state a number from 2021. When asked to cite a law, it might generate a plausible-sounding but nonexistent citation. In financial services, these errors are not just embarrassing — they are potentially harmful to clients and legally significant for advisors." },
        { "type": "callout", "kind": "warn", "title": "Verify every factual claim", "text": "Tax rates, contribution limits, RMD ages, SECURE Act provisions, SEC rules, state regulations — verify every single one against primary sources before they leave your hands. The IRS website, FINRA BrokerCheck, SEC.gov, and your compliance department are your ground truth. AI is your drafting assistant, not your compliance resource." },
        { "type": "heading", "text": "What not to put into AI tools" },
        { "type": "paragraph", "text": "Public AI tools — including the major consumer products — process your inputs on external servers. Entering client personally identifiable information (PII) into these tools is a privacy risk, a potential FINRA violation, and in some states a legal breach. PII includes more than Social Security numbers. It includes names, email addresses, phone numbers, account numbers, dates of birth, and combinations of information that could identify a specific individual." },
        { "type": "list", "items": [
          "<strong>Never enter:</strong> Client full names with financial data",
          "<strong>Never enter:</strong> Account numbers or balances tied to an individual",
          "<strong>Never enter:</strong> Social Security numbers, dates of birth, or addresses",
          "<strong>Never enter:</strong> Medical information",
          "<strong>Safe to enter:</strong> Anonymized scenarios (\"a 58-year-old client with $800K in a 401(k)\")",
          "<strong>Safe to enter:</strong> General planning concepts and educational content",
          "<strong>Safe with enterprise tools:</strong> Firm-specific content when your tool has a BAA or equivalent data agreement"
        ]},
        { "type": "heading", "text": "Regulatory context" },
        { "type": "paragraph", "text": "The SEC's 2023 guidance on AI in investment advisory makes clear that firms remain responsible for all communications regardless of how they were generated. FINRA has reiterated that AI-generated content is subject to the same supervision, review, and recordkeeping requirements as human-generated content. Your compliance department is the right resource for your firm's specific AI use policy." },
        { "type": "heading", "text": "Building your personal AI policy" },
        { "type": "paragraph", "text": "Before you rely on AI in your practice, decide explicitly what you will and will not use it for — and what your review process is. A simple written policy protects you, sets expectations with colleagues, and makes you think clearly about the guardrails before a problem occurs." },
        { "type": "activity", "title": "Write Your Personal AI Use Policy", "prompt": "Draft a one-page personal AI policy for your practice. Be specific and honest.", "steps": [
          "List 5 tasks you will use AI for (be specific — not just 'writing').",
          "List 3 tasks you will never use AI for, and explain why.",
          "Write your verification workflow: what do you check before AI-assisted content reaches a client?",
          "Write your data rule: what information will you never enter into an AI tool?",
          "Identify who at your firm or compliance provider you would consult if you had a question about a specific AI use case."
        ]},
        { "type": "glossary", "terms": [
          { "term": "Hallucination", "definition": "When an AI generates confident, plausible-sounding content that is factually incorrect. Particularly dangerous with statistics, regulations, and citations." },
          { "term": "PII (Personally Identifiable Information)", "definition": "Any data that can identify a specific individual — names, SSNs, account numbers, addresses, dates of birth, and combinations thereof." },
          { "term": "BAA (Business Associate Agreement)", "definition": "A contract that ensures a vendor (including AI tool providers) handles sensitive data in compliance with applicable privacy laws." },
          { "term": "RAG (Retrieval-Augmented Generation)", "definition": "An AI architecture that combines a language model with a specific document database — allowing the model to answer questions based on verified, up-to-date sources rather than training data alone." },
          { "term": "Prompt Engineering", "definition": "The practice of writing precise, structured prompts to produce more accurate, useful outputs from AI tools." }
        ]},
        { "type": "callout", "kind": "key", "title": "The bottom line", "text": "Your fiduciary duty is unchanged. You owe your clients the same duty of care whether you wrote something in five minutes or whether an AI drafted it in five seconds and you reviewed it in five minutes. The tools change the workflow. They do not change the responsibility." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "text": "An AI writing assistant generates a client newsletter with a statement that the Roth IRA contribution limit for 2024 is $6,000. What is the advisor's correct next step?",
        "options": [
          "Verify the current limit against the IRS website before sending the newsletter",
          "Send the newsletter — AI tools are trained on current data",
          "Add a disclaimer that figures are approximate",
          "Ask the AI to confirm the number a second time"
        ],
        "correct": 0,
        "explanation": "AI tools do not have access to current data and frequently hallucinate specific figures. Every factual claim — especially tax limits and regulatory numbers — must be verified against a primary source before reaching clients."
      },
      {
        "id": "q2",
        "text": "Which of the following should NEVER be entered into a public AI tool?",
        "options": [
          "A client's name, account balance, and date of birth",
          "A hypothetical scenario about a 55-year-old client with $500K in savings",
          "A general explanation of how Roth conversions work",
          "A draft market commentary article for your newsletter"
        ],
        "correct": 0,
        "explanation": "Client PII — including names, account numbers, balances, dates of birth, and SSNs — must never be entered into public AI tools. Anonymized scenarios and general content are safe."
      },
      {
        "id": "q3",
        "text": "Under current SEC and FINRA guidance, who is responsible for AI-generated client communications?",
        "options": [
          "The advisor and firm, to the same standard as human-authored communications",
          "The AI tool provider, since they generated the content",
          "No one — AI content is in a regulatory gray area",
          "The compliance department, who must pre-approve all AI output"
        ],
        "correct": 0,
        "explanation": "Regulators have made clear that AI-generated content is subject to the same supervision, accuracy, and recordkeeping requirements as content written by the advisor directly."
      },
      {
        "id": "q4",
        "text": "What is the primary risk of AI 'hallucination' in financial content?",
        "options": [
          "The AI generates confident, plausible-sounding content that is factually incorrect",
          "The AI refuses to answer financial questions",
          "The AI produces content that is too technical for clients to understand",
          "The AI copies content from competitor firm websites"
        ],
        "correct": 0,
        "explanation": "Hallucination is when AI generates factually incorrect information with apparent confidence. In financial services this can mislead clients, create liability, and result in regulatory violations."
      },
      {
        "id": "q5",
        "text": "Which of the following is the BEST use of AI in client relationship management?",
        "options": [
          "Generating a pre-meeting brief from CRM notes that the advisor reviews before the meeting",
          "Having AI respond directly to client emails without advisor review",
          "Replacing discovery conversations with AI-administered questionnaires",
          "Using AI to make suitability determinations based on risk profile data"
        ],
        "correct": 0,
        "explanation": "AI excels at preparing advisors for human conversations — synthesizing history, flagging open items, and surfacing relevant details. The advisor reviews the brief and remains the relationship."
      },
      {
        "id": "q6",
        "text": "An advisor uses AI to draft a quarterly performance report, then sends it to clients without review. What is the primary problem with this approach?",
        "options": [
          "The advisor has not fulfilled their supervisory responsibility over client communications",
          "AI-generated reports are not permitted under any circumstances",
          "Clients might prefer human-written reports",
          "The AI may have used a different font than the firm standard"
        ],
        "correct": 0,
        "explanation": "Sending AI-generated client communications without review violates the advisor's supervisory obligation. The advisor must verify accuracy, compliance, and appropriateness before any communication reaches a client."
      },
      {
        "id": "q7",
        "text": "What does 'prompt engineering' mean in the context of AI tools?",
        "options": [
          "Writing precise, structured instructions to produce more accurate and useful AI outputs",
          "Programming AI models from scratch",
          "Identifying and fixing errors in AI-generated code",
          "Selecting which AI tool to use for a given task"
        ],
        "correct": 0,
        "explanation": "Prompt engineering is the practice of crafting clear, specific, well-structured prompts. Better prompts produce more accurate and useful outputs from AI tools."
      },
      {
        "id": "q8",
        "text": "Which workflow automation candidate is MOST appropriate for an advisory practice?",
        "options": [
          "Automatically sending appointment confirmation emails when a meeting is booked",
          "Automatically rebalancing client portfolios when allocations drift",
          "Automatically approving client withdrawals under a certain threshold",
          "Automatically updating a client's risk profile annually"
        ],
        "correct": 0,
        "explanation": "Administrative automations — scheduling, reminders, confirmations — are ideal candidates because they are rule-based and require no professional judgment. Portfolio and risk decisions require licensed oversight."
      },
      {
        "id": "q9",
        "text": "A client asks why their advisor's newsletter seems to know exactly what they care about. The advisor used AI to generate segment-specific versions. Is this appropriate?",
        "options": [
          "Yes, if the advisor reviewed the content for accuracy and compliance before sending",
          "No, because clients must be told when AI is used in any communication",
          "No, because personalized content can only be written by the advisor personally",
          "Yes, no review is needed if the content is educational rather than advisory"
        ],
        "correct": 0,
        "explanation": "Using AI to generate personalized educational content is appropriate when the advisor reviews it for accuracy and compliance. There is currently no general requirement to disclose AI involvement in informational newsletters."
      },
      {
        "id": "q10",
        "text": "What is the correct description of RAG (Retrieval-Augmented Generation)?",
        "options": [
          "An AI architecture that combines a language model with a specific document database for more accurate, sourced responses",
          "A method for detecting AI hallucinations in financial documents",
          "A regulatory framework governing AI use in registered investment advisory",
          "A technique for anonymizing client data before entering it into AI tools"
        ],
        "correct": 0,
        "explanation": "RAG connects an AI model to a curated, verified document source — allowing it to answer questions based on current, specific information rather than general training data. Useful for compliance and regulation-based queries."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 30;

-- ── module29_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 29 CONTENT
-- Practice Management & Business Development
-- ============================================================================
update public.modules set
  title = 'Practice Management & Business Development',
  competency_id = 'OJL-20',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Build the business side of the counselor practice — service models, marketing, referrals, hiring, and the economics of running a sustainable advisory firm.',
  learning_objectives = ARRAY[
    'Design a service model that matches the firm''s capacity to the client base',
    'Understand the economics of an advisory practice — revenue, costs, and capacity',
    'Develop a marketing and business development approach that fits a fiduciary practice',
    'Build referral relationships with COIs (centers of influence)',
    'Plan for hiring, training, and succession in a growing practice'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Designing the Service Model",
        "summary": "The service model is the operating system of the practice — what clients get, how often, in what format. Get this right and growth is sustainable. Get it wrong and the practice eats itself.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most advisory practices that fail do not fail because the advisor was bad at advice. They fail because the service model — the implicit and explicit promise of what clients get — outgrew the capacity to deliver it. The counselor who promised quarterly meetings to 80 clients cannot actually deliver quarterly meetings to 80 clients. Quality drops. Trust erodes. Clients leave. Or the counselor burns out trying to keep promises that should never have been made. Designing the service model is foundational — and an apprentice should understand it long before they have clients of their own."},
          {"type": "subheading", "content": "The three levels of a service model"},
          {"type": "glossary", "terms": [
            {"term": "Service tiers", "definition": "Different levels of service for different client segments — typically based on complexity, assets, or fee structure. Common patterns: Foundational/Standard/Premier or A/B/C client groupings."},
            {"term": "Service calendar", "definition": "What happens with each client across the year — annual review timing, mid-year touch, year-end planning, ad hoc availability. The calendar formalizes the cadence promised."},
            {"term": "Service deliverables", "definition": "Specific outputs each client receives — annual plan refresh, quarterly performance report, tax planning memo, estate review, etc."}
          ]},
          {"type": "subheading", "content": "Capacity math — how many clients can one counselor actually serve?"},
          {"type": "paragraph", "content": "A working figure used in the industry: a full-time financial counselor delivering a comprehensive planning service with quarterly touches can sustainably serve approximately 60-100 client households, depending on complexity and team support. With dedicated support staff and operations, that number can grow to 120-150. Beyond that, either service quality degrades, the relationship becomes transactional, or the model has shifted to something other than comprehensive planning. The numbers vary by firm. The principle does not: capacity is finite. Pretending otherwise fails."},
          {"type": "subheading", "content": "Segmenting the client base"},
          {"type": "paragraph", "content": "Most firms segment clients into tiers — say A (top 20% by complexity or revenue, receiving most-intensive service), B (middle 60%, standard service), and C (the rest, often receiving more streamlined service or transitioned to digital/group offerings). Segmentation is not a value judgment about clients — it is a recognition that service intensity must match the firm's ability to deliver. A C-tier client receiving B-tier service is unsustainable. An A-tier client receiving C-tier service will leave."},
          {"type": "callout", "kind": "key", "content": "Service tiers are not about ranking clients. They are about matching the service you can sustainably deliver to the client situations that need that level of service."},
          {"type": "subheading", "content": "Designing the annual calendar per tier"},
          {"type": "list", "items": [
            "A-tier (top ~20%): semi-annual deep reviews, quarterly touch, ad hoc availability, dedicated team, customized year-end planning, estate and tax coordination",
            "B-tier (middle ~60%): annual deep review, mid-year touch, year-end checklist, response within 1-2 business days, standardized planning template",
            "C-tier (bottom ~20%): annual review, year-end checklist, response within 3-5 business days, simplified planning, often group/digital education"
          ]},
          {"type": "subheading", "content": "The promise the firm can keep"},
          {"type": "paragraph", "content": "Every client agreement should clearly describe what the client receives — frequency of reviews, scope of planning, response time expectations, what is and is not included. Vague promises ('we are here when you need us') create misaligned expectations. Specific promises ('quarterly reviews scheduled in advance, response within 24 hours during business days, comprehensive planning refresh annually') let both sides know what success looks like."},
          {"type": "case_study", "title": "The 200-client practice that broke", "scenario": "A counselor builds a successful practice over twelve years. By year twelve, they have 198 clients personally. They promised quarterly meetings at the start of every relationship and have kept that promise mostly through working 70-hour weeks. In year thirteen they miss their first cycle — a few clients do not get their fall meeting. By year fourteen, three A-tier clients have left, citing 'I do not feel like a priority.' By year fifteen, the counselor is on stress leave. The remaining clients are being managed by a junior staff member with no relationship and no authority. Most leave over the following year.", "discussion": "The counselor was excellent at advice and had real relationships with their clients. The failure was structural: capacity was exceeded, the service model never adjusted, and there was no team to absorb the overflow. By the time the cracks showed, the recovery options were limited. The lesson: capacity discipline early. Build the model that scales before you need it to."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Economics of an Advisory Practice",
        "summary": "Revenue, costs, margins, and what makes an advisory firm a business — not just a collection of relationships.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An advisor who does not understand the economics of their own firm cannot make good business decisions and cannot have honest conversations with clients about fees. An apprentice does not need to be a CFO, but should understand how the firm makes money, what it costs to deliver service, and where the leverage points are."},
          {"type": "subheading", "content": "Revenue models"},
          {"type": "glossary", "terms": [
            {"term": "AUM (assets under management) fee", "definition": "Percentage of client assets, typically 0.5%-1.25% annually, often tiered. Most common revenue model for RIAs. Aligns advisor with growing client assets."},
            {"term": "Flat fee / retainer", "definition": "Fixed annual or monthly fee per client regardless of assets. Cleaner alignment for planning-focused work; can be more accessible to younger or non-asset-heavy clients."},
            {"term": "Hourly / project fee", "definition": "Charged per engagement or per hour. Common for second-opinion or one-time planning work. Hard to scale to a full-time practice but useful for specific use cases."},
            {"term": "Subscription / monthly retainer", "definition": "Monthly fee for ongoing planning relationship. Increasingly common, especially for younger clients or planning-focused (non-AUM) firms."},
            {"term": "Commission", "definition": "Paid by product providers (insurance carriers, broker-dealers) when clients buy products. Creates conflicts of interest and is not used by fiduciary fee-only firms."}
          ]},
          {"type": "subheading", "content": "Typical cost structure of a small advisory firm"},
          {"type": "list", "items": [
            "Compensation (counselors, advisors, support staff) — usually 50-65% of revenue",
            "Technology (CRM, planning software, custodian fees, portfolio management) — 5-10%",
            "Occupancy (rent, utilities) — 5-10% for office-based firms; lower for distributed models",
            "Compliance and legal — 2-5%, growing as firms scale",
            "Marketing and business development — 2-5%",
            "Insurance (E&O, cyber, general business) — 1-3%",
            "Owner draw / profit — what remains, typically 15-30% in healthy firms"
          ]},
          {"type": "subheading", "content": "Revenue per client and capacity"},
          {"type": "paragraph", "content": "A firm with 100 client relationships at an average revenue of $5,000 per client generates $500,000. The same firm with 100 clients at $15,000 average revenue generates $1.5M. Same number of relationships, three times the revenue. This is why client selection and pricing matter as much as marketing. A firm cannot indefinitely grow by adding low-revenue clients — the operational overhead eventually exceeds the marginal revenue."},
          {"type": "subheading", "content": "Lifetime value of a client"},
          {"type": "paragraph", "content": "A planning relationship that lasts 20 years at $10,000 a year is a $200,000 revenue relationship. The cost of acquiring that client (referrals, marketing, onboarding time) — say $5,000-$15,000 — is well-justified. But if that client churns after three years instead of staying for twenty, the math collapses. Retention is the most important growth lever. Most advisory firms do not have a 'new client' problem. They have a 'losing existing clients' problem dressed up as a marketing problem."},
          {"type": "callout", "kind": "key", "content": "A firm that retains clients well grows almost without trying. A firm that loses clients quietly is on a treadmill no marketing budget can fix."},
          {"type": "subheading", "content": "Fee transparency and the fee conversation"},
          {"type": "paragraph", "content": "Every client should know exactly what they pay the firm and what they get for it. Hiding fees in fund expense ratios or platform fees creates trust problems that surface later. The fee conversation should happen openly at the start, be revisited annually, and any change should be discussed in advance. Clients who feel they understand the fee rarely complain about it. Clients who feel the fee is opaque eventually complain about everything."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Marketing a Fiduciary Practice",
        "summary": "Most financial marketing is loud, formulaic, and ineffective. The marketing that works for a fiduciary practice is quieter, longer-cycle, and grounded in what the firm actually does.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Fiduciary planning firms tend to be bad at marketing. The work is consultative, complex, and relationship-driven — none of which translates to a Facebook ad. The marketing that actually works is closer to thought leadership and community presence than to direct response. Done right, marketing for a fiduciary practice is an asset that compounds. Done wrong, it is wasted spend and brand damage."},
          {"type": "subheading", "content": "Where good clients actually come from"},
          {"type": "list", "items": [
            "Referrals from existing clients (typically 40-60% of new clients at healthy firms)",
            "Centers of influence (COIs) — CPAs, attorneys, business brokers, mortgage brokers (15-25%)",
            "Content marketing — articles, podcasts, talks that establish expertise (10-20%)",
            "Community presence — events, sponsorships, nonprofit boards (5-15%)",
            "Digital lead generation — typically lower for fiduciary firms (varies widely)"
          ]},
          {"type": "subheading", "content": "The referral question — how and when to ask"},
          {"type": "paragraph", "content": "Most advisors ask for referrals badly. The 'do you know anyone else who could benefit from our services' line at the end of a meeting is awkward, generic, and rarely effective. Better: identify specific moments when clients are most likely to refer (just after a successful outcome, after a major life event well-handled, at year-end when they are thinking about gratitude). And be specific about who you serve well. 'We do our best work with mid-career professionals dealing with stock-based compensation' is a referrable description. 'We help everyone with financial planning' is not."},
          {"type": "callout", "kind": "do", "content": "After major successful planning events — a business sale closing, a retirement well-launched, a complex estate plan settled — there is a natural window to ask: 'If you know someone navigating something similar, I would be glad to have an introductory conversation with them.' Specific, contextual, low-pressure."},
          {"type": "subheading", "content": "Working with centers of influence (COIs)"},
          {"type": "paragraph", "content": "CPAs and estate attorneys are the highest-quality referral sources for fiduciary planning firms because they share clients in adjacent professional capacities. The relationship is built over years — coordinating on shared clients, attending each other's events, occasional working lunches, mutual respect. It is not built by sending business cards or cold-emailing CPAs in the area. The work that brings COI referrals is the work of being genuinely good at your part of shared client situations, and being easy and pleasant to coordinate with. CPAs do not refer to advisors who make their lives harder. They refer to advisors who make their lives easier."},
          {"type": "subheading", "content": "Content as long-cycle marketing"},
          {"type": "paragraph", "content": "Writing articles, recording podcasts, or speaking at events does not generate immediate leads. It builds long-term credibility and discoverability. Over years, a body of work becomes a moat — when someone searches for 'tax planning for restricted stock units' and finds a thoughtful article you wrote three years ago, that is a future client who already trusts you. The horizon for content marketing is years, not months. Firms that commit to consistency for five-plus years see results. Firms that try it for three months and quit see nothing."},
          {"type": "subheading", "content": "Marketing rules under SEC and state regulators"},
          {"type": "paragraph", "content": "The SEC's Marketing Rule (effective 2022) governs how registered investment advisors can advertise, including the use of testimonials, endorsements, and performance figures. Key rules: testimonials and endorsements are allowed but with required disclosures (whether the person was paid, whether they are a client, conflicts of interest); past specific recommendations may only be presented with required context; hypothetical performance has stringent requirements; predecessor performance (e.g. from a previous firm) requires specific conditions. The implication for marketing: do not improvise. Have compliance review any advertising or marketing content before publishing."},
          {"type": "callout", "kind": "warn", "content": "Posting client compliments on social media without proper disclosures, sharing investment performance without context, or making forward-looking claims about returns can all trigger regulatory issues. The Marketing Rule is enforceable. Compliance review is not optional."},
          {"type": "subheading", "content": "Brand and trust"},
          {"type": "paragraph", "content": "Marketing for a fiduciary practice is mostly trust-building, and trust-building is mostly consistency. The firm that says the same things, treats clients the same way, shows up at the same community events year after year — that firm becomes known. The flashier firm that pivots messaging every quarter becomes background noise. Boring consistency beats interesting variety in this work."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Hiring, Training, and the Team",
        "summary": "Solo practices have a ceiling. Building a team multiplies what one person can do — and creates a different set of challenges to manage well.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most planning practices start as solo practices and at some point face the team question. The first hire is usually an administrative or operations support person. Later hires include junior advisors, paraplanners, compliance staff, and eventually partner-level counselors. Each hire changes the firm — economically, culturally, operationally. Doing it well is the difference between a firm that scales and a firm that just gets bigger and more dysfunctional."},
          {"type": "subheading", "content": "The first hire — typically operations or paraplanner"},
          {"type": "paragraph", "content": "The first hire at most planning firms is somebody who takes the operational and administrative load off the lead counselor — scheduling, document collection, custodian paperwork, basic plan prep. This hire frees the counselor to spend more time in client meetings and complex planning. The first hire often pays for itself by allowing the counselor to add three to five A-tier clients with their freed time."},
          {"type": "subheading", "content": "Hiring junior advisors and apprentices"},
          {"type": "paragraph", "content": "The next level — bringing in another advisor or apprentice — is more complex. Now there is another voice in client relationships. Training, supervision, quality control, and culture all become explicit work. The junior advisor needs both technical training (the work of the planning) and relational training (how this firm handles relationships, what its values mean in practice). The DOL Registered Apprenticeship model — which is what this entire curriculum supports — is one structured path for developing the next generation of counselors. Whether through formal apprenticeship or other structured development, the firm that invests in growing people grows talent that is loyal and aligned. The firm that hires senior people from competitors gets people with skills but often without alignment."},
          {"type": "callout", "kind": "key", "content": "The Wealth Solutions Counselor Apprenticeship that you are working through right now is itself a piece of practice management — a way for firms like GIC to grow talent intentionally rather than poach it expensively."},
          {"type": "subheading", "content": "Culture and values in practice"},
          {"type": "list", "items": [
            "Written values that show up in how clients are treated — not just on the wall",
            "Hiring for values fit, not just skills — skills can be taught more easily",
            "Onboarding that includes culture explicitly — what we do here, what we do not",
            "Performance reviews that measure values-aligned behavior, not only revenue or output",
            "Difficult conversations when behavior drifts from values — the cost of avoidance is higher than the cost of the conversation",
            "Letting people go when fit is wrong — protecting the team is protecting clients"
          ]},
          {"type": "subheading", "content": "Compensation that aligns"},
          {"type": "paragraph", "content": "How a firm pays its team shapes behavior more than any speech about values. Counselors compensated primarily on bringing in new assets behave differently than counselors compensated on client retention. Operations staff paid hourly with no upside in firm growth behave differently than those with profit-sharing or equity. Design compensation deliberately. Common patterns at fiduciary planning firms: base salary plus modest performance bonus tied to client retention and team metrics, with equity opportunities for long-tenured staff and partner-track advisors. Aggressive sales commissions tend to be uncommon at fee-only fiduciary firms because they create conflicts that work against the planning relationship."},
          {"type": "subheading", "content": "Succession and ownership"},
          {"type": "paragraph", "content": "Every firm has a succession question, whether or not it is being asked. What happens to clients if the lead advisor retires, becomes disabled, or dies? The DOL and SEC require business continuity plans for registered firms. Beyond compliance, the human question is: who carries the relationships forward? Firms that develop next-generation counselors internally — through apprenticeship, mentorship, and explicit ownership pathways — can transition smoothly. Firms that wait until the founder is ready to retire to think about succession often end up selling to an outside aggregator at a discount, with clients caught in the middle."},
          {"type": "case_study", "title": "GIC's apprenticeship strategy", "scenario": "Global Investment Company has chosen to invest in the DOL Registered Apprenticeship Program for the Wealth Solutions Counselor role rather than hire experienced advisors from competitors. The 36-month structured pathway costs the firm in training time and supervision but produces counselors who understand the firm's planning approach from the ground up, who are licensed and competent across the full scope of competencies, and who are aligned with the firm's values because they were shaped by them. After five years of running the apprenticeship, the firm has three apprenticeship graduates serving as counselors and is preparing to begin a fourth cohort.", "discussion": "Apprenticeship is a long-term bet. It does not pay off in year one. It pays off in year three through year thirty, in retention, in alignment, in succession capacity. Firms with a five-year horizon make this investment. Firms with a six-month horizon do not."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "The Long Game — Practice as Career, Career as Practice",
        "summary": "Practice management is not separate from the planning work. It is the structure that lets the planning work be done well for decades. Hold both together.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An apprentice starting this curriculum is at the beginning of what could be a thirty-five-year career. The practice you participate in — whether at GIC or elsewhere — is the container that lets that career develop. The choices about how the practice is run shape what is possible in the career. The choices about what to build in the career shape what the practice becomes. The two are inseparable."},
          {"type": "subheading", "content": "What a career in this work actually looks like"},
          {"type": "list", "items": [
            "Years 1-3: apprentice / new counselor — learning the technical work, building skills with clients under supervision, getting licensed",
            "Years 3-7: counselor — handling a growing book of relationships, deepening technical specialty, mentoring newer apprentices",
            "Years 7-15: senior counselor / advisor — leading complex client situations, contributing to firm strategy, often beginning partner track",
            "Years 15-30: partner / principal — significant equity, leadership role in firm direction, mentoring next generation, often public-facing thought leadership",
            "Years 30+: gradual transition — handing relationships to next generation, possibly emeritus or board role, succession of equity"
          ]},
          {"type": "subheading", "content": "Specialization as the practice matures"},
          {"type": "paragraph", "content": "Many counselors specialize as their career develops — in equity compensation, business sale planning, divorce planning, sudden wealth, multi-generational family wealth, healthcare professionals, tech executives, athletes and entertainers, or other niches. Specialization is not necessary but often beneficial: it concentrates expertise, builds referral patterns, and lets the practice command premium fees in areas of genuine depth. Apprentices should expect to start general and specialize over years as interests and opportunities crystallize."},
          {"type": "subheading", "content": "Credentials over time"},
          {"type": "paragraph", "content": "The CFP (Certified Financial Planner) is the most widely recognized planning credential and is often pursued during or shortly after the apprenticeship. CFA (Chartered Financial Analyst) is more investment-focused. CPWA (Certified Private Wealth Advisor) and CIMA (Certified Investment Management Analyst) are advanced credentials for high-net-worth practice. CFTA (Certified Financial Therapist) for behavioral specialty. Each requires time and study, and each pays back in client trust and professional positioning."},
          {"type": "subheading", "content": "Burnout, balance, and longevity"},
          {"type": "paragraph", "content": "Counseling work is meaningful and emotionally taxing. Clients bring you their fears, their regrets, their hopes — and the cumulative weight of holding that across years is real. Counselors who burn out do not help anyone. Investing in your own life outside the work — relationships, physical health, hobbies, intellectual interests, periodic genuine rest — is not separate from being good at the work. It is what makes a 35-year career possible."},
          {"type": "callout", "kind": "key", "content": "Be the counselor at year fifteen who is still curious, still energized, still genuinely interested in the next client conversation. That counselor is rare. That counselor is irreplaceable. That counselor is built by the choices made at year three."},
          {"type": "subheading", "content": "What this apprenticeship is really for"},
          {"type": "paragraph", "content": "The thirty modules you have worked through are not just technical training. They are the foundation of a craft. Financial planning done well is one of the most consequential professional services in someone's life — it touches their security, their family, their legacy, their freedom. The clients you will serve will trust you with information they share with no one else. The decisions you help them make will shape decades. Take the work seriously. Hold yourself to a high standard. Keep learning. Keep growing. Keep showing up. The career rewards the apprentices who do."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: the Capstone. Module 30 brings together everything from the prior twenty-nine modules into a single integrated exercise. Building a practice — your practice — one decision at a time."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "A typical sustainable client capacity for a full-time financial counselor delivering comprehensive planning with quarterly touches and team support is roughly:", "options": ["20-30 households", "60-150 households depending on complexity and team support", "300-500 households", "Unlimited"], "correct": 1, "explanation": "The working figure is 60-100 clients solo, expanding to 120-150 with team support. Beyond that, service intensity must change or quality degrades."},
        {"id": "q2", "prompt": "Client segmentation into A/B/C tiers is best understood as:", "options": ["A way of ranking clients by importance", "A method to charge different prices to similar clients", "A way to match service intensity to client situations the firm can sustainably serve", "Required by regulation"], "correct": 2, "explanation": "Segmentation matches deliverable service to client needs. It is not a value judgment about clients but a capacity discipline."},
        {"id": "q3", "prompt": "The most important growth lever for most advisory firms is:", "options": ["New client acquisition through digital marketing", "Client retention — keeping existing clients happy and engaged over decades", "Adding new service tiers", "Hiring more advisors"], "correct": 1, "explanation": "Most firms with a 'growth problem' actually have a retention problem. A 20-year client relationship is worth far more than a new client added every six months for three years."},
        {"id": "q4", "prompt": "The SEC's Marketing Rule (effective 2022) generally requires that testimonials and endorsements in advertising:", "options": ["Be banned entirely", "Be allowed without restrictions", "Be allowed with required disclosures about compensation, client status, and conflicts of interest", "Be allowed only if approved by the client in writing"], "correct": 2, "explanation": "Testimonials and endorsements are permitted but with specific disclosure requirements. Improvising marketing without compliance review can trigger regulatory issues."},
        {"id": "q5", "prompt": "The highest-quality external referral sources for most fiduciary planning firms tend to be:", "options": ["Cold-call lead lists", "Centers of influence like CPAs and estate attorneys built over years of working with shared clients", "Pay-per-click advertising", "Telemarketing"], "correct": 1, "explanation": "COI relationships compound over years through shared-client coordination. CPAs and attorneys refer to advisors who make their work easier, not to advisors who simply ask for referrals."},
        {"id": "q6", "prompt": "The DOL Registered Apprenticeship program supporting this curriculum is best understood as:", "options": ["A regulatory burden", "An optional certification", "A long-term practice management investment in growing aligned, capable counselors from the ground up rather than poaching from competitors", "A marketing tool"], "correct": 2, "explanation": "Apprenticeship is a multi-year investment that pays back through retention, alignment, and succession capacity. Long-horizon firms make this bet."},
        {"id": "q7", "prompt": "Compensation that aligns a counselor with client retention rather than aggressive sales commissions is more common at:", "options": ["Wirehouses", "Independent broker-dealers focused on product sales", "Fee-only fiduciary planning firms", "Insurance-focused firms"], "correct": 2, "explanation": "Fiduciary planning firms typically use base salary plus performance bonuses tied to retention and team metrics, avoiding aggressive sales commissions that create conflicts with the planning relationship."},
        {"id": "q8", "prompt": "A typical compensation expense as a percentage of revenue at a healthy small advisory firm is approximately:", "options": ["10-20%", "30-40%", "50-65%", "80-90%"], "correct": 2, "explanation": "Compensation is usually the largest expense category at advisory firms, typically running 50-65% of revenue."},
        {"id": "q9", "prompt": "Specialization in a counselor's career (in equity comp, business sales, sudden wealth, etc.) tends to:", "options": ["Limit growth opportunities", "Concentrate expertise, build referral patterns, and allow premium fees in areas of genuine depth", "Be discouraged by regulators", "Be required by all firms"], "correct": 1, "explanation": "Specialization typically benefits both the counselor and clients — deeper expertise, clearer referral patterns, and premium positioning. Most counselors specialize as their career develops."},
        {"id": "q10", "prompt": "The CFP credential is most commonly pursued by counselors:", "options": ["Only after fifteen years of practice", "During or shortly after the apprenticeship period", "Only by those who specialize in investments", "Optional for all counselors and rarely held"], "correct": 1, "explanation": "The CFP is the foundational planning credential and is typically pursued during or shortly after the apprenticeship, well before mid-career."},
        {"id": "q11", "prompt": "A service promise like 'we are here when you need us' tends to be problematic because:", "options": ["It is too modest", "It creates misaligned expectations and cannot be measured against — specific, concrete promises serve everyone better", "It overcommits the firm", "It is illegal"], "correct": 1, "explanation": "Vague promises create misalignment. Specific commitments — 'quarterly reviews, 24-hour response, annual planning refresh' — let both sides know what success looks like."},
        {"id": "q12", "prompt": "Counselor burnout in this work is best prevented by:", "options": ["Working harder during peak years", "Avoiding emotionally difficult client situations", "Investing in life outside the work — relationships, health, hobbies, rest — recognizing this investment is what makes a 35-year career sustainable", "Limiting career to ten years"], "correct": 2, "explanation": "Counseling work is meaningful and emotionally taxing. The counselor who is still curious and present at year fifteen made choices about life-balance at year three."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 31;

-- ── module30_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 30 CONTENT
-- Capstone: Building a Practice
-- ============================================================================
update public.modules set
  title = 'Capstone: Building a Practice',
  competency_id = 'OJL-21',
  ri_hours = 0,
  ojl_hours = 120,
  short_description = 'Integrate everything from the prior twenty-nine modules into a single sustained client engagement — discovery to ongoing relationship — and reflect on the kind of counselor you intend to be.',
  learning_objectives = ARRAY[
    'Integrate technical, behavioral, and operational competencies into a coherent client engagement',
    'Lead a complete client lifecycle from first meeting through one full year of relationship',
    'Self-assess against the thirty competencies and identify your continuing development areas',
    'Articulate a personal philosophy of practice that will guide your work going forward',
    'Plan the next phase of your professional development beyond the apprenticeship'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "What You Have Learned — Mapping the Thirty Competencies",
        "summary": "Before integration, a moment to look back at the scope of the curriculum you have worked through and locate yourself within it.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "You have reached the final module of the Wealth Solutions Counselor Registered Apprenticeship. Behind you are twenty-nine modules covering the foundations of financial planning, the practice of client work, and the operations and business of a fiduciary advisory firm. The DOL framework calls these the thirty core competencies. The full RAPIDS 3007HY occupation profile codifies them. What that profile cannot show is what they look like when held together — integrated, in a real client situation, by a counselor making real decisions. That is what this capstone module is about."},
          {"type": "subheading", "content": "The three bands you have worked through"},
          {"type": "list", "items": [
            "CORE (Modules 1-9) — the technical foundation: financial literacy, time value of money, credit and debt, risk management, taxes, investments, retirement, estate planning, ethics and regulation. 144 hours of related instruction.",
            "OJL-A Client-Facing (Modules 10-18) — the practice of working with clients: discovery, goal-setting, document collection, financial statements, behavioral coaching, risk profiling, plan presentation, implementation, ongoing reviews. The relational core of the work.",
            "OJL-B Advanced/Operations (Modules 19-30) — the technical depth and operational discipline: portfolio construction, investment research, asset allocation, performance reporting, trading, tax-loss harvesting, account administration, reconciliation, compliance, cybersecurity, practice management, and this capstone."
          ]},
          {"type": "subheading", "content": "What the competencies are not"},
          {"type": "paragraph", "content": "The competencies are not a checklist that, once completed, makes you a finished counselor. They are a foundation. Real mastery happens through repetition — hundreds of client conversations, dozens of implementations, several major life events for clients you walked through them with. The apprenticeship gives you the shape of the work. The first ten years of practice give you the substance. Plan accordingly: graduating from the program is the beginning, not the end, of your professional development."},
          {"type": "callout", "kind": "key", "content": "An apprenticeship graduate who treats the credential as the destination is not yet what the credential represents. An apprenticeship graduate who treats the credential as the starting line of a thirty-year practice is."},
          {"type": "subheading", "content": "Self-assessment — where do you stand?"},
          {"type": "paragraph", "content": "Before the capstone exercise, take honest stock. For each of the thirty competencies, you fit one of three buckets: solid — you can apply this competency in real client work without supervision; functional — you can apply this competency with some supervision or specific reference; developing — you understand this competency but have not yet demonstrated it under real conditions. There is no shame in being 'developing' on multiple competencies. Most apprenticeship graduates are. Knowing where you are honest about it is what makes the next five years productive."},
          {"type": "activity", "title": "Self-assessment exercise", "prompt": "Build your personal competency map. For each of the thirty competencies, label yourself solid, functional, or developing. Identify the three you most want to deepen in your first year post-apprenticeship. Identify the one you most need help on from a senior mentor. This document is for you — not graded, not shared unless you choose. Update it annually for the next five years.", "steps": [
            "List all thirty competencies",
            "Label each (solid / functional / developing)",
            "Identify your top three priorities for the coming year",
            "Identify the one competency where you most need senior mentorship",
            "Sketch a development plan for each priority — what would advancement look like, what resources, what timeline",
            "Set a calendar reminder to review and update this document in one year"
          ]}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Capstone Exercise — The Full Client Lifecycle",
        "summary": "Take a single client through the full year of an engagement, from first inquiry through the first annual review. Apply every band of competencies in sequence. This is the integration the apprenticeship is designed to produce.",
        "read_time": "14 min read",
        "blocks": [
          {"type": "paragraph", "content": "The capstone exercise asks you to lead a full client engagement — either a real client under supervision, a comprehensive simulation with a designated case study, or a structured role-play with your mentor. Whichever format your firm uses, the exercise covers the full lifecycle, with deliverables and review points at each stage. The work integrates everything you have learned. The point is not to be perfect. The point is to demonstrate that the competencies live in your hands now, not just in your head."},
          {"type": "subheading", "content": "Stage 1 — Inquiry to first meeting"},
          {"type": "numbered", "items": [
            "Inbound inquiry intake — what information do you gather, how do you respond, what is the timeline to first meeting?",
            "Pre-meeting research — what do you learn about the prospect before they walk in?",
            "Conflict and capacity check — does this client fit the firm's service model? Are there any conflicts that need to be addressed?",
            "First meeting agenda — what are you trying to accomplish, what do they need to leave knowing?",
            "Deliverable: a brief pre-meeting memo capturing what you know and what you need to learn"
          ]},
          {"type": "subheading", "content": "Stage 2 — Discovery and engagement"},
          {"type": "numbered", "items": [
            "Discovery conversation — apply Module 10 fully; surface goals, life context, financial picture, and emotional landscape",
            "Goal-setting and prioritization — work with the client to articulate what matters in priority order (Module 11)",
            "Document collection — list every document you need; coordinate getting them gathered (Module 12)",
            "Engagement agreement and fee disclosure — clear written description of what they receive, what it costs, conflicts and standards of conduct",
            "Deliverable: signed engagement agreement, prioritized goals document, document collection tracker"
          ]},
          {"type": "subheading", "content": "Stage 3 — Analysis"},
          {"type": "numbered", "items": [
            "Build financial statements — net worth, cash flow, projections (Module 13)",
            "Apply the technical CORE competencies — tax position, risk coverage, retirement projection, estate review, debt analysis",
            "Risk profiling and suitability documentation (Module 15)",
            "Behavioral observations — what coaching is this client likely to need over time (Module 14)",
            "Recommendation development — what do you recommend, in what priority, with what tradeoffs",
            "Deliverable: full plan document with executive summary, findings, recommendations, and implementation plan"
          ]},
          {"type": "subheading", "content": "Stage 4 — Presentation and decision"},
          {"type": "numbered", "items": [
            "Plan presentation meeting — apply Module 16 fully; lead with goals, surface findings, present recommendations, handle questions",
            "Documentation of client decisions — what was agreed, what was declined, why",
            "Investment Policy Statement signing — pre-commitment for the relationship",
            "Action list with owners and dates",
            "Deliverable: signed IPS, completed action list, meeting recap email to client within 24 hours"
          ]},
          {"type": "subheading", "content": "Stage 5 — Implementation"},
          {"type": "numbered", "items": [
            "Sequence the implementation correctly (Module 17) — account opens before transfers, beneficiaries same day, tax-aware timing",
            "Coordinate with external professionals — CPA, attorney, insurance broker — with proper authorization",
            "Execute account opens, rollovers, contribution changes, beneficiary updates",
            "Build the portfolio — apply Modules 19-21 to construct, document the allocation rationale",
            "Verify every action on the source system; close the loop on each item",
            "Deliverable: completed implementation tracker with every item verified, client notification of completion"
          ]},
          {"type": "subheading", "content": "Stage 6 — Ongoing relationship and first annual review"},
          {"type": "numbered", "items": [
            "Establish review cadence and document in CRM (Module 18)",
            "Quarterly performance reporting — accurate, contextualized, plain language (Module 22)",
            "Trading and rebalancing as needed (Modules 21, 23)",
            "Tax-loss harvesting if applicable (Module 24)",
            "Mid-year touchpoint — confirm progress, surface any life changes",
            "Annual review meeting at the one-year mark — lead through the five-section structure, surface what changed, refresh action items",
            "Deliverable: written annual review summary, updated plan document, refreshed action list, scheduled next year's cadence"
          ]},
          {"type": "subheading", "content": "Review and reflection"},
          {"type": "paragraph", "content": "At the end of the full lifecycle, sit down with your supervising counselor or mentor for a structured review. What worked, what did not, what surprised you, what would you do differently, what competencies surfaced as strongest and which as needing more development. This conversation is the most valuable part of the exercise. The deliverables matter. The reflection matters more."},
          {"type": "callout", "kind": "do", "content": "Write the reflection in your own words and save it. Five years from now, reading what you wrote at the end of your apprenticeship will be a meaningful check on how you have grown and where you stayed the same."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Articulating a Personal Philosophy of Practice",
        "summary": "The technical competencies are universal. How you choose to practice them is yours. The counselor you become is shaped by the philosophy you build — explicitly or by default.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Two counselors with identical technical training and identical client bases can practice very differently — and over a 30-year career the difference compounds enormously. The counselor who developed an explicit philosophy of practice early — who decided what kind of counselor they wanted to be and made decisions accordingly — tends to look different at year fifteen than the counselor who let the practice shape them by default."},
          {"type": "subheading", "content": "Questions worth answering — out loud, in writing"},
          {"type": "list", "items": [
            "What kind of clients do I most want to serve, and why?",
            "What kind of work energizes me, and what kind drains me?",
            "What do I consider non-negotiable in client work — values I will not compromise on?",
            "What do I want to be known for in five years? In fifteen?",
            "How do I want clients to describe me to their friends?",
            "How will I know if I am drifting from the kind of counselor I want to be?",
            "What does 'success' mean to me in this career — beyond income and AUM?",
            "How will I sustain myself emotionally and intellectually for decades of this work?"
          ]},
          {"type": "paragraph", "content": "These questions do not have one right answer. They have your answer. The discipline is to answer them honestly, write the answers down, and revisit them periodically. Many counselors find their answers shift over the first five to ten years of practice and then stabilize. The shifts themselves are useful information — they show you what you are learning about yourself."},
          {"type": "subheading", "content": "The clients you want to serve"},
          {"type": "paragraph", "content": "Most counselors discover within a few years that they do their best work with certain kinds of clients and merely competent work with others. Some counselors thrive with mid-career professionals navigating complexity; others with retirees seeking simplification; others with business owners going through liquidity events; others with multi-generational family wealth. None of these is the right answer for everyone. Knowing which is the right answer for you shapes how you build your practice and what referral patterns you cultivate."},
          {"type": "subheading", "content": "The work you will not do"},
          {"type": "paragraph", "content": "Equally important — what kind of work, or what kind of clients, will you decline? A fiduciary practice can decline engagements that are wrong for the firm. A counselor who tries to be all things to all clients eventually serves no one well. Knowing your no is part of knowing your yes. Examples of legitimate no's: 'I don't do high-frequency trading advice.' 'I don't work with crypto-focused portfolios as a primary strategy.' 'I don't take on clients who require day-of access.' 'I don't accept gifts from clients beyond [firm threshold].' Define your no's early."},
          {"type": "subheading", "content": "How you measure yourself"},
          {"type": "paragraph", "content": "If the only metric is revenue or AUM, the practice optimizes for revenue or AUM. That has been a recipe for some of the industry's worst conduct historically. Healthier metrics — client retention, complaint rate, second-generation client retention (when client's adult children also become clients), peer respect, the number of clients who would describe you as 'the person we trust most with our finances' — produce different practices. Pick the metrics that match the philosophy. Track them. Let them shape decisions."},
          {"type": "case_study", "title": "Julius and the Life House framework", "scenario": "Before GIC built this apprenticeship, Julius Jackson built Life House Reentry — a workshop system helping formerly incarcerated people build financial lives. The Life House framework was explicit about philosophy: dignity first, accessibility before sophistication, education embedded in every transaction, no one shamed for what they did not know. When Julius brought Life House thinking into GIC's apprenticeship design, that philosophy traveled with him. The values that shape this curriculum — clear language, behavioral attention, fiduciary discipline, client-centered design — are an expression of a philosophy worked out long before any of these modules were written.", "discussion": "Notice what happened: a philosophy developed in one context shaped a curriculum developed in another. That is what philosophy does — it shapes the work consistently across the situations the work takes you to. Build yours deliberately. It will travel with you."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Continuing Education and Credentials Beyond the Apprenticeship",
        "summary": "Graduating from the apprenticeship sets the table for a career of continued learning. Here is what comes next.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Apprenticeship completion is recognized by the U.S. Department of Labor as a journey-level credential in the Wealth Solutions Counselor occupation. It demonstrates that you have completed structured related instruction, accumulated qualifying on-the-job learning hours, and demonstrated competence across the thirty competencies. It is real. It is portable. It positions you for the next phase. But the financial services industry has its own credentialing landscape that will continue to shape your career."},
          {"type": "subheading", "content": "Licensing — required for many practice paths"},
          {"type": "list", "items": [
            "Series 65 (Uniform Investment Adviser Law Examination) — required for most investment adviser representatives at RIAs; often the first license a new counselor obtains",
            "Series 7 (General Securities Representative) — required for broker-dealer registered representatives; broader than Series 65 but with different scope",
            "Series 66 (combined 63 + 65) — common alongside Series 7",
            "Series 63 (Uniform Securities Agent State Law) — state-level for broker-dealer reps in addition to Series 7",
            "State insurance licenses — required to sell or advise on insurance products in each state of practice",
            "Series 24, 26, 27, 28, 51, 53, 99 — various supervisory and operations licenses; relevant as career advances"
          ]},
          {"type": "subheading", "content": "Major credentials by stage of career"},
          {"type": "glossary", "terms": [
            {"term": "CFP (Certified Financial Planner)", "definition": "The most widely-held planning credential. Requires bachelor's degree, completion of CFP Board-approved coursework, 6,000 hours of professional experience (or 4,000 hours of apprenticeship experience), passing the CFP exam, and ongoing CE. Often the first major credential pursued."},
            {"term": "ChFC (Chartered Financial Consultant)", "definition": "Alternative to CFP from The American College. Similar curriculum, different sponsoring organization, no comprehensive exam."},
            {"term": "CFA (Chartered Financial Analyst)", "definition": "Investment-focused credential from CFA Institute. Three rigorous exams, four years of qualified work experience. Less common for planners; more common for investment analysts and portfolio managers."},
            {"term": "EA (Enrolled Agent)", "definition": "Tax specialist credential from the IRS. Strong complement for counselors doing significant tax planning work."},
            {"term": "CPWA (Certified Private Wealth Advisor)", "definition": "From the Investments and Wealth Institute. Advanced credential for HNW practice. Often pursued mid-career."},
            {"term": "CIMA (Certified Investment Management Analyst)", "definition": "Investment consulting credential from the Investments and Wealth Institute. Often pursued by counselors focused on portfolio construction."},
            {"term": "AAMS, CRPC, RICP", "definition": "Specialty credentials in accredited asset management, retirement planning, and retirement income — each fills a specific niche."}
          ]},
          {"type": "subheading", "content": "Continuing education requirements"},
          {"type": "paragraph", "content": "Every license and credential carries CE obligations — typically 24-40 hours over a renewal cycle of 1-2 years. Most firms cover or facilitate CE. Plan your CE strategically: use it to advance areas you want to deepen (a counselor specializing in equity comp might pursue advanced equity comp CE; a counselor specializing in retirement income might pursue RICP-related material). Done well, CE is a structured way to keep growing across decades. Done badly, it is a compliance checkbox."},
          {"type": "subheading", "content": "Beyond formal credentials — reading, writing, networking"},
          {"type": "paragraph", "content": "Some of the most important professional development happens outside formal CE. Reading widely — Kahneman, Bernstein, Bogle, Pfau, Kitces, Bernstein, current academic research, current industry publications. Writing — articles, even short notes; the discipline of writing clarifies thinking and builds visibility. Networking — peer relationships with other counselors at other firms, study groups, professional associations like NAPFA or the FPA. Mentoring junior apprentices — teaching the work is one of the best ways to deepen it. Attending one or two strong conferences a year. The cumulative effect over a career is significant."},
          {"type": "callout", "kind": "do", "content": "In your first year post-apprenticeship, commit to: completing the Series 65 if not already done, registering for the CFP curriculum, joining a professional association, and reading one practice-relevant book per quarter. By year three, sit for the CFP exam. By year seven, complete it. By year ten, consider advanced credentials or specialty designations. This is a long game played in small consistent moves."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing — The Counselor You Become",
        "summary": "A final reflection. You arrived at this apprenticeship as one kind of person. You finish it as another. What kind of counselor will you become next?",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "You started this curriculum on day one of the apprenticeship as someone learning the language of money. Through related instruction and hundreds of hours of supervised practice, you have built the foundations of a craft. You have learned how money moves through a household, how decisions get made under uncertainty, how to coach clients through fear and euphoria, how to design portfolios and communicate risk, how to run the operational discipline that protects client trust, and how to think about the business of a practice that lasts decades."},
          {"type": "paragraph", "content": "What you carry forward is not just technical knowledge. It is the orientation of a counselor — someone who sits across from another person at a difficult moment in their financial life and brings real competence, real care, and real fiduciary discipline to the conversation. That orientation is rare in the financial services industry. The industry is full of salespeople, of product pushers, of people willing to leave clients worse off in exchange for commissions. You have been trained for something different."},
          {"type": "subheading", "content": "What the work asks of you, going forward"},
          {"type": "list", "items": [
            "Show up prepared, every meeting, every time — the client trusted you with their time",
            "Tell the truth, including hard truth, with care but without flinching",
            "Document your work — your future self and your clients depend on it",
            "Coordinate with the other professionals in your client's life — you are not alone, do not act like it",
            "Keep learning — the curriculum ended; the learning has not",
            "Mentor the apprentices who come after you — the work continues through people, not through documents",
            "Protect the relationship — money will come and go, market cycles will rise and fall, but the relationship is what makes the practice possible",
            "Sustain yourself — physically, emotionally, intellectually — so that you can do this for thirty years"
          ]},
          {"type": "subheading", "content": "What GIC is hoping you become"},
          {"type": "paragraph", "content": "Global Investment Company built this apprenticeship as a long-horizon investment in counselors who can carry the firm's standards into the next generation of clients. The standards: integrity, intelligence, impact. The clients you will serve over your career include people who would never have access to fiduciary planning under the old industry model. The work you do will help people whose financial lives have historically been served badly or not at all. That is part of why this apprenticeship exists. That is part of why your career matters."},
          {"type": "callout", "kind": "key", "content": "Be a counselor your clients describe, fifteen years from now, as 'the person who actually changed how we live with money.' That is the standard. That is what the work is for."},
          {"type": "subheading", "content": "Acknowledging the predecessors"},
          {"type": "paragraph", "content": "The framework of this apprenticeship draws on the Life House Reentry workshop system that preceded GIC's involvement — a system originally built to help formerly incarcerated people rebuild financial lives with dignity. The dignity-first orientation, the commitment to clear language, the refusal to shame anyone for what they did not know — these came from Life House. They live in this curriculum. Carry them forward. Anywhere you practice. With every client you serve."},
          {"type": "subheading", "content": "The final exercise — your own commitment"},
          {"type": "activity", "title": "Write your one-page commitment", "prompt": "Before you mark this module complete, write a one-page document, addressed to yourself, capturing the following: the kind of counselor you intend to be, the principles you will hold yourself to, the clients you most want to serve, the work you will not do, the metrics by which you will measure yourself, and your development plan for the next five years. Date it. Sign it. Save it where you will see it again. Read it on the first day of every year for the rest of your career.", "steps": [
            "Open a fresh document — paper or digital, your choice",
            "Title it: 'My Practice — Commitments at Apprenticeship Completion'",
            "Write each of the six sections above in your own words, one paragraph each",
            "Date and sign",
            "Save somewhere durable — version-controlled, in a personal vault, or in a sealed envelope you open on Jan 1 each year",
            "Set a recurring calendar reminder for January 1 of each year to re-read and reflect"
          ]},
          {"type": "divider"},
          {"type": "paragraph", "content": "Welcome to the profession. The thirty modules end here. The career begins now. The clients who will sit across from you over the coming decades — some of whom have not yet been born, some of whom are at the lowest moments of their financial lives right now — are why this work exists. Be ready for them. Stay curious. Stay honest. Stay in the work."},
          {"type": "paragraph", "content": "Congratulations on completing the Wealth Solutions Counselor Apprenticeship."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The thirty competencies of the apprenticeship are best understood as:", "options": ["A complete and final certification", "A foundation that becomes mastery through years of repeated practice — the credential is the start, not the destination", "A checklist that determines compensation", "A regulatory requirement disconnected from practice"], "correct": 1, "explanation": "Real mastery comes from repetition with real clients over years. The apprenticeship gives the shape; the next decade gives the substance."},
        {"id": "q2", "prompt": "The CFP credential typically requires:", "options": ["Only a passing exam", "Bachelor's degree, CFP Board-approved coursework, qualifying work experience, passing the CFP exam, and ongoing CE", "A graduate degree in finance", "Ten years in the industry"], "correct": 1, "explanation": "The CFP has multiple requirements — coursework, exam, experience, ongoing CE — and is often the first major credential pursued after the apprenticeship."},
        {"id": "q3", "prompt": "Series 65 is required for:", "options": ["Most investment adviser representatives at RIAs", "Selling insurance products", "All financial planning work", "Only operations staff"], "correct": 0, "explanation": "The Series 65 is the standard license for investment adviser representatives at RIAs and is often the first license pursued after apprenticeship."},
        {"id": "q4", "prompt": "Knowing the work and clients you will *decline* is best described as:", "options": ["Lazy practice management", "Part of knowing your yes — defining no's protects the practice and serves the right clients better", "A way to lose revenue", "A regulatory requirement"], "correct": 1, "explanation": "Counselors who try to be all things to all clients eventually serve no one well. Defining no's is part of a healthy practice."},
        {"id": "q5", "prompt": "Useful metrics for a counselor's own measurement beyond revenue might include:", "options": ["Hours worked per week only", "Client retention, complaint rate, second-generation client retention, peer respect, and clients who describe you as the person they trust most", "Number of leads contacted", "Marketing spend"], "correct": 1, "explanation": "Healthier metrics produce healthier practices. Revenue-only optimization has been a recipe for some of the industry's worst conduct."},
        {"id": "q6", "prompt": "The capstone exercise asks the apprentice to:", "options": ["Take a written final exam", "Lead a full client lifecycle from inquiry through first annual review, integrating competencies across all three bands", "Memorize all thirty competencies", "Pass the Series 65"], "correct": 1, "explanation": "The capstone is integration — demonstrating that the competencies live in your hands, not just your head, through a sustained client engagement."},
        {"id": "q7", "prompt": "Continuing education over a counselor's career is most valuable when:", "options": ["Completed as a minimum compliance checkbox", "Used strategically to deepen areas of specialization and pursue advanced credentials over time", "Limited to mandatory hours", "Done only in the final year of a license cycle"], "correct": 1, "explanation": "Strategic CE — chosen to advance specialization and pursue advanced credentials — compounds into a meaningful career trajectory."},
        {"id": "q8", "prompt": "GIC's commitment to a registered apprenticeship pathway rather than hiring experienced advisors externally reflects:", "options": ["A short-term cost-saving measure", "A long-horizon investment in growing aligned, capable counselors from the ground up, with retention and succession benefits", "A regulatory requirement", "A staffing emergency"], "correct": 1, "explanation": "Apprenticeship is a multi-year bet that pays back through alignment, retention, and succession capacity over many years."},
        {"id": "q9", "prompt": "The most important habit for an apprenticeship graduate's first year of practice is:", "options": ["Maximizing new client acquisition", "Returning to formal study", "Showing up prepared for every client meeting, telling the truth including hard truth, documenting work, and continuing to learn", "Pursuing the next credential immediately"], "correct": 2, "explanation": "These are the daily disciplines that build a real counselor. Credentials and growth follow from them, not the other way around."},
        {"id": "q10", "prompt": "The Life House Reentry framework that preceded GIC's apprenticeship contributed which orientation to this curriculum?", "options": ["High-frequency trading techniques", "Dignity first, accessibility before sophistication, clear language, refusal to shame anyone for what they did not know", "A specific portfolio strategy", "A marketing approach"], "correct": 1, "explanation": "The dignity-first, accessibility-focused, clear-language orientation traveled from Life House into this curriculum and into the kind of counselor it produces."},
        {"id": "q11", "prompt": "Counselor longevity over a 30-year career is best supported by:", "options": ["Working harder during peak years", "Avoiding emotionally taxing client situations", "Sustained investment in life outside the work — relationships, health, intellectual interests, rest — alongside the work itself", "Switching specialties every few years"], "correct": 2, "explanation": "Counseling is emotionally taxing. Sustaining yourself across decades requires deliberate investment in the rest of your life, which makes the work possible to keep doing well."},
        {"id": "q12", "prompt": "The one-page commitment document at the end of this module is intended to:", "options": ["Be submitted for grading", "Be shared publicly", "Be reread on January 1 of each year for the rest of your career, as a personal check on the kind of counselor you intend to be", "Replace the firm's compliance manual"], "correct": 2, "explanation": "The commitment is for you. Reading it annually keeps the philosophy of practice deliberate rather than letting it drift by default."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 32;

-- ── final_exam_setup.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — FINAL COMPREHENSIVE EXAM
-- 30 questions, one per competency, integration-level assessment
-- Passing score: 85% (26 of 30 correct)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Schema: final_exams + final_exam_attempts (idempotent)
-- ----------------------------------------------------------------------------

create table if not exists public.final_exams (
  id uuid primary key default gen_random_uuid(),
  exam_code text unique not null,
  title text not null,
  description text,
  passing_score integer not null default 85,
  content jsonb not null,
  is_active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.final_exam_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  exam_code text not null,
  score integer not null,
  total_questions integer not null,
  passed boolean not null,
  answers jsonb,
  competency_breakdown jsonb,
  started_at timestamptz default now(),
  completed_at timestamptz default now(),
  reviewed_by uuid references auth.users(id),
  reviewed_at timestamptz,
  review_notes text
);

create index if not exists final_exam_attempts_user_idx
  on public.final_exam_attempts(user_id);
create index if not exists final_exam_attempts_exam_idx
  on public.final_exam_attempts(exam_code);

-- ----------------------------------------------------------------------------
-- 2. RLS
-- ----------------------------------------------------------------------------

alter table public.final_exams enable row level security;
alter table public.final_exam_attempts enable row level security;

drop policy if exists "final_exams readable by authenticated" on public.final_exams;
create policy "final_exams readable by authenticated"
  on public.final_exams for select
  using (auth.role() = 'authenticated' and is_active = true);

drop policy if exists "final_exams admin manage" on public.final_exams;
create policy "final_exams admin manage"
  on public.final_exams for all
  using (
    exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver')
    )
  );

drop policy if exists "exam_attempts own read" on public.final_exam_attempts;
create policy "exam_attempts own read"
  on public.final_exam_attempts for select
  using (
    user_id = auth.uid()
    or exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver', 'mentor')
    )
  );

drop policy if exists "exam_attempts own insert" on public.final_exam_attempts;
create policy "exam_attempts own insert"
  on public.final_exam_attempts for insert
  with check (user_id = auth.uid());

drop policy if exists "exam_attempts admin review" on public.final_exam_attempts;
create policy "exam_attempts admin review"
  on public.final_exam_attempts for update
  using (
    exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver')
    )
  );

-- Trigger for updated_at (depends on tg_set_updated_at() from session 1)
drop trigger if exists final_exams_set_updated_at on public.final_exams;
create trigger final_exams_set_updated_at
  before update on public.final_exams
  for each row execute function public.tg_set_updated_at();

-- ----------------------------------------------------------------------------
-- 3. Insert the comprehensive final exam
-- ----------------------------------------------------------------------------

insert into public.final_exams (exam_code, title, description, passing_score, content)
values (
  'FINAL-COMPREHENSIVE',
  'Wealth Solutions Counselor — Final Comprehensive Exam',
  'Capstone assessment covering all thirty competencies of the apprenticeship. One question per competency, integration-level scenarios drawn from real client work. Must be completed after all thirty modules and signed off by the supervising counselor. Passing score: 85% (26 of 30 correct).',
  85,
  $jsonb$
  {
    "exam_type": "final_comprehensive",
    "intro": {
      "title": "Final Comprehensive Exam",
      "summary": "Thirty integration-level questions covering all thirty competencies. This is the final assessment of the Wealth Solutions Counselor apprenticeship.",
      "instructions": [
        "You must have completed all thirty modules before sitting for this exam.",
        "Your supervising counselor must have signed off on your apprenticeship completion before submission counts.",
        "Passing score is 85% — 26 of 30 questions correct.",
        "The exam covers integration of competencies in scenarios drawn from real client work. Recall alone is not sufficient — apply what you have learned.",
        "If you do not pass on the first attempt, a retake may be scheduled after additional review with your mentor on the competencies missed.",
        "Take the time you need. This is not timed. Quality of reasoning matters more than speed.",
        "After you submit, your supervising counselor and the firm's approver will review the result and any apprenticeship documentation."
      ]
    },
    "passing_score": 85,
    "competency_count": 30,
    "questions": [
      {
        "id": "q1",
        "competency": "CORE-1",
        "competency_name": "Financial Literacy & Planning",
        "prompt": "A client reports monthly take-home income of $8,400 and expenses of $7,950, telling you they feel they 'should be saving more.' The strongest next move is to:",
        "options": [
          "Recommend they begin saving $1,500 per month immediately",
          "Walk through their expense categories — fixed, variable, discretionary — to build savings around an honest cash flow picture rather than an aspirational one",
          "Suggest a budgeting app and end the conversation",
          "Defer planning until next year's tax return is filed"
        ],
        "correct": 1,
        "explanation": "Cash flow analysis must precede savings recommendations. Imposing a savings target the cash flow cannot support invites failure and damages trust. Working through real categories produces sustainable saving."
      },
      {
        "id": "q2",
        "competency": "CORE-2",
        "competency_name": "Time Value of Money",
        "prompt": "A 30-year-old client has $25,000 saved, can contribute $500 per month, and expects 7% nominal annualized returns. At age 65, the projected balance is approximately:",
        "options": [
          "~$300,000",
          "~$580,000",
          "~$1.1 million",
          "~$2.5 million"
        ],
        "correct": 2,
        "explanation": "Lump-sum future value of $25,000 at 7% for 35 years is roughly $267,000. Future value of a $500/month annuity at 7% over 35 years is roughly $900,000. Combined ≈ $1.17M. This is the power of compounding paired with consistent contribution."
      },
      {
        "id": "q3",
        "competency": "CORE-3",
        "competency_name": "Credit, Debt & Lending",
        "prompt": "Marcus and Tasha carry credit card debt at 22% APR, an auto loan at 6%, and a mortgage at 4.5%. With $1,500 of extra monthly cash flow, the mathematically optimal payoff strategy is:",
        "options": [
          "Pay off the smallest balance first regardless of rate (debt snowball)",
          "Apply all extra to the highest-rate debt — the credit card at 22% — first (debt avalanche)",
          "Distribute extra payments evenly across all three",
          "Accelerate the mortgage first because of the long term"
        ],
        "correct": 1,
        "explanation": "The avalanche method — extra payments to the highest-interest debt first — minimizes total interest paid. The snowball method has behavioral advantages but is mathematically suboptimal. Knowing both and choosing intentionally with the client is the skill."
      },
      {
        "id": "q4",
        "competency": "CORE-4",
        "competency_name": "Risk Management & Insurance",
        "prompt": "A 38-year-old primary earner with two young children, a non-working spouse, a $500,000 mortgage, and $25,000 in savings has the most urgent insurance need for:",
        "options": [
          "Whole life insurance with cash value accumulation",
          "Term life insurance with a death benefit sized to replace income through child independence and pay off the mortgage",
          "A deferred annuity",
          "Long-term care insurance"
        ],
        "correct": 1,
        "explanation": "The catastrophic loss for this household is the loss of the earner. Term life — cheap, large death benefit, matched to the dependency horizon — is the right tool. Whole life addresses different problems and is not the urgent need here."
      },
      {
        "id": "q5",
        "competency": "CORE-5",
        "competency_name": "Tax Fundamentals",
        "prompt": "A client in the 24% federal marginal tax bracket contributes $7,000 to a Traditional IRA (assume full deductibility). The immediate federal income tax savings is approximately:",
        "options": [
          "$7,000",
          "$1,680",
          "$2,400",
          "$0 — IRA contributions never reduce current taxes"
        ],
        "correct": 1,
        "explanation": "$7,000 × 24% = $1,680. Traditional IRA contributions reduce current taxable income, with savings calculated at the marginal rate. The full $7,000 is not saved — only the tax on that income would have been."
      },
      {
        "id": "q6",
        "competency": "CORE-6",
        "competency_name": "Investment Vehicles & Markets",
        "prompt": "An ETF and a mutual fund tracking the same index differ most importantly in:",
        "options": [
          "Their underlying holdings — they hold different securities",
          "Structural differences affecting tax efficiency, intraday tradability, and expense ratios — with ETFs generally more tax-efficient due to in-kind creation/redemption",
          "Return potential — ETFs outperform mutual funds",
          "Regulatory oversight — only one is SEC-regulated"
        ],
        "correct": 1,
        "explanation": "Same index, same holdings, materially different structure. ETFs trade intraday on exchanges and use in-kind transfers that limit capital gains distributions. Mutual funds price once daily and can distribute taxable gains to all shareholders."
      },
      {
        "id": "q7",
        "competency": "CORE-7",
        "competency_name": "Retirement Planning Foundations",
        "prompt": "A client with a Social Security Full Retirement Age (FRA) of 67 claims benefits at age 62. They will receive approximately what percentage of their Primary Insurance Amount (PIA)?",
        "options": [
          "100% — claiming early has no permanent effect",
          "About 70% — claiming five years early permanently reduces the benefit",
          "50% — early claiming halves the benefit",
          "132% — early claiming triggers delayed retirement credits"
        ],
        "correct": 1,
        "explanation": "Claiming at 62 with an FRA of 67 reduces the benefit to roughly 70% of PIA, permanently. Conversely, delaying past FRA earns 8% annually in delayed retirement credits up to age 70."
      },
      {
        "id": "q8",
        "competency": "CORE-8",
        "competency_name": "Estate Planning & Wealth Transfer",
        "prompt": "A client has a will leaving everything to their spouse. They also have an IRA on which an old beneficiary form names their adult child from a prior marriage as 100% beneficiary. Upon the client's death, the IRA passes to:",
        "options": [
          "The spouse, because the will controls all assets",
          "The adult child named on the beneficiary form, because retirement account beneficiary designations override the will",
          "The estate, splitting between spouse and child",
          "Probate court — to be decided by a judge"
        ],
        "correct": 1,
        "explanation": "Beneficiary designations on retirement accounts and life insurance are non-probate transfers that override the will. This is one of the most consequential and routinely-mishandled details in estate planning."
      },
      {
        "id": "q9",
        "competency": "CORE-9",
        "competency_name": "Ethics, Fiduciary Duty & Regulation",
        "prompt": "A counselor recommends a product paying them a 5% commission when an equally suitable, lower-cost no-commission alternative exists. Under a fiduciary standard, this:",
        "options": [
          "Is permissible if disclosed to the client",
          "Violates the duty of loyalty — the recommendation must be in the client's best interest, not the counselor's, regardless of disclosure",
          "Is required by FINRA",
          "Is acceptable if the recommended product performs well"
        ],
        "correct": 1,
        "explanation": "Fiduciary duty is more than disclosure. Loyalty requires the client's best interest to come first. Disclosure cures conflicts in some circumstances but does not cure choosing a worse option for the client because it pays the counselor more."
      },
      {
        "id": "q10",
        "competency": "OJL-1",
        "competency_name": "Client Discovery & Intake",
        "prompt": "In a discovery meeting, a client casually mentions 'I had some health issues last year' and immediately changes the topic. The most appropriate response is to:",
        "options": [
          "Move on — health is outside financial planning scope",
          "Pause and ask one open question to understand whether the health event affects current planning, while leaving the client in control of how much to share",
          "Request medical records to update risk profile",
          "Refer them to a physician"
        ],
        "correct": 1,
        "explanation": "Health events have real planning implications — disability insurance, retirement timing, estate planning, cash flow. But pressing too hard breaks trust. The skill is acknowledging gently and inviting one more sentence without prying."
      },
      {
        "id": "q11",
        "competency": "OJL-2",
        "competency_name": "Goal-Setting & Prioritization",
        "prompt": "A client lists six goals: emergency fund, debt payoff, retirement saving, kids' college, vacation home, kitchen renovation. With limited cash flow, the right next step is to:",
        "options": [
          "Pursue all six simultaneously with equal funding",
          "Tell the client to pick the single most important goal",
          "Help the client sequence and prioritize, distinguishing foundational goals (emergency fund, high-rate debt) from longer-horizon and discretionary goals",
          "Pursue them in the order the client listed"
        ],
        "correct": 2,
        "explanation": "Foundational goals (emergency reserve, high-rate debt) usually need to be at least partially established before longer-horizon goals can be safely funded. Sequencing is a counselor skill — not a personal ranking but a structural one."
      },
      {
        "id": "q12",
        "competency": "OJL-3",
        "competency_name": "Document Collection & Analysis",
        "prompt": "The most efficient and reliable way to manage document collection across a client base is:",
        "options": [
          "Ad hoc emails when something specific is needed",
          "A consistent tracker (CRM or shared list) showing requested, received, and outstanding items per client, reviewed at a regular cadence with clear next actions",
          "Wait for clients to send what they think is relevant",
          "Collect everything at once in a single massive request"
        ],
        "correct": 1,
        "explanation": "Document collection is operational discipline. A tracker prevents drop-through, reduces follow-up friction, and lets the counselor verify status in seconds rather than hunting through email threads."
      },
      {
        "id": "q13",
        "competency": "OJL-4",
        "competency_name": "Building Financial Statements",
        "prompt": "A client's net worth has increased $80,000 year-over-year. Their cash flow statement shows only $15,000 in savings from income during the same period. The most likely explanation is:",
        "options": [
          "The savings figure is understated and must be corrected",
          "Asset appreciation — investments and home equity — accounts for most of the increase, since net worth reflects both cash flow contributions and market value changes",
          "The client is hiding income",
          "The cash flow statement is wrong"
        ],
        "correct": 1,
        "explanation": "Net worth changes from two sources: contributions from cash flow, and appreciation/depreciation of existing assets. A counselor who conflates the two will misread the client's actual savings discipline."
      },
      {
        "id": "q14",
        "competency": "OJL-5",
        "competency_name": "Behavioral Finance & Client Coaching",
        "prompt": "A client emails at 11pm wanting to 'move everything to cash' after an 18% portfolio drop. The strongest next-morning response is to:",
        "options": [
          "Process the trade per the client's written instructions",
          "Reply with a chart of long-term market returns and a recommendation to stay the course",
          "Call the client, acknowledge the fear before any data, and only then walk through what the plan was designed to do in exactly this scenario",
          "Refer them to a mental health professional"
        ],
        "correct": 2,
        "explanation": "Clients in fear cannot hear data until they feel heard. The emotion comes first, the data follows. Charts emailed in response to panic almost always fail. A live conversation that begins with the feeling almost always works."
      },
      {
        "id": "q15",
        "competency": "OJL-6",
        "competency_name": "Risk Profiling & Suitability",
        "prompt": "A 24-year-old client with high stated risk tolerance wants to invest a house down payment they will use in approximately 18 months. The portfolio decision should be driven primarily by:",
        "options": [
          "Their high stated risk tolerance — aggressive equity allocation",
          "Risk capacity — the 18-month horizon for the specific dollar means short-term instruments are appropriate regardless of stated tolerance",
          "A standard 60/40 allocation",
          "Maximizing expected return given their long career horizon"
        ],
        "correct": 1,
        "explanation": "Capacity beats tolerance every time. The dollar's job determines its allocation. An 18-month down payment has zero capacity for equity drawdown no matter how aggressive the client says they are."
      },
      {
        "id": "q16",
        "competency": "OJL-7",
        "competency_name": "Plan Presentation & Communication",
        "prompt": "Presenting a plan with five recommendations, the most effective sequencing is:",
        "options": [
          "Hardest first to get the difficult conversation over with",
          "Random order to keep the client engaged",
          "High-impact, easy wins first to build momentum and agreement before harder asks",
          "Alphabetical for clarity"
        ],
        "correct": 2,
        "explanation": "A client who has agreed to three things in the first ten minutes is far more likely to agree to a harder fourth. Sequencing intentionally — easy wins first, hardest ask last — is communication craft."
      },
      {
        "id": "q17",
        "competency": "OJL-8",
        "competency_name": "Implementation & Coordination",
        "prompt": "A 401(k) rollover check arrives at the client's home made payable to the client (not to the receiving custodian). The right immediate action is to:",
        "options": [
          "Have the client deposit the check and complete the 60-day indirect rollover",
          "Stop the process, document the situation, and call the sending custodian to reissue the check made payable to the receiving custodian for benefit of the client — converting it to a direct rollover",
          "Have the client cash the check and wire the funds",
          "Wait 30 days to see if the situation resolves"
        ],
        "correct": 1,
        "explanation": "A check payable to the client is an indirect rollover — triggers mandatory 20% federal withholding and a 60-day deposit clock. Reissue properly to avoid both. Time matters; the 60-day clock starts when the client receives the check."
      },
      {
        "id": "q18",
        "competency": "OJL-9",
        "competency_name": "Ongoing Reviews & Life Events",
        "prompt": "During an annual review, a client mentions casually that their adult daughter is going through a divorce. The right response is to:",
        "options": [
          "Note it but defer until the next scheduled annual review",
          "Acknowledge it and ask one open question about whether the parents are providing any financial support — adult children's life events can have material planning implications even when indirect",
          "Push to revise the entire estate plan that day",
          "Refer them to a family law attorney"
        ],
        "correct": 1,
        "explanation": "Indirect life events still touch the plan — financial support to adult children, estate plan beneficiary considerations, potential capacity to help. Surface it gently and explore what matters for planning."
      },
      {
        "id": "q19",
        "competency": "OJL-10",
        "competency_name": "Portfolio Construction",
        "prompt": "A 35-year-old client with a 30+ year horizon, stable W-2 income, six months of emergency reserves, and moderate risk tolerance is most appropriately served by a portfolio that is:",
        "options": [
          "100% cash to preserve capital",
          "Diversified with a meaningful equity allocation appropriate to a long horizon, fixed-income exposure for stability and behavioral ballast, and global diversification — without concentration in any single position",
          "100% in employer stock to maximize growth potential",
          "Concentrated in a single high-conviction sector"
        ],
        "correct": 1,
        "explanation": "Portfolio construction follows from goals, horizon, capacity, and tolerance — not from chasing returns or avoiding all risk. Diversification across asset classes and regions, scaled to the client's actual situation, is the foundation."
      },
      {
        "id": "q20",
        "competency": "OJL-11",
        "competency_name": "Investment Research & Due Diligence",
        "prompt": "When evaluating a new fund for inclusion in a client portfolio, the most important factors to assess are:",
        "options": [
          "Trailing 1-year performance and recent star ratings",
          "Investment process, fees and expense ratio, manager tenure, fit with the existing portfolio's role for that allocation slot, risk-adjusted long-term track record, and tax efficiency",
          "Marketing materials and brand recognition",
          "Whatever the sales representative recommends"
        ],
        "correct": 1,
        "explanation": "Recent performance is the weakest predictor of future performance. Fees, process, tenure, fit, and risk-adjusted long-term results are stronger signals. Due diligence is structured, repeatable analysis — not pattern-matching to recent winners."
      },
      {
        "id": "q21",
        "competency": "OJL-12",
        "competency_name": "Asset Allocation & Rebalancing",
        "prompt": "A portfolio designed as 70% equity / 30% fixed income has drifted to 78/22 after a strong equity year. The disciplined response is to:",
        "options": [
          "Let it ride — the equities are working",
          "Rebalance toward target, trimming equities and adding to fixed income — restoring the risk profile the client signed for and locking in some gains",
          "Sell all equities to cash",
          "Buy more equities to extend the trend"
        ],
        "correct": 1,
        "explanation": "Rebalancing enforces the discipline of buying low and selling high — and more importantly, holds the portfolio to the risk profile the client agreed to. Drift is a risk signal, not a feature."
      },
      {
        "id": "q22",
        "competency": "OJL-13",
        "competency_name": "Performance Reporting",
        "prompt": "A client portfolio returned 12% in a year the S&P 500 returned 18%. The right framing for the client is:",
        "options": [
          "Acknowledge underperformance and consider manager changes",
          "Compare the return to the appropriate blended benchmark for the client's actual allocation, not a 100% equity index — a 70/30 benchmark may have returned approximately 12%",
          "Recommend shifting to a 100% S&P 500 portfolio",
          "Avoid the topic"
        ],
        "correct": 1,
        "explanation": "Performance reporting without correct benchmarking misleads. A diversified portfolio should be compared to a diversified benchmark. Comparing a 70/30 portfolio to the S&P 500 invites bad decisions in both directions across cycles."
      },
      {
        "id": "q23",
        "competency": "OJL-14",
        "competency_name": "Trading & Execution",
        "prompt": "For a large equity trade in a thinly-traded stock, best execution practice is to:",
        "options": [
          "Submit as a single market order for immediate fill",
          "Use limit orders and/or work the order over time to manage market impact, prioritizing execution quality (price, total cost) over speed alone",
          "Wait until the closing auction regardless of conditions",
          "Always use stop orders"
        ],
        "correct": 1,
        "explanation": "Best execution considers price, total cost, speed, likelihood of execution, and market impact. For thinly-traded names, market orders can move the price against the client. Limit orders and time-weighted execution protect the client's outcome."
      },
      {
        "id": "q24",
        "competency": "OJL-15",
        "competency_name": "Tax-Loss Harvesting",
        "prompt": "A client harvests a $5,000 loss by selling a fund. To preserve the loss for tax purposes, they must avoid repurchasing 'substantially identical' securities for:",
        "options": [
          "The same trading day",
          "30 calendar days before or after the sale (a 61-day window total) — the wash-sale rule",
          "The remainder of the tax year",
          "Six months from the sale date"
        ],
        "correct": 1,
        "explanation": "The wash-sale rule disallows the loss if substantially identical securities are purchased within 30 days before or after the sale. The window extends across the sale date — both directions matter. Violations defer rather than eliminate the loss but complicate basis tracking."
      },
      {
        "id": "q25",
        "competency": "OJL-16",
        "competency_name": "Account Administration & Custody",
        "prompt": "At a qualified custodian like Schwab or Fidelity serving an RIA, client assets are held:",
        "options": [
          "On the advisor firm's balance sheet, commingled with firm assets",
          "In the client's name at the qualified custodian, segregated from advisor firm assets, with the advisor having limited authority per the advisory agreement",
          "In a single pooled account with other clients",
          "Anywhere the advisor chooses to hold them"
        ],
        "correct": 1,
        "explanation": "Qualified custody is a regulatory protection — client assets stay in the client's name at an independent custodian. The advisor has agreed-upon authority (trade, fee deduction) but does not hold the assets. This is foundational to client protection in the RIA model."
      },
      {
        "id": "q26",
        "competency": "OJL-17",
        "competency_name": "Reconciliation & Operations Controls",
        "prompt": "Daily reconciliation between the firm's internal records and the custodian's records exists primarily to:",
        "options": [
          "Satisfy regulators with paperwork",
          "Catch errors, fraud, and discrepancies early — when they are still small and recoverable — through systematic comparison rather than accidental discovery later",
          "Generate billable activity",
          "Replace external audits"
        ],
        "correct": 1,
        "explanation": "Reconciliation is the operational discipline that catches problems before they become catastrophes. The cost of daily reconciliation is small. The cost of discovering a six-month-old error or a quiet fraud through an unrelated audit is enormous."
      },
      {
        "id": "q27",
        "competency": "OJL-18",
        "competency_name": "Compliance Workflows",
        "prompt": "A compliance review surfaces a recommendation that was substantively suitable for the client but had no documented rationale in the client file. The compliance issue is:",
        "options": [
          "None — the recommendation was suitable",
          "The missing documentation — a suitable recommendation without documented rationale is, for regulatory and audit purposes, indistinguishable from an unsuitable one",
          "The recommendation itself, which should be reversed",
          "Both — and the matter should be escalated to FINRA immediately"
        ],
        "correct": 1,
        "explanation": "Compliance lives in the documentation. A regulator reviewing the file three years later cannot reconstruct your reasoning if it was never written down. 'It was suitable' is not a defensible claim without contemporaneous evidence of why."
      },
      {
        "id": "q28",
        "competency": "OJL-19",
        "competency_name": "Cybersecurity & Data Protection",
        "prompt": "An apprentice receives an urgent wire transfer request via email from a long-standing client on a Friday afternoon. The non-negotiable next action is to:",
        "options": [
          "Process the wire to meet the Friday cutoff",
          "Voice-verify the request by calling the client at the phone number already in the CRM — not at any number provided in the email — before any wire is processed",
          "Reply to the email confirming receipt and process",
          "Have a second team member verify via email and then process"
        ],
        "correct": 1,
        "explanation": "Wire fraud is the highest-loss event most advisor firms face. Voice verification at a known number is the entire defense. Friday-afternoon urgency is itself a signal often engineered by attackers to delay weekend discovery. Verify every time, no exceptions."
      },
      {
        "id": "q29",
        "competency": "OJL-20",
        "competency_name": "Practice Management & Business Development",
        "prompt": "The most important growth lever for most advisory firms is:",
        "options": [
          "Aggressive marketing spend on digital lead generation",
          "Client retention over decades — most firms with a perceived growth problem actually have a quiet retention problem disguised as a marketing problem",
          "Hiring more advisors as quickly as possible",
          "Lowering fees to undercut competitors"
        ],
        "correct": 1,
        "explanation": "A retained client compounds in value over a 20-year relationship. A new client added to replace a lost one resets the clock. Firms that retain well grow almost without trying. Firms that lose quietly cannot out-market the leak."
      },
      {
        "id": "q30",
        "competency": "OJL-21",
        "competency_name": "Capstone — Building a Practice",
        "prompt": "Completing this apprenticeship is most accurately understood as:",
        "options": [
          "A finished credential that completes the counselor's development",
          "The foundation of a craft — the apprenticeship gives the shape of the work; the next decade of repeated practice with real clients gives the substance",
          "Sufficient preparation for partnership-level responsibilities immediately",
          "A regulatory checkbox unrelated to actual practice"
        ],
        "correct": 1,
        "explanation": "An apprenticeship graduate who treats the credential as the destination is not yet what the credential represents. An apprenticeship graduate who treats it as the starting line of a thirty-year practice is. The thirty competencies are foundations — mastery comes through years of repetition with real clients."
      }
    ]
  }
  $jsonb$::jsonb
)
on conflict (exam_code) do update set
  title = excluded.title,
  description = excluded.description,
  passing_score = excluded.passing_score,
  content = excluded.content,
  updated_at = now();

-- ----------------------------------------------------------------------------
-- 4. Verification query (run manually to confirm)
-- ----------------------------------------------------------------------------
-- select exam_code, title, passing_score,
--   jsonb_array_length(content -> 'questions') as question_count
-- from public.final_exams
-- where exam_code = 'FINAL-COMPREHENSIVE';
