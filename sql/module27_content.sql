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
