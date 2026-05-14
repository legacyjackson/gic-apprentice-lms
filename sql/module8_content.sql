-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 8 CONTENT
-- Estate Planning & Wealth Transfer
-- ============================================================================
update public.modules set
  title = 'Estate Planning & Wealth Transfer',
  competency_id = 'CORE-8',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How families move wealth across generations and across moments of crisis. Wills, trusts, powers of attorney, beneficiaries, and the documents that matter when something goes wrong.',
  learning_objectives = ARRAY[
    'Distinguish probate from non-probate assets and explain why this drives most estate planning.',
    'Identify the four core documents every adult should have, regardless of net worth.',
    'Distinguish revocable from irrevocable trusts and articulate when each is the right tool.',
    'Explain why beneficiary designations override wills and how to audit them.',
    'Articulate the basics of federal estate, gift, and generation-skipping taxes at current thresholds.',
    'Coordinate with an estate planning attorney effectively without practicing law.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Estate Planning Is Not Just for the Wealthy",
      "summary": "The four documents every adult needs, and what happens when they don't have them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Estate planning is one of the most over-postponed conversations in personal finance. Clients hear \"estate\" and think \"rich people problem\" — and so the documents that protect a family in a crisis go unwritten. A Wealth Solutions Counselor's job is to translate: this is not about taxes for most clients, it's about <em>what happens when something goes wrong</em>." },

        { "type": "callout", "kind": "key", "title": "The four core documents", "text": "<strong>(1) Will</strong>, <strong>(2) Durable power of attorney for finances</strong>, <strong>(3) Healthcare power of attorney / advance directive</strong>, <strong>(4) HIPAA authorization</strong>. Every adult — regardless of net worth — should have all four. Cost via an estate attorney: typically $500–$2,500 for a basic plan. Cost of not having them: incalculable when needed." },

        { "type": "heading", "text": "What happens without a will (intestacy)" },
        { "type": "paragraph", "text": "If a person dies without a will, state law decides who inherits. The state's default rules are called <strong>intestacy laws</strong>, and they rarely match what the deceased would have wanted." },
        { "type": "list", "items": [
          "Surviving spouse may share inheritance with parents or siblings of the deceased, depending on state and whether there are children.",
          "If there are children from prior relationships, the surviving spouse may share with stepchildren.",
          "Unmarried partners typically inherit nothing under intestacy.",
          "Minor children's inheritance is held by court-appointed conservators, often with high court costs.",
          "The state appoints a guardian for minor children — without input from the parents."
        ]},
        { "type": "callout", "kind": "warn", "title": "The argument that ends the conversation", "text": "\"If you die without a will, the state writes one for you — and they don't know your family.\" That sentence often opens the door for clients who've been avoiding the topic for years." },

        { "type": "heading", "text": "The four documents in plain language" },
        { "type": "subheading", "text": "Will" },
        { "type": "paragraph", "text": "Directs distribution of <em>probate</em> assets at death. Names an executor to settle the estate. Names guardians for minor children. Doesn't override beneficiary designations or jointly owned property — more on that in the next lesson." },

        { "type": "subheading", "text": "Durable power of attorney for finances" },
        { "type": "paragraph", "text": "Names someone (an \"agent\" or \"attorney-in-fact\") to manage finances if the principal becomes incapacitated. \"Durable\" means it survives incapacity (the entire point — a non-durable POA terminates when the principal can't make decisions). Critical for: paying bills, managing investments, dealing with the IRS, handling real estate, and a hundred other tasks the household needs done when someone is unable to do them." },

        { "type": "subheading", "text": "Healthcare power of attorney" },
        { "type": "paragraph", "text": "Names someone to make medical decisions when the principal can't. Often paired with an <strong>advance directive</strong> (also called a living will) that specifies preferences for end-of-life care, life support, organ donation. Without these documents, family members fight over medical decisions or hospitals follow defaults that may not match the patient's wishes." },

        { "type": "subheading", "text": "HIPAA authorization" },
        { "type": "paragraph", "text": "Federal medical privacy law (HIPAA) restricts who can receive a patient's health information. A HIPAA authorization tells providers it's OK to share the patient's medical information with named individuals — usually the agents under the healthcare POA. Without it, even spouses can be told \"I can't discuss the patient with you.\"" },

        { "type": "callout", "kind": "do", "title": "The minimum-viable estate plan", "text": "Will + durable POA + healthcare POA/advance directive + HIPAA authorization. These four documents take care of the structural risks for most clients. More sophisticated planning (trusts, advanced tax strategies) builds on top — but starts with the core four." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Probate, Beneficiaries, and How Assets Actually Transfer",
      "summary": "Why the beneficiary designation on a 401(k) overrides everything in the will.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "One of the most expensive misunderstandings in personal finance is the belief that a will controls everything. It doesn't. Knowing exactly what transfers <em>by</em> the will and what transfers <em>around</em> the will is the difference between an estate plan that works and one that explodes." },

        { "type": "heading", "text": "Probate vs. non-probate" },
        { "type": "glossary", "terms": [
          { "term": "Probate", "definition": "The court-supervised process of validating a will, paying debts and taxes, and distributing remaining assets. Public, can take 6 months to 2+ years, costs typically 3–7% of estate value." },
          { "term": "Probate assets", "definition": "Assets that pass through the will and through probate. Examples: individually-owned bank accounts without payable-on-death designations, individually-owned vehicles, real estate held solely in the decedent's name, personal property." },
          { "term": "Non-probate assets", "definition": "Assets that pass outside the will, by their own legal mechanism. They transfer faster, more privately, and sometimes more cheaply — but only if set up correctly." }
        ]},

        { "type": "heading", "text": "The four ways non-probate assets transfer" },
        { "type": "numbered", "items": [
          "<strong>Beneficiary designation</strong> — retirement accounts (401(k), IRA, Roth IRA), life insurance, annuities. Goes directly to the named beneficiary at death, bypassing the will entirely.",
          "<strong>Joint ownership with right of survivorship</strong> — bank accounts, real estate, vehicles. Surviving owner immediately becomes sole owner.",
          "<strong>Transfer-on-death (TOD) / Payable-on-death (POD) designation</strong> — many states allow these on brokerage accounts, bank accounts, even real estate. Functions like a beneficiary designation.",
          "<strong>Trust ownership</strong> — assets owned by a trust transfer according to the trust document, not by will. Major reason to use a revocable living trust."
        ]},

        { "type": "callout", "kind": "key", "title": "The rule that saves families", "text": "<strong>Beneficiary designations override wills.</strong> Always. If the will leaves everything to the second spouse but the 401(k) still names the first spouse as beneficiary, the 401(k) goes to the first spouse. This has destroyed countless second marriages' financial plans. Auditing beneficiary designations is one of the most important things an advisor can do annually." },

        { "type": "subheading", "text": "What to audit on beneficiary designations" },
        { "type": "list", "items": [
          "Every retirement account: 401(k), 403(b), IRA, Roth IRA, SEP, SIMPLE.",
          "Every life insurance policy — employer-provided AND individual.",
          "Annuities of every kind.",
          "HSAs.",
          "Brokerage accounts with TOD designations.",
          "Bank accounts with POD designations."
        ]},
        { "type": "subheading", "text": "What to check for each" },
        { "type": "list", "items": [
          "Is there a primary beneficiary?",
          "Is there a contingent beneficiary in case the primary dies first?",
          "Are the beneficiaries the right people for the current life situation? (Common errors: ex-spouses, deceased parents, minor children listed directly.)",
          "Are the percentages adding to 100%?",
          "Are spouses properly named (with full legal name, date of birth, and SSN if required)?"
        ]},

        { "type": "callout", "kind": "warn", "title": "The ex-spouse trap", "text": "After divorce, retirement accounts and life insurance still name the ex as beneficiary in a stunning percentage of cases. Some states have laws that automatically revoke ex-spouse designations on divorce, but those laws don't apply to federally-regulated plans (like 401(k)s) — federal law preempts. Result: ex-spouse legally inherits, regardless of what the will or divorce decree says. Every divorce should trigger a beneficiary audit." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The blended family disaster",
          "scenario": "Marcus (from prior modules, now imagining a remarriage scenario) divorced his first wife and remarried Tasha. He updated his will to leave everything to Tasha and his two children. He died unexpectedly. His will was clean. His 401(k) still named his first wife as primary beneficiary — he'd never updated it after the divorce.",
          "discussion": "<p>The $340,000 401(k) goes to the first wife. By law. There's no provision for the surviving family to challenge it successfully — the beneficiary designation is contractually binding on the plan administrator.</p><p>Tasha inherits the house (jointly titled), the cars, the bank accounts (which had her as a co-owner or POD beneficiary), and the rest of the will-controlled assets — but the largest single asset, the retirement account, is gone to someone he hadn't lived with in 12 years.</p><p>This story is not rare. The advisor who, in a routine annual review, asks \"can we pull up your beneficiary designations and confirm they're current?\" is doing structural risk management that quietly prevents these disasters. <strong>That is what this profession is for.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Trusts — Revocable and Irrevocable",
      "summary": "When a will is enough, and when a trust earns its keep.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Trusts are misunderstood in roughly equal measure as estate-planning savior and unnecessary complication. They are useful for specific purposes; for many clients with simple situations, they're overkill. A Wealth Solutions Counselor needs to know when to suggest a trust to the client and when to leave well enough alone." },

        { "type": "heading", "text": "What a trust actually is" },
        { "type": "paragraph", "text": "A trust is a legal arrangement where one party (the <strong>grantor</strong> or <strong>settlor</strong>) gives property to a <strong>trustee</strong> to hold and manage for the benefit of <strong>beneficiaries</strong>, according to terms spelled out in the trust document. The trust itself owns the property; the trustee operates under fiduciary duty." },

        { "type": "heading", "text": "Revocable living trust" },
        { "type": "paragraph", "text": "A revocable trust is one the grantor can change or terminate during their lifetime. Most commonly used for:" },
        { "type": "list", "items": [
          "<strong>Avoiding probate</strong> — assets owned by the trust pass per the trust document, not through court probate. In states with painful probate processes (California, Florida), this alone justifies the cost.",
          "<strong>Privacy</strong> — wills become public record in probate. Trust distributions don't.",
          "<strong>Incapacity planning</strong> — the successor trustee can step in if the grantor becomes incapacitated, without a court-appointed conservatorship.",
          "<strong>Multi-state property</strong> — owning real estate in multiple states normally triggers probate in each. Trust ownership avoids this.",
          "<strong>Blended family planning</strong> — can specify complex distributions across multiple sets of beneficiaries with more nuance than a will."
        ]},
        { "type": "callout", "kind": "note", "title": "What revocable trusts do NOT do", "text": "They do <em>not</em> save federal estate taxes (because the grantor still controls and owns the assets for tax purposes). They do <em>not</em> protect assets from the grantor's creditors during their lifetime. They are estate-administration tools, not tax-avoidance or asset-protection tools." },

        { "type": "heading", "text": "Irrevocable trusts" },
        { "type": "paragraph", "text": "An irrevocable trust, once created, generally cannot be changed by the grantor. The grantor has surrendered control over the assets. This makes irrevocable trusts powerful for specific planning purposes that revocable trusts can't accomplish:" },
        { "type": "list", "items": [
          "<strong>Estate tax reduction</strong> — assets transferred to certain irrevocable trusts are removed from the grantor's taxable estate.",
          "<strong>Asset protection</strong> — properly structured irrevocable trusts can shield assets from future creditors (rules vary widely by state).",
          "<strong>Special needs planning</strong> — a special needs trust preserves a disabled beneficiary's eligibility for government benefits while providing supplemental support.",
          "<strong>Life insurance ownership (ILIT)</strong> — an irrevocable life insurance trust owns the policy so death proceeds are not part of the taxable estate.",
          "<strong>Charitable planning</strong> — charitable remainder trusts and charitable lead trusts have specialized estate and income tax benefits."
        ]},

        { "type": "callout", "kind": "warn", "title": "The cost of irrevocability", "text": "An irrevocable trust gives up control. If circumstances change, the trust is generally stuck. Most clients should not enter irrevocable arrangements until the basic planning is solid and the specific tax/protection benefit clearly justifies the loss of flexibility. Always involve an experienced estate attorney." },

        { "type": "divider" },

        { "type": "heading", "text": "When a will alone is fine" },
        { "type": "paragraph", "text": "Most clients do not need a trust. A well-drafted will, combined with proper beneficiary designations and joint ownership where appropriate, handles their estate cleanly." },
        { "type": "subheading", "text": "Will-only is typically sufficient when..." },
        { "type": "list", "items": [
          "Estate is well below federal exemption (currently $13+ million per individual, sunset reverts lower in 2026).",
          "Single state of residence with reasonable probate (most states are not California or Florida).",
          "Simple family structure — first marriage, no special-needs beneficiaries.",
          "No business interests requiring sophisticated succession planning.",
          "No need for incapacity-driven trust management (powers of attorney suffice)."
        ]},

        { "type": "case_study",
          "title": "Trust or no trust?",
          "scenario": "Two clients each have $1.4 million net worth, two adult children, simple family situations. Client A lives in Texas. Client B lives in California.",
          "discussion": "<p>Client A (Texas): probate in Texas is relatively painless and quick — independent administration is common, court oversight minimal. A well-drafted will plus beneficiary designations and joint titling on the house likely suffices. <strong>Trust adds cost without much benefit.</strong></p><p>Client B (California): California probate is famously slow, expensive (statutory attorney fees on a $1.4M estate run roughly $25,000+), and public. A revocable living trust costs $2,000–$5,000 to set up but saves the probate process entirely. <strong>The trust pays for itself many times over.</strong></p><p>The trust decision is jurisdictional more than wealth-based. Always ask about the client's state and whether real estate is owned in multiple states.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Gifts, Estate Tax, and the Federal Exemption",
      "summary": "When taxes matter, who they apply to, and how to use the annual exclusion.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Federal estate and gift tax affects a small fraction of households — but for the clients it affects, the stakes are enormous. And the rules around the annual gift exclusion and lifetime exemption matter in planning conversations even when the client isn't currently above the threshold." },

        { "type": "heading", "text": "The lifetime exemption" },
        { "type": "paragraph", "text": "Federal estate tax applies to the value transferred at death (or by gift during life) that exceeds the <strong>lifetime exemption</strong>. As of 2025, the exemption is approximately <strong>$13.99 million per individual</strong> ($27.98 million per couple). For estates above this threshold, the marginal federal estate tax rate is 40%." },
        { "type": "callout", "kind": "warn", "title": "The 2026 sunset", "text": "Unless Congress acts, the lifetime exemption is currently scheduled to be roughly cut in half at the end of 2025, dropping to approximately $7 million per individual. Clients with estates in the $7–14M range may move from \"not subject to estate tax\" to \"subject to estate tax\" based on legislative action alone. This is a real planning consideration; high-net-worth clients should be discussing it with an estate attorney now. <em>Always verify the current threshold before quoting it to clients — legislation changes.</em>" },

        { "type": "heading", "text": "Annual gift exclusion" },
        { "type": "paragraph", "text": "Separate from the lifetime exemption, every individual can gift up to a certain amount per recipient per year with no tax consequence and no use of the lifetime exemption. As of 2025: <strong>$19,000 per recipient per year</strong>. A married couple can jointly gift $38,000 per recipient. There is no limit on the number of recipients." },
        { "type": "subheading", "text": "Annual exclusion examples" },
        { "type": "list", "items": [
          "A couple gifts $38,000 to each of their three children annually: $114,000 per year transferred, no gift tax filing required, no use of lifetime exemption.",
          "Grandparents (a couple) gift $38,000 to each of five grandchildren plus three children: $304,000 per year transferred.",
          "Over a 10-year period, the same couple could transfer over $3 million using only annual exclusions — sizable wealth movement with no tax cost."
        ]},
        { "type": "callout", "kind": "key", "title": "Why this matters for high-net-worth families", "text": "Systematic use of the annual gift exclusion reduces the taxable estate over time. Combined with strategic use of the lifetime exemption (especially before any reduction), it can move enormous wealth across generations tax-free. The window is open until it isn't — and unlike many planning ideas, this one runs on a literal calendar." },

        { "type": "divider" },

        { "type": "heading", "text": "Step-up in basis" },
        { "type": "paragraph", "text": "When an asset is inherited at death, the recipient's tax basis is generally reset to the asset's value at the date of death — the <strong>step-up in basis</strong>. This can be a far more valuable tax provision than the estate tax exemption for many families." },
        { "type": "subheading", "text": "Why step-up matters" },
        { "type": "list", "items": [
          "A client buys $50,000 of stock that grows to $500,000 over 30 years. If she sells, she owes capital gains tax on the $450,000 gain.",
          "If she instead holds the stock until death, her heirs inherit it at the $500,000 stepped-up basis. They can sell immediately and owe no capital gains tax.",
          "This is why planners often recommend that highly-appreciated assets be held until death rather than sold during life, particularly when heirs will receive them anyway."
        ]},
        { "type": "callout", "kind": "do", "title": "The planning move", "text": "When a client has both highly-appreciated assets and assets without much gain, sell the low-gain assets first if cash is needed. Leave the appreciated assets for the step-up at death. This is one of the highest-leverage tax planning moves available to anyone with taxable investments, and it costs nothing to execute correctly." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Working with the Estate Attorney",
      "summary": "How a Wealth Solutions Counselor coordinates without practicing law.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Drafting wills and trusts is the practice of law and requires a licensed attorney. A Wealth Solutions Counselor's role in estate planning is to identify the need, prepare the client for the conversation, coordinate with the attorney, and implement and maintain the plan over time. Done well, the counselor multiplies the value of the attorney's work." },

        { "type": "heading", "text": "What the counselor does" },
        { "type": "list", "items": [
          "<strong>Identify the gap.</strong> Most clients haven't done estate planning, or did it many years ago. The counselor notices and raises the conversation.",
          "<strong>Gather information.</strong> Before the attorney meeting, help the client prepare: asset inventory, beneficiaries, family details, goals for distribution.",
          "<strong>Explain plain-language basics.</strong> Walk the client through what a will does, why beneficiary designations matter, what powers of attorney accomplish. Demystify the conversation before they meet with the attorney.",
          "<strong>Refer to a qualified attorney.</strong> Have a short list of vetted estate planning attorneys. Match the complexity to the right attorney.",
          "<strong>Coordinate implementation.</strong> Once documents are signed, help the client retitle assets into the trust, update beneficiary designations, and store documents safely.",
          "<strong>Monitor and update.</strong> Life changes (marriage, divorce, new child, inheritance, business sale, move) and law changes both trigger reviews."
        ]},

        { "type": "callout", "kind": "warn", "title": "What the counselor does NOT do", "text": "Draft documents. Provide legal advice on which provisions to choose. Opine on trust selection, executor selection, or specific clauses. Witness signing of estate documents (unless explicitly part of firm procedure, and even then under attorney supervision). Be the trustee, executor, or POA agent for a client (unless your firm has a formal corporate trustee arrangement). The line is real — when in doubt, defer to the attorney." },

        { "type": "heading", "text": "Storing the documents" },
        { "type": "paragraph", "text": "An estate plan that can't be found is no plan at all. Help clients establish a system:" },
        { "type": "list", "items": [
          "Original signed documents stored in a fireproof safe or with the attorney (not in a bank safe deposit box — those can be sealed at death until court order).",
          "Copies provided to the executor, POA agents, and healthcare agents.",
          "Family members told where the originals are kept.",
          "Beneficiary designations stored alongside or referenced — they're not part of the will but are part of the plan.",
          "Digital asset inventory: passwords, accounts, cryptocurrency. This is a growing gap; courts and family struggle to access digital assets without documentation."
        ]},

        { "type": "case_study",
          "title": "The first estate planning conversation",
          "scenario": "Naomi (now 36) is single, no children, $250K net worth, lives in California. She's never had any estate documents drafted. In a routine planning meeting, you ask: 'What happens if you can't make medical decisions tomorrow?' She doesn't know.",
          "discussion": "<p>Naomi doesn't need a trust at this stage. Her assets are still below the California probate hassle threshold, her situation is simple, and she has no dependents requiring complex distribution. What she needs:</p><ul><li>Will — names a beneficiary (likely her parents or a sibling) and an executor.</li><li>Durable POA for finances — names someone to manage her finances if she's incapacitated.</li><li>Healthcare POA + advance directive — names a medical decision-maker and her preferences.</li><li>HIPAA authorization — allows the medical agent to access her records.</li><li>Beneficiary designations updated on her Roth IRA, 401(k), HSA, and any life insurance.</li></ul><p>Cost: probably $500–$1,500 with a flat-fee estate attorney. Time: one or two meetings.</p><p>The advisor's contribution: noticing the gap, framing it without scaring her, providing a vetted attorney, and helping her implement after signing. As her net worth grows or her family situation changes, she'll come back for revisions. <strong>This is what 'preparing the next generation of Wealth Solutions Counselors' actually looks like in practice — taking a smart 36-year-old from 'I should do that someday' to 'I have all the documents' in less than a month.</strong></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which four documents make up the minimum-viable estate plan every adult should have?",
        "options": [
          "Will, 401(k), homeowners insurance, life insurance",
          "Will, durable financial POA, healthcare POA / advance directive, HIPAA authorization",
          "Will, trust, deed, mortgage",
          "Living will, last will, holographic will, codicil"
        ],
        "correct": 1,
        "explanation": "Every adult — regardless of net worth — should have these four. They handle the structural risks of death and incapacity. Trusts and advanced planning layer on top of this base."
      },
      {
        "id": "q2",
        "prompt": "If a person dies without a will, their estate is distributed:",
        "options": [
          "Equally among all surviving relatives.",
          "To the federal government.",
          "According to the state's intestacy laws, which often produce surprising results.",
          "To whomever filed the death certificate."
        ],
        "correct": 2,
        "explanation": "State intestacy laws set default distribution. They rarely match what the deceased would have chosen — surviving spouses may share with parents, unmarried partners may inherit nothing, minor children's funds get held by court-appointed conservators."
      },
      {
        "id": "q3",
        "prompt": "Beneficiary designations on retirement accounts and life insurance:",
        "options": [
          "Are controlled by the will.",
          "Override the will and pass directly to the named beneficiary, regardless of what the will says.",
          "Only apply if the will is missing or contested.",
          "Require probate court approval to be honored."
        ],
        "correct": 1,
        "explanation": "Beneficiary designations override wills. Always. The most common estate-planning disaster: a will leaving everything to the second spouse, while the 401(k) still names the ex-spouse from 15 years ago. The 401(k) goes to the ex. Auditing beneficiaries annually prevents this."
      },
      {
        "id": "q4",
        "prompt": "What is the primary purpose of a revocable living trust?",
        "options": [
          "Save federal estate taxes.",
          "Protect assets from creditors during the grantor's lifetime.",
          "Avoid probate, plan for incapacity, and provide privacy for asset distribution.",
          "Generate income tax deductions."
        ],
        "correct": 2,
        "explanation": "Revocable trusts are estate-administration tools, not tax tools. They bypass probate, allow seamless management at incapacity, and keep distributions private. They do NOT save estate taxes (grantor still owns the assets for tax purposes) or protect from grantor's creditors during life."
      },
      {
        "id": "q5",
        "prompt": "Which factor makes a revocable trust most clearly worth the cost?",
        "options": [
          "The client lives in a state with painful probate (California, Florida, etc.) or owns real estate in multiple states.",
          "The client's net worth is above $1 million.",
          "The client has more than one child.",
          "The client is over age 65."
        ],
        "correct": 0,
        "explanation": "The trust decision is jurisdictional more than wealth-based. In states with slow, expensive, public probate processes, even modest estates benefit from trust ownership. Conversely, in states with streamlined probate, the same wealth level may not justify the trust."
      },
      {
        "id": "q6",
        "prompt": "What is the 2025 federal estate tax lifetime exemption per individual (approximate)?",
        "options": [
          "$1 million",
          "$5.5 million",
          "$13.99 million",
          "$25 million"
        ],
        "correct": 2,
        "explanation": "Approximately $13.99 million per individual in 2025. Note: scheduled to roughly halve at end of 2025 absent congressional action. Verify the current threshold before quoting to clients — this number moves."
      },
      {
        "id": "q7",
        "prompt": "What is the 2025 annual gift tax exclusion per recipient?",
        "options": [
          "$5,000",
          "$15,000",
          "$19,000",
          "$50,000"
        ],
        "correct": 2,
        "explanation": "$19,000 per recipient per giver in 2025. A married couple can jointly gift $38,000 per recipient. No limit on number of recipients. Systematic use can transfer significant wealth across generations tax-free."
      },
      {
        "id": "q8",
        "prompt": "What is the 'step-up in basis' and why does it matter?",
        "options": [
          "An IRS penalty on gifts made within one year of death.",
          "When assets are inherited at death, the recipient's tax basis is reset to the asset's value at date of death — eliminating capital gains tax on prior appreciation.",
          "A method of valuing real estate for property tax purposes.",
          "The increase in retirement contribution limits at age 50."
        ],
        "correct": 1,
        "explanation": "Step-up in basis often saves more tax for middle-class families than estate tax exemption ever could. Highly appreciated assets held until death allow heirs to sell immediately with no capital gains tax on the prior growth. This is why advisors often recommend selling low-gain assets first and holding high-gain assets for inheritance."
      },
      {
        "id": "q9",
        "prompt": "When does an irrevocable trust make sense versus a revocable trust?",
        "options": [
          "Always — irrevocable trusts are more flexible.",
          "When the planning goal specifically requires loss of grantor control: estate tax reduction, asset protection, special-needs planning, or specific tax structures.",
          "When the client doesn't trust their family members.",
          "Whenever net worth exceeds $1 million."
        ],
        "correct": 1,
        "explanation": "Irrevocable trusts surrender grantor control. They're appropriate when a specific goal — estate tax reduction, asset protection, special needs preservation, life insurance trust structures — justifies giving up the flexibility. They are never the default; always involve experienced estate counsel."
      },
      {
        "id": "q10",
        "prompt": "Which life event MOST commonly creates a beneficiary designation problem advisors must catch?",
        "options": [
          "Birth of a child",
          "Buying a home",
          "Divorce — ex-spouses often remain beneficiaries on retirement accounts and life insurance long after the divorce.",
          "Job change"
        ],
        "correct": 2,
        "explanation": "Divorce is the highest-stakes trigger. State law sometimes auto-revokes ex-spouse designations, but federal law preempts for ERISA-governed plans (401(k)s) and the ex remains beneficiary unless manually changed. Every divorce should trigger a beneficiary audit on every retirement account and life insurance policy."
      },
      {
        "id": "q11",
        "prompt": "What is the role of a Wealth Solutions Counselor in estate planning?",
        "options": [
          "Draft the will and trust documents themselves.",
          "Identify the need, prepare the client, refer to and coordinate with an estate attorney, and implement and maintain the plan over time.",
          "Serve as executor and trustee for all clients.",
          "Provide specific legal advice on which provisions to choose."
        ],
        "correct": 1,
        "explanation": "Drafting documents is the practice of law and requires a licensed attorney. The counselor's role is identifying the need, preparing the client, coordinating with the attorney, and handling implementation (retitling, beneficiaries, ongoing review). The boundary is real — when in doubt, defer to the attorney."
      },
      {
        "id": "q12",
        "prompt": "Why is a bank safe deposit box generally a BAD place to store original estate documents?",
        "options": [
          "Banks don't keep them secure.",
          "They can be sealed at death until a court order is issued — exactly the moment the family needs access.",
          "Banks charge too much rent for the boxes.",
          "Documents fade in safe deposit boxes."
        ],
        "correct": 1,
        "explanation": "Safe deposit boxes can be sealed at the owner's death, requiring court intervention to access. The family needs the documents at precisely that moment. Better options: fireproof home safe, with the attorney, or with the executor. Always tell the family where the originals are."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 8;
