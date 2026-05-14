-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 9 CONTENT
-- Ethics, Fiduciary Duty & Regulation
-- ============================================================================
update public.modules set
  title = 'Ethics, Fiduciary Duty & Regulation',
  competency_id = 'CORE-9',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The standards that separate a professional from a salesperson. Fiduciary duty, suitability, the regulatory landscape, and the daily judgment calls that make or break a career.',
  learning_objectives = ARRAY[
    'Distinguish fiduciary duty from suitability and explain why the difference matters.',
    'Identify the major U.S. regulators (SEC, FINRA, state regulators, CFP Board) and who they oversee.',
    'Recognize conflicts of interest and apply the disclose/mitigate/avoid framework.',
    'Explain Regulation Best Interest (Reg BI) and the Investment Advisers Act of 1940 at a working level.',
    'Apply the CFP Board Code of Ethics to common client scenarios.',
    'Identify the red flags that require immediate escalation to compliance.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Fiduciary Duty vs. Suitability",
      "summary": "The single most important distinction in the financial services industry.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "If a client asked you, \"is my advisor required to act in my best interest?\" — would you know how to answer? The answer depends on what kind of advisor they have, what regulator oversees that advisor, and what they're being advised on. This lesson teaches the distinction every counselor must be able to make in plain language." },

        { "type": "heading", "text": "Fiduciary duty" },
        { "type": "callout", "kind": "key", "title": "The fiduciary standard, plainly", "text": "A fiduciary is legally required to act in the client's best interest, putting the client's interests <em>ahead</em> of the fiduciary's own. This includes a duty of loyalty (no self-dealing), a duty of care (reasonable competence and prudence), and a duty of full disclosure of material conflicts of interest." },
        { "type": "paragraph", "text": "Fiduciary duty applies to:" },
        { "type": "list", "items": [
          "Registered Investment Advisers (RIAs) under the Investment Advisers Act of 1940.",
          "Investment Adviser Representatives (IARs) — the individuals registered with RIAs.",
          "Trustees, executors, attorneys, doctors, and many other professional roles.",
          "CFP® professionals when providing financial advice (per CFP Board's Code of Ethics, since 2019)."
        ]},

        { "type": "heading", "text": "Suitability" },
        { "type": "paragraph", "text": "A lower standard. Historically applied to brokers (registered representatives of broker-dealers): the recommended product must be \"suitable\" given the client's profile, but the broker is not required to recommend the <em>best</em> option for the client — only one that fits." },
        { "type": "callout", "kind": "warn", "title": "Why this difference matters", "text": "Under suitability, a broker could recommend a product paying them a 5% commission when an identical product at 0.5% existed — as long as the recommended product was \"suitable.\" Under fiduciary duty, that recommendation would be a violation. Same product. Same client. Different legal duty. Different outcome." },

        { "type": "heading", "text": "Regulation Best Interest (Reg BI)" },
        { "type": "paragraph", "text": "Adopted by the SEC in 2019. Raised the broker standard from \"suitability\" to \"best interest\" for retail customers, but stopped short of full fiduciary duty. Reg BI requires brokers to:" },
        { "type": "list", "items": [
          "Act in the retail customer's best interest at the time of recommendation.",
          "Not place the broker's financial interests ahead of the customer's.",
          "Have policies to identify and mitigate conflicts.",
          "Provide a customer relationship summary (Form CRS) disclosing relationships, fees, and conflicts."
        ]},
        { "type": "callout", "kind": "note", "title": "Reg BI is NOT full fiduciary duty", "text": "Reg BI applies to brokers at the moment of recommendation; fiduciary duty under the Advisers Act applies to investment advisers continuously across the relationship. Reg BI permits commission-based compensation; full fiduciary duty doesn't prohibit it but treats it as a conflict requiring management. The standards have converged somewhat but are not the same — and the difference still matters in client conversations." },

        { "type": "divider" },

        { "type": "heading", "text": "Why this lives at the center of the profession" },
        { "type": "paragraph", "text": "Financial advice is the rare service where the advisor's compensation can be structured in ways that conflict with what's best for the client. A real estate agent earns a commission only if you buy. A car salesperson is compensated when the car sells. Financial advisors can be paid by fees, commissions, asset-based percentages, sales contests, or product-specific compensation — and the structure shapes the recommendation, whether or not the advisor consciously realizes it." },
        { "type": "callout", "kind": "key", "title": "The honest frame", "text": "Don't ask <em>\"is this advisor a fiduciary?\"</em> Ask <em>\"how does this advisor get paid, and what would they recommend differently if they were paid another way?\"</em> That question gets to the heart of the matter and respects the client's intelligence." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Regulatory Map",
      "summary": "Who regulates whom — and where Global Investment Company fits.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial services regulation in the U.S. is a maze. A counselor doesn't need to be a compliance attorney, but does need to know who oversees each piece of the work — and who to call when something goes wrong." },

        { "type": "heading", "text": "The major regulators" },
        { "type": "glossary", "terms": [
          { "term": "SEC — Securities and Exchange Commission", "definition": "Federal regulator of securities markets, broker-dealers (jointly with FINRA), and Registered Investment Advisers with assets under management above $100 million." },
          { "term": "FINRA — Financial Industry Regulatory Authority", "definition": "Self-regulatory organization overseeing broker-dealers and registered representatives. Administers the Series 7, Series 6, Series 65, Series 66 and other licensing exams." },
          { "term": "State securities regulators", "definition": "Oversee Investment Advisers with AUM below $100 million (mid-sized advisers split by state-specific thresholds) and broker-dealers operating within the state." },
          { "term": "CFP Board", "definition": "Private organization that grants and maintains the Certified Financial Planner® credential. Enforces its own Code of Ethics and Standards of Conduct for CFP professionals." },
          { "term": "DOL — Department of Labor", "definition": "Regulates advice and management of ERISA-covered retirement plans (most 401(k)s, pensions). Issues fiduciary regulations for retirement plan investment advice." },
          { "term": "CFPB — Consumer Financial Protection Bureau", "definition": "Regulates consumer financial products: mortgages, credit cards, credit reporting, debt collection. Less directly relevant to investment advice but matters for advisors discussing debt and credit." },
          { "term": "State insurance commissioners", "definition": "Regulate insurance products and producers. Insurance is largely a state regulatory matter." }
        ]},

        { "type": "heading", "text": "Three kinds of advisor licensure" },
        { "type": "subheading", "text": "Investment Adviser Representative (IAR)" },
        { "type": "paragraph", "text": "Provides investment advice for compensation. Registered with an RIA firm, which is registered with the SEC (large firms) or state regulators (smaller firms). Operates under fiduciary duty. Typically passes the Series 65 (or Series 66 with Series 7). Compensation usually fee-based: percentage of AUM, hourly, flat fees." },

        { "type": "subheading", "text": "Registered Representative (RR)" },
        { "type": "paragraph", "text": "Sometimes called a stockbroker. Sells securities through a broker-dealer. Regulated by FINRA. Operates under suitability + Reg BI. Typically passes Series 7 (full securities) or Series 6 (mutual funds and variable annuities only). Compensation often commission-based." },

        { "type": "subheading", "text": "Insurance producer" },
        { "type": "paragraph", "text": "Sells insurance and annuity products. State-licensed. Operates under state insurance laws (suitability standards for annuities; variable annuities are securities and require additional FINRA licensing). Compensation typically commission-based, sometimes with renewals." },

        { "type": "callout", "kind": "key", "title": "Most modern advisors are 'dual-registered'", "text": "Carry both IAR and RR credentials. They can provide advisory services under fiduciary duty <em>and</em> sell commission products under Reg BI. The duty applied to a specific transaction depends on which capacity the advisor is acting in. Client confusion about \"hats\" is endemic; the advisor's job is to make the hat clear at every relevant moment." },

        { "type": "divider" },

        { "type": "heading", "text": "Where Global Investment Company fits" },
        { "type": "paragraph", "text": "Global Investment Company operates as a Registered Investment Adviser under the Investment Advisers Act of 1940. Wealth Solutions Counselors at GIC operate under fiduciary duty. This is the firm's chosen standard and is reflected in our compensation model (fee-based, no commissions), our disclosure practices (Form ADV available to all clients), and our standards of practice (documented in this curriculum)." },
        { "type": "callout", "kind": "do", "title": "Form ADV", "text": "Every RIA must file <strong>Form ADV</strong> with the SEC or state regulators. Parts 2A and 2B are written in plain English and disclose services, fees, conflicts, disciplinary history of the firm and its representatives. Every client must receive these. As a counselor, you should be able to point clients to GIC's Form ADV and walk them through the relevant sections. Memorize where they live in your firm's onboarding kit." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Conflicts of Interest",
      "summary": "What they are, why they're inevitable, and the framework for handling them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Conflicts of interest are not bad in themselves — they're inherent to almost every advisor-client relationship. The professional question is not \"are there conflicts?\" The professional question is \"are the conflicts disclosed, mitigated, or avoided — and which one is appropriate for each conflict?\"" },

        { "type": "heading", "text": "Common conflicts to recognize" },
        { "type": "list", "items": [
          "<strong>Compensation structure</strong> — fee-based, commission-based, AUM-based all create different incentives. AUM advisors are paid more when assets grow, including incentivizing the advisor to keep client assets under management even when paying down debt or buying a home would be a better use.",
          "<strong>Product compensation differentials</strong> — some products pay the firm more than others. The advisor's recommendation should not be driven by what pays better.",
          "<strong>Proprietary products</strong> — firms with their own mutual funds, annuities, or insurance products face conflicts when recommending in-house vs. third-party alternatives.",
          "<strong>Cross-selling pressure</strong> — banks and large firms often expect advisors to refer clients to other product lines (mortgages, insurance, trust services). Each referral creates a potential conflict.",
          "<strong>Sales contests and incentives</strong> — quarterly contests, trips, bonuses tied to product sales create strong incentives that can override fiduciary judgment.",
          "<strong>Outside relationships</strong> — when the advisor has a personal or business relationship with a product provider, custodian, or referral source.",
          "<strong>Personal investments</strong> — when the advisor owns the same securities being recommended (front-running, etc.)."
        ]},

        { "type": "heading", "text": "The framework: disclose, mitigate, avoid" },
        { "type": "subheading", "text": "Disclose" },
        { "type": "paragraph", "text": "Most conflicts cannot be eliminated. They can be disclosed — in writing, in plain language, ideally before the recommendation is acted on. Disclosure shifts the question to the client: \"given that I am paid this way, here is my recommendation.\" Disclosure alone does not satisfy fiduciary duty if the conflict actually drives the recommendation — but it's the floor." },

        { "type": "subheading", "text": "Mitigate" },
        { "type": "paragraph", "text": "Some conflicts can be reduced. Examples:" },
        { "type": "list", "items": [
          "Internal review of recommendations involving products paying higher compensation.",
          "Required documentation of why a recommendation was made (especially when alternatives exist).",
          "Compensation grids that pay the advisor the same regardless of which product within a category is recommended.",
          "Refusing certain compensation arrangements that create structural pressure (sales contests, etc.).",
          "Pre-trade approval requirements for personal securities trades."
        ]},

        { "type": "subheading", "text": "Avoid" },
        { "type": "paragraph", "text": "Some conflicts are sufficiently serious that the only correct response is to walk away from them. Examples:" },
        { "type": "list", "items": [
          "Accepting gifts or entertainment beyond modest, customary levels.",
          "Personal financial relationships with clients beyond the advisory relationship (loans, joint investments, romantic relationships).",
          "Serving as a beneficiary of a client's estate (other than for the advisor's own family).",
          "Trading client securities for personal benefit ahead of client trades.",
          "Recommending a product that pays significantly more in compensation when an alternative is clearly better for the client."
        ]},

        { "type": "callout", "kind": "key", "title": "The decision rule", "text": "<em>If I had to defend this recommendation in front of regulators, a judge, and the client's adult children, knowing they would learn how I was compensated — would my recommendation still hold up?</em> If yes, document it and proceed. If no, change the recommendation or escalate." },

        { "type": "case_study",
          "title": "The product recommendation",
          "scenario": "Your firm offers two retirement income products in roughly the same category. Product A pays your firm a 1% advisory fee on assets; Product B is a proprietary annuity with a 5% upfront commission to the firm and to you personally. Both products are 'suitable' for the client.",
          "discussion": "<p>Under suitability, either product is acceptable. Under fiduciary duty, the standard is harder: which is actually in the client's best interest?</p><p>To answer honestly, compare on dimensions that matter to the client: total fees over expected holding period, surrender charges, flexibility of access, expected returns, tax treatment, complexity, and the client's actual planning need. If after that analysis the proprietary annuity is genuinely the better product for the client, then it's the right recommendation — and the documentation should clearly show why.</p><p>If after that analysis the open-architecture advisory fee product is better and you still recommend the annuity because of compensation, you've violated fiduciary duty regardless of whether the annuity is 'suitable.' The honest test isn't whether the product fits — it's whether it's the best available option for this client.</p><p><strong>Document the analysis, every time.</strong> If you can't explain why a higher-compensation product was chosen over a lower-compensation alternative in writing, don't choose it.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "The CFP Board Standards and Ethical Decision-Making",
      "summary": "How professionals decide when the right answer isn't obvious.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Many of the hardest moments in advisory practice are not technical questions — they're ethical ones. The CFP Board Code of Ethics and Standards of Conduct provides a framework for these moments. Even if a counselor is not yet a CFP professional, knowing the framework strengthens judgment." },

        { "type": "heading", "text": "The CFP Code of Ethics" },
        { "type": "paragraph", "text": "The CFP Board requires its certificants to commit to six principles:" },
        { "type": "numbered", "items": [
          "<strong>Act with honesty, integrity, competence, and diligence.</strong>",
          "<strong>Act in the client's best interests.</strong>",
          "<strong>Exercise due care.</strong>",
          "<strong>Avoid or disclose and manage conflicts of interest.</strong>",
          "<strong>Maintain the confidentiality and protect the privacy of client information.</strong>",
          "<strong>Act in a manner that reflects positively on the financial planning profession and CFP® certification.</strong>"
        ]},

        { "type": "heading", "text": "The fiduciary duty within the CFP Standards" },
        { "type": "paragraph", "text": "When providing financial advice to a client, a CFP professional is bound by a <strong>fiduciary duty</strong> consisting of:" },
        { "type": "list", "items": [
          "<strong>Duty of loyalty</strong> — place the client's interests above the CFP's own and the firm's.",
          "<strong>Duty of care</strong> — provide advice with care, skill, prudence, and diligence reasonable under the circumstances.",
          "<strong>Duty to follow client instructions</strong> — within the scope of the engagement and consistent with the law."
        ]},

        { "type": "heading", "text": "Ethical decision-making in practice" },
        { "type": "paragraph", "text": "When the right answer isn't obvious, the structured approach is:" },
        { "type": "numbered", "items": [
          "<strong>Identify the parties and their interests.</strong> Whose interests are affected and how?",
          "<strong>Identify the relevant duties.</strong> What does fiduciary duty require? What does the firm's policy require? What do applicable regulations require?",
          "<strong>Identify the conflict.</strong> Where do interests or duties collide?",
          "<strong>Consider alternatives.</strong> What are the possible courses of action?",
          "<strong>Evaluate each alternative.</strong> Against client interest, against duties, against the optics of the decision.",
          "<strong>Decide and act.</strong> Choose the course of action best aligned with duty and document the reasoning.",
          "<strong>Escalate when uncertain.</strong> When the stakes are meaningful or the answer unclear, involve a supervisor or compliance officer."
        ]},

        { "type": "callout", "kind": "do", "title": "The simple test before any tough call", "text": "<em>If this decision became public tomorrow — to my client, to my employer, to regulators, to the press — would I be comfortable defending it?</em> If yes, proceed and document. If no, reconsider or escalate. The discomfort of escalating is far smaller than the discomfort of a violation that surfaces later." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The friend-of-a-friend referral",
          "scenario": "A new client is referred by an existing client, who calls and says, 'I told her you'd take care of her, she's recently widowed and inherited $1.2M, just put it somewhere safe.' The widow is 64, grieving, hasn't yet processed the situation, and signs whatever you put in front of her in the first meeting.",
          "discussion": "<p>Several ethical issues at once:</p><ul><li><strong>Capacity to engage.</strong> A grieving client immediately after a major loss may not be in a state to make informed long-term decisions. The 30-day-rule (some advisors won't make major recommendations within 30–60 days of a significant life event) exists for this reason.</li><li><strong>Discovery.</strong> You can't make a fiduciary recommendation without understanding the client's situation. 'Put it somewhere safe' is not a goal — it's a feeling.</li><li><strong>Referring-client pressure.</strong> The implicit \"I told her you'd take care of her\" creates pressure to act quickly to deliver for the referrer. That pressure runs counter to taking the time the situation requires.</li><li><strong>Signing documents.</strong> The widow signing without comprehension is not informed consent.</li></ul><p>The right move: slow down. Express condolences clearly. Do a thorough discovery over multiple meetings. Park the $1.2M in a high-yield savings account or short-term Treasuries while you both work toward clarity. Document everything. Resist any temptation to recommend investment products in the first few weeks. If the referring client gets impatient, that's a signal about the referring client, not about the work — explain calmly that this is how you serve clients well, regardless of how they came in the door.</p><p><strong>This is fiduciary duty in practice: not the technical right product, but the right pace and the right care.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Red Flags and Escalation",
      "summary": "What to do when something doesn't sit right — and the price of not doing it.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Ethical practice is shaped less by big decisions and more by daily judgment calls. The counselor who learns to recognize red flags and act on them is the counselor whose career lasts. The one who lets things slide accumulates risk that eventually erupts." },

        { "type": "heading", "text": "Client-side red flags" },
        { "type": "list", "items": [
          "<strong>Diminished capacity.</strong> Client confusion about their own finances, memory lapses, unusual decisions, vulnerability to family pressure. Escalate and follow firm protocols (which may include reaching out to a trusted contact on file).",
          "<strong>Suspected elder financial abuse.</strong> Caregiver involvement in unusual transactions, new \"friend\" appearing in financial matters, isolation from family. Many states require advisors to report suspected abuse.",
          "<strong>Sudden, unexplained changes</strong> in beneficiaries, withdrawal patterns, or risk tolerance — particularly from clients who have previously been consistent.",
          "<strong>Pressure to make a transaction.</strong> 'I need this done today.' Urgency is a red flag, not a justification.",
          "<strong>Requests on accounts the client doesn't own.</strong> Anything involving an elderly parent, an adult child, an ex-spouse, a business partner.",
          "<strong>Disclosure of marital problems, depression, or addiction.</strong> Not directly an investment issue, but each affects judgment and may signal need for caution and slowing down.",
          "<strong>Mention of large unsolicited investment opportunities</strong> — friend's startup, crypto scheme, real estate fund, etc. Often legitimate, sometimes fraud, sometimes outside the advisor's scope."
        ]},

        { "type": "heading", "text": "Advisor-side red flags" },
        { "type": "paragraph", "text": "Equally important: notice when something about <em>your own</em> situation or another colleague's situation crosses a line." },
        { "type": "list", "items": [
          "Personal financial pressure that might influence recommendations.",
          "Compensation structure that's pushing toward a specific product or behavior.",
          "Personal relationship with a client that's becoming non-professional.",
          "Receiving gifts or entertainment that feels disproportionate.",
          "Colleague's behavior toward clients, accounts, or compliance procedures that doesn't add up.",
          "Pressure from a supervisor to skip steps, rush decisions, or sell specific products."
        ]},

        { "type": "callout", "kind": "warn", "title": "What to do with red flags", "text": "Document the observation in client notes. Escalate to a supervisor or compliance officer. If the conduct is criminal or fraudulent, internal whistleblower protections apply, and external reporting channels exist (SEC tip line, FINRA complaint, state regulator). Inaction is not a neutral choice — silence becomes complicity." },

        { "type": "heading", "text": "The career arc this protects" },
        { "type": "paragraph", "text": "The vast majority of advisors who are sanctioned, fined, or barred from the industry didn't intend to commit a violation. They drifted. A small ethical compromise here, a missed disclosure there, a friend's deal that seemed harmless. The accumulation eventually reaches a regulator or a lawsuit, and at that point the documentation either tells a clean story or it doesn't." },

        { "type": "callout", "kind": "key", "title": "The advisor who lasts", "text": "Treats every recommendation as if it might be reviewed five years from now. Documents conflicts before they're noticed. Escalates uncomfortable conversations rather than swallowing them. Operates with the assumption that clean practice <em>is</em> the business model — not friction that interferes with it. <strong>This is what \"professional\" means in the deepest sense.</strong> It's also what makes a 40-year career possible." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the most important practical difference between fiduciary duty and suitability?",
        "options": [
          "Fiduciary duty applies only to lawyers; suitability applies to financial advisors.",
          "Fiduciary duty requires acting in the client's best interest; suitability requires only that a recommendation be appropriate.",
          "Fiduciary duty applies only to retirement accounts; suitability applies to taxable accounts.",
          "They are the same standard with different names."
        ],
        "correct": 1,
        "explanation": "Fiduciary requires the client's interests come first. Suitability allows a 'fitting' recommendation even when better options exist. Same product, same client, different legal duty, different acceptable outcome."
      },
      {
        "id": "q2",
        "prompt": "Which federal law makes Registered Investment Advisers (RIAs) fiduciaries?",
        "options": [
          "Sarbanes-Oxley Act of 2002",
          "Investment Advisers Act of 1940",
          "Securities Act of 1933",
          "Dodd-Frank Act of 2010"
        ],
        "correct": 1,
        "explanation": "The Investment Advisers Act of 1940 establishes the regulatory framework for RIAs and the fiduciary duty under which they operate."
      },
      {
        "id": "q3",
        "prompt": "What is Regulation Best Interest (Reg BI)?",
        "options": [
          "A 2019 SEC regulation requiring brokers to act in the retail customer's best interest at the time of recommendation, raising the standard from pure suitability but stopping short of full fiduciary duty.",
          "A FINRA rule about insider trading.",
          "A state-level fiduciary requirement.",
          "A DOL rule about retirement accounts only."
        ],
        "correct": 0,
        "explanation": "Reg BI raised the broker standard above pure suitability for retail customers but did not impose full fiduciary duty. It applies at the moment of recommendation, requires conflicts disclosure, and mandates Form CRS. Distinct from the continuous fiduciary duty under the Advisers Act."
      },
      {
        "id": "q4",
        "prompt": "An advisor compares two retirement products: Product A is fee-based (1% AUM), Product B is a proprietary annuity paying 5% upfront commission. Both are 'suitable.' Under fiduciary duty, the advisor must:",
        "options": [
          "Recommend Product A because lower fees are always better.",
          "Recommend Product B because the firm benefits more.",
          "Compare them honestly on dimensions that matter to the client and recommend the genuinely better option — documenting why if Product B is chosen.",
          "Let the client decide without a recommendation."
        ],
        "correct": 2,
        "explanation": "Fiduciary duty requires honest comparison and a recommendation in the client's best interest. If Product B is genuinely better despite higher compensation, recommending it is fine — but the analysis must demonstrate why, not just that the product is 'suitable.'"
      },
      {
        "id": "q5",
        "prompt": "Which form must every Registered Investment Adviser file and provide to clients?",
        "options": [
          "Form 1099",
          "Form ADV",
          "Form W-9",
          "Form 5500"
        ],
        "correct": 1,
        "explanation": "Form ADV (Parts 2A and 2B in plain English) disclose services, fees, conflicts, disciplinary history of the firm and its representatives. Required for every RIA. Counselors should know where these live in the firm's onboarding materials."
      },
      {
        "id": "q6",
        "prompt": "Conflicts of interest in advisory practice are best handled by:",
        "options": [
          "Eliminating all conflicts entirely.",
          "Ignoring them since they're inherent to the business.",
          "Disclosing, mitigating, or avoiding each conflict as appropriate — applying the right level of response to the level of conflict.",
          "Letting compliance handle all of them."
        ],
          "correct": 2,
          "explanation": "Most conflicts cannot be eliminated and are inherent to advisor compensation structures. The professional response: disclose lower-stakes conflicts, mitigate larger ones through process and policy, and avoid the conflicts that cannot be ethically managed (personal financial relationships with clients, beneficiary designations, etc.)."
      },
      {
        "id": "q7",
        "prompt": "Which of the following are core principles of the CFP Board Code of Ethics?",
        "options": [
          "Aggressively grow client assets, generate referrals, minimize taxes, maximize returns.",
          "Honesty, integrity, competence and diligence; act in client's best interest; due care; manage conflicts; maintain confidentiality; reflect positively on the profession.",
          "Sell suitable products, document recommendations, supervise junior staff.",
          "Pass continuing education, file annual reports, pay dues on time."
        ],
        "correct": 1,
        "explanation": "These are the six core principles of the CFP Board Code of Ethics. They apply to all CFP professionals and form the foundation of professional standards in financial planning."
      },
      {
        "id": "q8",
        "prompt": "A grieving client recently inherited $1.2M and wants you to 'put it somewhere safe today.' What's the right counselor move?",
        "options": [
          "Recommend an immediate purchase of a balanced mutual fund — she said somewhere safe.",
          "Slow down, do thorough discovery over multiple meetings, park the funds in a high-yield savings or short Treasuries until the client has clarity, and document the approach.",
          "Refuse the client because she's not making informed decisions.",
          "Have her sign documents quickly while she's motivated."
        ],
        "correct": 1,
        "explanation": "A grieving client immediately after a major loss may not be in a state to make informed long-term decisions. The right move: slow down, build understanding through discovery, park the money in safe and liquid options, and resist external pressure to act quickly. This is fiduciary duty in practice — not just product selection."
      },
      {
        "id": "q9",
        "prompt": "Which is a red flag requiring immediate escalation to a supervisor?",
        "options": [
          "Client asks a question about an unfamiliar product.",
          "A request involving an account the client doesn't legally own (e.g., an elderly parent's account).",
          "Client wants to change asset allocation.",
          "Client misses a quarterly meeting."
        ],
        "correct": 1,
        "explanation": "Requests involving accounts the client doesn't legally control may signal elder abuse, unauthorized activity, or the need for proper authorization. Escalate immediately rather than proceed. The cost of escalation is small; the cost of doing nothing can be enormous."
      },
      {
        "id": "q10",
        "prompt": "Why are commission-based sales contests a particular concern under fiduciary duty?",
        "options": [
          "They violate the law.",
          "They are illegal under all circumstances.",
          "They create structural incentives that can override fiduciary judgment by paying advisors more for one product over another regardless of client benefit.",
          "They are taxed at higher rates."
        ],
        "correct": 2,
        "explanation": "Sales contests financially incentivize the advisor to recommend specific products, which can drive recommendations toward higher-commission options rather than the best client outcome. They're not necessarily illegal but they create powerful pressure against fiduciary duty. Many firms have eliminated them; many haven't."
      },
      {
        "id": "q11",
        "prompt": "The 'simple test' to apply before making a difficult ethical call is:",
        "options": [
          "Would my supervisor approve?",
          "Is it technically legal?",
          "If this decision became public tomorrow — to my client, my employer, regulators, and the press — would I be comfortable defending it?",
          "Will it generate revenue for the firm?"
        ],
        "correct": 2,
        "explanation": "The public-defensibility test captures the spirit of fiduciary duty better than any single technical rule. If you'd be comfortable defending the decision openly, document and proceed. If not, reconsider or escalate. This single question prevents most career-ending mistakes."
      },
      {
        "id": "q12",
        "prompt": "What characterizes the advisor who builds a 40-year career without regulatory issues?",
        "options": [
          "Generates the most fees and commissions.",
          "Treats every recommendation as if it might be reviewed five years from now; documents conflicts proactively; escalates uncomfortable conversations rather than swallowing them.",
          "Has the most clients.",
          "Avoids all regulators and lawyers."
        ],
        "correct": 1,
        "explanation": "The advisors who get sanctioned didn't usually intend violations — they drifted. Clean documentation, proactive disclosure, willingness to escalate, and the assumption that clean practice IS the business model are what makes a long career possible."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 9;
