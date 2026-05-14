-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 15 CONTENT
-- Risk Profiling & Suitability
-- ============================================================================
update public.modules set
  title = 'Risk Profiling & Suitability',
  competency_id = 'OJL-6',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Translate a client''s risk capacity, tolerance, and required return into a defensible suitability determination — and document it the way regulators expect.',
  learning_objectives = ARRAY[
    'Distinguish risk capacity, risk tolerance, and required return',
    'Administer and interpret a risk profiling questionnaire',
    'Reconcile mismatches between what a client says and what their situation requires',
    'Document a suitability determination that holds up to compliance review',
    'Communicate risk in terms clients actually feel, not just statistics'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Three Risks That Live in Every Client",
        "summary": "Every client has three different risk numbers — and one of the most common counselor mistakes is conflating them. Get them separated.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Ask three different planners 'how risky a portfolio should this client have' and you can get three different answers — not because anyone is wrong but because they are answering different questions. Risk in client work is not one number. It is three numbers that have to be reconciled. If you mix them up, you build the wrong portfolio for the right client, or worse, the right portfolio for the wrong client."},
          {"type": "subheading", "content": "The three risk dimensions"},
          {"type": "glossary", "terms": [
            {"term": "Risk capacity", "definition": "How much loss the client can financially absorb without breaking the plan. A function of time horizon, income stability, savings rate, and other resources. Objective. Calculable."},
            {"term": "Risk tolerance", "definition": "How much loss the client can emotionally absorb without breaking themselves. A function of personality, history, and current life stress. Subjective. Measured by questionnaire and conversation."},
            {"term": "Required return", "definition": "The annualized return the client's portfolio needs to deliver for the stated goals to be achievable. A function of starting assets, savings, time horizon, and target. Objective. Calculable from the financial plan."}
          ]},
          {"type": "callout", "kind": "key", "content": "Capacity says what the client can take. Tolerance says what the client can stand. Required return says what the client needs. The portfolio has to honor all three — and when they conflict, the conversation gets interesting."},
          {"type": "subheading", "content": "Worked example — Naomi at 32"},
          {"type": "paragraph", "content": "Naomi has a 32-year time horizon for retirement, stable W-2 income, six months of emergency reserves, and is saving 18% of gross income. Her risk capacity is high — even a 40% drawdown does not break the plan because she will not need the money for three decades and has cash flow to keep contributing through any drawdown. Her risk tolerance, based on questionnaire and the panic email from Module 14, is moderate — she felt real pain at 18% down. Her required return to hit a comfortable retirement is about 6% real. The portfolio decision has to thread the needle: capacity says go aggressive, tolerance says no more than she can stand, required return says she does not need to take maximum risk."},
          {"type": "subheading", "content": "Worked example — A 68-year-old retiree"},
          {"type": "paragraph", "content": "Now consider a 68-year-old retiree drawing 4.5% of a $1.2M portfolio annually. Risk capacity is lower than Naomi's — a 40% drawdown means selling assets to fund withdrawals at depressed prices, which can permanently impair the plan. Risk tolerance is high — this client lived through 1987, 2000, and 2008 and never sold. Required return is about 5% nominal to sustain the withdrawal rate. Here capacity is the binding constraint, not tolerance. Just because the client can stand more risk does not mean the plan can. The 60/40 portfolio is right not because the client is timid but because the plan cannot tolerate large equity drawdowns at this stage."},
          {"type": "callout", "kind": "warn", "content": "Common error: building portfolios based only on risk tolerance. A client who says 'I can handle anything' but who needs the money in 18 months for a down payment has high tolerance and zero capacity. The capacity wins. Always."},
          {"type": "subheading", "content": "The fourth quiet variable — risk perception"},
          {"type": "paragraph", "content": "Some practitioners add a fourth: risk perception, or how the client interprets the risk they are taking. Two clients with identical 70/30 portfolios can perceive their risk completely differently — one because they understand what they own, the other because they do not. Perception is what the counselor's communication shapes. The same portfolio that feels 'volatile and concerning' can feel 'doing exactly what it should' when the client understands the design. Education is part of risk management."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Questionnaire and What It Actually Measures",
        "summary": "Risk tolerance questionnaires are a compliance requirement and a starting point. They are not the answer — they are a prompt for a conversation.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most broker-dealers and RIAs require a documented risk tolerance questionnaire on file for every client. The instruments vary — Riskalyze (now Nitrogen), FinaMetrica, internal proprietary scales — but they generally try to do three things: measure stated risk tolerance under hypothetical scenarios, measure investment knowledge, and surface preferences about volatility versus growth. Used well, they are useful. Used badly, they are dangerous — because a client who scored 'aggressive' on a questionnaire and then sold at the bottom of a drawdown will be the first person the client's attorney points at."},
          {"type": "subheading", "content": "What good questionnaires try to measure"},
          {"type": "list", "items": [
            "Stated reaction to hypothetical drawdowns — would you sell, hold, or buy more if your portfolio fell 25%?",
            "Investment knowledge and experience — how long have you invested, what have you owned?",
            "Time horizon and liquidity needs — when do you need the money, how much, for what?",
            "Preference between volatility and growth — would you take a steady 5% or a volatile 10%?",
            "Income stability and other resources — how does this money fit the rest of your picture?"
          ]},
          {"type": "subheading", "content": "What questionnaires cannot measure"},
          {"type": "list", "items": [
            "How the client will actually behave when the loss is real instead of hypothetical",
            "How the client will behave when their spouse, parent, or coworker is panicking around them",
            "Whether the client understood the questions the way you intended",
            "Hidden context — a recent layoff, a divorce, a parent's illness — that shifts everything"
          ]},
          {"type": "callout", "kind": "do", "content": "Walk through the questionnaire with the client, do not just hand it to them. Watch which questions they hesitate on. Ask 'tell me more about why you picked that' on any answer that feels off. The conversation around the questionnaire is more valuable than the score."},
          {"type": "subheading", "content": "Interpreting the score"},
          {"type": "paragraph", "content": "Most questionnaires output a number or band — Conservative, Moderately Conservative, Moderate, Moderately Aggressive, Aggressive — that maps to a model portfolio. Treat the band as a starting point and a documentation artifact, not a final answer. If the questionnaire says Moderate but the client just received a $1.5M inheritance from a parent they lost three months ago, the right move may be to start more conservatively than the band suggests for the first year. The score does not know about the grief."},
          {"type": "case_study", "title": "The questionnaire that lied", "scenario": "Naomi takes a risk tolerance questionnaire and scores Aggressive. She answers every drawdown question with 'I would buy more.' Six months later she sends the panic email from Module 14 after an 18% drop. The questionnaire was not wrong on its terms — Naomi genuinely believed she would buy more. But she had never experienced a drawdown with real money. Stated tolerance and revealed tolerance can differ enormously. The advisor's note after the panic episode: 'Reassess as Moderately Aggressive at most. Build a 5-7% cash buffer to give her something to deploy during the next drawdown so she has agency.'", "discussion": "The questionnaire's mistake was not the score. It was being treated as the answer. Revealed behavior in the first real drawdown is more diagnostic than any questionnaire. Reassess and document the reassessment."},
          {"type": "callout", "kind": "note", "content": "Re-administer the risk tolerance questionnaire after major life events, after a significant drawdown the client experienced, and at minimum every two to three years. Tolerance is not a fixed trait."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Suitability — The Legal Standard, Plain English",
        "summary": "Suitability is not a vague aspiration. It is a regulatory requirement with specific elements. Know what it requires and what it does not.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Suitability is the foundational regulatory requirement for investment recommendations in the United States. FINRA Rule 2111 governs broker-dealer representatives. SEC Regulation Best Interest (Reg BI), effective June 2020, raised the standard for broker-dealers when recommending securities to retail customers — requiring that recommendations be in the customer's best interest at the time of the recommendation. RIAs and their representatives operate under a separate fiduciary standard under the Investment Advisers Act of 1940, which has historically been a higher standard than suitability — though the practical gap narrowed somewhat with Reg BI."},
          {"type": "callout", "kind": "key", "content": "Suitability is the floor. Fiduciary duty is the higher standard. Know which applies to you in the role you are operating. At GIC, the apprentice operates under the supervision of a fiduciary advisor — your work is held to the higher standard whether or not you personally hold the license that requires it."},
          {"type": "subheading", "content": "FINRA Rule 2111 — three suitability obligations"},
          {"type": "glossary", "terms": [
            {"term": "Reasonable-basis suitability", "definition": "The recommendation is reasonable for at least some investors. The product itself is not inherently unsuitable. Diligence on the product."},
            {"term": "Customer-specific suitability", "definition": "The recommendation is reasonable for this specific customer based on their profile — age, financial situation, tax status, investment experience, objectives, time horizon, liquidity needs, and risk tolerance."},
            {"term": "Quantitative suitability", "definition": "Even if individual recommendations are suitable, the pattern of recommendations — the frequency, volume, and turnover — is not excessive for the customer."}
          ]},
          {"type": "subheading", "content": "Reg BI — four obligations for broker-dealers"},
          {"type": "list", "items": [
            "Disclosure — provide certain disclosures before or at the time of the recommendation",
            "Care — exercise reasonable diligence, care, and skill",
            "Conflict of interest — establish and enforce written policies addressing conflicts",
            "Compliance — establish and enforce policies reasonably designed to achieve compliance with Reg BI"
          ]},
          {"type": "subheading", "content": "The Form CRS"},
          {"type": "paragraph", "content": "Reg BI introduced a required client relationship summary — Form CRS — that broker-dealers and RIAs must deliver to retail clients. It is meant to be a plain-English explanation of services, fees, conflicts, and standard of conduct. You should be able to walk a client through your firm's Form CRS in five minutes. Practice it."},
          {"type": "subheading", "content": "Documenting suitability"},
          {"type": "paragraph", "content": "Suitability lives or dies in the documentation. A recommendation that was suitable but undocumented is, from a compliance perspective, indistinguishable from one that was unsuitable. The file note for any recommendation should capture: what was recommended, why it was suitable given the client's profile, what alternatives were considered and why they were rejected, what disclosures were made, and what the client said in response. Do this consistently and a regulator can reconstruct your reasoning years later. Skip it and you cannot reconstruct your own reasoning a year later."},
          {"type": "case_study", "title": "The variable annuity recommendation that needed a paper trail", "scenario": "An apprentice's supervising advisor is recommending a deferred variable annuity for a 58-year-old client with $450,000 in qualified retirement assets. The annuity has a 1.65% M&E fee, a 2.10% rider fee for guaranteed lifetime income, and a 7-year surrender schedule. The apprentice drafts the suitability memo: client objective (income certainty in retirement), why this product (income rider provides longevity hedging the client values), alternatives considered (managed payout fund, bond ladder, deferred income annuity at age 70 — each evaluated and noted), all fees and surrender terms disclosed, client signed acknowledgment. The memo is six paragraphs.", "discussion": "If this client complains in three years that the fees ate her returns, the file shows that the alternatives were considered, the fees were disclosed, the client's stated objective was income certainty, and the product matched that objective. The memo is the difference between a defensible recommendation and a problem."},
          {"type": "callout", "kind": "do", "content": "If you would not feel comfortable explaining the recommendation to a regulator three years from now without the file in front of you, write a better file note now. Documentation is part of the recommendation, not paperwork after it."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "When Capacity and Tolerance Disagree",
        "summary": "The hardest counseling conversations happen when what the client can financially afford and what they can emotionally tolerate point in opposite directions. Here is how to work through it.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When capacity, tolerance, and required return all line up, the portfolio decision is easy. The work happens when they disagree. The four common mismatches are worth knowing by name because you will see each of them in client meetings."},
          {"type": "subheading", "content": "Mismatch 1 — high capacity, low tolerance"},
          {"type": "paragraph", "content": "The client has a long horizon, stable income, and plenty of resources, but cannot sleep with equity volatility. They are emotionally a 40/60 client in a financial situation that could support 80/20. If you build 80/20 to maximize math, they will sell at the bottom and lock in losses. If you build 40/60 to honor emotion, they may not hit their goals. The honest move: meet them where they are now — say 50/50 or 60/40 — and use education, smaller exposures, and time to gradually grow tolerance. Do not engineer for the portfolio they should have. Engineer for the portfolio they will actually hold."},
          {"type": "subheading", "content": "Mismatch 2 — low capacity, high tolerance"},
          {"type": "paragraph", "content": "The opposite case. The retiree with high stated tolerance whose plan cannot survive a 40% drawdown. The recent retiree who 'rode out 2008 fine' but is now in a withdrawal phase rather than an accumulation phase. Capacity wins. Even if the client wants more equity, the responsible counselor explains why the portfolio that fit during accumulation is not the portfolio that fits during withdrawal. Sequence-of-returns risk is the technical name. Educate, document, and constrain."},
          {"type": "subheading", "content": "Mismatch 3 — required return exceeds capacity"},
          {"type": "paragraph", "content": "The client wants to retire at 55 on $90,000 a year and currently has $400,000 saved with eight years to go. The required return to make that math work without further savings is implausibly high. You cannot fix this with a more aggressive portfolio — taking the risk required to chase that return creates an unacceptable probability of being permanently impaired. The right conversation is not about portfolio. It is about goals. Some combination of saving more, working longer, spending less in retirement, or accepting a lower probability of success is needed. The portfolio cannot solve a goal problem."},
          {"type": "callout", "kind": "warn", "content": "When required return exceeds reasonable capacity, the temptation is to recommend more aggressive investments to chase the math. Resist. You are setting the client up to fail in a drawdown. Instead, reset the goals."},
          {"type": "subheading", "content": "Mismatch 4 — capacity exceeds required return"},
          {"type": "paragraph", "content": "The pleasant case. A client has more resources, time, or income stability than they need for their goals. They could take 80/20 risk but only need 50/50 returns to be fine. Do not maximize what is unnecessary. A wealthy retiree who already has more than enough for the rest of their life does not benefit from chasing growth — the marginal dollar from upside does not change their life, while a large drawdown could meaningfully damage it. Discuss explicitly with the client whether they want growth for heirs, philanthropy, or other purposes — and let that conversation, not a return target, drive the allocation."},
          {"type": "case_study", "title": "Marcus and Tasha — required return reality check", "scenario": "Marcus and Tasha — early 30s, two kids — want to fully fund both college costs and retire at 60. After running the projections, the required return is 8.5% real to do everything without raising savings. That is implausible to plan around — it exceeds long-term equity real returns and would require taking risk that breaks tolerance. The apprentice does not propose a more aggressive portfolio. Instead they walk through the four levers: save more, retire later, spend less in retirement, or accept partially funding college (with the kids covering the gap through scholarships, in-state schools, or loans). Marcus and Tasha decide to raise savings by 3% and target 80% of college costs rather than 100%. The required return drops to 5.8% real — achievable.", "discussion": "Notice that the apprentice did not solve a goals problem with a portfolio recommendation. They surfaced the math, explained the levers, and let the clients choose. That is fiduciary work."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Talking About Risk So Clients Actually Feel It",
        "summary": "Statistics about standard deviation and Sharpe ratios do not move clients. Dollar amounts and lived scenarios do. Communicate risk the way clients hear it.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A 15% standard deviation on a portfolio means almost nothing to almost any client. 'Your portfolio could drop by $87,000 in a bad year' means everything. The skill is in translating statistical risk into experienced risk — turning percentages into dollars, charts into stories, and abstract probabilities into something the client can feel before they have to live through it."},
          {"type": "subheading", "content": "From percentages to dollars"},
          {"type": "paragraph", "content": "Every time you discuss potential drawdowns with a client, translate to dollars on their actual balance. A 30% drawdown on a $750,000 portfolio is $225,000 — and the client needs to sit with that number before agreeing to the allocation that produces it. If they flinch at the number, the allocation is wrong. If they nod calmly and say 'I have seen that before and it does not move me,' the allocation may be right. The point is not to scare the client. The point is to surface the actual experience the portfolio is signing them up for."},
          {"type": "subheading", "content": "Historical context — what the portfolio has done before"},
          {"type": "paragraph", "content": "Show clients the actual worst rolling 12-month and 36-month periods for portfolios similar to theirs. A 70/30 portfolio's worst 12-month period since 1976 was roughly -28% in 2008. That is what the portfolio did the last time things got bad. If the client cannot imagine signing for that, do not build that portfolio. If the client says 'I lived through it and added money,' you have useful information."},
          {"type": "subheading", "content": "Range framing"},
          {"type": "paragraph", "content": "Rather than a single expected return, show the client the range. 'Over 20 years, a portfolio like this has historically returned between X% and Y% per year on the worst and best rolling 20-year windows. The middle is around Z%.' This honors the truth that returns are not a constant and prevents the client from anchoring on the median as a promise."},
          {"type": "subheading", "content": "Probability of failure language"},
          {"type": "paragraph", "content": "Monte Carlo simulations output a probability that the plan succeeds — say, '88% probability the plan succeeds over the planning horizon.' Many clients hear 88% and feel reassured. Some clients hear 12% probability of failure and feel terrified — same number, different framing. Both framings are honest. Lead with the one that gives the client the most accurate emotional signal for their situation. If the client is risk-tolerant and may underprepare, lead with the failure framing. If the client is risk-averse and may overreact, lead with the success framing. Both numbers should be in the document."},
          {"type": "case_study", "title": "Explaining a 70/30 portfolio to a couple in their 40s", "scenario": "The apprentice is presenting a 70/30 portfolio to a couple with $560,000 invested. Rather than 'expected return 6.5%, standard deviation 11.2%,' the apprentice says: 'Based on history, this portfolio averages about 6 to 7 percent a year, but in a bad year it could drop by $90,000 to $170,000. The worst 12-month period for something like this since 1976 was about $156,000 down. The recovery from that took roughly three years. Can you sign up for that experience between now and retirement, knowing it will happen at least once or twice?'", "discussion": "Notice — dollars, history, recovery time, and an explicit invitation to commit. The couple either says yes with eyes open or says no and the apprentice goes back to design. Either outcome is better than building a portfolio the clients did not actually understand the risk of."},
          {"type": "callout", "kind": "key", "content": "If the client cannot sign for the drawdown number in calm conversation, they cannot hold the portfolio in the actual drawdown. Find the allocation they can sign for. That is the right one."},
          {"type": "subheading", "content": "Closing the suitability loop"},
          {"type": "paragraph", "content": "When risk is communicated this way and the client agrees to the allocation in writing, suitability is not a paperwork exercise. It is a documented record of an informed decision. That is what regulators want to see. That is what clients want to remember when the drawdown actually arrives. That is the goal of this entire module — not to predict the future, but to prepare the relationship for whatever future shows up."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: now that you have the right allocation, you have to present the full plan in a way the client can actually absorb. Plan Presentation & Communication."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Risk capacity is best described as:", "options": ["How much loss the client can emotionally absorb", "How much loss the client can financially absorb without breaking the plan", "The annualized return needed to hit goals", "The standard deviation of the portfolio"], "correct": 1, "explanation": "Capacity is the objective financial measure — what the plan can survive. Tolerance is the emotional measure. Required return is the math need."},
        {"id": "q2", "prompt": "A 24-year-old client with stable income, a 40-year horizon, and high stated comfort with volatility wants to invest a down payment they will use in 18 months. The right portfolio decision is:", "options": ["Aggressive equity allocation since they have high tolerance", "Conservative cash or short-term instruments since capacity for this dollar is low", "Match their stated tolerance regardless of horizon", "60/40 by default"], "correct": 1, "explanation": "Capacity wins. The dollar is needed in 18 months — that is zero capacity for equity drawdown, no matter what tolerance the client states."},
        {"id": "q3", "prompt": "FINRA Rule 2111 includes which three suitability obligations?", "options": ["Disclosure, care, and conflict of interest", "Reasonable-basis, customer-specific, and quantitative suitability", "Capacity, tolerance, and required return", "Fees, performance, and benchmarks"], "correct": 1, "explanation": "Rule 2111 specifies reasonable-basis (product itself), customer-specific (right for this client), and quantitative (pattern of recommendations not excessive) suitability."},
        {"id": "q4", "prompt": "Regulation Best Interest (Reg BI) became effective in:", "options": ["June 2017", "January 2019", "June 2020", "January 2022"], "correct": 2, "explanation": "Reg BI became effective in June 2020 and raised the standard for broker-dealer recommendations to retail customers."},
        {"id": "q5", "prompt": "Form CRS is:", "options": ["A risk tolerance questionnaire", "A required client relationship summary explaining services, fees, conflicts, and standard of conduct", "A custodial agreement", "A tax form"], "correct": 1, "explanation": "Form CRS is the plain-English client relationship summary that broker-dealers and RIAs must deliver to retail clients under Reg BI."},
        {"id": "q6", "prompt": "When required return significantly exceeds reasonable capacity, the right move is to:", "options": ["Recommend a more aggressive portfolio to chase returns", "Reset the goals through some combination of saving more, working longer, spending less, or accepting lower success probability", "Switch to alternative investments", "Tell the client to be patient"], "correct": 1, "explanation": "Portfolio cannot solve a goals problem. Surface the math, walk the client through the levers, and let them choose."},
        {"id": "q7", "prompt": "Sequence-of-returns risk is most relevant to:", "options": ["Young accumulators with long horizons", "Clients in or near withdrawal from the portfolio", "Tax-advantaged accounts only", "Fixed-income investors"], "correct": 1, "explanation": "Sequence risk matters most when withdrawals are being taken — early drawdowns paired with withdrawals can permanently impair the plan."},
        {"id": "q8", "prompt": "Naomi scored 'Aggressive' on her risk questionnaire but panicked after an 18% drawdown. The right interpretation is:", "options": ["The questionnaire was useless", "Stated tolerance and revealed tolerance can differ; reassess based on lived behavior and document the change", "Naomi should be reclassified as Conservative", "Risk questionnaires should not be used"], "correct": 1, "explanation": "Stated tolerance under hypothetical scenarios is not the same as revealed behavior in real drawdowns. Reassess and document the reassessment."},
        {"id": "q9", "prompt": "Communicating risk to clients is most effective when:", "options": ["Standard deviation and Sharpe ratios are emphasized", "Risk is translated into dollar amounts on the client's actual balance and into historical experienced drawdowns", "Only positive outcomes are highlighted", "Probability of failure is never mentioned"], "correct": 1, "explanation": "Dollars and historical experience move clients in a way statistics do not. The goal is for the client to feel the risk before they have to live through it."},
        {"id": "q10", "prompt": "Suitability documentation should capture, at minimum:", "options": ["The recommendation only", "What was recommended, why suitable for this client, alternatives considered, disclosures made, and client response", "The fee schedule", "Marketing materials"], "correct": 1, "explanation": "The file note should let a reviewer reconstruct the reasoning years later, including alternatives considered and rejected and disclosures made."},
        {"id": "q11", "prompt": "When capacity exceeds required return — the client has more resources or time than they need — the appropriate response is to:", "options": ["Automatically recommend more aggressive growth", "Discuss with the client whether growth for heirs, philanthropy, or other purposes is desired, and let purpose drive allocation", "Move to all cash since growth is unnecessary", "Maintain the standard model regardless"], "correct": 1, "explanation": "When unnecessary risk is not needed, the right conversation is about purpose. Excess capacity becomes a choice, not a default."},
        {"id": "q12", "prompt": "At GIC, an apprentice operating under the supervision of a fiduciary advisor is held to:", "options": ["The suitability standard only", "The higher fiduciary standard, regardless of personal licensing", "No regulatory standard", "Whatever the client chooses"], "correct": 1, "explanation": "The fiduciary standard governs the work product at GIC. Apprentices learn and operate to the higher standard from day one."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 15;
