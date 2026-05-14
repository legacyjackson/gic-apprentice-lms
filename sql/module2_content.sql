-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 2 CONTENT
-- Time Value of Money & Compounding
-- ============================================================================
-- Updates module 2 metadata + content. Status remains 'draft' until Cathy
-- Jackson-Gent approves via the admin UI. Safe to re-run; uses UPDATE.
-- ============================================================================

update public.modules set
  title = 'Time Value of Money & Compounding',
  competency_id = 'CORE-2',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The single most important mathematical idea in personal finance: why a dollar today is not a dollar tomorrow, and how time turns small differences into life-changing ones.',
  learning_objectives = ARRAY[
    'Explain why money has time value and articulate the four drivers behind it.',
    'Compute present value and future value of single cash flows by hand and with a spreadsheet.',
    'Apply the Rule of 72 to estimate doubling times and required rates of return.',
    'Distinguish nominal from real returns and compute inflation-adjusted outcomes.',
    'Choose the right model — single sum, annuity, or growing stream — for a given client question.',
    'Explain compounding to a client in plain language using a worked example.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Money Has Time Value",
      "summary": "The single most important math idea in personal finance, in plain language.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "If a client offered you $10,000 today or $10,000 in five years, the choice is obvious. The interesting question is <em>why</em> — and the answer underwrites almost every recommendation a Wealth Solutions Counselor will ever make." },
        { "type": "paragraph", "text": "Money has <strong>time value</strong>. A dollar in hand today is worth more than a dollar promised later. Internalize this until it feels obvious; the math that follows is the formal expression of it." },

        { "type": "heading", "text": "The four drivers" },
        { "type": "numbered", "items": [
          "<strong>Opportunity cost.</strong> A dollar today can be invested. That dollar working for you is a dollar you don't have to wait for. The return you give up by waiting is the opportunity cost of delay.",
          "<strong>Inflation.</strong> Prices rise. The same dollar buys less next year than this year. Even if the nominal number is preserved, purchasing power isn't.",
          "<strong>Risk and uncertainty.</strong> A promise to pay you later carries the risk it won't be honored. The dollar in hand has resolved that risk; the dollar later has not.",
          "<strong>Preference.</strong> Humans generally prefer present consumption over future consumption. We discount the future not just because the math says we should, but because we're wired to."
        ]},

        { "type": "callout", "kind": "key", "title": "Why this matters in practice", "text": "Every retirement projection, every \"should I take the lump sum or the pension?\" question, every \"is it worth refinancing?\" calculation rests on time value of money. Without fluency here, an advisor can only repeat rules of thumb. With it, they can actually answer the question on the table." },

        { "type": "heading", "text": "The two operations" },
        { "type": "paragraph", "text": "There are really only two moves to learn:" },
        { "type": "list", "items": [
          "<strong>Compounding</strong> — moving money <em>forward</em> in time. What is $1 today worth in 30 years at 7%?",
          "<strong>Discounting</strong> — moving money <em>backward</em> in time. What is a $100,000 inheritance 20 years from now worth today at 5%?"
        ]},
        { "type": "paragraph", "text": "Every financial calculation in this module is one of those two operations, sometimes applied to a single dollar, sometimes applied to a stream of dollars. Get them in your fingertips and the rest becomes mechanical." },

        { "type": "callout", "kind": "do", "title": "The fluency reflex", "text": "When a client says \"I'll have $500,000 saved by retirement,\" your reflex should be: <em>in what year, and in today's dollars or future dollars?</em> That single question separates an advisor who can plan from one who can only recite numbers." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Present Value and Future Value",
      "summary": "The two formulas underneath every plan you'll ever build.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two formulas do nearly all the work. Memorize the structure, not just the symbols — once you can write them from memory and explain what each piece means, you've crossed the line from rule-of-thumb advisor to fluent one." },

        { "type": "heading", "text": "Future Value of a single sum" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>FV = PV × (1 + r)<sup>n</sup></strong><br/>Where PV is the present amount, r is the periodic rate, and n is the number of periods." },
        { "type": "paragraph", "text": "Example: $10,000 today, invested at 7% annually for 30 years." },
        { "type": "list", "items": [
          "FV = 10,000 × (1.07)<sup>30</sup>",
          "FV = 10,000 × 7.6123",
          "FV ≈ <strong>$76,123</strong>"
        ]},
        { "type": "paragraph", "text": "Notice what happened: the original $10,000 grew to more than seven times itself. The earning generated more earnings, which generated still more. That's compounding — and it's the engine behind every long-horizon plan." },

        { "type": "heading", "text": "Present Value of a single sum" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>PV = FV ÷ (1 + r)<sup>n</sup></strong><br/>The same equation, rearranged to ask the opposite question." },
        { "type": "paragraph", "text": "Example: A client expects to inherit $250,000 in 15 years. If you discount at 5% (the rate they could reasonably earn on safe money), what's that inheritance worth today in their plan?" },
        { "type": "list", "items": [
          "PV = 250,000 ÷ (1.05)<sup>15</sup>",
          "PV = 250,000 ÷ 2.0789",
          "PV ≈ <strong>$120,257</strong>"
        ]},
        { "type": "paragraph", "text": "The expected inheritance is real money, but it is not <em>today's</em> money. When you build a current-state net worth statement, you do not list it at $250,000 — that overstates the client's actual position. Either omit it (the conservative approach) or list it at present value with a note about discount rate and timing." },

        { "type": "callout", "kind": "warn", "title": "The most common mistake", "text": "Mixing nominal and discounted figures inside the same plan. If retirement spending is in today's dollars, future portfolio values must also be in today's dollars — or both must be in future dollars. Pick one frame and stay there. Otherwise the plan looks fine on paper and fails in reality." },

        { "type": "heading", "text": "The variables to think about" },
        { "type": "glossary", "terms": [
          { "term": "Rate (r)", "definition": "The expected return per period, expressed as a decimal. 7% per year is 0.07. Be careful: if periods are monthly, the rate must also be monthly — divide annual by 12." },
          { "term": "Periods (n)", "definition": "The number of compounding periods, not the number of years. Monthly compounding over 30 years means n = 360, not n = 30." },
          { "term": "Discount rate", "definition": "The rate used to bring future dollars back to today. Often the expected long-term return on safe assets, or the client's after-tax investment hurdle." },
          { "term": "Effective annual rate (EAR)", "definition": "The actual annualized return after accounting for compounding frequency. 6% compounded monthly is an EAR of about 6.17%." }
        ]},

        { "type": "activity", "title": "Build the spreadsheet you'll use forever", "prompt": "Open a spreadsheet. In separate cells, build a small FV/PV calculator you can reuse with clients.", "steps": [
          "Cell A1: \"Present Value\". A2: 10000.",
          "Cell B1: \"Rate (annual)\". B2: 0.07.",
          "Cell C1: \"Years\". C2: 30.",
          "Cell D1: \"Future Value\". D2: =A2*(1+B2)^C2.",
          "Confirm D2 reads approximately 76,123. Now play with B2 and C2 to feel how returns and time interact.",
          "Add a second row for PV: PV = FV/(1+r)^n. Use it on the $250,000-in-15-years example."
        ]}
      ]
    },

    {
      "id": "lesson-3",
      "title": "Compounding and the Rule of 72",
      "summary": "The engine of long-horizon wealth, and the back-of-envelope trick every advisor uses.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Compounding is what Einstein (apocryphally) called the most powerful force in the universe. Whether or not he said it, the math is real: when returns earn returns, growth accelerates non-linearly. A counselor who teaches a 25-year-old to save $300/month with confidence in this idea changes the trajectory of a life." },

        { "type": "heading", "text": "Simple vs. compound interest" },
        { "type": "paragraph", "text": "<strong>Simple interest</strong> pays only on the original principal. $1,000 at 7% simple yields $70 per year, every year. After 30 years: $1,000 + (30 × $70) = $3,100." },
        { "type": "paragraph", "text": "<strong>Compound interest</strong> pays on principal <em>and</em> accumulated earnings. The $70 you earned in year one earns its own return in year two. After 30 years at 7% compounded annually: $1,000 × (1.07)<sup>30</sup> ≈ <strong>$7,612</strong>. More than double the simple result, from the same starting principal and the same rate." },
        { "type": "callout", "kind": "key", "title": "Time does the heavy lifting", "text": "Compound growth is shallow early and steep late. The first decade looks modest; the last decade looks miraculous. Clients who quit early miss the part of the curve they were waiting for." },

        { "type": "heading", "text": "The Rule of 72" },
        { "type": "callout", "kind": "key", "text": "<strong>Years to double ≈ 72 ÷ rate</strong><br/>At 6% annual returns, money doubles every ~12 years. At 9%, every ~8 years. At 4%, every ~18 years." },
        { "type": "paragraph", "text": "It's an approximation, not a precise formula, but it's accurate enough to do in your head while a client is asking a question. Use it to estimate doubling times, to back into required rates, and to make compounding feel concrete in conversation." },

        { "type": "subheading", "text": "Sample uses" },
        { "type": "list", "items": [
          "Client is 35 and has $50,000 invested. At an expected 7% return, the money roughly doubles every 10 years (72 ÷ 7). By age 65 — three doublings — it's roughly $400,000, before any additional contributions.",
          "Client wants to double their money in 6 years. They'd need approximately 12% returns (72 ÷ 6). Use that to anchor a conversation about realistic expectations and risk.",
          "Client says their CD pays 4.5%. Their money doubles every ~16 years. Helpful frame when comparing to an alternative investment."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Why small differences in rate become enormous" },
        { "type": "paragraph", "text": "Take three clients, each saving $500/month from age 25 to age 65 — same amount, same length, different rates. Watch what happens:" },
        { "type": "list", "items": [
          "At <strong>4%</strong> annual return: ~$590,000 at retirement.",
          "At <strong>7%</strong> annual return: ~$1,300,000 at retirement.",
          "At <strong>10%</strong> annual return: ~$3,160,000 at retirement."
        ]},
        { "type": "paragraph", "text": "Same person. Same monthly habit. Same career. The difference is rate of return and the multiplicative power of time. That gap is why advisor choices about fees, asset allocation, and tax efficiency matter — they shift the rate slightly, and the slight shift, compounded for decades, becomes life-altering." },

        { "type": "callout", "kind": "warn", "title": "The honest caveat", "text": "These projections assume constant returns. Real markets don't deliver constant returns — they deliver sequences. A bad sequence early in accumulation hurts less than a bad sequence early in retirement, but both matter. Compounding math is a planning tool, not a prophecy." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Discounting and Decision-Making",
      "summary": "Running the math backwards: how to compare options that pay off at different times.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Discounting is compounding run backwards. It's the move that lets you compare apples to apples when one option pays now and another pays later." },

        { "type": "heading", "text": "Why discounting matters" },
        { "type": "paragraph", "text": "Clients constantly face comparison problems where the cash flows are at different times:" },
        { "type": "list", "items": [
          "Take the $50,000 lump sum bonus today or the $60,000 deferred for three years?",
          "Take Social Security at 62 or wait until 70?",
          "Pay off the mortgage now with savings or invest and pay it down on schedule?",
          "Lease or buy the car?",
          "Pay tuition out of pocket or take the loan?"
        ]},
        { "type": "paragraph", "text": "None of these questions can be answered honestly without putting all the cash flows on a common time footing. That common footing is <em>present value</em>." },

        { "type": "heading", "text": "Picking a discount rate" },
        { "type": "paragraph", "text": "The choice of discount rate is consequential. A higher rate makes future money look worth less today; a lower rate makes it look worth more. Common practice:" },
        { "type": "list", "items": [
          "<strong>For safe, near-certain flows</strong> (Social Security, pension, Treasury): use a low rate, often the long-term inflation-adjusted Treasury yield (1–3% real).",
          "<strong>For risky flows</strong> (stock returns, business earnings): use a higher rate that compensates for the risk (often 6–10% nominal).",
          "<strong>For client-specific decisions</strong> (refinance, lump-sum vs. annuity): use the client's after-tax expected portfolio return as a defensible default.",
          "<strong>For comparisons against a known alternative</strong>: use the rate of the alternative as the discount rate. If the choice is \"take the cash or invest it,\" discount future cash flows at the rate you'd actually earn investing."
        ]},
        { "type": "callout", "kind": "do", "title": "Show your work", "text": "Always document the discount rate used and the rationale. Two equally smart advisors can defensibly produce different answers using different discount rates. Documenting the choice converts the analysis from a guess into a defensible recommendation." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The pension decision",
          "scenario": "A 60-year-old client is offered a choice from her employer: take a $400,000 lump sum today, or take a single-life annuity of $24,000/year for life starting at age 65. She is in good health; life expectancy is 87. Her after-tax expected portfolio return is 5%. Which option is mathematically larger?",
          "discussion": "<p>Twenty-two annual payments of $24,000 from age 65 to age 87. Discount each back to age 60 at 5%.</p><p>Approximate present value of the annuity stream at age 60: ~<strong>$280,000</strong>. (Each payment discounted to today, then summed.)</p><p>Lump sum: <strong>$400,000</strong>.</p><p>Mathematically, the lump sum is larger — by about $120,000 in present-value terms. But the analysis isn't done. The pension is insured against longevity (it pays as long as she lives), and the lump sum is exposed to market risk and her own withdrawal discipline. A complete recommendation weighs the math <em>and</em> the structural risk. Often the right answer for a healthy, disciplined investor is the lump sum; for an unsteady investor or someone with strong longevity in the family, it's the pension. Present value gives you the floor for the conversation — not the ceiling.</p>"
        },

        { "type": "callout", "kind": "key", "title": "The frame to teach clients", "text": "<em>\"Future dollars are smaller dollars. How much smaller depends on how long you wait and what you could have done with the money in the meantime. My job is to make sure we're comparing dollars on the same time footing — that's why I'll talk about present value.\"</em>" }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Annuities, Lump Sums, and Payment Streams",
      "summary": "Single flows vs. multiple flows — recognizing which math to use.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Real client situations rarely involve a single cash flow. They involve streams — monthly contributions over a career, monthly withdrawals in retirement, recurring premium payments, mortgage installments. The math for streams is built on the math for single sums, but it has a few special-case shortcuts worth knowing." },

        { "type": "heading", "text": "Ordinary annuity vs. annuity due" },
        { "type": "list", "items": [
          "<strong>Ordinary annuity</strong> — payments at the <em>end</em> of each period. Most loans, most savings contributions, most bond coupons.",
          "<strong>Annuity due</strong> — payments at the <em>beginning</em> of each period. Most rent, most insurance premiums, most lease payments."
        ]},
        { "type": "paragraph", "text": "The difference matters: an annuity due is worth slightly more than an ordinary annuity of the same payments, because each dollar has one extra period to earn. Most calculators and spreadsheets let you specify which type; check the default before trusting the answer." },

        { "type": "heading", "text": "Future value of an annuity" },
        { "type": "paragraph", "text": "How much will regular contributions grow to? This is the question behind every retirement projection:" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>FV<sub>annuity</sub> = PMT × [((1 + r)<sup>n</sup> − 1) ÷ r]</strong>" },
        { "type": "paragraph", "text": "Example: $500/month into a retirement account, 7% annual return, 30 years." },
        { "type": "list", "items": [
          "Monthly rate: 0.07 ÷ 12 = 0.005833",
          "Periods: 30 × 12 = 360",
          "FV = 500 × [((1.005833)<sup>360</sup> − 1) ÷ 0.005833]",
          "FV ≈ <strong>$609,985</strong>"
        ]},
        { "type": "paragraph", "text": "Notice: the client contributed a total of $500 × 360 = $180,000. The remaining $430,000+ is compound growth. That ratio gets more dramatic the longer the time horizon. It's why starting young matters so much." },

        { "type": "heading", "text": "Present value of an annuity" },
        { "type": "paragraph", "text": "What is a stream of future payments worth right now? Used for pension valuations, lottery cash-vs-annuity decisions, mortgage payoff math, and bond pricing:" },
        { "type": "callout", "kind": "key", "title": "Formula", "text": "<strong>PV<sub>annuity</sub> = PMT × [(1 − (1 + r)<sup>−n</sup>) ÷ r]</strong>" },
        { "type": "paragraph", "text": "Example: A pension paying $30,000/year for 20 years, discounted at 5%." },
        { "type": "list", "items": [
          "PV = 30,000 × [(1 − (1.05)<sup>−20</sup>) ÷ 0.05]",
          "PV = 30,000 × 12.4622",
          "PV ≈ <strong>$373,866</strong>"
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "When the stream grows" },
        { "type": "paragraph", "text": "Real cash flow streams often aren't flat — retirement spending usually rises with inflation, salaries grow over a career, business revenue compounds. A <strong>growing annuity</strong> adjusts the formula:" },
        { "type": "callout", "kind": "key", "title": "Growing annuity PV", "text": "<strong>PV = PMT × [1 − ((1 + g) ÷ (1 + r))<sup>n</sup>] ÷ (r − g)</strong><br/>Where g is the growth rate of the payments. Requires r > g, otherwise the math diverges." },
        { "type": "callout", "kind": "note", "title": "When you'll really use this", "text": "Building a retirement spending plan where expenses grow with inflation, or pricing a business with growing earnings. For most client conversations, having a financial planning calculator (like the ones in MoneyGuide, RightCapital, or even a competent spreadsheet) handle the math is fine — but knowing what the model is doing under the hood lets you challenge a result that doesn't pass the smell test." },

        { "type": "case_study",
          "title": "How much will Marcus and Tasha have at 65?",
          "scenario": "Marcus and Tasha (couple from Module 1) are 42 and 41 respectively. They're contributing $1,800/month combined to retirement accounts. Expected 7% return until retirement at 65. What's their projected nest egg if they keep their current pace?",
          "discussion": "<p>Treat as ordinary annuity. Monthly contributions $1,800. Monthly rate 0.07/12 = 0.005833. Periods = 24 × 12 = 288.</p><p>FV ≈ <strong>$1,506,000</strong>.</p><p>That number is meaningless without context: <em>is it enough?</em> A common rule of thumb is the 4% safe withdrawal rule — $1.5M supports ~$60,000/year of inflation-adjusted spending. Compare to their needs (which we'd compute separately). Once you have current trajectory and projected need, you can tell whether the plan is on track or has a gap to close. <strong>That</strong> is what time value of money lets you do that intuition alone never can.</p>"
        }
      ]
    },

    {
      "id": "lesson-6",
      "title": "Inflation, Real vs. Nominal, and the Honest Plan",
      "summary": "The silent variable that turns optimistic plans into disappointing ones.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every long-term plan must answer one question honestly: <em>what will the dollars actually buy?</em> A retirement projection that says \"you'll have $2 million\" is incomplete without specifying what $2 million in 2050 will purchase compared to $2 million today. The bridge between those is inflation." },

        { "type": "heading", "text": "Nominal vs. real" },
        { "type": "list", "items": [
          "<strong>Nominal return</strong> — the raw return without adjustment. The number on the statement.",
          "<strong>Real return</strong> — the return after subtracting inflation. The actual increase in purchasing power.",
          "<strong>Real ≈ Nominal − Inflation</strong> (more precisely: (1 + nominal) / (1 + inflation) − 1, but the subtraction is a fine approximation for advisor work)."
        ]},
        { "type": "paragraph", "text": "Long-run U.S. stock returns are often quoted around 10% nominal. Long-run inflation has averaged around 3%. So the long-run <em>real</em> return on stocks is closer to 7% — and 7% is the number a retirement plan should use if expenses are stated in today's dollars." },

        { "type": "callout", "kind": "warn", "title": "The most common plan failure", "text": "Building a plan with a 10% expected return on the portfolio and a flat retirement spending number in today's dollars. The math is mixed: stocks grow at the nominal rate, but expenses also grow with inflation. Either model both in real terms (7% return, today's spending, no inflation on expenses) or both in nominal terms (10% return, growing spending). Picking one frame and staying there is the difference between a plan that works and one that quietly fails." },

        { "type": "heading", "text": "The inflation calculation" },
        { "type": "paragraph", "text": "How much will $80,000 of annual spending today cost in 30 years at 3% inflation?" },
        { "type": "list", "items": [
          "FV = 80,000 × (1.03)<sup>30</sup>",
          "FV = 80,000 × 2.4273",
          "FV ≈ <strong>$194,000</strong>"
        ]},
        { "type": "paragraph", "text": "The client doesn't need to budget $194,000 in 2055 because they're suddenly extravagant. They need to budget $194,000 because that's what $80,000 of today's lifestyle costs at that point." },

        { "type": "subheading", "text": "Categories that inflate differently" },
        { "type": "paragraph", "text": "Headline CPI is an average. Some categories run hotter:" },
        { "type": "list", "items": [
          "<strong>Healthcare</strong> — historically 4–6% per year, well above headline CPI. Material for any retiree projection.",
          "<strong>Higher education</strong> — historically 5–7% per year, though slowing recently. Critical if college costs are in the plan.",
          "<strong>Housing</strong> — varies widely by region; coastal markets have run far above CPI for decades.",
          "<strong>Technology/electronics</strong> — sometimes deflationary."
        ]},
        { "type": "callout", "kind": "do", "title": "Inflation rates worth using as defaults", "text": "Headline CPI: 3% as a long-term planning assumption. Healthcare: 5%. Higher education: 5%. Override defaults with current data when running a plan; default rates are starting points, not destinations." },

        { "type": "divider" },

        { "type": "heading", "text": "Real returns by asset class — long-run estimates" },
        { "type": "paragraph", "text": "Useful long-run real return assumptions for planning, in approximate ranges (these vary by source; always document yours):" },
        { "type": "list", "items": [
          "<strong>Cash/short Treasuries</strong>: roughly 0% to 1% real",
          "<strong>Long-term Treasuries</strong>: roughly 1% to 2% real",
          "<strong>Investment-grade bonds</strong>: roughly 1% to 3% real",
          "<strong>U.S. stocks</strong>: roughly 5% to 7% real",
          "<strong>International developed stocks</strong>: roughly 4% to 6% real",
          "<strong>Emerging markets stocks</strong>: roughly 5% to 7% real with higher volatility"
        ]},
        { "type": "callout", "kind": "note", "title": "These are not guarantees", "text": "Past performance describes a history; it doesn't promise a future. Long-run averages mask decades of underperformance and outperformance. Use these as planning anchors, not promises to clients. The standard advisor language is \"expected\" or \"long-term assumption,\" never \"will earn.\"" },

        { "type": "activity", "title": "Build the honest retirement projection", "prompt": "Pick a hypothetical client (or yourself). Build a single-page projection that handles inflation correctly.", "steps": [
          "State current age, retirement age, life expectancy.",
          "State retirement annual spending in <em>today's dollars</em>.",
          "Choose an expected portfolio real return (e.g., 5%) and a planning inflation rate (e.g., 3%).",
          "Project the future-dollar spending need at retirement age, and at age 85.",
          "Project the portfolio balance at retirement age, given current savings and ongoing contributions.",
          "Convert the portfolio balance to a sustainable real income using a 4% withdrawal rate.",
          "Compare to need. Note the gap or surplus.",
          "On a separate line, document every assumption: rates, inflation, withdrawal, life expectancy. This is the audit trail."
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Why does money have time value?",
        "options": [
          "Because banks charge fees that reduce its worth over time.",
          "Because of opportunity cost, inflation, risk, and human preference for present consumption.",
          "Because the Federal Reserve adjusts interest rates each year.",
          "Because the IRS taxes future dollars at a higher rate."
        ],
        "correct": 1,
        "explanation": "The four drivers are opportunity cost (a dollar today can be invested), inflation (future dollars buy less), risk (future promises may not be kept), and preference (humans prefer present consumption)."
      },
      {
        "id": "q2",
        "prompt": "What is $5,000 today worth in 20 years at 8% annual returns?",
        "options": [
          "Approximately $13,000",
          "Approximately $19,000",
          "Approximately $23,000",
          "Approximately $33,000"
        ],
        "correct": 2,
        "explanation": "FV = 5,000 × (1.08)^20 = 5,000 × 4.661 ≈ $23,305."
      },
      {
        "id": "q3",
        "prompt": "Using the Rule of 72, approximately how long does money take to double at 6% annual returns?",
        "options": [
          "6 years",
          "9 years",
          "12 years",
          "18 years"
        ],
        "correct": 2,
        "explanation": "72 ÷ 6 = 12 years. The Rule of 72 is a quick mental approximation, accurate enough for advisor conversations."
      },
      {
        "id": "q4",
        "prompt": "A client expects to inherit $200,000 in 10 years. At a 5% discount rate, what is that inheritance worth today?",
        "options": [
          "Approximately $100,000",
          "Approximately $123,000",
          "Approximately $150,000",
          "Approximately $200,000"
        ],
        "correct": 1,
        "explanation": "PV = 200,000 ÷ (1.05)^10 = 200,000 ÷ 1.6289 ≈ $122,782."
      },
      {
        "id": "q5",
        "prompt": "Which of the following is the most common mistake when building long-term plans?",
        "options": [
          "Using too high a discount rate.",
          "Mixing nominal and real figures inside the same plan.",
          "Using monthly instead of annual compounding.",
          "Ignoring the Rule of 72."
        ],
        "correct": 1,
        "explanation": "If portfolio returns are nominal but expenses are flat in today's dollars (or vice versa), the plan is internally inconsistent and will mislead. Pick one frame — real or nominal — and stay there throughout."
      },
      {
        "id": "q6",
        "prompt": "A client saves $400/month for 35 years at 7% annual returns. Approximately what will the account be worth at the end?",
        "options": [
          "Approximately $168,000",
          "Approximately $390,000",
          "Approximately $722,000",
          "Approximately $1,050,000"
        ],
        "correct": 2,
        "explanation": "Monthly rate 0.07/12 = 0.005833, periods = 35 × 12 = 420. FV of annuity = 400 × [((1.005833)^420 − 1) / 0.005833] ≈ $722,000. The client contributed $168,000; the remaining $554,000+ is compound growth."
      },
      {
        "id": "q7",
        "prompt": "If long-term U.S. stock nominal returns average about 10% and long-term inflation averages about 3%, the real return on stocks is approximately:",
        "options": [
          "3%",
          "7%",
          "10%",
          "13%"
        ],
        "correct": 1,
        "explanation": "Real ≈ Nominal − Inflation. 10% − 3% ≈ 7%. This is the number to use if expenses in the plan are stated in today's dollars."
      },
      {
        "id": "q8",
        "prompt": "Which is the right discount rate to use when a client is choosing between a $50,000 cash bonus today and an alternative they would otherwise invest in a balanced portfolio?",
        "options": [
          "The risk-free Treasury rate.",
          "The client's expected after-tax return on the balanced portfolio.",
          "Whatever inflation is currently.",
          "10%, by default."
        ],
        "correct": 1,
        "explanation": "When the choice is between an option and a known alternative, the right discount rate is the rate of the alternative. Anything else doesn't match the decision being made."
      },
      {
        "id": "q9",
        "prompt": "Healthcare costs historically inflate at what rate relative to general CPI?",
        "options": [
          "Below CPI.",
          "Roughly the same as CPI.",
          "Above CPI, typically 4–6% per year long-run.",
          "Healthcare doesn't inflate; insurance pays for it."
        ],
        "correct": 2,
        "explanation": "Healthcare runs persistently above headline CPI — often 4–6% historically. Critical for any retiree projection where healthcare is a major line item."
      },
      {
        "id": "q10",
        "prompt": "A client's annual living expenses today are $90,000. At 3% inflation, what will those same expenses cost in 25 years?",
        "options": [
          "Approximately $115,000",
          "Approximately $135,000",
          "Approximately $188,000",
          "Approximately $270,000"
        ],
        "correct": 2,
        "explanation": "FV = 90,000 × (1.03)^25 = 90,000 × 2.0938 ≈ $188,440. The number isn't an exaggeration — it's what today's lifestyle costs 25 years from now."
      },
      {
        "id": "q11",
        "prompt": "Which of the following best describes the difference between an ordinary annuity and an annuity due?",
        "options": [
          "Ordinary annuities pay interest, annuities due pay principal.",
          "Ordinary annuities are taxable, annuities due are not.",
          "Ordinary annuities pay at the end of each period, annuities due pay at the beginning.",
          "There is no difference; the terms are interchangeable."
        ],
        "correct": 2,
        "explanation": "Ordinary annuity: end-of-period payments (loans, savings contributions, bond coupons). Annuity due: beginning-of-period payments (rent, insurance, leases). The annuity due is worth slightly more because each dollar has one extra period to earn."
      },
      {
        "id": "q12",
        "prompt": "A 60-year-old client is offered a $400,000 lump sum or $24,000/year for life starting at 65. Life expectancy is 87. Discount rate is 5%. What does the math suggest, and what's missing from the math?",
        "options": [
          "The annuity is mathematically larger; risk doesn't change that.",
          "The lump sum is mathematically larger by roughly $120,000 in present-value terms, but the annuity has longevity insurance and reduced behavioral risk that the math doesn't capture.",
          "They are identical; pensions and lump sums are designed to be equivalent.",
          "The lump sum is always wrong because clients spend lump sums irresponsibly."
        ],
        "correct": 1,
        "explanation": "PV of the annuity stream is approximately $280,000 at age 60 (22 payments of $24,000 starting in 5 years, discounted at 5%). Lump sum is $400,000. Math favors the lump sum by roughly $120,000 — but the annuity offers longevity insurance and removes withdrawal-discipline risk. The complete recommendation weighs the math and the structural risk together."
      },
      {
        "id": "q13",
        "prompt": "What is the right reflex when a client says, \"I'll have $500,000 saved by retirement\"?",
        "options": [
          "Congratulate them and move on.",
          "Ask whether the figure is in today's dollars or future dollars, and at what year.",
          "Ask whether they've considered international stocks.",
          "Ask what their spouse thinks."
        ],
        "correct": 1,
        "explanation": "Whether $500,000 is in today's dollars or future dollars matters enormously. The advisor's job is to make sure all numbers in a plan are on the same time footing — that question is the first move."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 2;

-- ============================================================================
-- DONE. Module remains 'draft' until Cathy Jackson-Gent approves via admin UI.
-- ============================================================================
