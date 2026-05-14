-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 16 CONTENT
-- Plan Presentation & Communication
-- ============================================================================
update public.modules set
  title = 'Plan Presentation & Communication',
  competency_id = 'OJL-7',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Present a complete financial plan in a way clients can absorb, remember, and act on — without drowning them in detail or hiding behind jargon.',
  learning_objectives = ARRAY[
    'Structure a plan presentation that leads with the client''s goals, not your analysis',
    'Build plan documents and slide decks that an intelligent non-expert can read alone',
    'Lead a presentation meeting with confidence, including for difficult news',
    'Handle questions, objections, and emotional reactions in real time',
    'Close the meeting with clear action steps, ownership, and follow-up dates'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Designing the Plan Document for the Client, Not the Planner",
        "summary": "Most financial plans are written for the planner who built them. The good ones are written for the client who has to read them — once, alone, sitting at the kitchen table.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A planning deliverable that the client cannot read alone has failed, no matter how technically excellent it is. The test for any plan document is: if the client looked at this six months from now without you in the room, could they tell what their situation is, what was recommended, and what their action items are? If yes, you have done the work. If no, you have produced a beautiful artifact that does not serve the client."},
          {"type": "subheading", "content": "The standard plan document structure"},
          {"type": "numbered", "items": [
            "Executive summary — one page, written last, captures the entire plan in a way a busy client can read in three minutes",
            "Goals as stated — what the client said they wanted, in their words and prioritized order",
            "Current financial position — net worth, cash flow, key balances, current account titles",
            "Key observations — what the analysis revealed, organized by topic not by spreadsheet",
            "Recommendations — clear, prioritized, with rationale and tradeoffs explained",
            "Implementation plan — who does what by when",
            "Appendices — full statements, projections, Monte Carlo runs, disclosure documents"
          ]},
          {"type": "callout", "kind": "key", "content": "Lead with goals, end with action. Everything in between is supporting the path from one to the other."},
          {"type": "subheading", "content": "The one-page executive summary"},
          {"type": "paragraph", "content": "The executive summary is the most important page of the document and should be written last. It captures, in order: who the client is (one sentence), what they came to plan for, what you found, what you recommend, and what happens next. A client should be able to read the executive summary alone and know whether to read the rest. If the summary cannot stand alone, the plan is not yet finished."},
          {"type": "subheading", "content": "Visual hierarchy and white space"},
          {"type": "list", "items": [
            "One major idea per page — do not pack pages with multiple topics",
            "Headings at the top of pages, not floating in the middle",
            "Tables and charts captioned with the takeaway, not just the data ('Net worth has grown 32% over three years' beats 'Net worth over time')",
            "Reading text at 11-12pt minimum — older clients especially should not have to squint",
            "Black ink on white pages for most content; reserve color for emphasis and brand consistency"
          ]},
          {"type": "subheading", "content": "Plain language commitment"},
          {"type": "paragraph", "content": "Every word of jargon in a plan document is a small invitation for the client to feel stupid or to disengage. Both are bad outcomes. Sweep through any draft and replace: 'asset allocation' becomes 'how your money is split between stocks, bonds, and other things'; 'tax-deferred' becomes 'taxes due later, not now'; 'Roth conversion' becomes 'paying tax now to make a chunk of your retirement money tax-free later.' Use industry terms only after you have established the plain English meaning, and only where the term itself is part of what the client needs to learn."},
          {"type": "callout", "kind": "do", "content": "Read the draft aloud as if you were the client. If you stumble on a sentence, rewrite it. If a sentence requires you to pause and explain to yourself, the client will not understand it either."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Presentation Meeting — Structure and Flow",
        "summary": "A good plan presentation is not just reading the document out loud. It is a designed experience that builds understanding, surfaces reactions, and ends in clear commitment.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The plan presentation meeting is usually 60 to 90 minutes. The temptation is to walk page by page through everything you produced. Resist. The client does not need a tour of your work. They need to understand their situation, understand your recommendations, and arrive at the end of the meeting with clarity about what to do next."},
          {"type": "subheading", "content": "The flow"},
          {"type": "numbered", "items": [
            "Reset the room (5 min) — reconnect, remind them why you are here, restate goals as they stated them",
            "Walk the current position (10-15 min) — net worth, cash flow, where their money is today",
            "Surface key findings (15 min) — three to five observations from the analysis, in order of importance",
            "Present recommendations (20-30 min) — what to do, in priority order, with rationale and tradeoffs",
            "Discuss and react (10-15 min) — open the floor, hear questions and objections, adjust where needed",
            "Close with action (5-10 min) — what happens next, who owns each step, when you talk again"
          ]},
          {"type": "subheading", "content": "Reset the room"},
          {"type": "paragraph", "content": "Open with the client's own goals in their own words, read back from the discovery meeting. This grounds the conversation in why you are here. Clients will sit through 75 minutes of analysis if they feel the analysis is in service of what they actually want. They will tune out in five minutes if they feel the meeting is about the planner's process."},
          {"type": "subheading", "content": "Walk the current position"},
          {"type": "paragraph", "content": "Before you present recommendations, the client and you need to share a picture of where they are now. Use the financial statements from Module 13. Walk net worth, walk cash flow, point out the biggest line items. Ask 'does this look like your situation?' and pause for the answer. Catching a missing $14,000 credit card balance in this conversation is much cheaper than discovering it after recommendations have been made."},
          {"type": "subheading", "content": "Surface key findings"},
          {"type": "paragraph", "content": "After current position, share three to five findings from your analysis. Not twenty. Three to five. Examples: 'You are over-allocated to a single employer's stock through your RSUs.' 'Your beneficiary designations are stale from before you got married.' 'You are funding a 529 before maxing the match on your 401(k).' Each finding sets up a recommendation. Each one should be a clean sentence the client can repeat to their spouse later."},
          {"type": "callout", "kind": "key", "content": "Findings are not the recommendations. They are the observations that justify the recommendations. Separating them keeps the logic clean."},
          {"type": "subheading", "content": "Present recommendations in priority order"},
          {"type": "paragraph", "content": "Lead with the highest-impact, easiest-to-implement recommendation. Build momentum. A client who agrees to three things in the first ten minutes is more likely to agree to the harder recommendation that comes after. A client who hears the hardest recommendation first may dig in and refuse everything that follows. Sequence intentionally."},
          {"type": "subheading", "content": "Tradeoffs explicitly named"},
          {"type": "paragraph", "content": "Every recommendation costs something. Maxing the 401(k) means less cash flow now. Paying off the auto loan early means less in the brokerage. A Roth conversion means a tax bill this year. Name the tradeoff every time. Clients who hear only the benefits become suspicious, or worse, surprised later when they see the cost. Clients who hear benefits and tradeoffs trust the recommendation more, even when they decline it."},
          {"type": "case_study", "title": "Marcus and Tasha at the presentation meeting", "scenario": "The apprentice opens with their stated goals: pay down debt, build emergency fund, fund college, retire at 60. Walks current position — including the $14,000 credit card balance surfaced in discovery. Three findings: (1) the rate on the credit card is the highest-cost thing in their financial picture; (2) Marcus's 401(k) match is being left on the table; (3) the 529 was started before either of those was addressed. Three recommendations in order: redirect the 529 contribution temporarily, capture the full match, attack the credit card aggressively. Tradeoff named: 529 will fall a year behind plan, recoverable later. Marcus and Tasha agree to all three in 45 minutes. The fourth and harder recommendation — raising the savings rate by 3% — comes after they have already said yes three times.", "discussion": "Notice the order. Easy wins first, hard ask last. Notice the explicit tradeoff. Notice that the recommendations all trace back to findings, which all trace back to stated goals. The presentation is not a sales pitch. It is a logical chain the clients can follow and own."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Delivering Difficult News",
        "summary": "Sometimes the analysis says things the client does not want to hear. The skill of delivering hard news without breaking trust is what separates apprentices from counselors.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Some of the most important sentences in this work are uncomfortable to say. 'You will not be able to retire at the age you planned.' 'The way you have been managing taxes has cost you significant money.' 'Your current allocation cannot survive a major drawdown.' 'The spending level you are describing is not sustainable.' Saying these things clearly, kindly, and with the next step ready is part of the practice. Hiding from them is malpractice."},
          {"type": "subheading", "content": "The structure of a difficult-news conversation"},
          {"type": "numbered", "items": [
            "Signal that something hard is coming — 'I want to walk through one finding that I think will be the most important conversation we have today'",
            "Deliver the news cleanly — no hedging, no jargon, no minimizing",
            "Give the client a moment — silence is appropriate; do not rush to fill it",
            "Acknowledge the emotion — name what you observe ('this is a lot to take in')",
            "Move to options — 'here are the levers we can pull' — never deliver bad news without a path forward",
            "Invite the client to choose the path — they decide, not you"
          ]},
          {"type": "subheading", "content": "Do not minimize"},
          {"type": "paragraph", "content": "When delivering hard news, the temptation is to soften it: 'It is probably not as bad as it sounds' or 'lots of clients are in this position.' These phrases protect the planner's discomfort, not the client. They also make the client distrust the data. Say it cleanly. The client can handle truth. They cannot handle a counselor who flinches."},
          {"type": "subheading", "content": "Do not catastrophize either"},
          {"type": "paragraph", "content": "The opposite mistake is loading the news with urgency that is not warranted. 'You are in serious trouble' when the client has time to course-correct creates fear without information. Calibrate to the actual situation: how big is the gap, what is the time horizon, what levers exist?"},
          {"type": "subheading", "content": "Always have the next step ready"},
          {"type": "paragraph", "content": "Never deliver bad news without options for what to do about it. If you have to say 'you cannot retire at 60 on your current trajectory,' you should be ready immediately with: 'Here are the four things we could do — work two more years, raise savings by X, lower spending target by Y, or accept higher probability of needing to adjust mid-retirement. We do not have to decide today.' The path forward turns a verdict into a problem the client can solve with you."},
          {"type": "case_study", "title": "The retiree who is overspending", "scenario": "A 71-year-old client has been drawing 7.5% of her portfolio annually for the last four years. The Monte Carlo run shows a 35% probability the plan fails by age 88. The apprentice does not soften: 'I want to walk through what we found, because it is important. At your current spending rate, our analysis shows about a 35% chance the portfolio runs short before age 88. I do not want you to find that out at 85. Here is what we can do: adjust spending by about $1,200 a month, sell the second car and reduce insurance and fuel, downsize the home in the next two years, or some combination of these. We have time to decide. Which of these is hardest to hear?' The client says the second car. The apprentice explores it without judgment.", "discussion": "Notice the clarity, the options, the pause, the invitation. The client is not lectured. The client is informed and then asked. By the end of the meeting the client has chosen a path that reduces spending by $850 a month — drawing from two of the three levers. The plan now projects 91% probability of success. The hard news became a solvable problem."},
          {"type": "callout", "kind": "do", "content": "If you cannot bring yourself to say the hard thing, you cannot do this job. Practice the sentences. Say them out loud before the meeting if you have to. The client deserves someone who can deliver truth with care."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Handling Questions, Objections, and Emotional Reactions",
        "summary": "The middle of a plan presentation is where it earns its keep. Real questions surface. Real objections come up. Real feelings arrive. Handle them well and the plan gets implemented.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If the client asks no questions during your presentation, they either understand everything or they have stopped engaging. The second is more likely. Build pauses into the presentation explicitly. 'Before I move on, what questions are coming up?' 'How is this landing for you?' Silence is not agreement. Silence is data."},
          {"type": "subheading", "content": "Types of questions and how to handle them"},
          {"type": "glossary", "terms": [
            {"term": "Clarifying questions", "definition": "The client wants to make sure they understood. Answer plainly and check that the answer landed. 'Did that make sense, or do you want me to explain it differently?'"},
            {"term": "Stress-test questions", "definition": "The client is testing the recommendation. 'What if the market drops 40%?' 'What if I lose my job?' Welcome these. Run the scenario if the data supports it."},
            {"term": "Skeptical questions", "definition": "The client is not convinced. 'Why this and not that?' Take the question seriously. If you do not have a good answer, do not bluff. 'That is a good question, let me get you a better answer before we decide.'"},
            {"term": "Emotional questions disguised as logical ones", "definition": "'But what if I want to retire earlier?' is sometimes a math question and sometimes an underlying anxiety. Listen to which."},
            {"term": "Sourced-elsewhere questions", "definition": "'My brother-in-law says I should buy gold.' Acknowledge the source, address the substance gently, do not insult the brother-in-law."}
          ]},
          {"type": "subheading", "content": "When clients object"},
          {"type": "paragraph", "content": "Objections are not the end of the conversation. They are the beginning. An objection means the client is engaged enough to push back — which is better than a silent nod followed by no implementation. The move when you hear an objection: slow down, do not defend, ask one open question."},
          {"type": "list", "items": [
            "'Tell me more about what is bothering you about that recommendation'",
            "'What would have to be true for that to feel like the right move?'",
            "'Help me understand what you are weighing'",
            "'Is there a piece of this I have not addressed yet?'"
          ]},
          {"type": "subheading", "content": "Adjusting in real time"},
          {"type": "paragraph", "content": "Sometimes the client raises something that genuinely changes the recommendation. The right response is not to defend the original plan. The right response is to incorporate the new information. 'Given what you just told me, I want to walk back to the recommendation on the 529 and think differently about it.' This is not weakness. This is fiduciary work — the recommendation should match the facts, and the facts just changed."},
          {"type": "subheading", "content": "When emotions surface"},
          {"type": "paragraph", "content": "Plan presentations can trigger emotion. A client may cry talking about a parent's terminal illness that affects estate plans. A spouse may get angry at the other spouse mid-meeting. A retiree may grieve realizing they have to keep working two more years. None of this is unprofessional. All of it is part of the work. Slow down, acknowledge what you observe ('I can see this is a lot'), let them have the moment, and continue when they are ready. Offer water. Offer to pause and resume later. Do not pretend you did not notice."},
          {"type": "callout", "kind": "warn", "content": "Never make a recommendation feel like a sales close. 'So can we get this implemented today?' lands wrong in a fiduciary relationship. The client should feel like the decision is theirs and the timeline serves them, not you."},
          {"type": "case_study", "title": "Devon pushes back on the line of credit", "scenario": "After the equipment financing conversation, the apprentice recommends Devon establish a $150,000 business line of credit at his bank to address the cash protection need. Devon resists: 'I do not want to owe the bank anything.' The apprentice does not argue. 'Tell me more about that — what is the feeling about owing the bank?' Devon describes a childhood watching his uncle's restaurant fail under bank debt. The apprentice acknowledges the experience, then offers a reframe: 'A line of credit you do not draw on costs you a small annual fee but creates optionality. It is not the same as debt — it is access to debt only if you decide to use it. What would feel different if you knew you could decide later?' Devon stays skeptical. The apprentice does not push. 'Let us hold the line of credit idea for now and come back to it after we work through the next set of recommendations. There is no rush.'", "discussion": "The apprentice noticed the emotion behind the objection, honored it, offered information, and then let go of the close. Devon will think about it. He may agree in the next meeting. He may not. Either way, the relationship and the rest of the plan are not at risk."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing the Meeting — Action, Ownership, Next Date",
        "summary": "A plan that ends with 'we will follow up soon' is a plan that does not get implemented. Close every meeting with specifics so the client knows exactly what happens next.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The last ten minutes of the meeting matter as much as the previous eighty. This is where commitment turns into action — or where action quietly evaporates because nobody specified who does what by when. Treat the closing of the meeting as a separate section of the agenda with its own time block."},
          {"type": "subheading", "content": "The action list — every item has three things"},
          {"type": "numbered", "items": [
            "What — a specific, concrete task in plain language",
            "Who owns it — exactly one person, named",
            "By when — a specific date, not 'soon' or 'this month'"
          ]},
          {"type": "paragraph", "content": "Examples that work: 'Tasha will pull last year's tax return and email a PDF to me by November 8.' 'I will draft the beneficiary change forms for both IRAs and send them for your signature by November 15.' 'Marcus will increase the 401(k) contribution from 6% to 9% in the employer's portal by November 22.' Each item is unambiguous. Each item has a single owner. Each item has a date. The whole list lives at the bottom of the executive summary and in your CRM."},
          {"type": "callout", "kind": "do", "content": "Read the action list aloud at the end of the meeting and ask the client to confirm each item. 'Tasha, you have the tax return by the 8th — does that work?' If they hesitate, find a better date now, not later."},
          {"type": "subheading", "content": "Document the meeting"},
          {"type": "paragraph", "content": "Within 24 hours, send a written meeting recap to the client that includes: what was discussed, what was decided, the action list with owners and dates, and the next meeting date. This serves three purposes: it gives the client a written reference, it triggers the action list (the recap email is often what makes the client actually do their tasks), and it creates a record for compliance. The recap should be plain English. Not a transcript. A clear summary."},
          {"type": "subheading", "content": "Set the next date before you leave the room"},
          {"type": "paragraph", "content": "The single biggest predictor of whether action items get done is whether a follow-up meeting is on both calendars. 'We will check in once you have done those things' is too vague. 'Let us put 30 minutes on the calendar for December 10 to review where you got' is concrete. Schedule it before the current meeting ends. Send the invite from the room if needed."},
          {"type": "subheading", "content": "Quality check — would the client tell their friend?"},
          {"type": "paragraph", "content": "After the meeting ends, ask yourself: if this client called their best friend tomorrow and said 'I just had my plan presentation,' would they describe a clear set of decisions and a path forward, or would they describe a confusing meeting with a lot of charts? The first is the goal. If you cannot picture the friend conversation going well, the meeting was not closed properly. Improve the close next time."},
          {"type": "case_study", "title": "Closing with Marcus and Tasha", "scenario": "After the 75-minute presentation, the apprentice spends the final 10 minutes on the action list. Six items: (1) Marcus increases 401(k) to 9% by Nov 22 in Fidelity portal; (2) Tasha pulls last year's tax return and emails to apprentice by Nov 8; (3) Tasha sets up auto-transfer of $400 bi-weekly to high-yield savings account by Nov 15; (4) Both sign updated beneficiary change forms for IRAs once apprentice sends by Nov 15; (5) Apprentice prepares 529 contribution pause memo and emails by Nov 12; (6) Both review and approve the written plan and sign the IPS by Nov 30. Next meeting set for December 14 at 4pm to review progress. Recap email sent the next morning. Five of six items completed by next meeting.", "discussion": "Not because Marcus and Tasha were unusually disciplined — because the action list was unambiguous, the owners were assigned, the dates were specific, and the recap arrived in writing. The structure produced the outcome."},
          {"type": "callout", "kind": "key", "content": "The presentation meeting does not end with a plan. It ends with the next action. Always."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: implementation. The plan has been presented and agreed to. Now somebody has to actually move the money, file the paperwork, change the beneficiaries, and coordinate with the CPA and attorney. Implementation & Coordination."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The single best test for a plan document is:", "options": ["The number of pages it contains", "Whether it includes Monte Carlo projections", "Whether the client can read it alone six months later and understand their situation, recommendations, and next steps", "Whether it uses industry-standard terminology throughout"], "correct": 2, "explanation": "A plan document that requires the planner present to be understood has failed. The standalone readability test is the right standard."},
        {"id": "q2", "prompt": "In a plan presentation, recommendations should be sequenced:", "options": ["Hardest first to get them out of the way", "In random order to keep the client engaged", "In priority order, with high-impact easy wins first to build momentum", "Alphabetically"], "correct": 2, "explanation": "Building momentum with easy agreements early makes harder recommendations later more likely to be accepted. Sequence intentionally."},
        {"id": "q3", "prompt": "When delivering difficult news, the right structure includes:", "options": ["Soften the news so the client does not get upset", "Signal something hard is coming, deliver cleanly, give a moment, acknowledge emotion, move to options, let client choose", "Move quickly past the hard part to keep momentum", "Avoid the hard news if possible"], "correct": 1, "explanation": "The structure protects both clarity and care. Never deliver bad news without options for what to do next."},
        {"id": "q4", "prompt": "A client says 'lots of clients must be in worse shape than us.' The planner's best response is to:", "options": ["Agree to make the client feel better", "Avoid the comparison and refocus on the client's specific situation and the path forward", "Compare to specific other clients", "Drop the difficult finding"], "correct": 1, "explanation": "Comparing to others, either to comfort or alarm, distracts from the client's actual situation. Refocus on what the analysis shows and the options available."},
        {"id": "q5", "prompt": "Every action item in a plan close should have:", "options": ["A category and a color code", "What, who owns it, and a specific date", "An expected return", "A signature"], "correct": 1, "explanation": "Specific task, single owner, concrete date. Without all three, action items decay."},
        {"id": "q6", "prompt": "When a client raises an objection during presentation, the most effective first move is to:", "options": ["Defend the recommendation with more data", "Slow down, do not defend, and ask one open question about the objection", "Move to the next topic", "Lower the recommendation"], "correct": 1, "explanation": "Objections are engagement. Open questions explore the underlying concern. Defense usually makes objections harder, not softer."},
        {"id": "q7", "prompt": "The plan document's executive summary should be:", "options": ["Written first, before the analysis", "Written last and able to stand alone as a summary the client can read in a few minutes", "Three or more pages with all detail", "Optional"], "correct": 1, "explanation": "The executive summary is written last because it captures the entire plan. It should be standalone-readable for the busy client."},
        {"id": "q8", "prompt": "In delivering difficult news, never:", "options": ["Be specific about the magnitude", "Deliver bad news without ready options for what to do about it", "Pause for the client to react", "Acknowledge the emotion"], "correct": 1, "explanation": "Bad news without options creates fear without agency. Always have the next-step levers ready before you open the conversation."},
        {"id": "q9", "prompt": "The standard plan document structure leads with:", "options": ["Detailed investment performance tables", "The client's goals as stated in their own words", "Disclosure documents", "The planner's credentials"], "correct": 1, "explanation": "Leading with client goals grounds everything that follows in the reason the work was done. Goals first, action last."},
        {"id": "q10", "prompt": "Within how long should a meeting recap be sent to the client after the presentation?", "options": ["A week", "24 hours", "30 days", "Only if requested"], "correct": 1, "explanation": "Within 24 hours preserves the freshness of the conversation and triggers the action list while commitment is high."},
        {"id": "q11", "prompt": "Tradeoffs in recommendations should be:", "options": ["Mentioned only if the client asks", "Named explicitly every time, including what the recommendation costs", "Hidden so the recommendation is more appealing", "Discussed only in the appendix"], "correct": 1, "explanation": "Naming the tradeoff every time builds trust and prevents surprises. Clients who hear both benefits and costs make better decisions and trust the counselor more."},
        {"id": "q12", "prompt": "If a client cries or shows strong emotion during a plan presentation, the right response is to:", "options": ["Pretend you did not notice and continue", "End the meeting immediately", "Slow down, acknowledge what you observe, let them have the moment, and continue when they are ready", "Tell them to stay focused on the numbers"], "correct": 2, "explanation": "Emotion is part of the work, not a disruption to it. Acknowledge gently, hold the moment, and continue when they are ready."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 16;
