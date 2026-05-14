-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 18 CONTENT
-- Ongoing Reviews & Life Events
-- ============================================================================
update public.modules set
  title = 'Ongoing Reviews & Life Events',
  competency_id = 'OJL-9',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Move from a one-time plan to a continuing relationship — building a review cadence, watching for life events that change the plan, and adapting without losing continuity.',
  learning_objectives = ARRAY[
    'Design a review cadence that matches client complexity and stage of life',
    'Lead an effective annual review that surfaces what has changed and what should change',
    'Recognize the life events that require plan changes — and the ones that do not',
    'Handle estate-relevant life events (death, divorce, disability) with care and competence',
    'Maintain continuity in the relationship across years and transitions'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "From One-Time Plan to Continuing Relationship",
        "summary": "The first 90 days deliver the plan. The next thirty years deliver the value. Building a relationship structure that lasts is the real work.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Financial planning is not a project with an end date. It is a relationship that lasts decades. The plan you build in year one is a snapshot. The plan that actually serves the client is the moving body of work that adapts as their life changes — new jobs, marriages, divorces, children, inheritances, business sales, health events, deaths. The counselor who sees clients only once a year and produces an annual report has built a thin relationship. The counselor who has rhythm with the client across the year, knows what is coming, and adapts as life happens has built something different."},
          {"type": "callout", "kind": "key", "content": "Plans do not fail because the math was wrong. Plans fail because life changed and nobody updated the plan."},
          {"type": "subheading", "content": "The continuing relationship has structure"},
          {"type": "paragraph", "content": "A well-structured ongoing relationship has at least three components: a scheduled review cadence (annual at minimum, more often for complex clients), trigger-based touchpoints (calls or meetings when something material changes), and ambient communication (regular brief updates, market context when warranted, year-end planning reminders). The cadence is set at the start and adjusted as the client's situation evolves. A 35-year-old accumulator with a stable W-2 does not need the same cadence as a 68-year-old business seller in transition."},
          {"type": "subheading", "content": "Typical cadences by client stage"},
          {"type": "list", "items": [
            "Early accumulator (20s-30s, simple situation) — annual review, ad hoc check-ins around major decisions",
            "Mid-career complex (40s-50s, multi-account, business owner, or pre-retirement) — semi-annual reviews, quarterly informal touch",
            "Pre-retirement (3-5 years before retirement) — semi-annual reviews with explicit retirement countdown, more frequent in the final year",
            "Recently retired (first 5 years) — semi-annual reviews to dial in the withdrawal strategy as it meets reality",
            "Mature retirement (steady-state) — annual review, more often if health or longevity events are surfacing",
            "Transition periods (divorce, business sale, recent widow/widower) — weekly to monthly for the duration of the transition, then taper"
          ]},
          {"type": "subheading", "content": "Cadence is not the same as 'check the boxes'"},
          {"type": "paragraph", "content": "An annual review that consists of a custodian-generated performance report and twenty minutes of small talk is not a review. It is theater. A real review surfaces what has changed in the client's life, what has changed in the plan, what needs to change going forward, and what the client should expect over the next year. If you cannot answer 'what did we accomplish in that meeting' with three specific things, the meeting was not used well."},
          {"type": "subheading", "content": "Building the relationship account"},
          {"type": "paragraph", "content": "Every interaction with a client is a small deposit or withdrawal from the relationship. Calls returned promptly are deposits. Forgotten birthdays of the client's children that the client mentioned years ago are withdrawals. Remembered details — the client's recent surgery, the kid who started college, the parent who passed — are large deposits. The cumulative effect over a decade is the difference between a counselor the client describes as 'my advisor who manages my money' and one they describe as 'someone I trust completely with everything.'"},
          {"type": "callout", "kind": "do", "content": "After every client interaction, take 60 seconds and add one or two human details to the CRM. The client's golden retriever's name. The kid's college. The travel plans they mentioned. A year from now you will remember to ask, and that question will be the most important thing you do that meeting."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Annual Review — Structure, Preparation, Execution",
        "summary": "An annual review well-led is more valuable than the first plan that produced it. Here is how to do one that actually moves the relationship and the plan forward.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The annual review is the most important single meeting in most client relationships. It is the moment where the past year is reckoned with and the next year is shaped. Done well, it generates clarity, surfaces issues early, and produces a refreshed action list. Done poorly, it becomes a perfunctory 'everything is on track' that papers over the actual situation."},
          {"type": "subheading", "content": "Preparation — what you do before the meeting"},
          {"type": "numbered", "items": [
            "Pull current financial statements — updated net worth and cash flow",
            "Run a fresh projection — has the trajectory changed from last year's expectations?",
            "Review the action items from the last meeting — what was done, what slipped, what is still open",
            "Review any communications during the year — what did the client tell you about that should inform the review?",
            "Pull any data the client may have shared — recent tax return, salary changes, new debts, life events",
            "Scan the markets and the macro — what context might the client be carrying into the meeting?",
            "Note any compliance, tax, or law changes that affect the client"
          ]},
          {"type": "subheading", "content": "Open the meeting on a personal note"},
          {"type": "paragraph", "content": "Do not lead with 'let me walk through your performance.' Lead with the client. 'How was your year overall — what stands out?' This opens space for the things you need to know about (a new job, a parent's illness, a kid's surprise college acceptance) that may not have surfaced in routine touches. Spend the first ten minutes here. If something significant has happened, you will need to restructure the rest of the meeting around it. Better to know early."},
          {"type": "subheading", "content": "The five-section agenda"},
          {"type": "numbered", "items": [
            "What changed for you this year? (10 min) — personal, professional, family, health",
            "Where you are now (10 min) — net worth, cash flow, progress against goals",
            "Did the plan do what it was supposed to? (15 min) — performance, withdrawals, savings, projections",
            "What needs to change for next year? (15 min) — recommendations driven by what was surfaced",
            "Action items and next meeting (10 min) — owners, dates, follow-up"
          ]},
          {"type": "subheading", "content": "Did the plan do what it was supposed to?"},
          {"type": "paragraph", "content": "This section is not 'how did the market do.' It is 'how did the plan do.' The plan was designed to accomplish certain things — fund savings, hit certain account balances, provide a certain income, maintain a certain risk level. Walk through whether each expected thing happened. If the client was supposed to save $24,000 to the IRA and Roth IRA combined and only $18,000 was saved, that is the conversation, not the S&P 500's return. Performance matters — but in context of the plan, not in isolation."},
          {"type": "subheading", "content": "What needs to change for next year?"},
          {"type": "paragraph", "content": "Based on what surfaced in sections 1 and 2 and what worked or did not work in section 3, make specific recommendations for the next year. Sometimes there are none — the plan is on track, the client's life is stable, the right move is to keep doing what is working. Sometimes there are many — a new job changes contribution capacity, a paid-off mortgage frees cash flow, a child's college is now four years closer. Whatever the recommendations, they should trace back to what was discussed in the meeting, not appear from nowhere."},
          {"type": "case_study", "title": "Marcus and Tasha's first annual review", "scenario": "One year after the initial plan presentation. Marcus and Tasha sit down with their apprentice for the annual review. The personal opening surfaces: Tasha's mother had a stroke six months ago — Tasha has been her caregiver and the family has spent ~$8,000 on home modifications and medical equipment. The financial section: credit card paid off, emergency fund at $7,200 (target was $9,000 — caregiving costs slowed progress), 401(k) contribution at 9% as planned, 529 still paused. Plan section: progress is real but slower than projected. Recommendations: continue paused 529 for another six months, hold emergency fund target steady (do not push to $12,000 yet), discuss long-term care planning for Tasha's mother as a separate workstream, surface the question of how the mother's care affects retirement timing.", "discussion": "Without the personal opening, the apprentice would have walked through numbers and recommended raising the 529 contribution — completely missing that Tasha is providing meaningful family caregiving. The recommendation set is now responsive to the actual life the clients are living, not to the spreadsheet."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Recognizing Life Events That Change the Plan",
        "summary": "Some life events require plan changes. Some do not. Knowing which is which — and acting promptly when one does — is core counselor judgment.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Life events fall on a spectrum. At one end are events that fundamentally change the plan: marriage, divorce, the birth of a child, death of a spouse, a major inheritance, a business sale, a significant disability, retirement itself. At the other end are events that feel big in the moment but do not actually require plan changes — a normal market drawdown, a missed bonus, a friend's bad financial advice. Calibrating which is which is judgment. Acting promptly when a real life event happens is non-negotiable."},
          {"type": "subheading", "content": "Major life events and what they typically require"},
          {"type": "glossary", "terms": [
            {"term": "Marriage", "definition": "Beneficiary review across all accounts, estate document update (will, POAs, healthcare directives), tax filing status review, insurance review (spouse covered, life insurance amounts), potential consolidation of accounts."},
            {"term": "Divorce", "definition": "QDRO for retirement plan division, beneficiary updates urgent, new will/trust, separate accounts re-established, cash flow reset for new household, often a year of close support."},
            {"term": "Birth/adoption of a child", "definition": "529 plan considered, life insurance review (term coverage often increases), guardian designation in will, possibly umbrella liability coverage."},
            {"term": "Death of a spouse", "definition": "Surviving-spouse rollovers, beneficiary cash flow assessment, Social Security survivor planning, estate administration, often six to twelve months of intensive support and decisions deferred where possible."},
            {"term": "Major inheritance", "definition": "Step-up basis valuation if inherited assets, qualified vs non-qualified inherited accounts each have own rules (SECURE Act 10-year window for most non-spouse inherited retirement accounts), tax planning urgent, behavioral support around the money."},
            {"term": "Business sale", "definition": "Tax planning (QSBS Section 1202, installment sales, earnouts), wealth management transition from concentrated business owner to diversified investor, estate planning review, often a multi-year project."},
            {"term": "Disability", "definition": "Disability insurance benefits coordination, Social Security disability if applicable, cash flow restructure, possible Special Needs Trust if permanent, estate plan review for capacity considerations."},
            {"term": "Retirement", "definition": "Cash flow transition from earned income to portfolio withdrawals, Social Security start decision, Medicare enrollment (turning 65), tax bracket management for early retirement years, withdrawal sequencing across account types."},
            {"term": "Job change", "definition": "Old 401(k) decision (leave, roll to new plan, roll to IRA), new benefits package review, salary change effect on savings rate, equity compensation if applicable, stock option/RSU treatment."}
          ]},
          {"type": "subheading", "content": "Events that look big but usually do not require plan changes"},
          {"type": "list", "items": [
            "A market drawdown — the plan was built assuming this would happen periodically",
            "A missed bonus — annual variability is part of the cash flow plan, not an anomaly unless persistent",
            "A friend's investment advice that conflicts with the plan — usually a conversation, not a plan change",
            "Short-term media noise (this election, this tax proposal, this crisis) — almost never requires a change in long-term allocation"
          ]},
          {"type": "callout", "kind": "warn", "content": "The hardest moment of judgment is when the client believes a non-event is an event and wants to change the plan. Push back gently. 'Let us not change the plan in response to this. Let us put it on the agenda for our next scheduled review and decide with a calmer head.'"},
          {"type": "subheading", "content": "When the client tells you about a life event"},
          {"type": "paragraph", "content": "When a client mentions a life event — even casually, even at the end of a meeting about something else — pause. Do not let it slip past. 'You mentioned your father moved in with you. Help me understand what is changing there.' Then schedule a dedicated conversation if the event warrants it. Some events warrant a meeting within a week. Some warrant a meeting within a month. Almost no event warrants 'we will get to that at the annual review' if the annual review is more than 90 days away."},
          {"type": "case_study", "title": "Devon's business sale", "scenario": "Devon, the small business owner from prior modules, calls the apprentice to mention he received an unsolicited offer to acquire his business at a price that would net him about $4.2M after taxes. The apprentice does not try to handle this in a phone call. They schedule a 90-minute meeting for that week, prepare by pulling Devon's financials and reviewing QSBS eligibility, recommend Devon engage a business attorney and a transaction-experienced CPA, and outline the multi-year wealth planning that will be needed if the sale proceeds. Devon's sale ultimately closes nine months later. The relationship and the plan are transformed.", "discussion": "Devon was a comfortable mid-six-figure client. Post-sale he is a wealth management client. The apprentice's recognition that this was a major life event — not a hypothetical to discuss whenever convenient — set up everything that followed. Speed and structure of response matter."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Handling Estate Events — Death, Disability, Divorce",
        "summary": "Three life events deserve their own treatment because of their emotional weight and operational complexity. Doing them well is what counselors are made for.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Death of a client, severe disability, and divorce are among the hardest situations a counselor will work through. The financial work is real and consequential. The human work alongside it — sitting with grief, navigating family dynamics, witnessing the worst chapters of someone's life — is real too. Be ready for both. Decline neither."},
          {"type": "subheading", "content": "When a client dies"},
          {"type": "numbered", "items": [
            "First contact is usually from the surviving spouse, an adult child, or the executor — within days of death",
            "Do not push for decisions in the first 30 days unless legally required (RMDs in year of death, certain tax-elective items)",
            "Death certificates — surviving family needs multiple originals; help guide where to order them",
            "Account-level work: each retirement account, brokerage, bank account, insurance policy has its own claims process; build a master tracker for the survivor",
            "Surviving spouse rollover — surviving spouse inheriting an IRA can typically roll it to their own IRA, treating it as their own (with their own RMD age and rules), which is usually preferred",
            "Non-spouse inherited retirement accounts — SECURE Act generally requires distribution within 10 years (with some exceptions), planning the withdrawal across the 10 years to manage tax brackets is part of the work",
            "Social Security survivor benefits — file with SSA, coordinate timing with the survivor's own benefits",
            "Estate administration coordinates with the attorney — probate where applicable, trust administration where applicable",
            "Cash flow reset for the survivor — household income often drops significantly; new plan needed"
          ]},
          {"type": "callout", "kind": "do", "content": "When a client dies, send a handwritten condolence note. Not an email. Not a card from the firm. From you, signed by you. The smallest gesture is the largest signal."},
          {"type": "subheading", "content": "When a client experiences a major disability"},
          {"type": "paragraph", "content": "Disability creates cash flow disruption (lost earned income), often new expenses (medical, equipment, home modifications, ongoing care), and sometimes capacity questions. Work in sequence: stabilize cash flow first (disability insurance benefits if any, possibly Social Security disability, drawing from emergency reserves), then assess the medium-term picture (return to work timeline, severity of impairment), then update the long-term plan. If capacity is impaired, the durable power of attorney becomes active — confirm it is in place and the agent knows. If a Special Needs Trust may be needed (for ongoing support without disqualifying from means-tested benefits), engage the attorney early."},
          {"type": "subheading", "content": "When clients divorce"},
          {"type": "paragraph", "content": "Divorce is the financial event most commonly mishandled by advisors. Both spouses were your clients. Now one or both will not be. The fiduciary duty does not disappear during the divorce. Common rules: stop making changes to joint accounts without both signatures, refer the spouses to separate counsel (yours and a separate advisor for the spouse who will leave), avoid being drawn into the legal or emotional fight, and prepare for the operational work — QDRO for retirement plan division, beneficiary updates that are now urgent, new wills, new accounts, new tax filing status."},
          {"type": "list", "items": [
            "QDRO (Qualified Domestic Relations Order) — the legal instrument required to divide an ERISA-qualified retirement plan in divorce; must be drafted by attorney and accepted by plan administrator",
            "Beneficiary updates are urgent — divorce does not automatically remove the ex-spouse from many beneficiary designations; update or face the possibility of the ex-spouse inheriting",
            "Tax filing status changes — joint to single, with attention to the year of divorce specifics",
            "New estate documents — old will likely names ex-spouse as executor and beneficiary",
            "Insurance review — life insurance for child support obligations, health insurance transition, disability if relevant",
            "Cash flow reset — household income usually drops, new fixed costs may rise"
          ]},
          {"type": "callout", "kind": "warn", "content": "Beneficiary designations on retirement accounts and life insurance survive divorce in most cases unless updated. Divorce decrees often require beneficiary changes — but the changes have to actually be made. People die between the decree and the update. Treat this as urgent."},
          {"type": "case_study", "title": "Tasha's mother — disability planning becomes real", "scenario": "Six months after the annual review, Tasha's mother's condition has progressed. Tasha and her siblings are deciding whether to bring in 24/7 home care, move her to a care facility, or have her move in with Tasha and Marcus permanently. The apprentice does not try to make this decision. They convene a session with Tasha, Marcus, and Tasha's siblings (with everyone's consent) to think through the financial implications of each scenario, identify what resources the mother has (Social Security, pension, small savings), surface what insurance coverage exists, and outline what Tasha and Marcus would need to take on financially. The family ultimately decides on a hybrid — daytime in-home care plus weekend support from siblings. The apprentice draws up a 24-month cash flow projection for the new arrangement and integrates it into Marcus and Tasha's plan.", "discussion": "The apprentice did not pretend to be a geriatric care expert. They were a planner who helped the family think through the financial consequences clearly. The family kept its own decision-making authority. The plan adapted to the new reality. Both human and operational work were done well."},
          {"type": "subheading", "content": "Sitting with the difficulty"},
          {"type": "paragraph", "content": "The temptation in hard life events is to retreat into spreadsheets and operational tasks because the operational tasks feel manageable and the human reality does not. Resist that impulse. Spreadsheets are part of the work, not all of it. The client needs both — competence at the operations and presence with the difficulty. If you can offer both, you become irreplaceable in the most important seasons of their life."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Continuity — Staying With the Client Across Decades",
        "summary": "The most valuable financial relationships are measured in decades. Building one requires intentional systems for memory, communication, and adaptation across years.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most advisors are with a client for a fraction of the client's financial life. The best advisors are with a client for the whole back half of it. Continuity is a system, not a feeling. The advisor who built systems for memory, communication, and adaptation early in their career has a different relationship at year fifteen than the advisor who relied on goodwill."},
          {"type": "subheading", "content": "The CRM as institutional memory"},
          {"type": "paragraph", "content": "Every client interaction generates information that may matter ten years later. The kid's name. The medical condition the spouse has. The vacation property in Oregon. The specific anxiety the client expressed about running out of money. The reason they switched advisors before you. None of this can be recalled reliably from human memory across a 20-year relationship and hundreds of other clients. The CRM is the place where the relationship's memory actually lives. Treat it that way. Add to it after every meeting. Read from it before every meeting. The few minutes invested compound enormously over the relationship."},
          {"type": "subheading", "content": "What goes in the CRM"},
          {"type": "list", "items": [
            "Family details — names, birthdays, relationships, anniversaries that matter",
            "Health information they have shared (with privacy and discretion)",
            "Career history and current role",
            "Hobbies, interests, what they look forward to",
            "Past financial mistakes or wounds they have referenced",
            "Stated values and what money is for them",
            "Specific anxieties — running out, leaving enough for kids, getting taxed",
            "Their preferred communication style and cadence",
            "Things they have told you about other professionals — CPA, attorney, doctor, contractor"
          ]},
          {"type": "callout", "kind": "do", "content": "Use the CRM's calendar features to remind yourself about meaningful dates — the client's late spouse's anniversary, the date a child was born, when the parent passed. A short message on the right date is one of the most meaningful things you can send."},
          {"type": "subheading", "content": "Adapting the relationship as the client ages"},
          {"type": "paragraph", "content": "A client in their 30s and the same client in their 70s may want very different things from the relationship. The younger version wanted to know they were on track. The older version may want reassurance, simplicity, and the sense that someone is looking out for them. Read the change. Slow your communication style. Use more visual aids, larger type, simpler documents. Consider whether adult children should be in some meetings (with consent). Watch for capacity decline — gently, over years — and plan ahead for what the relationship looks like if the client cannot make their own decisions."},
          {"type": "subheading", "content": "Handling counselor turnover"},
          {"type": "paragraph", "content": "Sometimes the advisor changes — an apprentice gets promoted, a counselor retires, a firm reorganizes. The transition is risky to the client relationship. Best practices: introduce the new counselor in person before the transition, have several joint meetings during the handoff, share notes openly with the client about what is in the CRM (transparency builds trust), and let the client know that the firm's commitment to them does not depend on a single individual. Done well, transitions strengthen the institutional relationship. Done badly, they end the relationship."},
          {"type": "subheading", "content": "Year-over-year continuity rituals"},
          {"type": "list", "items": [
            "Annual review at the same approximate time each year — predictability is a feature",
            "Year-end planning letter or email in early November with personalized recommendations",
            "Brief mid-year check-in call — 'just confirming everything is going as expected'",
            "Holiday acknowledgment in December — handwritten when possible",
            "Recognition of anniversaries the client values — never sales-y, always personal"
          ]},
          {"type": "subheading", "content": "Closing the OJL-A band"},
          {"type": "paragraph", "content": "You have now worked through the full client-facing band of competencies: discovery, goal-setting, document collection, financial statements, behavioral coaching, risk profiling, plan presentation, implementation, and ongoing reviews. Together these nine modules describe the practice of a counselor — the work that produces a real planning relationship rather than a sequence of transactions. The next band shifts to operations and investment work. But this band is where the relationship lives. Master it and the rest serves the relationship rather than substituting for it."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: OJL-B opens with Portfolio Construction — translating risk profile and plan into the actual portfolio."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The most appropriate review cadence for a 68-year-old recently-retired client in the first five years of retirement is:", "options": ["Annual review", "Semi-annual reviews to dial in the withdrawal strategy as it meets reality", "Monthly reviews", "Quarterly reviews only if performance is poor"], "correct": 1, "explanation": "Early retirement is a transition stage. Withdrawal strategies often need adjustment as theory meets practice. Semi-annual cadence allows responsive tuning."},
        {"id": "q2", "prompt": "When opening an annual review meeting, the most effective first move is to:", "options": ["Pull up the performance report and start with returns", "Walk through the action items from last year", "Open on a personal note — 'how was your year overall?' — to surface what has changed in their life", "Discuss markets and current events"], "correct": 2, "explanation": "Leading personally surfaces life changes that should shape the rest of the meeting. Performance data discussed without context of life events is less useful and can be misleading."},
        {"id": "q3", "prompt": "A non-spouse inherited retirement account under the SECURE Act (for most beneficiaries) generally must be distributed:", "options": ["Within one year", "Over the beneficiary's life expectancy", "Within ten years", "By the end of the calendar year of the death"], "correct": 2, "explanation": "The SECURE Act generally requires non-spouse inherited retirement accounts to be fully distributed within 10 years (with limited exceptions for certain eligible designated beneficiaries)."},
        {"id": "q4", "prompt": "A QDRO is used to:", "options": ["Designate retirement plan beneficiaries", "Divide an ERISA-qualified retirement plan in divorce", "Authorize a Roth conversion", "Transfer accounts between custodians"], "correct": 1, "explanation": "A Qualified Domestic Relations Order is the legal instrument that divides ERISA-qualified retirement plans pursuant to divorce."},
        {"id": "q5", "prompt": "When a client tells you casually at the end of a meeting that their father has moved in with them, the right response is to:", "options": ["Note it for the next annual review", "Pause, acknowledge it, and ask one open question to understand what is changing", "Move on, since the meeting was about something else", "Send a follow-up email asking them to schedule a separate meeting"], "correct": 1, "explanation": "Life events surface in casual mentions. Do not let them slip past. Acknowledge, ask, and schedule a dedicated conversation if warranted."},
        {"id": "q6", "prompt": "Beneficiary designations on retirement accounts and life insurance following a divorce:", "options": ["Are automatically updated by the divorce decree", "Survive divorce in most cases unless actively updated — treat as urgent", "Are voided by the divorce", "Become the responsibility of the attorney"], "correct": 1, "explanation": "Without active update, ex-spouse beneficiary designations often remain in effect. People die between decree and update. This is urgent."},
        {"id": "q7", "prompt": "The most appropriate response to a client who wants to dramatically change the plan in reaction to a normal market drawdown is to:", "options": ["Make the change immediately to honor client wishes", "Refuse to discuss the topic", "Push back gently — suggest holding the discussion for the next scheduled review with a calmer head", "Increase the equity allocation"], "correct": 2, "explanation": "Reactive plan changes during drawdowns are usually destructive. Delay the decision to a calmer moment without dismissing the client's concern."},
        {"id": "q8", "prompt": "A surviving spouse inheriting an IRA can usually:", "options": ["Only take a lump-sum distribution", "Roll the IRA into their own IRA, treating it as their own going forward (typically preferred)", "Must distribute within 10 years", "Must wait one year before doing anything"], "correct": 1, "explanation": "A surviving spouse has the unique option to roll an inherited IRA into their own, which restarts the rules under their own age and circumstances. Usually the preferred treatment."},
        {"id": "q9", "prompt": "When a client dies, the first 30 days should generally:", "options": ["Be used to liquidate the portfolio for tax purposes", "Not push for decisions unless legally required (RMDs in year of death, certain elections); focus on stabilizing and gathering information", "Be used to update all beneficiary designations on the surviving spouse's accounts", "Be skipped entirely until the executor is appointed"], "correct": 1, "explanation": "Grief impairs decision-making. Defer non-urgent decisions. Operational and information-gathering work happens early; consequential decisions wait."},
        {"id": "q10", "prompt": "The CRM in a long-term advisor-client relationship is best understood as:", "options": ["A compliance requirement", "The relationship's institutional memory — the place where details that may matter ten years later live", "A marketing tool", "Optional"], "correct": 1, "explanation": "Across 20-year relationships and hundreds of other clients, human memory cannot reliably retain the details that build trust. The CRM is the memory. Treat it accordingly."},
        {"id": "q11", "prompt": "A counselor who is being transitioned off a client relationship to another counselor at the firm should:", "options": ["Stop communicating with the client immediately", "Introduce the new counselor in person before the transition, have several joint meetings during the handoff, share notes openly", "Refer the client to a competing firm", "Wait for the client to ask about the change"], "correct": 1, "explanation": "Transitions are risky to retention. In-person introductions, joint meetings, and transparency about institutional knowledge protect the relationship and often strengthen it."},
        {"id": "q12", "prompt": "Devon receiving an unsolicited offer to acquire his business at a $4.2M after-tax price is best handled by:", "options": ["Discussing in the next quarterly check-in", "Scheduling a dedicated 90-minute meeting that week, engaging a transaction-experienced CPA and business attorney, and outlining multi-year wealth planning", "Recommending Devon accept the offer immediately", "Waiting until the next annual review"], "correct": 1, "explanation": "Major life events warrant prompt, structured response. Speed and the right professionals on the team early are how these situations get handled well."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 18;
