-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 10 CONTENT
-- Client Discovery & Intake
-- ============================================================================
update public.modules set
  title = 'Client Discovery & Intake',
  competency_id = 'OJL-1',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'The first conversation. How to gather what you need without making a client feel interrogated, and why the qualitative information matters more than the quantitative.',
  learning_objectives = ARRAY[
    'Conduct a structured first meeting that builds trust and surfaces the right information.',
    'Distinguish quantitative discovery (numbers) from qualitative discovery (goals, values, fears).',
    'Use open-ended questions effectively and listen actively.',
    'Recognize and adapt to family dynamics, money scripts, and emotional history with money.',
    'Document a discovery meeting in a way that allows a colleague to pick up the file cleanly.',
    'Identify when to defer questions or split discovery across multiple meetings.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The First Meeting",
      "summary": "The structure that gets discovery right — and the mistakes that derail it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The first meeting with a client sets the tone for everything that follows. A good first meeting is half listening, half clarifying, and ends with both parties knowing exactly what happens next. A bad first meeting is half pitch, half data collection, and leaves the client wondering why they came." },

        { "type": "callout", "kind": "key", "title": "The frame", "text": "Discovery is not data entry. Discovery is <em>understanding a household well enough to give them advice that fits them</em>. The numbers matter, but they're the easy part — the bank statements will arrive whether or not the meeting went well. The qualitative information either gets surfaced in the first conversations or doesn't surface at all." },

        { "type": "heading", "text": "A working structure for the first meeting" },
        { "type": "numbered", "items": [
          "<strong>Welcome and orientation (5 min).</strong> Make them comfortable. Explain how the meeting will run, how long it will take, that they can stop or ask questions anytime.",
          "<strong>Their story (15–20 min).</strong> Open with the broadest possible question and listen. \"Tell me what's going on in your financial life right now\" or \"What brought you in?\" Resist the urge to redirect, even if they wander.",
          "<strong>Goals and concerns (15 min).</strong> Surface what they want, what they're worried about, what's keeping them up. Ask follow-ups, not just the next question on the form.",
          "<strong>Quick quantitative scan (10–15 min).</strong> Get high-level numbers — income, savings, debts, family structure. Detailed gathering happens later via documents.",
          "<strong>Family and life context (10 min).</strong> Children, parents, dependents, health, expected changes.",
          "<strong>How you work (5 min).</strong> Explain your firm, your fiduciary duty, fees, services. Don't sell — orient.",
          "<strong>Next steps (5 min).</strong> Document what they'll send you (statements, tax returns, plan documents), when the next meeting is, what it will cover.",
          "<strong>Disclosures and Form ADV (during meeting or at end).</strong> Required for compliance. Set expectations for documents that will arrive in their inbox."
        ]},

        { "type": "callout", "kind": "do", "title": "The two questions to ask in every first meeting", "text": "<strong>(1)</strong> \"What would have to be true a year from now for you to feel like working with us was a good decision?\" — surfaces real goals.<br/><strong>(2)</strong> \"Tell me about your relationship with money growing up.\" — surfaces money scripts that shape every financial decision." },

        { "type": "heading", "text": "What a good first meeting feels like — to the client" },
        { "type": "list", "items": [
          "They did more talking than the advisor.",
          "They were asked at least one question no one had asked them before.",
          "They left with a written list of what to send and when.",
          "They felt understood rather than processed.",
          "They are clear on what the next meeting will accomplish and when it is."
        ]},

        { "type": "callout", "kind": "warn", "title": "Mistakes that destroy first meetings", "text": "Reading off the intake form. Selling services in the first half of the meeting. Cutting the client off when they're telling a story that doesn't seem 'on topic' — those stories ARE the topic. Making recommendations before discovery is complete. Pretending to understand when you don't. Avoiding awkward questions about death, divorce, illness, or family conflict — these are exactly the questions that produce the most planning value." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Quantitative Discovery",
      "summary": "Numbers, sources, and the documents that tell the real story.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Numbers are the easier half of discovery. A standard set of documents tells you almost everything you need about a household's quantitative situation. The skill is knowing what to ask for, how to organize it, and what to do when something is missing." },

        { "type": "heading", "text": "The standard intake document set" },
        { "type": "subheading", "text": "Income and employment" },
        { "type": "list", "items": [
          "Most recent pay stubs (showing gross, deductions, net, year-to-date) for each working adult.",
          "Most recent two years of W-2s.",
          "Self-employment: most recent two years Schedule C or business return, year-to-date P&L.",
          "Variable income (RSU, bonus, commission): vesting schedules, recent annual statements.",
          "Pension and Social Security statements (if applicable)."
        ]},

        { "type": "subheading", "text": "Tax returns" },
        { "type": "list", "items": [
          "Most recent two years of federal and state returns, all schedules.",
          "If pending an extension or amendment, status of that.",
          "Any IRS or state correspondence open."
        ]},

        { "type": "subheading", "text": "Assets" },
        { "type": "list", "items": [
          "Bank statements (checking, savings, money market) — most recent.",
          "Investment account statements — all of them. Brokerage, retirement, education savings, HSA.",
          "Real estate: current value estimate, mortgage balance, original cost basis if available.",
          "Business interests: most recent valuation if applicable.",
          "Other significant assets: collectibles, art, cryptocurrency, private investments."
        ]},

        { "type": "subheading", "text": "Liabilities" },
        { "type": "list", "items": [
          "Mortgage statement(s) showing current balance, rate, term.",
          "Other loan statements (auto, student, personal).",
          "Credit card statements showing balances and rates.",
          "Any other debts (medical, tax debt, personal loans)."
        ]},

        { "type": "subheading", "text": "Insurance" },
        { "type": "list", "items": [
          "Life insurance: declarations pages of all policies.",
          "Disability insurance: policy documents and employer benefit summaries.",
          "Health insurance: current plan and recent annual benefit statement.",
          "Property/casualty: declarations pages for auto, homeowners/renters, umbrella.",
          "Other: long-term care, annuities, specialty coverages."
        ]},

        { "type": "subheading", "text": "Estate documents" },
        { "type": "list", "items": [
          "Will (current version, all amendments).",
          "Trust documents (if any).",
          "Powers of attorney — durable financial and healthcare.",
          "Advance directives.",
          "Beneficiary designations on retirement accounts and life insurance — most recent confirmations."
        ]},

        { "type": "callout", "kind": "do", "title": "The intake checklist", "text": "Every firm should have a standard intake checklist organized by category. Send it before the first meeting if possible, or after the first meeting with deadlines. Reduce it to one page when possible — long lists trigger procrastination. Follow up at one week, two weeks, four weeks if items aren't arriving." },

        { "type": "callout", "kind": "warn", "title": "What incomplete information signals", "text": "When a client can't or won't produce a routine document, take it seriously. Sometimes it's disorganization. Sometimes it's shame about the actual numbers (especially debt). Sometimes it's marital secrecy. Sometimes there's a problem the client hasn't admitted to themselves yet. The advisor's job is to notice and proceed gently — not to demand or to ignore." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Qualitative Discovery",
      "summary": "Money scripts, family dynamics, and the questions that produce real insight.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Qualitative discovery is the harder half. It asks: <em>what does this household actually want, what are they afraid of, and what shapes their decisions?</em> No spreadsheet answers these questions. They emerge through conversation, careful listening, and questions that go beneath the surface." },

        { "type": "heading", "text": "Money scripts" },
        { "type": "paragraph", "text": "Coined by financial psychologists Brad and Ted Klontz, money scripts are unconscious beliefs about money formed in childhood and carried into adulthood. They shape financial behavior more than income does. Four common scripts:" },
        { "type": "list", "items": [
          "<strong>Money avoidance</strong> — money is bad, dirty, corrupting. Rich people are immoral. Result: subconscious sabotage of wealth-building. Underearning despite capability.",
          "<strong>Money worship</strong> — more money will solve life's problems. Happiness comes from accumulation. Result: workaholism, chronic dissatisfaction, debt to fund lifestyle.",
          "<strong>Money status</strong> — net worth equals self-worth. Spending signals identity. Result: lifestyle inflation, financial decisions driven by appearance.",
          "<strong>Money vigilance</strong> — money should be saved, not spent. Discussing finances is taboo. Generally the healthiest script, though extreme cases produce miserliness and inability to enjoy wealth."
        ]},
        { "type": "callout", "kind": "key", "title": "The advisor's role", "text": "You don't change a client's money scripts in a single meeting. You recognize them. The 60-year-old physician who 'doesn't deserve' to retire despite millions in assets is operating on a money script, not on numbers. The recently-promoted executive who immediately upgrades the house, the car, and the lifestyle is operating on a script too. Knowing the script shapes which recommendation will actually land." },

        { "type": "heading", "text": "Questions that surface qualitative information" },
        { "type": "subheading", "text": "About values and goals" },
        { "type": "list", "items": [
          "If money were no object, what would you do with the next ten years?",
          "What's a recent purchase that brought you real, lasting satisfaction?",
          "What do you wish you had more time for?",
          "What does \"enough\" look like for you?",
          "What's something you'd want to leave behind?"
        ]},

        { "type": "subheading", "text": "About fears" },
        { "type": "list", "items": [
          "What's the financial concern that wakes you up at 3 AM?",
          "What's the worst-case scenario you find yourself preparing for?",
          "What financial conversation are you avoiding?",
          "What would have to happen for things to go really wrong?"
        ]},

        { "type": "subheading", "text": "About the past" },
        { "type": "list", "items": [
          "Tell me about your relationship with money growing up.",
          "Did your parents argue about money? Talk about it?",
          "What's the best money decision you've ever made?",
          "What's a money mistake you'd want to avoid making again?"
        ]},

        { "type": "subheading", "text": "About family" },
        { "type": "list", "items": [
          "Who else has a stake in these decisions? Spouse, children, parents?",
          "Are there conversations happening at home about this we should know about?",
          "Are there family members who depend on you financially? Or might in the future?",
          "Has there been a financial event in your family — inheritance, business sale, illness — that shaped how you think about money now?"
        ]},

        { "type": "callout", "kind": "do", "title": "The technique that matters most", "text": "<strong>Silence after the question.</strong> Most advisors fill the silence after an open-ended question, robbing the client of the space to think and answer fully. Ask, then wait. The client's first answer is often surface-level; the second is often the real answer. The silence is what produces the second answer." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Family Dynamics and the Couple's Meeting",
      "summary": "When you're advising a household, you're advising a relationship.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients are not individuals — they're households. And household financial decisions are made by relationships, not by spreadsheets. A counselor who can read the relationship dimension produces planning that actually gets implemented." },

        { "type": "heading", "text": "The couple in the first meeting" },
        { "type": "subheading", "text": "Things to notice" },
        { "type": "list", "items": [
          "Who's doing the talking? Often one spouse handles money and the other defers. This isn't necessarily bad, but it's information about how decisions get made.",
          "Where do they disagree? Watch for body language when one answers a question — eye rolls, slight shake of the head, a look between them. Pause and ask: 'I get the sense you two might see this a little differently — am I right?'",
          "What language do they use? 'My money' vs. 'our money' is a window into the relationship structure, especially in second marriages.",
          "Who's anxious about what? Common pattern: one spouse worries about market risk, the other worries about not having enough."
        ]},

        { "type": "callout", "kind": "key", "title": "The seven topics couples disagree about", "text": "Most couples have at least one fundamental disagreement about: (1) <strong>how much risk is acceptable</strong>, (2) <strong>how much to give to adult children</strong>, (3) <strong>when to retire</strong>, (4) <strong>where to live in retirement</strong>, (5) <strong>how generous to be with charity</strong>, (6) <strong>how to handle aging parents</strong>, (7) <strong>what to leave to heirs</strong>. Get these surfaced early. The plan that ignores them isn't a plan — it's a paper exercise that breaks the first time real money is at stake." },

        { "type": "heading", "text": "When to recommend separate conversations" },
        { "type": "paragraph", "text": "Most discovery should happen with both spouses present. Some moments call for one-on-one conversation:" },
        { "type": "list", "items": [
          "Disclosure of past financial issues (debt, addiction, prior bankruptcy) the client may not have shared with the spouse.",
          "Disclosure of impending changes (job loss, intent to leave the marriage, health concerns).",
          "Family financial issues affecting one spouse's parents or siblings.",
          "Disagreements between spouses that are too charged to work through in front of each other."
        ]},
        { "type": "callout", "kind": "warn", "title": "The boundary", "text": "If a client tells you something privately that materially affects the planning — for example, an affair, a plan to divorce, a hidden account — you have a real ethical problem. You cannot plan honestly for the household while holding undisclosed information that would change the recommendations. Most firms have specific policies on this; know yours and consult compliance. The general principle: gently encourage disclosure, document the conversation, and decline to proceed on plans that depend on the undisclosed information." },

        { "type": "divider" },

        { "type": "heading", "text": "Multi-generational dynamics" },
        { "type": "paragraph", "text": "Increasingly, advisory engagements involve multiple generations: adult children advising aging parents, parents trying to help adult children, grandparents funding grandchildren's education. Each pattern has its own complexity." },
        { "type": "subheading", "text": "Common dynamics" },
        { "type": "list", "items": [
          "<strong>Adult child overstepping.</strong> Well-meaning child making decisions for capable parent. Watch for the autonomy of the actual client.",
          "<strong>Hidden caregiving costs.</strong> One adult child carrying most of the load for elderly parents; that cost rarely shows up in the parents' net worth statement.",
          "<strong>Inheritance expectations.</strong> Adult children making spending decisions based on expected inheritance that the parents have no intention of leaving them (or vice versa).",
          "<strong>Grandparent education funding.</strong> Generous but sometimes structured in ways that complicate financial aid, gift tax, or family relationships."
        ]},

        { "type": "case_study",
          "title": "The discovery meeting that surfaces what matters",
          "scenario": "A married couple comes in. He talks about retirement planning, target portfolio returns, the inheritance they'll receive from his mother eventually. She is quiet through most of the meeting. Toward the end you ask her: 'I'd love to hear what you most want to be true ten years from now.' She pauses, then says: 'I want to know that if something happens to him, I won't have to figure out the money alone.'",
          "discussion": "<p>In one sentence, the entire discovery just shifted. The plan he wants is about wealth accumulation. The plan she needs is about financial autonomy and her ability to manage the household alone if necessary.</p><p>A planner who builds the portfolio he asked for and skips her concern produces a 'plan' that completely misses what would make this a successful engagement for the household. The right move: pause, acknowledge what she just said, ask follow-ups (\"What would it look like for you to feel confident? What do you wish you knew that you don't?\"), and build her requirements explicitly into the goals.</p><p>The deliverable for this couple includes everything he wanted PLUS structures that make her financial life manageable on her own — simpler portfolios, named contingent contacts, clear documentation of what to do and who to call, regular check-ins with her specifically. <strong>This is what \"financial planning is half listening\" actually means in practice.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Documentation and Handoff",
      "summary": "How to leave a trail that lets a colleague pick up the file at any moment.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "The work of discovery is only as good as the documentation of it. A 90-minute meeting in your head is worth nothing two months later when you can't remember the details. The discipline of writing things up — promptly, completely, in your own words — is what makes discovery durable." },

        { "type": "heading", "text": "The discovery memo" },
        { "type": "paragraph", "text": "Within 24 hours of the meeting, capture in writing:" },
        { "type": "list", "items": [
          "<strong>Date, time, attendees.</strong>",
          "<strong>Format.</strong> In-person, video, phone.",
          "<strong>Top-line summary.</strong> One paragraph: who they are, what they want, where they are now, what's next.",
          "<strong>Quantitative snapshot.</strong> Income, current net worth, major assets, major debts. Note sources for each number.",
          "<strong>Goals.</strong> In their words first, then in planning terms. Time-bound when possible.",
          "<strong>Concerns and constraints.</strong> What worries them, what's off the table, what's non-negotiable.",
          "<strong>Family and life context.</strong> Marital status, dependents, parents, expected life changes.",
          "<strong>Money story.</strong> Brief — what came up about their relationship with money.",
          "<strong>Discovery gaps.</strong> What you didn't get to, what you still need to learn.",
          "<strong>Documents requested and status.</strong> What they're sending you and when.",
          "<strong>Next steps and next meeting.</strong> Scheduled or pending.",
          "<strong>Open issues for follow-up.</strong> Things flagged that need attention later."
        ]},

        { "type": "callout", "kind": "do", "title": "Capture impressions, not just facts", "text": "Good discovery memos include things like: 'She seemed visibly uncomfortable when discussing her mother's care needs — likely a sensitive area to revisit gently.' Or: 'He emphasized risk avoidance three times despite an aggressive current portfolio — possible mismatch between stated and actual tolerance.' These observations are planning gold and disappear if not captured." },

        { "type": "heading", "text": "The handoff principle" },
        { "type": "paragraph", "text": "Imagine you're hit by a bus tomorrow and a colleague has to take over this engagement. Can they read your files and continue the work with the client experiencing minimal disruption? If yes, your documentation is good enough. If no, fix it." },

        { "type": "callout", "kind": "key", "title": "Why this matters beyond bus accidents", "text": "Discovery files are read by: future-you in six months, a colleague covering during your vacation, the team lead reviewing the case, compliance during periodic audits, and (rarely) regulators in a complaint. Each of these readers needs to understand what happened and why. The discipline of documenting for those readers is the same discipline that protects your career, serves the client, and makes the firm professional." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the primary purpose of a first discovery meeting?",
        "options": [
          "Sell the firm's services.",
          "Collect the standard data set in the intake form.",
          "Understand the household well enough to advise them — surfacing both quantitative AND qualitative information.",
          "Make initial recommendations."
        ],
        "correct": 2,
        "explanation": "Discovery is about understanding, not data entry or selling. Documents will arrive whether or not the meeting goes well. Qualitative information (goals, fears, money scripts) either surfaces in conversation or doesn't surface at all."
      },
      {
        "id": "q2",
        "prompt": "Which two questions are most powerful in a first meeting?",
        "options": [
          "What's your risk tolerance? What's your income?",
          "What would have to be true a year from now for this to feel like a good decision? Tell me about your relationship with money growing up.",
          "What's your net worth? What's your time horizon?",
          "Have you worked with an advisor before? What did you not like?"
        ],
        "correct": 1,
        "explanation": "These two questions surface real goals (vs. surface answers) and money scripts (vs. behavior alone). Both produce information no standardized form will."
      },
      {
        "id": "q3",
        "prompt": "What is a 'money script'?",
        "options": [
          "A budget spreadsheet template.",
          "An unconscious belief about money formed in childhood that shapes adult financial behavior.",
          "The script a salesperson uses to close.",
          "A note on a check or wire transfer."
        ],
        "correct": 1,
        "explanation": "Money scripts (Klontz & Klontz) — money avoidance, money worship, money status, money vigilance — shape decisions more than income does. A counselor doesn't change a script in one meeting, but recognizing it shapes which recommendations will actually land."
      },
      {
        "id": "q4",
        "prompt": "After asking an open-ended question, what is the most important technique?",
        "options": [
          "Ask the next question immediately.",
          "Summarize what they said before they finish.",
          "Stay silent. Wait. Give them space to give a deeper second answer.",
          "Take notes loudly so they can see you're engaged."
        ],
        "correct": 2,
        "explanation": "Most advisors fill the silence after an open-ended question, robbing the client of space to think. Ask, then wait. The first answer is often surface; the second is often the real answer."
      },
      {
        "id": "q5",
        "prompt": "When a client can't or won't produce a routine document during intake (like a recent tax return), the most appropriate response is:",
        "options": [
          "Demand it immediately or refuse to continue.",
          "Ignore it and proceed with planning.",
          "Notice it, take it seriously — it may indicate shame, marital secrecy, or unresolved issues — and proceed gently while documenting.",
          "Drop the client; they're not serious."
        ],
        "correct": 2,
        "explanation": "Missing documents often signal something real beneath the surface — debt the client hasn't admitted to, marital secrecy, or a problem they haven't acknowledged. The advisor's job is to notice, not demand or ignore. Proceeding gently while watching for patterns is the right approach."
      },
      {
        "id": "q6",
        "prompt": "In a couples' first meeting, what is the right move when you notice one spouse subtly disagreeing with the other's answer?",
        "options": [
          "Ignore it and continue with the agenda.",
          "Press them to argue it out.",
          "Pause and ask: 'I get the sense you two might see this a little differently — am I right?' — surfacing the disagreement gently.",
          "Recommend they go to counseling."
        ],
        "correct": 2,
        "explanation": "Disagreements that get hidden in discovery become plan failures later. A gentle, named question opens the door without forcing an argument. Couples generally appreciate being seen accurately."
      },
      {
        "id": "q7",
        "prompt": "Which is NOT one of the seven topics couples commonly disagree about?",
        "options": [
          "How much risk is acceptable.",
          "When to retire.",
          "How much to give to adult children.",
          "Which mutual funds to buy."
        ],
        "correct": 3,
        "explanation": "The seven common disagreements: risk tolerance, support for adult children, retirement timing, retirement location, charity, aging parent decisions, and inheritance. Mutual fund selection is downstream — it's a product decision, not a values disagreement."
      },
      {
        "id": "q8",
        "prompt": "When a client privately tells you something they haven't shared with their spouse that would materially affect the planning (hidden debt, plans to divorce, hidden account), the right action is:",
        "options": [
          "Plan with the information, but keep the secret.",
          "Tell the spouse immediately.",
          "Gently encourage disclosure, document the conversation, decline to proceed on plans that depend on the undisclosed info, and consult firm compliance policy.",
          "Refuse to plan for the household at all."
        ],
        "correct": 2,
        "explanation": "Planning honestly while holding undisclosed material information is an ethical violation. The right path: encourage disclosure, document, refuse to build plans that depend on hidden information, and engage firm compliance. Know your firm's specific policy."
      },
      {
        "id": "q9",
        "prompt": "When should the discovery memo be written?",
        "options": [
          "Whenever there's time.",
          "Within 24 hours of the meeting, while memory is fresh.",
          "Quarterly, in batch.",
          "Only if requested by compliance."
        ],
        "correct": 1,
        "explanation": "Within 24 hours. Details fade fast. The 90-minute meeting that lives in your head Monday is half gone by Friday. The discipline of writing things up promptly is what makes discovery durable across time."
      },
      {
        "id": "q10",
        "prompt": "A good discovery memo includes:",
        "options": [
          "Only the verified quantitative numbers.",
          "Quantitative snapshot, goals, concerns, family context, money story, gaps, next steps, and YOUR impressions — including observations that flag sensitive areas.",
          "Just a list of documents received.",
          "Only what compliance requires."
        ],
        "correct": 1,
        "explanation": "Facts and impressions both. Notes like 'visibly uncomfortable discussing her mother's care' or 'emphasized risk avoidance despite an aggressive portfolio' are planning gold. Capture them while fresh."
      },
      {
        "id": "q11",
        "prompt": "A counselor's documentation should be good enough that:",
        "options": [
          "The client never has to repeat themselves.",
          "A colleague could pick up the file tomorrow and continue serving the client with minimal disruption.",
          "The compliance officer is happy.",
          "All of the above — but especially (B)."
        ],
        "correct": 3,
        "explanation": "All three are true, but the colleague-handoff test is the strongest version of the standard. If your files survive that test, they also satisfy the others — and they protect both the client and your career across vacations, departures, and reviews."
      },
      {
        "id": "q12",
        "prompt": "A client says she wants 'to know that if something happens to him, I won't have to figure out the money alone.' What does this require of the plan?",
        "options": [
          "Higher portfolio returns.",
          "Structures that make her financial life manageable on her own — simpler portfolios, named contacts, clear documentation, separate check-ins with her.",
          "More insurance on him.",
          "Estate planning documents only."
        ],
        "correct": 1,
        "explanation": "Her goal isn't returns — it's autonomy. The plan must build for her ability to manage independently if needed. This is qualitative discovery shaping concrete recommendations: simpler structures, documentation she can use, contact protocols, and meetings designed around her engagement. Missed by an advisor who only listens to the spouse who talks more."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 10;
