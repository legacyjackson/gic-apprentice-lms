-- ================================================================
-- GIC LMS — MASTER SETUP PART 5
-- Run parts in order: 1 → 2 → 3 → 4 → 5
-- ================================================================


-- ── module26_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 26 CONTENT
-- Reconciliation & Operations Controls
-- ============================================================================
update public.modules set
  title = 'Reconciliation & Operations Controls',
  competency_id = 'OJL-17',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Reconcile what the firm''s systems say with what the custodian''s records say — daily, monthly, and annually — and build the operational controls that catch errors before they become incidents.',
  learning_objectives = ARRAY[
    'Perform daily, monthly, and annual reconciliation between firm and custodial records',
    'Identify and resolve common reconciliation breaks',
    'Calculate and apply advisory fees accurately',
    'Process corporate actions correctly',
    'Build segregation-of-duties and audit-trail controls appropriate to the firm''s size'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Reconciliation — Why It Exists and What It Catches",
        "summary": "Reconciliation is the discipline of comparing what the firm thinks it has to what the custodian says it has — and chasing down every difference. It is the operational backbone of trustworthy reporting.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A firm's internal portfolio management system (PMS) tracks positions, transactions, cash flows, performance, and fees. The custodian's system tracks the same things. The two systems should always agree. They sometimes do not — due to delayed feeds, manual entries, corporate actions, fee accruals, or genuine errors. Reconciliation is the practice of comparing the two records, identifying every difference, and resolving each one. Done daily, reconciliation catches errors when they are cheap to fix. Done poorly or rarely, errors compound and reports lose credibility."},
          {"type": "subheading", "content": "What reconciliation catches"},
          {"type": "list", "items": [
            "Trades placed but not reflected in the PMS (or vice versa)",
            "Position quantity discrepancies — a corporate action processed differently in the two systems",
            "Cost basis differences — particularly after wash-sale adjustments, return-of-capital distributions, or transfers in from external accounts",
            "Cash balance differences — a fee accrued in the PMS but not yet debited at the custodian (or vice versa)",
            "Income discrepancies — a dividend posted on different dates in the two systems",
            "Pricing discrepancies — particularly for less liquid securities where the PMS and custodian use different pricing sources",
            "Account-level discrepancies — accounts that exist in one system but not the other (transfers in or out, account closures)"
          ]},
          {"type": "subheading", "content": "Daily reconciliation"},
          {"type": "paragraph", "content": "At the start of every business day, the firm's operations team (or, at smaller firms, the apprentice or operations-aware advisor) compares the prior day's positions and transactions between the PMS and the custodian. Modern PMS platforms automate most of this — they ingest the custodian's feed each night and produce an exception report showing only items that did not auto-reconcile. The work is in resolving the exceptions, not in checking every position manually. Common patterns: a manual trade entered yesterday and not yet flowing through correctly; a corporate action that posted overnight; a fee accrual not yet matched against the custodian's debit."},
          {"type": "subheading", "content": "Monthly reconciliation"},
          {"type": "paragraph", "content": "At month-end, a more comprehensive reconciliation: full position match, cash match, fee accrual match, performance calculation tie-out. The monthly reconciliation produces the foundation for client statements and performance reporting (Module 22). Any unresolved breaks at month-end must be documented and tracked to resolution — they cannot be ignored or hidden. At many firms, the operations team produces a monthly reconciliation report that is signed off by the compliance officer or operations manager."},
          {"type": "subheading", "content": "Annual reconciliation"},
          {"type": "paragraph", "content": "At year-end, on top of the monthly reconciliation, there is a comprehensive tax-level reconciliation: realized gains/losses match between PMS and custodian; cost basis for each lot matches; income types match (dividends, qualified dividends, interest, return of capital); tax-reportable transactions match. The custodian's 1099 reports are the official tax documents — the PMS records should agree. Discrepancies must be resolved before tax-reporting season begins, both because corrections after tax filing are expensive and because mismatched records destroy CPA workflows."},
          {"type": "callout", "kind": "key", "content": "The custodian's records are the official truth. If the PMS disagrees, fix the PMS — not the other way around. Clients see the custodian's statement; their reality is what the custodian says it is."},
          {"type": "subheading", "content": "Tools and automation"},
          {"type": "paragraph", "content": "Most modern advisory firms use a portfolio management system (Orion, Tamarac, Black Diamond, Addepar, others) that automates the bulk of reconciliation through automated feeds from the custodian. The technology handles the routine; humans handle the exceptions. An exception is any item that did not auto-reconcile. The discipline is in the exception workflow: investigate, identify the cause, correct in the appropriate system, document the resolution. Exceptions that linger are operational debt — they accumulate until they become incidents."},
          {"type": "case_study", "title": "The cost basis discrepancy", "scenario": "An apprentice notices a daily reconciliation exception: cost basis on a tax lot of VTI in Naomi's taxable account is $245 per share in the PMS but $241 per share at the custodian. The difference is $4 per share across 252 shares — $1,008 of cost basis difference. Investigation: VTI paid a small return-of-capital distribution earlier in the year. The custodian's system reduced cost basis by the ROC amount; the PMS did not pick up the adjustment correctly. The apprentice initiates a basis adjustment in the PMS to align with the custodian's record, documents the reason, and reports the exception type to the operations manager for systemic review (because the issue likely affected other accounts with the same security).", "discussion": "A $1,008 cost basis difference seems trivial — until tax-loss harvesting decisions or capital gains calculations depend on it. The same systemic issue across 50 accounts is meaningful. Daily reconciliation caught the issue when it was a single-account fix; without the discipline, it would have surfaced at tax time across many accounts."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Common Reconciliation Breaks and How to Resolve Them",
        "summary": "Knowing the typical break patterns lets you triage exceptions quickly. Most breaks fall into a few recurring categories with well-understood resolution paths.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Reconciliation exceptions are not all created equal. Some are routine and self-resolving by the next day. Some require active intervention. Some indicate a deeper systemic issue. Triaging exceptions efficiently means recognizing the pattern, applying the standard resolution, and escalating only what genuinely needs investigation."},
          {"type": "subheading", "content": "Timing breaks — usually self-resolving"},
          {"type": "paragraph", "content": "Most reconciliation breaks are timing differences that resolve themselves within 1-2 business days. A trade placed late on Friday may post to the custodian's system Saturday and to the PMS's automated feed Monday morning. A dividend ex-date may produce the dividend in the PMS on the ex-date but at the custodian on the pay-date. These breaks resolve themselves — but you should still note them as expected breaks so they do not get lost in the exception report."},
          {"type": "subheading", "content": "Corporate actions — the largest single category of breaks"},
          {"type": "glossary", "terms": [
            {"term": "Cash dividend", "definition": "A simple distribution of cash to shareholders. Reconciles easily in most systems."},
            {"term": "Stock dividend", "definition": "Additional shares of the same security distributed as a dividend. Requires the PMS to add the new shares at the correct basis."},
            {"term": "Stock split", "definition": "Existing shares split into a larger number; per-share price adjusted proportionally. Position quantity and cost basis per share both change."},
            {"term": "Reverse split", "definition": "Existing shares consolidated into a smaller number; per-share price adjusted up. Often associated with fractional share roundings."},
            {"term": "Spin-off", "definition": "A company distributes shares of a subsidiary to existing shareholders. Cost basis allocation between the original and spun-off security is required."},
            {"term": "Merger", "definition": "Two companies combine; shares of the acquired company become shares of the acquirer or cash. Tax treatment varies."},
            {"term": "Return of capital (ROC)", "definition": "A distribution that is treated as a return of the investor's basis rather than income. Reduces the cost basis of the position rather than being taxed as a dividend."},
            {"term": "Tender offer", "definition": "An offer to buy shares from existing holders at a stated price. Acceptance requires action; declination is the default."}
          ]},
          {"type": "subheading", "content": "How corporate actions create breaks"},
          {"type": "paragraph", "content": "Custodians typically process corporate actions on their announced effective dates with their own data sources. PMS platforms ingest corporate action data from third-party feeds (sometimes the same provider, sometimes different) that may have slight timing or methodology differences. A return of capital distribution might be classified as a dividend by the PMS until the security's annual tax characterization is finalized. A spin-off might post differently based on different basis allocation methodologies. Most of these resolve when the tax year's final classifications are published — but until then, reconciliation requires monitoring and sometimes manual adjustment."},
          {"type": "subheading", "content": "Cash breaks"},
          {"type": "paragraph", "content": "Cash differences between PMS and custodian are usually small but worth tracking. Common sources: advisory fee accruals (PMS books the fee as it is earned; custodian debits when the fee is actually charged); interest accrual timing on bonds (PMS uses straight-line; custodian uses actual coupon dates); ACH transfers in flight (the PMS may have recorded the transfer at initiation; the custodian recognizes it on settlement); pending distributions (a trade in process where cash will arrive). Cash breaks usually resolve within days; sustained cash breaks indicate a more meaningful issue."},
          {"type": "subheading", "content": "Position breaks — the highest-priority category"},
          {"type": "paragraph", "content": "A position quantity discrepancy — the firm thinks the client owns 252 shares of VTI, the custodian shows 250 — is the most serious type of break. It can indicate a real operational error: a trade that did not actually execute, a transfer error, a manual entry mistake. Investigate position breaks immediately. Do not let a position quantity break sit overnight without explanation. Either the client's wealth is mismeasured (you are reporting positions they do not own or missing positions they do) or there is an operational failure that will surface in some other way."},
          {"type": "callout", "kind": "warn", "content": "Any position quantity break that cannot be explained within the trading day is an escalation event. Document, investigate, involve operations and compliance — do not move on until resolved."},
          {"type": "subheading", "content": "Resolving the break — fix in the right system"},
          {"type": "paragraph", "content": "When a break is identified and the cause understood, the fix goes in the system that was wrong. If the PMS missed an entry, post the entry in the PMS to align with the custodian. If the custodian's data feed had a glitch, work with the custodian to correct (rare but possible). Do not adjust the PMS to mask a real issue. The audit trail should show what was changed, when, by whom, and why. PMS platforms log these adjustments automatically."},
          {"type": "case_study", "title": "Marcus and Tasha's spin-off", "scenario": "A company Marcus owns through a single-stock position spins off a subsidiary. Each share of the parent company also receives a fractional share of the spin-off. The custodian processes the corporate action: original position retained, new spin-off position created, cost basis allocated 87% to original and 13% to spin-off (per the company's IRS Form 8937 guidance). The PMS, however, uses a third-party data provider that initially allocates 90/10. Daily reconciliation flags the basis discrepancy. The apprentice researches the company's filing, confirms the 87/13 allocation is correct per IRS guidance, and adjusts the PMS to align with the custodian. Documents the source (company's Form 8937) and the resolution. Reports the data feed discrepancy to the operations manager for review with the third-party provider.", "discussion": "Corporate actions are operationally complex. Reconciliation catches the discrepancies; research identifies the correct treatment; fix in the appropriate system; document the source. The audit trail months later shows exactly what was decided and why."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Advisory Fee Calculation and Application",
        "summary": "How and when advisory fees get charged is governed by the advisory agreement and the firm's billing process. Getting fees right — and reconciling them precisely — is fundamental operational integrity.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Advisory fees are how the firm gets paid. The advisory agreement specifies the fee schedule, billing frequency, calculation method, and authorization for the custodian to debit the fee directly from client accounts. Calculating fees accurately, applying them correctly, and reconciling them against the firm's expectations is one of the most-watched operational controls — both because fee errors generate immediate client complaints when overcharged and immediate revenue loss when undercharged."},
          {"type": "subheading", "content": "Fee structures"},
          {"type": "list", "items": [
            "Tiered AUM percentage — different rates apply to different brackets of AUM (e.g., 1.00% on first $1M, 0.75% on next $4M, 0.50% above $5M)",
            "Flat percentage — single rate across all AUM",
            "Fixed dollar — flat annual fee regardless of asset level (common in financial planning)",
            "Project or hourly — used for specific engagements (estate planning project, one-time financial plan)",
            "Performance fee — fee tied to performance above a benchmark; subject to SEC rules requiring qualified clients and specific structure",
            "Bundled vs unbundled — fee covers all services or itemized by service"
          ]},
          {"type": "subheading", "content": "Calculation method"},
          {"type": "paragraph", "content": "The advisory agreement specifies the calculation method. Common: fees calculated quarterly based on the average daily balance over the prior quarter; fees calculated based on the period-end balance; fees calculated based on the period-start balance; fees calculated as a daily accrual based on each day's balance. Different methods produce slightly different fee amounts for the same client. Whatever the method, it must be applied consistently and disclosed clearly."},
          {"type": "subheading", "content": "Pro-rating for partial periods"},
          {"type": "paragraph", "content": "When clients are added or terminated mid-period, the fee for the period is pro-rated. New client added on day 20 of a 90-day quarter pays 70/90ths of the quarterly fee. Terminated client gets the same treatment in reverse — billed only for the days they were a client during the period. Pro-rating must be documented in the advisory agreement and applied consistently."},
          {"type": "subheading", "content": "Fee debits from client accounts"},
          {"type": "paragraph", "content": "Most RIAs are authorized in the advisory agreement to instruct the custodian to debit fees directly from client accounts. The custodian processes the debit on the scheduled date; the client sees the debit on their statement. The custodian sends an automated 'fee debit' notification to the client (or to the advisor for relay) confirming the fee amount and source account. This is one of the limited-authority transactions allowed without per-event client consent — but the authority must be clearly granted in the advisory agreement and the firm must have processes to ensure fees are calculated correctly."},
          {"type": "callout", "kind": "warn", "content": "Overcharging clients on fees, even by small amounts, is one of the most common findings in SEC and state regulatory exams. The error usually comes from incorrect fee schedule application, not bad intent — but the consequence (restitution, fines, reputational damage) is real. Reconcile fees carefully every billing cycle."},
          {"type": "subheading", "content": "Fee reconciliation"},
          {"type": "paragraph", "content": "Each billing cycle, the firm should reconcile: the expected fee (calculated from the agreement and AUM); the fee invoice generated by the system; the fee debited at the custodian; the revenue recognized in the firm's accounting. All four numbers should agree. Discrepancies require investigation: is the AUM source correct, is the rate schedule current, are pro-rations correct, did the custodian process the debit correctly. The fee reconciliation is typically run by operations or compliance, with sign-off after every billing cycle."},
          {"type": "subheading", "content": "Form ADV Part 2 alignment"},
          {"type": "paragraph", "content": "The fee schedule actually applied must match the fee disclosure in the firm's Form ADV Part 2. If the firm has different rate cards for different client segments, all of them must be disclosed. If fees are negotiable, the practice and basis must be disclosed. A regulator comparing a client's actual billed fees against the firm's Form ADV looking for unexplained discrepancies is a common audit pattern. Keep alignment tight."},
          {"type": "case_study", "title": "The pro-ration that nobody caught", "scenario": "A client terminated the relationship on March 15. The firm's quarterly billing process ran on March 31 and billed the full quarter's fee for January 1 - March 31. The client noticed: 'I terminated mid-March, why is the fee for the full quarter?' The apprentice investigated: the billing system was not configured to apply pro-ration for the termination month. Total over-billing: $1,234. Resolution: the firm refunded the over-billed amount immediately, communicated transparently with the client (who appreciated the prompt fix and stayed within the firm's friend network), and updated the billing configuration to handle terminations correctly going forward. The compliance officer also reviewed the prior 12 months of terminations to identify other clients who may have been similarly over-billed; found two other instances and processed refunds.", "discussion": "The error was small in any single case but systemic across the firm. Without the client's question and the apprentice's investigation, the issue would have persisted. Process fix: terminations now trigger an automatic pro-rated billing calculation; compliance reviews terminations monthly. The cost of operational fix is much lower than the cost of an SEC finding."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Processing Corporate Actions and Income",
        "summary": "Corporate actions and income distributions require active operational management. Mishandling them creates tax errors, reporting errors, and client confusion.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Securities held in client accounts generate a steady stream of events that require operational handling: dividends, interest, return of capital distributions, stock splits, spin-offs, mergers, tender offers, rights offerings. Some of these are passive (the custodian processes automatically and the PMS reflects the result). Others require election decisions (a tender offer, a merger consideration choice between cash or stock). All require accurate reflection in records, correct tax treatment, and clear client communication where appropriate."},
          {"type": "subheading", "content": "Passive corporate actions"},
          {"type": "paragraph", "content": "Most corporate actions are passive — the custodian processes them automatically and the PMS picks up the result. Cash dividends post to the client's cash balance. Stock dividends create new shares. Stock splits adjust position quantities and per-share basis. Return of capital reduces basis. These do not require advisor action. They do require reconciliation (Lesson 2) to ensure the PMS reflects what the custodian shows."},
          {"type": "subheading", "content": "Active corporate actions — election decisions"},
          {"type": "paragraph", "content": "Some corporate actions present the client with a choice: accept a tender offer or hold the shares; choose cash or stock in a merger; exercise or sell warrants; participate in or skip a rights offering. The custodian notifies the firm of the action with a deadline. The firm has to decide (within authority granted) or coordinate with the client to decide. Defaults vary: tender offers default to non-participation (you keep the shares); rights offerings default to non-exercise (the rights expire); merger elections often default to a specific option per the merger documents."},
          {"type": "subheading", "content": "Income distributions and tax characterization"},
          {"type": "paragraph", "content": "Income distributions from securities — dividends, interest, capital gain distributions from funds — are characterized for tax purposes by the security issuer or fund company. Same dollar amount can be characterized differently depending on its source. Common characterizations: ordinary dividends, qualified dividends (preferential tax treatment), short-term capital gain distributions (ordinary rates), long-term capital gain distributions (preferential rates), tax-exempt interest (federal-tax-free), foreign-source income (eligible for foreign tax credit), and return of capital (basis reduction, not income). Characterizations are finalized in January when the tax-year reporting completes, sometimes resulting in reclassification of distributions made during the year."},
          {"type": "subheading", "content": "January reclassifications"},
          {"type": "paragraph", "content": "Many mutual funds and ETFs reclassify some of their distributions in January, after the fact. A distribution paid as 'dividend' during the year may be reclassified to return of capital or to a different capital gain treatment when the fund's final tax allocations are determined. The reclassification can change client tax outcomes — sometimes significantly. The reconciliation process must pick up these reclassifications and update PMS records accordingly. CPAs preparing client returns need the final 1099 reflecting reclassifications, not the in-year preliminary characterizations."},
          {"type": "subheading", "content": "Dividends and DRIP"},
          {"type": "paragraph", "content": "Dividend reinvestment plans (DRIP) automatically reinvest cash dividends in additional shares of the dividend-paying security. Set per account and per security at the custodian. Two considerations: tax-loss harvesting requires turning off DRIP on the security being harvested (to prevent wash-sale through the reinvestment, per Module 24); systematic rebalancing benefits from turning off DRIP and letting dividends accumulate in cash to be directed toward underweight allocations. Many client accounts have DRIP enabled by default; reviewing and adjusting DRIP settings is part of account setup and annual review."},
          {"type": "subheading", "content": "Communicating corporate actions to clients"},
          {"type": "paragraph", "content": "Some corporate actions warrant client communication; many do not. Threshold: communicate to the client when the action requires a decision (tender offer with potential financial impact, merger with election choice), when the action materially changes the holding (large special dividend, significant spin-off), or when the action will be visible on the client's statement in a way that may prompt questions. Routine dividends and small distributions do not require communication. Use judgment; over-communicating creates noise, under-communicating creates surprises."},
          {"type": "case_study", "title": "The unexpected reclassification", "scenario": "In December, Devon's portfolio shows $14,200 in distributions from a REIT ETF, categorized at that point as 'qualified dividends.' In late January, the fund company issues final tax allocations: the $14,200 is actually 38% qualified dividends, 41% ordinary non-qualified dividends, 16% return of capital, and 5% long-term capital gains. The PMS picks up the reclassification through the custodian's updated reporting. Devon's tax outlook changes meaningfully — what looked like all preferential-rate income includes substantial ordinary rate income. The apprentice notifies Devon and his CPA: 'The REIT ETF distribution characterization has been finalized differently than initially reported. Your final 1099 will reflect $5,400 in qualified dividends instead of $14,200, with the remainder in ordinary dividends, ROC, and capital gain distributions. Tax impact is approximately $1,800 higher than the December projection. Updated planning attached.'", "discussion": "REITs and certain other funds reclassify substantially in January. Without picking up the reclassification, Devon's tax projection would have been materially wrong. The CPA needs the final 1099 to file correctly. The apprentice's role: detect the reclassification, communicate the impact, update plans accordingly. Operational discipline matters at tax time."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Operations Controls and Segregation of Duties",
        "summary": "Operations controls are how a firm prevents errors and fraud through structural process design. Even at small firms, the principles can be applied with discipline.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "A firm's operational integrity depends on more than individual diligence — it depends on the structural controls that catch errors before they propagate. Segregation of duties (no one person controls the entire chain of a high-risk operation), independent review (a second set of eyes on consequential items), and audit trails (every action documented) are the three pillars of operational control. At larger firms, these are formalized by entire operations departments. At smaller firms, the principles still apply — implemented with discipline rather than scale."},
          {"type": "subheading", "content": "Segregation of duties — the principle"},
          {"type": "paragraph", "content": "Segregation of duties means that no single person should control all phases of a sensitive operation. The classic example: the person who authorizes a payment should not also be the person who initiates it, and neither should be the person who reconciles the bank statement. If all three are the same person, that person can divert funds and cover it up. With segregation, the diversion would require collusion across multiple people — much harder to execute and easier to detect."},
          {"type": "subheading", "content": "Common segregations in advisory operations"},
          {"type": "list", "items": [
            "Trade authorization vs trade execution — the apprentice may prepare the trade; the trader executes; the operations team reconciles",
            "Fee calculation vs fee review — the system calculates; operations or compliance reviews; finance recognizes revenue",
            "Account opening vs disbursement authority — the person who opens an account should not be the same person who authorizes withdrawals from it",
            "Wire initiation vs wire approval — wires above a threshold require approval from a second person",
            "Personal trading vs trade execution — anyone who places client trades has constrained personal trading per firm policy"
          ]},
          {"type": "subheading", "content": "Independent review"},
          {"type": "paragraph", "content": "Beyond segregation, certain operations should have independent review even if not strictly segregated. Examples: a senior advisor reviewing all new account openings before they go live; compliance reviewing all fee calculations periodically; operations reviewing all corporate action elections; trading reviewing all suitability documentation on certain product types. Independent review is not bureaucracy — it is the structural mechanism for catching errors that the originator missed."},
          {"type": "subheading", "content": "Audit trails"},
          {"type": "paragraph", "content": "Every significant action — trade, transfer, fee debit, account change, document update — should generate a record showing who did it, when, and why. Modern PMS and CRM systems automate audit trails for actions performed within them. Actions performed outside (manual paperwork, phone calls, emails) need to be recorded manually. The audit trail serves three purposes: regulatory compliance, dispute resolution, and continuous improvement. Years later, the audit trail is what allows the firm to reconstruct what happened and why."},
          {"type": "subheading", "content": "Compliance calendar"},
          {"type": "paragraph", "content": "Most firms maintain a compliance calendar — scheduled recurring reviews, filings, and certifications. Examples: quarterly Form ADV updates if applicable; annual Form ADV re-filing; annual review of all client suitability documents; quarterly review of personal trading; semi-annual review of soft dollar arrangements; annual review of business continuity plan. Apprentices typically do not own the compliance calendar but may contribute to specific items. Knowing the cadence and respecting the deadlines is part of professionalism."},
          {"type": "subheading", "content": "Operational risk assessment"},
          {"type": "paragraph", "content": "Periodically — annually for most firms — the firm should conduct an operational risk assessment: what are the operations we perform, where are the failure modes, what controls do we have, and where are the gaps? The assessment is the structured version of the question 'what could go wrong here, and what would we do if it did.' Outputs include process improvements, control additions, and training priorities. Small firms can do this in a few hours; large firms have entire teams dedicated to it. Either way, the discipline keeps controls aligned with evolving risk."},
          {"type": "subheading", "content": "Errors as learning opportunities"},
          {"type": "paragraph", "content": "When an operational error occurs, the response should include not only the immediate correction (Module 23, Module 17) but a structured retrospective: what happened, why was it not caught, what process change would prevent recurrence. The retrospective should be blameless — focused on system improvement, not individual fault. Errors that lead to better systems are better than errors that lead to silence. The firm's error log, reviewed quarterly, reveals patterns: which operations produce the most errors, which controls are working, where new controls are needed."},
          {"type": "callout", "kind": "key", "content": "Strong operations are not the absence of errors — they are the system that detects errors quickly, corrects them cleanly, and continuously improves to reduce their frequency. Treat every error as data about how to improve."},
          {"type": "case_study", "title": "Building controls at a growing firm", "scenario": "A small RIA has grown from 1 advisor to 3 in 18 months, adding an operations associate and an apprentice. The founder previously handled all operations personally; segregation of duties was structurally impossible with one person. With the team in place, the founder works with the operations associate to build the first formal controls: trades placed by advisors are reviewed end-of-day by operations; fee calculations are reviewed quarterly by compliance (which they outsource to a consultant); wires over $50K require two-person approval; the apprentice runs daily reconciliation with senior review of any exception over $5K. The firm documents the controls in a written operations manual.", "discussion": "None of this is exotic. All of it is the standard playbook applied at the firm's scale. The investment in formalization pays back in fewer errors, faster detection of any that occur, and a defensible compliance posture as the firm grows further. Operational maturity is what enables scale."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Compliance Workflows. The regulatory framework that governs day-to-day operations and the documentation that proves we are operating within it."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "When the firm's portfolio management system and the custodian's records disagree, the appropriate response is to:", "options": ["Use whichever number is higher", "Investigate, identify the cause, and fix the system that is wrong — custodial records are the official truth", "Average the two", "Use the PMS number for client reports"], "correct": 1, "explanation": "Custodian records are the official truth. Reconciliation aligns the PMS to the custodian, with documented adjustments."},
        {"id": "q2", "prompt": "Daily reconciliation catches errors when:", "options": ["They are cheapest to fix; lingering errors compound and surface as larger incidents", "There is nothing else to do", "Required by SEC rules", "Only at year-end"], "correct": 0, "explanation": "Speed of detection determines cost of correction. Daily reconciliation flags exceptions while they are still single-account fixes."},
        {"id": "q3", "prompt": "A return of capital (ROC) distribution affects the security's:", "options": ["Tax bracket", "Cost basis — it is treated as a return of the investor's basis rather than income, reducing basis", "Dividend yield", "Sector classification"], "correct": 1, "explanation": "ROC reduces basis rather than producing current income. When the security is eventually sold, the gain is larger because of the basis reduction."},
        {"id": "q4", "prompt": "January reclassifications by mutual funds and ETFs can affect:", "options": ["Only the fund company", "Client tax outcomes — distributions paid during the year may be re-characterized when final tax allocations are determined, changing whether amounts were dividends, ROC, capital gains, etc.", "Only IRA accounts", "Only foreign investments"], "correct": 1, "explanation": "January reclassifications can materially change client tax outcomes. CPAs need final 1099s reflecting the reclassifications; preliminary in-year characterizations are not final."},
        {"id": "q5", "prompt": "A position quantity discrepancy between PMS and custodian is:", "options": ["A routine timing break that can wait", "A high-priority break that should be investigated immediately and not left overnight without explanation", "Always the custodian's fault", "Usually a tax-only issue"], "correct": 1, "explanation": "Position discrepancies can indicate real operational failures — missing trades, transfer errors, manual mistakes. Escalation is appropriate when not resolved same-day."},
        {"id": "q6", "prompt": "Most advisory fees are calculated and debited based on:", "options": ["Client request each quarter", "Authority granted in the advisory agreement, with the custodian processing the debit on the scheduled date based on the firm's calculation", "Custodian discretion", "Performance only"], "correct": 1, "explanation": "Direct debit authority is granted in the advisory agreement and processed by the custodian. The firm calculates the fee; the custodian debits; the client sees both."},
        {"id": "q7", "prompt": "Overcharging clients on advisory fees, even small amounts, is:", "options": ["Generally minor and unenforced", "One of the most common findings in SEC and state regulatory exams; restitution and penalties are real", "Required for revenue maintenance", "Disclosed in marketing materials"], "correct": 1, "explanation": "Fee errors are a recurring regulatory finding. Even when unintentional, the consequence is restitution, fines, and reputational damage."},
        {"id": "q8", "prompt": "Segregation of duties means:", "options": ["Each advisor specializes in one area", "No single person should control all phases of a sensitive operation — separation creates a check that requires collusion to defeat", "All trades go through one person for consistency", "Different fees for different services"], "correct": 1, "explanation": "Segregation makes single-person fraud or error harder by ensuring multiple people see different parts of a process. Standard control in financial operations."},
        {"id": "q9", "prompt": "When a client terminates the advisory relationship mid-quarter, the fee for that quarter should be:", "options": ["Charged in full per the agreement", "Pro-rated for the days the client was actually a client during the period, per the advisory agreement", "Waived entirely", "Increased to cover transition costs"], "correct": 1, "explanation": "Pro-ration is the standard practice and must be documented in the advisory agreement. Failing to pro-rate is a common over-billing pattern flagged in exams."},
        {"id": "q10", "prompt": "Tender offers in client accounts where no election is made typically default to:", "options": ["Acceptance of the offer", "Non-participation — the client keeps the shares", "Cash exchange at the lowest offered price", "Court determination"], "correct": 1, "explanation": "Tender offers require affirmative election to participate. Without election, the client retains the shares."},
        {"id": "q11", "prompt": "Audit trails for operational actions serve which purposes?", "options": ["Only regulatory compliance", "Regulatory compliance, dispute resolution, and continuous improvement", "Internal marketing", "Tax preparation only"], "correct": 1, "explanation": "Audit trails enable reconstruction of what happened, defense in disputes, and pattern analysis for process improvement. Multi-purpose discipline."},
        {"id": "q12", "prompt": "After an operational error, the most valuable response is:", "options": ["Identifying who to blame", "A blameless retrospective focused on what process change would prevent recurrence, plus immediate client correction", "Hiding the error from compliance", "Reducing the affected client's fees as compensation"], "correct": 1, "explanation": "Blameless retrospectives produce systemic improvements. Blame produces silence and recurrence. Combine the immediate client correction with the structural fix."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 27;

-- ── module27_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 27 CONTENT
-- Compliance Workflows
-- ============================================================================
update public.modules set
  title = 'Compliance Workflows',
  competency_id = 'OJL-18',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Operate within the regulatory framework that governs advisory practice — books and records, advertising rules, supervision, exams, and the day-to-day compliance disciplines that protect clients and the firm.',
  learning_objectives = ARRAY[
    'Identify the major regulatory regimes that govern RIA and broker-dealer practice',
    'Maintain books and records that satisfy SEC, FINRA, and state requirements',
    'Apply the SEC Marketing Rule to communications and advertising',
    'Operate within supervisory frameworks and respond to inquiries',
    'Prepare for and participate in regulatory examinations'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "The Regulatory Landscape",
        "summary": "Multiple regulators govern advisory practice. Knowing which one applies to which activity — and what each one cares about — is the foundation of compliance.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Advisory and brokerage practice in the United States sits within a layered regulatory structure. The same firm and the same activity can be subject to multiple regulators at once. Understanding which regulator governs which activity, what each one cares about, and how their requirements interact is foundational. Compliance is not a single set of rules — it is a multi-dimensional framework that practitioners learn to operate within instinctively over years."},
          {"type": "subheading", "content": "The major regulators"},
          {"type": "glossary", "terms": [
            {"term": "SEC (Securities and Exchange Commission)", "definition": "Federal regulator of securities markets, broker-dealers above certain thresholds, registered investment advisers with AUM above $100M (or operating in 15+ states), public company disclosures, and securities laws including the 1933 Act, 1934 Act, and Investment Advisers Act of 1940."},
            {"term": "FINRA (Financial Industry Regulatory Authority)", "definition": "Self-regulatory organization (SRO) for broker-dealers. Sets rules, conducts exams, administers licensing exams (Series 7, 63, 65, 66, etc.), and disciplines members. Not a government agency but operates under SEC oversight."},
            {"term": "State securities regulators", "definition": "Regulate registered investment advisers below $100M AUM (state-registered RIAs) and have authority over broker-dealer activity within their state. Coordinated through NASAA (North American Securities Administrators Association)."},
            {"term": "CFPB (Consumer Financial Protection Bureau)", "definition": "Federal regulator of consumer financial products and services — primarily relevant to banking, lending, and consumer credit rather than investment advice."},
            {"term": "DOL (Department of Labor)", "definition": "Regulates retirement plans under ERISA, including rules around rollovers and fiduciary conduct toward retirement assets. Active rulemaking history around fiduciary standards."},
            {"term": "MSRB (Municipal Securities Rulemaking Board)", "definition": "Self-regulatory body for municipal securities. Relevant for firms dealing in muni bonds."},
            {"term": "CFTC (Commodity Futures Trading Commission)", "definition": "Regulates futures and derivatives markets. Relevant for firms dealing in commodity futures."}
          ]},
          {"type": "subheading", "content": "RIA vs Broker-Dealer regulation"},
          {"type": "paragraph", "content": "The two primary regulatory tracks for retail-facing investment professionals are RIA and broker-dealer. RIAs operate under the Investment Advisers Act of 1940 and applicable state laws, with fiduciary duty to clients. Broker-dealers operate under the Securities Exchange Act of 1934 and FINRA rules, with Reg BI (best interest) standard for retail recommendations. Many firms operate dual registrations — both an RIA and a broker-dealer entity, sometimes with overlapping personnel. The same person may give advice under fiduciary duty (RIA hat) and recommend products under Reg BI (BD hat) to the same client. The complexity is real."},
          {"type": "subheading", "content": "Registration thresholds"},
          {"type": "list", "items": [
            "Investment advisers with $100M+ AUM register with SEC (federal)",
            "Investment advisers below $100M AUM generally register with state regulators",
            "Investment advisers operating in 15+ states may opt for SEC registration regardless of AUM",
            "Broker-dealers register with SEC and FINRA federally; also register in each state where they do business",
            "Individual representatives must pass relevant licensing exams and register through Form U4 with the firm's appropriate regulator"
          ]},
          {"type": "subheading", "content": "Investment Adviser Representatives (IAR)"},
          {"type": "paragraph", "content": "Individuals who provide advice on behalf of an RIA are Investment Adviser Representatives. They must pass either the Series 65 exam, or hold a Series 7 plus Series 66 combination, unless they hold a qualifying professional designation (CFP, ChFC, CFA, etc.) that may exempt them in certain states. Apprentices typically work toward and pass the Series 65 during the apprenticeship, often within the first 12-18 months. The exam is not trivial but is achievable with systematic study."},
          {"type": "subheading", "content": "What each regulator cares about"},
          {"type": "list", "items": [
            "SEC — books and records, marketing rule compliance, Form ADV accuracy, conflicts of interest disclosure, custody and safety of client assets, performance reporting, supervision, anti-fraud rules",
            "FINRA — best execution, sales practices, supervision, advertising review, personal trading, communications with the public, training and licensing",
            "State regulators — registration, Form ADV alignment, fee transparency, client complaints, exam findings, anti-fraud, suitability/fiduciary alignment",
            "DOL — rollover recommendations from retirement plans, fiduciary conduct toward retirement assets, prohibited transaction exemptions"
          ]},
          {"type": "callout", "kind": "key", "content": "Compliance is not adversarial. The regulators and the firm have the same goal: protect clients and maintain the integrity of the market. Treat compliance as a partner discipline, not as friction."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Books and Records — What Must Be Kept and for How Long",
        "summary": "Books and records rules specify what records firms must maintain, in what form, and for how long. Failing to meet the requirements is one of the most common regulatory findings.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "The federal securities laws and state regulations require firms to maintain comprehensive records of their activities. Rule 204-2 under the Investment Advisers Act lays out the books-and-records requirements for RIAs; SEC Rule 17a-4 covers broker-dealers. Most retention periods are 5-7 years; some are longer. The requirements are detailed and not optional. Books-and-records deficiencies are among the most common findings in regulatory exams because the rules cover so much."},
          {"type": "subheading", "content": "Required records — RIA highlights"},
          {"type": "list", "items": [
            "Journal of all cash receipts and disbursements, including securities transactions",
            "General and auxiliary ledgers reflecting asset, liability, reserve, capital, income, and expense accounts",
            "Memoranda of every order given for the purchase or sale of securities (whether executed or not), with appropriate detail",
            "All check books, bank statements, cancelled checks, cash reconciliations",
            "All bills or statements relating to the business",
            "All trial balances, financial statements, internal audit working papers",
            "Originals of all written communications received and copies of all written communications sent relating to investment recommendations or advice given",
            "Lists of advised accounts and required client identifying information",
            "Records of every transaction in the firm's proprietary accounts",
            "Copies of advertisements, brochures, and other marketing materials with required supporting documentation",
            "Personal securities transaction records for access persons (employees with access to nonpublic client info)",
            "Code of ethics and records related to its administration"
          ]},
          {"type": "subheading", "content": "Retention periods"},
          {"type": "paragraph", "content": "Most records must be kept for 5 years from the end of the fiscal year in which the record was created — with the first 2 years in an 'easily accessible' place. Some records have longer retention requirements: organizational documents, partnership agreements, articles of incorporation, and similar foundational documents must be kept for at least 3 years after termination of the entity. Records related to written ESG/responsibility marketing have specific retention. Records of conditions giving rise to disqualification of personnel may be kept indefinitely."},
          {"type": "subheading", "content": "Electronic records and storage"},
          {"type": "paragraph", "content": "Modern firms store most records electronically. SEC and FINRA rules permit electronic record storage but require: the records be preserved exclusively in non-rewriteable, non-erasable format (WORM — Write Once Read Many) or equivalent; the records be readily accessible and producible during their retention period; the firm have systems for backing up and protecting the records; the firm be able to produce records to regulators on request in usable form. Most cloud-based record systems used in financial services are designed to satisfy these requirements; firms should verify that the specific systems they use meet the rule's requirements."},
          {"type": "subheading", "content": "Email and electronic communications"},
          {"type": "paragraph", "content": "Email and other electronic business communications must be captured and retained per the same books-and-records rules. FINRA and SEC have penalized many firms — sometimes for hundreds of millions of dollars — for off-channel communications (text messages, encrypted apps, personal email) that were used for business purposes but not captured. Modern firms typically use email archiving systems (Smarsh, Global Relay, others) that capture all business email; some also capture text messages and chat platforms. The principle: every business communication is a record subject to the rules. Personal channels for business use are violations."},
          {"type": "callout", "kind": "warn", "content": "Using personal text, WhatsApp, Signal, or any non-archived channel for business communications is a serious compliance violation that has produced hundreds of millions in fines across the industry. Use only firm-approved channels for client communications."},
          {"type": "subheading", "content": "Client records"},
          {"type": "paragraph", "content": "Client-specific records include the advisory agreement, suitability documentation, IPS, fee billing records, performance reports, all written communications, meeting notes, and any other records of the relationship. These must be maintained for the same retention periods. When a client relationship terminates, the records remain — not destroyed at termination, but retained per the books-and-records timeline."},
          {"type": "subheading", "content": "Records during examinations"},
          {"type": "paragraph", "content": "During an SEC or state exam, records will be requested. The firm has obligations to produce records promptly and in usable form. The exam request may include very specific records (all emails between Advisor A and Client B between dates X and Y), specific reports (all advisory fees billed in 2023 over $10,000), or broad samples. A well-maintained records system can respond efficiently; a poorly-maintained one cannot. Many exam findings are not about underlying conduct but about the firm's ability to produce records — a deficiency in itself."},
          {"type": "case_study", "title": "The text-message problem", "scenario": "A small RIA discovers during an internal review that several advisors have been using personal text messages with clients — coordinating meetings, answering quick questions, occasionally discussing portfolio matters. None of these messages are captured in the firm's email archive. The total volume over the past year is estimated at several hundred messages. The firm's compliance officer raises this immediately. Remediation: issue firm-approved mobile communication tools that integrate with the archiving system; train all staff that personal channels are off-limits for business; conduct a sampling review of the discovered text messages for any substantive client matters that need to be preserved as records; self-report to the firm's regulator depending on severity.", "discussion": "Self-reporting a discovered issue, combined with prompt remediation, is far preferred to the regulator finding it independently. The industry has been hit with hundreds of millions in fines over text-message issues; firms that surface and remediate proactively fare much better."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "The SEC Marketing Rule",
        "summary": "The SEC's Marketing Rule (effective November 2022) replaced the prior advertising rule and significantly changed how RIAs can market. Knowing it is essential for anyone preparing client-facing material.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Rule 206(4)-1 under the Investment Advisers Act — known as the Marketing Rule — replaced the prior advertising rule effective November 4, 2022. It modernized the rules around advertising, testimonials, endorsements, third-party ratings, and performance presentation. It is comprehensive, principles-based, and now governs essentially all RIA communications intended to obtain or retain advisory clients. Apprentices who prepare any client-facing material need to know it cold."},
          {"type": "subheading", "content": "What counts as an 'advertisement'"},
          {"type": "paragraph", "content": "Under the Marketing Rule, an advertisement is any direct or indirect communication by an investment adviser to more than one person (or to one or more persons if it includes hypothetical performance) that offers the adviser's services or new investment advisory services. It also includes any endorsement or testimonial for which an adviser provides compensation. The definition is broad and intentionally so — it captures website content, email blasts, social media posts, presentations, written marketing materials, and many other communications."},
          {"type": "subheading", "content": "General prohibitions"},
          {"type": "list", "items": [
            "Untrue statements of material fact or omissions of material fact necessary to prevent statements from being misleading",
            "Statements the adviser does not have a reasonable basis to believe it can substantiate",
            "Statements that imply the adviser would not otherwise reach without substantial qualifications that are not also presented",
            "Statements that fail to provide fair and balanced treatment of material risks and limitations",
            "Statements about specific investment advice the adviser provided in a way that is not fair and balanced",
            "Otherwise materially misleading information in any way"
          ]},
          {"type": "subheading", "content": "Testimonials and endorsements"},
          {"type": "paragraph", "content": "The Marketing Rule permits testimonials (from clients) and endorsements (from non-clients) — both prohibited under the prior rule — subject to specific conditions. Required disclosures include: whether the speaker is a client or non-client; whether cash or non-cash compensation was paid; and material conflicts of interest. Compensated testimonials and endorsements require a written agreement and adviser oversight. There are detailed rules around what counts as a testimonial vs an endorsement and what counts as a third-party rating."},
          {"type": "subheading", "content": "Performance advertising"},
          {"type": "paragraph", "content": "Performance presentations in marketing must follow detailed requirements: gross and net performance both presented with equal prominence; specific time periods (1-, 5-, and 10-year, or since inception for shorter records); use of related performance (similar accounts) with appropriate disclosures; restrictions on hypothetical performance (which requires policies designed to ensure relevance to the intended audience); restrictions on extracted performance (showing just one slice of a strategy); and various other technical requirements. Anyone preparing performance marketing without compliance review is operating in a high-risk area."},
          {"type": "callout", "kind": "warn", "content": "Performance advertising under the Marketing Rule is detailed and technical. Have compliance review any performance content before publication. Errors here are easy to make and expensive to correct."},
          {"type": "subheading", "content": "Hypothetical performance"},
          {"type": "paragraph", "content": "Hypothetical performance — including model performance, backtested performance, and targeted/projected performance — is allowed but requires specific policies and procedures, plus disclosures including the criteria used to select the audience and the inherent limitations of hypothetical performance. Importantly, hypothetical performance generally cannot be included in advertisements aimed at the general public (e.g., publicly accessible websites); it must be appropriately targeted to recipients for whom it is relevant."},
          {"type": "subheading", "content": "Third-party ratings and awards"},
          {"type": "paragraph", "content": "Using third-party ratings or awards (Forbes 'Top Advisors,' Barron's lists, etc.) in marketing requires specific disclosures: the date the rating was given; the period covered; the third party that did the rating; whether and how the adviser paid for it; the criteria used. These ratings are often industry-marketing rather than independent assessments — using them without disclosure is a violation."},
          {"type": "subheading", "content": "Social media"},
          {"type": "paragraph", "content": "Social media posts by the firm or by individual advisors that meet the advertisement definition are subject to the Marketing Rule. Firms typically maintain social media policies that govern what advisors can post (often requiring pre-clearance for substantive content), how interactions are handled, and how the content is archived. Liking or sharing third-party content can sometimes constitute adoption of that content as the adviser's own marketing — a subtle trap. Apprentices should review the firm's social media policy carefully and ask compliance before posting anything client-facing."},
          {"type": "case_study", "title": "The website update that triggered compliance", "scenario": "An apprentice is asked to draft updated content for the firm's website 'About Us' page. The draft includes language about the firm's performance ('Our clients' portfolios have outperformed the broader market over the past five years') and a couple of client quotes praising the firm. The apprentice routes the draft to compliance before publishing. Compliance flags multiple issues: the performance claim needs specific support, presentation, and disclosures per the Marketing Rule; the client quotes are testimonials that require disclosure of whether the clients are compensated and any conflicts of interest. The draft is reworked: performance claim removed (the supporting documentation would have been extensive); testimonials retained with required disclosures clearly displayed. The page goes live two weeks later in compliant form.", "discussion": "The apprentice's instinct to route to compliance before publishing was correct. The original draft, posted without review, could have generated a violation. Build the habit: any client-facing communication beyond routine correspondence goes through compliance review."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Supervision, Personal Trading, and the Code of Ethics",
        "summary": "Supervision rules require firms to oversee the conduct of their personnel. Personal trading rules constrain employees with access to client information. Together they form the structural integrity of advisory practice.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An advisory firm is not just a collection of individuals — it is a regulated entity with responsibility for the conduct of everyone working under its umbrella. Supervision rules require firms to design and implement reasonable procedures for overseeing personnel; personal trading rules constrain certain employees from trading in ways that could conflict with clients; the firm's Code of Ethics codifies the standards expected of everyone. Together these form the structural integrity of the firm's operations."},
          {"type": "subheading", "content": "Supervision under SEC and FINRA rules"},
          {"type": "paragraph", "content": "SEC Rule 206(4)-7 requires RIAs to adopt and implement written compliance policies and procedures reasonably designed to prevent violations of the Advisers Act. FINRA Rule 3110 requires broker-dealers to establish supervisory systems including written procedures, designated supervisors, and reasonable supervision of associated persons. Both rules require an annual review of the compliance program's effectiveness. The Chief Compliance Officer (CCO) typically owns this work; everyone else operates within the framework the CCO maintains."},
          {"type": "subheading", "content": "Personal trading and Access Persons"},
          {"type": "paragraph", "content": "Access Persons are employees who have access to nonpublic information about client transactions or holdings. Apprentices are typically Access Persons from day one. Access Persons are subject to personal trading restrictions designed to prevent front-running, conflicts, and the appearance of impropriety. Common requirements: pre-clearance of certain personal trades; quarterly reporting of all personal securities transactions; annual reporting of all securities holdings; restrictions on trading in securities the firm is buying or selling for clients; restrictions on participation in IPOs and limited offerings."},
          {"type": "callout", "kind": "warn", "content": "Personal trading violations are one of the most common pathways to professional discipline for individuals in advisory roles. The cost of pre-clearing a personal trade is two minutes. The cost of an enforcement action is career-ending. Pre-clear when uncertain."},
          {"type": "subheading", "content": "The Code of Ethics"},
          {"type": "paragraph", "content": "Rule 204A-1 under the Advisers Act requires RIAs to adopt a written Code of Ethics. The Code must include: standards of business conduct reflecting the firm's fiduciary duty; provisions for compliance with applicable federal securities laws; reporting of personal securities transactions by Access Persons; reporting of violations of the Code; review and certification by each Access Person of receipt of the Code and its amendments. Most firm Codes go beyond the minimum to articulate the firm's values and expected conduct."},
          {"type": "subheading", "content": "Conflicts of interest disclosure and management"},
          {"type": "paragraph", "content": "Form ADV Part 2 requires disclosure of conflicts of interest. The Code of Ethics requires their management. Common conflicts: receiving compensation from product sponsors; receiving non-cash compensation (gifts, travel) from vendors or referral sources; outside business activities by employees; political contributions in 'pay to play' contexts; family relationships with clients or vendors. Each must be disclosed in Form ADV (in appropriately specific terms) and managed through the firm's policies. Annual training typically reinforces the conflicts framework."},
          {"type": "subheading", "content": "Whistleblower and reporting policies"},
          {"type": "paragraph", "content": "Firms must have channels for personnel to report suspected violations without retaliation. The SEC's whistleblower program provides financial incentives for outside reporting of securities law violations, but the firm's internal channels should be the first line. A culture where personnel feel able to raise concerns to compliance — or where appropriate, to an independent body — is part of healthy operations. The CCO's accessibility matters."},
          {"type": "subheading", "content": "Gifts, entertainment, and outside activities"},
          {"type": "list", "items": [
            "Most firms have gift limits — both for giving to clients/prospects and for receiving from vendors/referral sources (e.g., $100 per year per recipient/source, or modest entertainment)",
            "Outside business activities (board memberships, side businesses, teaching, writing for compensation) typically require pre-approval and may need disclosure on Form ADV",
            "Political contributions can trigger 'pay to play' issues for advisers working with state and local government plans; many firms have pre-clearance for any political activity",
            "Personal investment in private offerings, alternative funds, or other limited investments often requires pre-clearance"
          ]},
          {"type": "subheading", "content": "Training and certification"},
          {"type": "paragraph", "content": "Most firms require annual training on the Code of Ethics, anti-money laundering (AML), cybersecurity, suitability, and other topics. Annual certifications from each employee — that they have read the Code, understand it, and certify their compliance — are part of the routine. Apprentices complete the same trainings as senior staff; the apprenticeship is not a partial-membership status when it comes to compliance."},
          {"type": "case_study", "title": "The pre-clearance that prevented a problem", "scenario": "An apprentice receives an email from a friend who runs a small startup, asking the apprentice to invest $5,000 as a friends-and-family round in the startup's seed financing. The apprentice is excited about the opportunity. Before sending money, the apprentice consults the firm's personal trading policy: limited offerings (which the seed round is) require pre-clearance. The apprentice submits a pre-clearance request to compliance with details on the issuer, the offering structure, the relationship to the apprentice. Compliance reviews: no firm client has a relationship with the startup; no conflict identified; investment within the firm's Access Person personal investment limits; approval granted with the requirement to report annually. The apprentice invests with documentation in place.", "discussion": "Without pre-clearance, the apprentice could have unknowingly created a conflict (if the startup later became a client or a counterparty) or violated the policy (if limited offerings were restricted). The pre-clearance step took 30 minutes and converted a risky decision into a documented and authorized one. Build the habit early."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Examinations and Regulatory Inquiries",
        "summary": "Examinations by the SEC, state regulators, and FINRA are routine for advisory firms. Knowing what to expect and how to prepare is part of operational maturity.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Registered investment advisers and broker-dealers are subject to periodic regulatory examinations. The SEC examines RIAs through its Division of Examinations (EXAMS); FINRA examines broker-dealers; state regulators examine state-registered RIAs and have authority over broker activity in their states. Exam frequency varies — large RIAs may see SEC exams every few years, smaller ones less often. Each exam follows a structured process. Preparing well makes the process manageable; preparing poorly makes it expensive."},
          {"type": "subheading", "content": "The exam process"},
          {"type": "numbered", "items": [
            "Notification — the regulator notifies the firm (typically by letter or email) that an examination will occur, with a list of initial document requests",
            "Initial document production — the firm produces requested records, typically over a 2-4 week window",
            "On-site or remote phase — examiners review documents, interview personnel, ask follow-up questions over days or weeks",
            "Follow-up requests — additional documents and clarifications as the examiners' understanding develops",
            "Exit conference — examiners summarize their preliminary findings and any concerns",
            "Deficiency letter (if any) — formal letter listing identified deficiencies and requesting remediation",
            "Firm response — the firm responds to the deficiency letter with planned and completed remediation",
            "Closure — the exam closes with no findings, with deficiencies remediated, or in serious cases with referral to enforcement"
          ]},
          {"type": "subheading", "content": "What examiners typically look at"},
          {"type": "list", "items": [
            "Form ADV — is it accurate, complete, and consistent with actual practice?",
            "Fees — are fees calculated correctly, disclosed in Form ADV, and applied per the advisory agreement?",
            "Books and records — is everything required being kept, in proper form, and producible on request?",
            "Marketing materials — do communications comply with the Marketing Rule?",
            "Performance reporting — are performance calculations accurate and disclosed properly?",
            "Trading practices — best execution, allocation fairness, soft dollars, personal trading",
            "Compliance program — is there a written program, is it implemented, is it reviewed annually?",
            "Cybersecurity — are reasonable safeguards in place for client information?",
            "Conflicts of interest — are they disclosed in Form ADV and managed?",
            "Custody — does the firm have custody as defined, and if so does it meet the custody rule requirements?"
          ]},
          {"type": "subheading", "content": "Common findings — what to avoid"},
          {"type": "list", "items": [
            "Fee calculation errors (over-billing, incorrect pro-rations, undisclosed fee changes)",
            "Form ADV inconsistencies (description of fees doesn't match actual practice, conflicts not disclosed, AUM misstated)",
            "Books and records gaps (missing emails, missing meeting notes, incomplete trade documentation)",
            "Marketing rule violations (testimonials without disclosure, performance presentations without required elements, hypothetical performance issues)",
            "Inadequate compliance program (no annual review, no current procedures, untrained personnel)",
            "Custody rule violations (inadvertent custody without surprise audit)",
            "Personal trading policy violations or inadequate review"
          ]},
          {"type": "subheading", "content": "Preparing for examinations — ongoing readiness"},
          {"type": "paragraph", "content": "The best preparation for an examination is ongoing operational discipline. Firms that maintain clean records, follow their stated policies, document everything as it happens, and review their compliance program annually are ready for exams whenever they come. Firms that scramble when an exam notice arrives are signaling deeper issues. The discipline of operating as-if-being-examined is the right baseline."},
          {"type": "subheading", "content": "Apprentices in exams"},
          {"type": "paragraph", "content": "Examiners may interview apprentices and other staff to understand how the firm actually operates. The right approach: answer questions truthfully, do not speculate beyond what you know, do not embellish, do not minimize, do not hide anything that should be known. If you do not know an answer, say so. If you need to check a record, say so. Compliance and senior leadership typically prepare staff before interviews — listen to that preparation. Examiners are not adversaries; they are doing their job. Cooperate professionally."},
          {"type": "callout", "kind": "do", "content": "In any exam interview, the goal is accuracy, not advocacy. Answer what is asked, in scope, truthfully. Do not volunteer beyond the question. Do not speculate. Defer to compliance on anything you are not certain about."},
          {"type": "subheading", "content": "Responding to deficiencies"},
          {"type": "paragraph", "content": "When an exam produces deficiencies, the firm responds with a remediation plan: what was found, what the firm did or will do to fix it, by when, and what controls will prevent recurrence. Take deficiencies seriously even when they seem technical. Patterns of unaddressed deficiencies escalate. Most deficiencies are resolved at the exam-letter level; serious or unaddressed deficiencies can escalate to enforcement actions, with consequences ranging from censure to fines to license revocation."},
          {"type": "case_study", "title": "The exam that found three things", "scenario": "A small RIA is examined by the SEC for the first time. The exam takes six weeks. Three findings in the deficiency letter: (1) Form ADV described a fee schedule that did not exactly match the actual fee invoices for several clients; (2) the firm's compliance program had not been reviewed in writing in the past 18 months; (3) some emails from a departed former advisor had been retained outside the firm's archived system. The firm responds within 30 days: Form ADV corrected and reconciled against billing; compliance program annual review completed and dated; emails retrieved from former-advisor's local archive and added to the central archive. The firm also self-audits the prior 24 months for any similar gaps. The exam closes with the deficiencies remediated and no further action.", "discussion": "None of the findings were intentional misconduct. All were operational gaps — exactly what exams typically find. The firm's prompt, complete, transparent response converted a stressful event into a process improvement. Many firms experience this; not all respond as well. Cooperation and remediation matter."},
          {"type": "callout", "kind": "key", "content": "Compliance is the structural framework that lets the firm do the actual work of helping clients well. Treat it as integral to the practice, not as overhead."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Cybersecurity & Data Protection — the protection of client information that has become one of the most consequential operational disciplines in modern advisory practice."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "Registered investment advisers with $100M or more in AUM generally register with:", "options": ["State regulators only", "The SEC", "FINRA", "The Department of Labor"], "correct": 1, "explanation": "The $100M AUM threshold separates state-registered RIAs from SEC-registered RIAs. Some smaller RIAs operating in 15+ states may also register with the SEC."},
        {"id": "q2", "prompt": "FINRA is best described as:", "options": ["A government agency", "A self-regulatory organization for broker-dealers operating under SEC oversight", "An insurance company", "A trade association without regulatory authority"], "correct": 1, "explanation": "FINRA is an SRO — not a government agency but functioning as a regulator under SEC oversight. It administers exams, sets rules, conducts exams, and disciplines members."},
        {"id": "q3", "prompt": "Books-and-records retention periods under SEC Rule 204-2 for RIAs are generally:", "options": ["1 year", "2 years", "5 years from the end of the fiscal year in which the record was created, with the first 2 years easily accessible", "Indefinite"], "correct": 2, "explanation": "5-year retention is the standard for most records, with the first 2 years required to be easily accessible. Some records have longer requirements."},
        {"id": "q4", "prompt": "Using personal text messages, WhatsApp, or other non-archived channels for business communications is:", "options": ["Permissible if disclosed", "A serious compliance violation that has produced hundreds of millions in industry fines; only firm-approved archived channels should be used", "Required for client convenience", "Acceptable for client preferences"], "correct": 1, "explanation": "Off-channel communications violate books-and-records rules. The industry has been heavily penalized for this. All business communications must use archived channels."},
        {"id": "q5", "prompt": "The SEC Marketing Rule (Rule 206(4)-1, effective November 2022):", "options": ["Prohibits all marketing by RIAs", "Replaced the prior advertising rule and modernized rules around testimonials, endorsements, performance, and third-party ratings, subject to detailed conditions", "Applies only to print advertising", "Applies only to broker-dealers"], "correct": 1, "explanation": "The Marketing Rule modernized the framework, permitting testimonials and endorsements with required disclosures and detailed conditions for performance and hypothetical performance presentation."},
        {"id": "q6", "prompt": "Under the Marketing Rule, testimonials from clients in advertisements require disclosure of:", "options": ["Nothing — testimonials are unrestricted", "Whether the speaker is a client or non-client, whether compensation was paid, and material conflicts of interest", "Only the client's full name", "Only past performance"], "correct": 1, "explanation": "Testimonials are permitted but require specific disclosures: status (client vs non-client), compensation, and conflicts. Compensated testimonials also require written agreements and adviser oversight."},
        {"id": "q7", "prompt": "Access Persons under personal trading rules are:", "options": ["Only senior partners", "Employees who have access to nonpublic information about client transactions or holdings — apprentices typically qualify from day one", "Only persons holding Series 65", "Persons outside the firm"], "correct": 1, "explanation": "Access Persons is broadly defined and includes essentially anyone with access to client info. Apprentices typically are Access Persons immediately."},
        {"id": "q8", "prompt": "Pre-clearance of personal trades by Access Persons exists to:", "options": ["Slow down employees", "Prevent front-running, conflicts, and the appearance of impropriety; the 2-minute process prevents career-ending violations", "Generate fees for compliance", "Restrict employees from investing"], "correct": 1, "explanation": "Pre-clearance is structural prevention of personal trading violations. The friction is small versus the cost of a violation."},
        {"id": "q9", "prompt": "Rule 204A-1 requires RIAs to adopt:", "options": ["A custody plan", "A written Code of Ethics with specific required elements including standards of conduct and personal trading reporting", "A marketing budget", "An audit committee"], "correct": 1, "explanation": "The Code of Ethics is a required document under Rule 204A-1 with specific minimum content including conduct standards, personal trading reporting, and violation reporting."},
        {"id": "q10", "prompt": "During a regulatory examination interview, the right approach is to:", "options": ["Advocate for the firm and minimize any issues", "Answer truthfully, in scope, defer to compliance on anything uncertain, and not embellish or speculate", "Refuse to answer most questions", "Volunteer extensive information beyond the questions asked"], "correct": 1, "explanation": "Examiners want accuracy. Cooperate professionally, answer truthfully, do not speculate, and defer when uncertain. This is the right baseline for any interview."},
        {"id": "q11", "prompt": "Common exam findings include:", "options": ["Only intentional fraud", "Operational gaps — fee calculation errors, Form ADV inconsistencies, books and records gaps, marketing rule issues — that are not malicious but are deficiencies", "Only major investment losses", "Only insufficient profits"], "correct": 1, "explanation": "Most exam findings are operational rather than intentional misconduct. The discipline is in preventing the gaps through ongoing operational rigor."},
        {"id": "q12", "prompt": "The best preparation for a regulatory examination is:", "options": ["Last-minute document gathering when the notice arrives", "Ongoing operational discipline — maintaining clean records, following stated policies, documenting as you go, and reviewing the compliance program annually", "Hiring an outside law firm", "Reducing client communications"], "correct": 1, "explanation": "Firms that operate as-if-being-examined are ready whenever exams arrive. Last-minute preparation signals deeper issues."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 28;

-- ── module28_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 28 CONTENT
-- Cybersecurity & Data Protection
-- ============================================================================
update public.modules set
  title = 'Cybersecurity & Data Protection',
  competency_id = 'OJL-19',
  ri_hours = 0,
  ojl_hours = 60,
  short_description = 'Protect client data, money, and trust against the threats that target financial advisors specifically — wire fraud, account takeover, phishing, and the human-engineering attacks that exploit relationships.',
  learning_objectives = ARRAY[
    'Identify the most common attack vectors targeting financial advisors and their clients',
    'Apply authentication, encryption, and access control best practices to daily work',
    'Recognize and stop wire fraud and impersonation attempts before money moves',
    'Respond to a suspected breach following firm protocol and regulatory requirements',
    'Educate clients on the security practices that protect them outside the firm'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Why Financial Advisors Are a Target",
        "summary": "Financial advisor firms hold money, client trust, and the ability to move both. That combination makes them one of the most attractive targets in the economy.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "A criminal looking for the highest-value, lowest-friction target in the financial system rarely picks a retail bank — banks have spent billions on fraud detection. They pick the small-to-mid-sized RIA or independent broker-dealer where one apprentice with email access can be tricked into wiring $80,000 to a fraudulent account. Every advisor firm should assume they are being probed continuously. The question is not whether you will be attacked but whether your defenses will hold the attack you cannot see coming."},
          {"type": "callout", "kind": "key", "content": "The threat model for a financial advisor is not random hackers. It is patient, sophisticated attackers who study your firm, your clients, and your communication patterns — often for weeks — before making a single move."},
          {"type": "subheading", "content": "The attack surface"},
          {"type": "list", "items": [
            "Email — by far the most common attack vector; phishing, business email compromise (BEC), impersonation",
            "Voice — vishing calls impersonating clients, custodians, or firm executives",
            "Text/SMS — smishing, often combined with email to add legitimacy",
            "Client portals and login pages — credential stuffing, session hijacking",
            "Physical — laptops, paper documents, office access, dumpster diving",
            "Vendor and supply chain — your custodian's portal, your CRM, your file-sharing tool",
            "Insider threat — employees with access, contractors, departing staff"
          ]},
          {"type": "subheading", "content": "The specific attacks you will see"},
          {"type": "glossary", "terms": [
            {"term": "Business Email Compromise (BEC)", "definition": "Attacker gains access to or convincingly spoofs an email account inside the firm or at a client. Uses it to authorize a wire, change beneficiary, or request sensitive documents. Highest-dollar attack in finance."},
            {"term": "Spear phishing", "definition": "Targeted phishing using information specific to the target — name, role, recent activity. Distinguishable from mass phishing by personalization."},
            {"term": "Account takeover (ATO)", "definition": "Attacker gains login credentials and accesses a client's brokerage or banking account, often to wire funds or change settings."},
            {"term": "Wire fraud via impersonation", "definition": "Attacker impersonates a client (or staff) and instructs a wire to a fraudulent account. Often follows email compromise."},
            {"term": "Ransomware", "definition": "Malware that encrypts firm data and demands payment for the decryption key. Increasingly common in financial services."},
            {"term": "Pretexting", "definition": "Constructing a false story to get the target to share information or take action — 'I'm the new compliance officer at Schwab and I need to verify...' "},
            {"term": "Credential stuffing", "definition": "Using usernames/passwords leaked from breaches at other sites to try logins on financial sites — works because people reuse passwords."}
          ]},
          {"type": "case_study", "title": "The Friday afternoon wire", "scenario": "An apprentice receives an email at 3:30pm on a Friday from a long-standing client. 'I need to wire $87,000 to my contractor today for a home renovation deposit. Account info attached. Please process immediately so it goes out before the cutoff. I'm in meetings the rest of the day so just confirm by email when done.' The email is from the client's actual email address. The signature is correct. The language is plausible. The wiring instructions look professional. The apprentice processes the wire.", "discussion": "The wire went to an attacker. The client's email was compromised three weeks earlier. The attacker had been reading the email traffic, learning the communication style, and waiting for an opportunity. Friday afternoon was selected because it delays discovery — the client won't see the unsent reply or notice the missing funds until Monday. By then, the money is overseas. Loss: $87,000. The apprentice did everything email-asked them to do. They did not verify out-of-band. That is the failure."},
          {"type": "callout", "kind": "warn", "content": "Any wire instruction received only via email is suspect by default. The cost of a five-minute phone call to verify is nothing. The cost of not making the call can be career-ending."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Authentication, Encryption, and Access Controls",
        "summary": "The technical foundations that prevent most attacks — covered at a level every apprentice needs to actually use, not just nod along to.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most security incidents in financial advisor firms are not exotic. They are basic controls that were missing or applied inconsistently. Strong authentication, encrypted communications, and disciplined access controls block the vast majority of attempts. The fancy attacks make headlines; the basics prevent the headlines."},
          {"type": "subheading", "content": "Multi-factor authentication (MFA) — non-negotiable"},
          {"type": "paragraph", "content": "Every login that touches client data or firm systems should require at least two factors: something you know (password) plus something you have (authenticator app, hardware key, or push notification). SMS-based 2FA is better than nothing but is vulnerable to SIM-swap attacks and should be replaced with app-based or hardware-key factors wherever the option exists. The order of preference: hardware security key (YubiKey, Titan) > authenticator app (Authy, Google Authenticator, 1Password) > push notification > SMS."},
          {"type": "list", "items": [
            "Email account — MFA required, preferably hardware key",
            "Custodian portals — MFA required",
            "CRM — MFA required",
            "VPN — MFA required",
            "Cloud storage (Google Drive, Dropbox, OneDrive) — MFA required",
            "Personal accounts that touch work — also MFA, especially personal email that receives password resets"
          ]},
          {"type": "subheading", "content": "Password hygiene"},
          {"type": "paragraph", "content": "Long, unique, machine-generated passwords stored in a password manager. Never reuse a password across accounts — credential stuffing makes that catastrophic if any one site is breached. The password manager is the single most impactful security investment most people can make. Pick one (1Password, Bitwarden, Dashlane), use it for everything, lock it behind a strong master password and MFA."},
          {"type": "subheading", "content": "Encryption — at rest and in transit"},
          {"type": "list", "items": [
            "Laptop/device disk encryption — FileVault on Mac, BitLocker on Windows; on by default for new devices, verify it is on yours",
            "Email — TLS in transit is the minimum; for sensitive content, use encrypted portals or PGP-signed attachments",
            "File sharing with clients — never email attachments containing SSNs, account numbers, or signed forms; use the firm's secure document portal",
            "Mobile devices — passcode, biometric lock, remote wipe capability enabled",
            "Backups — encrypted, with the encryption key stored separately from the backup"
          ]},
          {"type": "subheading", "content": "Access controls — least privilege"},
          {"type": "paragraph", "content": "An apprentice should have access to exactly the systems and clients required for their work — not more. Custodian master accounts, payroll, vendor management systems, and other sensitive areas typically should not be in an apprentice's access list. When access is needed temporarily, it is granted temporarily and removed afterward. Departing staff have access revoked the same day. Inactive accounts are flagged and removed quarterly. Audit logs are reviewed periodically."},
          {"type": "callout", "kind": "do", "content": "Once a quarter, walk through your own access list and ask: do I still need this? If not, ask for it to be removed. The smaller your access footprint, the less damage an attacker who compromises your account can do."},
          {"type": "subheading", "content": "Phishing awareness as a continuous skill"},
          {"type": "paragraph", "content": "Phishing emails are designed to bypass your conscious attention — they create urgency, invoke authority, or appeal to helpfulness so you click before you think. Train yourself to pause on any email that creates urgency, asks you to click a link to verify credentials, comes from an unexpected sender about a sensitive topic, has a slightly-off email address (paypa1.com instead of paypal.com), or asks you to bypass normal processes. Hover over links before clicking. When in doubt, report it. False alarms are fine. Falling for a real phish is not."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Wire Fraud and the Verification Discipline",
        "summary": "Wire fraud is the single highest-loss event most advisor firms face. The defense is verification — slow, sometimes annoying, always non-negotiable.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The FBI's Internet Crime Complaint Center (IC3) reports billions of dollars annually in business email compromise and wire fraud losses, with financial services consistently among the top-targeted sectors. A successful wire fraud at a small advisory firm can be an extinction event — both for the client and potentially for the firm's reputation. There is one defense that works: out-of-band verification of every wire instruction, every time."},
          {"type": "subheading", "content": "The verification protocol"},
          {"type": "numbered", "items": [
            "Any wire request received via email or text must be verbally verified by calling the client at a known phone number — not a number provided in the email",
            "Known phone number means the number in your CRM that was established before this request — not a new number, not a number in the email signature, not what the client mentions in a follow-up message",
            "Confirm the dollar amount, the receiving institution, the routing and account numbers, and the purpose of the wire — all verbally",
            "If you cannot reach the client, do not process the wire — full stop. The wire can wait. Money lost cannot be recovered",
            "Document the verification call — date, time, who was called, what was confirmed",
            "For wires above certain thresholds (typically $50,000 or as firm policy specifies), require a second team member to also verify"
          ]},
          {"type": "callout", "kind": "key", "content": "If you only learn one thing from this module: never wire money based only on a written request. Voice verification, every time, no exceptions, even when the client gets impatient."},
          {"type": "subheading", "content": "Common social engineering patterns to recognize"},
          {"type": "list", "items": [
            "Urgency — 'I need this done today, by end of day, in the next hour'",
            "Confidentiality — 'Do not mention this to my spouse/business partner/anyone'",
            "Bypass — 'I know we usually verify by phone, but I'm in meetings; just process it'",
            "Authority — 'The senior advisor already approved this on the phone, just push it through'",
            "Plausibility — small details (recent vacation, family member's name, recent purchase) intended to confirm legitimacy",
            "Friday afternoon timing — delays discovery over the weekend",
            "Slight email address variations — clientname@gmail.com vs clientname@gmai1.com"
          ]},
          {"type": "subheading", "content": "What to do when you suspect fraud"},
          {"type": "numbered", "items": [
            "Stop the transaction immediately — do not process, do not engage with the suspicious party further",
            "Notify your supervisor or compliance officer immediately, by voice, not email (the email may also be compromised)",
            "If a wire has already been initiated, contact the sending bank within minutes to request a recall — recall windows can be as short as a few hours",
            "Contact the client at a known phone number to confirm whether the request was legitimate",
            "Document everything — every email, every timestamp, every call",
            "Report to authorities: FBI IC3 (ic3.gov) for federal reporting; FINRA if applicable; state regulators per your firm's protocol",
            "If client information was potentially exposed, the firm's breach notification protocol begins"
          ]},
          {"type": "case_study", "title": "The wire that was stopped", "scenario": "A second apprentice at the same firm receives a similar Friday-afternoon wire request three months after the prior incident. This time the firm has revised protocol: no wire is processed without voice verification regardless of urgency. The apprentice calls the client at the number in the CRM. The client answers, surprised: 'I didn't send any wire request. I'm not doing any renovations.' The apprentice immediately escalates. Investigation reveals the client's email had been compromised the week before — the attacker had been monitoring. Loss prevented: $112,000.", "discussion": "Same attack pattern. Different outcome. The only variable that changed was protocol. Voice verification is the entire defense against the highest-loss attack the firm faces. Make it sacred. Annoying clients with a 90-second phone call is the trade-off. The client whose money was protected will thank you. The one whose money you wired without verifying will not."},
          {"type": "callout", "kind": "warn", "content": "Clients sometimes complain about verification calls. 'You should know it's me by now.' Smile, agree it's a hassle, complete the verification. The most important moment to verify is the moment when the client is most annoyed by it — that emotional pressure is sometimes engineered to bypass you."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Privacy, the GLBA, and Regulation S-P",
        "summary": "Federal privacy law has specific requirements for how advisor firms handle client information. Knowing the rules protects clients and keeps the firm in compliance.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "The Gramm-Leach-Bliley Act (GLBA) and the SEC's Regulation S-P together establish the federal framework for how financial institutions, including investment advisors and broker-dealers, must handle nonpublic personal information (NPI) about their clients. These are not advisory guidelines. They are enforceable requirements with civil penalties, examination findings, and reputational consequences for non-compliance."},
          {"type": "subheading", "content": "What is NPI?"},
          {"type": "paragraph", "content": "Nonpublic personal information includes any information about a client that is not publicly available and was obtained in connection with providing a financial service. Names, addresses, Social Security numbers, account numbers, balances, transaction history, financial conditions, and any inferences drawn from such information are all NPI. The default is privacy — assume any information about a client is NPI unless you can specifically establish it is public."},
          {"type": "subheading", "content": "Reg S-P key requirements"},
          {"type": "list", "items": [
            "Initial privacy notice to clients at the start of the relationship explaining the firm's information practices",
            "Annual privacy notice (with some exceptions under the FAST Act for firms whose policies have not changed and who do not share with non-affiliated third parties)",
            "Opt-out rights for certain disclosures to non-affiliated third parties",
            "Safeguards Rule — written policies and procedures reasonably designed to protect customer records and information",
            "Disposal Rule — proper destruction of consumer report information when no longer needed",
            "Breach notification — Reg S-P amendments effective 2025 require notice to affected individuals within 30 days of becoming aware of a breach involving sensitive customer information (with limited exceptions)"
          ]},
          {"type": "callout", "kind": "note", "content": "The 2024 SEC amendments to Reg S-P significantly strengthened breach notification requirements. Firms must now have incident response programs in place and notify affected individuals within 30 days when sensitive customer information has been or is reasonably likely to have been accessed or used without authorization."},
          {"type": "subheading", "content": "State privacy laws add another layer"},
          {"type": "paragraph", "content": "California (CCPA/CPRA), Virginia (VCDPA), Colorado (CPA), Connecticut, and others have enacted state privacy laws that may apply in addition to federal requirements. The New York Department of Financial Services Part 500 (the Cybersecurity Regulation) applies to firms covered by NYDFS. For firms serving clients in multiple states, the patchwork matters. Know which states apply to your client base."},
          {"type": "subheading", "content": "Daily practices that comply"},
          {"type": "list", "items": [
            "Never discuss client information in public spaces (coffee shops, airplanes, restaurants) where it can be overheard",
            "Lock your screen when stepping away from your desk",
            "Shred paper documents containing NPI rather than throwing them in regular trash",
            "Use the firm's secure document portal for any client paperwork transmission — not personal email, not personal cloud storage",
            "When sharing a screen with a colleague, ensure no other client's information is visible",
            "Be cautious with voicemails to clients — leave generic call-back requests, not specifics",
            "When clients are introduced to each other (referrals, events), get explicit consent before sharing any identifying information"
          ]},
          {"type": "subheading", "content": "Vendor and third-party considerations"},
          {"type": "paragraph", "content": "When your firm uses third-party vendors that may access NPI — CRM providers, planning software, document management, file storage — the firm is responsible for vendor security. This is typically managed through vendor due diligence questionnaires, written agreements with confidentiality and security requirements, and ongoing monitoring. For an apprentice, the practical implication is: do not introduce a new tool that touches client data without compliance/IT review, even if it would be convenient."},
          {"type": "case_study", "title": "The convenient cloud folder", "scenario": "An apprentice has been emailing scanned client documents to themselves and storing them in a personal Google Drive folder for easier access from home. Discovered during a compliance review. The firm's official document storage is encrypted with audit logs and access controls; the personal Google Drive is not. The apprentice's intent was efficiency, not malice. Compliance still has to: log the incident, assess scope of NPI potentially exposed, evaluate notification requirements, remediate the storage, and discipline the conduct. The apprentice receives written warning and remedial training.", "discussion": "The temptation to use familiar consumer tools (personal email, personal cloud, personal text) for work is constant. Resist it always. The firm's tools exist for compliance reasons. Going around them — even for convenience, even with good intentions — creates real legal exposure for the firm and the client."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Incident Response and Client Education",
        "summary": "When something goes wrong, the firm's response in the first 24 hours determines whether a problem becomes a crisis. And the best long-term defense is clients who themselves know what to watch for.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Cybersecurity incidents are not theoretical for advisor firms — they are routine. Most firms will experience some form of incident within any given year, ranging from a single phishing email someone almost clicked to a confirmed compromise. The difference between a routine incident and a catastrophe is the response. Plan it before you need it."},
          {"type": "subheading", "content": "The first 24 hours after a suspected incident"},
          {"type": "numbered", "items": [
            "Contain — immediately isolate affected systems or accounts (disable the compromised email, force password resets, revoke sessions)",
            "Document — preserve evidence; do not delete the phishing email or the suspicious activity logs",
            "Escalate — notify the firm's incident response lead (CISO, compliance officer, or designated principal) immediately",
            "Assess scope — what data, what clients, what time window, what systems",
            "Notify outside counsel and the cyber insurance carrier per firm protocol — engaging counsel early may help preserve attorney-client privilege over the investigation",
            "Engage forensics — outside firms specialized in incident response are usually needed; do not try to investigate complex incidents alone",
            "Plan notifications — clients, custodians, regulators per applicable timelines"
          ]},
          {"type": "callout", "kind": "warn", "content": "The first hour matters most. A compromised email account being used to send fraudulent wire instructions to clients can do enormous damage in 60 minutes. Containment beats investigation in the immediate term."},
          {"type": "subheading", "content": "Regulatory notification obligations"},
          {"type": "list", "items": [
            "SEC Reg S-P (as amended) — 30-day notification to affected individuals for breaches of sensitive customer information",
            "State breach notification laws — vary by state; some require notification within shorter windows (e.g., 30, 45, or 60 days)",
            "FINRA Rule 4530 — broker-dealers must report certain events including significant security breaches",
            "NYDFS Part 500 — applicable firms must notify NYDFS within 72 hours of a cybersecurity event",
            "GDPR — if any EU resident data was affected, 72-hour notification to the supervisory authority",
            "FBI IC3 — voluntary but encouraged reporting; helps track patterns and may aid recovery"
          ]},
          {"type": "subheading", "content": "Client notification done right"},
          {"type": "paragraph", "content": "When client notification is required, the notice should be clear, specific, and actionable. Tell the client what happened, what data was affected, what the firm has done in response, what the client should do (monitor accounts, change passwords, place fraud alerts), and where to call with questions. Do not minimize. Do not over-promise. Have legal review every notification before sending."},
          {"type": "subheading", "content": "Educating clients on their own security"},
          {"type": "paragraph", "content": "The firm's security is only as strong as the security of the channels you use to communicate with clients. A client whose personal email is compromised is a wire fraud waiting to happen, no matter how secure your systems are. Routine client education topics — covered in onboarding and at least annually:"},
          {"type": "list", "items": [
            "Enable MFA on personal email, custodian portals, and any account that touches money",
            "Use a password manager; never reuse passwords",
            "Watch for phishing — especially emails appearing to come from custodians or the firm; verify by calling, never by clicking",
            "Be skeptical of urgent requests, especially around wires or account changes",
            "Update operating system and applications regularly; do not run software past its end-of-life",
            "Do not access financial accounts on public Wi-Fi without a VPN",
            "Freeze credit at the three bureaus if not actively borrowing — it costs nothing and prevents new-account fraud",
            "Designate trusted contacts at custodians and with the advisor — a person the firm can call if something looks unusual"
          ]},
          {"type": "subheading", "content": "Closing thoughts on security"},
          {"type": "paragraph", "content": "Security is not a project. It is a practice. Every email read with awareness, every wire verified, every password rotated, every quarterly access review — these are the small reps that build the muscle. The firm that has been doing this for years before a major attack hits is in a different position than the firm that started after the attack. Be the first kind."},
          {"type": "case_study", "title": "Devon's account takeover attempt", "scenario": "Devon receives a text message: 'Schwab fraud alert: confirm recent login from Lagos, Nigeria? Reply Y to confirm or call 1-800-555-2341.' Devon does neither — he calls his apprentice directly at the firm's main number. The apprentice contacts Schwab's actual fraud line on Devon's behalf; no such alert was issued by Schwab. The text was a smishing attempt designed to get Devon to call a fraudulent number where attackers would walk him through 'verifying his account' — actually capturing his credentials and a 2FA code in real time. The apprentice walks Devon through reporting the text, confirms his actual account shows no anomalies, and uses the event to refresh Devon's broader security practices.", "discussion": "Devon's training paid off. Two years earlier, the same client might have called the number in the text. Instead he called the firm — a known number, a known person. The relationship was the defense. That is what client education buys you: a phone call to you instead of a phone call to the attacker."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: with operations and security in place, the final stretch — how to actually build a sustainable practice as a counselor. Module 29: Practice Management & Business Development."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "An apprentice receives an email from a long-standing client requesting an urgent wire on a Friday afternoon. The right next action is:", "options": ["Process the wire to meet the cutoff", "Call the client at the phone number in the CRM to verify the wire instruction verbally", "Reply to the email asking for confirmation", "Have a colleague review the email and process if it looks legitimate"], "correct": 1, "explanation": "Voice verification at a known phone number is the entire defense against wire fraud. Email confirmations and second email reviews do not help — the email may already be compromised."},
        {"id": "q2", "prompt": "The strongest form of multi-factor authentication available is generally:", "options": ["SMS-based codes", "Push notification on a phone", "Hardware security key like a YubiKey", "A password with a special character"], "correct": 2, "explanation": "Hardware security keys are the strongest factor — resistant to phishing, SIM swap, and remote attack. Order of preference: hardware key > authenticator app > push notification > SMS."},
        {"id": "q3", "prompt": "Business Email Compromise (BEC) typically involves:", "options": ["Mass spam emails sent to millions of recipients", "An attacker accessing or convincingly spoofing a real email account to authorize fraudulent actions", "Malware infecting a computer", "Phishing for credit card numbers"], "correct": 1, "explanation": "BEC is targeted attack via real or spoofed business email accounts to authorize wires, beneficiary changes, or sensitive data requests. Highest-dollar attack vector in finance."},
        {"id": "q4", "prompt": "Under the 2024 amendments to SEC Regulation S-P, firms must notify affected individuals of a breach of sensitive customer information within:", "options": ["72 hours", "30 days", "60 days", "Six months"], "correct": 1, "explanation": "Reg S-P as amended requires 30-day notification (with limited exceptions) when sensitive customer information has been or is reasonably likely to have been accessed without authorization."},
        {"id": "q5", "prompt": "An apprentice has been storing scanned client documents in their personal Google Drive for convenience. This practice:", "options": ["Is acceptable since Google has good security", "Creates significant compliance exposure for the firm and should not be done — firm's secure systems must be used for client NPI", "Is acceptable if the documents are password-protected", "Is acceptable if the apprentice deletes them after each use"], "correct": 1, "explanation": "Personal cloud storage bypasses the firm's compliance controls regardless of vendor security. NPI must stay within firm-approved, audited systems."},
        {"id": "q6", "prompt": "When clients complain about voice verification calls before wires, the appropriate response is to:", "options": ["Stop requiring the calls for that client", "Process the wire without verification this once", "Acknowledge the inconvenience and complete the verification regardless — annoyance is sometimes engineered by attackers to bypass controls", "Have a colleague process the wire instead"], "correct": 2, "explanation": "Emotional pressure to bypass verification is itself a social engineering signal. The most important time to verify is when there is pressure not to."},
        {"id": "q7", "prompt": "Nonpublic Personal Information (NPI) under GLBA and Reg S-P includes:", "options": ["Only Social Security numbers", "Only account numbers and balances", "Any non-public information about a client obtained in connection with providing a financial service, including names, addresses, financial conditions, and inferences", "Only information the client has marked confidential"], "correct": 2, "explanation": "NPI is broadly defined — essentially any client information that is not publicly available and was obtained while providing financial services."},
        {"id": "q8", "prompt": "If a phishing email is received and identified before any harm is done, the right action is to:", "options": ["Delete it and move on", "Forward it widely to warn colleagues", "Report it to the firm's security/IT team and do not click any links or reply", "Reply asking the sender to stop"], "correct": 2, "explanation": "Report through proper channels so security can investigate, block similar messages, and track patterns. Do not engage with the sender or forward widely."},
        {"id": "q9", "prompt": "The first priority after detecting an active security incident is:", "options": ["Identify who is responsible", "Contain the incident — isolate affected systems, disable compromised accounts, prevent further damage", "Notify clients", "Write a press statement"], "correct": 1, "explanation": "Containment in the first hour limits damage. Investigation and notification come after containment."},
        {"id": "q10", "prompt": "An apprentice should perform an access review of their own systems and permissions:", "options": ["Only when joining the firm", "Quarterly — actively asking 'do I still need this access?' and reducing footprint", "Only when required by audit", "Never — IT handles this"], "correct": 1, "explanation": "Quarterly self-review of access reduces the blast radius if the account is ever compromised. Least privilege is an ongoing practice, not a one-time setup."},
        {"id": "q11", "prompt": "Devon receives a suspicious text claiming to be from Schwab with a phone number to call. The best action is to:", "options": ["Call the number in the text to clear it up", "Reply to confirm or deny", "Ignore the text and call the advisor or Schwab at known phone numbers", "Click any link to investigate"], "correct": 2, "explanation": "Never use phone numbers or links provided in unsolicited messages. Always use known, independently-sourced contact methods to verify."},
        {"id": "q12", "prompt": "A firm's security is best understood as:", "options": ["A one-time setup that lasts indefinitely", "An ongoing practice of small consistent actions — MFA, verification calls, access reviews, training, incident response readiness", "Primarily the responsibility of the IT vendor", "A regulatory checkbox to be minimized"], "correct": 1, "explanation": "Security is built by small disciplined practices repeated daily. The firm that did the reps before the attack is in a different position than the one that started after."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 29;

-- ── module30_ai_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 30 CONTENT
-- AI for Reporting, Automation, and Client Relationships
-- ============================================================================
update public.modules set
  title = 'AI for Reporting, Automation, and Client Relationships',
  competency_id = 'OJL-21',
  ri_hours = 8,
  ojl_hours = 40,
  short_description = 'AI is reshaping how financial advisors work. This module prepares Wealth Solutions Counselors to use AI tools for client reporting, workflow automation, and relationship management — while maintaining the accuracy standards and fiduciary responsibility every practitioner owes every client.',
  learning_objectives = ARRAY[
    'Explain how AI tools are currently being used in financial planning, reporting, and client communication.',
    'Use an AI assistant to draft client reports, meeting summaries, and financial education content.',
    'Identify the limitations and ethical considerations when using AI tools with client data.',
    'Demonstrate a repeatable workflow for using AI to automate routine administrative tasks.',
    'Apply AI tools to improve client relationship management, follow-up cadence, and personalized outreach.',
    'Evaluate AI-generated financial content for accuracy and compliance before sharing with clients.',
    'Describe the regulatory context for AI-generated content under SEC and FINRA supervision.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "AI in Financial Services — What's Actually Happening",
      "summary": "Cut through the hype. Here is what AI tools are actually doing in advisory practices today.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The financial services industry is in the middle of a genuine shift. AI tools are not replacing advisors — they are changing what advisors spend their time on. The practices growing fastest right now are the ones using AI to handle the administrative and documentation work so their people can focus on what only humans can do: build relationships, exercise judgment, and deliver advice clients trust." },
        { "type": "callout", "kind": "key", "title": "The right frame", "text": "AI amplifies your judgment. It does not replace it. Every output it produces is your responsibility before it reaches a client. Think of it as a fast, capable junior analyst who needs supervision." },
        { "type": "heading", "text": "What AI is actually being used for" },
        { "type": "paragraph", "text": "Across advisory firms of all sizes, the most common AI use cases right now are practical and unsexy: drafting meeting summaries, generating first drafts of client letters, summarizing long documents, writing marketing emails, transcribing calls, and automating follow-up sequences. The technology doing most of this work is called a large language model — a system trained on massive amounts of text that generates coherent, contextually relevant responses to prompts." },
        { "type": "list", "items": [
          "<strong>Writing assistants</strong> — draft emails, reports, summaries, and educational content from a prompt",
          "<strong>Transcription and summarization</strong> — convert recorded meetings into notes and action items",
          "<strong>CRM and workflow automation</strong> — trigger follow-ups, move pipeline stages, log activities",
          "<strong>Document analysis</strong> — extract key data from statements, tax returns, and intake forms",
          "<strong>Meeting prep</strong> — summarize client history, flag open items, suggest talking points",
          "<strong>Scheduling and admin</strong> — handle appointment booking, reminders, and intake workflows"
        ]},
        { "type": "heading", "text": "What AI cannot do" },
        { "type": "paragraph", "text": "AI tools do not know your client. They do not have fiduciary obligations. They cannot make suitability determinations, account for emotional context, or replace a conversation. An AI that writes a beautiful retirement income analysis is producing a draft — not a recommendation. The advisor reviews it, contextualizes it, takes responsibility for it, and delivers it." },
        { "type": "callout", "kind": "warn", "title": "AI hallucinations are real", "text": "Large language models will confidently state incorrect tax rates, outdated regulations, fabricated statistics, and nonexistent laws. This is called hallucination. In any field this is a problem. In financial services, it is a liability. Every factual claim in AI-generated content must be verified before it leaves your hands." },
        { "type": "heading", "text": "The regulatory context" },
        { "type": "paragraph", "text": "The SEC and FINRA have both issued guidance making clear that AI-generated content is still advisor-supervised content. If an AI writes a client communication, the firm is responsible for its accuracy, suitability, and compliance — exactly as if the advisor wrote it personally. The tools are new. The responsibilities are not." },
        { "type": "glossary", "terms": [
          { "term": "Large Language Model (LLM)", "definition": "An AI system trained on large amounts of text that generates human-like responses to prompts. ChatGPT, Claude, and Gemini are examples." },
          { "term": "Hallucination", "definition": "When an AI model generates confident, plausible-sounding content that is factually incorrect. Common with statistics, regulations, and citations." },
          { "term": "Prompt", "definition": "The instruction or question you give an AI tool. Better prompts produce more useful, accurate outputs." },
          { "term": "Automation", "definition": "Using software to perform tasks that would otherwise require manual human action — triggered by a rule, event, or schedule." }
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Drafting Reports and Client Communications with AI",
      "summary": "A practical workflow for using AI to produce first drafts — and the review process that makes them safe to send.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "The highest-value AI use case for most advisors is not exotic. It is this: instead of staring at a blank screen for twenty minutes, you spend five minutes prompting an AI and ten minutes editing the result. The quality goes up. The time goes down. The advisor is still fully in the loop — they just entered the process at the editing stage instead of the blank-page stage." },
        { "type": "heading", "text": "The meeting summary workflow" },
        { "type": "numbered", "items": [
          "Obtain client consent to record the meeting (required — document it in your CRM).",
          "Record the meeting or take structured notes.",
          "Feed the transcript or notes to an AI assistant with a clear prompt.",
          "Review the AI summary for accuracy, completeness, and anything sensitive.",
          "Edit, add your judgment, and send to the client as a follow-up.",
          "Log the final version in your CRM as the official meeting record."
        ]},
        { "type": "callout", "kind": "key", "title": "A prompt that works", "text": "\"Summarize the following client meeting notes into a professional follow-up email. Include: (1) key topics discussed, (2) decisions made, (3) action items with who is responsible, (4) next meeting date if mentioned. Tone: warm and professional. Do not include specific dollar amounts or account numbers. Length: under 300 words.\" — The more specific your prompt, the better the output." },
        { "type": "heading", "text": "Client-facing financial reports" },
        { "type": "paragraph", "text": "Quarterly reports, annual reviews, and financial plan summaries are time-intensive to produce. AI can generate a first draft of the narrative sections — the explanation of what happened, what changed, and what the plan calls for next — from structured data you provide. You review the numbers, verify every factual claim, and add the context only you have." },
        { "type": "callout", "kind": "warn", "title": "Never feed account data into public AI tools", "text": "Entering client names, account numbers, balances, or Social Security numbers into a public AI tool is a privacy violation and potentially a regulatory breach. Use anonymized data (Client A, $X balance) or tools with enterprise data agreements. More on this in Lesson 5." },
        { "type": "heading", "text": "Educational content and newsletters" },
        { "type": "paragraph", "text": "Client newsletters, market commentary, and financial education emails are legitimate AI use cases — with the same review requirement. An AI can generate a clear explanation of how rising interest rates affect bond prices, or a plain-English summary of a tax law change. Your job is to verify it is accurate, that it does not constitute personalized advice, and that it reflects your firm's voice." },
        { "type": "heading", "text": "Prompt engineering for financial content" },
        { "type": "paragraph", "text": "The single biggest factor in the quality of AI output is the quality of your prompt. Generic prompts produce generic results. Specific, structured prompts produce usable first drafts. The elements of a good prompt: specify the audience (\"a client who is 58, near retirement, moderately conservative\"), specify the purpose (\"explain Roth conversion strategy\"), specify the format (\"under 200 words, no jargon\"), and specify what to avoid (\"do not recommend specific products\")." },
        { "type": "heading", "text": "The review checklist before anything reaches a client" },
        { "type": "numbered", "items": [
          "Verify every number, percentage, and statistic against a primary source.",
          "Check that no specific investment, product, or strategy is being recommended to a specific person.",
          "Confirm there are no references to tax rules, contribution limits, or regulations without verifying they are current.",
          "Read the tone — is it appropriate for this client and this situation?",
          "Check that no client PII (names, account numbers, SSNs) was included in the output."
        ]},
        { "type": "activity", "title": "Write a Meeting Summary Prompt", "prompt": "Practice prompt engineering for a real use case. Write a prompt for an AI assistant to generate a post-meeting summary for a client who just completed their annual review.", "steps": [
          "Specify the audience: who is this client (age range, situation — no real names)?",
          "Specify what was covered: investment review, insurance gap, beneficiary update discussion.",
          "Specify the format: email, under 300 words, 3 action items listed.",
          "Specify what to exclude: specific account numbers, investment recommendations.",
          "Submit the prompt to an AI tool if available, then list 5 things you would check before sending the result."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Workflow Automation for the Modern Advisor",
      "summary": "Identify which tasks can be automated, and build the workflows that free you to do what humans do best.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Research consistently finds that financial advisors spend 30–40% of their time on administrative tasks: scheduling, data entry, follow-up emails, document routing, and status tracking. These tasks are necessary. Most of them do not require a licensed professional to do them. Automation is the discipline of redirecting that time." },
        { "type": "heading", "text": "The automation inventory" },
        { "type": "paragraph", "text": "Before you automate anything, audit what you actually do. For one week, track your tasks in two columns: <strong>Human judgment required</strong> (advice, discovery conversations, complex decisions) and <strong>Rule-based or repetitive</strong> (sending a reminder, moving a file, logging an activity). The second column is your automation target list." },
        { "type": "callout", "kind": "do", "title": "High-value automation candidates", "text": "Appointment confirmation and reminders · New client intake form → CRM entry · Birthday and anniversary messages · Post-meeting follow-up email sequence · Document checklist reminders · Annual review scheduling trigger · Compliance document expiration alerts" },
        { "type": "heading", "text": "CRM automation" },
        { "type": "paragraph", "text": "Modern CRM platforms (Salesforce, Redtail, Wealthbox, HubSpot) have built-in automation engines. You define a trigger — a client turns 70½, a prospect submits an intake form, a meeting is logged — and the system takes an action: sending an email, creating a task, updating a field, notifying a team member. These workflows run without human intervention once built." },
        { "type": "heading", "text": "Document processing" },
        { "type": "paragraph", "text": "AI-powered document processing tools can extract key data from client statements, tax returns, and intake forms — pulling balances, account types, contribution amounts, and filing status into structured fields without manual data entry. This eliminates a significant source of error and frees up substantial time during onboarding and annual review preparation." },
        { "type": "heading", "text": "Building a simple intake automation" },
        { "type": "numbered", "items": [
          "Client submits intake form (digital).",
          "Form submission triggers CRM record creation with all form data populated.",
          "Automated welcome email sends within 5 minutes with next steps.",
          "Calendar invite for discovery call populates based on advisor availability.",
          "Task is created for advisor to review intake before the call.",
          "Document checklist email sends 24 hours before the discovery call."
        ]},
        { "type": "paragraph", "text": "Every step above can run without any manual action after initial setup. The advisor's time enters the process when judgment is required — during the discovery call itself." },
        { "type": "activity", "title": "Map Your Automation Opportunities", "prompt": "Audit one week of your own tasks (or a hypothetical advisor week) to find automation candidates.", "steps": [
          "List 10 tasks an advisor performs in a typical week.",
          "For each, write whether it requires licensed judgment or is rule-based.",
          "Circle the rule-based tasks.",
          "For two of them, sketch the trigger → action logic: what starts the automation, and what does it do?",
          "Identify which tool in a typical advisory tech stack could run each automation."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "AI and Client Relationship Management",
      "summary": "How to use AI to be more present, more prepared, and more consistent — without losing the human element clients came for.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The best client relationships in advisory practices are built on consistency: consistent follow-through, consistent communication, consistent attention to what matters to each client. AI makes consistency easier at scale. A practice with 200 clients can deliver the same attentiveness as one with 30 — if the advisor uses the right tools and keeps the human at the center." },
        { "type": "heading", "text": "Meeting preparation" },
        { "type": "paragraph", "text": "Before every client meeting, an advisor should know: what was discussed last time, what action items are open, what has changed in the client's life or portfolio, and what the agenda is today. AI can generate a pre-meeting brief from CRM notes, past meeting summaries, and account data — in two minutes instead of twenty. The advisor reviews it, adds context, and walks into the meeting fully prepared." },
        { "type": "callout", "kind": "key", "title": "The preparation dividend", "text": "Clients notice when their advisor remembers details. 'How is your daughter's college search going?' is a human moment — but it only happens if you remembered. AI-generated pre-meeting briefs surface those details from your notes so you can show up as the advisor clients want." },
        { "type": "heading", "text": "Personalized outreach at scale" },
        { "type": "paragraph", "text": "Quarterly newsletters, market commentary, and educational content can be personalized by client segment. An AI can generate a version of your market update written for near-retirees, and a different version for young accumulators, from the same source material. The advisor reviews both. The client receives something that feels relevant to them." },
        { "type": "heading", "text": "The authenticity line" },
        { "type": "paragraph", "text": "Clients come to an advisor because they want a human relationship with someone they trust. That relationship is the product. AI should make you more available and more consistent — not less genuine. The line is crossed when clients feel managed rather than known. Automated messages that feel form-letter generic, AI responses sent directly to clients without human review, or communication that does not match the tone of your actual relationship — these erode the trust you built." },
        { "type": "list", "items": [
          "<strong>Works well:</strong> AI drafts a birthday message that you personalize before sending",
          "<strong>Works well:</strong> AI prepares a meeting brief you use to have a better conversation",
          "<strong>Works well:</strong> AI generates educational content you review and send under your name",
          "<strong>Backfires:</strong> AI sends automated 'personal' messages without your review",
          "<strong>Backfires:</strong> AI responds directly to client questions without advisor oversight",
          "<strong>Backfires:</strong> Generic mass emails dressed up as personalized outreach"
        ]},
        { "type": "callout", "kind": "do", "title": "The rule of thumb", "text": "If a client would feel deceived knowing AI drafted it first — rethink the workflow. If they would feel served by knowing you had better preparation tools — that is the goal." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Ethics, Accuracy, and the Guardrails Every Practitioner Needs",
      "summary": "Your fiduciary duty applies to every communication you send — regardless of who or what drafted it first.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The efficiency gains from AI are real. So are the risks. This lesson is about building the habits that let you capture the benefits without creating liability, violating client privacy, or producing content you cannot stand behind." },
        { "type": "heading", "text": "AI hallucinations in financial content" },
        { "type": "paragraph", "text": "Large language models generate text by predicting what words should follow other words, based on patterns in their training data. They do not look things up. They do not have access to current regulations unless specifically designed to. When asked about the 2024 Roth IRA contribution limit, a model might confidently state a number from 2021. When asked to cite a law, it might generate a plausible-sounding but nonexistent citation. In financial services, these errors are not just embarrassing — they are potentially harmful to clients and legally significant for advisors." },
        { "type": "callout", "kind": "warn", "title": "Verify every factual claim", "text": "Tax rates, contribution limits, RMD ages, SECURE Act provisions, SEC rules, state regulations — verify every single one against primary sources before they leave your hands. The IRS website, FINRA BrokerCheck, SEC.gov, and your compliance department are your ground truth. AI is your drafting assistant, not your compliance resource." },
        { "type": "heading", "text": "What not to put into AI tools" },
        { "type": "paragraph", "text": "Public AI tools — including the major consumer products — process your inputs on external servers. Entering client personally identifiable information (PII) into these tools is a privacy risk, a potential FINRA violation, and in some states a legal breach. PII includes more than Social Security numbers. It includes names, email addresses, phone numbers, account numbers, dates of birth, and combinations of information that could identify a specific individual." },
        { "type": "list", "items": [
          "<strong>Never enter:</strong> Client full names with financial data",
          "<strong>Never enter:</strong> Account numbers or balances tied to an individual",
          "<strong>Never enter:</strong> Social Security numbers, dates of birth, or addresses",
          "<strong>Never enter:</strong> Medical information",
          "<strong>Safe to enter:</strong> Anonymized scenarios (\"a 58-year-old client with $800K in a 401(k)\")",
          "<strong>Safe to enter:</strong> General planning concepts and educational content",
          "<strong>Safe with enterprise tools:</strong> Firm-specific content when your tool has a BAA or equivalent data agreement"
        ]},
        { "type": "heading", "text": "Regulatory context" },
        { "type": "paragraph", "text": "The SEC's 2023 guidance on AI in investment advisory makes clear that firms remain responsible for all communications regardless of how they were generated. FINRA has reiterated that AI-generated content is subject to the same supervision, review, and recordkeeping requirements as human-generated content. Your compliance department is the right resource for your firm's specific AI use policy." },
        { "type": "heading", "text": "Building your personal AI policy" },
        { "type": "paragraph", "text": "Before you rely on AI in your practice, decide explicitly what you will and will not use it for — and what your review process is. A simple written policy protects you, sets expectations with colleagues, and makes you think clearly about the guardrails before a problem occurs." },
        { "type": "activity", "title": "Write Your Personal AI Use Policy", "prompt": "Draft a one-page personal AI policy for your practice. Be specific and honest.", "steps": [
          "List 5 tasks you will use AI for (be specific — not just 'writing').",
          "List 3 tasks you will never use AI for, and explain why.",
          "Write your verification workflow: what do you check before AI-assisted content reaches a client?",
          "Write your data rule: what information will you never enter into an AI tool?",
          "Identify who at your firm or compliance provider you would consult if you had a question about a specific AI use case."
        ]},
        { "type": "glossary", "terms": [
          { "term": "Hallucination", "definition": "When an AI generates confident, plausible-sounding content that is factually incorrect. Particularly dangerous with statistics, regulations, and citations." },
          { "term": "PII (Personally Identifiable Information)", "definition": "Any data that can identify a specific individual — names, SSNs, account numbers, addresses, dates of birth, and combinations thereof." },
          { "term": "BAA (Business Associate Agreement)", "definition": "A contract that ensures a vendor (including AI tool providers) handles sensitive data in compliance with applicable privacy laws." },
          { "term": "RAG (Retrieval-Augmented Generation)", "definition": "An AI architecture that combines a language model with a specific document database — allowing the model to answer questions based on verified, up-to-date sources rather than training data alone." },
          { "term": "Prompt Engineering", "definition": "The practice of writing precise, structured prompts to produce more accurate, useful outputs from AI tools." }
        ]},
        { "type": "callout", "kind": "key", "title": "The bottom line", "text": "Your fiduciary duty is unchanged. You owe your clients the same duty of care whether you wrote something in five minutes or whether an AI drafted it in five seconds and you reviewed it in five minutes. The tools change the workflow. They do not change the responsibility." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "text": "An AI writing assistant generates a client newsletter with a statement that the Roth IRA contribution limit for 2024 is $6,000. What is the advisor's correct next step?",
        "options": [
          "Verify the current limit against the IRS website before sending the newsletter",
          "Send the newsletter — AI tools are trained on current data",
          "Add a disclaimer that figures are approximate",
          "Ask the AI to confirm the number a second time"
        ],
        "correct": 0,
        "explanation": "AI tools do not have access to current data and frequently hallucinate specific figures. Every factual claim — especially tax limits and regulatory numbers — must be verified against a primary source before reaching clients."
      },
      {
        "id": "q2",
        "text": "Which of the following should NEVER be entered into a public AI tool?",
        "options": [
          "A client's name, account balance, and date of birth",
          "A hypothetical scenario about a 55-year-old client with $500K in savings",
          "A general explanation of how Roth conversions work",
          "A draft market commentary article for your newsletter"
        ],
        "correct": 0,
        "explanation": "Client PII — including names, account numbers, balances, dates of birth, and SSNs — must never be entered into public AI tools. Anonymized scenarios and general content are safe."
      },
      {
        "id": "q3",
        "text": "Under current SEC and FINRA guidance, who is responsible for AI-generated client communications?",
        "options": [
          "The advisor and firm, to the same standard as human-authored communications",
          "The AI tool provider, since they generated the content",
          "No one — AI content is in a regulatory gray area",
          "The compliance department, who must pre-approve all AI output"
        ],
        "correct": 0,
        "explanation": "Regulators have made clear that AI-generated content is subject to the same supervision, accuracy, and recordkeeping requirements as content written by the advisor directly."
      },
      {
        "id": "q4",
        "text": "What is the primary risk of AI 'hallucination' in financial content?",
        "options": [
          "The AI generates confident, plausible-sounding content that is factually incorrect",
          "The AI refuses to answer financial questions",
          "The AI produces content that is too technical for clients to understand",
          "The AI copies content from competitor firm websites"
        ],
        "correct": 0,
        "explanation": "Hallucination is when AI generates factually incorrect information with apparent confidence. In financial services this can mislead clients, create liability, and result in regulatory violations."
      },
      {
        "id": "q5",
        "text": "Which of the following is the BEST use of AI in client relationship management?",
        "options": [
          "Generating a pre-meeting brief from CRM notes that the advisor reviews before the meeting",
          "Having AI respond directly to client emails without advisor review",
          "Replacing discovery conversations with AI-administered questionnaires",
          "Using AI to make suitability determinations based on risk profile data"
        ],
        "correct": 0,
        "explanation": "AI excels at preparing advisors for human conversations — synthesizing history, flagging open items, and surfacing relevant details. The advisor reviews the brief and remains the relationship."
      },
      {
        "id": "q6",
        "text": "An advisor uses AI to draft a quarterly performance report, then sends it to clients without review. What is the primary problem with this approach?",
        "options": [
          "The advisor has not fulfilled their supervisory responsibility over client communications",
          "AI-generated reports are not permitted under any circumstances",
          "Clients might prefer human-written reports",
          "The AI may have used a different font than the firm standard"
        ],
        "correct": 0,
        "explanation": "Sending AI-generated client communications without review violates the advisor's supervisory obligation. The advisor must verify accuracy, compliance, and appropriateness before any communication reaches a client."
      },
      {
        "id": "q7",
        "text": "What does 'prompt engineering' mean in the context of AI tools?",
        "options": [
          "Writing precise, structured instructions to produce more accurate and useful AI outputs",
          "Programming AI models from scratch",
          "Identifying and fixing errors in AI-generated code",
          "Selecting which AI tool to use for a given task"
        ],
        "correct": 0,
        "explanation": "Prompt engineering is the practice of crafting clear, specific, well-structured prompts. Better prompts produce more accurate and useful outputs from AI tools."
      },
      {
        "id": "q8",
        "text": "Which workflow automation candidate is MOST appropriate for an advisory practice?",
        "options": [
          "Automatically sending appointment confirmation emails when a meeting is booked",
          "Automatically rebalancing client portfolios when allocations drift",
          "Automatically approving client withdrawals under a certain threshold",
          "Automatically updating a client's risk profile annually"
        ],
        "correct": 0,
        "explanation": "Administrative automations — scheduling, reminders, confirmations — are ideal candidates because they are rule-based and require no professional judgment. Portfolio and risk decisions require licensed oversight."
      },
      {
        "id": "q9",
        "text": "A client asks why their advisor's newsletter seems to know exactly what they care about. The advisor used AI to generate segment-specific versions. Is this appropriate?",
        "options": [
          "Yes, if the advisor reviewed the content for accuracy and compliance before sending",
          "No, because clients must be told when AI is used in any communication",
          "No, because personalized content can only be written by the advisor personally",
          "Yes, no review is needed if the content is educational rather than advisory"
        ],
        "correct": 0,
        "explanation": "Using AI to generate personalized educational content is appropriate when the advisor reviews it for accuracy and compliance. There is currently no general requirement to disclose AI involvement in informational newsletters."
      },
      {
        "id": "q10",
        "text": "What is the correct description of RAG (Retrieval-Augmented Generation)?",
        "options": [
          "An AI architecture that combines a language model with a specific document database for more accurate, sourced responses",
          "A method for detecting AI hallucinations in financial documents",
          "A regulatory framework governing AI use in registered investment advisory",
          "A technique for anonymizing client data before entering it into AI tools"
        ],
        "correct": 0,
        "explanation": "RAG connects an AI model to a curated, verified document source — allowing it to answer questions based on current, specific information rather than general training data. Useful for compliance and regulation-based queries."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 30;

-- ── module29_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 29 CONTENT
-- Practice Management & Business Development
-- ============================================================================
update public.modules set
  title = 'Practice Management & Business Development',
  competency_id = 'OJL-20',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Build the business side of the counselor practice — service models, marketing, referrals, hiring, and the economics of running a sustainable advisory firm.',
  learning_objectives = ARRAY[
    'Design a service model that matches the firm''s capacity to the client base',
    'Understand the economics of an advisory practice — revenue, costs, and capacity',
    'Develop a marketing and business development approach that fits a fiduciary practice',
    'Build referral relationships with COIs (centers of influence)',
    'Plan for hiring, training, and succession in a growing practice'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Designing the Service Model",
        "summary": "The service model is the operating system of the practice — what clients get, how often, in what format. Get this right and growth is sustainable. Get it wrong and the practice eats itself.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most advisory practices that fail do not fail because the advisor was bad at advice. They fail because the service model — the implicit and explicit promise of what clients get — outgrew the capacity to deliver it. The counselor who promised quarterly meetings to 80 clients cannot actually deliver quarterly meetings to 80 clients. Quality drops. Trust erodes. Clients leave. Or the counselor burns out trying to keep promises that should never have been made. Designing the service model is foundational — and an apprentice should understand it long before they have clients of their own."},
          {"type": "subheading", "content": "The three levels of a service model"},
          {"type": "glossary", "terms": [
            {"term": "Service tiers", "definition": "Different levels of service for different client segments — typically based on complexity, assets, or fee structure. Common patterns: Foundational/Standard/Premier or A/B/C client groupings."},
            {"term": "Service calendar", "definition": "What happens with each client across the year — annual review timing, mid-year touch, year-end planning, ad hoc availability. The calendar formalizes the cadence promised."},
            {"term": "Service deliverables", "definition": "Specific outputs each client receives — annual plan refresh, quarterly performance report, tax planning memo, estate review, etc."}
          ]},
          {"type": "subheading", "content": "Capacity math — how many clients can one counselor actually serve?"},
          {"type": "paragraph", "content": "A working figure used in the industry: a full-time financial counselor delivering a comprehensive planning service with quarterly touches can sustainably serve approximately 60-100 client households, depending on complexity and team support. With dedicated support staff and operations, that number can grow to 120-150. Beyond that, either service quality degrades, the relationship becomes transactional, or the model has shifted to something other than comprehensive planning. The numbers vary by firm. The principle does not: capacity is finite. Pretending otherwise fails."},
          {"type": "subheading", "content": "Segmenting the client base"},
          {"type": "paragraph", "content": "Most firms segment clients into tiers — say A (top 20% by complexity or revenue, receiving most-intensive service), B (middle 60%, standard service), and C (the rest, often receiving more streamlined service or transitioned to digital/group offerings). Segmentation is not a value judgment about clients — it is a recognition that service intensity must match the firm's ability to deliver. A C-tier client receiving B-tier service is unsustainable. An A-tier client receiving C-tier service will leave."},
          {"type": "callout", "kind": "key", "content": "Service tiers are not about ranking clients. They are about matching the service you can sustainably deliver to the client situations that need that level of service."},
          {"type": "subheading", "content": "Designing the annual calendar per tier"},
          {"type": "list", "items": [
            "A-tier (top ~20%): semi-annual deep reviews, quarterly touch, ad hoc availability, dedicated team, customized year-end planning, estate and tax coordination",
            "B-tier (middle ~60%): annual deep review, mid-year touch, year-end checklist, response within 1-2 business days, standardized planning template",
            "C-tier (bottom ~20%): annual review, year-end checklist, response within 3-5 business days, simplified planning, often group/digital education"
          ]},
          {"type": "subheading", "content": "The promise the firm can keep"},
          {"type": "paragraph", "content": "Every client agreement should clearly describe what the client receives — frequency of reviews, scope of planning, response time expectations, what is and is not included. Vague promises ('we are here when you need us') create misaligned expectations. Specific promises ('quarterly reviews scheduled in advance, response within 24 hours during business days, comprehensive planning refresh annually') let both sides know what success looks like."},
          {"type": "case_study", "title": "The 200-client practice that broke", "scenario": "A counselor builds a successful practice over twelve years. By year twelve, they have 198 clients personally. They promised quarterly meetings at the start of every relationship and have kept that promise mostly through working 70-hour weeks. In year thirteen they miss their first cycle — a few clients do not get their fall meeting. By year fourteen, three A-tier clients have left, citing 'I do not feel like a priority.' By year fifteen, the counselor is on stress leave. The remaining clients are being managed by a junior staff member with no relationship and no authority. Most leave over the following year.", "discussion": "The counselor was excellent at advice and had real relationships with their clients. The failure was structural: capacity was exceeded, the service model never adjusted, and there was no team to absorb the overflow. By the time the cracks showed, the recovery options were limited. The lesson: capacity discipline early. Build the model that scales before you need it to."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "The Economics of an Advisory Practice",
        "summary": "Revenue, costs, margins, and what makes an advisory firm a business — not just a collection of relationships.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An advisor who does not understand the economics of their own firm cannot make good business decisions and cannot have honest conversations with clients about fees. An apprentice does not need to be a CFO, but should understand how the firm makes money, what it costs to deliver service, and where the leverage points are."},
          {"type": "subheading", "content": "Revenue models"},
          {"type": "glossary", "terms": [
            {"term": "AUM (assets under management) fee", "definition": "Percentage of client assets, typically 0.5%-1.25% annually, often tiered. Most common revenue model for RIAs. Aligns advisor with growing client assets."},
            {"term": "Flat fee / retainer", "definition": "Fixed annual or monthly fee per client regardless of assets. Cleaner alignment for planning-focused work; can be more accessible to younger or non-asset-heavy clients."},
            {"term": "Hourly / project fee", "definition": "Charged per engagement or per hour. Common for second-opinion or one-time planning work. Hard to scale to a full-time practice but useful for specific use cases."},
            {"term": "Subscription / monthly retainer", "definition": "Monthly fee for ongoing planning relationship. Increasingly common, especially for younger clients or planning-focused (non-AUM) firms."},
            {"term": "Commission", "definition": "Paid by product providers (insurance carriers, broker-dealers) when clients buy products. Creates conflicts of interest and is not used by fiduciary fee-only firms."}
          ]},
          {"type": "subheading", "content": "Typical cost structure of a small advisory firm"},
          {"type": "list", "items": [
            "Compensation (counselors, advisors, support staff) — usually 50-65% of revenue",
            "Technology (CRM, planning software, custodian fees, portfolio management) — 5-10%",
            "Occupancy (rent, utilities) — 5-10% for office-based firms; lower for distributed models",
            "Compliance and legal — 2-5%, growing as firms scale",
            "Marketing and business development — 2-5%",
            "Insurance (E&O, cyber, general business) — 1-3%",
            "Owner draw / profit — what remains, typically 15-30% in healthy firms"
          ]},
          {"type": "subheading", "content": "Revenue per client and capacity"},
          {"type": "paragraph", "content": "A firm with 100 client relationships at an average revenue of $5,000 per client generates $500,000. The same firm with 100 clients at $15,000 average revenue generates $1.5M. Same number of relationships, three times the revenue. This is why client selection and pricing matter as much as marketing. A firm cannot indefinitely grow by adding low-revenue clients — the operational overhead eventually exceeds the marginal revenue."},
          {"type": "subheading", "content": "Lifetime value of a client"},
          {"type": "paragraph", "content": "A planning relationship that lasts 20 years at $10,000 a year is a $200,000 revenue relationship. The cost of acquiring that client (referrals, marketing, onboarding time) — say $5,000-$15,000 — is well-justified. But if that client churns after three years instead of staying for twenty, the math collapses. Retention is the most important growth lever. Most advisory firms do not have a 'new client' problem. They have a 'losing existing clients' problem dressed up as a marketing problem."},
          {"type": "callout", "kind": "key", "content": "A firm that retains clients well grows almost without trying. A firm that loses clients quietly is on a treadmill no marketing budget can fix."},
          {"type": "subheading", "content": "Fee transparency and the fee conversation"},
          {"type": "paragraph", "content": "Every client should know exactly what they pay the firm and what they get for it. Hiding fees in fund expense ratios or platform fees creates trust problems that surface later. The fee conversation should happen openly at the start, be revisited annually, and any change should be discussed in advance. Clients who feel they understand the fee rarely complain about it. Clients who feel the fee is opaque eventually complain about everything."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Marketing a Fiduciary Practice",
        "summary": "Most financial marketing is loud, formulaic, and ineffective. The marketing that works for a fiduciary practice is quieter, longer-cycle, and grounded in what the firm actually does.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Fiduciary planning firms tend to be bad at marketing. The work is consultative, complex, and relationship-driven — none of which translates to a Facebook ad. The marketing that actually works is closer to thought leadership and community presence than to direct response. Done right, marketing for a fiduciary practice is an asset that compounds. Done wrong, it is wasted spend and brand damage."},
          {"type": "subheading", "content": "Where good clients actually come from"},
          {"type": "list", "items": [
            "Referrals from existing clients (typically 40-60% of new clients at healthy firms)",
            "Centers of influence (COIs) — CPAs, attorneys, business brokers, mortgage brokers (15-25%)",
            "Content marketing — articles, podcasts, talks that establish expertise (10-20%)",
            "Community presence — events, sponsorships, nonprofit boards (5-15%)",
            "Digital lead generation — typically lower for fiduciary firms (varies widely)"
          ]},
          {"type": "subheading", "content": "The referral question — how and when to ask"},
          {"type": "paragraph", "content": "Most advisors ask for referrals badly. The 'do you know anyone else who could benefit from our services' line at the end of a meeting is awkward, generic, and rarely effective. Better: identify specific moments when clients are most likely to refer (just after a successful outcome, after a major life event well-handled, at year-end when they are thinking about gratitude). And be specific about who you serve well. 'We do our best work with mid-career professionals dealing with stock-based compensation' is a referrable description. 'We help everyone with financial planning' is not."},
          {"type": "callout", "kind": "do", "content": "After major successful planning events — a business sale closing, a retirement well-launched, a complex estate plan settled — there is a natural window to ask: 'If you know someone navigating something similar, I would be glad to have an introductory conversation with them.' Specific, contextual, low-pressure."},
          {"type": "subheading", "content": "Working with centers of influence (COIs)"},
          {"type": "paragraph", "content": "CPAs and estate attorneys are the highest-quality referral sources for fiduciary planning firms because they share clients in adjacent professional capacities. The relationship is built over years — coordinating on shared clients, attending each other's events, occasional working lunches, mutual respect. It is not built by sending business cards or cold-emailing CPAs in the area. The work that brings COI referrals is the work of being genuinely good at your part of shared client situations, and being easy and pleasant to coordinate with. CPAs do not refer to advisors who make their lives harder. They refer to advisors who make their lives easier."},
          {"type": "subheading", "content": "Content as long-cycle marketing"},
          {"type": "paragraph", "content": "Writing articles, recording podcasts, or speaking at events does not generate immediate leads. It builds long-term credibility and discoverability. Over years, a body of work becomes a moat — when someone searches for 'tax planning for restricted stock units' and finds a thoughtful article you wrote three years ago, that is a future client who already trusts you. The horizon for content marketing is years, not months. Firms that commit to consistency for five-plus years see results. Firms that try it for three months and quit see nothing."},
          {"type": "subheading", "content": "Marketing rules under SEC and state regulators"},
          {"type": "paragraph", "content": "The SEC's Marketing Rule (effective 2022) governs how registered investment advisors can advertise, including the use of testimonials, endorsements, and performance figures. Key rules: testimonials and endorsements are allowed but with required disclosures (whether the person was paid, whether they are a client, conflicts of interest); past specific recommendations may only be presented with required context; hypothetical performance has stringent requirements; predecessor performance (e.g. from a previous firm) requires specific conditions. The implication for marketing: do not improvise. Have compliance review any advertising or marketing content before publishing."},
          {"type": "callout", "kind": "warn", "content": "Posting client compliments on social media without proper disclosures, sharing investment performance without context, or making forward-looking claims about returns can all trigger regulatory issues. The Marketing Rule is enforceable. Compliance review is not optional."},
          {"type": "subheading", "content": "Brand and trust"},
          {"type": "paragraph", "content": "Marketing for a fiduciary practice is mostly trust-building, and trust-building is mostly consistency. The firm that says the same things, treats clients the same way, shows up at the same community events year after year — that firm becomes known. The flashier firm that pivots messaging every quarter becomes background noise. Boring consistency beats interesting variety in this work."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Hiring, Training, and the Team",
        "summary": "Solo practices have a ceiling. Building a team multiplies what one person can do — and creates a different set of challenges to manage well.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most planning practices start as solo practices and at some point face the team question. The first hire is usually an administrative or operations support person. Later hires include junior advisors, paraplanners, compliance staff, and eventually partner-level counselors. Each hire changes the firm — economically, culturally, operationally. Doing it well is the difference between a firm that scales and a firm that just gets bigger and more dysfunctional."},
          {"type": "subheading", "content": "The first hire — typically operations or paraplanner"},
          {"type": "paragraph", "content": "The first hire at most planning firms is somebody who takes the operational and administrative load off the lead counselor — scheduling, document collection, custodian paperwork, basic plan prep. This hire frees the counselor to spend more time in client meetings and complex planning. The first hire often pays for itself by allowing the counselor to add three to five A-tier clients with their freed time."},
          {"type": "subheading", "content": "Hiring junior advisors and apprentices"},
          {"type": "paragraph", "content": "The next level — bringing in another advisor or apprentice — is more complex. Now there is another voice in client relationships. Training, supervision, quality control, and culture all become explicit work. The junior advisor needs both technical training (the work of the planning) and relational training (how this firm handles relationships, what its values mean in practice). The DOL Registered Apprenticeship model — which is what this entire curriculum supports — is one structured path for developing the next generation of counselors. Whether through formal apprenticeship or other structured development, the firm that invests in growing people grows talent that is loyal and aligned. The firm that hires senior people from competitors gets people with skills but often without alignment."},
          {"type": "callout", "kind": "key", "content": "The Wealth Solutions Counselor Apprenticeship that you are working through right now is itself a piece of practice management — a way for firms like GIC to grow talent intentionally rather than poach it expensively."},
          {"type": "subheading", "content": "Culture and values in practice"},
          {"type": "list", "items": [
            "Written values that show up in how clients are treated — not just on the wall",
            "Hiring for values fit, not just skills — skills can be taught more easily",
            "Onboarding that includes culture explicitly — what we do here, what we do not",
            "Performance reviews that measure values-aligned behavior, not only revenue or output",
            "Difficult conversations when behavior drifts from values — the cost of avoidance is higher than the cost of the conversation",
            "Letting people go when fit is wrong — protecting the team is protecting clients"
          ]},
          {"type": "subheading", "content": "Compensation that aligns"},
          {"type": "paragraph", "content": "How a firm pays its team shapes behavior more than any speech about values. Counselors compensated primarily on bringing in new assets behave differently than counselors compensated on client retention. Operations staff paid hourly with no upside in firm growth behave differently than those with profit-sharing or equity. Design compensation deliberately. Common patterns at fiduciary planning firms: base salary plus modest performance bonus tied to client retention and team metrics, with equity opportunities for long-tenured staff and partner-track advisors. Aggressive sales commissions tend to be uncommon at fee-only fiduciary firms because they create conflicts that work against the planning relationship."},
          {"type": "subheading", "content": "Succession and ownership"},
          {"type": "paragraph", "content": "Every firm has a succession question, whether or not it is being asked. What happens to clients if the lead advisor retires, becomes disabled, or dies? The DOL and SEC require business continuity plans for registered firms. Beyond compliance, the human question is: who carries the relationships forward? Firms that develop next-generation counselors internally — through apprenticeship, mentorship, and explicit ownership pathways — can transition smoothly. Firms that wait until the founder is ready to retire to think about succession often end up selling to an outside aggregator at a discount, with clients caught in the middle."},
          {"type": "case_study", "title": "GIC's apprenticeship strategy", "scenario": "Global Investment Company has chosen to invest in the DOL Registered Apprenticeship Program for the Wealth Solutions Counselor role rather than hire experienced advisors from competitors. The 36-month structured pathway costs the firm in training time and supervision but produces counselors who understand the firm's planning approach from the ground up, who are licensed and competent across the full scope of competencies, and who are aligned with the firm's values because they were shaped by them. After five years of running the apprenticeship, the firm has three apprenticeship graduates serving as counselors and is preparing to begin a fourth cohort.", "discussion": "Apprenticeship is a long-term bet. It does not pay off in year one. It pays off in year three through year thirty, in retention, in alignment, in succession capacity. Firms with a five-year horizon make this investment. Firms with a six-month horizon do not."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "The Long Game — Practice as Career, Career as Practice",
        "summary": "Practice management is not separate from the planning work. It is the structure that lets the planning work be done well for decades. Hold both together.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An apprentice starting this curriculum is at the beginning of what could be a thirty-five-year career. The practice you participate in — whether at GIC or elsewhere — is the container that lets that career develop. The choices about how the practice is run shape what is possible in the career. The choices about what to build in the career shape what the practice becomes. The two are inseparable."},
          {"type": "subheading", "content": "What a career in this work actually looks like"},
          {"type": "list", "items": [
            "Years 1-3: apprentice / new counselor — learning the technical work, building skills with clients under supervision, getting licensed",
            "Years 3-7: counselor — handling a growing book of relationships, deepening technical specialty, mentoring newer apprentices",
            "Years 7-15: senior counselor / advisor — leading complex client situations, contributing to firm strategy, often beginning partner track",
            "Years 15-30: partner / principal — significant equity, leadership role in firm direction, mentoring next generation, often public-facing thought leadership",
            "Years 30+: gradual transition — handing relationships to next generation, possibly emeritus or board role, succession of equity"
          ]},
          {"type": "subheading", "content": "Specialization as the practice matures"},
          {"type": "paragraph", "content": "Many counselors specialize as their career develops — in equity compensation, business sale planning, divorce planning, sudden wealth, multi-generational family wealth, healthcare professionals, tech executives, athletes and entertainers, or other niches. Specialization is not necessary but often beneficial: it concentrates expertise, builds referral patterns, and lets the practice command premium fees in areas of genuine depth. Apprentices should expect to start general and specialize over years as interests and opportunities crystallize."},
          {"type": "subheading", "content": "Credentials over time"},
          {"type": "paragraph", "content": "The CFP (Certified Financial Planner) is the most widely recognized planning credential and is often pursued during or shortly after the apprenticeship. CFA (Chartered Financial Analyst) is more investment-focused. CPWA (Certified Private Wealth Advisor) and CIMA (Certified Investment Management Analyst) are advanced credentials for high-net-worth practice. CFTA (Certified Financial Therapist) for behavioral specialty. Each requires time and study, and each pays back in client trust and professional positioning."},
          {"type": "subheading", "content": "Burnout, balance, and longevity"},
          {"type": "paragraph", "content": "Counseling work is meaningful and emotionally taxing. Clients bring you their fears, their regrets, their hopes — and the cumulative weight of holding that across years is real. Counselors who burn out do not help anyone. Investing in your own life outside the work — relationships, physical health, hobbies, intellectual interests, periodic genuine rest — is not separate from being good at the work. It is what makes a 35-year career possible."},
          {"type": "callout", "kind": "key", "content": "Be the counselor at year fifteen who is still curious, still energized, still genuinely interested in the next client conversation. That counselor is rare. That counselor is irreplaceable. That counselor is built by the choices made at year three."},
          {"type": "subheading", "content": "What this apprenticeship is really for"},
          {"type": "paragraph", "content": "The thirty modules you have worked through are not just technical training. They are the foundation of a craft. Financial planning done well is one of the most consequential professional services in someone's life — it touches their security, their family, their legacy, their freedom. The clients you will serve will trust you with information they share with no one else. The decisions you help them make will shape decades. Take the work seriously. Hold yourself to a high standard. Keep learning. Keep growing. Keep showing up. The career rewards the apprentices who do."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next: the Capstone. Module 30 brings together everything from the prior twenty-nine modules into a single integrated exercise. Building a practice — your practice — one decision at a time."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "A typical sustainable client capacity for a full-time financial counselor delivering comprehensive planning with quarterly touches and team support is roughly:", "options": ["20-30 households", "60-150 households depending on complexity and team support", "300-500 households", "Unlimited"], "correct": 1, "explanation": "The working figure is 60-100 clients solo, expanding to 120-150 with team support. Beyond that, service intensity must change or quality degrades."},
        {"id": "q2", "prompt": "Client segmentation into A/B/C tiers is best understood as:", "options": ["A way of ranking clients by importance", "A method to charge different prices to similar clients", "A way to match service intensity to client situations the firm can sustainably serve", "Required by regulation"], "correct": 2, "explanation": "Segmentation matches deliverable service to client needs. It is not a value judgment about clients but a capacity discipline."},
        {"id": "q3", "prompt": "The most important growth lever for most advisory firms is:", "options": ["New client acquisition through digital marketing", "Client retention — keeping existing clients happy and engaged over decades", "Adding new service tiers", "Hiring more advisors"], "correct": 1, "explanation": "Most firms with a 'growth problem' actually have a retention problem. A 20-year client relationship is worth far more than a new client added every six months for three years."},
        {"id": "q4", "prompt": "The SEC's Marketing Rule (effective 2022) generally requires that testimonials and endorsements in advertising:", "options": ["Be banned entirely", "Be allowed without restrictions", "Be allowed with required disclosures about compensation, client status, and conflicts of interest", "Be allowed only if approved by the client in writing"], "correct": 2, "explanation": "Testimonials and endorsements are permitted but with specific disclosure requirements. Improvising marketing without compliance review can trigger regulatory issues."},
        {"id": "q5", "prompt": "The highest-quality external referral sources for most fiduciary planning firms tend to be:", "options": ["Cold-call lead lists", "Centers of influence like CPAs and estate attorneys built over years of working with shared clients", "Pay-per-click advertising", "Telemarketing"], "correct": 1, "explanation": "COI relationships compound over years through shared-client coordination. CPAs and attorneys refer to advisors who make their work easier, not to advisors who simply ask for referrals."},
        {"id": "q6", "prompt": "The DOL Registered Apprenticeship program supporting this curriculum is best understood as:", "options": ["A regulatory burden", "An optional certification", "A long-term practice management investment in growing aligned, capable counselors from the ground up rather than poaching from competitors", "A marketing tool"], "correct": 2, "explanation": "Apprenticeship is a multi-year investment that pays back through retention, alignment, and succession capacity. Long-horizon firms make this bet."},
        {"id": "q7", "prompt": "Compensation that aligns a counselor with client retention rather than aggressive sales commissions is more common at:", "options": ["Wirehouses", "Independent broker-dealers focused on product sales", "Fee-only fiduciary planning firms", "Insurance-focused firms"], "correct": 2, "explanation": "Fiduciary planning firms typically use base salary plus performance bonuses tied to retention and team metrics, avoiding aggressive sales commissions that create conflicts with the planning relationship."},
        {"id": "q8", "prompt": "A typical compensation expense as a percentage of revenue at a healthy small advisory firm is approximately:", "options": ["10-20%", "30-40%", "50-65%", "80-90%"], "correct": 2, "explanation": "Compensation is usually the largest expense category at advisory firms, typically running 50-65% of revenue."},
        {"id": "q9", "prompt": "Specialization in a counselor's career (in equity comp, business sales, sudden wealth, etc.) tends to:", "options": ["Limit growth opportunities", "Concentrate expertise, build referral patterns, and allow premium fees in areas of genuine depth", "Be discouraged by regulators", "Be required by all firms"], "correct": 1, "explanation": "Specialization typically benefits both the counselor and clients — deeper expertise, clearer referral patterns, and premium positioning. Most counselors specialize as their career develops."},
        {"id": "q10", "prompt": "The CFP credential is most commonly pursued by counselors:", "options": ["Only after fifteen years of practice", "During or shortly after the apprenticeship period", "Only by those who specialize in investments", "Optional for all counselors and rarely held"], "correct": 1, "explanation": "The CFP is the foundational planning credential and is typically pursued during or shortly after the apprenticeship, well before mid-career."},
        {"id": "q11", "prompt": "A service promise like 'we are here when you need us' tends to be problematic because:", "options": ["It is too modest", "It creates misaligned expectations and cannot be measured against — specific, concrete promises serve everyone better", "It overcommits the firm", "It is illegal"], "correct": 1, "explanation": "Vague promises create misalignment. Specific commitments — 'quarterly reviews, 24-hour response, annual planning refresh' — let both sides know what success looks like."},
        {"id": "q12", "prompt": "Counselor burnout in this work is best prevented by:", "options": ["Working harder during peak years", "Avoiding emotionally difficult client situations", "Investing in life outside the work — relationships, health, hobbies, rest — recognizing this investment is what makes a 35-year career sustainable", "Limiting career to ten years"], "correct": 2, "explanation": "Counseling work is meaningful and emotionally taxing. The counselor who is still curious and present at year fifteen made choices about life-balance at year three."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 31;

-- ── module30_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 30 CONTENT
-- Capstone: Building a Practice
-- ============================================================================
update public.modules set
  title = 'Capstone: Building a Practice',
  competency_id = 'OJL-21',
  ri_hours = 0,
  ojl_hours = 120,
  short_description = 'Integrate everything from the prior twenty-nine modules into a single sustained client engagement — discovery to ongoing relationship — and reflect on the kind of counselor you intend to be.',
  learning_objectives = ARRAY[
    'Integrate technical, behavioral, and operational competencies into a coherent client engagement',
    'Lead a complete client lifecycle from first meeting through one full year of relationship',
    'Self-assess against the thirty competencies and identify your continuing development areas',
    'Articulate a personal philosophy of practice that will guide your work going forward',
    'Plan the next phase of your professional development beyond the apprenticeship'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "What You Have Learned — Mapping the Thirty Competencies",
        "summary": "Before integration, a moment to look back at the scope of the curriculum you have worked through and locate yourself within it.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "You have reached the final module of the Wealth Solutions Counselor Registered Apprenticeship. Behind you are twenty-nine modules covering the foundations of financial planning, the practice of client work, and the operations and business of a fiduciary advisory firm. The DOL framework calls these the thirty core competencies. The full RAPIDS 3007HY occupation profile codifies them. What that profile cannot show is what they look like when held together — integrated, in a real client situation, by a counselor making real decisions. That is what this capstone module is about."},
          {"type": "subheading", "content": "The three bands you have worked through"},
          {"type": "list", "items": [
            "CORE (Modules 1-9) — the technical foundation: financial literacy, time value of money, credit and debt, risk management, taxes, investments, retirement, estate planning, ethics and regulation. 144 hours of related instruction.",
            "OJL-A Client-Facing (Modules 10-18) — the practice of working with clients: discovery, goal-setting, document collection, financial statements, behavioral coaching, risk profiling, plan presentation, implementation, ongoing reviews. The relational core of the work.",
            "OJL-B Advanced/Operations (Modules 19-30) — the technical depth and operational discipline: portfolio construction, investment research, asset allocation, performance reporting, trading, tax-loss harvesting, account administration, reconciliation, compliance, cybersecurity, practice management, and this capstone."
          ]},
          {"type": "subheading", "content": "What the competencies are not"},
          {"type": "paragraph", "content": "The competencies are not a checklist that, once completed, makes you a finished counselor. They are a foundation. Real mastery happens through repetition — hundreds of client conversations, dozens of implementations, several major life events for clients you walked through them with. The apprenticeship gives you the shape of the work. The first ten years of practice give you the substance. Plan accordingly: graduating from the program is the beginning, not the end, of your professional development."},
          {"type": "callout", "kind": "key", "content": "An apprenticeship graduate who treats the credential as the destination is not yet what the credential represents. An apprenticeship graduate who treats the credential as the starting line of a thirty-year practice is."},
          {"type": "subheading", "content": "Self-assessment — where do you stand?"},
          {"type": "paragraph", "content": "Before the capstone exercise, take honest stock. For each of the thirty competencies, you fit one of three buckets: solid — you can apply this competency in real client work without supervision; functional — you can apply this competency with some supervision or specific reference; developing — you understand this competency but have not yet demonstrated it under real conditions. There is no shame in being 'developing' on multiple competencies. Most apprenticeship graduates are. Knowing where you are honest about it is what makes the next five years productive."},
          {"type": "activity", "title": "Self-assessment exercise", "prompt": "Build your personal competency map. For each of the thirty competencies, label yourself solid, functional, or developing. Identify the three you most want to deepen in your first year post-apprenticeship. Identify the one you most need help on from a senior mentor. This document is for you — not graded, not shared unless you choose. Update it annually for the next five years.", "steps": [
            "List all thirty competencies",
            "Label each (solid / functional / developing)",
            "Identify your top three priorities for the coming year",
            "Identify the one competency where you most need senior mentorship",
            "Sketch a development plan for each priority — what would advancement look like, what resources, what timeline",
            "Set a calendar reminder to review and update this document in one year"
          ]}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Capstone Exercise — The Full Client Lifecycle",
        "summary": "Take a single client through the full year of an engagement, from first inquiry through the first annual review. Apply every band of competencies in sequence. This is the integration the apprenticeship is designed to produce.",
        "read_time": "14 min read",
        "blocks": [
          {"type": "paragraph", "content": "The capstone exercise asks you to lead a full client engagement — either a real client under supervision, a comprehensive simulation with a designated case study, or a structured role-play with your mentor. Whichever format your firm uses, the exercise covers the full lifecycle, with deliverables and review points at each stage. The work integrates everything you have learned. The point is not to be perfect. The point is to demonstrate that the competencies live in your hands now, not just in your head."},
          {"type": "subheading", "content": "Stage 1 — Inquiry to first meeting"},
          {"type": "numbered", "items": [
            "Inbound inquiry intake — what information do you gather, how do you respond, what is the timeline to first meeting?",
            "Pre-meeting research — what do you learn about the prospect before they walk in?",
            "Conflict and capacity check — does this client fit the firm's service model? Are there any conflicts that need to be addressed?",
            "First meeting agenda — what are you trying to accomplish, what do they need to leave knowing?",
            "Deliverable: a brief pre-meeting memo capturing what you know and what you need to learn"
          ]},
          {"type": "subheading", "content": "Stage 2 — Discovery and engagement"},
          {"type": "numbered", "items": [
            "Discovery conversation — apply Module 10 fully; surface goals, life context, financial picture, and emotional landscape",
            "Goal-setting and prioritization — work with the client to articulate what matters in priority order (Module 11)",
            "Document collection — list every document you need; coordinate getting them gathered (Module 12)",
            "Engagement agreement and fee disclosure — clear written description of what they receive, what it costs, conflicts and standards of conduct",
            "Deliverable: signed engagement agreement, prioritized goals document, document collection tracker"
          ]},
          {"type": "subheading", "content": "Stage 3 — Analysis"},
          {"type": "numbered", "items": [
            "Build financial statements — net worth, cash flow, projections (Module 13)",
            "Apply the technical CORE competencies — tax position, risk coverage, retirement projection, estate review, debt analysis",
            "Risk profiling and suitability documentation (Module 15)",
            "Behavioral observations — what coaching is this client likely to need over time (Module 14)",
            "Recommendation development — what do you recommend, in what priority, with what tradeoffs",
            "Deliverable: full plan document with executive summary, findings, recommendations, and implementation plan"
          ]},
          {"type": "subheading", "content": "Stage 4 — Presentation and decision"},
          {"type": "numbered", "items": [
            "Plan presentation meeting — apply Module 16 fully; lead with goals, surface findings, present recommendations, handle questions",
            "Documentation of client decisions — what was agreed, what was declined, why",
            "Investment Policy Statement signing — pre-commitment for the relationship",
            "Action list with owners and dates",
            "Deliverable: signed IPS, completed action list, meeting recap email to client within 24 hours"
          ]},
          {"type": "subheading", "content": "Stage 5 — Implementation"},
          {"type": "numbered", "items": [
            "Sequence the implementation correctly (Module 17) — account opens before transfers, beneficiaries same day, tax-aware timing",
            "Coordinate with external professionals — CPA, attorney, insurance broker — with proper authorization",
            "Execute account opens, rollovers, contribution changes, beneficiary updates",
            "Build the portfolio — apply Modules 19-21 to construct, document the allocation rationale",
            "Verify every action on the source system; close the loop on each item",
            "Deliverable: completed implementation tracker with every item verified, client notification of completion"
          ]},
          {"type": "subheading", "content": "Stage 6 — Ongoing relationship and first annual review"},
          {"type": "numbered", "items": [
            "Establish review cadence and document in CRM (Module 18)",
            "Quarterly performance reporting — accurate, contextualized, plain language (Module 22)",
            "Trading and rebalancing as needed (Modules 21, 23)",
            "Tax-loss harvesting if applicable (Module 24)",
            "Mid-year touchpoint — confirm progress, surface any life changes",
            "Annual review meeting at the one-year mark — lead through the five-section structure, surface what changed, refresh action items",
            "Deliverable: written annual review summary, updated plan document, refreshed action list, scheduled next year's cadence"
          ]},
          {"type": "subheading", "content": "Review and reflection"},
          {"type": "paragraph", "content": "At the end of the full lifecycle, sit down with your supervising counselor or mentor for a structured review. What worked, what did not, what surprised you, what would you do differently, what competencies surfaced as strongest and which as needing more development. This conversation is the most valuable part of the exercise. The deliverables matter. The reflection matters more."},
          {"type": "callout", "kind": "do", "content": "Write the reflection in your own words and save it. Five years from now, reading what you wrote at the end of your apprenticeship will be a meaningful check on how you have grown and where you stayed the same."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Articulating a Personal Philosophy of Practice",
        "summary": "The technical competencies are universal. How you choose to practice them is yours. The counselor you become is shaped by the philosophy you build — explicitly or by default.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Two counselors with identical technical training and identical client bases can practice very differently — and over a 30-year career the difference compounds enormously. The counselor who developed an explicit philosophy of practice early — who decided what kind of counselor they wanted to be and made decisions accordingly — tends to look different at year fifteen than the counselor who let the practice shape them by default."},
          {"type": "subheading", "content": "Questions worth answering — out loud, in writing"},
          {"type": "list", "items": [
            "What kind of clients do I most want to serve, and why?",
            "What kind of work energizes me, and what kind drains me?",
            "What do I consider non-negotiable in client work — values I will not compromise on?",
            "What do I want to be known for in five years? In fifteen?",
            "How do I want clients to describe me to their friends?",
            "How will I know if I am drifting from the kind of counselor I want to be?",
            "What does 'success' mean to me in this career — beyond income and AUM?",
            "How will I sustain myself emotionally and intellectually for decades of this work?"
          ]},
          {"type": "paragraph", "content": "These questions do not have one right answer. They have your answer. The discipline is to answer them honestly, write the answers down, and revisit them periodically. Many counselors find their answers shift over the first five to ten years of practice and then stabilize. The shifts themselves are useful information — they show you what you are learning about yourself."},
          {"type": "subheading", "content": "The clients you want to serve"},
          {"type": "paragraph", "content": "Most counselors discover within a few years that they do their best work with certain kinds of clients and merely competent work with others. Some counselors thrive with mid-career professionals navigating complexity; others with retirees seeking simplification; others with business owners going through liquidity events; others with multi-generational family wealth. None of these is the right answer for everyone. Knowing which is the right answer for you shapes how you build your practice and what referral patterns you cultivate."},
          {"type": "subheading", "content": "The work you will not do"},
          {"type": "paragraph", "content": "Equally important — what kind of work, or what kind of clients, will you decline? A fiduciary practice can decline engagements that are wrong for the firm. A counselor who tries to be all things to all clients eventually serves no one well. Knowing your no is part of knowing your yes. Examples of legitimate no's: 'I don't do high-frequency trading advice.' 'I don't work with crypto-focused portfolios as a primary strategy.' 'I don't take on clients who require day-of access.' 'I don't accept gifts from clients beyond [firm threshold].' Define your no's early."},
          {"type": "subheading", "content": "How you measure yourself"},
          {"type": "paragraph", "content": "If the only metric is revenue or AUM, the practice optimizes for revenue or AUM. That has been a recipe for some of the industry's worst conduct historically. Healthier metrics — client retention, complaint rate, second-generation client retention (when client's adult children also become clients), peer respect, the number of clients who would describe you as 'the person we trust most with our finances' — produce different practices. Pick the metrics that match the philosophy. Track them. Let them shape decisions."},
          {"type": "case_study", "title": "Julius and the Life House framework", "scenario": "Before GIC built this apprenticeship, Julius Jackson built Life House Reentry — a workshop system helping formerly incarcerated people build financial lives. The Life House framework was explicit about philosophy: dignity first, accessibility before sophistication, education embedded in every transaction, no one shamed for what they did not know. When Julius brought Life House thinking into GIC's apprenticeship design, that philosophy traveled with him. The values that shape this curriculum — clear language, behavioral attention, fiduciary discipline, client-centered design — are an expression of a philosophy worked out long before any of these modules were written.", "discussion": "Notice what happened: a philosophy developed in one context shaped a curriculum developed in another. That is what philosophy does — it shapes the work consistently across the situations the work takes you to. Build yours deliberately. It will travel with you."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Continuing Education and Credentials Beyond the Apprenticeship",
        "summary": "Graduating from the apprenticeship sets the table for a career of continued learning. Here is what comes next.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Apprenticeship completion is recognized by the U.S. Department of Labor as a journey-level credential in the Wealth Solutions Counselor occupation. It demonstrates that you have completed structured related instruction, accumulated qualifying on-the-job learning hours, and demonstrated competence across the thirty competencies. It is real. It is portable. It positions you for the next phase. But the financial services industry has its own credentialing landscape that will continue to shape your career."},
          {"type": "subheading", "content": "Licensing — required for many practice paths"},
          {"type": "list", "items": [
            "Series 65 (Uniform Investment Adviser Law Examination) — required for most investment adviser representatives at RIAs; often the first license a new counselor obtains",
            "Series 7 (General Securities Representative) — required for broker-dealer registered representatives; broader than Series 65 but with different scope",
            "Series 66 (combined 63 + 65) — common alongside Series 7",
            "Series 63 (Uniform Securities Agent State Law) — state-level for broker-dealer reps in addition to Series 7",
            "State insurance licenses — required to sell or advise on insurance products in each state of practice",
            "Series 24, 26, 27, 28, 51, 53, 99 — various supervisory and operations licenses; relevant as career advances"
          ]},
          {"type": "subheading", "content": "Major credentials by stage of career"},
          {"type": "glossary", "terms": [
            {"term": "CFP (Certified Financial Planner)", "definition": "The most widely-held planning credential. Requires bachelor's degree, completion of CFP Board-approved coursework, 6,000 hours of professional experience (or 4,000 hours of apprenticeship experience), passing the CFP exam, and ongoing CE. Often the first major credential pursued."},
            {"term": "ChFC (Chartered Financial Consultant)", "definition": "Alternative to CFP from The American College. Similar curriculum, different sponsoring organization, no comprehensive exam."},
            {"term": "CFA (Chartered Financial Analyst)", "definition": "Investment-focused credential from CFA Institute. Three rigorous exams, four years of qualified work experience. Less common for planners; more common for investment analysts and portfolio managers."},
            {"term": "EA (Enrolled Agent)", "definition": "Tax specialist credential from the IRS. Strong complement for counselors doing significant tax planning work."},
            {"term": "CPWA (Certified Private Wealth Advisor)", "definition": "From the Investments and Wealth Institute. Advanced credential for HNW practice. Often pursued mid-career."},
            {"term": "CIMA (Certified Investment Management Analyst)", "definition": "Investment consulting credential from the Investments and Wealth Institute. Often pursued by counselors focused on portfolio construction."},
            {"term": "AAMS, CRPC, RICP", "definition": "Specialty credentials in accredited asset management, retirement planning, and retirement income — each fills a specific niche."}
          ]},
          {"type": "subheading", "content": "Continuing education requirements"},
          {"type": "paragraph", "content": "Every license and credential carries CE obligations — typically 24-40 hours over a renewal cycle of 1-2 years. Most firms cover or facilitate CE. Plan your CE strategically: use it to advance areas you want to deepen (a counselor specializing in equity comp might pursue advanced equity comp CE; a counselor specializing in retirement income might pursue RICP-related material). Done well, CE is a structured way to keep growing across decades. Done badly, it is a compliance checkbox."},
          {"type": "subheading", "content": "Beyond formal credentials — reading, writing, networking"},
          {"type": "paragraph", "content": "Some of the most important professional development happens outside formal CE. Reading widely — Kahneman, Bernstein, Bogle, Pfau, Kitces, Bernstein, current academic research, current industry publications. Writing — articles, even short notes; the discipline of writing clarifies thinking and builds visibility. Networking — peer relationships with other counselors at other firms, study groups, professional associations like NAPFA or the FPA. Mentoring junior apprentices — teaching the work is one of the best ways to deepen it. Attending one or two strong conferences a year. The cumulative effect over a career is significant."},
          {"type": "callout", "kind": "do", "content": "In your first year post-apprenticeship, commit to: completing the Series 65 if not already done, registering for the CFP curriculum, joining a professional association, and reading one practice-relevant book per quarter. By year three, sit for the CFP exam. By year seven, complete it. By year ten, consider advanced credentials or specialty designations. This is a long game played in small consistent moves."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing — The Counselor You Become",
        "summary": "A final reflection. You arrived at this apprenticeship as one kind of person. You finish it as another. What kind of counselor will you become next?",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "You started this curriculum on day one of the apprenticeship as someone learning the language of money. Through related instruction and hundreds of hours of supervised practice, you have built the foundations of a craft. You have learned how money moves through a household, how decisions get made under uncertainty, how to coach clients through fear and euphoria, how to design portfolios and communicate risk, how to run the operational discipline that protects client trust, and how to think about the business of a practice that lasts decades."},
          {"type": "paragraph", "content": "What you carry forward is not just technical knowledge. It is the orientation of a counselor — someone who sits across from another person at a difficult moment in their financial life and brings real competence, real care, and real fiduciary discipline to the conversation. That orientation is rare in the financial services industry. The industry is full of salespeople, of product pushers, of people willing to leave clients worse off in exchange for commissions. You have been trained for something different."},
          {"type": "subheading", "content": "What the work asks of you, going forward"},
          {"type": "list", "items": [
            "Show up prepared, every meeting, every time — the client trusted you with their time",
            "Tell the truth, including hard truth, with care but without flinching",
            "Document your work — your future self and your clients depend on it",
            "Coordinate with the other professionals in your client's life — you are not alone, do not act like it",
            "Keep learning — the curriculum ended; the learning has not",
            "Mentor the apprentices who come after you — the work continues through people, not through documents",
            "Protect the relationship — money will come and go, market cycles will rise and fall, but the relationship is what makes the practice possible",
            "Sustain yourself — physically, emotionally, intellectually — so that you can do this for thirty years"
          ]},
          {"type": "subheading", "content": "What GIC is hoping you become"},
          {"type": "paragraph", "content": "Global Investment Company built this apprenticeship as a long-horizon investment in counselors who can carry the firm's standards into the next generation of clients. The standards: integrity, intelligence, impact. The clients you will serve over your career include people who would never have access to fiduciary planning under the old industry model. The work you do will help people whose financial lives have historically been served badly or not at all. That is part of why this apprenticeship exists. That is part of why your career matters."},
          {"type": "callout", "kind": "key", "content": "Be a counselor your clients describe, fifteen years from now, as 'the person who actually changed how we live with money.' That is the standard. That is what the work is for."},
          {"type": "subheading", "content": "Acknowledging the predecessors"},
          {"type": "paragraph", "content": "The framework of this apprenticeship draws on the Life House Reentry workshop system that preceded GIC's involvement — a system originally built to help formerly incarcerated people rebuild financial lives with dignity. The dignity-first orientation, the commitment to clear language, the refusal to shame anyone for what they did not know — these came from Life House. They live in this curriculum. Carry them forward. Anywhere you practice. With every client you serve."},
          {"type": "subheading", "content": "The final exercise — your own commitment"},
          {"type": "activity", "title": "Write your one-page commitment", "prompt": "Before you mark this module complete, write a one-page document, addressed to yourself, capturing the following: the kind of counselor you intend to be, the principles you will hold yourself to, the clients you most want to serve, the work you will not do, the metrics by which you will measure yourself, and your development plan for the next five years. Date it. Sign it. Save it where you will see it again. Read it on the first day of every year for the rest of your career.", "steps": [
            "Open a fresh document — paper or digital, your choice",
            "Title it: 'My Practice — Commitments at Apprenticeship Completion'",
            "Write each of the six sections above in your own words, one paragraph each",
            "Date and sign",
            "Save somewhere durable — version-controlled, in a personal vault, or in a sealed envelope you open on Jan 1 each year",
            "Set a recurring calendar reminder for January 1 of each year to re-read and reflect"
          ]},
          {"type": "divider"},
          {"type": "paragraph", "content": "Welcome to the profession. The thirty modules end here. The career begins now. The clients who will sit across from you over the coming decades — some of whom have not yet been born, some of whom are at the lowest moments of their financial lives right now — are why this work exists. Be ready for them. Stay curious. Stay honest. Stay in the work."},
          {"type": "paragraph", "content": "Congratulations on completing the Wealth Solutions Counselor Apprenticeship."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "The thirty competencies of the apprenticeship are best understood as:", "options": ["A complete and final certification", "A foundation that becomes mastery through years of repeated practice — the credential is the start, not the destination", "A checklist that determines compensation", "A regulatory requirement disconnected from practice"], "correct": 1, "explanation": "Real mastery comes from repetition with real clients over years. The apprenticeship gives the shape; the next decade gives the substance."},
        {"id": "q2", "prompt": "The CFP credential typically requires:", "options": ["Only a passing exam", "Bachelor's degree, CFP Board-approved coursework, qualifying work experience, passing the CFP exam, and ongoing CE", "A graduate degree in finance", "Ten years in the industry"], "correct": 1, "explanation": "The CFP has multiple requirements — coursework, exam, experience, ongoing CE — and is often the first major credential pursued after the apprenticeship."},
        {"id": "q3", "prompt": "Series 65 is required for:", "options": ["Most investment adviser representatives at RIAs", "Selling insurance products", "All financial planning work", "Only operations staff"], "correct": 0, "explanation": "The Series 65 is the standard license for investment adviser representatives at RIAs and is often the first license pursued after apprenticeship."},
        {"id": "q4", "prompt": "Knowing the work and clients you will *decline* is best described as:", "options": ["Lazy practice management", "Part of knowing your yes — defining no's protects the practice and serves the right clients better", "A way to lose revenue", "A regulatory requirement"], "correct": 1, "explanation": "Counselors who try to be all things to all clients eventually serve no one well. Defining no's is part of a healthy practice."},
        {"id": "q5", "prompt": "Useful metrics for a counselor's own measurement beyond revenue might include:", "options": ["Hours worked per week only", "Client retention, complaint rate, second-generation client retention, peer respect, and clients who describe you as the person they trust most", "Number of leads contacted", "Marketing spend"], "correct": 1, "explanation": "Healthier metrics produce healthier practices. Revenue-only optimization has been a recipe for some of the industry's worst conduct."},
        {"id": "q6", "prompt": "The capstone exercise asks the apprentice to:", "options": ["Take a written final exam", "Lead a full client lifecycle from inquiry through first annual review, integrating competencies across all three bands", "Memorize all thirty competencies", "Pass the Series 65"], "correct": 1, "explanation": "The capstone is integration — demonstrating that the competencies live in your hands, not just your head, through a sustained client engagement."},
        {"id": "q7", "prompt": "Continuing education over a counselor's career is most valuable when:", "options": ["Completed as a minimum compliance checkbox", "Used strategically to deepen areas of specialization and pursue advanced credentials over time", "Limited to mandatory hours", "Done only in the final year of a license cycle"], "correct": 1, "explanation": "Strategic CE — chosen to advance specialization and pursue advanced credentials — compounds into a meaningful career trajectory."},
        {"id": "q8", "prompt": "GIC's commitment to a registered apprenticeship pathway rather than hiring experienced advisors externally reflects:", "options": ["A short-term cost-saving measure", "A long-horizon investment in growing aligned, capable counselors from the ground up, with retention and succession benefits", "A regulatory requirement", "A staffing emergency"], "correct": 1, "explanation": "Apprenticeship is a multi-year bet that pays back through alignment, retention, and succession capacity over many years."},
        {"id": "q9", "prompt": "The most important habit for an apprenticeship graduate's first year of practice is:", "options": ["Maximizing new client acquisition", "Returning to formal study", "Showing up prepared for every client meeting, telling the truth including hard truth, documenting work, and continuing to learn", "Pursuing the next credential immediately"], "correct": 2, "explanation": "These are the daily disciplines that build a real counselor. Credentials and growth follow from them, not the other way around."},
        {"id": "q10", "prompt": "The Life House Reentry framework that preceded GIC's apprenticeship contributed which orientation to this curriculum?", "options": ["High-frequency trading techniques", "Dignity first, accessibility before sophistication, clear language, refusal to shame anyone for what they did not know", "A specific portfolio strategy", "A marketing approach"], "correct": 1, "explanation": "The dignity-first, accessibility-focused, clear-language orientation traveled from Life House into this curriculum and into the kind of counselor it produces."},
        {"id": "q11", "prompt": "Counselor longevity over a 30-year career is best supported by:", "options": ["Working harder during peak years", "Avoiding emotionally taxing client situations", "Sustained investment in life outside the work — relationships, health, intellectual interests, rest — alongside the work itself", "Switching specialties every few years"], "correct": 2, "explanation": "Counseling is emotionally taxing. Sustaining yourself across decades requires deliberate investment in the rest of your life, which makes the work possible to keep doing well."},
        {"id": "q12", "prompt": "The one-page commitment document at the end of this module is intended to:", "options": ["Be submitted for grading", "Be shared publicly", "Be reread on January 1 of each year for the rest of your career, as a personal check on the kind of counselor you intend to be", "Replace the firm's compliance manual"], "correct": 2, "explanation": "The commitment is for you. Reading it annually keeps the philosophy of practice deliberate rather than letting it drift by default."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 32;

-- ── final_exam_setup.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — FINAL COMPREHENSIVE EXAM
-- 30 questions, one per competency, integration-level assessment
-- Passing score: 85% (26 of 30 correct)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Schema: final_exams + final_exam_attempts (idempotent)
-- ----------------------------------------------------------------------------

create table if not exists public.final_exams (
  id uuid primary key default gen_random_uuid(),
  exam_code text unique not null,
  title text not null,
  description text,
  passing_score integer not null default 85,
  content jsonb not null,
  is_active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.final_exam_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  exam_code text not null,
  score integer not null,
  total_questions integer not null,
  passed boolean not null,
  answers jsonb,
  competency_breakdown jsonb,
  started_at timestamptz default now(),
  completed_at timestamptz default now(),
  reviewed_by uuid references auth.users(id),
  reviewed_at timestamptz,
  review_notes text
);

create index if not exists final_exam_attempts_user_idx
  on public.final_exam_attempts(user_id);
create index if not exists final_exam_attempts_exam_idx
  on public.final_exam_attempts(exam_code);

-- ----------------------------------------------------------------------------
-- 2. RLS
-- ----------------------------------------------------------------------------

alter table public.final_exams enable row level security;
alter table public.final_exam_attempts enable row level security;

drop policy if exists "final_exams readable by authenticated" on public.final_exams;
create policy "final_exams readable by authenticated"
  on public.final_exams for select
  using (auth.role() = 'authenticated' and is_active = true);

drop policy if exists "final_exams admin manage" on public.final_exams;
create policy "final_exams admin manage"
  on public.final_exams for all
  using (
    exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver')
    )
  );

drop policy if exists "exam_attempts own read" on public.final_exam_attempts;
create policy "exam_attempts own read"
  on public.final_exam_attempts for select
  using (
    user_id = auth.uid()
    or exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver', 'mentor')
    )
  );

drop policy if exists "exam_attempts own insert" on public.final_exam_attempts;
create policy "exam_attempts own insert"
  on public.final_exam_attempts for insert
  with check (user_id = auth.uid());

drop policy if exists "exam_attempts admin review" on public.final_exam_attempts;
create policy "exam_attempts admin review"
  on public.final_exam_attempts for update
  using (
    exists (
      select 1 from public.profiles
      where profiles.id = auth.uid()
      and profiles.role in ('admin', 'approver')
    )
  );

-- Trigger for updated_at (depends on tg_set_updated_at() from session 1)
drop trigger if exists final_exams_set_updated_at on public.final_exams;
create trigger final_exams_set_updated_at
  before update on public.final_exams
  for each row execute function public.tg_set_updated_at();

-- ----------------------------------------------------------------------------
-- 3. Insert the comprehensive final exam
-- ----------------------------------------------------------------------------

insert into public.final_exams (exam_code, title, description, passing_score, content)
values (
  'FINAL-COMPREHENSIVE',
  'Wealth Solutions Counselor — Final Comprehensive Exam',
  'Capstone assessment covering all thirty competencies of the apprenticeship. One question per competency, integration-level scenarios drawn from real client work. Must be completed after all thirty modules and signed off by the supervising counselor. Passing score: 85% (26 of 30 correct).',
  85,
  $jsonb$
  {
    "exam_type": "final_comprehensive",
    "intro": {
      "title": "Final Comprehensive Exam",
      "summary": "Thirty integration-level questions covering all thirty competencies. This is the final assessment of the Wealth Solutions Counselor apprenticeship.",
      "instructions": [
        "You must have completed all thirty modules before sitting for this exam.",
        "Your supervising counselor must have signed off on your apprenticeship completion before submission counts.",
        "Passing score is 85% — 26 of 30 questions correct.",
        "The exam covers integration of competencies in scenarios drawn from real client work. Recall alone is not sufficient — apply what you have learned.",
        "If you do not pass on the first attempt, a retake may be scheduled after additional review with your mentor on the competencies missed.",
        "Take the time you need. This is not timed. Quality of reasoning matters more than speed.",
        "After you submit, your supervising counselor and the firm's approver will review the result and any apprenticeship documentation."
      ]
    },
    "passing_score": 85,
    "competency_count": 30,
    "questions": [
      {
        "id": "q1",
        "competency": "CORE-1",
        "competency_name": "Financial Literacy & Planning",
        "prompt": "A client reports monthly take-home income of $8,400 and expenses of $7,950, telling you they feel they 'should be saving more.' The strongest next move is to:",
        "options": [
          "Recommend they begin saving $1,500 per month immediately",
          "Walk through their expense categories — fixed, variable, discretionary — to build savings around an honest cash flow picture rather than an aspirational one",
          "Suggest a budgeting app and end the conversation",
          "Defer planning until next year's tax return is filed"
        ],
        "correct": 1,
        "explanation": "Cash flow analysis must precede savings recommendations. Imposing a savings target the cash flow cannot support invites failure and damages trust. Working through real categories produces sustainable saving."
      },
      {
        "id": "q2",
        "competency": "CORE-2",
        "competency_name": "Time Value of Money",
        "prompt": "A 30-year-old client has $25,000 saved, can contribute $500 per month, and expects 7% nominal annualized returns. At age 65, the projected balance is approximately:",
        "options": [
          "~$300,000",
          "~$580,000",
          "~$1.1 million",
          "~$2.5 million"
        ],
        "correct": 2,
        "explanation": "Lump-sum future value of $25,000 at 7% for 35 years is roughly $267,000. Future value of a $500/month annuity at 7% over 35 years is roughly $900,000. Combined ≈ $1.17M. This is the power of compounding paired with consistent contribution."
      },
      {
        "id": "q3",
        "competency": "CORE-3",
        "competency_name": "Credit, Debt & Lending",
        "prompt": "Marcus and Tasha carry credit card debt at 22% APR, an auto loan at 6%, and a mortgage at 4.5%. With $1,500 of extra monthly cash flow, the mathematically optimal payoff strategy is:",
        "options": [
          "Pay off the smallest balance first regardless of rate (debt snowball)",
          "Apply all extra to the highest-rate debt — the credit card at 22% — first (debt avalanche)",
          "Distribute extra payments evenly across all three",
          "Accelerate the mortgage first because of the long term"
        ],
        "correct": 1,
        "explanation": "The avalanche method — extra payments to the highest-interest debt first — minimizes total interest paid. The snowball method has behavioral advantages but is mathematically suboptimal. Knowing both and choosing intentionally with the client is the skill."
      },
      {
        "id": "q4",
        "competency": "CORE-4",
        "competency_name": "Risk Management & Insurance",
        "prompt": "A 38-year-old primary earner with two young children, a non-working spouse, a $500,000 mortgage, and $25,000 in savings has the most urgent insurance need for:",
        "options": [
          "Whole life insurance with cash value accumulation",
          "Term life insurance with a death benefit sized to replace income through child independence and pay off the mortgage",
          "A deferred annuity",
          "Long-term care insurance"
        ],
        "correct": 1,
        "explanation": "The catastrophic loss for this household is the loss of the earner. Term life — cheap, large death benefit, matched to the dependency horizon — is the right tool. Whole life addresses different problems and is not the urgent need here."
      },
      {
        "id": "q5",
        "competency": "CORE-5",
        "competency_name": "Tax Fundamentals",
        "prompt": "A client in the 24% federal marginal tax bracket contributes $7,000 to a Traditional IRA (assume full deductibility). The immediate federal income tax savings is approximately:",
        "options": [
          "$7,000",
          "$1,680",
          "$2,400",
          "$0 — IRA contributions never reduce current taxes"
        ],
        "correct": 1,
        "explanation": "$7,000 × 24% = $1,680. Traditional IRA contributions reduce current taxable income, with savings calculated at the marginal rate. The full $7,000 is not saved — only the tax on that income would have been."
      },
      {
        "id": "q6",
        "competency": "CORE-6",
        "competency_name": "Investment Vehicles & Markets",
        "prompt": "An ETF and a mutual fund tracking the same index differ most importantly in:",
        "options": [
          "Their underlying holdings — they hold different securities",
          "Structural differences affecting tax efficiency, intraday tradability, and expense ratios — with ETFs generally more tax-efficient due to in-kind creation/redemption",
          "Return potential — ETFs outperform mutual funds",
          "Regulatory oversight — only one is SEC-regulated"
        ],
        "correct": 1,
        "explanation": "Same index, same holdings, materially different structure. ETFs trade intraday on exchanges and use in-kind transfers that limit capital gains distributions. Mutual funds price once daily and can distribute taxable gains to all shareholders."
      },
      {
        "id": "q7",
        "competency": "CORE-7",
        "competency_name": "Retirement Planning Foundations",
        "prompt": "A client with a Social Security Full Retirement Age (FRA) of 67 claims benefits at age 62. They will receive approximately what percentage of their Primary Insurance Amount (PIA)?",
        "options": [
          "100% — claiming early has no permanent effect",
          "About 70% — claiming five years early permanently reduces the benefit",
          "50% — early claiming halves the benefit",
          "132% — early claiming triggers delayed retirement credits"
        ],
        "correct": 1,
        "explanation": "Claiming at 62 with an FRA of 67 reduces the benefit to roughly 70% of PIA, permanently. Conversely, delaying past FRA earns 8% annually in delayed retirement credits up to age 70."
      },
      {
        "id": "q8",
        "competency": "CORE-8",
        "competency_name": "Estate Planning & Wealth Transfer",
        "prompt": "A client has a will leaving everything to their spouse. They also have an IRA on which an old beneficiary form names their adult child from a prior marriage as 100% beneficiary. Upon the client's death, the IRA passes to:",
        "options": [
          "The spouse, because the will controls all assets",
          "The adult child named on the beneficiary form, because retirement account beneficiary designations override the will",
          "The estate, splitting between spouse and child",
          "Probate court — to be decided by a judge"
        ],
        "correct": 1,
        "explanation": "Beneficiary designations on retirement accounts and life insurance are non-probate transfers that override the will. This is one of the most consequential and routinely-mishandled details in estate planning."
      },
      {
        "id": "q9",
        "competency": "CORE-9",
        "competency_name": "Ethics, Fiduciary Duty & Regulation",
        "prompt": "A counselor recommends a product paying them a 5% commission when an equally suitable, lower-cost no-commission alternative exists. Under a fiduciary standard, this:",
        "options": [
          "Is permissible if disclosed to the client",
          "Violates the duty of loyalty — the recommendation must be in the client's best interest, not the counselor's, regardless of disclosure",
          "Is required by FINRA",
          "Is acceptable if the recommended product performs well"
        ],
        "correct": 1,
        "explanation": "Fiduciary duty is more than disclosure. Loyalty requires the client's best interest to come first. Disclosure cures conflicts in some circumstances but does not cure choosing a worse option for the client because it pays the counselor more."
      },
      {
        "id": "q10",
        "competency": "OJL-1",
        "competency_name": "Client Discovery & Intake",
        "prompt": "In a discovery meeting, a client casually mentions 'I had some health issues last year' and immediately changes the topic. The most appropriate response is to:",
        "options": [
          "Move on — health is outside financial planning scope",
          "Pause and ask one open question to understand whether the health event affects current planning, while leaving the client in control of how much to share",
          "Request medical records to update risk profile",
          "Refer them to a physician"
        ],
        "correct": 1,
        "explanation": "Health events have real planning implications — disability insurance, retirement timing, estate planning, cash flow. But pressing too hard breaks trust. The skill is acknowledging gently and inviting one more sentence without prying."
      },
      {
        "id": "q11",
        "competency": "OJL-2",
        "competency_name": "Goal-Setting & Prioritization",
        "prompt": "A client lists six goals: emergency fund, debt payoff, retirement saving, kids' college, vacation home, kitchen renovation. With limited cash flow, the right next step is to:",
        "options": [
          "Pursue all six simultaneously with equal funding",
          "Tell the client to pick the single most important goal",
          "Help the client sequence and prioritize, distinguishing foundational goals (emergency fund, high-rate debt) from longer-horizon and discretionary goals",
          "Pursue them in the order the client listed"
        ],
        "correct": 2,
        "explanation": "Foundational goals (emergency reserve, high-rate debt) usually need to be at least partially established before longer-horizon goals can be safely funded. Sequencing is a counselor skill — not a personal ranking but a structural one."
      },
      {
        "id": "q12",
        "competency": "OJL-3",
        "competency_name": "Document Collection & Analysis",
        "prompt": "The most efficient and reliable way to manage document collection across a client base is:",
        "options": [
          "Ad hoc emails when something specific is needed",
          "A consistent tracker (CRM or shared list) showing requested, received, and outstanding items per client, reviewed at a regular cadence with clear next actions",
          "Wait for clients to send what they think is relevant",
          "Collect everything at once in a single massive request"
        ],
        "correct": 1,
        "explanation": "Document collection is operational discipline. A tracker prevents drop-through, reduces follow-up friction, and lets the counselor verify status in seconds rather than hunting through email threads."
      },
      {
        "id": "q13",
        "competency": "OJL-4",
        "competency_name": "Building Financial Statements",
        "prompt": "A client's net worth has increased $80,000 year-over-year. Their cash flow statement shows only $15,000 in savings from income during the same period. The most likely explanation is:",
        "options": [
          "The savings figure is understated and must be corrected",
          "Asset appreciation — investments and home equity — accounts for most of the increase, since net worth reflects both cash flow contributions and market value changes",
          "The client is hiding income",
          "The cash flow statement is wrong"
        ],
        "correct": 1,
        "explanation": "Net worth changes from two sources: contributions from cash flow, and appreciation/depreciation of existing assets. A counselor who conflates the two will misread the client's actual savings discipline."
      },
      {
        "id": "q14",
        "competency": "OJL-5",
        "competency_name": "Behavioral Finance & Client Coaching",
        "prompt": "A client emails at 11pm wanting to 'move everything to cash' after an 18% portfolio drop. The strongest next-morning response is to:",
        "options": [
          "Process the trade per the client's written instructions",
          "Reply with a chart of long-term market returns and a recommendation to stay the course",
          "Call the client, acknowledge the fear before any data, and only then walk through what the plan was designed to do in exactly this scenario",
          "Refer them to a mental health professional"
        ],
        "correct": 2,
        "explanation": "Clients in fear cannot hear data until they feel heard. The emotion comes first, the data follows. Charts emailed in response to panic almost always fail. A live conversation that begins with the feeling almost always works."
      },
      {
        "id": "q15",
        "competency": "OJL-6",
        "competency_name": "Risk Profiling & Suitability",
        "prompt": "A 24-year-old client with high stated risk tolerance wants to invest a house down payment they will use in approximately 18 months. The portfolio decision should be driven primarily by:",
        "options": [
          "Their high stated risk tolerance — aggressive equity allocation",
          "Risk capacity — the 18-month horizon for the specific dollar means short-term instruments are appropriate regardless of stated tolerance",
          "A standard 60/40 allocation",
          "Maximizing expected return given their long career horizon"
        ],
        "correct": 1,
        "explanation": "Capacity beats tolerance every time. The dollar's job determines its allocation. An 18-month down payment has zero capacity for equity drawdown no matter how aggressive the client says they are."
      },
      {
        "id": "q16",
        "competency": "OJL-7",
        "competency_name": "Plan Presentation & Communication",
        "prompt": "Presenting a plan with five recommendations, the most effective sequencing is:",
        "options": [
          "Hardest first to get the difficult conversation over with",
          "Random order to keep the client engaged",
          "High-impact, easy wins first to build momentum and agreement before harder asks",
          "Alphabetical for clarity"
        ],
        "correct": 2,
        "explanation": "A client who has agreed to three things in the first ten minutes is far more likely to agree to a harder fourth. Sequencing intentionally — easy wins first, hardest ask last — is communication craft."
      },
      {
        "id": "q17",
        "competency": "OJL-8",
        "competency_name": "Implementation & Coordination",
        "prompt": "A 401(k) rollover check arrives at the client's home made payable to the client (not to the receiving custodian). The right immediate action is to:",
        "options": [
          "Have the client deposit the check and complete the 60-day indirect rollover",
          "Stop the process, document the situation, and call the sending custodian to reissue the check made payable to the receiving custodian for benefit of the client — converting it to a direct rollover",
          "Have the client cash the check and wire the funds",
          "Wait 30 days to see if the situation resolves"
        ],
        "correct": 1,
        "explanation": "A check payable to the client is an indirect rollover — triggers mandatory 20% federal withholding and a 60-day deposit clock. Reissue properly to avoid both. Time matters; the 60-day clock starts when the client receives the check."
      },
      {
        "id": "q18",
        "competency": "OJL-9",
        "competency_name": "Ongoing Reviews & Life Events",
        "prompt": "During an annual review, a client mentions casually that their adult daughter is going through a divorce. The right response is to:",
        "options": [
          "Note it but defer until the next scheduled annual review",
          "Acknowledge it and ask one open question about whether the parents are providing any financial support — adult children's life events can have material planning implications even when indirect",
          "Push to revise the entire estate plan that day",
          "Refer them to a family law attorney"
        ],
        "correct": 1,
        "explanation": "Indirect life events still touch the plan — financial support to adult children, estate plan beneficiary considerations, potential capacity to help. Surface it gently and explore what matters for planning."
      },
      {
        "id": "q19",
        "competency": "OJL-10",
        "competency_name": "Portfolio Construction",
        "prompt": "A 35-year-old client with a 30+ year horizon, stable W-2 income, six months of emergency reserves, and moderate risk tolerance is most appropriately served by a portfolio that is:",
        "options": [
          "100% cash to preserve capital",
          "Diversified with a meaningful equity allocation appropriate to a long horizon, fixed-income exposure for stability and behavioral ballast, and global diversification — without concentration in any single position",
          "100% in employer stock to maximize growth potential",
          "Concentrated in a single high-conviction sector"
        ],
        "correct": 1,
        "explanation": "Portfolio construction follows from goals, horizon, capacity, and tolerance — not from chasing returns or avoiding all risk. Diversification across asset classes and regions, scaled to the client's actual situation, is the foundation."
      },
      {
        "id": "q20",
        "competency": "OJL-11",
        "competency_name": "Investment Research & Due Diligence",
        "prompt": "When evaluating a new fund for inclusion in a client portfolio, the most important factors to assess are:",
        "options": [
          "Trailing 1-year performance and recent star ratings",
          "Investment process, fees and expense ratio, manager tenure, fit with the existing portfolio's role for that allocation slot, risk-adjusted long-term track record, and tax efficiency",
          "Marketing materials and brand recognition",
          "Whatever the sales representative recommends"
        ],
        "correct": 1,
        "explanation": "Recent performance is the weakest predictor of future performance. Fees, process, tenure, fit, and risk-adjusted long-term results are stronger signals. Due diligence is structured, repeatable analysis — not pattern-matching to recent winners."
      },
      {
        "id": "q21",
        "competency": "OJL-12",
        "competency_name": "Asset Allocation & Rebalancing",
        "prompt": "A portfolio designed as 70% equity / 30% fixed income has drifted to 78/22 after a strong equity year. The disciplined response is to:",
        "options": [
          "Let it ride — the equities are working",
          "Rebalance toward target, trimming equities and adding to fixed income — restoring the risk profile the client signed for and locking in some gains",
          "Sell all equities to cash",
          "Buy more equities to extend the trend"
        ],
        "correct": 1,
        "explanation": "Rebalancing enforces the discipline of buying low and selling high — and more importantly, holds the portfolio to the risk profile the client agreed to. Drift is a risk signal, not a feature."
      },
      {
        "id": "q22",
        "competency": "OJL-13",
        "competency_name": "Performance Reporting",
        "prompt": "A client portfolio returned 12% in a year the S&P 500 returned 18%. The right framing for the client is:",
        "options": [
          "Acknowledge underperformance and consider manager changes",
          "Compare the return to the appropriate blended benchmark for the client's actual allocation, not a 100% equity index — a 70/30 benchmark may have returned approximately 12%",
          "Recommend shifting to a 100% S&P 500 portfolio",
          "Avoid the topic"
        ],
        "correct": 1,
        "explanation": "Performance reporting without correct benchmarking misleads. A diversified portfolio should be compared to a diversified benchmark. Comparing a 70/30 portfolio to the S&P 500 invites bad decisions in both directions across cycles."
      },
      {
        "id": "q23",
        "competency": "OJL-14",
        "competency_name": "Trading & Execution",
        "prompt": "For a large equity trade in a thinly-traded stock, best execution practice is to:",
        "options": [
          "Submit as a single market order for immediate fill",
          "Use limit orders and/or work the order over time to manage market impact, prioritizing execution quality (price, total cost) over speed alone",
          "Wait until the closing auction regardless of conditions",
          "Always use stop orders"
        ],
        "correct": 1,
        "explanation": "Best execution considers price, total cost, speed, likelihood of execution, and market impact. For thinly-traded names, market orders can move the price against the client. Limit orders and time-weighted execution protect the client's outcome."
      },
      {
        "id": "q24",
        "competency": "OJL-15",
        "competency_name": "Tax-Loss Harvesting",
        "prompt": "A client harvests a $5,000 loss by selling a fund. To preserve the loss for tax purposes, they must avoid repurchasing 'substantially identical' securities for:",
        "options": [
          "The same trading day",
          "30 calendar days before or after the sale (a 61-day window total) — the wash-sale rule",
          "The remainder of the tax year",
          "Six months from the sale date"
        ],
        "correct": 1,
        "explanation": "The wash-sale rule disallows the loss if substantially identical securities are purchased within 30 days before or after the sale. The window extends across the sale date — both directions matter. Violations defer rather than eliminate the loss but complicate basis tracking."
      },
      {
        "id": "q25",
        "competency": "OJL-16",
        "competency_name": "Account Administration & Custody",
        "prompt": "At a qualified custodian like Schwab or Fidelity serving an RIA, client assets are held:",
        "options": [
          "On the advisor firm's balance sheet, commingled with firm assets",
          "In the client's name at the qualified custodian, segregated from advisor firm assets, with the advisor having limited authority per the advisory agreement",
          "In a single pooled account with other clients",
          "Anywhere the advisor chooses to hold them"
        ],
        "correct": 1,
        "explanation": "Qualified custody is a regulatory protection — client assets stay in the client's name at an independent custodian. The advisor has agreed-upon authority (trade, fee deduction) but does not hold the assets. This is foundational to client protection in the RIA model."
      },
      {
        "id": "q26",
        "competency": "OJL-17",
        "competency_name": "Reconciliation & Operations Controls",
        "prompt": "Daily reconciliation between the firm's internal records and the custodian's records exists primarily to:",
        "options": [
          "Satisfy regulators with paperwork",
          "Catch errors, fraud, and discrepancies early — when they are still small and recoverable — through systematic comparison rather than accidental discovery later",
          "Generate billable activity",
          "Replace external audits"
        ],
        "correct": 1,
        "explanation": "Reconciliation is the operational discipline that catches problems before they become catastrophes. The cost of daily reconciliation is small. The cost of discovering a six-month-old error or a quiet fraud through an unrelated audit is enormous."
      },
      {
        "id": "q27",
        "competency": "OJL-18",
        "competency_name": "Compliance Workflows",
        "prompt": "A compliance review surfaces a recommendation that was substantively suitable for the client but had no documented rationale in the client file. The compliance issue is:",
        "options": [
          "None — the recommendation was suitable",
          "The missing documentation — a suitable recommendation without documented rationale is, for regulatory and audit purposes, indistinguishable from an unsuitable one",
          "The recommendation itself, which should be reversed",
          "Both — and the matter should be escalated to FINRA immediately"
        ],
        "correct": 1,
        "explanation": "Compliance lives in the documentation. A regulator reviewing the file three years later cannot reconstruct your reasoning if it was never written down. 'It was suitable' is not a defensible claim without contemporaneous evidence of why."
      },
      {
        "id": "q28",
        "competency": "OJL-19",
        "competency_name": "Cybersecurity & Data Protection",
        "prompt": "An apprentice receives an urgent wire transfer request via email from a long-standing client on a Friday afternoon. The non-negotiable next action is to:",
        "options": [
          "Process the wire to meet the Friday cutoff",
          "Voice-verify the request by calling the client at the phone number already in the CRM — not at any number provided in the email — before any wire is processed",
          "Reply to the email confirming receipt and process",
          "Have a second team member verify via email and then process"
        ],
        "correct": 1,
        "explanation": "Wire fraud is the highest-loss event most advisor firms face. Voice verification at a known number is the entire defense. Friday-afternoon urgency is itself a signal often engineered by attackers to delay weekend discovery. Verify every time, no exceptions."
      },
      {
        "id": "q29",
        "competency": "OJL-20",
        "competency_name": "Practice Management & Business Development",
        "prompt": "The most important growth lever for most advisory firms is:",
        "options": [
          "Aggressive marketing spend on digital lead generation",
          "Client retention over decades — most firms with a perceived growth problem actually have a quiet retention problem disguised as a marketing problem",
          "Hiring more advisors as quickly as possible",
          "Lowering fees to undercut competitors"
        ],
        "correct": 1,
        "explanation": "A retained client compounds in value over a 20-year relationship. A new client added to replace a lost one resets the clock. Firms that retain well grow almost without trying. Firms that lose quietly cannot out-market the leak."
      },
      {
        "id": "q30",
        "competency": "OJL-21",
        "competency_name": "Capstone — Building a Practice",
        "prompt": "Completing this apprenticeship is most accurately understood as:",
        "options": [
          "A finished credential that completes the counselor's development",
          "The foundation of a craft — the apprenticeship gives the shape of the work; the next decade of repeated practice with real clients gives the substance",
          "Sufficient preparation for partnership-level responsibilities immediately",
          "A regulatory checkbox unrelated to actual practice"
        ],
        "correct": 1,
        "explanation": "An apprenticeship graduate who treats the credential as the destination is not yet what the credential represents. An apprenticeship graduate who treats it as the starting line of a thirty-year practice is. The thirty competencies are foundations — mastery comes through years of repetition with real clients."
      }
    ]
  }
  $jsonb$::jsonb
)
on conflict (exam_code) do update set
  title = excluded.title,
  description = excluded.description,
  passing_score = excluded.passing_score,
  content = excluded.content,
  updated_at = now();

-- ----------------------------------------------------------------------------
-- 4. Verification query (run manually to confirm)
-- ----------------------------------------------------------------------------
-- select exam_code, title, passing_score,
--   jsonb_array_length(content -> 'questions') as question_count
-- from public.final_exams
-- where exam_code = 'FINAL-COMPREHENSIVE';
