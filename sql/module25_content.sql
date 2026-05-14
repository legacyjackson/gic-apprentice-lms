-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 25 CONTENT
-- Account Administration & Custody
-- ============================================================================
update public.modules set
  title = 'Account Administration & Custody',
  competency_id = 'OJL-16',
  ri_hours = 0,
  ojl_hours = 80,
  short_description = 'Understand the custodial infrastructure that holds client assets — what custodians actually do, how account registrations work, what protections exist, and the day-to-day administration that keeps everything running clean.',
  learning_objectives = ARRAY[
    'Distinguish the roles of advisor, custodian, and broker-dealer',
    'Choose the right account registration for each client situation',
    'Understand SIPC, FDIC, and other investor protections',
    'Manage account-level details — money movement, ACH, beneficiaries, authority levels',
    'Recognize the operational risks that live in account administration and how to control them'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Who Holds the Money — Advisor, Custodian, Broker-Dealer",
        "summary": "Many clients believe their advisor holds their money. They do not. Understanding who does — and why that separation matters — is the foundation of operational competence.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "When a client invests through an RIA, three different entities are typically involved: the advisor (the firm that recommends and manages the portfolio), the custodian (the firm that holds the assets and processes transactions), and the broker-dealer (the firm that executes trades, sometimes the same entity as the custodian). The separation of these roles is not arbitrary — it is a structural protection. The advisor recommends; the custodian holds and verifies; nobody touches the client's money in isolation. Understanding the architecture protects clients and prevents the kinds of fraud that have ended advisor careers."},
          {"type": "subheading", "content": "The advisor's role"},
          {"type": "paragraph", "content": "Registered Investment Advisers are typically registered with either the SEC (if assets under management exceed $100M) or with state securities regulators (below that threshold). They provide advice, build portfolios, execute trades on the client's behalf through the custodian, and bill fees. The advisor does not hold the client's assets directly. Statements come from the custodian, not the advisor — this is a structural protection against fraud."},
          {"type": "subheading", "content": "The custodian's role"},
          {"type": "paragraph", "content": "Custodians — Schwab, Fidelity, Pershing, Goldman Sachs Custody Solutions, and others — hold the securities, process trades, send statements, handle corporate actions, distribute dividends, and report tax information. They are typically broker-dealers themselves and are subject to SEC and FINRA oversight. The custodian's records are the official record of what the client owns. If the advisor's reporting and the custodian's reporting differ, the custodian's records prevail."},
          {"type": "subheading", "content": "Why the separation matters — Madoff and lessons learned"},
          {"type": "paragraph", "content": "Bernie Madoff's fraud worked partly because he ran both the advisory firm and the custodian — clients received statements from Madoff Securities showing assets that did not exist. After Madoff, the industry doubled down on the principle that custody should be independent of advice. When a client receives a statement from Schwab (not from their RIA) showing their actual securities, that statement is the truth. The RIA's portfolio management software is reconciled against custodial data, not the other way around. The separation is the structural defense against most fraud patterns."},
          {"type": "callout", "kind": "key", "content": "When in doubt about whether something is right, look at the custodial statement, not the advisor's report. The custodial statement is the official record."},
          {"type": "subheading", "content": "The broker-dealer's role"},
          {"type": "paragraph", "content": "Broker-dealers execute trades. At many custodians, the same legal entity serves as custodian and as broker-dealer (Schwab and Fidelity are both). At others, there is more separation. When trades are placed, the executing broker may differ from the custodian (especially for less liquid securities or larger institutional trades). The Trade Confirmation generated for each trade names the executing broker; the custodial statement reflects the resulting position. For retail RIA work using major custodians, advisor, custodian, and broker-dealer often appear in a clean three-way relationship that simplifies the model."},
          {"type": "subheading", "content": "Authority levels — what the advisor can do without client permission"},
          {"type": "list", "items": [
            "Discretionary authority — advisor can place trades within the IPS without per-trade client consent (the most common model)",
            "Limited trading authority — advisor can trade but only with explicit per-trade client consent",
            "Limited withdrawal authority — advisor can withdraw fees from the account per the advisory agreement, but cannot withdraw to anywhere else",
            "Full transaction authority — rare in retail RIA, allows advisor to direct distributions to client-specified destinations; tightly controlled with paperwork",
            "Account opening authority — typically client must sign for new accounts, even with discretionary authority over existing ones"
          ]},
          {"type": "subheading", "content": "Custodial selection considerations"},
          {"type": "paragraph", "content": "Larger RIAs typically work with a single primary custodian or a small number. The choice affects: trading commissions and pricing, technology integration (CRM, portfolio management software), product availability (mutual funds, alternatives, structured products), service quality and operational support, minimum account sizes for the custodian platform, and fee structure (some custodians charge platform fees on top of advisor fees, others bundle). The choice is significant. Apprentices typically operate within the firm's existing custodial relationship rather than choosing one."},
          {"type": "case_study", "title": "The fraud that didn't happen", "scenario": "A client receives a phone call from someone claiming to be from her advisor's office, saying her advisor has changed firms and her account needs to be transferred — to a new custodian she has never heard of, with instructions to wire funds. The client calls her actual advisor to verify. The advisor confirms: no transfer is happening, no wire instructions were authorized, the call was fraudulent. The advisor walks her through verifying the custodial statement directly with the custodian (Schwab in this case) — her assets are intact at the custodian. Police are notified.", "discussion": "The structural separation prevented loss. The client knew the custodial relationship existed — her statements came from Schwab, not from the advisor — and that knowledge let her test the fraudulent call by going to the custodian directly. Clients who understand the custody architecture are harder to defraud."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Account Registrations — Getting the Title Right",
        "summary": "How an account is titled determines who owns it, who can access it, how it passes at death, and how it is treated for tax purposes. Getting the registration wrong is one of the most expensive mistakes in retail finance.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "Account registration is the legal title of the account — who owns it, in what capacity, and with what rights. Most clients give little thought to registration ('whatever is easiest'), but the choice has consequences that cascade through tax, estate, creditor, and family-law contexts. The correct registration depends on the client's situation, state law, and goals. Knowing the major types and when each fits is fundamental operational knowledge."},
          {"type": "subheading", "content": "Individual accounts"},
          {"type": "glossary", "terms": [
            {"term": "Individual account", "definition": "A taxable brokerage account titled to one person. Simple. Passes through the owner's will or trust at death (no automatic transfer feature)."},
            {"term": "Joint Tenants with Rights of Survivorship (JTWROS)", "definition": "Two owners with equal rights; at first owner's death, the entire account passes automatically to the surviving owner outside probate. Common between spouses."},
            {"term": "Tenants in Common (TIC)", "definition": "Two or more owners with specified percentages; each owner's share passes through their own estate at death, not automatically to the other owner. Used when joint owners want their share to go elsewhere than the co-owner."},
            {"term": "Community Property", "definition": "Specific to community property states (California and 8 others); spouses each have a 50% interest in property acquired during marriage. Has tax basis advantages at first spouse's death (full step-up on both halves in some configurations)."},
            {"term": "Joint Tenants by the Entirety", "definition": "A form of joint ownership available only to married couples in some states. Has creditor protection advantages: neither spouse's individual creditors can attach the account; only joint creditors of both spouses can."}
          ]},
          {"type": "subheading", "content": "Trust accounts"},
          {"type": "paragraph", "content": "Accounts titled in the name of a trust are held according to the trust's terms. The trustee — named in the trust document — has authority over the account. Trust accounts can be: revocable (the grantor can change or revoke the trust; for the grantor's lifetime the account is taxed as their own); irrevocable (cannot be changed once established; separate tax entity); testamentary (created by will at death). Account titling typically reads 'John Smith, Trustee of the Smith Family Living Trust dated 3/15/2018.' Get the title exact — the custodian requires the title to match the trust document precisely."},
          {"type": "subheading", "content": "Retirement accounts"},
          {"type": "list", "items": [
            "Traditional IRA — individually owned, contributions usually pre-tax, withdrawals taxed as ordinary income",
            "Roth IRA — individually owned, contributions after-tax, qualified withdrawals tax-free",
            "Rollover IRA — created to receive a rollover from a 401(k) or other qualified plan; same as Traditional IRA for most purposes but may have advantages for future rollback to a new employer plan",
            "SEP IRA — Simplified Employee Pension; self-employment retirement plan with higher contribution limits than personal IRA",
            "SIMPLE IRA — for small businesses with up to 100 employees; lower contribution limits than 401(k)",
            "401(k) — employer-sponsored qualified retirement plan; varies by plan",
            "Inherited IRA (Beneficiary IRA) — special account type holding inherited retirement assets; SECURE Act rules govern distribution"
          ]},
          {"type": "subheading", "content": "Custodial and minor accounts"},
          {"type": "list", "items": [
            "UTMA/UGMA — Uniform Transfers/Gifts to Minors Act accounts; assets owned by the minor with an adult custodian until the age of majority (18 or 21 depending on state and account type)",
            "529 plans — state-sponsored education savings accounts with tax advantages",
            "Coverdell ESA — Education Savings Account; less commonly used since 529 limits expanded",
            "Custodial Roth IRA — Roth IRA for a minor with earned income; custodian until majority"
          ]},
          {"type": "subheading", "content": "Business and entity accounts"},
          {"type": "list", "items": [
            "Sole proprietorship — typically uses individual or DBA registration; assets are the owner's personally",
            "LLC accounts — owned by the LLC entity; titled in the LLC name; signing authority defined by operating agreement",
            "Corporate accounts — owned by the corporation; signing authority per board resolution",
            "Partnership accounts — owned by the partnership; authority per partnership agreement"
          ]},
          {"type": "callout", "kind": "warn", "content": "Getting the registration wrong at account opening is much cheaper to fix than discovering it years later when the client dies or divorces or gets sued. Take the extra five minutes at opening to confirm the registration is correct."},
          {"type": "subheading", "content": "Transfer-on-Death (TOD) and Payable-on-Death (POD)"},
          {"type": "paragraph", "content": "TOD on a brokerage account or POD on a bank account names a beneficiary who will receive the account directly at the owner's death, bypassing probate. TOD/POD is a powerful tool for simple estate planning — passes assets outside probate, supersedes the will for those specific assets — but requires care. The named beneficiary must be kept current. TOD does not avoid estate tax. TOD beneficiaries must be coordinated with the rest of the estate plan; uncoordinated TOD can produce inheritances that contradict the will's intent."},
          {"type": "case_study", "title": "The registration that didn't match the trust", "scenario": "Devon and his wife established a Family Living Trust in 2018. The attorney drafted the trust expecting Devon's brokerage account to be titled in the name of the trust. Five years later when reviewing the estate plan, the apprentice notices: the brokerage account is still titled in Devon's individual name. The trust was created but the asset was never re-titled into it. If Devon died, the brokerage account would pass through his will (not the trust), going through probate, potentially with different beneficiaries than the trust's terms. The fix takes 45 minutes — Devon and the apprentice complete the custodian's retitling paperwork, the account moves to trust registration, and the trust now actually holds the asset it was designed to hold.", "discussion": "Estate plans are only as good as their funding. The trust document is one half; the retitled accounts are the other. Without re-registration, the estate plan was a paper exercise. This is the kind of operational miss that estate attorneys assume their clients (or advisors) will handle and that often does not get done."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "SIPC, FDIC, and Other Investor Protections",
        "summary": "Clients want to know their money is safe. Knowing what is actually protected — and what is not — lets you answer the question correctly.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Several different protection regimes apply to different types of financial accounts. None of them are a guarantee against investment loss; all of them protect against specific failure scenarios. Confusing them — or implying broader protection than exists — is a regulatory and ethical issue. Know the scope of each."},
          {"type": "subheading", "content": "SIPC — Securities Investor Protection Corporation"},
          {"type": "paragraph", "content": "SIPC is a nonprofit funded by member broker-dealers and provides protection if a member broker-dealer fails (financial failure of the brokerage itself), not against market losses. Coverage: up to $500,000 per customer per separate capacity, including a $250,000 sublimit for cash. SIPC restores securities and cash held by the failed broker-dealer to customers. Most major custodians carry supplemental insurance beyond SIPC's limits through commercial insurers — Lloyd's of London is commonly named — extending protection to substantially higher amounts (often hundreds of millions per account)."},
          {"type": "subheading", "content": "FDIC — Federal Deposit Insurance Corporation"},
          {"type": "paragraph", "content": "FDIC insures bank deposits up to $250,000 per depositor per insured bank per ownership category. Applies to checking, savings, CDs, and money market deposit accounts at FDIC-insured banks — not to money market funds (different product even though similar name), brokerage cash balances at non-bank custodians, or investment securities. A married couple with proper account structuring can have substantially more than $250,000 protected at a single bank by using different ownership categories (individual, joint, trust, retirement)."},
          {"type": "subheading", "content": "NCUA — National Credit Union Administration"},
          {"type": "paragraph", "content": "NCUA provides FDIC-equivalent insurance for credit unions, with the same $250,000 per depositor per insured credit union per ownership category limit."},
          {"type": "subheading", "content": "What is NOT protected"},
          {"type": "list", "items": [
            "Investment losses from market movements — SIPC explicitly does not protect against market risk",
            "Losses from bad advice or unsuitable recommendations — separate remedies through arbitration or court",
            "Money market funds (not bank deposit money market accounts) — these are SEC-regulated investment products without SIPC cash sublimit protection, though they have stable-NAV regulation",
            "Cryptocurrency holdings on most platforms — no SIPC, no FDIC, regulatory framework still developing",
            "Commodities futures accounts — covered by SIPC only in limited ways; CFTC has its own regime",
            "Insurance products — covered by state insurance guaranty associations, which vary by state and product type"
          ]},
          {"type": "subheading", "content": "Communicating protections accurately"},
          {"type": "paragraph", "content": "Clients often ask 'is my money insured?' The honest answer is layered: their cash at a bank is FDIC-insured up to limits; their cash and securities at a brokerage are SIPC-protected against broker-dealer failure up to limits, often with supplemental coverage beyond; nothing protects them against investment losses from market movements; bad advice is a separate accountability path through fiduciary duty and dispute resolution. Avoid any phrasing that suggests their investment values are 'safe' or 'protected' in a market-loss sense — they are not."},
          {"type": "callout", "kind": "warn", "content": "Telling a client their investments are 'protected' or 'safe' in any blanket way is a compliance issue and an ethical one. Be precise about what each insurance regime actually covers."},
          {"type": "subheading", "content": "Cash sweep arrangements"},
          {"type": "paragraph", "content": "Most brokerages sweep uninvested cash into one of several vehicles: money market funds (not FDIC-insured but SIPC-cash-sublimit protected and stable-NAV regulated), bank deposit sweep programs (FDIC-insured up to limits, often spread across multiple partner banks to extend coverage), or money market deposit accounts (FDIC-insured up to single-bank limits). The choice affects yield, insurance coverage, and access. Most retail clients have a default sweep vehicle that may not be optimal — particularly for cash balances above FDIC single-bank limits. Reviewing sweep arrangements at account setup is part of competent administration."},
          {"type": "case_study", "title": "The cash sweep question", "scenario": "A retired client has $620,000 sitting in their brokerage account's cash sweep — a single-bank FDIC sweep at the custodian. Only $250,000 is insured at that bank. The apprentice flags this in the next review: 'Your current cash sweep covers $250K of the $620K under FDIC. The remaining $370K is uninsured. We have three options: (1) move to a multi-bank sweep program at this custodian that spreads cash across multiple banks for higher coverage, (2) keep the FDIC-insured portion here and move excess to a money market fund for SIPC-cash protection within limits, or (3) deploy the cash into the portfolio per the IPS — most of this cash is sitting idle and could be invested.' The client opts for the multi-bank sweep on operating cash plus deployment of excess into the portfolio.", "discussion": "Without the apprentice flagging this, the client could have lost insurance protection on $370K without knowing. Account administration includes noticing things like this. Cash sweep arrangements are easy to ignore — and the cost of ignoring them shows up only in tail-risk scenarios."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "Money Movement — ACH, Wires, Journals, and Standing Instructions",
        "summary": "Money has to move in and out of accounts. Each method has its own speed, cost, risk profile, and proper use. Getting money movement right is operational discipline.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Routine account operations involve frequent money movement — depositing contributions, distributing income, paying advisory fees, transferring between accounts, sending withdrawals to clients. The methods used carry different speeds, costs, irreversibility, and fraud risks. Choosing the right method for each situation, and verifying movement before considering it complete, is daily operational work."},
          {"type": "subheading", "content": "Common money movement methods"},
          {"type": "glossary", "terms": [
            {"term": "ACH (Automated Clearing House)", "definition": "Electronic bank-to-bank transfer. Typically 1-3 business days. Free at most custodians. Reversible within a window. Standard method for client contributions, withdrawals, and recurring transfers."},
            {"term": "Wire transfer", "definition": "Same-day electronic transfer. Fee-based (typically $15-30 outgoing). Generally irreversible once sent. Used for large transfers, time-sensitive transfers, and any transfer to a non-bank destination."},
            {"term": "Journal", "definition": "Internal transfer between accounts at the same custodian. Same-day, free, and the cleanest method for moving assets between client accounts within one custodian."},
            {"term": "Check", "definition": "Paper or electronic check. Slowest method (mail time plus deposit time). Still used for some scenarios; mostly displaced by ACH and wire."},
            {"term": "Standing instruction / Letter of Authorization", "definition": "Pre-authorized recurring transfer instructions on file with the custodian. Allows automated movement (monthly contributions, scheduled withdrawals) without per-transaction approval."}
          ]},
          {"type": "subheading", "content": "ACH for routine flows"},
          {"type": "paragraph", "content": "ACH is the standard method for most retail money movement: scheduled monthly contributions, distributions from retirement accounts, advisory fee deductions, and one-time client-requested deposits or withdrawals. The mechanics: a one-time client-signed authorization on file with the custodian links a verified external bank account; subsequent ACH instructions can be initiated by the client or by the advisor (within the scope of authority granted). ACH transactions are reversible for a window — typically 60 days for consumer accounts under NACHA rules — which provides some protection against fraud but also means the transfer is not 'final' immediately."},
          {"type": "subheading", "content": "Wires for large or time-sensitive transfers"},
          {"type": "paragraph", "content": "Wires are used when speed matters (settlement on a real estate purchase) or when ACH limits are exceeded (some banks limit ACH amounts) or when the destination is not a regular bank account (a title company escrow, an attorney's IOLTA account). Wire fees are not trivial — outgoing wires typically cost $15-30; international wires cost more. Wires are irreversible. Once sent, the money is gone. This irreversibility is the source of most wire fraud losses — once a fraudster has tricked a victim into sending a wire to the wrong account, the recovery options are limited."},
          {"type": "callout", "kind": "warn", "content": "Wire instructions changed in an email are a common fraud pattern. If wire instructions arrive by email — even from a known counterparty (CPA, attorney, title company) — verbally verify them by phone using a previously-known number before initiating. The five-minute call has prevented many six- and seven-figure fraud losses."},
          {"type": "subheading", "content": "Journals between accounts at the same custodian"},
          {"type": "paragraph", "content": "When moving assets between accounts at the same custodian — between a client's spouse's account, between their taxable and IRA, between household member accounts — a journal is the cleanest method. Same-day, free, and bypasses the external banking system. The custodian handles tax-reporting implications appropriately. Use journals whenever the destination is internal to the custodian; default to ACH or wire only when external transfer is necessary."},
          {"type": "subheading", "content": "Standing instructions — efficient but require monitoring"},
          {"type": "paragraph", "content": "Standing instructions automate recurring transfers — the $400 bi-weekly auto-save we set up for Marcus and Tasha in Module 17. These are valuable for behavioral reasons (the transfer happens without the client having to remember) but require periodic verification: confirm the transfer is actually executing as expected; confirm the destination details have not changed; confirm the amount is still appropriate for the client's situation. Standing instructions also need to be terminated cleanly when no longer wanted — leaving a standing instruction running after it should have ended is a common operational error."},
          {"type": "subheading", "content": "Verification — confirm money actually arrived"},
          {"type": "paragraph", "content": "An initiated transfer is not a completed transfer. Always verify the money arrived where it was supposed to go and in the amount expected. For ACH, wait for the settled date (typically T+2 to T+3) before considering the transfer complete. For wires, confirm receipt on the destination side (often via a confirmation from the receiving bank). For journals, the same-day verification is straightforward — the source account is debited and the destination is credited within hours. The verification step is identical in principle to the post-trade verification from Module 17 — submission is not completion."},
          {"type": "case_study", "title": "The wire that almost went to the fraudster", "scenario": "Devon's controller emails the apprentice with updated wire instructions for the firm's quarterly distribution — different routing and account numbers than the prior quarter. The email looks legitimate, comes from the controller's known email address. The apprentice does not initiate the wire. Instead, calls the controller's direct office line (not the number in the email). The controller picks up — and is surprised. He never sent that email. His email had been compromised. The wire instructions in the email were fraudulent — the destination account belonged to a fraud ring. The apprentice's verification call stopped a $185,000 wire to criminals.", "discussion": "Email-based wire fraud is one of the largest current threat patterns. The protocol of verbally verifying any wire instruction change via known phone numbers is not paranoia. It is the industry standard for a reason. The five-minute call is worth it every single time."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Operational Risk in Account Administration",
        "summary": "Account administration is operational work, and operational work has its own risks. Knowing where errors and fraud typically arise lets you control them.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "The most expensive failures in retail advisory operations are usually not investment mistakes but operational ones — wrong account numbers, missing beneficiary updates, fraudulent wires, expired authorizations, mishandled distributions. The losses can be financial (the client loses money) or reputational (the firm loses trust) or regulatory (compliance failure becomes enforcement matter). Operational risk management is a discipline of identifying the failure modes and building processes that catch them before they cost."},
          {"type": "subheading", "content": "Common operational failure modes"},
          {"type": "list", "items": [
            "Beneficiary designations left stale through major life events (divorce, remarriage, death of designated beneficiary)",
            "Account titles not updated when the client's life circumstances change (single → married, individual → trust)",
            "Standing instructions running after they should have been terminated",
            "Authorization paperwork expired without renewal (some authorizations are time-limited)",
            "Custodial defaults left at suboptimal settings (FIFO cost basis on a taxable account, automatic DRIP on a position being managed for diversification)",
            "Linked external accounts no longer in use but still authorized for ACH",
            "Email-based fraud directing wires to fraudulent destinations",
            "Mistaken sending of personal information (PII) to wrong recipients",
            "Adviser personal trading conducted in violation of firm policy"
          ]},
          {"type": "subheading", "content": "The annual administrative review"},
          {"type": "paragraph", "content": "Once a year — typically at the annual review with the client or shortly before it — conduct an administrative review of every account in the household: titles and registrations match current circumstances; beneficiaries are current and percentages add to 100% for each category; standing instructions still appropriate; external bank account links still in use; cost basis method set correctly; insurance protections (FDIC sweep, SIPC limits) understood and appropriate. This review takes 15-20 minutes per household and catches dozens of small issues that compound over years."},
          {"type": "subheading", "content": "Process controls for the highest-risk operations"},
          {"type": "glossary", "terms": [
            {"term": "Two-person verification for large transfers", "definition": "Any wire over a firm-defined threshold (commonly $25K or $50K) requires verification by a second person before execution. Catches typos and detects social engineering."},
            {"term": "Call-back verification for new payment instructions", "definition": "Any new or changed payment instructions verified verbally with the client (not the email sender) using a known phone number. Industry standard for wire fraud prevention."},
            {"term": "Periodic beneficiary review", "definition": "Beneficiary designations reviewed at every annual client review and after every life event. Documented in the file."},
            {"term": "External account verification", "definition": "Linked external bank accounts re-verified annually; any not used in 12+ months are unlinked to reduce attack surface."},
            {"term": "Standing instruction expiration", "definition": "Time-limited standing instructions where appropriate, with automatic expiration prompting review and renewal."}
          ]},
          {"type": "subheading", "content": "Documentation as risk control"},
          {"type": "paragraph", "content": "Every administrative action — title change, beneficiary update, new authorization, standing instruction creation or termination — generates a record. The record protects the client (the change is what was intended) and protects the firm (we can prove what was authorized and when). Treat documentation as part of the action, not as paperwork after. The discipline from Module 17 extends to all administrative work."},
          {"type": "callout", "kind": "do", "content": "Every administrative change you make in a client account should generate (1) the actual change in the custodial system, (2) confirmation that the change took effect, (3) a record in the firm's CRM, and (4) communication to the client where appropriate. Submission is not completion; documentation is not optional."},
          {"type": "subheading", "content": "When something goes wrong"},
          {"type": "paragraph", "content": "When an operational error occurs — fraudulent wire, mishandled distribution, missing beneficiary — the response follows the same protocol as trade errors (Module 23): detect fast, disclose honestly, make the client whole, document, and improve the process. Operational errors are typically more visible to the client than investment errors (a wrong allocation might be invisible for years; a wrong wire shows up immediately). The transparency and speed of response defines the firm's character in these moments."},
          {"type": "case_study", "title": "The annual administrative review for Naomi", "scenario": "At Naomi's first annual review, the apprentice spends 20 minutes on administration in addition to the planning review. Findings: account titles current. Beneficiaries: primary beneficiary on Roth IRA still 'estate' (default from original opening — never updated). Contingent beneficiaries blank. The apprentice flags this immediately as the most important administrative item — updates Naomi's Roth IRA designations during the meeting (primary: her sister; contingent: her parents 50/50). External bank links: two old bank accounts linked from her prior employer's payroll, neither in current use — unlinked. Cost basis method: FIFO default on her taxable brokerage — switched to Specific Identification per Module 21 guidance. Standing instructions: monthly $1,500 to the Roth IRA, set up correctly. 20-minute review caught two material items and several smaller ones.", "discussion": "None of these were investment issues. All of them affect Naomi's outcomes. The beneficiary update alone could have been catastrophic in an unlikely-but-possible early-death scenario. The annual administrative review is what catches what the other reviews miss."},
          {"type": "callout", "kind": "key", "content": "Account administration is unglamorous, repetitive, detail-oriented work. It is also where the largest avoidable losses live. Build the systems and run them with discipline."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: Reconciliation & Operations Controls — the broader operational discipline that account administration sits within."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "In a typical RIA setup, the advisor:", "options": ["Holds the client's assets directly", "Provides advice and manages the portfolio while the custodian holds the assets — the separation is a structural fraud protection", "Also serves as the custodian", "Has no role in trading"], "correct": 1, "explanation": "Separation of advice and custody is a structural protection against fraud. Statements come from the custodian, not the advisor. This separation was hardened industry-wide after Madoff."},
        {"id": "q2", "prompt": "SIPC protection covers:", "options": ["Market losses on investments", "Broker-dealer failure up to $500,000 per customer per separate capacity (with a $250,000 cash sublimit)", "All forms of fraud", "Bank deposit losses"], "correct": 1, "explanation": "SIPC restores securities and cash held by failed member broker-dealers. It explicitly does not protect against investment losses from market movements."},
        {"id": "q3", "prompt": "FDIC insurance applies to:", "options": ["Money market mutual funds", "Brokerage cash balances at all custodians", "Bank deposits at FDIC-insured banks up to $250,000 per depositor per insured bank per ownership category", "Cryptocurrency holdings"], "correct": 2, "explanation": "FDIC covers bank deposits (checking, savings, CDs, bank money market deposit accounts) up to the limit per ownership category. Money market mutual funds are not FDIC-insured."},
        {"id": "q4", "prompt": "JTWROS (Joint Tenants with Rights of Survivorship) means:", "options": ["Each owner has a specified percentage that passes through their own estate", "Two owners with equal rights; at first owner's death, the account passes automatically to the surviving owner outside probate", "Property is community-owned by spouses", "The account is held in trust"], "correct": 1, "explanation": "JTWROS includes automatic survivorship — most common between spouses. Differs from Tenants in Common, where each owner's share passes through their own estate."},
        {"id": "q5", "prompt": "When wire instructions arrive by email — even from a known counterparty — the proper protocol is to:", "options": ["Initiate the wire immediately to maintain efficiency", "Verbally verify by phone using a previously-known number before initiating, regardless of how legitimate the email appears", "Reply to the email asking for confirmation", "Forward to compliance for approval"], "correct": 1, "explanation": "Email-based wire fraud is a leading current threat pattern. Verbal verification on a known number catches social engineering attacks that visual inspection of the email does not."},
        {"id": "q6", "prompt": "A Transfer-on-Death (TOD) designation on a brokerage account:", "options": ["Eliminates estate tax on the assets", "Names a beneficiary who receives the account directly at death, bypassing probate, superseding the will for those specific assets", "Requires court approval", "Cannot be changed once established"], "correct": 1, "explanation": "TOD is a probate-avoidance tool. It does not avoid estate tax, and it supersedes the will for those assets — so it must be coordinated with the overall estate plan."},
        {"id": "q7", "prompt": "A revocable living trust that names the grantor as trustee, with an account titled in the trust's name, is treated for tax purposes during the grantor's lifetime as:", "options": ["A separate tax entity with its own EIN and return", "The grantor's own account, taxed as theirs", "Tax-exempt", "An IRA"], "correct": 1, "explanation": "Revocable trusts are 'grantor trusts' for the grantor's lifetime — all income flows through to the grantor's individual return. After death the trust may become irrevocable and a separate tax entity."},
        {"id": "q8", "prompt": "ACH transfers between bank accounts are typically:", "options": ["Same-day, irreversible", "1-3 business days, reversible within a window, free at most custodians", "Free but only available for accounts under $10,000", "Faster than wires"], "correct": 1, "explanation": "ACH is the workhorse of routine money movement — slower than wires but reversible (within a window) and typically free."},
        {"id": "q9", "prompt": "Bernie Madoff's fraud was made possible partly because:", "options": ["He used licensed custodians", "He ran both the advisory firm and custody operations, allowing fabricated statements", "He was a fee-only advisor", "He invested only in ETFs"], "correct": 1, "explanation": "The lack of independent custody let Madoff produce statements showing assets that did not exist. The industry response was structural separation of custody from advice."},
        {"id": "q10", "prompt": "An annual administrative review of a client household should check, at minimum:", "options": ["Only the investment performance", "Account titles, beneficiaries, standing instructions, external account links, cost basis defaults, and applicable insurance protections", "Only the fees charged", "Only the tax situation"], "correct": 1, "explanation": "Administrative review is operational, not investment. Catching stale beneficiaries, expired authorizations, suboptimal defaults, and unused external account links prevents downstream problems."},
        {"id": "q11", "prompt": "Telling a client their investments are 'safe' or 'protected' is:", "options": ["Standard reassurance language", "A compliance and ethical issue because no investment is protected against market losses; precise language about specific insurance regimes is required", "Required by SEC rules", "Appropriate for conservative portfolios"], "correct": 1, "explanation": "Blanket safety language is misleading. SIPC and FDIC cover specific failures, not market losses; bad advice is a separate remedy path. Be precise about what each covers."},
        {"id": "q12", "prompt": "An estate plan with a revocable living trust where the brokerage account is still titled in the individual's name (never re-titled into the trust) means:", "options": ["The trust still controls the account", "The trust is funded automatically at death", "The account is not in the trust and will pass through probate via the will, not the trust", "Nothing — there is no difference"], "correct": 2, "explanation": "Trust funding requires actual re-titling of assets. A trust document without re-titled assets is a paper exercise; the assets pass through the probate process under the will."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 26;
