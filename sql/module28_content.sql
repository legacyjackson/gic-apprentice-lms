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
where module_number = 28;
