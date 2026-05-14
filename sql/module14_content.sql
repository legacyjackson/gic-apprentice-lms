-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 14 CONTENT
-- Behavioral Finance & Client Coaching
-- ============================================================================
update public.modules set
  title = 'Behavioral Finance & Client Coaching',
  competency_id = 'OJL-5',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Recognize the cognitive and emotional patterns that drive client decisions, and learn the coaching moves that keep plans intact when markets get loud.',
  learning_objectives = ARRAY[
    'Identify the most common cognitive biases that show up in real client conversations',
    'Recognize emotional patterns around volatility, windfalls, and losses',
    'Apply motivational interviewing techniques to client meetings',
    'Use pre-commitment, automation, and framing to design around bias',
    'Coach couples and families when stakeholders disagree about money'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Why Smart People Make Predictable Money Mistakes",
        "summary": "Behavioral finance is the study of why humans systematically deviate from rational economic behavior — and why even sophisticated clients need coaching.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Traditional economics assumed people were rational utility-maximizers. Decades of research — much of it from Daniel Kahneman and Amos Tversky — proved they aren't. People are loss-averse, present-biased, herd-following, overconfident, and prone to remembering the dramatic over the typical. None of this makes clients stupid. It makes them human. Your job as a counselor is not to lecture clients out of these patterns — that doesn't work. Your job is to recognize the patterns and design the plan, the conversation, and the environment so the patterns don't sink the plan."},
          {"type": "heading", "content": "The advisor's behavioral premium"},
          {"type": "paragraph", "content": "Vanguard's Advisor's Alpha research and Russell Investments' Value of an Advisor studies both estimate that a meaningful portion of the value advisors deliver comes not from picking better investments but from preventing client behavioral mistakes — talking the panicked client off a sell-everything ledge in March 2020, slowing the euphoric client who wants to dump retirement savings into a hot meme stock, getting the couple in agreement so they stop sabotaging each other's contributions. Behavior coaching is not soft skills. It is the work."},
          {"type": "callout", "kind": "key", "content": "If you only learn one thing from this module: the goal is not to be right about the client's biases. The goal is to design the relationship so the biases never get to drive."},
          {"type": "subheading", "content": "The bias toolkit you will see every week"},
          {"type": "glossary", "terms": [
            {"term": "Loss aversion", "definition": "The pain of losing $1,000 feels roughly twice as strong as the pleasure of gaining $1,000. Drives panic selling and refusal to realize losses."},
            {"term": "Anchoring", "definition": "Fixating on a reference number — what the stock used to be worth, what the house was listed for, what the 401(k) hit at its peak. The anchor often has no bearing on the present decision."},
            {"term": "Recency bias", "definition": "Weighting recent events more heavily than long-term data. A client who watched the market drop 15% this quarter cannot easily picture a 30-year horizon."},
            {"term": "Confirmation bias", "definition": "Seeking and remembering information that supports an existing belief while filtering out contradictory evidence."},
            {"term": "Herding", "definition": "Doing what others are doing — buying into a rally because friends are bragging, selling because the news cycle is grim."},
            {"term": "Overconfidence", "definition": "Believing one's predictions are more accurate than they actually are. Especially common in high-earning professionals."},
            {"term": "Mental accounting", "definition": "Treating money differently based on its source or label — bonus money gets spent, salary gets saved, tax refunds get blown."},
            {"term": "Present bias / hyperbolic discounting", "definition": "Overweighting immediate rewards versus future ones. The reason saving is hard even when the math is obvious."}
          ]},
          {"type": "case_study", "title": "Naomi after a bad quarter", "scenario": "Naomi, the analyst we have followed since Module 2, watches her 401(k) drop 18% in a quarter. She emails her advisor at 11pm: 'I want to move everything to cash until this settles down.' Her time horizon is 32 years. The portfolio is doing exactly what a 90/10 portfolio is supposed to do during a drawdown. Three biases are firing at once: loss aversion (the pain is acute), recency bias (she cannot feel the 32-year horizon), and anchoring (she is mentally anchored to the peak balance from three months ago).", "discussion": "The wrong move is to email back a Vanguard chart about 'time in the market.' That validates that this is a math problem. It is not. It is a fear problem dressed up in math clothing. The right move is to call her in the morning, acknowledge the fear, ask what specifically she is afraid of, and only then walk through what her plan was designed to do in exactly this scenario."},
          {"type": "paragraph", "content": "Notice the move: you start with the emotion, not the data. Clients who feel heard can hear data. Clients who feel dismissed cannot."},
          {"type": "callout", "kind": "note", "content": "Biases are not character flaws. They are features of human cognition that evolved to keep our ancestors alive. The same loss aversion that makes Naomi want to sell at the bottom is what kept her great-grandmother from eating unfamiliar berries."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Reading Emotion in the Room",
        "summary": "Before you can coach, you have to diagnose. What clients say is rarely the whole story — learn to read what they are actually feeling.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Clients almost never walk into a meeting and say 'I am terrified about running out of money in retirement and that terror is making me consider a decision I will regret.' They say things like 'I have been thinking about being more conservative' or 'a friend told me about an annuity.' Your job in the first ten minutes of any consequential conversation is to translate the surface request into the underlying feeling. You cannot solve the surface request well if you have misread the underlying state."},
          {"type": "subheading", "content": "The four emotional states that show up most often"},
          {"type": "list", "items": [
            "Fear — usually around loss, running out, or being exposed as not having known something",
            "Shame — typically about past financial choices, debt, divorce settlements, not having saved enough",
            "Euphoria — after a windfall, a hot investment, an inheritance, a business sale",
            "Resentment — usually around a spouse, a sibling, a former partner, or an institution"
          ]},
          {"type": "paragraph", "content": "Each state distorts decision-making differently. Fear narrows the field of view; the client cannot consider long-term tradeoffs because everything is about the immediate threat. Shame makes clients omit information — they leave out the credit card balance, the second mortgage, the loan from dad. Euphoria makes clients unusually willing to take risks they would have rejected a year earlier. Resentment makes clients make decisions to spite someone else rather than to serve themselves."},
          {"type": "subheading", "content": "Verbal signals to listen for"},
          {"type": "glossary", "terms": [
            {"term": "Should statements", "definition": "'I should have started saving sooner.' 'We should be further along.' Almost always shame. Do not validate the should — redirect to what is possible now."},
            {"term": "Catastrophic language", "definition": "'Everything I have worked for.' 'Nothing left.' 'Wiped out.' Almost always fear. The actual situation is rarely as binary as the language suggests."},
            {"term": "Comparison statements", "definition": "'My brother-in-law is up 40% this year.' 'Everyone in my office is buying X.' Usually herding pressure. Slow down before responding."},
            {"term": "Vague qualifiers", "definition": "'Some' debt. 'A few' credit cards. 'A while ago.' Shame about specifics. Get the actual numbers gently."},
            {"term": "Spouse-blame language", "definition": "'He never wanted to save.' 'She insisted on the bigger house.' Resentment. Both spouses need to be in the room before you build a plan."}
          ]},
          {"type": "subheading", "content": "Non-verbal signals you can train yourself to notice"},
          {"type": "list", "items": [
            "Body closing off — arms crossing, leaning back, turning toward the door. Trust is dropping.",
            "Glancing at the spouse before answering — the answer being given may not be the real answer.",
            "Long pauses before numbers — the client is calculating whether to tell you the truth.",
            "Voice dropping or trailing off — the topic has hit something painful.",
            "Sudden topic changes — you have approached something the client is not ready to discuss."
          ]},
          {"type": "case_study", "title": "Marcus and Tasha in the discovery meeting", "scenario": "Marcus and Tasha — the couple from Modules 3 and 11 — are in their first planning meeting. When the apprentice asks about debt, Marcus answers immediately: 'We have the mortgage, that is it.' Tasha glances at him, says nothing. Five minutes later when the apprentice asks about emergency savings, Tasha mentions 'the card we use for emergencies sometimes.' The apprentice gently follows up: 'Tell me a little more about that card — what's the balance?' Tasha says about $14,000.", "discussion": "Marcus was not lying — he genuinely did not consider the card a debt because Tasha manages it. But the glance was the signal. A counselor who pushed past the first 'that is it' would have missed the fourteen thousand dollars and built a plan around a fiction. Reading the glance is more important than reading the spreadsheet."},
          {"type": "callout", "kind": "do", "content": "When something feels off, slow down. Ask one more open question. 'Help me understand a little more about...' is one of the most powerful sentences in this work."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "The Coaching Conversation — Motivational Interviewing for Money",
        "summary": "Motivational interviewing is a clinical technique developed for addiction counseling. It works in financial coaching for the same reason it works there: people change when they hear themselves say why.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "If you have ever tried to argue someone out of a bad financial decision, you already know it does not work. The harder you push, the more committed the client becomes to defending the position. Motivational interviewing flips this. Instead of telling the client what to do, you ask questions designed to surface their own reasons for change. The client persuades themselves. You just hold the space."},
          {"type": "subheading", "content": "The four core moves — OARS"},
          {"type": "glossary", "terms": [
            {"term": "Open questions", "definition": "Questions that cannot be answered with yes or no. 'What does retirement look like for you?' beats 'Do you want to retire at 65?' every time."},
            {"term": "Affirmations", "definition": "Specific recognition of strengths and effort. Not flattery. 'It took real discipline to pay off that card last year.'"},
            {"term": "Reflections", "definition": "Saying back what you heard, sometimes with slight amplification. 'So even though the market makes you nervous, you have stayed with the plan for three years now.'"},
            {"term": "Summaries", "definition": "Pulling together what the client has said over a longer stretch and offering it back. Lets the client hear their own thinking organized."}
          ]},
          {"type": "subheading", "content": "Change talk — the sound of motivation"},
          {"type": "paragraph", "content": "When clients start using certain kinds of language, motivation is rising. Listen for: desire ('I want to...'), ability ('I could...'), reasons ('Because if I do not...'), need ('I have to...'), and commitment ('I will...'). Your job is to ask questions that elicit more of this language. The more the client hears themselves talking about change, the more likely change becomes."},
          {"type": "subheading", "content": "Sustain talk and rolling with resistance"},
          {"type": "paragraph", "content": "The opposite of change talk is sustain talk — reasons to keep doing what they are doing. 'I cannot save more, I just cannot.' 'My husband would never agree to that.' When you hear sustain talk, the wrong move is to argue. The right move is to reflect it back without agreeing, then ask a question that opens a different angle. 'Saving more feels impossible right now. If we could find $50 a month somewhere, where would you want it to go?' You are not contradicting the client. You are inviting them to imagine differently."},
          {"type": "activity", "title": "Practice — flipping the script", "prompt": "For each statement below, write a response that reflects the client's feeling without agreeing with the conclusion, then asks an open question:", "steps": [
            "'There is no point trying to save for retirement, it is too late for me.'",
            "'My friends are all buying crypto and they are making a fortune. I am missing out.'",
            "'My wife handles all the money, I just sign what she puts in front of me.'",
            "'We will get serious about this when the kids are out of college.'"
          ]},
          {"type": "case_study", "title": "Devon and the equipment loan", "scenario": "Devon, the small business owner from prior modules, wants to take out a $90,000 equipment loan at 9.5% interest. He has $130,000 in his business savings. When the apprentice asks why he prefers debt to using cash, Devon says 'I never want to be cash-poor in the business.' The apprentice does not argue. Instead: 'Tell me about a time being cash-poor really hurt the business.' Devon describes 2020 — a stretch when receivables stretched out and he almost missed payroll. 'So the loan is partly about protecting against that feeling again.' Devon agrees. 'If we could solve the cash protection a different way — say a line of credit at 7% you only draw if you actually need it — what would that change?'", "discussion": "The apprentice never told Devon his plan was wrong. They asked questions that surfaced the real driver — fear of 2020 repeating — and then offered a structure that solved for the fear without the 9.5% locked-in debt. Devon makes the new decision. He owns it because he arrived at it."},
          {"type": "callout", "kind": "key", "content": "You will not persuade clients with better arguments. You will only persuade them by asking questions that let them persuade themselves."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Designing Around Bias — Automation, Pre-Commitment, and Framing",
        "summary": "Some bias problems can be solved by conversation. Others need to be solved by structure. Learn to build a plan that does not rely on the client being a different person than they are.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Coaching is necessary but not sufficient. The best behavioral interventions remove the decision from the moment of weakness entirely. If a client cannot resist spending the bonus, the plan should automatically route the bonus into investments before the client sees it. If a client panics when the market drops, the rebalancing rules should be written down in advance, signed, and triggered by predetermined thresholds — not by how the news is making the client feel that morning. Design the environment, not the resolve."},
          {"type": "subheading", "content": "Automation as a bias antidote"},
          {"type": "list", "items": [
            "Automatic contributions to 401(k), IRA, brokerage — removes the monthly decision",
            "Auto-escalation — contribution rate increases by 1% each year on a set date",
            "Sweep accounts — anything above $X in checking moves to savings on the 1st",
            "Direct deposit splitting — bonuses or commissions routed directly to savings before they hit checking",
            "Automatic rebalancing on a fixed schedule or threshold, not a feeling"
          ]},
          {"type": "subheading", "content": "Pre-commitment devices"},
          {"type": "paragraph", "content": "A pre-commitment device is a decision the client makes when they are calm that constrains the decision they will be tempted to make when they are not. The classic example is the Investment Policy Statement — a written document that says 'I will not change my allocation in response to a single quarter's performance. If I want to make a change, I will wait 30 days and re-discuss.' Signed when the client is calm. Pulled out when the client wants to panic-sell."},
          {"type": "callout", "kind": "do", "content": "Every client over a certain asset threshold should have a one-page Investment Policy Statement signed at the start of the relationship. It is the single most useful tool for surviving market drawdowns."},
          {"type": "subheading", "content": "Framing — same fact, different feeling"},
          {"type": "paragraph", "content": "How information is framed changes how clients react to it, even when the underlying numbers are identical. A 90% survival probability feels safer than a 10% failure probability — even though they are the same. A $10,000 loss feels different described as 'a 5% drawdown in a portfolio that has averaged 8% over 15 years' than as 'losing $10,000.' Framing is not manipulation. It is presenting the same truth in a way the client can actually process. The lie would be omitting either side. The skill is in choosing which frame to lead with."},
          {"type": "glossary", "terms": [
            {"term": "Default framing", "definition": "Setting the default option to the desired behavior. Auto-enrollment in a 401(k) raises participation from ~60% to ~90% — same employees, same plan, different default."},
            {"term": "Loss framing", "definition": "Describing a choice in terms of what is at risk of being lost. Tends to motivate action because of loss aversion."},
            {"term": "Gain framing", "definition": "Describing the same choice in terms of what could be gained. Tends to feel less urgent but more sustainable."},
            {"term": "Bucket framing", "definition": "Mentally separating money by purpose — emergency bucket, retirement bucket, near-term goals bucket. Leverages mental accounting positively."}
          ]},
          {"type": "case_study", "title": "Designing for Marcus and Tasha", "scenario": "Marcus and Tasha agreed to save more after Modules 3 and 11. But three months in, the extra savings are not happening — they keep meaning to transfer money and never do. The apprentice does not call this a discipline problem. They restructure: bi-weekly automatic transfer of $400 from checking to a high-yield savings account labeled 'Emergency Fund' at a different bank than their checking. The money moves the day after each payday, before discretionary spending. Three months later, the emergency fund is at $2,400 with no further conversations.", "discussion": "Marcus and Tasha did not become more disciplined. The system became more forgiving of their actual discipline level. Notice also the labeling — 'Emergency Fund' at a different bank — uses mental accounting and friction to discourage casual withdrawal."},
          {"type": "callout", "kind": "warn", "content": "If a plan requires the client to make a recurring willpower-dependent decision, the plan will eventually fail. Engineer the willpower out."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "When Two People Have to Agree — Coaching Couples and Families",
        "summary": "Most household financial decisions involve more than one person. When stakeholders disagree, the coaching work doubles — and the wrong move can damage the marriage as much as the portfolio.",
        "read_time": "12 min read",
        "blocks": [
          {"type": "paragraph", "content": "Money is one of the top three causes of divorce. By the time a couple is sitting across from you, there is often a long history of money fights, money silences, money resentments — and the conversation you are about to have is not really about asset allocation. It is about whether two people who love each other can build something together that they both believe in. Take the role seriously. You are not a marriage counselor, but you are doing some of the work."},
          {"type": "subheading", "content": "Common couple patterns to recognize"},
          {"type": "glossary", "terms": [
            {"term": "The CFO and the consumer", "definition": "One spouse handles all the money decisions, the other spouse spends without engagement. Eventually the CFO burns out or the consumer wakes up to a balance sheet they do not recognize."},
            {"term": "The saver and the spender", "definition": "One spouse is wired toward security, the other toward enjoyment. Neither is wrong. The plan has to honor both or it will break."},
            {"term": "The risk-seeker and the risk-avoider", "definition": "One spouse is comfortable with equity volatility, the other cannot sleep with it. A 70/30 portfolio works for neither — design something asymmetric."},
            {"term": "The yours/mine couple", "definition": "Separate accounts, separate everything, often after a prior marriage. Build a plan that respects the separation but creates joint accountability where needed."},
            {"term": "The silent spouse", "definition": "One spouse comes to every meeting and does not speak. Either disengaged or being overridden. Address it directly and gently."}
          ]},
          {"type": "subheading", "content": "Ground rules for the joint meeting"},
          {"type": "list", "items": [
            "Both spouses in the room for any consequential decision — no one-sided sign-offs on things that affect them both",
            "Ask each spouse questions directly, not just 'you two' — make sure both voices land in the record",
            "When one spouse interrupts the other, calmly redirect: 'I want to hear Maria finish that thought'",
            "Never side with one spouse against the other, even when you privately agree with one of them",
            "Surface disagreement explicitly — 'It sounds like you two see this differently. Let's slow down here.'",
            "If a couple is in active conflict, do not push to a decision in that meeting. Reschedule."
          ]},
          {"type": "subheading", "content": "Working with adult children, parents, and blended families"},
          {"type": "paragraph", "content": "The household is not always two people. Adult children may be involved in aging parents' decisions. Stepchildren and former spouses complicate estate planning. Sometimes a financially successful child is supporting a parent or a sibling. Each of these situations has emotional currents that long predate you. Your job is to map the dynamics without judging them, and to design a plan that does not require the family to suddenly become a different family."},
          {"type": "case_study", "title": "Marcus's mother", "scenario": "During the planning conversation, Marcus mentions that he has been sending his mother $400 a month for two years. Tasha looks surprised. She knew he helped sometimes but did not know it was monthly or that amount. The apprentice does not move past this. 'It sounds like this is the first time you two are talking about this number together. I want to make sure we plan with the real picture.' The apprentice asks Marcus to explain what the support is for, asks Tasha what she is feeling hearing it for the first time, and only then continues.", "discussion": "The apprentice did not avoid the moment because it was uncomfortable. They held the moment. The $4,800 a year matters for the cash flow plan — but the bigger issue is that Marcus and Tasha did not have a shared picture of their own money. Surfacing that gently, with care, is part of the work. A counselor who breezed past it would have built a financial plan that excluded reality."},
          {"type": "callout", "kind": "note", "content": "When you sense a couple has just disagreed on something for the first time in front of you, you have two options: rush past it or hold it. Hold it. The couple needs to talk about it eventually. They might as well do it with a calm professional in the room."},
          {"type": "subheading", "content": "Tying it back to the apprentice role"},
          {"type": "paragraph", "content": "Behavioral coaching is the difference between being a financial calculator and being a counselor. The numbers any apprentice can learn. The capacity to sit with another human being's fear, shame, euphoria, or resentment — without flinching, without judging, without trying to fix what is not yours to fix — that is the practice. Every client meeting is an opportunity to develop it."},
          {"type": "divider"},
          {"type": "paragraph", "content": "In the next module, we move from coaching the relationship to the structured tool that translates client risk capacity and tolerance into an actual portfolio decision: risk profiling and suitability."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "A client emails at 11pm wanting to move everything to cash after a bad quarter. The first move is to:", "options": ["Email back a chart showing long-term market returns", "Call in the morning and start with the emotion, not the data", "Process the trade overnight to honor client wishes", "Refer the client to a different advisor"], "correct": 1, "explanation": "Clients in fear cannot hear data until they feel heard. Start with the emotion. The data conversation follows."},
        {"id": "q2", "prompt": "Loss aversion describes which of the following?", "options": ["The tendency to lose money on most trades", "The pain of losing $1,000 feeling roughly twice as strong as the pleasure of gaining $1,000", "The risk of avoiding all investments", "A bias unique to inexperienced investors"], "correct": 1, "explanation": "Loss aversion is the asymmetry between the felt pain of loss and the felt pleasure of equivalent gain. It affects everyone, including sophisticated investors."},
        {"id": "q3", "prompt": "Which of the following is an example of a pre-commitment device?", "options": ["Telling the client to be more disciplined", "An Investment Policy Statement signed when the client is calm that constrains future panic decisions", "Reading market news every morning", "Setting more aggressive return targets"], "correct": 1, "explanation": "A pre-commitment device is a decision made in a calm state that constrains a decision the client will be tempted to make under stress. The IPS is the classic example."},
        {"id": "q4", "prompt": "Motivational interviewing's OARS framework stands for:", "options": ["Observe, Ask, Recommend, Sell", "Open questions, Affirmations, Reflections, Summaries", "Outline, Articulate, Reason, Solve", "Onboarding, Assessment, Review, Strategy"], "correct": 1, "explanation": "OARS — Open questions, Affirmations, Reflections, Summaries — is the core conversational toolkit of motivational interviewing."},
        {"id": "q5", "prompt": "A client says 'My friends are all buying crypto and making a fortune. I am missing out.' This is most likely:", "options": ["A rational reallocation request", "Anchoring bias", "Herding pressure", "Hyperbolic discounting"], "correct": 2, "explanation": "Herding — doing what others are doing because they are doing it — is the bias driving most 'everyone else is...' statements."},
        {"id": "q6", "prompt": "Auto-enrollment raises 401(k) participation rates from roughly 60% to 90% because:", "options": ["Employees become more financially literate", "The contribution rates increase automatically", "Setting the default to the desired behavior leverages how people respond to defaults", "Employers offer better matches"], "correct": 2, "explanation": "Default framing is one of the most powerful behavioral interventions. Most people accept the default, so designing the default is designing the outcome."},
        {"id": "q7", "prompt": "Which of the following best describes 'change talk' in motivational interviewing?", "options": ["The advisor telling the client what to change", "The client using language of desire, ability, reasons, need, or commitment toward change", "Switching topics during a conversation", "Discussing market changes"], "correct": 1, "explanation": "Change talk is the client's own language signaling motivation. The more change talk, the more likely behavior change. The advisor's job is to ask questions that elicit it."},
        {"id": "q8", "prompt": "During a joint meeting, one spouse interrupts the other every time the second spouse tries to speak. The most appropriate move is to:", "options": ["Let the dominant spouse finish, since they seem more engaged", "Side with the quieter spouse to even things out", "Calmly redirect: 'I want to hear Maria finish that thought'", "End the meeting and only meet with one spouse going forward"], "correct": 2, "explanation": "Both voices need to land in the record. Calmly redirecting without taking sides preserves your neutrality and protects the relationship."},
        {"id": "q9", "prompt": "Mental accounting refers to:", "options": ["The math of calculating portfolio returns", "Treating money differently based on its source or label", "Reviewing accounts mentally before sleep", "A type of double-entry bookkeeping"], "correct": 1, "explanation": "Mental accounting is the tendency to treat money differently depending on where it came from or what we call it. Bonus money gets spent, salary gets saved, refunds get blown."},
        {"id": "q10", "prompt": "A client says 'I should have started saving sooner. I should be further along by now.' This 'should' language most often indicates:", "options": ["Strong financial literacy", "Confirmation bias", "Shame about past financial choices", "A request for tax planning"], "correct": 2, "explanation": "'Should' statements about the past are almost always shame. The right move is to redirect to what is possible now, not to validate the should."},
        {"id": "q11", "prompt": "Devon wants a $90,000 equipment loan at 9.5% when he has $130,000 in business savings. After exploring, the apprentice learns Devon is afraid of repeating a 2020 cash crisis. The strongest next move is to:", "options": ["Tell Devon his fear is irrational and use the cash", "Refuse to discuss the loan", "Offer a structure — like a line of credit — that solves the cash protection without the high locked-in rate", "Process the loan as requested"], "correct": 2, "explanation": "You do not win by overriding the client's fear. You win by designing a structure that honors the underlying need (cash protection) without paying 9.5% locked in."},
        {"id": "q12", "prompt": "The behavioral premium of an advisor — the value of preventing client behavioral mistakes — is best described as:", "options": ["A marketing concept with no empirical support", "A meaningful portion of the value advisors deliver according to multiple industry studies", "A practice only used by fee-only advisors", "Only relevant for high-net-worth clients"], "correct": 1, "explanation": "Industry research from Vanguard, Russell, and others estimates behavioral coaching is a meaningful part of advisor value — often as much or more than investment selection."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 14;
