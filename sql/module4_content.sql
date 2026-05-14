-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 4 CONTENT
-- Risk Management & Insurance
-- ============================================================================

update public.modules set
  title = 'Risk Management & Insurance',
  competency_id = 'CORE-4',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How a household identifies the risks that can destroy a plan, and how insurance transfers those risks at the right price and structure.',
  learning_objectives = ARRAY[
    'Articulate the four risk-handling strategies and when each applies.',
    'Right-size life, disability, health, and property-casualty coverage for a typical household.',
    'Distinguish term and permanent life insurance and explain when each fits.',
    'Read a policy declarations page and identify the levers — limits, deductibles, exclusions, riders.',
    'Identify catastrophic exposures that require umbrella coverage.',
    'Explain the role of insurance inside a financial plan to a client without selling product.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Risk and How to Handle It",
      "summary": "The four strategies every plan uses, and when each one fits.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A financial plan is fragile if any single bad event — a death, a disability, a fire, a lawsuit — can break it. Risk management is how the plan is built to survive the events you can't predict and can't prevent." },
        { "type": "paragraph", "text": "There are four ways to handle a risk, and every recommendation an advisor makes is one of them. Naming them explicitly is the first move." },

        { "type": "callout", "kind": "key", "title": "The four strategies", "text": "<strong>Avoid</strong> · <strong>Reduce</strong> · <strong>Retain</strong> · <strong>Transfer</strong>" },

        { "type": "subheading", "text": "Avoid" },
        { "type": "paragraph", "text": "Don't engage in the activity that creates the risk. Don't own the boat, don't keep the dog known to bite, don't take the second mortgage to invest in a single stock. Avoidance is often the cheapest strategy, when it's available." },

        { "type": "subheading", "text": "Reduce" },
        { "type": "paragraph", "text": "Engage in the activity but lower the probability or severity. Install smoke detectors. Lock the gun safe. Wear a seatbelt. Get the roof replaced before it leaks. Reduction is where loss-control measures live and where many premium discounts come from." },

        { "type": "subheading", "text": "Retain" },
        { "type": "paragraph", "text": "Accept the risk and pay any losses out of pocket. Appropriate for risks that are <strong>frequent but small</strong> — a $200 fender-bender, a $50 broken phone. Retention is essentially self-insurance. Higher deductibles formalize a decision to retain more risk in exchange for lower premiums." },

        { "type": "subheading", "text": "Transfer" },
        { "type": "paragraph", "text": "Pay someone else to bear the risk — typically an insurance company. Appropriate for risks that are <strong>low-frequency but high-severity</strong> — a house fire, a major surgery, a wrongful-death lawsuit, premature death of the breadwinner. Transfer is what people usually mean when they say \"insurance.\"" },

        { "type": "callout", "kind": "key", "title": "The grid that organizes everything", "text": "<strong>High severity + low frequency</strong> → transfer (insurance).<br/><strong>Low severity + high frequency</strong> → retain (self-insure with cash and high deductibles).<br/><strong>High severity + high frequency</strong> → avoid (the activity is too dangerous to manage).<br/><strong>Low severity + low frequency</strong> → retain (ignore; not worth managing)." },

        { "type": "divider" },

        { "type": "heading", "text": "What insurance actually is" },
        { "type": "paragraph", "text": "Insurance is the pooled-risk arrangement that lets a household pay a small, certain amount (premium) to avoid the possibility of a large, uncertain loss. It is not an investment. It is not a savings vehicle. It is a risk-transfer mechanism, priced by the insurer to be profitable on average across many policyholders." },
        { "type": "callout", "kind": "warn", "title": "What insurance is not", "text": "Insurance is not free money. Every dollar of premium is a dollar the client does not have. Buying coverage for risks they could comfortably absorb out of pocket means paying the insurer's overhead and profit margin on something they could self-handle. The advisor's job is to direct insurance dollars at the risks that <em>actually</em> require transfer — and stop them being spent on the rest." },

        { "type": "heading", "text": "The first risk-management questions to ask a client" },
        { "type": "list", "items": [
          "Who depends financially on this client, and for how long?",
          "If the client could not work tomorrow, how long could the household sustain itself?",
          "What assets — house, car, retirement savings — would be exposed in a major lawsuit?",
          "What policies are currently in force, and is anyone tracking renewals and coverage adequacy?",
          "Has there been a significant life event (marriage, birth, divorce, business start) since the policies were last reviewed?"
        ]},
        { "type": "callout", "kind": "do", "title": "The annual review reflex", "text": "Coverage that fit a household five years ago may not fit it now. New child, paid-off mortgage, business sold, kid moved out — each one shifts the insurance picture. Build an annual coverage review into the engagement cadence and you'll catch the gaps before they become disasters." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Life Insurance",
      "summary": "Term, permanent, and the question that decides which fits.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Life insurance pays a death benefit to the beneficiaries when the insured dies. It exists for one structural reason: there are people who depend financially on the insured, and they would be in trouble if the income disappeared." },

        { "type": "callout", "kind": "key", "title": "The question that decides everything", "text": "<strong>If this client died tonight, who would be financially worse off?</strong> If the answer is no one — single, no dependents, savings adequate to cover final expenses — they likely don't need life insurance. If the answer is a spouse, children, business partner, or anyone counting on the income, that's the dependency the policy exists to address." },

        { "type": "heading", "text": "Term life insurance" },
        { "type": "paragraph", "text": "Pays a death benefit if the insured dies during a specified term — commonly 10, 20, or 30 years. Premiums are level for the duration; at the end of the term, coverage ends (or renews at much higher rates)." },
        { "type": "list", "items": [
          "<strong>Low premium relative to death benefit.</strong> A healthy 35-year-old can often buy $1 million of 20-year term for under $50/month.",
          "<strong>Pure risk transfer.</strong> No cash value, no investment component. Premium pays for insurance and nothing else.",
          "<strong>Designed to cover a finite need.</strong> Most clients need insurance during working years to protect dependents; once kids are grown and assets are built, the need disappears.",
          "<strong>The default recommendation for most households.</strong> Term covers the actual risk at the lowest cost."
        ]},

        { "type": "heading", "text": "Permanent life insurance" },
        { "type": "paragraph", "text": "Coverage that lasts a lifetime, combined with a savings/investment component. Several flavors:" },
        { "type": "glossary", "terms": [
          { "term": "Whole life", "definition": "Fixed premium, fixed death benefit, cash value grows at a guaranteed rate. The most traditional permanent product." },
          { "term": "Universal life (UL)", "definition": "Flexible premiums, flexible death benefit, cash value grows at a declared rate. More customizable, more complex." },
          { "term": "Variable universal life (VUL)", "definition": "Like UL but cash value is invested in market subaccounts. Returns are not guaranteed; account can lose value." },
          { "term": "Indexed universal life (IUL)", "definition": "Cash value linked to an equity index with floors and caps. Marketed as offering upside without downside; in practice, caps and fees often limit upside meaningfully." }
        ]},
        { "type": "callout", "kind": "warn", "title": "Where permanent insurance gets oversold", "text": "Permanent life is frequently sold to clients who would be better served by term plus a separate investment. The combined product is often more expensive than the sum of the parts, returns on the cash value are typically modest, and the structure is opaque. \"Buy term and invest the difference\" is a defensible default. Permanent has legitimate uses — estate liquidity for large estates, business succession funding, certain wealth-transfer strategies — but for a typical household, it's the wrong tool." },

        { "type": "heading", "text": "Sizing the death benefit" },
        { "type": "paragraph", "text": "How much coverage is enough? Two methods are common:" },

        { "type": "subheading", "text": "Method 1 — Income replacement" },
        { "type": "paragraph", "text": "Multiply gross annual income by 10–15. A client earning $100,000 might carry $1,000,000–$1,500,000 of coverage. Simple, conservative, easy to explain. Good starting point for most." },

        { "type": "subheading", "text": "Method 2 — Needs analysis (DIME or capital needs)" },
        { "type": "paragraph", "text": "Build coverage from specific obligations:" },
        { "type": "list", "items": [
          "<strong>D</strong>ebts — pay off mortgage, auto loans, credit cards.",
          "<strong>I</strong>ncome — replace the insured's income for the years dependents need it.",
          "<strong>M</strong>ortgage — sometimes called out separately for clarity.",
          "<strong>E</strong>ducation — anticipated college costs for children.",
          "Plus a final-expense reserve and a buffer for inflation."
        ]},
        { "type": "paragraph", "text": "Needs analysis is more precise but more work. For most households, either method produces an answer in the same ballpark. Use the one that produces a number the client will actually agree to and act on." },

        { "type": "case_study",
          "title": "Sizing for Marcus and Tasha",
          "scenario": "Marcus and Tasha (couple from earlier modules), early 40s, two kids ages 10 and 13. Combined gross income $148,000, mortgage $310,000, savings $80,000, retirement $250,000. Currently no individual life insurance beyond modest group policies through employers.",
          "discussion": "<p>Both spouses contribute income, so both need coverage. Sizing each:</p><ul><li>Mortgage payoff: $310,000</li><li>Income replacement (10× each): $740,000 Marcus, $740,000 Tasha (assume equal earnings for simplicity)</li><li>College for two kids: ~$300,000 in today's dollars at private rates, less for state schools</li><li>Final expenses + buffer: $50,000</li></ul><p><strong>Recommendation:</strong> $1,500,000 of 20-year term on each. Twenty years covers the period when kids are dependents and mortgage is paid down. Combined premium for two healthy 40-year-olds: roughly $100–$150/month total. The cost is small; the protection is enormous. Note the group policies stay — they're cheap supplemental coverage — but they're not a substitute for individual policies because they end when employment ends.</p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Disability and Health Insurance",
      "summary": "The two coverages most clients underestimate, despite both being more likely to pay out than life insurance.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A healthy 35-year-old is much more likely to experience a disabling injury or illness during their working life than to die before age 65. And medical events are the leading cause of personal bankruptcy in the United States. Both disability and health coverage are non-negotiable for almost every household." },

        { "type": "heading", "text": "Disability insurance" },
        { "type": "paragraph", "text": "Replaces a portion of income when the insured cannot work due to injury or illness. Two main categories:" },
        { "type": "list", "items": [
          "<strong>Short-term disability (STD)</strong> — covers 3–6 months. Often employer-provided.",
          "<strong>Long-term disability (LTD)</strong> — covers from end of STD until retirement age or recovery. The structurally important coverage."
        ]},

        { "type": "subheading", "text": "The variables that matter" },
        { "type": "glossary", "terms": [
          { "term": "Benefit amount", "definition": "Typically 60–70% of pre-disability income. Tax treatment depends on who paid the premium — employer-paid benefits are usually taxable; individual-paid benefits are usually not." },
          { "term": "Elimination period", "definition": "The waiting period before benefits start. Common: 60, 90, 180 days. Longer waits mean lower premiums but require a larger emergency fund to bridge." },
          { "term": "Benefit period", "definition": "How long benefits pay. \"To age 65\" or \"to age 67\" is the standard for serious LTD." },
          { "term": "Definition of disability", "definition": "How the policy defines unable to work. Two main types — <strong>own occupation</strong> (can't perform the duties of your specific job) vs. <strong>any occupation</strong> (can't perform any job for which you're qualified). Own-occ is more generous and more expensive; critical for high-skill professionals." }
        ]},

        { "type": "callout", "kind": "key", "title": "What good LTD looks like", "text": "60–70% benefit, 90-day elimination period, to-age-65 benefit period, own-occupation definition at least for the first 2–5 years. For high earners or specialty professionals (physicians, lawyers, surgeons), <em>true own-occupation to age 65</em> is the standard worth paying for." },

        { "type": "callout", "kind": "warn", "title": "Group LTD is not enough on its own", "text": "Many clients have group LTD through work — usually 60% of base salary, often capped (e.g., max $10,000/month), benefits taxable, ends if employment ends, definition often shifts to \"any occupation\" after 2 years. For a client whose income is below the cap and whose career is portable, group might be sufficient. For a high earner, a specialty professional, or anyone whose income is largely bonus/commission, supplemental individual coverage usually fills a real gap." },

        { "type": "divider" },

        { "type": "heading", "text": "Health insurance" },
        { "type": "paragraph", "text": "Pays a portion of medical costs in exchange for premium. The category most clients deal with monthly. The advisor's role isn't to pick plans — most clients buy through employer or marketplace — but to make sure the client is using the coverage well and protected against worst cases." },

        { "type": "subheading", "text": "Reading a plan" },
        { "type": "glossary", "terms": [
          { "term": "Premium", "definition": "Monthly cost to maintain the plan." },
          { "term": "Deductible", "definition": "Out-of-pocket spending required before insurance starts paying (other than for covered preventive care)." },
          { "term": "Copay", "definition": "Fixed dollar amount paid per visit or prescription, regardless of total cost." },
          { "term": "Coinsurance", "definition": "Percentage of cost shared between insurer and patient after the deductible (e.g., 80/20 — insurer pays 80%, patient pays 20%)." },
          { "term": "Out-of-pocket maximum", "definition": "The annual cap on patient spending. Once hit, insurance pays 100% of covered costs for the rest of the year. <strong>The most important number on the policy.</strong>" },
          { "term": "Network", "definition": "Providers who have negotiated rates with the insurer. Out-of-network care often costs dramatically more, sometimes with no coverage at all." }
        ]},

        { "type": "callout", "kind": "do", "title": "The high-deductible + HSA combination", "text": "For a healthy household with cash flow flexibility, a high-deductible health plan (HDHP) paired with a Health Savings Account (HSA) can be the most tax-efficient health coverage available. HSAs offer triple tax advantage — contributions are deductible, growth is tax-free, withdrawals for medical are tax-free. After age 65, HSA can be used for any purpose with only income tax owed. It is, structurally, one of the best retirement accounts that exists. Cover this in detail with anyone enrolled in an HDHP and not maximizing the HSA." },

        { "type": "callout", "kind": "warn", "title": "When the HDHP is wrong", "text": "Clients with predictable high medical use (chronic conditions, planned pregnancy, medications) often pay more in the HDHP despite the lower premium. Always run the math against the client's expected utilization, not just the headline premium difference." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Property, Casualty, and Liability",
      "summary": "Protecting the assets the client has built — and the lawsuits that can take them away.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Once a household has assets — a house, savings, retirement accounts — those assets become exposures. A car accident, a guest injured at the home, a teenage driver in a fender-bender that escalates: any of these can produce a lawsuit large enough to threaten years of wealth-building. Property, casualty, and liability coverage exist to absorb that exposure." },

        { "type": "heading", "text": "Homeowners insurance (HO-3 standard)" },
        { "type": "paragraph", "text": "Standard policy structure for an owner-occupied single-family home:" },
        { "type": "list", "items": [
          "<strong>Coverage A — Dwelling</strong>: rebuilding the structure. Should be set at <em>replacement cost</em>, not market value. (A $700,000 market-value home may cost $500,000 to rebuild — or vice versa.) Many policies require coverage at 80% of replacement cost or better to avoid penalty at claim time.",
          "<strong>Coverage B — Other structures</strong>: detached garages, sheds, fences. Typically 10% of A.",
          "<strong>Coverage C — Personal property</strong>: contents inside the home. Typically 50–75% of A. Coverage is usually actual cash value (depreciated) unless replacement-cost endorsement is purchased.",
          "<strong>Coverage D — Loss of use</strong>: hotel and meal costs while the home is uninhabitable. Typically 20% of A.",
          "<strong>Coverage E — Personal liability</strong>: legal defense and judgment for incidents at the property. Often only $100K–$300K by default — usually inadequate.",
          "<strong>Coverage F — Medical payments to others</strong>: small no-fault coverage for guest injuries, typically $1K–$5K."
        ]},
        { "type": "callout", "kind": "warn", "title": "What standard policies don't cover", "text": "Floods, earthquakes, sewer backups (usually), mold (often limited), business activity in the home. These require either riders or separate policies. Flood insurance in particular: standard homeowners <strong>excludes flood</strong>, and FEMA flood maps determine eligibility for the National Flood Insurance Program. Check this on every new client review." },

        { "type": "heading", "text": "Auto insurance" },
        { "type": "paragraph", "text": "Required by law in most states. Standard parts:" },
        { "type": "list", "items": [
          "<strong>Bodily injury liability</strong>: pays for injuries to others when the insured is at fault. State minimums are usually inadequate. A common recommendation is 250/500 ($250K per person, $500K per accident) or higher.",
          "<strong>Property damage liability</strong>: pays for damage to others' property. $100K minimum is reasonable.",
          "<strong>Collision</strong>: pays for damage to the insured's vehicle in an accident. Optional but standard if the vehicle is financed.",
          "<strong>Comprehensive</strong>: pays for non-collision damage (theft, vandalism, falling objects, animal strikes). Optional but standard if the vehicle is financed.",
          "<strong>Uninsured/underinsured motorist (UM/UIM)</strong>: pays when the at-fault driver has insufficient or no insurance. <strong>Critical and frequently underbought.</strong> Match it to liability limits.",
          "<strong>Personal injury protection (PIP) / medical payments</strong>: no-fault medical coverage. Required in some states, optional in others."
        ]},

        { "type": "heading", "text": "Umbrella liability" },
        { "type": "paragraph", "text": "Sits on top of homeowners and auto liability, extending coverage by $1 million or more. Triggers when the underlying policy's liability limit is exhausted. Astonishingly cheap relative to the protection — often $200–$500/year for $1 million of additional coverage." },
        { "type": "callout", "kind": "key", "title": "Who should have umbrella", "text": "Any household with assets meaningfully above the underlying liability limits. As a rough rule, if the client has more than $300K of net worth, umbrella is a conversation. If they have more than $1M, it's a recommendation. If they have rental properties, pools, teen drivers, dogs, or any high-visibility profession, the threshold drops further. The cost is small; the protection is structural." },

        { "type": "case_study",
          "title": "The fender-bender that wasn't",
          "scenario": "A teen driver rear-ends another vehicle at 30 mph. The other driver has soft-tissue neck injuries that turn into a chronic condition with surgery. Medical costs plus lost wages plus pain-and-suffering judgment: $1.2 million. The family had auto liability of $250K and no umbrella.",
          "discussion": "<p>The auto policy pays its $250K. The remaining $950,000 is the family's exposure — coming first from any non-retirement savings, then potentially from wage garnishment for years. Retirement accounts and the primary home are usually protected by state law from creditors, but not always, and the protection varies by state.</p><p>For about $300/year, that family could have had a $1M umbrella that covered the entire judgment. The umbrella conversation isn't about fear-mongering; it's about explaining that a routine accident can produce a non-routine outcome, and the cost of the protection is small. Every client review should include the question: <em>is umbrella coverage in place, and is it the right size?</em></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Reading a Policy and the Annual Review",
      "summary": "The five things to look at on every declarations page, and how to spot what's missing.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Insurance products are dense, full of exclusions, and easy to misread. A Wealth Solutions Counselor doesn't need to sell insurance, but does need to read policies competently enough to spot gaps, mismatches, and oversold coverage. The skill is mechanical and learnable." },

        { "type": "heading", "text": "The declarations page" },
        { "type": "paragraph", "text": "The first page of every policy summarizes the contract. Always start here. Look for:" },
        { "type": "numbered", "items": [
          "<strong>Named insured(s).</strong> Does the policy cover the right people? Spouse listed? Adult children at college covered?",
          "<strong>Policy period.</strong> Is the policy current? When does it renew?",
          "<strong>Coverage limits.</strong> Each one. Match against the asset or exposure it's meant to protect.",
          "<strong>Deductibles.</strong> Per-occurrence, per-event, separate wind/hail or named-storm deductibles in coastal areas.",
          "<strong>Premium.</strong> Annual total, and what's being paid for which coverage."
        ]},

        { "type": "heading", "text": "Beyond the declarations page" },
        { "type": "list", "items": [
          "<strong>Endorsements and riders.</strong> Listed separately. Often where the most important customizations live — jewelry floaters, business activity riders, water/sewer backup riders, scheduled property.",
          "<strong>Exclusions.</strong> What the policy does NOT cover. The most-cited at claim time are flood, earthquake, intentional acts, business pursuits, motor vehicles, and certain dog breeds.",
          "<strong>Replacement cost vs. actual cash value.</strong> ACV depreciates; RC pays to replace. The same loss can produce wildly different settlements depending on which applies."
        ]},

        { "type": "callout", "kind": "do", "title": "The five-minute spot-check", "text": "On any homeowners policy: <strong>(1)</strong> Is dwelling coverage at replacement cost? <strong>(2)</strong> Is personal liability at least $300K? <strong>(3)</strong> Are flood and earthquake addressed (covered or consciously declined)? <strong>(4)</strong> Are any unusual exposures listed and covered (pool, trampoline, business in home)? <strong>(5)</strong> Is replacement cost on contents elected? These five questions catch most coverage gaps in five minutes." },

        { "type": "divider" },

        { "type": "heading", "text": "The annual insurance review" },
        { "type": "paragraph", "text": "Schedule once a year, ideally during the policy-renewal season for each major coverage. Walk through:" },
        { "type": "list", "items": [
          "Did anything change in the client's life this year? (New job, new home, new car, new child, marriage, divorce, business start.)",
          "Are premiums in line with peer benchmarks?",
          "Are deductibles set appropriately for the client's emergency fund? (Higher deductible = lower premium, but the client needs the cash to absorb it.)",
          "Are limits keeping pace with replacement costs and inflation? (Especially dwelling coverage — construction costs have risen significantly in recent years.)",
          "Are bundled discounts captured? (Same-carrier auto + home is often cheaper than two carriers.)"
        ]},

        { "type": "callout", "kind": "key", "title": "The independent agent vs. captive question", "text": "Captive agents (State Farm, Allstate, Farmers) sell one carrier. Independent agents work across many. For most clients, an independent agent who shops the market every few years produces materially better outcomes — both on price and on coverage breadth. This is one of the most concrete, immediately useful recommendations an advisor can make to a household that's been with the same carrier for two decades." },

        { "type": "activity", "title": "Audit your own coverage", "prompt": "Same instruction as previous modules: do this for yourself before you do it for a client.", "steps": [
          "Pull declarations pages for every active policy: auto, home/renters, umbrella (if any), life, disability, health.",
          "For each, run the five-minute spot-check from this lesson.",
          "Identify gaps and overlaps. Where might you be under-insured? Where might you be paying for coverage you don't actually need?",
          "Note premium dollars per category — which coverage is consuming the most of your insurance budget?",
          "Save the document. Repeat annually. The discipline that makes you a good advisor on this is the same discipline you'll teach clients."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which of the following risks should typically be TRANSFERRED via insurance rather than retained?",
        "options": [
          "A $300 cracked phone screen",
          "A $100,000 medical event",
          "A $50 parking ticket",
          "Routine vehicle maintenance costs"
        ],
        "correct": 1,
        "explanation": "Insurance is for low-frequency, high-severity risks. A major medical event qualifies. The phone, ticket, and maintenance are low-severity and should be retained (paid out of cash flow or emergency fund)."
      },
      {
        "id": "q2",
        "prompt": "A healthy 35-year-old client with a spouse and two young children, earning $90,000/year with a $250,000 mortgage, has no individual life insurance. What is the most defensible recommendation?",
        "options": [
          "Permanent (whole life) policy, $500K death benefit.",
          "Term policy, 20-year, $750K–$1M death benefit.",
          "No insurance — life insurance is overrated.",
          "Variable universal life, $1M death benefit."
        ],
        "correct": 1,
        "explanation": "Term insurance for the working/dependent years is the default for most households. Income replacement of 10–15× plus mortgage payoff suggests roughly $750K–$1.5M. A 20-year term covers until kids are independent and mortgage is significantly paid down. Premium is small."
      },
      {
        "id": "q3",
        "prompt": "What does 'own occupation' mean in a disability insurance policy?",
        "options": [
          "The insured can choose any occupation after disability.",
          "Disability is defined as inability to perform the duties of the insured's specific occupation, even if the insured could work in a different field.",
          "The policy only pays if the disability happened on the job.",
          "Premiums are tax-deductible because of self-employment."
        ],
        "correct": 1,
        "explanation": "Own-occupation is the more generous definition: a surgeon who can no longer operate but could teach is still disabled under own-occ. Any-occupation requires inability to do any job for which the insured is qualified. Own-occ is critical for high-skill professionals."
      },
      {
        "id": "q4",
        "prompt": "Which of the following is the most important number on a health insurance policy?",
        "options": [
          "Premium",
          "Deductible",
          "Out-of-pocket maximum",
          "Copay"
        ],
        "correct": 2,
        "explanation": "The out-of-pocket maximum is the cap on what the client can spend in a year. Once hit, insurance pays 100%. It's the number that defines worst-case exposure — more important than the premium, deductible, or copay in isolation."
      },
      {
        "id": "q5",
        "prompt": "Which of the following is NOT typically covered by a standard homeowners (HO-3) policy?",
        "options": [
          "Fire damage to the dwelling",
          "Theft of personal property",
          "Flood damage from a storm surge",
          "A guest's medical bills after slipping on the deck"
        ],
        "correct": 2,
        "explanation": "Flood is excluded from standard homeowners policies and requires either NFIP coverage or a private flood policy. Always confirm flood exposure and whether the client is covered."
      },
      {
        "id": "q6",
        "prompt": "A household has $500K of net worth, including a home worth $400K and savings of $100K. Auto liability limits are $100K/$300K. They have no umbrella policy. What is the structurally important exposure?",
        "options": [
          "Their auto insurance deductible is too low.",
          "Their savings yield is too low.",
          "Their auto liability limit is well below their net worth, and a serious accident could expose savings (and potentially the home) to a judgment beyond policy limits.",
          "Their home is uninsured."
        ],
        "correct": 2,
        "explanation": "Auto liability of $100K/$300K is well below their $500K net worth. A serious accident judgment could exhaust the liability limit and reach their other assets. An umbrella policy (typically $200–$500/year for $1M of coverage) closes this gap structurally and inexpensively."
      },
      {
        "id": "q7",
        "prompt": "What is the triple tax advantage of a Health Savings Account (HSA)?",
        "options": [
          "Tax-deductible contributions, tax-deferred growth, taxable withdrawals.",
          "Tax-deductible contributions, tax-free growth, tax-free withdrawals for qualified medical expenses.",
          "Tax-free contributions, taxable growth, tax-free withdrawals.",
          "All three taxes are deferred until age 59½."
        ],
        "correct": 1,
        "explanation": "HSA contributions are pre-tax (deductible), growth is tax-free, and withdrawals for qualified medical expenses are tax-free. After age 65, withdrawals for any purpose owe only income tax. It is structurally one of the best tax-advantaged accounts available."
      },
      {
        "id": "q8",
        "prompt": "Which of the following is the strongest reason to prefer term insurance over permanent insurance for a typical household?",
        "options": [
          "Term has guaranteed cash value.",
          "Term provides much lower premium for the same death benefit during the years the protection is actually needed; the insurance need typically disappears as wealth is built and dependents become independent.",
          "Permanent insurance is illegal in some states.",
          "Term builds wealth faster."
        ],
        "correct": 1,
        "explanation": "Term provides pure death-benefit protection at low cost during the working/dependent years. The insurance need typically disappears as the client builds assets and dependents grow up. Permanent insurance bundles in a savings component that is generally inferior to investing separately."
      },
      {
        "id": "q9",
        "prompt": "Which of the four risk-handling strategies applies to driving with a seatbelt and installing smoke detectors?",
        "options": [
          "Avoid",
          "Reduce",
          "Retain",
          "Transfer"
        ],
        "correct": 1,
        "explanation": "Reduction — engaging in the activity but lowering the probability or severity of loss. Loss-control measures live here and are often where insurance premium discounts come from."
      },
      {
        "id": "q10",
        "prompt": "A client says they have 'group long-term disability through work, so I'm covered.' What's the right follow-up?",
        "options": [
          "Confirm and move on.",
          "Ask about the benefit percentage, the income cap, whether the benefit is taxable, the definition of disability, and whether coverage portable if employment ends. Group LTD is often inadequate without supplement.",
          "Tell them to drop the group coverage to save money.",
          "Recommend they switch jobs to one with better LTD."
        ],
        "correct": 1,
        "explanation": "Group LTD frequently has caps that under-cover high earners, is often taxable (paid with pre-tax premiums), shifts definition to 'any occupation' after 2 years, and ends if employment ends. Confirming details — and supplementing with individual coverage when group is inadequate — is the advisor move."
      },
      {
        "id": "q11",
        "prompt": "When reviewing a homeowners policy, the dwelling coverage should be:",
        "options": [
          "Equal to the home's market value.",
          "Equal to the home's purchase price.",
          "Equal to the cost to rebuild the structure (replacement cost), which can differ significantly from market value.",
          "Equal to the outstanding mortgage balance."
        ],
        "correct": 2,
        "explanation": "Dwelling coverage protects against rebuild cost, not market value. Market value includes land (which usually survives most losses) and reflects supply/demand. Replacement cost reflects construction labor and materials. The two can differ by a lot — always verify."
      },
      {
        "id": "q12",
        "prompt": "Which is the best general description of when insurance is the wrong tool?",
        "options": [
          "When the client is young.",
          "When the risk is frequent and small enough that the household can absorb it from cash flow or emergency fund.",
          "When the client has not had a claim in the last five years.",
          "When the premium has not increased recently."
        ],
        "correct": 1,
        "explanation": "Insurance is for low-frequency, high-severity events that would meaningfully harm the household. Small, frequent losses should be retained — typically expressed as higher deductibles and absence of certain optional coverages. Buying insurance for risks the household could handle out of pocket means paying the insurer's overhead unnecessarily."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 4;

-- ============================================================================
-- DONE.
-- ============================================================================
