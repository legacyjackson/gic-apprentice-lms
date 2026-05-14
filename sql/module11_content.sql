-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 11 CONTENT
-- Goal-Setting & Prioritization
-- ============================================================================
update public.modules set
  title = 'Goal-Setting & Prioritization',
  competency_id = 'OJL-2',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'Turning vague aspirations into specific, time-bound, fundable goals — and helping clients choose between competing priorities when the math says they can''t have everything.',
  learning_objectives = ARRAY[
    'Translate vague client wishes into SMART planning goals.',
    'Apply a goal hierarchy that distinguishes survival, security, freedom, and legacy.',
    'Run trade-off conversations when client goals exceed available resources.',
    'Match each goal to an appropriate time horizon and funding strategy.',
    'Document goals in a way both client and colleague can reference.',
    'Update goals as life events and priorities shift over time.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "From Vague Wish to Plannable Goal",
      "summary": "What 'I want to retire someday' actually means when you turn it into something you can plan.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients rarely arrive with planning-ready goals. They arrive with wishes — 'I want to retire,' 'I want to be okay,' 'I want to give my kids a head start.' Half the value of a financial planning engagement is helping the client move from the wish to a specific, time-bound, fundable goal. Without that translation, the rest of the work is just guessing." },

        { "type": "callout", "kind": "key", "title": "The SMART standard, adapted for planning", "text": "<strong>Specific</strong> (what exactly), <strong>Measurable</strong> (in dollars or some unit), <strong>Actionable</strong> (achievable through identifiable steps), <strong>Relevant</strong> (connected to the client's actual values), and <strong>Time-bound</strong> (with a target year or age). Goals that lack any of these dimensions resist planning." },

        { "type": "heading", "text": "Examples of the translation" },
        { "type": "subheading", "text": "Vague: 'I want to retire someday.'" },
        { "type": "paragraph", "text": "Plannable: 'I want to retire by age 65 (in 23 years) with $75,000/year of inflation-adjusted spending power, lasting through age 95.'" },

        { "type": "subheading", "text": "Vague: 'I want to be financially comfortable.'" },
        { "type": "paragraph", "text": "Plannable: 'I want a fully funded 6-month emergency fund within 18 months, debt-free outside of mortgage within 5 years, and on track for retirement by age 50.'" },

        { "type": "subheading", "text": "Vague: 'I want to help my kids with college.'" },
        { "type": "paragraph", "text": "Plannable: 'I want to fund 4 years of in-state public university for each of my two kids — approximately $30,000/year in today's dollars, starting in 8 years for the older and 12 for the younger.'" },

        { "type": "subheading", "text": "Vague: 'I want to leave something for my children.'" },
        { "type": "paragraph", "text": "Plannable: 'I want at least $250,000 each to go to my two children after both my spouse and I are gone, in addition to whatever we use for our own care.'" },

        { "type": "heading", "text": "Why specificity matters" },
        { "type": "paragraph", "text": "Once a goal is specific, it can be:" },
        { "type": "list", "items": [
          "<strong>Costed.</strong> You know what it requires.",
          "<strong>Tracked.</strong> You can measure progress quarter-over-quarter.",
          "<strong>Traded off.</strong> When two goals compete, you can have the conversation in numbers, not feelings.",
          "<strong>Defended.</strong> The plan you build can be evaluated against the goal years later."
        ]},

        { "type": "callout", "kind": "do", "title": "The translation technique", "text": "When a client gives you a vague wish, ask the follow-ups that turn it into a SMART goal — gently, conversationally: \"When you imagine retiring, what age comes to mind?\" \"What does that look like — what would a typical week be?\" \"What kind of lifestyle — current spending, more, less?\" \"And if it doesn't work — if you couldn't retire then, what's the latest acceptable date?\" Each question adds a dimension. By the end you have a plannable goal in the client's own words." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Goal Hierarchy",
      "summary": "Survival, security, freedom, legacy — and which one wins when they collide.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Not all goals are equal. A simple hierarchy helps both advisor and client decide what comes first when resources are constrained — which is most of the time." },

        { "type": "callout", "kind": "key", "title": "The four levels", "text": "<strong>(1) Survival</strong> — meet current needs, protect against catastrophe.<br/><strong>(2) Security</strong> — eliminate destructive debt, build emergency reserves, ensure income protection.<br/><strong>(3) Freedom</strong> — accumulate assets that fund the life the client wants, with optionality.<br/><strong>(4) Legacy</strong> — transfer wealth or impact beyond the client's life." },

        { "type": "heading", "text": "Survival goals" },
        { "type": "list", "items": [
          "Meet monthly basic needs (housing, food, utilities, transportation, healthcare).",
          "Maintain employer health insurance or equivalent coverage.",
          "Make minimum payments on all debts to avoid default and credit damage.",
          "Protect against catastrophic income loss with appropriate insurance (life, disability, health)."
        ]},
        { "type": "paragraph", "text": "Survival goals win every trade-off. A plan that pushes investing or aggressive debt paydown while letting health insurance lapse or skipping mortgage payments is not a plan." },

        { "type": "heading", "text": "Security goals" },
        { "type": "list", "items": [
          "Build full 3–6 month emergency fund.",
          "Eliminate high-interest debt (credit cards, payday loans, anything 7%+).",
          "Capture employer 401(k) match.",
          "Establish adequate liability and umbrella coverage.",
          "Establish minimum-viable estate documents (will, POA, healthcare directive)."
        ]},

        { "type": "heading", "text": "Freedom goals" },
        { "type": "list", "items": [
          "Fully fund retirement (within tax-advantaged accounts, then taxable).",
          "Build assets that allow career flexibility, business launch, or other major life options.",
          "Pay down moderate-interest debt (mortgage acceleration, student loans).",
          "Fund children's education or other major dependent expenses.",
          "Build cash for major life purchases (home, second home, business)."
        ]},

        { "type": "heading", "text": "Legacy goals" },
        { "type": "list", "items": [
          "Estate planning above the minimum (trusts, advanced tax strategies).",
          "Wealth transfer to heirs.",
          "Charitable giving programs.",
          "Family business succession planning."
        ]},

        { "type": "callout", "kind": "do", "title": "The diagnostic question", "text": "<em>Which level of the hierarchy is this household truly secure at?</em> Many clients arrive saying 'I want to think about legacy' while their security level is incomplete. The advisor's job is to gently re-anchor: legacy planning is wonderful AND we need to make sure the foundation is solid first. The Marcus and Tasha households of the world don't need to talk about generational wealth transfer — they need to fix the periodic-expense gap from Module 1." },

        { "type": "callout", "kind": "warn", "title": "The exception to the hierarchy", "text": "Capture of employer 401(k) match (Security level) is typically worth doing even before the emergency fund is complete, because the match is effectively a 50–100% guaranteed return that disappears if not captured each year. Most planners adjust the hierarchy slightly for this single exception." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Trade-Offs When Goals Compete",
      "summary": "What to do when the math says the client can't have everything.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The most common moment in financial planning is the moment when the client's stated goals require more than their resources can produce. The advisor either runs an honest trade-off conversation or quietly builds an unrealistic plan that disappoints later. The first option is harder. It's also the job." },

        { "type": "heading", "text": "The trade-off conversation, structurally" },
        { "type": "numbered", "items": [
          "<strong>State the gap clearly.</strong> \"At your current savings rate, projected to retirement at 65, you'd have approximately $1.1M. Your stated need is approximately $1.8M. There's a gap of roughly $700,000 we need to close.\"",
          "<strong>Identify the levers.</strong> Save more, work longer, spend less in retirement, take more investment risk, get higher returns. Maybe inherit something. Those are the levers — there aren't others.",
          "<strong>Quantify each lever.</strong> What would it take? \"To close the gap by saving more, we'd need an additional $X per month. By delaying retirement to 67, the gap drops to $Y. By reducing retirement spending by 15%, $Z.\"",
          "<strong>Hand the choice to the client.</strong> The client decides which combination of levers fits their life. The advisor's job is to make the trade-off visible, not to choose for them.",
          "<strong>Document the decision and the alternatives considered.</strong> Years from now, both client and advisor should be able to remember why the plan looks the way it does."
        ]},

        { "type": "callout", "kind": "key", "title": "The reframe that helps", "text": "Don't ask <em>'what are you willing to give up?'</em> — it puts everything in the language of loss. Ask <em>'given these options, which version of this plan feels most like the life you want?'</em> Same trade-off, different emotional posture. The first frame produces resistance; the second produces choices." },

        { "type": "divider" },

        { "type": "heading", "text": "Trade-off scenarios" },
        { "type": "subheading", "text": "Retirement vs. kids' college" },
        { "type": "paragraph", "text": "The clearest competing-goal scenario for parents. The right answer almost always tilts toward retirement because:" },
        { "type": "list", "items": [
          "Children can borrow for college; parents cannot borrow for retirement.",
          "Time-value-of-money math heavily favors letting retirement assets compound longer.",
          "If parents under-save and can't retire, the burden may eventually fall on the children anyway."
        ]},
        { "type": "paragraph", "text": "Most planners recommend funding retirement first, then funding college from the remaining capacity. This is not what most parents want to hear, and the conversation requires care — but the math is consistent." },

        { "type": "subheading", "text": "Debt paydown vs. investing" },
        { "type": "paragraph", "text": "Generally, compare guaranteed debt rate to expected after-tax investment return:" },
        { "type": "list", "items": [
          "Debt rate above expected investment return → pay debt first (mathematical certainty).",
          "Debt rate near or below expected investment return → behavioral and tax considerations dominate. Many clients sleep better with debt paid down, even if math is slightly against it. Tax-deductibility of mortgage interest can shift the comparison.",
          "Very low-rate debt (e.g., 2.5% mortgage in 2021) — most planners recommend investing instead of accelerating paydown."
        ]},

        { "type": "subheading", "text": "Lifestyle now vs. wealth later" },
        { "type": "paragraph", "text": "The deepest values question in personal finance. The advisor's role is not to impose a value, but to make the trade-off visible:" },
        { "type": "list", "items": [
          "What does an extra $1,000/month of current lifestyle cost in eventual retirement income? (Use TVM from Module 2.)",
          "What does saving an extra $1,000/month now buy in retirement income?",
          "Neither answer is right. Clients have to choose, and they choose better when they see the math."
        ]},

        { "type": "case_study",
          "title": "The Marcus and Tasha trade-off",
          "scenario": "Marcus (42) and Tasha (41) want to: (1) save more for retirement, (2) help both their kids go to college without student debt, (3) take a major family trip every other year, and (4) eventually buy a second home in the mountains for retirement. Combined gross income $148,000. Current saving capacity after the fixes from Module 1: roughly $30,000/year.",
          "discussion": "<p>The total cost of all four goals far exceeds what $30,000/year can fund over the remaining 23 years to retirement. Trade-off conversation:</p><ul><li><strong>Retirement (must-fund):</strong> $20,000/year going into 401(k)s and Roth IRAs. Realistic projected balance at 65: roughly $1.6M.</li><li><strong>College (modify the goal):</strong> $5,000/year into 529 accounts. Won't fully fund both kids at private schools, but covers in-state public university with modest gap they could finance.</li><li><strong>Travel (annualize):</strong> $3,000/year into a sinking fund for trips every other year. They don't give it up — they fund it explicitly.</li><li><strong>Mountain home (defer or modify):</strong> Honestly tabled for the next 5 years. Revisit when retirement is more secure and college is more in view. Possibly funded by a downsize of the primary home at retirement.</li></ul><p>The plan now fits the available resources, and the client makes the choices about which goals get priority. Both Marcus and Tasha know what's funded, what's modified, and what's deferred. <strong>That's planning. The plan that quietly fails to mention the mountain home is fragile until the day they bring it up.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Matching Goals to Time Horizons",
      "summary": "Money for next year and money for 30 years from now do not live in the same place.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every goal has a time horizon. The time horizon determines where the money should live — cash, bonds, stocks, real estate, illiquid alternatives — because the right investment for one horizon is the wrong investment for another." },

        { "type": "callout", "kind": "key", "title": "The horizon-allocation principle", "text": "Money needed soon must be safe and liquid. Money needed later can take risk for higher expected returns. Mismatching these is one of the most common and costly errors in personal finance." },

        { "type": "heading", "text": "Standard horizons and allocation" },
        { "type": "subheading", "text": "0–1 year — Cash" },
        { "type": "list", "items": [
          "Emergency fund.",
          "Money for known near-term expenses (taxes due, planned major purchases, tuition coming up).",
          "Vehicle: High-yield savings, money market, short Treasuries. No exposure to market volatility."
        ]},

        { "type": "subheading", "text": "1–5 years — Conservative" },
        { "type": "list", "items": [
          "Down payment on a home being purchased in a couple of years.",
          "Education funding for a child currently in late high school.",
          "Sabbatical or career-transition cash.",
          "Vehicle: Short- to intermediate-term Treasuries, CDs, conservative bond funds, modest equity exposure (15–30%) only if some flexibility on timing exists."
        ]},

        { "type": "subheading", "text": "5–15 years — Balanced" },
        { "type": "list", "items": [
          "Education funding for younger children.",
          "Major lifestyle goals (career change, business launch, second home).",
          "Mid-career retirement assets approaching withdrawal.",
          "Vehicle: Balanced portfolio (40–70% equities), typically diversified across asset classes."
        ]},

        { "type": "subheading", "text": "15+ years — Growth" },
        { "type": "list", "items": [
          "Long retirement.",
          "Young children's college (when child is under 6).",
          "Multi-generational wealth.",
          "Vehicle: Growth-oriented portfolio (70–100% equities), diversified globally. Long horizon allows volatility to wash out."
        ]},

        { "type": "callout", "kind": "warn", "title": "The classic horizon mistake", "text": "Putting house-down-payment money (3-year horizon) into the stock market because returns look attractive. If the market drops 30% in year 2, the timing of the home purchase is broken. Conversely: keeping decades' worth of retirement savings in cash because of fear, missing the growth that long horizons are <em>for</em>. Both are common; both are expensive." },

        { "type": "heading", "text": "When horizons overlap" },
        { "type": "paragraph", "text": "Retirement isn't a single moment — it's a 30-year withdrawal period. Different layers of the retirement portfolio serve different horizons within retirement itself:" },
        { "type": "list", "items": [
          "<strong>Years 1–3</strong> of retirement spending: cash and short bonds, so a market crash doesn't force sales at the bottom.",
          "<strong>Years 4–10</strong>: intermediate bonds and balanced exposure.",
          "<strong>Years 10+</strong>: growth-oriented, because the money won't be touched for a decade."
        ]},
        { "type": "paragraph", "text": "This is the foundation of the bucket strategy or sequence-of-returns management — covered more deeply in the Retirement Planning module (CORE-7). Discovery and goal-setting is where the horizons get clarified; portfolio construction is where they get implemented." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Documenting Goals and Keeping Them Alive",
      "summary": "Goals don't stay set. They evolve as life evolves.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "Goals are not set once and filed away. They change as life changes — and the advisor who treats them as a one-time exercise eventually has a plan that no longer fits the client. Living documents only stay living through ongoing care." },

        { "type": "heading", "text": "What goal documentation includes" },
        { "type": "list", "items": [
          "Goal statement in plain language, in the client's words where possible.",
          "Target dollar amount (in today's dollars and/or future dollars, with assumption documented).",
          "Target date or age.",
          "Priority level — must-fund, important, aspirational. Helps when trade-offs come up later.",
          "Funding source — which account, which monthly contribution.",
          "Status — on track, behind, ahead.",
          "Last review date."
        ]},

        { "type": "heading", "text": "Review cadence" },
        { "type": "list", "items": [
          "<strong>Annually</strong>: full review with the client. What changed? What new goals? What old goals are no longer relevant? Status of each.",
          "<strong>Quarterly</strong>: light check-in. Status updates, any urgent changes flagged.",
          "<strong>Life-event triggered</strong>: marriage, divorce, child, job change, inheritance, health diagnosis, business sale — any of these may demand an unscheduled goals refresh."
        ]},

        { "type": "callout", "kind": "do", "title": "The closing question for every review", "text": "\"Has anything changed in the last 12 months that we should think about?\" Open enough that something might surface. Direct enough that the client knows you actually want to hear it. Specific examples worth probing: jobs, dependents, health, family relationships, business situations, large purchases planned." },

        { "type": "callout", "kind": "key", "title": "Why goals are the deliverable, not the plan", "text": "Clients often think the deliverable of financial planning is the plan document — the binder, the dashboard, the projection. It isn't. The deliverable is <em>clarity about what they're building toward and confidence that the plan supports it</em>. The numbers serve the goals; the goals don't serve the numbers. Counselors who keep this orientation produce better advice and longer-lasting client relationships." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What does it mean to translate a 'wish' into a SMART goal?",
        "options": [
          "Make it sound more professional in writing.",
          "Make it Specific, Measurable, Actionable, Relevant, and Time-bound.",
          "Use SMART software for tracking.",
          "Add a budget to it."
        ],
        "correct": 1,
        "explanation": "SMART criteria — specificity, measurability, actionability, relevance, and time-bound — convert vague wishes ('I want to retire someday') into plannable goals ('I want to retire at 65 with $75,000/year inflation-adjusted spending lasting through age 95')."
      },
      {
        "id": "q2",
        "prompt": "Which level of the goal hierarchy comes first in trade-offs?",
        "options": [
          "Legacy",
          "Freedom",
          "Security",
          "Survival"
        ],
        "correct": 3,
        "explanation": "Survival (basic needs, catastrophic protection) wins every trade-off. A plan that pushes investing while letting health insurance lapse isn't a plan."
      },
      {
        "id": "q3",
        "prompt": "What is the typical exception to the strict goal hierarchy?",
        "options": [
          "Charitable giving comes before retirement.",
          "Capturing employer 401(k) match is typically done even before the emergency fund is complete, because the match is essentially a guaranteed 50–100% return that disappears if not captured.",
          "Estate planning comes before debt paydown.",
          "Insurance comes after investing."
        ],
        "correct": 1,
        "explanation": "Employer match is the rare guaranteed return that expires annually. Most planners advise capturing the match even before fully building the emergency fund. Few other goals justify departing from the survival → security → freedom → legacy order."
      },
      {
        "id": "q4",
        "prompt": "When client goals exceed available resources, the right move is:",
        "options": [
          "Quietly build the most realistic plan you can and hope they don't notice.",
          "Refuse to plan.",
          "State the gap clearly, identify and quantify the levers (save more, work longer, spend less, take more risk), then hand the choice to the client and document the decision.",
          "Tell them their goals are unrealistic."
        ],
        "correct": 2,
        "explanation": "The trade-off conversation, run honestly, is what financial planning IS. Make the gap visible, quantify the levers, let the client choose the combination that fits their life. Document the alternatives considered."
      },
      {
        "id": "q5",
        "prompt": "When retirement funding and college funding compete for the same dollar, the typical recommendation is to prioritize retirement because:",
        "options": [
          "Retirement is more important than children.",
          "Children can borrow for college, but parents cannot borrow for retirement; under-saved parents may eventually become a burden on the children anyway.",
          "Tax laws favor it.",
          "College is not really necessary."
        ],
        "correct": 1,
        "explanation": "The math and structural logic favor retirement first. Children have access to loans; parents don't. Under-funded retirement often forces eventual reliance on adult children — the very thing parents typically want to avoid. Not what most parents want to hear, but consistent."
      },
      {
        "id": "q6",
        "prompt": "Money needed within 1 year should live in:",
        "options": [
          "A diversified stock portfolio for growth.",
          "Real estate.",
          "High-yield savings, money market, or short Treasuries — safe and liquid.",
          "Long-term bonds."
        ],
        "correct": 2,
        "explanation": "Short horizon = no exposure to market volatility. The right investment for a 30-year goal is the wrong investment for a 1-year goal. Mismatching is one of the most expensive errors in personal finance."
      },
      {
        "id": "q7",
        "prompt": "Money for a goal 15+ years away can appropriately be invested in:",
        "options": [
          "Mostly cash to avoid volatility.",
          "Mostly stocks (70–100%), diversified globally — long horizon allows volatility to wash out and growth to compound.",
          "Only certificates of deposit.",
          "Real estate only."
        ],
        "correct": 1,
        "explanation": "Long horizons are what growth investing is for. Cash for a 30-year goal nearly guarantees underperformance to inflation. Equity volatility, painful in 1-year windows, washes out across 15+ year horizons in historical data."
      },
      {
        "id": "q8",
        "prompt": "Within a retirement portfolio, why might different 'buckets' have different time horizons?",
        "options": [
          "Bucket strategies are gimmicks.",
          "Different years of retirement spending have different time horizons — the first few years are short-horizon and need safety, while later decades remain long-horizon and benefit from growth exposure.",
          "Tax law requires bucketing.",
          "It increases trading fees."
        ],
        "correct": 1,
        "explanation": "Retirement is a 30-year withdrawal period, not a single moment. Money needed in years 1–3 of retirement is short-horizon; money needed in years 15–30 is still long-horizon. Bucketing aligns each layer of the portfolio to its actual time horizon, mitigating sequence-of-returns risk."
      },
      {
        "id": "q9",
        "prompt": "How often should goals be reviewed?",
        "options": [
          "Once when the plan is built, then never.",
          "Annually with the client, with lighter quarterly check-ins and life-event-triggered updates as needed.",
          "Only when the client asks.",
          "Every five years."
        ],
        "correct": 1,
        "explanation": "Annual full reviews. Quarterly light check-ins. Plus immediate refresh on major life events (marriage, divorce, child, job change, inheritance, health, business sale). Goals are living documents."
      },
      {
        "id": "q10",
        "prompt": "What is the closing question worth asking in every review?",
        "options": [
          "Are you happy with our returns?",
          "Has anything changed in the last 12 months that we should think about?",
          "Do you want to add money?",
          "Should we increase your risk?"
        ],
        "correct": 1,
        "explanation": "Open enough to surface things you don't know. Direct enough that the client knows you actually want to hear. Captures the life events that change priorities — job, family, health, relationships, business — before they break the plan."
      },
      {
        "id": "q11",
        "prompt": "What is the deliverable of financial planning, really?",
        "options": [
          "The binder, plan document, or dashboard.",
          "Clarity about what the client is building toward and confidence that the plan supports it.",
          "The portfolio.",
          "A signed agreement."
        ],
        "correct": 1,
        "explanation": "The artifacts are not the deliverable. The deliverable is clarity and confidence. Counselors who keep this orientation produce better advice and longer client relationships. The numbers serve the goals — not the other way around."
      },
      {
        "id": "q12",
        "prompt": "A client says 'I want to think about legacy planning' but their cash flow shows a structural monthly deficit. What's the right reframe?",
        "options": [
          "Build the legacy plan; cash flow is separate.",
          "Refuse to discuss legacy until they fix the cash flow.",
          "Gently re-anchor: legacy planning is wonderful, AND we need to make sure the foundation is solid first. Address the cash flow gap as the immediate priority while keeping the legacy goal in view.",
          "Tell them they can't afford to think about legacy."
        ],
        "correct": 2,
        "explanation": "Honor the aspiration while honestly assessing where they truly are in the goal hierarchy. Most clients who want to discuss legacy planning are still working on security — they may not realize it. The gentle re-anchor preserves the relationship and refocuses on the work that has to happen first."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 11;
