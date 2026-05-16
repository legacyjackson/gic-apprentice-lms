-- ============================================================================
-- GIC APPRENTICE LMS — FINAL COMPREHENSIVE EXAM (GIC Work Process Aligned)
-- 30 questions — one integration-level question per GIC competency GIC-01 to GIC-30
-- Passing score: 85% (26 of 30 correct)
-- Run this AFTER session1_base_schema.sql and final_exam_setup.sql
-- This UPDATES the existing exam content — it does not recreate the tables.
-- ============================================================================

-- Update the existing exam record with new GIC-aligned questions
-- If the exam doesn't exist yet, insert it
INSERT INTO public.final_exams (exam_code, title, description, passing_score, content)
VALUES (
  'WSC-FINAL-2026',
  'Wealth Solutions Counselor — Final Competency Examination',
  'A 30-question integration assessment covering all GIC Work Process competencies. Each question is scenario-based and tests practical application at the level expected of a qualified Wealth Solutions Counselor. Passing score: 85% (26 of 30 correct).',
  85,
  $jsonb$
{
  "questions": [
    {
      "id": "f01",
      "competency": "GIC-01",
      "text": "During a first discovery meeting, a client answers your questions with one or two words and seems reluctant to share financial details. They say, 'I just want someone to manage my money. I don't see why I have to answer all these questions.' What is the most professional response?",
      "options": [
        "Acknowledge the discomfort directly, explain that discovery is how you ensure your advice actually fits their situation, and then ask a smaller, easier-to-answer question to rebuild momentum",
        "Skip the detailed discovery and proceed to investment recommendations to respect the client's preference",
        "Reschedule the meeting for when the client is more willing to participate",
        "Hand the client a written questionnaire to complete on their own time"
      ],
      "correct": 0,
      "explanation": "A reluctant client needs to understand why the questions matter — not be pushed or accommodated by skipping discovery. Acknowledging the discomfort and continuing with smaller questions builds trust while maintaining the professional standard."
    },
    {
      "id": "f02",
      "competency": "GIC-02",
      "text": "A client returns a document package that includes tax returns, brokerage statements, and a pay stub. You notice that the investment statement is from 18 months ago, the pay stub is from a previous employer, and the tax returns are for the most recent year. What is the correct next step?",
      "options": [
        "Request updated documents specifically: a current brokerage statement as of the most recent quarter-end and a current pay stub from the client's current employer, then verify before proceeding with analysis",
        "Use the available documents and note in the file that some information may be outdated",
        "Proceed with the analysis using the tax returns, which are current, and estimate the other figures",
        "Contact the custodian directly to obtain a current brokerage statement without involving the client"
      ],
      "correct": 0,
      "explanation": "Financial planning requires current, accurate documents. An 18-month-old investment statement and a pay stub from a previous employer cannot support accurate analysis. Both must be replaced before work proceeds."
    },
    {
      "id": "f03",
      "competency": "GIC-03",
      "text": "A client says they have $800 left over at the end of every month, but their savings account grew by only $1,200 last year. How do you explain this gap and what is the most useful next step?",
      "options": [
        "Explain that the $6,600 gap ($9,600 expected minus $1,200 actual) represents untracked spending, and offer to review 3-6 months of bank statements together to identify where the money is actually going",
        "Suggest the client set up automatic transfers of $800/month to prevent the money from being spent",
        "Conclude that the client's income must have been lower than expected and recalculate based on a lower figure",
        "Assume the client made a large one-time purchase and proceed with planning based on the stated surplus"
      ],
      "correct": 0,
      "explanation": "The gap between expected and actual savings is one of the most diagnostic findings in cash flow work. The $6,600 discrepancy represents real spending that wasn't tracked. Bank statement review is the only way to find it."
    },
    {
      "id": "f04",
      "competency": "GIC-04",
      "text": "A 58-year-old client wants to retire at 62. They currently earn $95,000/year, have $380,000 in their 401(k), and expect Social Security of $1,650/month at 62. They estimate they need $5,500/month in retirement. What is the most immediate concern you should surface in the retirement scenario?",
      "options": [
        "The portfolio must fund a $3,850/month gap ($5,500 needed minus $1,650 Social Security) for potentially 30+ years from a $380,000 base — which at a 4% withdrawal rate supports only $1,267/month. The client is significantly underfunded for their retirement goal at 62.",
        "The client should delay Social Security until 70 to maximize the benefit",
        "The 401(k) balance is adequate if invested aggressively for the four remaining working years",
        "The client's income is too low to fund the gap and they should consider part-time work"
      ],
      "correct": 0,
      "explanation": "A 4% withdrawal rate on $380,000 yields ~$15,200/year (~$1,267/month). The client needs $3,850/month beyond Social Security. The portfolio shortfall is the primary planning problem — it must be surfaced directly."
    },
    {
      "id": "f05",
      "competency": "GIC-05",
      "text": "A client has a will leaving everything to their current spouse. Their IRA beneficiary form still lists their ex-spouse (divorced 3 years ago). The client is surprised and says the will should override the beneficiary form. What is the accurate explanation?",
      "options": [
        "Beneficiary designations on retirement accounts override the will — the ex-spouse will receive the IRA at death regardless of what the will says. The beneficiary form must be updated immediately.",
        "The will does override the beneficiary form since it was executed after the divorce",
        "The divorce decree automatically removes the ex-spouse as beneficiary by operation of law",
        "The IRA custodian will investigate the conflict and determine the correct beneficiary at death"
      ],
      "correct": 0,
      "explanation": "Beneficiary designations are contractual — they control the distribution of retirement accounts regardless of what the will says. This is the most misunderstood aspect of estate planning. The update must happen immediately."
    },
    {
      "id": "f06",
      "competency": "GIC-06",
      "text": "You are preparing a planning summary for a client who just received a $200,000 inheritance. The summary is 14 pages and includes the full analysis, all scenario details, and every data point you reviewed. The advisor asks you to revise it before the client meeting. What is the most important revision?",
      "options": [
        "Add a one-page executive summary at the front that answers three questions: where does the client stand, what are the most important recommendations for the inheritance, and what are the next steps — so the client can understand the key points without reading all 14 pages",
        "Reduce the font size so the document fits in fewer pages",
        "Remove the scenario details and leave only the final recommendations",
        "Add a table of contents so the client can navigate to sections of interest"
      ],
      "correct": 0,
      "explanation": "Planning summaries must lead with conclusions. A 14-page document without an executive summary forces the client to read everything to find what matters most. The one-page executive summary is the essential missing element."
    },
    {
      "id": "f07",
      "competency": "GIC-07",
      "text": "Three days after a client meeting, you realize you never logged the interaction in the CRM. You remember most of what was discussed but not all the details. What is the correct action?",
      "options": [
        "Log the interaction now with as much accurate detail as you can recall, clearly noting the actual meeting date and the date the entry was created, and flag any uncertain details as 'per recollection' — then commit to logging within 24 hours going forward",
        "Skip the entry since too much time has passed for it to be useful",
        "Ask a colleague to log the entry based on your verbal summary",
        "Wait for the client's next contact and update the log at that point"
      ],
      "correct": 0,
      "explanation": "A late entry is better than no entry, but it must be accurate and transparent about its limitations. Noting both the actual meeting date and the entry date, and flagging uncertain details, maintains the integrity of the record."
    },
    {
      "id": "f08",
      "competency": "GIC-08",
      "text": "During a client annual review meeting you are attending as a support associate, you notice that the client seems confused after the advisor explains a Roth conversion strategy — but the advisor has already moved on to the next topic. What is the appropriate action?",
      "options": [
        "Note the apparent confusion in your meeting notes and flag it to the advisor after the meeting, recommending that Roth conversion be followed up with a brief written explanation in the follow-up email",
        "Interrupt the meeting to re-explain the Roth conversion to the client",
        "Say nothing — it is the advisor's responsibility to read the room",
        "Ask the client directly if they understood the strategy while the advisor is speaking"
      ],
      "correct": 0,
      "explanation": "Your role in client meetings is observation, documentation, and follow-through — not intervention. The correct action is to capture the confusion in your notes and ensure the advisor addresses it in the follow-up. Interrupting the meeting oversteps your role."
    },
    {
      "id": "f09",
      "competency": "GIC-09",
      "text": "A client scores 'moderately aggressive' on the risk questionnaire but their financial situation shows: six months from retirement, all savings in a single 401(k), no pension, and Social Security of only $1,400/month. They need $5,000/month in retirement. How should the suitability determination resolve this?",
      "options": [
        "Surface the conflict: the client's risk capacity (near-retirement, single asset, large income gap) does not support a moderately aggressive strategy regardless of their stated tolerance. Present the options honestly: accept a lower-return conservative strategy and adjust retirement income expectations, or extend the working timeline.",
        "Accept the questionnaire result and invest aggressively as the client prefers — their stated tolerance controls",
        "Average the questionnaire result with the financial situation to arrive at a 'moderate' strategy",
        "Document 'moderately aggressive' as stated and note the concerns separately without changing the recommendation"
      ],
      "correct": 0,
      "explanation": "When risk tolerance and risk capacity conflict, the fiduciary obligation requires surfacing the conflict and helping the client make an informed decision. A client six months from retirement with no pension and a large income gap does not have the capacity to absorb significant losses."
    },
    {
      "id": "f10",
      "competency": "GIC-10",
      "text": "A client's portfolio started the year at 60% equities / 40% fixed income. After a strong equity market, the allocation has drifted to 72% equities / 28% fixed income. The client is in a taxable account. What is the most tax-efficient first step before selling anything to rebalance?",
      "options": [
        "Redirect the client's next quarterly contribution and any dividends entirely to the fixed income positions to restore balance without triggering a taxable sale",
        "Sell the most appreciated equity positions to fund the fixed income purchase",
        "Sell the lowest-gain equity positions first to minimize capital gains",
        "Wait until December to harvest any offsetting losses before rebalancing"
      ],
      "correct": 0,
      "explanation": "Redirecting new contributions and dividends is the most tax-efficient rebalancing technique — it restores balance without triggering any taxable event. Only after exhausting this option should actual selling be considered."
    },
    {
      "id": "f11",
      "competency": "GIC-11",
      "text": "You are comparing two funds for a client's taxable account. Fund A is an actively managed large-cap fund with a 0.92% expense ratio and 95% annual turnover. Fund B is a large-cap index ETF with a 0.04% expense ratio and 4% turnover. Both have similar 10-year performance records. Which is more appropriate for a taxable account and why?",
      "options": [
        "Fund B — the ETF's dramatically lower expense ratio and near-zero turnover mean lower annual costs and far fewer taxable capital gain distributions, which is critical for a taxable account",
        "Fund A — higher turnover signals more active management, which may protect the client during market downturns",
        "Fund A — the higher expense ratio reflects more sophisticated management that produces better risk-adjusted returns",
        "They are equally appropriate since the 10-year performance records are similar"
      ],
      "correct": 0,
      "explanation": "In a taxable account, costs and tax efficiency dominate. Fund B's expense ratio is 22x lower and its 4% turnover vs. 95% means dramatically fewer taxable distributions. When after-tax, after-cost returns are considered, Fund B wins significantly."
    },
    {
      "id": "f12",
      "competency": "GIC-12",
      "text": "The S&P 500 declined 8% in a quarter. A client's 60/40 portfolio declined 4.9%. The 60/40 benchmark declined 5.2%. The client calls concerned. What is the most accurate and reassuring context to provide?",
      "options": [
        "The portfolio declined 4.9%, which is less than its benchmark (5.2%) and significantly less than the pure equity index (8%). The portfolio performed as designed — the fixed income allocation cushioned the equity decline. Nothing in the quarter changes the investment strategy.",
        "The market is down, but markets always recover — no action needed",
        "The portfolio lost nearly 5%, which is concerning and may warrant a shift to a more conservative allocation",
        "The S&P 500 is the wrong benchmark — the client should compare to a pure bond index for a fair comparison"
      ],
      "correct": 0,
      "explanation": "Performance communication must provide three pieces of context: what the market did, how the portfolio performed relative to its benchmark, and whether anything warrants a strategy change. All three point to 'the portfolio worked as intended.'"
    },
    {
      "id": "f13",
      "competency": "GIC-13",
      "text": "You are preparing a research brief on a sector ETF your advisor is considering for client portfolios. You find conflicting data: one sell-side report rates the sector 'Overweight' while another rates it 'Underweight.' How should you handle this conflict in the brief?",
      "options": [
        "Present both views, note the potential conflict of interest inherent in sell-side research, include the key supporting data for each position, and let the advisor draw the conclusion — your job is to surface the tension, not resolve it unilaterally",
        "Use only the 'Overweight' recommendation since it supports the advisor's consideration of the ETF",
        "Exclude both since conflicting sell-side opinions are not useful research",
        "Average the two views and present a 'Neutral' recommendation"
      ],
      "correct": 0,
      "explanation": "Conflicting research is valuable information — it tells you the sector is genuinely uncertain. The research brief must present both views with their supporting data and flag the conflict of interest. The advisor makes the judgment call with complete information."
    },
    {
      "id": "f14",
      "competency": "GIC-14",
      "text": "A colleague discovers a trade error in a client account — the wrong security was purchased. The error has not been noticed by the client. The colleague wants to quietly sell the wrong security and purchase the correct one without documenting the error. What is the correct response?",
      "options": [
        "Document the error immediately and involve the compliance department — attempting to correct it quietly creates a second, more serious problem (concealment) on top of the original error",
        "Help the colleague execute the correction quietly since the client was not harmed",
        "Tell the colleague to disclose the error to the client before correcting it",
        "Do nothing since the error is not yours to report"
      ],
      "correct": 0,
      "explanation": "Concealing errors from compliance is a more serious violation than the original error. Regulators distinguish between errors that are disclosed and corrected promptly versus errors that are concealed. The colleague must involve compliance, not avoid it."
    },
    {
      "id": "f15",
      "competency": "GIC-15",
      "text": "You generate a quarterly performance report for a client and notice the portfolio is showing +11.4% while the benchmark shows +5.8%. Before sending the report, you realize the benchmark selected is the S&P 500 but the client's portfolio is 60% equities / 40% bonds. What do you do?",
      "options": [
        "Correct the benchmark to a 60/40 blended index before sending — using the S&P 500 as a benchmark for a balanced portfolio is misleading regardless of whether it makes performance look better or worse",
        "Send the report with the S&P 500 benchmark since it shows favorable relative performance",
        "Send the report without any benchmark since the comparison is not straightforward",
        "Use the client's original benchmark from when the account was opened, even if it is no longer appropriate"
      ],
      "correct": 0,
      "explanation": "Benchmark selection is a professional and compliance obligation. An inappropriate benchmark — even one that makes performance look good — produces a misleading report. The correct benchmark for a 60/40 portfolio is a 60/40 blended index."
    },
    {
      "id": "f16",
      "competency": "GIC-16",
      "text": "The firm purchases a new server for $18,000. The bookkeeper wants to expense it as an office supply purchase this month. Why is this incorrect and what is the right treatment?",
      "options": [
        "A server that provides benefit over multiple years must be capitalized as an asset and depreciated — expensing it immediately overstates this period's expenses and understates the firm's long-term asset base",
        "It is correct since the server is a technology purchase, which is always expensed",
        "The treatment depends on the firm's cash accounting method — under cash basis, immediate expensing is acceptable",
        "The threshold for capitalization is $25,000 — items below this amount should be expensed"
      ],
      "correct": 0,
      "explanation": "Capitalization rules require that assets providing multi-year benefit be recorded as assets and depreciated over their useful life. Expensing an $18,000 server produces an inaccurate income statement and an understated balance sheet."
    },
    {
      "id": "f17",
      "competency": "GIC-17",
      "text": "During daily reconciliation, you find a $4,200 discrepancy in a client account — the portfolio management system shows 100 shares valued at $42/share while the custodian shows the same 100 shares at $84/share. After investigation, you discover the custodian applied a 2-for-1 stock split but the portfolio system did not. What is the resolution?",
      "options": [
        "Process the corporate action in the portfolio management system: double the share count to 200 shares at $42/share and verify the total market value now matches the custodian — then document the error, root cause, and resolution",
        "Accept the custodian's figures since they are always authoritative",
        "Accept the portfolio system's figures and report the discrepancy to the custodian as their error",
        "Escalate immediately to senior management since the discrepancy exceeds $1,000"
      ],
      "correct": 0,
      "explanation": "The corporate action (2-for-1 split) was processed by the custodian but not by the portfolio system. The resolution is to apply the split in the portfolio system and verify the reconciliation clears. Documentation is required regardless of size."
    },
    {
      "id": "f18",
      "competency": "GIC-18",
      "text": "A client's net worth statement shows total assets of $845,000 and total liabilities of $410,000. This is the third consecutive year the net worth has declined (from $950,000 two years ago and $890,000 last year). What does this trend signal and what is the appropriate advisor response?",
      "options": [
        "Liabilities are growing faster than assets over three consecutive years — this is a structural financial warning that requires an honest conversation about what is driving the trend and what needs to change in the financial plan",
        "A declining net worth over three years is normal during a market downturn and does not require immediate action",
        "The trend is not significant since the client still has positive net worth",
        "Request updated documents to verify the figures are accurate before drawing conclusions"
      ],
      "correct": 0,
      "explanation": "Three consecutive years of declining net worth signals a structural problem, not a market event. Even with positive net worth, the trend means liabilities are outpacing assets. This requires investigation and a plan response, not reassurance."
    },
    {
      "id": "f19",
      "competency": "GIC-19",
      "text": "After running the quarterly billing cycle, your reconciliation shows that 3 accounts were billed $150 more than their calculated fee due to an AUM calculation error — the fee was calculated on a higher balance than the actual quarter-end balance. What is the correct response?",
      "options": [
        "Credit each of the three accounts for the $150 overbilling, document the error and its cause, correct the AUM calculation process, and report the error to the compliance department per firm policy",
        "Apply the $450 total overbilling as a credit against next quarter's fees to avoid the administrative burden of individual credits",
        "No action is required since $150 per account is below the materiality threshold",
        "Notify the clients informally and resolve at the next billing cycle"
      ],
      "correct": 0,
      "explanation": "Fee errors — even small ones — must be corrected immediately, documented completely, and reported to compliance. Billing clients more than their agreed fee is a compliance violation. Materiality thresholds do not apply to unauthorized fee deductions."
    },
    {
      "id": "f20",
      "competency": "GIC-20",
      "text": "You are entering a client's retirement account information into the financial planning software. The client told you their 401(k) balance is 'around $485,000.' Their statement shows the quarter-end balance as $478,340. Which figure should you enter?",
      "options": [
        "The documented figure from the statement: $478,340 — client estimates are unreliable for planning purposes and all data entry must be sourced from verified documents",
        "The round number of $480,000 as a reasonable approximation",
        "The client's estimate of $485,000 since they know their account better than a statement",
        "The average of $481,670 to balance the two sources"
      ],
      "correct": 0,
      "explanation": "Every data entry must be sourced from a verified document — never from client memory. The quarter-end statement is the authoritative figure. Estimates produce plans that reflect estimates, not reality."
    },
    {
      "id": "f21",
      "competency": "GIC-21",
      "text": "During a self-audit of client files, you find that 8 of 20 files are missing the signed ADV Part 2 delivery receipt. The annual ADV was sent to all clients 4 months ago. What is the appropriate response?",
      "options": [
        "Report the gap to the compliance department, identify the 8 clients who did not return a receipt, and follow up to obtain signed receipts — then implement a tracking process to prevent the same gap next year",
        "Send the ADV Part 2 again to the 8 clients and wait for them to return receipts at their convenience",
        "Note the gap in the file with an explanation that the ADV was sent and compliance assumes receipt",
        "No action is needed since the firm has records that the ADV was sent, which is sufficient"
      ],
      "correct": 0,
      "explanation": "Sending the ADV is required; documenting receipt is also required. Missing receipts are an audit finding waiting to happen. Reporting to compliance, following up to obtain receipts, and fixing the process prevents recurrence."
    },
    {
      "id": "f22",
      "competency": "GIC-22",
      "text": "You send an email to operations requesting a wire transfer for a client. The wire does not process and you later find out the email contained the account number but not the wire amount, destination bank, or wire instructions. The wire cutoff has now passed. What should have been in the original request?",
      "options": [
        "Client name and account number, wire amount, destination bank name and routing number, beneficiary account number and name, any special instructions, and the requested processing date — all in the first email",
        "A phone call to operations rather than an email, since wire requests require verbal confirmation",
        "The client's signed authorization form, which operations can use to look up all other details",
        "A general description of the wire request with a follow-up call to provide specifics"
      ],
      "correct": 0,
      "explanation": "Money movement requests must include every piece of information operations needs to process correctly in the first communication. Missing any element causes delays and, in time-sensitive situations, missed cutoffs."
    },
    {
      "id": "f23",
      "competency": "GIC-23",
      "text": "You are preparing the meeting packet for a client's annual review. The performance report you generated shows the client's account is up 9.2% while the benchmark is up 12.1%. Before sending the packet to the advisor, what additional preparation is most important?",
      "options": [
        "Prepare a brief note for the advisor explaining the 2.9% underperformance — what drove it, whether it is within the normal range for this strategy, and suggested talking points for the client conversation",
        "Regenerate the report using a different benchmark to produce a more favorable comparison",
        "Add a disclaimer to the performance report noting that past performance does not guarantee future results",
        "Send the packet as-is since the advisor will identify and address the underperformance in the meeting"
      ],
      "correct": 0,
      "explanation": "The advisor pre-meeting brief should flag potential client concerns — including underperformance — with context and suggested talking points. This is the value of thorough preparation. Sending the packet without a briefing note leaves the advisor unprepared."
    },
    {
      "id": "f24",
      "competency": "GIC-24",
      "text": "During a supervised suitability needs analysis, a client says: 'I want to invest this $300,000 conservatively, but I need it to grow enough that I can retire in 8 years.' You calculate that retiring in 8 years requires approximately 7.5% annual growth on this amount. What is the correct way to handle this conflict?",
      "options": [
        "Surface the conflict directly: a conservative strategy is unlikely to achieve 7.5% growth. Present the three options — accept more investment risk, extend the working timeline, or reduce retirement income expectations — and document the discussion and the client's decision",
        "Select a 'moderate' strategy as a compromise between conservative and the required return",
        "Document 'conservative with growth objective' and invest conservatively as stated",
        "Recommend a 7.5% return target and explain that this requires an aggressive strategy, overriding the client's stated preference"
      ],
      "correct": 0,
      "explanation": "The fiduciary obligation requires surfacing conflicts between stated preference and mathematical reality. A conservative strategy cannot reliably achieve 7.5% growth. The client must make an informed choice among the available options — not have the conflict papered over."
    },
    {
      "id": "f25",
      "competency": "GIC-25",
      "text": "A client has a financial advisor, a CPA, and an estate attorney, but you discover the financial plan shows the client's taxable brokerage account titled in their individual name while the estate plan requires it to be titled in the name of their revocable trust. What action is required?",
      "options": [
        "This is a plan implementation gap — the account must be retitled into the trust to fund it properly. Coordinate with the estate attorney to confirm the correct titling and with the custodian to process the retitling before it becomes a probate issue",
        "Note the discrepancy in the file and address it at the next annual review",
        "The attorney's responsibility — no action needed from the advisory team",
        "Retitle the account immediately without consulting the attorney since the intent is clear from the trust document"
      ],
      "correct": 0,
      "explanation": "An unfunded trust is nearly useless. This is a wealth management coordination gap — the legal document exists but the financial account does not reflect it. The advisor must coordinate with the attorney and custodian to fund the trust correctly."
    },
    {
      "id": "f26",
      "competency": "GIC-26",
      "text": "A client asks why their portfolio holds municipal bonds in their Roth IRA account. You know from your product knowledge that municipal bond interest is federal tax-exempt. Why is this placement potentially suboptimal?",
      "options": [
        "Municipal bonds' tax-exempt interest provides no additional benefit inside a Roth IRA, which is already tax-free. The yield premium of munis over taxable bonds compensates for the tax exemption — placing them in a Roth eliminates the tax advantage while accepting the lower pre-tax yield",
        "Municipal bonds are not allowed in retirement accounts due to their tax-exempt status",
        "Roth IRAs require growth investments — income-producing bonds are not appropriate",
        "There is no issue — the tax treatment of the account and the bond are independent"
      ],
      "correct": 0,
      "explanation": "Municipal bonds are priced to provide a lower pre-tax yield in exchange for their tax exemption. In a Roth IRA — which is already tax-free — the tax exemption adds no value. The after-tax yield would typically be higher with a taxable bond in the same account."
    },
    {
      "id": "f27",
      "competency": "GIC-27",
      "text": "A client who normally calls every few weeks has not contacted the office in three months. They also missed their annual review meeting without rescheduling and did not respond to two emails. What is the appropriate response?",
      "options": [
        "Treat this as a potential attrition signal and make direct personal contact — call the client, acknowledge the gap, and ask a direct question about whether the relationship is meeting their expectations",
        "Continue the normal service cadence and wait for the client to re-engage on their own timeline",
        "Send a formal letter documenting the missed review and requesting a response within 30 days",
        "Schedule a home visit to check on the client's wellbeing"
      ],
      "correct": 0,
      "explanation": "Sudden disengagement is one of the strongest attrition signals. The appropriate response is proactive, personal contact — not patience. A direct question about whether the relationship is meeting expectations gives the client a chance to either raise their concern or be reassured by the outreach."
    },
    {
      "id": "f28",
      "competency": "GIC-28",
      "text": "A client's target portfolio is 60% US equities / 20% international equities / 20% bonds. The current allocation is 68% US equities / 18% international equities / 14% bonds. You are modeling the rebalancing trades on a $400,000 taxable account. What is the minimum set of trades that restores the target?",
      "options": [
        "Sell approximately $32,000 of US equities; use the proceeds to buy $8,000 of international equities and $24,000 of bonds — restoring US equities to 60% ($240K), international to 20% ($80K), and bonds to 20% ($80K)",
        "Sell all overweight positions simultaneously and buy all underweight positions with the proceeds",
        "Sell $32,000 of US equities and buy $32,000 of bonds only, leaving international unchanged",
        "Buy the underweight positions using new contributions rather than selling anything"
      ],
      "correct": 0,
      "explanation": "US equities are 8% overweight ($32,000 on $400K). International is 2% underweight ($8,000). Bonds are 6% underweight ($24,000). The minimum correction sells $32,000 of US equities and buys both underweight positions proportionally."
    },
    {
      "id": "f29",
      "competency": "GIC-29",
      "text": "The 2-year Treasury yield rises above the 10-year Treasury yield (the yield curve inverts). In your weekly market trend summary for the advisor, how should you characterize this?",
      "options": [
        "Note that the yield curve has inverted — a condition that has historically preceded most US recessions, though with uncertain timing — and identify which client portfolios have the most exposure to the risks typically associated with economic slowdown",
        "Predict that a recession will begin within the next six months based on the historical pattern",
        "Recommend shifting all client portfolios to cash since recession is imminent",
        "Dismiss it as a temporary technical event unlikely to reflect economic fundamentals"
      ],
      "correct": 0,
      "explanation": "The yield curve inversion is a meaningful signal worth noting — but it is a pattern, not a prediction. The professional response acknowledges the historical context, avoids specific timing claims, and identifies portfolio implications for the advisor's consideration."
    },
    {
      "id": "f30",
      "competency": "GIC-30",
      "text": "You have completed a research brief recommending against adding a specific alternative investment fund to the firm's model portfolios. The fund has strong marketing materials and the advisor has expressed initial enthusiasm. How do you present the finding?",
      "options": [
        "Lead with the conclusion directly: 'After reviewing [Fund], I recommend we do not use it. The primary reasons are: [1, 2, 3]. Here is the supporting evidence.' Then provide the counterarguments and the data that informed the conclusion.",
        "Present the positive and negative factors equally and ask the advisor to make the call without stating your view",
        "Present only the positive factors since the advisor is enthusiastic and a negative recommendation may create friction",
        "Ask a colleague to review and present the finding since your negative recommendation may conflict with the advisor's preference"
      ],
      "correct": 0,
      "explanation": "Professional research communication leads with the conclusion, regardless of whether it aligns with the audience's prior view. Presenting findings neutrally to avoid conflict is not objectivity — it is avoidance. The advisor needs the conclusion and the reasoning to make a good decision."
    }
  ]
}
$jsonb$::jsonb
)
ON CONFLICT (exam_code) DO UPDATE SET
  title        = EXCLUDED.title,
  description  = EXCLUDED.description,
  passing_score = EXCLUDED.passing_score,
  content      = EXCLUDED.content,
  updated_at   = now();

-- ============================================================================
-- VERIFICATION
-- SELECT exam_code, title, passing_score,
--        jsonb_array_length(content->'questions') as question_count
-- FROM public.final_exams;
-- Expected: 1 row, WSC-FINAL-2026, passing_score 85, question_count 30
-- ============================================================================
