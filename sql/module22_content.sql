-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 22 CONTENT
-- Performance Reporting
-- ============================================================================
update public.modules set
  title = 'Performance Reporting',
  competency_id = 'OJL-13',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Measure and communicate what the portfolio actually did — with the right return calculations, the right benchmarks, the right time periods, and reporting that clients can actually use.',
  learning_objectives = ARRAY[
    'Calculate and interpret time-weighted and money-weighted returns correctly',
    'Choose and explain benchmarks that fit the portfolio''s purpose',
    'Build performance reports that put returns in proper context',
    'Communicate performance honestly during both strong and weak periods',
    'Understand the GIPS framework and its principles even when not formally compliant'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Two Returns That Are Not the Same",
        "summary": "Time-weighted return and money-weighted return measure different things. Confusing them — or quoting one when you should be quoting the other — is a common but consequential error.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When a client asks 'how did my portfolio do this year,' there are two different correct answers depending on what they actually want to know. Time-weighted return tells you how the investment strategy performed, neutralizing the effect of when the client added or withdrew money. Money-weighted return tells you what the client's actual experience was, including the effects of their contribution and withdrawal timing. Both numbers matter. Knowing which to use when is part of the work."},
          {"type": "subheading", "content": "Time-weighted return (TWR)"},
          {"type": "paragraph", "content": "Time-weighted return measures the compound rate of growth of the portfolio over a period, independent of the timing of cash flows in or out. It is calculated by breaking the period into sub-periods (each ending with a cash flow), calculating the return for each sub-period, and chain-linking them. TWR is the industry standard for evaluating the performance of an investment strategy or manager, because it strips out the effects of when the client happened to add or withdraw money — effects the manager did not control."},
          {"type": "subheading", "content": "Money-weighted return (MWR) / Internal Rate of Return (IRR)"},
          {"type": "paragraph", "content": "Money-weighted return is the constant rate that would make the present value of all cash flows (contributions, withdrawals, and the ending balance) equal to the starting balance. It is the IRR of the cash flow stream. MWR reflects the client's actual dollar experience — if they made a large contribution right before a strong period, MWR will be higher than TWR; if they contributed right before a drop, MWR will be lower. MWR is the right number for answering 'what did my money actually earn for me' from the client's perspective."},
          {"type": "subheading", "content": "When TWR and MWR diverge"},
          {"type": "paragraph", "content": "If a client started the year with $200K, contributed $300K in February, then experienced an 18% portfolio drawdown in March followed by recovery to flat by year-end, the time-weighted return for the year might be 0% (the strategy ended where it began). But the money-weighted return would be significantly negative — most of the client's dollars were exposed to the drawdown after the February contribution. Both numbers are correct. They answer different questions."},
          {"type": "glossary", "terms": [
            {"term": "Time-weighted return (TWR)", "definition": "Compound growth rate of the portfolio independent of cash flow timing. Industry standard for strategy/manager performance."},
            {"term": "Money-weighted return (MWR)", "definition": "Internal rate of return of the actual cash flow stream. Reflects the client's dollar-experienced return."},
            {"term": "Modified Dietz", "definition": "Approximation of TWR that weights cash flows by the time they were in the portfolio. Less precise than true TWR but easier to calculate; widely used in practice."},
            {"term": "Daily-weighted return", "definition": "TWR calculated with daily portfolio valuations, the most accurate retail approach. Standard in modern reporting platforms."}
          ]},
          {"type": "callout", "kind": "key", "content": "Report TWR alongside benchmarks (it is the apples-to-apples comparison). Show MWR to the client when discussing what their actual experience was. Confusing the two is one of the most common reporting errors."},
          {"type": "subheading", "content": "Annualizing returns"},
          {"type": "paragraph", "content": "Returns over multi-year periods are usually presented as annualized. Annualizing a multi-year return means converting it into the equivalent constant annual rate that would compound to the same total. The formula: (1 + total return)^(1/years) - 1. A 33.1% three-year cumulative return annualizes to (1.331)^(1/3) - 1 = 10.0% per year. Annualizing only makes sense for periods of one year or longer; do not annualize a 3-month return — it suggests a precision that does not exist."},
          {"type": "case_study", "title": "Naomi's first-year performance number", "scenario": "Naomi's account is up 9.4% time-weighted for the year. But she contributed $24,000 over the year, including a large $18,000 contribution after a 4% drop in early October. The market then recovered strongly through year-end. Her money-weighted return for the year is 12.7% — the October contribution was unusually well-timed by accident. The apprentice reports both numbers in her year-end statement: 'Portfolio strategy performance (time-weighted): 9.4%. Your actual dollar-weighted experience: 12.7%. The dollar-weighted figure was higher this year because your October contribution caught a strong recovery; this can work in the other direction in other years.' Both numbers, with context.", "discussion": "The apprentice did not pick the flattering number. They explained both and the reason for the difference. Naomi knows what each means. She knows the 12.7% was partly luck. Honest reporting builds the trust that lets the relationship survive a year where MWR is below TWR."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Choosing the Right Benchmark",
        "summary": "A return without a benchmark is just a number. A benchmark turns it into information — but only if the benchmark is the right one.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Performance reporting without benchmarks is performance reporting without context. A 7% return looks good against a 3% benchmark and disappointing against a 12% benchmark. The benchmark choice can be the single most consequential decision in a performance report — and it deserves the same care as the portfolio construction. Get this wrong and you mislead the client either toward false comfort or false alarm."},
          {"type": "subheading", "content": "Single-asset benchmarks"},
          {"type": "paragraph", "content": "Individual asset class sleeves are benchmarked against the index that represents the asset class: U.S. broad equity against the Russell 3000 or CRSP US Total Market; large-cap U.S. against the S&P 500; international developed against MSCI EAFE or FTSE Developed; emerging against MSCI Emerging Markets; U.S. investment-grade bonds against the Bloomberg U.S. Aggregate. The benchmark should match the asset class universe, not the popular index. The S&P 500 is famous but misleading as a benchmark for a U.S. total market fund — the total market index includes mid- and small-caps the S&P 500 omits."},
          {"type": "subheading", "content": "Blended benchmarks"},
          {"type": "paragraph", "content": "A portfolio is rarely a single asset class — so a single-index benchmark is not appropriate for the portfolio as a whole. The right benchmark is a blended one that mirrors the target allocation. For a 75/25 portfolio: 75% in a global equity index (e.g., MSCI ACWI) and 25% in a U.S. aggregate bond index, rebalanced on the same schedule the portfolio uses. The blended benchmark answers 'how did a passive portfolio with the same allocation do?' — which is the relevant comparison."},
          {"type": "callout", "kind": "key", "content": "Compare your client's portfolio to a blended benchmark that mirrors the target allocation, not to the S&P 500. The S&P 500 comparison is misleading because the portfolio is not 100% S&P 500."},
          {"type": "subheading", "content": "Peer group comparisons"},
          {"type": "paragraph", "content": "Beyond the index benchmark, comparing the portfolio to peer groups doing similar things adds context. For example, the Morningstar Allocation 70-85% Equity category contains hundreds of allocation funds with broadly similar risk profiles. The portfolio's return relative to this peer group answers 'how did our 75/25 do compared to other 75/25-ish portfolios.' Peer comparisons should be used with care — peer groups include funds with different fees, strategies, and tax treatments — but they add useful triangulation."},
          {"type": "subheading", "content": "Benchmark mismatches that mislead"},
          {"type": "list", "items": [
            "Comparing a 60/40 portfolio to the S&P 500 (or vice versa) — different risk profiles, the comparison is not informative",
            "Comparing an actively managed fund to a benchmark that excludes the fund's actual style — a small-cap value fund compared to the S&P 500 will tell you nothing about the manager's skill",
            "Using a peer group that does not match the portfolio's strategy — Morningstar Conservative Allocation peer group does not fit a Moderately Aggressive portfolio",
            "Choosing a benchmark that flatters the portfolio over the chosen time period — survivorship bias in benchmark selection is a real form of bias"
          ]},
          {"type": "subheading", "content": "Benchmark for the client's plan vs benchmark for the strategy"},
          {"type": "paragraph", "content": "There are actually two benchmarks worth considering. The first is the portfolio's strategy benchmark — the blended index that matches the allocation. The second is the client's plan benchmark — the return the financial plan assumed in projections. If the plan projected 5% real returns and the portfolio is delivering 7% real, the plan is ahead of trajectory regardless of how the portfolio did versus the index. Both numbers matter for different purposes: strategy benchmark answers 'are we beating a passive version of our allocation,' plan benchmark answers 'is the plan on track.'"},
          {"type": "case_study", "title": "Devon's mixed report card", "scenario": "Devon's portfolio returned 8.2% for the year. The apprentice prepares three comparisons: (1) Versus the blended benchmark (60% MSCI ACWI / 40% Bloomberg U.S. Aggregate), the benchmark returned 8.9% — the portfolio modestly underperformed by 70 bps. (2) Versus the Morningstar Moderate Allocation peer group median return of 7.8% — the portfolio outperformed by 40 bps. (3) Versus the plan's assumed long-term real return of 4.5%, the portfolio's 8.2% nominal in a year of ~2.5% inflation means about 5.7% real — ahead of plan trajectory. The apprentice reports all three with context: passive index slightly ahead this year, peer group slightly behind, plan on track. Devon now has a multidimensional picture.", "discussion": "Reporting only the benchmark comparison would have been a partial truth. Reporting only the peer group would have been a different partial truth. Reporting only versus the plan would have been a third. All three together is the honest picture."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Building the Performance Report",
        "summary": "A performance report is a document the client will use. Design it for clarity, completeness, and the conversation it should prompt at the annual review.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A good performance report tells the client what their portfolio did, what comparable benchmarks did, what context surrounds those numbers, and what the apprentice's interpretation is. A bad performance report just lists numbers. The difference is design and intentionality — the report should be the artifact the client refers to throughout the year to understand what is happening with their money."},
          {"type": "subheading", "content": "What a complete performance report contains"},
          {"type": "numbered", "items": [
            "Account summary — beginning balance, ending balance, contributions, withdrawals, market growth, fees",
            "Returns — period returns (quarter, year-to-date, trailing 1/3/5/10 years, since inception), both time-weighted and money-weighted",
            "Benchmark comparison — blended benchmark return for each period",
            "Asset allocation snapshot — current allocation versus target, with permitted ranges shown",
            "Account-level breakdown — performance by account for clients with multiple accounts",
            "Income — dividends, interest, distributions received over the period",
            "Fees paid — both advisory fees and underlying fund expenses where reportable",
            "Commentary — apprentice's plain-language interpretation, including context for any unusual results"
          ]},
          {"type": "subheading", "content": "Trailing periods to report"},
          {"type": "paragraph", "content": "Standard trailing periods: current quarter, year-to-date, trailing 1-year, 3-year annualized, 5-year annualized, 10-year annualized, and since-inception annualized. Always show the corresponding benchmark return for each period. Trailing 1-year is the period clients fixate on most — and it is often the least diagnostic. Make sure longer periods are equally visible. If the portfolio has been managed less than 3 years, do not annualize — show cumulative since inception."},
          {"type": "subheading", "content": "Format and visual design"},
          {"type": "list", "items": [
            "Numbers in tables, never paragraphs",
            "Show portfolio and benchmark side by side in the same row, with the difference column",
            "Use colors sparingly — red for negative, black or dark blue for positive; consistent",
            "Group accounts in a household summary first, then individual accounts",
            "Headers and footers consistent across reports for institutional feel",
            "Date range and report-as-of date prominent on every page"
          ]},
          {"type": "subheading", "content": "The commentary section"},
          {"type": "paragraph", "content": "Numbers alone do not communicate. A short commentary — typically a single page or less — interprets the numbers for the client. What worked this period and why? What did not and why? What is your view of the portfolio's positioning going into the next period? Is there anything to do? This is where the apprentice's voice and judgment show. The commentary should be candid: if the portfolio underperformed, say so and explain why. Honesty in weak periods builds the credibility to be believed in strong ones."},
          {"type": "callout", "kind": "do", "content": "Read your commentary draft as if you were the client. If a sentence is defensive or evasive, rewrite it. Clients can tell the difference between candid explanation and corporate-speak. Candor wins."},
          {"type": "subheading", "content": "Reporting cadence"},
          {"type": "paragraph", "content": "Standard reporting cadence is quarterly with a more substantial annual report at year-end. Some clients prefer monthly statements (often supplied by the custodian) plus a quarterly advisor commentary. Some larger or more complex clients receive monthly or even weekly performance updates. Set the cadence in the engagement and stick to it. Predictability matters."},
          {"type": "case_study", "title": "Naomi's year-end report", "scenario": "The apprentice produces Naomi's first annual performance report — a 6-page document. Page 1: account summary and one-year return numbers (TWR 9.4%, MWR 12.7%, blended benchmark 9.6%, plan benchmark 5.0% real / 7.5% nominal — all on the page). Page 2: allocation snapshot showing current 76/24 vs target 75/25, all within bands. Page 3: account-level breakdown across her Roth IRA, taxable brokerage, and 401(k). Page 4: income and fee summary. Pages 5-6: commentary — 'Strategy slightly trailed the broader index this year by 20 bps, primarily due to international developed lagging U.S. equities; this is consistent with global allocation behavior over short periods. Your dollar-weighted return was substantially higher than time-weighted because your large October contribution caught a year-end rally. Allocation remains within target ranges. No changes recommended.' Footer on every page: date, page number, contact info, regulatory disclosure.", "discussion": "Naomi now has a document she can read alone. The numbers are honest. The commentary is candid. If she calls with a question, the report supports the conversation rather than requiring it. Year over year, the format stays the same — predictability accrues to trust."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Communicating Performance — Strong, Weak, and Mediocre Years",
        "summary": "How you talk about performance in different conditions is part of the relationship work. Strong years require humility; weak years require honesty; mediocre years require the courage to be boring.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Performance reporting is partly a communication discipline. The numbers are what they are; how you frame them shapes how the client experiences the relationship. Three different communication challenges arise across the cycle — strong periods, weak periods, and the long stretches in between when nothing dramatic happens but the work continues."},
          {"type": "subheading", "content": "Strong years — the humility problem"},
          {"type": "paragraph", "content": "After a strong year, the temptation is to claim credit. Resist. Most of the return came from the asset classes the client owns, not from any decision you made. If the portfolio matched its blended benchmark, the return is the benchmark's. If the portfolio beat the benchmark by 50 bps, attribute that carefully — was it manager selection, rebalancing timing, currency exposure? Be specific about what you actually did and avoid implying you predicted the rally. Clients who hear advisors claim credit for market returns lose trust the next time markets disappoint."},
          {"type": "subheading", "content": "Weak years — the honesty problem"},
          {"type": "paragraph", "content": "After a weak year, the temptation is to defend, explain away, or distract from the numbers. Resist. The portfolio did what it did. Explain why honestly — was it the asset class environment (most stocks were down), was it a specific position, was the allocation appropriate but the timing painful? Acknowledge the client's experience. Connect the result to the plan: 'A year like this is built into the long-term assumptions. The plan does not require positive returns every year. The plan requires us to stay invested through years like this so the long-term compounding can happen.' Reaffirm the IPS and the discipline of the framework."},
          {"type": "callout", "kind": "key", "content": "The relationship is built or broken in weak years. Be present, be honest, be calm, and be clear. Clients remember how their advisor handled the bad years far more than how they performed in the good ones."},
          {"type": "subheading", "content": "Mediocre years — the boredom problem"},
          {"type": "paragraph", "content": "Most years are mediocre — the portfolio gained or lost something modest, nothing dramatic happened. The temptation in mediocre years is to manufacture significance — find some metric that looks impressive, talk about positioning changes that did not actually happen, or pad the report with macro commentary. Resist. A short, calm report saying 'the portfolio did what it was designed to do; nothing material to discuss; we will see you at the annual review' is the right report. Boring is often the goal. Clients who get drama from their advisor every quarter eventually stop trusting any of it."},
          {"type": "subheading", "content": "Specific language techniques"},
          {"type": "list", "items": [
            "Lead with what happened factually, then interpretation — 'The portfolio returned 7.2% this year. Three things drove that...' beats 'In a challenging environment...'",
            "Attribute returns to factors, not to your skill — 'U.S. large-cap equities led' rather than 'we benefited from our positioning'",
            "Acknowledge the client's likely experience before walking through the numbers — 'I know watching the portfolio drop in March was hard'",
            "Always close with what comes next — schedules, action items, or the affirmation that nothing changes",
            "Avoid hedging language ('relatively', 'somewhat', 'in line with') that signals uncertainty about the framing"
          ]},
          {"type": "subheading", "content": "When the client wants to change the plan based on performance"},
          {"type": "paragraph", "content": "Some clients see good performance and want to add risk; others see bad performance and want to reduce it. Both are performance-chasing. The reporting conversation is the appropriate venue to gently push back on either impulse. 'Your portfolio did what it was designed to do this year. The plan does not change because of this year's result. Let us revisit at the annual review if you are seeing something that suggests the plan itself needs to evolve.' The IPS is the framework that makes this conversation possible. Without it, every quarter is a renegotiation."},
          {"type": "case_study", "title": "The painful 2022 conversation", "scenario": "A hypothetical: 2022 — both equities and bonds had bad years simultaneously, a 60/40 portfolio could be down 15-17%. The apprentice's communication to clients: '2022 was one of the most difficult years for diversified portfolios in many decades. Both stocks and bonds declined together, which is unusual. Your portfolio is down approximately 16% — in line with the blended benchmark. No allocation changes were made during the year; the IPS allocation remained appropriate for your situation. The plan's long-term projection includes years like this — it does not require positive returns every year to succeed over a 25-year horizon. The discipline of the plan asks us to remain invested through this period so the eventual recovery contributes to compounding. I am available to discuss further; an in-person review can be scheduled if helpful.' Calm, factual, plan-anchored, with availability for more conversation.", "discussion": "The communication does not minimize. It does not catastrophize. It connects the result to the framework. The clients who get this from their advisor in a bad year are the clients who stay through the next year — and who tell their friends about the advisor who handled the hard year well."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "GIPS and Performance Standards",
        "summary": "The Global Investment Performance Standards govern how performance is calculated and presented at scale. Even for clients you report on individually, the principles are worth knowing.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The Global Investment Performance Standards (GIPS) are a voluntary set of ethical principles for calculating and presenting investment performance, developed by the CFA Institute. Many institutional asset managers and increasingly some RIAs claim GIPS compliance because it signals a commitment to honest, consistent, and verifiable performance reporting. Even firms that do not claim formal GIPS compliance benefit from understanding the principles — they reflect industry consensus on what honest performance reporting looks like."},
          {"type": "subheading", "content": "GIPS core principles"},
          {"type": "list", "items": [
            "Fair representation — performance should be presented in a way that fairly represents what the strategy actually produced",
            "Full disclosure — material information about how returns were calculated, what was included or excluded, and what risks were taken should be disclosed",
            "Composite reporting — performance is reported on composites of all similar accounts, not cherry-picked individual ones",
            "Consistent methodology — calculations follow defined methodologies applied consistently across periods",
            "Verification — third-party verification is encouraged but not required to claim compliance"
          ]},
          {"type": "subheading", "content": "Composites — the heart of GIPS"},
          {"type": "paragraph", "content": "A composite is a group of all discretionary accounts managed in a similar strategy. GIPS requires that firms report the composite's performance — the aggregate of all accounts following that strategy, including ones that did poorly or were closed — rather than the performance of a chosen subset. This prevents the cherry-picking that would otherwise be possible. If a firm has 50 accounts in its 'Moderate Growth Strategy,' the strategy's GIPS performance is the asset-weighted return of all 50 accounts, with disclosed dispersion. Clients evaluating a strategy can see how the strategy actually performed across all clients, not just the best ones."},
          {"type": "subheading", "content": "Why GIPS matters even for non-claiming firms"},
          {"type": "paragraph", "content": "Most retail RIAs do not formally claim GIPS compliance because the operational requirements are substantial. But the principles still apply morally: do not selectively report flattering account results; do not change calculation methodology to look better; disclose what is being measured and what is not; do not pitch one client's results as the strategy's typical experience if the client was unusually fortunate. A retail advisor who internalizes these principles produces more honest performance reporting even without formal compliance."},
          {"type": "subheading", "content": "Common reporting practices that violate GIPS principles"},
          {"type": "list", "items": [
            "Showing a 'representative account' that is the best-performing one, not the typical one",
            "Excluding accounts that performed poorly from the composite",
            "Changing the time period being reported to show a more flattering result",
            "Showing gross-of-fees returns without disclosing that all-in fees are substantially higher than the model suggests",
            "Backtesting a strategy and presenting the backtest as historical performance without clear disclosure"
          ]},
          {"type": "subheading", "content": "Gross vs net of fees"},
          {"type": "paragraph", "content": "Performance can be reported gross of fees (before advisory fees are deducted) or net of fees (after fees). GIPS requires net-of-fees reporting in most contexts because that is what the client actually experienced. Some marketing materials show gross-of-fees figures with smaller-font net-of-fees disclosure — this is technically allowed but misleading in spirit. The honest practice is to lead with net-of-fees and to be transparent about what fees were included."},
          {"type": "case_study", "title": "The composite vs the showcase account", "scenario": "An apprentice is asked to prepare marketing materials describing the firm's 'Moderate Growth Strategy.' The supervising advisor is tempted to show their best client account — a high-net-worth account that has compounded at 11% annually for five years — as the 'representative example.' The apprentice does the GIPS-aligned thing instead: pulls the composite return across all 28 accounts in the strategy, finds the asset-weighted return is 8.7% annualized over five years (the showcase account was an outlier), and presents that with disclosed dispersion. The composite number is not as eye-catching, but it is honest. It is also the number the firm can defend in any future dispute or audit.", "discussion": "Marketing pressure pulls toward the flattering number. Discipline pulls toward the honest one. The apprentice's job is to hold the discipline. Over time, honesty in reporting attracts the clients who are looking for honesty — and those are the clients worth having."},
          {"type": "callout", "kind": "key", "content": "If you are tempted to pick a flattering data point, ask yourself: would I be comfortable defending this presentation in front of a regulator and a disappointed client three years from now? If no, find the more honest presentation."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Trading & Execution. From the decisions made in this module and the prior ones, somebody has to actually place the trades. The mechanics matter."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Time-weighted return is the right metric when:", "options": ["The client wants to know their actual dollar experience", "Evaluating the performance of the investment strategy or manager, independent of cash flow timing", "Calculating tax liability", "Forecasting future returns"], "correct": 1, "explanation": "TWR strips out the effects of when cash flows happened — appropriate for evaluating a strategy or comparing to a benchmark. MWR reflects the client's dollar experience."},
        {"id": "q2", "prompt": "Money-weighted return is best understood as:", "options": ["The compound growth rate of a unit of money", "The internal rate of return of the actual cash flow stream — the client's dollar-experienced return", "A weighted average of strategy returns", "A measure of risk"], "correct": 1, "explanation": "MWR (the IRR of the cash flow stream) tells the client what their money actually earned given the timing of their contributions and withdrawals."},
        {"id": "q3", "prompt": "The right benchmark for a 60/40 portfolio is generally:", "options": ["The S&P 500", "A blended benchmark like 60% global equity index / 40% U.S. aggregate bond index", "Cash", "The Dow Jones Industrial Average"], "correct": 1, "explanation": "Blended benchmarks mirror the portfolio's actual allocation. Single-index benchmarks like the S&P 500 are misleading for any portfolio that is not 100% in that index."},
        {"id": "q4", "prompt": "Annualizing returns is appropriate for:", "options": ["Any period including months and quarters", "Periods of one year or longer", "Only periods of five years or longer", "Only the inception-to-date period"], "correct": 1, "explanation": "Annualizing periods shorter than one year suggests a precision that does not exist. Annualize only for periods of one year or longer."},
        {"id": "q5", "prompt": "When the portfolio underperforms its benchmark, the most appropriate communication is to:", "options": ["Avoid mentioning the comparison", "Explain honestly what happened, connect the result to the plan, and reaffirm the framework", "Switch to a different benchmark that looks better", "Recommend immediate allocation changes"], "correct": 1, "explanation": "Honesty in weak periods builds the credibility to be believed in strong ones. Honest explanation plus plan-anchored framing is the discipline."},
        {"id": "q6", "prompt": "Reporting cadence for most retail clients is typically:", "options": ["Daily", "Quarterly with a more substantial annual report", "Only when the client requests", "Every five years"], "correct": 1, "explanation": "Quarterly reporting with annual deep review is the standard retail cadence. Predictability matters more than precision."},
        {"id": "q7", "prompt": "A composite in GIPS terminology is:", "options": ["A single best-performing account used for marketing", "A group of all discretionary accounts managed in a similar strategy, reported in aggregate", "A blend of multiple benchmarks", "A summary calculation method"], "correct": 1, "explanation": "Composites prevent cherry-picking. Reporting the asset-weighted return of all accounts in a strategy shows what the strategy actually delivered to clients."},
        {"id": "q8", "prompt": "After a strong year for the broader market, an advisor who claims credit for the returns:", "options": ["Strengthens client trust", "Risks losing trust the next time markets disappoint, because the implicit claim of skill was misleading", "Has done their job", "Should ask for higher fees"], "correct": 1, "explanation": "Most market returns come from market exposure, not from advisor decisions. Claiming credit for market returns sets up an impossible standard and erodes trust when markets reverse."},
        {"id": "q9", "prompt": "GIPS generally requires performance to be reported:", "options": ["Gross of fees only", "Net of fees in most contexts, because that is the client's actual experience", "Either, at the firm's discretion", "Annualized over 20 years"], "correct": 1, "explanation": "Net-of-fees reporting reflects what the client actually earned. Gross-of-fees is allowed in some contexts but only with clear disclosure."},
        {"id": "q10", "prompt": "Reporting Naomi's 12.7% money-weighted return without explaining it was higher than the 9.4% time-weighted return because of a well-timed contribution would be:", "options": ["Perfectly appropriate", "Misleading by omission — the higher number reflects luck of contribution timing, not strategy performance", "Required by GIPS", "Forbidden by FINRA"], "correct": 1, "explanation": "Both numbers are true. Reporting only the flattering one without explanation misleads the client about what to expect going forward."},
        {"id": "q11", "prompt": "A mediocre year — small return, nothing dramatic — is best communicated with:", "options": ["Manufactured significance and macro commentary", "A short, calm report saying the portfolio did what it was designed to do", "Recommendations for major changes to add interest", "No report at all"], "correct": 1, "explanation": "Boring is often the goal. Clients who receive drama every quarter eventually stop trusting any of it."},
        {"id": "q12", "prompt": "Showing a 'representative account' in marketing materials that is actually the firm's best-performing account is:", "options": ["Standard industry practice", "A violation of GIPS principles and misleading in spirit even if technically allowed", "Required if the account is real", "Acceptable with no disclosure"], "correct": 1, "explanation": "Composite-based reporting prevents cherry-picking. Showing an outlier as 'representative' misrepresents the typical client's experience."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 23;
