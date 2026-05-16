-- ============================================================================
-- GIC APPRENTICE LMS — NEW LESSON CONTENT: Modules 1–8
-- Aligned to GIC Work Process titles and practical on-the-job tasks.
-- Run AFTER session8_module_realignment.sql
-- ============================================================================

-- ── MODULE 1: Client Intake & Discovery Interviews ────────────────────────
UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "What Discovery Is Actually For",
      "summary": "Discovery is not data collection. It is the foundation of every recommendation you will ever make.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Before you can recommend anything — a savings rate, an investment strategy, an insurance policy — you have to understand the person sitting across from you. Discovery is how you get there. It is not a form-filling exercise. It is a structured conversation that surfaces who someone is financially, where they want to go, and what is standing in their way." },
        { "type": "callout", "kind": "key", "title": "The purpose of the first meeting", "text": "You are not there to impress the client. You are there to understand them. The more you talk, the less you learn. The best advisors ask great questions and then get out of the way." },
        { "type": "heading", "text": "How to open the discovery meeting" },
        { "type": "paragraph", "text": "Set the agenda in the first two minutes. Tell the client exactly what you are going to do and why: <em>'Today I want to understand your full financial picture — where you are, where you want to go, and what concerns you most. From there we can figure out how to be most useful to you.'</em> This reduces anxiety, builds trust, and gives you permission to ask personal questions." },
        { "type": "heading", "text": "The three layers of discovery" },
        { "type": "numbered", "items": [
          "<strong>Financial facts</strong> — income, assets, liabilities, insurance, estate documents. What exists.",
          "<strong>Goals and priorities</strong> — what the client wants to accomplish and when. What matters.",
          "<strong>Values and concerns</strong> — what drives their decisions, what keeps them up at night. What is underneath the numbers."
        ]},
        { "type": "callout", "kind": "warn", "title": "The trap most new advisors fall into", "text": "Jumping to solutions before completing discovery. If you are thinking about what to recommend while the client is still talking, you are not listening. Recommendations come after understanding — never during." },
        { "type": "activity", "title": "Practice Opening a Discovery Meeting", "prompt": "Write the first 3 minutes of a discovery meeting script for a 42-year-old married client who was referred by a colleague. They have never worked with a financial advisor before.", "steps": [
          "Start with a brief introduction of yourself and the firm.",
          "Set the agenda: explain what today's meeting is for.",
          "Explain what the client can expect from the process.",
          "Ask your first open-ended question to begin the conversation.",
          "Read it aloud — does it sound natural, or does it sound like a script?"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Discovery Interview Framework",
      "summary": "A structured question sequence that surfaces everything you need without making the client feel interrogated.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "Discovery works best when it follows a logical sequence: start with the factual and concrete, then move to goals, then to values and concerns. This sequence builds psychological safety. Clients are more comfortable sharing their fears and frustrations after they have already shared their balance sheet." },
        { "type": "heading", "text": "The question sequence" },
        { "type": "numbered", "items": [
          "<strong>Situational questions</strong> — 'Walk me through your current income sources.' 'What accounts do you currently have?' These are easy to answer and warm the conversation.",
          "<strong>Goal questions</strong> — 'What are the two or three financial goals that matter most to you right now?' 'When do you hope to retire?' These get to the heart of the engagement.",
          "<strong>Priority questions</strong> — 'If we could only accomplish one thing together in the next 12 months, what would it be?' This reveals what is truly urgent.",
          "<strong>Concern questions</strong> — 'What keeps you up at night financially?' 'Is there anything about your situation that worries you that we haven't talked about?' These surface the emotional agenda.",
          "<strong>Experience questions</strong> — 'Have you worked with an advisor before? What worked well? What didn't?' This tells you how to serve them."
        ]},
        { "type": "heading", "text": "Active listening in practice" },
        { "type": "paragraph", "text": "Active listening is not just being quiet while the client talks. It means demonstrating that you are processing what they say: reflecting back ('So what I'm hearing is...'), asking follow-up questions ('You mentioned you're worried about your daughter's college costs — can you tell me more about that?'), and resisting the urge to fill silence. Silence is productive. Let it breathe." },
        { "type": "callout", "kind": "do", "title": "The note-taking balance", "text": "Take notes, but do not let your notepad become a barrier. Glance down to write, but maintain eye contact. If you are writing constantly, the client feels like they are being processed. If you write nothing, you will miss critical details." },
        { "type": "glossary", "terms": [
          { "term": "Open-ended question", "definition": "A question that cannot be answered with yes or no. Begins with 'what,' 'how,' 'tell me about,' or 'walk me through.' Opens the conversation." },
          { "term": "Closed question", "definition": "A question with a specific answer: 'Do you have a 401(k)?' Useful for confirming facts, not for discovery." },
          { "term": "Reflective listening", "definition": "Paraphrasing what the client said to confirm understanding and show you were paying attention." }
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Quantitative vs. Qualitative Discovery",
      "summary": "Numbers tell you position. Goals tell you direction. Values tell you why. You need all three.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two clients with identical balance sheets — the same net worth, the same income, the same portfolio — can have completely different financial plans. The difference is not in the numbers. It is in what those numbers are supposed to accomplish and what the person is willing to do to get there." },
        { "type": "heading", "text": "Quantitative discovery — the factual layer" },
        { "type": "list", "items": [
          "Current income: all sources, gross and net",
          "Assets: bank accounts, investment accounts, retirement accounts, real property, business interests",
          "Liabilities: mortgage, auto loans, student loans, credit card balances",
          "Insurance: life, disability, health, property, liability",
          "Estate documents: will, trust, POA, beneficiary designations"
        ]},
        { "type": "heading", "text": "Qualitative discovery — the goal and values layer" },
        { "type": "paragraph", "text": "Qualitative discovery is harder because it requires clients to reflect on what they actually want — not what they think they should want, not what their parents wanted for them, but what genuinely matters to them. This takes patience and skill. Many clients have never had a structured conversation about their financial values before." },
        { "type": "callout", "kind": "key", "title": "Translating vague goals into plannable objectives", "text": "'I want to be comfortable in retirement' is not plannable. 'I want $6,000 per month in after-tax income starting at age 65, adjusted for inflation, that I cannot outlive' is plannable. Your job is to ask enough questions to make the translation." },
        { "type": "activity", "title": "Goal Translation Exercise", "prompt": "Take each vague client statement below and write the follow-up questions you would ask to turn it into a specific, plannable objective.", "steps": [
          "'I want to take care of my kids.' — What does taking care of them mean? Education? Down payment help? Life insurance?",
          "'I want to retire someday.' — When? What will retirement look like? What income will you need?",
          "'I want to be debt-free.' — All debt, or just consumer debt? By when? How aggressively?",
          "'I want to grow my money.' — What is the purpose of the growth? What is the time horizon? What risk is acceptable?",
          "'I want financial security.' — What would security look like? What would have to be true for you to feel secure?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Documenting the Discovery Meeting",
      "summary": "A discovery conversation that isn't documented didn't happen. Here's how to capture it correctly.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Documentation is not a formality. It is what allows a colleague to pick up a client file and serve that client effectively. It is what protects you in a compliance examination. It is what the advisor uses to prepare for the next meeting. If it is not in writing, it does not count." },
        { "type": "heading", "text": "What to document from the discovery meeting" },
        { "type": "list", "items": [
          "Date, attendees, and meeting format (in-person, phone, video)",
          "Financial facts gathered: accounts, income, liabilities, insurance, estate documents",
          "Goals identified: specific, prioritized, with target dates where possible",
          "Concerns raised: what the client is worried about, what they want to avoid",
          "Action items: what the advisor committed to, what the client needs to provide",
          "Next steps and scheduled follow-up"
        ]},
        { "type": "heading", "text": "The CRM entry standard" },
        { "type": "paragraph", "text": "Every discovery meeting gets a CRM interaction log entry within 24 hours. The entry should be complete enough that someone who was not in the meeting could understand what happened and what comes next. Use the firm's interaction log template. Do not summarize so heavily that the record is useless." },
        { "type": "callout", "kind": "do", "title": "The follow-up email", "text": "Send the client a follow-up email within 24 hours summarizing what was discussed, what you need from them, and the next step. This confirms their understanding, creates a paper trail, and demonstrates professionalism. Use a template but personalize it." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Common Discovery Challenges",
      "summary": "Not every discovery meeting goes smoothly. Here's how to handle the situations that trip up new advisors.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Discovery is a skill that improves with repetition. Even experienced advisors encounter challenging clients. The difference is that experienced advisors have learned to recognize the pattern and respond professionally rather than freeze or improvise poorly." },
        { "type": "case_study", "title": "The Reluctant Sharer", "scenario": "A client agrees to the meeting but gives one-word answers and seems uncomfortable discussing finances. 'I just want someone to manage my money. I don't see why I have to share all of this.' How do you respond?", "discussion": "Acknowledge the discomfort directly: 'I understand that talking about finances can feel personal — it is personal. The reason I ask these questions is that without understanding your full situation, I can't give you advice I can actually stand behind. I'm not asking to be intrusive. I'm asking because I want to get it right.' Then slow down, ask smaller questions, and build trust gradually." },
        { "type": "case_study", "title": "The Spouse Who Won't Engage", "scenario": "A couple comes in for discovery. One spouse is engaged and answering questions. The other is checking their phone and giving minimal responses. This matters because financial planning is a household exercise.", "discussion": "Direct a question specifically to the quieter spouse — something non-threatening and specific to them: 'From your perspective, what would make this year feel like a financial success?' Make them feel that their input matters and that you are working for both of them, not just the one who made the appointment." },
        { "type": "case_study", "title": "The Client Who Doesn't Know Their Own Numbers", "scenario": "You ask about household income and the client says 'I'm not sure exactly — somewhere around $200,000?' They don't know their account balances, their mortgage balance, or what they have in their 401(k).", "discussion": "This is more common than it sounds. Don't make them feel embarrassed. Normalize it: 'That's completely fine — most people don't have these numbers memorized. Let me give you a document checklist and we'll get exact figures from your statements.' Then work with estimated numbers for now and refine as documents come in." },
        { "type": "callout", "kind": "note", "title": "The skill that takes longest to develop", "text": "Comfortable silence. Most new advisors rush to fill a pause after a question. But silence often means the client is processing something important. Give them 5-10 seconds before you speak again. What comes after a pause is often the most important thing they say." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the primary purpose of a client discovery meeting?", "options": ["To understand the client's full financial situation, goals, and values before making any recommendations", "To present the firm's investment products and services", "To complete the required KYC documentation for compliance", "To determine how much the client can afford to invest"], "correct": 0, "explanation": "Discovery is about understanding before recommending. Recommendations made without complete discovery are guesswork." },
      { "id": "q2", "text": "In what order should discovery questions typically be asked?", "options": ["Factual/situational questions first, then goals, then values and concerns", "Values and concerns first, then goals, then facts", "Goals first, then facts, then values", "All at the same time using a structured questionnaire"], "correct": 0, "explanation": "Starting with factual questions builds psychological safety before asking more personal questions about values and concerns." },
      { "id": "q3", "text": "A client says 'I want to be comfortable in retirement.' What is the advisor's best next step?", "options": ["Ask follow-up questions to translate this into a specific, plannable objective", "Note the goal as stated and move on to other topics", "Recommend a retirement income annuity", "Explain that 'comfortable' is too vague to plan around"], "correct": 0, "explanation": "Vague goals must be translated into specific, measurable objectives before planning can begin. Follow-up questions are the tool." },
      { "id": "q4", "text": "What should the CRM interaction log entry from a discovery meeting include?", "options": ["Date, attendees, financial facts gathered, goals identified, concerns raised, and action items", "Only the client's account balances and investment preferences", "A summary of the advisor's recommendations", "The client's personal background and family history"], "correct": 0, "explanation": "Complete documentation allows any team member to serve the client effectively and satisfies compliance requirements." },
      { "id": "q5", "text": "A client answers questions with one-word responses and seems uncomfortable. What is the best approach?", "options": ["Acknowledge the discomfort directly, explain why the questions matter, then ask smaller, less threatening questions", "Skip the discovery and move to investment recommendations", "End the meeting and reschedule", "Have the client fill out a written questionnaire instead"], "correct": 0, "explanation": "Normalizing the discomfort and explaining the purpose of discovery builds trust. Skipping discovery leads to poor advice." },
      { "id": "q6", "text": "Which type of question is most effective for opening a discovery conversation?", "options": ["An open-ended question that cannot be answered with yes or no", "A closed question about current account balances", "A multiple-choice question about risk tolerance", "A yes/no question about whether the client has a will"], "correct": 0, "explanation": "Open-ended questions invite the client to share their full perspective and open the conversation naturally." },
      { "id": "q7", "text": "Within how long should a follow-up email and CRM entry be completed after a discovery meeting?", "options": ["Within 24 hours", "Within one week", "Before the next client meeting", "Only when the client requests it"], "correct": 0, "explanation": "24 hours is the professional standard. It confirms understanding, creates an audit trail, and demonstrates reliability." },
      { "id": "q8", "text": "A spouse in a couple's meeting is disengaged and checking their phone. What should the advisor do?", "options": ["Direct a specific, non-threatening question to the quieter spouse to make them feel included", "Focus on the engaged spouse and follow up with the other separately", "Note the engagement level and continue the meeting", "Ask the engaged spouse to encourage their partner to participate"], "correct": 0, "explanation": "Financial planning affects both partners. The advisor must engage both. A direct, personal question signals that their input matters." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 1;

-- ── MODULE 2: Gathering & Organizing Financial Documents ──────────────────
UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Document Universe",
      "summary": "Every financial planning engagement starts with documents. Know what you need, why you need it, and what is missing.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "You cannot build an accurate financial plan from what clients tell you from memory. Memory is selective, imprecise, and optimistic. Documents are authoritative. The discipline of gathering and organizing the right documents before analysis begins is the foundation of every accurate plan." },
        { "type": "heading", "text": "The core document set" },
        { "type": "glossary", "terms": [
          { "term": "Tax returns (2 years)", "definition": "Shows actual income, deductions, investment activity, business income, and tax liability. More reliable than a pay stub for complex income situations." },
          { "term": "Pay stubs (most recent)", "definition": "Confirms current gross income, tax withholding, benefits deductions, and retirement contributions. Use the YTD column for annualized figures." },
          { "term": "Investment account statements", "definition": "Shows holdings, balances, cost basis, dividends, and realized gains. Request the most recent quarter-end statement for each account." },
          { "term": "Retirement account statements", "definition": "401(k), 403(b), IRA, Roth IRA — each account separately. Shows balance, contribution rate, investment elections, and vesting schedule if applicable." },
          { "term": "Mortgage statement", "definition": "Shows current balance, interest rate, remaining term, and monthly payment. Essential for cash flow analysis and net worth calculation." },
          { "term": "Life and disability insurance policies", "definition": "Shows coverage amounts, premiums, beneficiaries, and policy type. Many clients cannot describe their own coverage accurately." },
          { "term": "Social Security statement", "definition": "Shows estimated benefit at various claiming ages based on earnings history. Available at ssa.gov. Critical for retirement planning." },
          { "term": "Estate planning documents", "definition": "Will, trust agreement, power of attorney, healthcare directive. Without reviewing these, beneficiary and ownership structures are unknown." }
        ]},
        { "type": "callout", "kind": "warn", "title": "What clients think they need vs. what you actually need", "text": "Clients often bring account statements but forget tax returns. They describe their insurance but cannot produce the policy. They know they have a will but haven't seen it in ten years. Build your checklist around documents, not client memory." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Building and Using a Document Checklist",
      "summary": "A well-built checklist is the difference between a complete file and an expensive mistake.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The document checklist is one of the most important tools in the advisory practice. Used correctly, it ensures nothing is missed. Used poorly — or not at all — it creates gaps that produce inaccurate analysis, bad recommendations, and compliance exposure." },
        { "type": "heading", "text": "Building the checklist" },
        { "type": "paragraph", "text": "The master checklist includes every document category. The client-specific checklist is customized at the start of each engagement: if the client has no business income, remove the business tax return. If they are renters, remove the mortgage statement. Customization reduces client overwhelm and improves response rate." },
        { "type": "heading", "text": "Tracking collection status" },
        { "type": "list", "items": [
          "<strong>Requested</strong> — you have asked for it, it has not arrived",
          "<strong>Received</strong> — you have it in hand",
          "<strong>Verified</strong> — you have confirmed it is complete and current",
          "<strong>N/A</strong> — not applicable for this client"
        ]},
        { "type": "callout", "kind": "do", "title": "The two-week follow-up rule", "text": "If a document has been requested and not received in two weeks, follow up. Use the checklist to identify what is outstanding. Clients are busy, not uncooperative. A friendly reminder with a specific list of what is missing gets results." },
        { "type": "activity", "title": "Build a Client Document Checklist", "prompt": "For a 48-year-old married client with W-2 income, a 401(k), two taxable investment accounts, a mortgage, and term life insurance, build a complete document checklist.", "steps": [
          "List every document category that applies to this client.",
          "For each document, specify the version needed (most recent, prior two years, etc.).",
          "Add a status column: Requested / Received / Verified / N/A.",
          "Identify two documents that clients in this situation most commonly forget or delay.",
          "Write the email you would send requesting these documents, with the checklist attached."
        ]}
      ]
    },
    {
      "id": "lesson-3",
      "title": "Verifying What You Receive",
      "summary": "Receiving a document is not the same as having usable information. Learn to read each document critically.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "Documents are only useful if you can read them correctly. A brokerage statement, a tax return, and a pay stub each have a specific structure. Knowing where to find the numbers you need — and recognizing when something looks wrong — is a core skill." },
        { "type": "heading", "text": "Reading a brokerage statement" },
        { "type": "list", "items": [
          "Account summary: total value, cash position, market value of securities",
          "Holdings detail: each position, shares held, current price, market value, cost basis",
          "Transaction history: buys, sells, dividends, interest, fees during the period",
          "Performance: portfolio return for the period — check the benchmark comparison"
        ]},
        { "type": "heading", "text": "Reading a pay stub" },
        { "type": "paragraph", "text": "The pay stub tells you three critical things: gross income (what the client earns), net income (what actually hits the bank account), and what is being withheld (taxes, retirement contributions, health insurance, HSA contributions). The YTD columns are more reliable than a single pay period for annualizing." },
        { "type": "callout", "kind": "warn", "title": "Red flags in documents", "text": "Large unexplained deposits or withdrawals on bank statements. Cost basis labeled as 'N/A' on investment statements (may indicate inherited assets or very old holdings). Life insurance premiums that seem disproportionately high for the coverage amount. Beneficiary designations that name an estate rather than a person. Each of these requires follow-up before analysis proceeds." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Organizing Files for Planning and Compliance",
      "summary": "Organization is not just for your convenience — it is a compliance requirement and a client service standard.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A disorganized client file is a liability. It slows down planning, creates errors, and fails compliance review. The time invested in organizing documents at intake pays dividends every time the file is touched." },
        { "type": "heading", "text": "The standard folder structure" },
        { "type": "numbered", "items": [
          "01 — Discovery & Intake (questionnaires, meeting notes, signed agreements)",
          "02 — Financial Documents (tax returns, statements, pay stubs, insurance policies)",
          "03 — Planning Work (analysis, scenarios, plan drafts)",
          "04 — Client Communications (emails, letters, follow-ups)",
          "05 — Compliance (signed disclosures, ADV receipts, suitability documentation)"
        ]},
        { "type": "callout", "kind": "note", "title": "Version control matters", "text": "When you receive an updated document — a new tax return, a revised account statement — do not delete the old one. Rename it with the date and keep it. Compliance examinations sometimes ask for historical documents. Deleting superseded files can create problems." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Requesting Documents Professionally",
      "summary": "How you ask for documents affects whether you get them. Tone, timing, and specificity all matter.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients do not always prioritize document gathering. They are busy, the task feels tedious, and they are not sure exactly what you need. Your job is to make it easy. A clear, specific, friendly request gets a faster response than a vague, formal one." },
        { "type": "heading", "text": "Elements of an effective document request" },
        { "type": "list", "items": [
          "<strong>Specific list</strong> — name each document, not just 'financial documents'",
          "<strong>Why it matters</strong> — one sentence explaining what you use each document for",
          "<strong>Format flexibility</strong> — 'A photo or PDF is fine' reduces friction",
          "<strong>Clear deadline</strong> — 'By Friday so we can begin analysis next week'",
          "<strong>Easy submission method</strong> — secure email, client portal, in-person"
        ]},
        { "type": "callout", "kind": "do", "title": "The follow-up without nagging", "text": "If documents haven't arrived after two weeks: 'Hi [Name], I wanted to follow up on the document list I sent. We're ready to begin your analysis as soon as we receive these three items — your most recent tax return, your 401(k) statement, and your life insurance policy. Happy to answer any questions about what we need or why.' Friendly, specific, forward-looking." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why are client documents more reliable than client memory for financial planning?", "options": ["Documents are authoritative and precise while memory is selective and often inaccurate", "Documents are required by regulation but memory is not", "Clients refuse to provide memory-based information", "Documents are easier to organize in the CRM"], "correct": 0, "explanation": "Memory is selective and optimistic. Actual tax returns, statements, and policy documents reflect reality. Plans built on documented facts are more accurate." },
      { "id": "q2", "text": "What does a Social Security statement show that is critical for retirement planning?", "options": ["Estimated benefit amounts at various claiming ages based on the client's actual earnings history", "The client's current Medicare eligibility status", "Required minimum distribution amounts", "The client's lifetime contribution history to Social Security"], "correct": 0, "explanation": "The SSA statement shows projected benefits at age 62, full retirement age, and 70. This is essential data for retirement income modeling." },
      { "id": "q3", "text": "Which document status means the document has been confirmed as complete and current?", "options": ["Verified", "Received", "Requested", "Reviewed"], "correct": 0, "explanation": "Received means it arrived. Verified means you confirmed it is complete, current, and usable. Both steps are required before using a document in analysis." },
      { "id": "q4", "text": "On a pay stub, which column is most useful for calculating annualized income?", "options": ["Year-to-date (YTD) column, which accumulates across all pay periods", "The current pay period column", "The gross pay line only", "The net pay line"], "correct": 0, "explanation": "The YTD column accumulates across all pay periods, making it more reliable for annualizing income than a single pay period figure." },
      { "id": "q5", "text": "A client's brokerage statement shows cost basis labeled as 'N/A' for several positions. What does this most likely indicate?", "options": ["Inherited assets or very old holdings where cost basis was not transferred", "The account was opened this year and no positions have been sold", "The client has elected not to report cost basis", "An error in the statement that should be ignored"], "correct": 0, "explanation": "N/A cost basis often signals inherited assets or positions transferred from old accounts where the original cost was not reported. This requires follow-up before analyzing gains." },
      { "id": "q6", "text": "What is the primary reason for maintaining the standard folder structure in client files?", "options": ["It allows any team member to find documents quickly and satisfies compliance documentation requirements", "It is required by SEC regulations for all RIA client files", "It makes it easier to send documents to clients", "It reduces storage costs for the firm"], "correct": 0, "explanation": "Consistent organization serves both efficiency (anyone can work the file) and compliance (examiners can find what they need)." },
      { "id": "q7", "text": "When a client provides an updated tax return, what should happen to the prior year's return?", "options": ["Rename it with the date and retain it — historical documents may be needed for compliance review", "Delete it since it is no longer current", "Move it to the client's personal folder outside the main filing system", "Return it to the client"], "correct": 0, "explanation": "Version control requires retaining superseded documents. Compliance examinations sometimes request historical records. Deleting old files creates risk." },
      { "id": "q8", "text": "What should a professional document request email include?", "options": ["A specific list of documents needed, why each matters, the format accepted, a clear deadline, and how to submit", "A general request for 'all financial documents'", "A list of what the advisor will do with the documents once received", "A formal letter on firm letterhead"], "correct": 0, "explanation": "Specific, clear document requests with reasons and deadlines get faster responses than vague requests. Reducing client friction speeds up the planning process." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 2;

-- ── MODULE 3: Cash Flow & Budgeting Analysis ──────────────────────────────
UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Building the Cash Flow Statement",
      "summary": "Cash flow is the engine of every financial plan. Learn to construct it from documents, not estimates.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow statement answers one question: does more money come in than go out each month — and by how much? The answer determines what is possible. Without a clear cash flow picture, savings goals, debt payoff plans, and investment strategies are built on guesswork." },
        { "type": "heading", "text": "Income: start with net, not gross" },
        { "type": "paragraph", "text": "Gross income is what clients earn. Net income is what they can spend. Every budgeting conversation must happen in net terms. When a client says 'I make $120,000 a year,' your first question is always: 'Is that gross or net?' The difference can be $30,000 or more after taxes, retirement contributions, and benefit deductions." },
        { "type": "heading", "text": "Three categories of expenses" },
        { "type": "glossary", "terms": [
          { "term": "Fixed expenses", "definition": "Same amount every month: rent or mortgage, car payment, insurance premiums, loan payments, subscriptions. Predictable and contractual." },
          { "term": "Variable expenses", "definition": "Change month to month: groceries, gas, dining, entertainment, clothing. Harder to track, easier to reduce." },
          { "term": "Periodic expenses", "definition": "Real expenses that don't occur monthly: annual insurance premiums, property taxes, car registration, holiday gifts, medical costs, home maintenance. The most commonly forgotten category — and the one that breaks most budgets." }
        ]},
        { "type": "callout", "kind": "key", "title": "The periodic expense problem", "text": "Most household budgeting failures trace back to forgetting periodic expenses. A client who 'has $800 left at the end of every month' may actually be running a deficit when you account for the $1,200 car registration in March, the $2,400 property tax payment in December, and the $3,000 holiday spending. Always ask: 'What expenses come up that aren't monthly?'" },
        { "type": "activity", "title": "Build a Cash Flow Statement", "prompt": "Using the information below, build a complete monthly cash flow statement and calculate net cash flow.", "steps": [
          "Gross income: $95,000/year. After taxes, 401(k) contribution (6%), and health insurance ($280/month), net monthly income = ?",
          "Fixed expenses: $2,200 mortgage, $450 car payment, $180 insurance, $90 subscriptions.",
          "Variable expenses: $600 groceries, $200 gas, $350 dining, $150 entertainment.",
          "Periodic expenses (monthly equivalent): $150 property tax, $80 car registration, $200 home maintenance reserve, $100 holiday/gifts.",
          "Calculate total monthly expenses and net cash flow (income minus expenses).",
          "Is this household in surplus or deficit? What would change if the car payment ended in 6 months?"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Finding the Gap — Surplus vs. Deficit",
      "summary": "The cash flow that looks fine from the outside often isn't. Learn to find the real number.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients frequently believe their cash flow is positive because they have not explicitly tracked where the money goes. Credit card debt that grows slowly, savings that barely move, and account balances that never quite improve — these are the symptoms of a cash flow problem that has not been diagnosed." },
        { "type": "heading", "text": "The proof is in the accounts" },
        { "type": "paragraph", "text": "If a client says they have $500 left at the end of every month but their savings account grew by only $1,200 last year, the math does not work. ($500 × 12 = $6,000 expected savings vs. $1,200 actual.) The gap is the spending that wasn't tracked. This discrepancy is your most powerful diagnostic tool." },
        { "type": "callout", "kind": "warn", "title": "The lifestyle inflation trap", "text": "Incomes rise. Expenses follow immediately. Every raise, bonus, or promotion is absorbed by a bigger car, a bigger house, a nicer vacation. This is normal human behavior. The cash flow analysis makes it visible so the client can make a conscious choice about it." },
        { "type": "callout", "kind": "do", "title": "Present findings, not judgments", "text": "When you find a spending gap: 'Looking at your cash flow, there's a difference between what you tell me should be left over and what's actually accumulating. Let's figure out where that gap is.' Not: 'You're overspending.' One opens a problem-solving conversation. The other creates defensiveness." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Budgeting Frameworks",
      "summary": "There is no universal budget. Learn which framework fits which client — and how to present it.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The best budget is the one the client will actually use. A technically perfect zero-based budget that a client abandons after three weeks is worse than a simple framework they stick with for years. Match the framework to the client." },
        { "type": "heading", "text": "The 50/30/20 framework" },
        { "type": "paragraph", "text": "50% of net income to needs (housing, food, transportation, utilities), 30% to wants (dining, entertainment, travel, hobbies), 20% to savings and debt repayment. Simple enough for clients who resist budgeting detail. Not precise enough for clients with complex situations or significant debt." },
        { "type": "heading", "text": "Zero-based budgeting" },
        { "type": "paragraph", "text": "Every dollar of income is assigned a category until the balance is zero. More rigorous, more powerful, and more difficult to maintain. Best for clients who are in debt, who have tried other approaches without success, or who genuinely want to optimize their cash flow." },
        { "type": "callout", "kind": "key", "title": "The spending plan vs. the restriction plan", "text": "Call it a spending plan, not a budget. 'Budget' carries a connotation of restriction and sacrifice. A spending plan is about intention — deciding in advance where the money goes rather than wondering afterward where it went. Framing matters." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Cash Flow as a Planning Tool",
      "summary": "Every goal in the financial plan gets funded from surplus cash flow. Here's how to use it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow statement is not just a diagnostic tool. It is the mechanism by which financial goals get funded. Every dollar of surplus cash flow is a dollar that can go toward savings, debt reduction, emergency fund building, or investment. The sequence matters." },
        { "type": "heading", "text": "Cash flow funding sequence" },
        { "type": "numbered", "items": [
          "Emergency fund first — 3-6 months of fixed expenses in liquid savings",
          "Employer 401(k) match — free money that should not be left on the table",
          "High-interest debt elimination — any debt above 6-7% interest rate",
          "Additional retirement contributions — maxing tax-advantaged accounts",
          "Other financial goals — education savings, home down payment, taxable investment"
        ]},
        { "type": "callout", "kind": "note", "title": "Debt payoff sequencing", "text": "The mathematically optimal approach is avalanche method: pay minimums on all debt, put extra toward the highest interest rate first. The behaviorally effective approach is snowball method: pay off the smallest balance first for motivational wins. Know both and match the method to the client." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Presenting Cash Flow Findings to Clients",
      "summary": "How you share the cash flow analysis determines whether the client acts on it or gets defensive.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The cash flow conversation is emotionally loaded. People have feelings about money — shame, pride, anxiety, defensiveness. How you present the findings determines whether the conversation becomes productive or shuts down." },
        { "type": "heading", "text": "Language that opens vs. language that closes" },
        { "type": "list", "items": [
          "<strong>Opens:</strong> 'Here's what your cash flow tells us about what's possible.' <strong>Closes:</strong> 'You're spending too much on dining out.'",
          "<strong>Opens:</strong> 'There's a gap between your income and your savings rate. Let's figure out what's driving it.' <strong>Closes:</strong> 'You're not saving enough.'",
          "<strong>Opens:</strong> 'If we redirect $400/month, here's what changes in 10 years.' <strong>Closes:</strong> 'You need to cut back on your lifestyle.'"
        ]},
        { "type": "callout", "kind": "do", "title": "Show the impact, not the sacrifice", "text": "Clients don't want to cut spending. They want to achieve goals. Show them what redirecting cash flow makes possible — a paid-off mortgage in 12 years instead of 22, a retirement at 62 instead of 67, a fully funded college education — and the sacrifice becomes a trade, not a loss." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "Why must cash flow analysis be conducted in net income terms rather than gross income?", "options": ["Net income is what the client actually has available to spend and save after taxes and deductions", "Gross income is harder to verify from documents", "Regulators require net income for financial planning", "Gross income varies too much month to month"], "correct": 0, "explanation": "Gross income is what clients earn. Net income is what they can actually deploy. Budgeting from gross figures leads to systematic overestimation of available cash." },
      { "id": "q2", "text": "Which category of expenses is most commonly forgotten in cash flow analysis?", "options": ["Periodic expenses — real costs that don't occur monthly but are predictable", "Fixed expenses like rent and mortgage payments", "Variable expenses like groceries and gas", "Investment contributions"], "correct": 0, "explanation": "Periodic expenses (annual insurance, property taxes, seasonal spending) break most budgets because they are real but not monthly. Always ask clients about non-monthly expenses." },
      { "id": "q3", "text": "A client says they have $600 left at the end of each month but their savings grew by only $900 last year. What does this suggest?", "options": ["There is approximately $6,300 of untracked spending — the gap between expected and actual savings", "The client made a large purchase during the year", "The client's income decreased during the year", "The savings account interest rate is dragging down the balance"], "correct": 0, "explanation": "$600 × 12 = $7,200 expected. $900 actual. The $6,300 gap represents spending that wasn't tracked. This is a powerful diagnostic finding." },
      { "id": "q4", "text": "What is the correct order for allocating surplus cash flow in a financial plan?", "options": ["Emergency fund, employer match, high-interest debt, additional retirement savings, other goals", "Investments first, then emergency fund, then debt", "Debt elimination first, then all savings goals simultaneously", "Retirement savings first regardless of other factors"], "correct": 0, "explanation": "The sequence matters. Emergency fund prevents new debt. Employer match is free money. High-interest debt has a guaranteed return equal to the interest rate. Then long-term goals." },
      { "id": "q5", "text": "What does the 50/30/20 budgeting framework allocate to savings and debt repayment?", "options": ["20% of net income", "30% of net income", "50% of net income", "It does not specify a savings allocation"], "correct": 0, "explanation": "50% to needs, 30% to wants, 20% to savings and debt repayment. Simple and memorable, though not precise enough for complex situations." },
      { "id": "q6", "text": "Why is calling it a 'spending plan' rather than a 'budget' recommended when working with clients?", "options": ["It reframes the exercise as intentional decision-making rather than restriction, which improves client engagement", "The term 'budget' is technically incorrect in financial planning", "Clients prefer longer terminology", "Regulators require the term 'spending plan'"], "correct": 0, "explanation": "Framing matters. 'Budget' implies restriction and sacrifice. 'Spending plan' implies intention and control. Clients are more likely to engage with the latter." },
      { "id": "q7", "text": "What is the mathematically optimal debt payoff method?", "options": ["Avalanche method: pay minimums on all debts, put extra toward highest interest rate first", "Snowball method: pay off smallest balance first", "Equal extra payments across all debts", "Minimum payments on all debts while maximizing investments"], "correct": 0, "explanation": "The avalanche method minimizes total interest paid by attacking the highest rate first. The snowball method is behaviorally superior for some clients but mathematically less efficient." },
      { "id": "q8", "text": "When presenting cash flow findings that show overspending in a specific category, what is the most effective approach?", "options": ["Frame it as what redirecting that cash flow makes possible, not what the client is doing wrong", "Show the client exactly how much they spent in each category with a detailed breakdown", "Compare the client's spending to national averages in each category", "Recommend specific spending cuts in problem categories"], "correct": 0, "explanation": "Clients respond to possibility, not judgment. Showing what a cash flow redirect achieves — years off a mortgage, earlier retirement — converts the sacrifice into a trade." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 3;

-- ── MODULES 4-8: Titles and structure maintained, core content provided ───

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Retirement Income Problem",
      "summary": "Retirement is the most complex planning challenge most clients face. Start with the income question.",
      "read_time": "12 min read",
      "blocks": [
        { "type": "paragraph", "text": "The fundamental challenge of retirement planning is not accumulation — it is income. A client who retires at 65 and lives to 90 needs 25 years of income from a pool of assets that is no longer being replenished. The question is not 'how much do you have?' It is 'how long will it last, and what happens if it doesn't?'" },
        { "type": "heading", "text": "The three sources of retirement income" },
        { "type": "list", "items": [
          "<strong>Social Security</strong> — guaranteed, inflation-adjusted, but rarely sufficient alone",
          "<strong>Pension or annuity income</strong> — guaranteed income that fewer clients have than a generation ago",
          "<strong>Portfolio withdrawals</strong> — from 401(k), IRA, and taxable accounts — the variable, depletable source"
        ]},
        { "type": "callout", "kind": "key", "title": "The inflation problem", "text": "At 3% annual inflation, $1 today buys $0.74 worth of goods in 10 years and $0.55 in 20 years. A client who needs $6,000/month at 65 will need approximately $8,100/month at 75 and $10,900/month at 85 to maintain the same purchasing power. Plans that ignore inflation are dangerously optimistic." },
        { "type": "heading", "text": "Calculating the retirement income need" },
        { "type": "paragraph", "text": "The replacement rate method: estimate that the client needs 70-85% of pre-retirement income. This is a rough approximation — adequate for a first conversation but not for a plan. The expense-based method is more accurate: project actual retirement expenses category by category (housing, healthcare, travel, food, insurance), then add an inflation buffer." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Social Security — Timing and Strategy",
      "summary": "Social Security claiming decisions are permanent. Most clients make them without analysis.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Social Security is the most underanalyzed decision most clients make. The claiming age determines the benefit amount for life. Taking benefits at 62 versus waiting until 70 can mean a 77% difference in monthly income. For a couple, the coordination of claiming strategies adds another layer of complexity." },
        { "type": "heading", "text": "The three claiming ages" },
        { "type": "glossary", "terms": [
          { "term": "Age 62 (earliest)", "definition": "Benefit is permanently reduced by 25-30% compared to full retirement age. Available immediately but locks in a lower amount for life." },
          { "term": "Full retirement age (66-67)", "definition": "Depends on birth year. The baseline benefit with no reduction or delayed credit." },
          { "term": "Age 70 (maximum)", "definition": "Delayed retirement credits add 8% per year after full retirement age. Maximum possible benefit." }
        ]},
        { "type": "callout", "kind": "key", "title": "The break-even analysis", "text": "Delaying Social Security means forgoing years of benefits in exchange for higher monthly payments later. The break-even point — when the cumulative total from delayed claiming catches up to the total from early claiming — is typically age 78-82. Clients in good health with longevity in their family have good reason to delay." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Retirement Accounts and Their Roles",
      "summary": "Know the vehicles before you discuss strategy. Each account has different rules and planning implications.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every client will have one or more retirement accounts. Knowing the rules for each — contribution limits, tax treatment, required distributions, withdrawal penalties — is a prerequisite for retirement planning, not an advanced skill." },
        { "type": "glossary", "terms": [
          { "term": "Traditional 401(k)", "definition": "Pre-tax contributions reduce current taxable income. Growth is tax-deferred. Withdrawals in retirement are taxed as ordinary income. RMDs begin at age 73." },
          { "term": "Roth 401(k)", "definition": "After-tax contributions. Growth and qualified withdrawals are tax-free. Same contribution limits as Traditional. No RMDs during the owner's lifetime." },
          { "term": "Traditional IRA", "definition": "May be tax-deductible depending on income and employer plan coverage. Tax-deferred growth. RMDs at 73. Backdoor Roth conversion strategy for high earners." },
          { "term": "Roth IRA", "definition": "After-tax contributions. Tax-free growth and qualified withdrawals. No RMDs. Income limits apply for direct contributions." },
          { "term": "SEP-IRA", "definition": "For self-employed and small business owners. Higher contribution limits than traditional IRA. Employer contributions only." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The Roth vs. Traditional decision", "text": "The core question: will the client be in a higher or lower tax bracket in retirement than today? If higher in retirement (young, low income now, expecting higher income later) — Roth. If lower in retirement (high income now, lower expected in retirement) — Traditional. If uncertain — split the contributions." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Building a Retirement Scenario",
      "summary": "Turn the analysis into a client-ready scenario that shows the path forward.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "A retirement scenario is not a projection of what will happen. It is a model of what could happen under specified assumptions. The assumptions must be documented, defensible, and explained to the client. The scenario is a planning tool, not a forecast." },
        { "type": "heading", "text": "Key assumptions to document" },
        { "type": "list", "items": [
          "Retirement age and retirement date",
          "Pre-retirement savings rate and account growth assumption",
          "Social Security claiming age and estimated benefit",
          "Estimated retirement spending (monthly, inflation-adjusted)",
          "Portfolio withdrawal rate in retirement",
          "Life expectancy assumption (usually plan to age 90 or 95 for conservative modeling)"
        ]},
        { "type": "activity", "title": "Sensitivity Analysis Exercise", "prompt": "Take a basic retirement scenario and model how changes in key variables affect the outcome.", "steps": [
          "Base case: retire at 65, 7% pre-retirement return, 4% withdrawal rate, plan to 90.",
          "Scenario 2: retire at 63 instead of 65. How does this change portfolio depletion?",
          "Scenario 3: portfolio returns are 5% instead of 7%. What changes?",
          "Scenario 4: client lives to 95 instead of 90. Is the portfolio sufficient?",
          "Which variable has the biggest impact on the outcome? What does this tell the client about their greatest risk?"
        ]}
      ]
    },
    {
      "id": "lesson-5",
      "title": "Documenting and Presenting Retirement Analysis",
      "summary": "The analysis is only useful if the client understands it and can act on it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Retirement scenarios can become technical very quickly. The advisor's job is to make the analysis legible to the client — not to show the full complexity of the model, but to answer the three questions clients actually care about: Am I on track? What do I need to change? What happens if things don't go as planned?" },
        { "type": "callout", "kind": "do", "title": "The three-question framework", "text": "<strong>1. Am I on track?</strong> A simple yes or no, with context. <strong>2. What needs to change?</strong> Specific, actionable — savings rate, retirement date, spending in retirement. <strong>3. What are my risks?</strong> The scenarios that could derail the plan — longevity, poor returns, unexpected health costs — and how to mitigate them." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "At 3% annual inflation, approximately what does $1 of purchasing power today become in 20 years?", "options": ["About $0.55", "About $0.75", "About $0.90", "About $0.85"], "correct": 0, "explanation": "At 3% inflation, purchasing power erodes to approximately $0.55 over 20 years. Plans that ignore inflation significantly underestimate retirement income needs." },
      { "id": "q2", "text": "What is the primary advantage of delaying Social Security claiming to age 70?", "options": ["Delayed retirement credits add 8% per year after full retirement age, resulting in the maximum possible monthly benefit", "The benefit becomes tax-free after age 70", "Medicare coverage begins automatically at 70 regardless of enrollment", "The benefit increases with inflation only after age 70"], "correct": 0, "explanation": "Delayed retirement credits increase the benefit by 8% per year from full retirement age to age 70. For clients in good health, this can be highly valuable." },
      { "id": "q3", "text": "When does a Traditional 401(k) require minimum distributions to begin?", "options": ["Age 73", "Age 70½", "Age 65", "Age 59½"], "correct": 0, "explanation": "The SECURE 2.0 Act moved the RMD starting age to 73. Failure to take RMDs results in a 25% excise tax on the amount not withdrawn." },
      { "id": "q4", "text": "In a retirement scenario, what is the purpose of documenting assumptions?", "options": ["To make the analysis defensible, transparent, and adjustable as circumstances change", "To satisfy regulatory requirements for retirement projections", "To show clients the complexity of the modeling process", "To set a legally binding expectation of future portfolio performance"], "correct": 0, "explanation": "Documented assumptions make the scenario auditable, allow for sensitivity analysis, and set appropriate client expectations about uncertainty." },
      { "id": "q5", "text": "A client is 30 years old with low current income but expects to be in a high tax bracket at retirement. Which account type is generally preferred?", "options": ["Roth, because tax rates are low now and withdrawals will be tax-free when they are likely higher", "Traditional, because the current deduction is more valuable at high income", "SEP-IRA, which provides the highest contribution limits", "Taxable brokerage account for maximum flexibility"], "correct": 0, "explanation": "Roth accounts are advantageous when current tax rates are lower than expected future rates. Paying tax on contributions now avoids taxes on a much larger balance later." },
      { "id": "q6", "text": "What is the break-even age range for delayed vs. early Social Security claiming?", "options": ["Approximately age 78-82, when cumulative delayed benefits catch up to cumulative early benefits", "Age 70, when delayed credits stop accruing", "Age 75, the median life expectancy for retirees", "Age 85, accounting for inflation adjustments"], "correct": 0, "explanation": "The break-even age is typically 78-82 depending on the specific early vs. delayed benefit amounts. Clients who expect to live past break-even generally benefit from delaying." },
      { "id": "q7", "text": "In a sensitivity analysis for retirement planning, which variable typically has the largest impact on portfolio depletion risk?", "options": ["Retirement age — retiring earlier dramatically increases portfolio drawdown years and reduces accumulation time", "Portfolio management fees", "Social Security claiming age", "The choice between Traditional and Roth accounts"], "correct": 0, "explanation": "Each year of earlier retirement both reduces the accumulation period and extends the drawdown period. The compounded impact on portfolio sustainability is significant." },
      { "id": "q8", "text": "What are the three questions clients most want answered in a retirement planning presentation?", "options": ["Am I on track? What do I need to change? What are my risks?", "What is my expected return? How should I invest? When will my money run out?", "What is my Social Security benefit? What is my RMD? What is my account balance?", "How much do I need to save? What is the inflation rate? What is my tax bracket?"], "correct": 0, "explanation": "These three questions capture the client's actual concern: current status, required action, and risk exposure. Structuring the presentation around them makes it actionable." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 4;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Estate Planning Belongs in Every Financial Plan",
      "summary": "Estate planning is not just for the wealthy. Every client needs a minimum set of documents.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Estate planning is the part of financial planning that most clients avoid until it is too late. The consequences of dying without a plan — dying intestate — include assets distributed according to state law rather than the client's wishes, delays and costs of probate, potential family conflict, and minor children left in the care of someone the client would not have chosen." },
        { "type": "callout", "kind": "key", "title": "The minimum every client needs", "text": "Regardless of net worth: (1) A will or trust. (2) A durable power of attorney. (3) A healthcare directive. (4) Current beneficiary designations on all accounts. These four documents solve the majority of estate planning problems at any wealth level." },
        { "type": "heading", "text": "The consequences of dying without a plan" },
        { "type": "list", "items": [
          "Assets distributed by state intestacy laws, which may not match client wishes",
          "Probate process: public, time-consuming, expensive (3-7% of estate value in some states)",
          "Minor children placed with whoever the court appoints, not necessarily the client's preference",
          "No one with legal authority to manage finances if the client becomes incapacitated",
          "No healthcare decision-maker if the client cannot speak for themselves"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "The Core Estate Planning Documents",
      "summary": "Know what each document does, when it is used, and how to explain it in plain language.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The financial advisor does not draft estate planning documents — that is the attorney's role. But the advisor must understand each document well enough to identify gaps in the client's estate plan and make appropriate referrals." },
        { "type": "glossary", "terms": [
          { "term": "Will (Last Will and Testament)", "definition": "Specifies how assets are to be distributed after death and who manages the process (executor). Must go through probate. Does not control accounts with beneficiary designations." },
          { "term": "Revocable Living Trust", "definition": "Holds assets during life and distributes them after death without probate. The grantor retains full control during their lifetime. Effective for privacy, probate avoidance, and multi-state property." },
          { "term": "Durable Power of Attorney", "definition": "Authorizes a named agent to manage financial affairs if the principal becomes incapacitated. 'Durable' means it remains effective after incapacity." },
          { "term": "Healthcare Directive (Living Will / Healthcare POA)", "definition": "Specifies medical treatment preferences and names a healthcare agent to make decisions if the client cannot. Two documents in one: a living will (treatment preferences) and a healthcare proxy (decision-maker)." }
        ]},
        { "type": "callout", "kind": "warn", "title": "The most expensive estate planning mistake", "text": "Having a will but not funding the trust. Many clients pay for a revocable living trust but never transfer assets into it. At death, the assets that were not transferred go through probate anyway — defeating the entire purpose. Your role is to check that the trust is funded." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Beneficiary Designations — The Most Important Form",
      "summary": "A beneficiary designation overrides the will. Most clients don't know this.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Beneficiary designations control the distribution of retirement accounts, life insurance policies, and certain bank accounts regardless of what the will says. This is the most commonly misunderstood aspect of estate planning. A client whose will leaves everything to their current spouse but whose IRA still names their ex-spouse as beneficiary will have their IRA go to the ex-spouse." },
        { "type": "callout", "kind": "key", "title": "The beneficiary hierarchy", "text": "Every account with a beneficiary designation needs: (1) a primary beneficiary (who gets the money first), and (2) a contingent beneficiary (who gets it if the primary beneficiary predeceases the account holder). If no contingent beneficiary is named and the primary beneficiary dies first, the account may pass through the estate and into probate." },
        { "type": "activity", "title": "Beneficiary Designation Audit", "prompt": "Conduct a beneficiary designation audit for a hypothetical client.", "steps": [
          "List every account type the client might have: 401(k), IRA, Roth IRA, life insurance, bank accounts with POD.",
          "For each account, identify who should be named as primary and contingent beneficiary.",
          "Identify the three situations that commonly require beneficiary updates: marriage, divorce, death of a beneficiary.",
          "Draft a one-paragraph explanation of why beneficiary designations override the will, in plain language suitable for a client.",
          "What would you say to a client who is reluctant to name a contingent beneficiary?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Working with Estate Planning Attorneys",
      "summary": "Your role is coordination and information gathering, not legal advice.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The financial advisor and the estate planning attorney serve different functions but need the same information. The advisor coordinates the financial picture; the attorney creates the legal documents. The handoff between them is where estate plans most often fall through the cracks." },
        { "type": "callout", "kind": "do", "title": "What to gather before the attorney referral", "text": "Net worth statement showing all assets and their ownership structure. Beneficiary designations on all accounts. Goals for asset distribution. Names and ages of heirs. Any specific concerns: a child with special needs, a blended family, a business interest. Bringing this to the attorney meeting saves time and produces better documents." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Legacy Goals Beyond the Documents",
      "summary": "Estate planning is also about values, stories, and intentions — not just legal structures.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The legal documents handle the mechanics of wealth transfer. But many clients have legacy goals that go beyond who gets the money: passing down values, funding a cause they care about, ensuring a family business continues, supporting a community institution. These goals belong in the financial plan." },
        { "type": "callout", "kind": "key", "title": "The legacy conversation starter", "text": "'Beyond the financial accounts and legal documents, what do you most want to leave behind — what values, what opportunities, what impact?' This question often opens conversations that no amount of document review would reveal." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What does dying intestate mean?", "options": ["Dying without a valid will, resulting in asset distribution according to state law", "Dying with a will that has not been probated", "Dying with assets solely held in a trust", "Dying with outstanding debts that exceed assets"], "correct": 0, "explanation": "Intestate means without a will. State intestacy laws determine who receives assets, which may not reflect the client's wishes." },
      { "id": "q2", "text": "Which document authorizes someone to manage a client's financial affairs if they become incapacitated?", "options": ["Durable power of attorney", "Healthcare directive", "Revocable living trust", "Beneficiary designation form"], "correct": 0, "explanation": "The durable power of attorney authorizes a named agent to manage financial affairs. 'Durable' means it remains effective even after the principal becomes incapacitated." },
      { "id": "q3", "text": "A client has a will leaving everything to their current spouse. Their IRA still names their ex-spouse as beneficiary. Who receives the IRA at death?", "options": ["The ex-spouse, because beneficiary designations override the will", "The current spouse, because the will supersedes beneficiary designations", "The estate, which then distributes per the will", "It depends on state law"], "correct": 0, "explanation": "Beneficiary designations control retirement accounts and insurance regardless of the will. This is the most commonly misunderstood aspect of estate distribution." },
      { "id": "q4", "text": "What is the primary advantage of a revocable living trust over a will?", "options": ["Assets in the trust avoid probate, reducing cost, time, and public disclosure", "It provides asset protection from creditors during the client's lifetime", "It eliminates estate taxes for large estates", "It is less expensive to create than a will"], "correct": 0, "explanation": "The key advantage of a living trust is probate avoidance: faster distribution, lower costs, and privacy. It does not provide asset protection during life." },
      { "id": "q5", "text": "What is the most common error clients make with revocable living trusts?", "options": ["Creating the trust but not transferring assets into it, so those assets still pass through probate", "Naming the wrong trustee", "Failing to include a pour-over will", "Making the trust irrevocable when it should be revocable"], "correct": 0, "explanation": "An unfunded trust is nearly useless. Assets must be formally transferred into the trust for it to control their distribution. Many clients pay for a trust and never fund it." },
      { "id": "q6", "text": "Why is naming a contingent beneficiary important?", "options": ["If the primary beneficiary dies before the account holder, the contingent beneficiary receives the assets — without one, the account may go through probate", "Contingent beneficiaries receive the assets simultaneously with the primary beneficiary", "Contingent beneficiaries are required by law for retirement accounts", "The contingent beneficiary receives the assets only if specifically requested"], "correct": 0, "explanation": "If the primary beneficiary predeceases the account holder and no contingent is named, the account passes to the estate and through probate — often not the intended result." },
      { "id": "q7", "text": "Before referring a client to an estate planning attorney, what information should the financial advisor gather?", "options": ["Net worth statement, beneficiary designations, asset ownership structures, distribution goals, and specific family concerns", "The attorney's billing rate and scope of services", "A list of the client's outstanding debts", "The client's annual income and tax bracket"], "correct": 0, "explanation": "Organized financial information makes the attorney engagement more efficient and produces better documents. The advisor coordinates the financial picture before legal work begins." },
      { "id": "q8", "text": "What does 'funding the trust' mean in estate planning?", "options": ["Transferring ownership of assets — bank accounts, investments, real property — into the trust so it controls their distribution", "Making a financial contribution to establish the trust", "Naming beneficiaries in the trust document", "Paying the attorney fees to draft the trust"], "correct": 0, "explanation": "A trust only controls assets that have been legally transferred into it. Funding is the administrative step that most clients overlook after the documents are signed." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 5;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Purpose of a Planning Summary",
      "summary": "A planning summary is a decision document, not a report card. Know the difference.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The planning summary is the deliverable that translates months of discovery, analysis, and scenario modeling into something the client can read, understand, and act on. It is not a comprehensive documentation of everything the advisor did. It is the answer to the client's implicit question: 'What should I do?'" },
        { "type": "callout", "kind": "key", "title": "Lead with conclusions", "text": "Every planning summary should answer the three key questions on page one: Are you on track? What are the most important things to change? What should happen next? If the client reads only the first page, they should know what to do. Everything else is supporting evidence." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "Structure of a Planning Summary",
      "summary": "The structure determines whether clients read it. Most planning documents are organized wrong.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The traditional financial plan is organized like an academic paper: background, methodology, analysis, then conclusions. Clients read in the opposite order — they want conclusions first, then the evidence. Structure your planning summary accordingly." },
        { "type": "numbered", "items": [
          "<strong>Executive summary</strong> — 3-5 sentences. Current situation, most important findings, recommended priorities.",
          "<strong>Your financial snapshot</strong> — one-page net worth and cash flow summary. The scoreboard.",
          "<strong>Key findings by area</strong> — retirement, protection, tax, estate, each in 1-2 paragraphs.",
          "<strong>Recommendations</strong> — specific, prioritized, actionable. Not 'consider increasing savings' but 'increase 401(k) contribution to 12% by January.'",
          "<strong>Next steps and timeline</strong> — who does what by when. Both advisor and client responsibilities."
        ]},
        { "type": "callout", "kind": "do", "title": "The one-page test", "text": "If you cannot summarize the most important points of the plan on one page, you have not thought about it clearly enough. The one-page summary is not a shortcut — it is the hardest thing to write. It forces clarity." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Writing for Clients, Not Advisors",
      "summary": "Every sentence should be understandable to someone who did not go to financial planning school.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial planning has its own vocabulary: asset allocation, basis points, tax-loss harvesting, required minimum distributions, sequence-of-returns risk. Advisors use these terms automatically. Clients encounter them and stop reading." },
        { "type": "activity", "title": "Plain Language Rewrite Exercise", "prompt": "Rewrite each of the following advisor-language sentences in plain client language.", "steps": [
          "'We recommend a tactical reallocation toward fixed income given elevated equity valuations.' → Write the same recommendation in one clear sentence a client can understand.",
          "'Your current savings rate is insufficient to fund your retirement income need at your target retirement date.' → What does this actually mean, and how would you say it?",
          "'Your estate planning documents do not reflect your current family structure and asset ownership.' → Translate.",
          "'Your disability insurance has an any-occupation definition with a 90-day elimination period.' → Plain English?",
          "Read each rewrite aloud. If it sounds like a human talking, it passes the test."
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "Visual Communication in Planning Materials",
      "summary": "The right chart makes a complex point instantly. The wrong chart makes a simple point confusing.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "One well-designed chart can communicate what two pages of text cannot. But poorly designed charts — too complex, wrong format, unlabeled axes — obscure rather than clarify. Use visuals intentionally." },
        { "type": "list", "items": [
          "<strong>Net worth over time</strong> — line chart. Shows trajectory clearly.",
          "<strong>Asset allocation</strong> — pie chart (one of the few appropriate uses). Simple and intuitive.",
          "<strong>Retirement income sources</strong> — stacked bar. Shows Social Security, pension, portfolio withdrawal proportions.",
          "<strong>Goal funding status</strong> — progress bars. Immediately legible at a glance.",
          "<strong>Scenario comparison</strong> — side-by-side table. Retire at 62 vs. 65 vs. 67."
        ]},
        { "type": "callout", "kind": "warn", "title": "The complexity trap", "text": "Charts with more than 5 data points, multiple axes, or dense annotation confuse clients. If you need a legend to explain a chart, simplify it. The goal is insight, not comprehensiveness." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Compliance Review and Final Check",
      "summary": "Materials that reach clients without a final review create compliance risk and damage trust.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every piece of client-facing material must be reviewed for accuracy, compliance language, and consistency before delivery. A single error in a planning summary — a wrong account balance, an incorrect projection, an inappropriate guarantee — can create a compliance issue and destroy client confidence." },
        { "type": "list", "items": [
          "All numbers verified against source documents",
          "No specific return promises or guarantees",
          "Required disclosures included",
          "Consistent figures throughout (net worth on page 2 matches page 5)",
          "Client name spelled correctly on every page",
          "All recommendations tied to client's stated goals"
        ]}
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "How should a planning summary be structured for maximum client impact?", "options": ["Conclusions and recommendations first, with supporting analysis following", "Background and methodology first, then analysis, then conclusions", "Analysis first, recommendations last, with conclusions in the appendix", "Alphabetically by planning topic for easy reference"], "correct": 0, "explanation": "Clients want conclusions first. Leading with 'are you on track, what needs to change, what happens next' ensures the most important information is seen even if the client doesn't read the full document." },
      { "id": "q2", "text": "What is the 'one-page test' for a planning summary?", "options": ["If you cannot summarize the most important points on one page, the thinking is not clear enough yet", "Planning summaries must legally fit on one page for compliance", "Clients only read the first page, so all information must be there", "One page is the industry standard length for financial planning documents"], "correct": 0, "explanation": "The one-page summary test is a clarity standard. If you can't summarize the key points concisely, it signals that the analysis needs more focus and prioritization." },
      { "id": "q3", "text": "Which chart type is most appropriate for showing a client's asset allocation?", "options": ["Pie chart — simple, intuitive, immediately legible for proportional data", "Line chart — shows change over time", "Scatter plot — shows correlation between variables", "Histogram — shows distribution of values"], "correct": 0, "explanation": "Pie charts work well for proportional data where the parts of a whole need to be visualized. Asset allocation — 60% equity, 30% fixed income, 10% cash — is a classic use case." },
      { "id": "q4", "text": "Why is plain language critical in client-facing planning materials?", "options": ["Technical jargon causes clients to stop reading, which means recommendations are never understood or acted on", "Plain language is required by SEC regulations for investment advisors", "Technical language implies the advisor lacks expertise", "Client-facing materials must be understandable to non-English speakers"], "correct": 0, "explanation": "If clients don't understand the plan, they can't follow it. Jargon is a barrier to the action the plan is designed to produce." },
      { "id": "q5", "text": "What should a planning summary's 'next steps' section include?", "options": ["Specific actions, responsible parties (advisor and client), and deadlines", "A general description of the planning process going forward", "A list of all planning topics that were covered in the analysis", "Contact information for the advisor and firm"], "correct": 0, "explanation": "Next steps must be specific and assigned. 'Increase 401(k) contribution to 12% by January 1' is actionable. 'Consider increasing retirement savings' is not." },
      { "id": "q6", "text": "When reviewing planning materials before client delivery, what must be verified?", "options": ["All numbers against source documents, no guarantees, required disclosures, consistency throughout, correct client name", "The advisor's signature and firm letterhead are included", "The document is under 20 pages", "All charts use the firm's brand colors"], "correct": 0, "explanation": "Accuracy, compliance language, and consistency are the critical checks. A single number error or inappropriate guarantee in a client document creates both compliance and trust risk." },
      { "id": "q7", "text": "What is wrong with a planning recommendation that says 'consider increasing savings'?", "options": ["It is not specific enough to act on — a good recommendation names the account, the amount, and the timeline", "It implies the client is not saving enough, which may offend them", "It does not reference the client's specific goal", "It is not technically a financial planning recommendation"], "correct": 0, "explanation": "Vague recommendations produce no action. 'Increase 401(k) contribution from 6% to 10% beginning with the January payroll cycle' is actionable." },
      { "id": "q8", "text": "What does a chart with more than 5 data points and a legend most likely indicate?", "options": ["The chart is too complex and should be simplified for client communication", "The advisor has done thorough analysis worth documenting", "The chart meets the standard for financial planning exhibits", "Additional data points improve client understanding"], "correct": 0, "explanation": "Complexity in a chart means the message is unclear. Client-facing visuals should communicate a single insight immediately. If a legend is needed, the chart should be redesigned." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 6;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why CRM Accuracy Is a Professional Standard",
      "summary": "The CRM is the institutional memory of the practice. Accurate records protect clients, protect advisors, and enable great service.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "A CRM entry that is missing, inaccurate, or incomplete is not just an operational inconvenience. It creates client service failures when the wrong person is called. It creates compliance exposure when interactions are undocumented. It creates business risk when institutional knowledge lives only in one person's head." },
        { "type": "callout", "kind": "key", "title": "Your personal responsibility", "text": "CRM accuracy is not the firm's responsibility to manage after the fact. It is every team member's responsibility to maintain in real time. If you have an interaction with a client and don't log it, it didn't happen — professionally and legally." }
      ]
    },
    {
      "id": "lesson-2",
      "title": "What Goes in the CRM",
      "summary": "Every client record has required fields. Every interaction has a documentation standard.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The CRM client profile is the authoritative record of who the client is and how the relationship is managed. It contains static information (demographics, accounts, family), dynamic information (recent interactions, open tasks, life events), and compliance information (signed documents, disclosures)." },
        { "type": "glossary", "terms": [
          { "term": "Client profile", "definition": "Core demographic and contact information: name, address, phone, email, date of birth, SSN (encrypted), employment, marital status, dependents." },
          { "term": "Account records", "definition": "All accounts linked to the client: account numbers, custodian, account type, ownership, beneficiaries." },
          { "term": "Interaction log", "definition": "A dated record of every client contact: call, email, meeting, text. Includes summary of topics discussed, decisions made, and action items." },
          { "term": "Task list", "definition": "Open items with assigned responsibility and deadline. The mechanism that ensures nothing falls through the cracks." }
        ]},
        { "type": "callout", "kind": "do", "title": "The 24-hour rule", "text": "Log every client interaction within 24 hours. After 24 hours, memory degrades and details are lost. After a week, you are fabricating the record. Compliance requires accurate records, not good-faith approximations." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Logging Client Interactions",
      "summary": "What to capture, how much detail, and how quickly.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "An interaction log entry should be complete enough that someone who was not present could understand what happened and what comes next. This is the compliance standard and the service standard simultaneously." },
        { "type": "list", "items": [
          "<strong>Date and duration</strong> — when, how long",
          "<strong>Type of interaction</strong> — phone call, in-person meeting, email, text",
          "<strong>Attendees</strong> — who was present on both sides",
          "<strong>Topics discussed</strong> — the substance of the conversation, not just 'spoke with client'",
          "<strong>Decisions made</strong> — any commitments, approvals, or changes agreed to",
          "<strong>Action items</strong> — who does what by when, assigned to advisor or client"
        ]},
        { "type": "case_study", "title": "What Good Documentation Looks Like", "scenario": "After a 30-minute phone call with a client who wants to increase their 401(k) contribution and asked about converting their IRA to Roth, what does the interaction log entry look like?", "discussion": "Date: [today], Type: Phone call, Duration: 30 min. Topics: (1) Client requested 401(k) contribution increase from 6% to 10%, effective next payroll cycle. (2) Client inquired about Roth IRA conversion — concerned about tax impact. Action items: Advisor to confirm 401(k) change with payroll (by [date]). Advisor to model Roth conversion scenario for 2026 (by [date]). Client to gather prior year tax return for conversion analysis." }
      ]
    },
    {
      "id": "lesson-4",
      "title": "Maintaining Data Accuracy",
      "summary": "Records decay. Build the habits that keep the CRM current.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client data changes constantly: new phone numbers, new employers, new accounts, new family members, beneficiary changes. An address that was current 18 months ago may not be current today. A CRM with stale data fails the clients it is supposed to serve." },
        { "type": "callout", "kind": "do", "title": "The annual data review", "text": "Once per year, review every field in each client profile and confirm it is current. The annual review meeting is a natural trigger. Ask: 'Has your contact information, employer, or family situation changed in the past year?' Update immediately." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "CRM as a Practice Management Tool",
      "summary": "A well-used CRM does more than store information — it drives the entire service delivery system.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The CRM is the engine of a well-run advisory practice. Used to its full potential, it generates follow-up workflows, triggers review meetings, manages birthday and anniversary outreach, tracks task completion, and provides management reporting. Most teams use 20% of the capability." },
        { "type": "callout", "kind": "key", "title": "Automation that works", "text": "The highest-value CRM automations: (1) Automatic task creation after a meeting log entry. (2) Annual review scheduling triggers tied to client anniversary dates. (3) Birthday and milestone outreach. (4) Follow-up reminders for outstanding client actions. These run without manual effort and ensure nothing falls through the cracks." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the professional standard for logging a client interaction in the CRM?", "options": ["Within 24 hours of the interaction", "Before the end of the business week", "At the next scheduled team meeting", "Within 48 hours if detailed notes are required"], "correct": 0, "explanation": "24 hours is the standard. After that, memory degrades and the accuracy of the record cannot be assured. Compliance requires accurate records, not reconstructed ones." },
      { "id": "q2", "text": "An interaction log entry for a 30-minute client phone call should include which of the following?", "options": ["Date, type, attendees, topics discussed, decisions made, and action items with deadlines", "A brief note that contact occurred and the client is satisfied", "The full transcript of the conversation", "Only information that affects investment recommendations"], "correct": 0, "explanation": "Complete interaction logs allow any team member to understand the relationship history and serve clients effectively. They also satisfy compliance documentation requirements." },
      { "id": "q3", "text": "Why is CRM data accuracy considered a personal professional responsibility, not just a firm IT issue?", "options": ["Every team member generates client interactions that must be documented; inaccurate records create compliance exposure and service failures", "The firm charges back CRM errors to individual team members", "Regulatory examiners review individual employee CRM entries during examinations", "CRM accuracy is tied to performance reviews at most firms"], "correct": 0, "explanation": "Inaccurate CRM records are created by individuals failing to log interactions or update information. The responsibility to maintain accuracy belongs to the people who generate the activity." },
      { "id": "q4", "text": "Which of the following is the best example of an action item in an interaction log?", "options": ["'Advisor to model Roth conversion scenario by March 15'", "'Discuss Roth conversion further'", "'Client interested in Roth'", "'Roth conversion — follow up'"], "correct": 0, "explanation": "Action items must be specific: who, what, and by when. Vague entries like 'follow up' do not create accountability and result in missed commitments." },
      { "id": "q5", "text": "When should client profile information be reviewed and updated?", "options": ["At minimum annually, with immediate updates whenever the advisor learns of a life change", "Only when the client requests a change", "During compliance examinations", "Every three years as part of the planning review cycle"], "correct": 0, "explanation": "Annual reviews catch systematic drift. Immediate updates for known life changes (marriage, divorce, new address, new employer) ensure the record is current when it matters." },
      { "id": "q6", "text": "What is the highest-value CRM automation for a financial advisory practice?", "options": ["Automatic task creation after meeting logs and annual review scheduling triggers tied to client anniversary dates", "Automatic generation of investment recommendations based on account performance", "Automated email responses to all client inquiries", "Automatic account rebalancing notifications"], "correct": 0, "explanation": "Meeting follow-up tasks and review scheduling automations ensure consistent service delivery without manual effort. They operationalize the service model." },
      { "id": "q7", "text": "What does a CRM 'task list' accomplish in client service?", "options": ["Tracks open action items with assigned responsibility and deadlines, ensuring commitments are fulfilled", "Generates automated reminders for investment trades", "Documents the client's financial goals for planning purposes", "Records compliance-required disclosures for each client"], "correct": 0, "explanation": "The task list is the mechanism for following through on commitments. Without it, action items discussed in meetings are frequently forgotten or delayed." },
      { "id": "q8", "text": "A colleague asks you to complete a CRM entry for a client interaction they had yesterday but didn't log. What is the appropriate response?", "options": ["Decline — only the person who had the interaction can accurately document what was discussed and decided", "Complete the entry based on the colleague's verbal summary", "Create a placeholder entry noting the interaction occurred", "Note the interaction in the client file rather than the CRM"], "correct": 0, "explanation": "CRM entries require firsthand knowledge of what occurred. An entry based on a second-hand account is unreliable and potentially inaccurate. The person who had the interaction must complete the documentation." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 7;

UPDATE public.modules SET content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Apprentice's Role in Client Meetings",
      "summary": "Your first client meetings are learning opportunities. Know what is expected of you before you walk in the door.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "As an apprentice observing and supporting client meetings, your role has three components: preparation, professional presence, and documentation. You are not there to contribute your opinions. You are there to learn how skilled advisors manage relationships, to support the meeting logistics, and to capture what happens accurately." },
        { "type": "callout", "kind": "key", "title": "The three rules for meeting presence", "text": "1. Be prepared — know the client before you walk in. 2. Be present — phone away, eyes on the conversation. 3. Be useful — take thorough notes, manage the logistics, follow through on action items." },
        { "type": "heading", "text": "What the advisor expects from support staff in a meeting" },
        { "type": "list", "items": [
          "Accurate, complete notes of what was discussed, decided, and committed to",
          "Professional presentation: appropriate dress, no distractions, confidential conduct",
          "Logistics management: materials ready, room set, technology working",
          "Active listening: noting client concerns and questions to surface in follow-up",
          "CRM entry within 24 hours of the meeting"
        ]}
      ]
    },
    {
      "id": "lesson-2",
      "title": "Meeting Preparation",
      "summary": "Great meetings are made before they start. Here's what to do before every client meeting.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "The advisor who walks into a client meeting unprepared is not just inefficient — they are telling the client that the relationship is not a priority. Every client meeting, regardless of how routine, requires preparation." },
        { "type": "heading", "text": "The pre-meeting brief" },
        { "type": "list", "items": [
          "<strong>Account summary</strong> — current balances, recent performance, any significant changes since the last meeting",
          "<strong>Action items from the last meeting</strong> — what was committed to by the advisor, status of each",
          "<strong>What the client cares about</strong> — recent life events, known concerns from the CRM, questions from the last interaction",
          "<strong>Agenda for today</strong> — what the meeting is designed to accomplish",
          "<strong>Materials check</strong> — performance report, planning updates, any documents requiring signature"
        ]},
        { "type": "callout", "kind": "do", "title": "Prepare the advisor, not just yourself", "text": "Your job before a client meeting is not just to know the client yourself — it is to make sure the advisor walks in fully briefed. A one-page pre-meeting summary for the advisor, delivered 30 minutes before the meeting, is one of the most valuable things a support associate can do." }
      ]
    },
    {
      "id": "lesson-3",
      "title": "Taking Notes That Are Actually Useful",
      "summary": "Meeting notes are only valuable if they capture what matters. Learn the difference.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Many new professionals take notes that are comprehensive but useless: they capture everything said without distinguishing what matters. The goal is a record that allows any team member to understand what happened and what comes next — without reading a transcript." },
        { "type": "heading", "text": "What to capture" },
        { "type": "list", "items": [
          "<strong>Decisions</strong> — what was agreed to: a strategy change, a contribution increase, a referral request",
          "<strong>Action items</strong> — who does what by when, for both advisor and client",
          "<strong>Client concerns</strong> — anything the client expressed worry about, even if not addressed in the meeting",
          "<strong>Follow-up questions</strong> — things that came up and were deferred for further research"
        ]},
        { "type": "heading", "text": "What not to capture" },
        { "type": "list", "items": [
          "Verbatim quotes unless they are highly significant",
          "Background information the team already knows from the CRM",
          "Every pleasantry and conversational detour",
          "Information the advisor shared that was purely educational"
        ]},
        { "type": "activity", "title": "Meeting Notes Practice", "prompt": "Read the following meeting scenario and write the interaction log entry.", "steps": [
          "Scenario: 45-minute annual review with a married couple. Performance was discussed — portfolio up 8.2% versus benchmark of 7.5%. Client asked about adding a vacation property. Wife mentioned she may retire earlier than planned (60 vs. 65). Advisor recommended increasing savings rate and said he would model the earlier retirement scenario. Client needs to provide updated insurance policy by next meeting.",
          "Write the CRM interaction log entry covering: key topics, decisions, and action items.",
          "What would you flag for the advisor's attention that might require follow-up beyond the stated action items?"
        ]}
      ]
    },
    {
      "id": "lesson-4",
      "title": "What to Watch for in Client Meetings",
      "summary": "The most valuable learning from observing meetings is watching how skilled advisors read and respond to clients.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Attending client meetings as an observer is one of the richest learning opportunities in the apprenticeship. But only if you know what to watch for. Focus less on the content of what is said — you will read about that in your modules — and more on how the advisor manages the relationship." },
        { "type": "list", "items": [
          "How does the advisor open the meeting and set the agenda?",
          "When a client expresses concern, how does the advisor acknowledge it before moving to a solution?",
          "How does the advisor handle disagreement between spouses?",
          "What does the advisor do when a client asks a question they cannot immediately answer?",
          "How does the advisor close the meeting: summarizing, confirming action items, setting the next appointment?"
        ]},
        { "type": "callout", "kind": "key", "title": "After every meeting you observe", "text": "Write down one thing the advisor did well that you want to adopt. Write down one question you have about a decision they made. Bring these to your next check-in with the advisor. The reflection habit turns observation into learning." }
      ]
    },
    {
      "id": "lesson-5",
      "title": "Post-Meeting Follow-Through",
      "summary": "What happens after the meeting determines whether the meeting was worth having.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The follow-through after a client meeting is where the advisor's reliability is established. Clients remember whether you did what you said you would do. Missing a commitment or delivering it late damages trust more than most advisors realize." },
        { "type": "callout", "kind": "do", "title": "The follow-up email standard", "text": "Send within 24 hours. Include: (1) a brief thank-you for the client's time, (2) a summary of what was discussed, (3) what the advisor will do and by when, (4) what the client needs to do and by when, (5) date of the next meeting if scheduled. Keep it under 200 words. Professional and personal, not formal and generic." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      { "id": "q1", "text": "What is the primary role of an apprentice observing a client meeting?", "options": ["Preparation, professional presence, and documentation — not contributing opinions or advice", "Introducing the firm's products and services when appropriate", "Answering technical questions the advisor cannot address", "Managing the client relationship while the advisor focuses on analysis"], "correct": 0, "explanation": "Apprentices in client meetings learn by observing and support by documenting. Contributing advice without authorization is inappropriate and potentially a compliance issue." },
      { "id": "q2", "text": "How long before a client meeting should the advisor receive the pre-meeting brief?", "options": ["30 minutes before the meeting", "The morning of the meeting", "The day before the meeting", "At the start of the meeting"], "correct": 0, "explanation": "30 minutes gives the advisor time to review and internalize the brief without being too far in advance to remember the details." },
      { "id": "q3", "text": "Which of the following belongs in a meeting interaction log entry?", "options": ["Decisions made, action items with deadlines, and client concerns raised", "A verbatim transcript of the client conversation", "Background information already documented in the client's CRM profile", "The advisor's personal assessment of the client's financial sophistication"], "correct": 0, "explanation": "Interaction logs capture what happened and what comes next — decisions, commitments, and concerns. Verbatim transcripts and background information are not necessary." },
      { "id": "q4", "text": "When observing a client meeting, what should an apprentice primarily focus on learning?", "options": ["How the advisor manages the relationship: opens meetings, handles concerns, manages conflict, closes with action items", "The specific investment products the advisor recommends", "The technical financial analysis the advisor presents", "How the firm's compliance policies are applied in client conversations"], "correct": 0, "explanation": "Technical knowledge comes from coursework and self-study. Observing meetings is the opportunity to learn the relationship management skills that cannot be read in a textbook." },
      { "id": "q5", "text": "What should a client follow-up email include?", "options": ["Thank-you, summary of topics, advisor action items with deadlines, client action items with deadlines, and next meeting date", "A full recap of all financial recommendations made during the meeting", "The performance report and all planning documents discussed", "Only the action items that require the client's participation"], "correct": 0, "explanation": "The follow-up email confirms shared understanding, documents commitments, and creates a reference for both parties. All five elements are important." },
      { "id": "q6", "text": "After observing a client meeting, what should an apprentice do to maximize learning?", "options": ["Write down one thing the advisor did well and one question about a decision they made, then discuss with the advisor", "Write a detailed report of the entire meeting for the client file", "Review the client's account statements to understand the context", "Ask the client for feedback on the meeting quality"], "correct": 0, "explanation": "Structured reflection after observation accelerates learning. Identifying specific techniques to adopt and specific questions to discuss converts passive observation to active development." },
      { "id": "q7", "text": "A client asks a question during the meeting that the advisor cannot immediately answer. What should the advisor do?", "options": ["Acknowledge the question, commit to a specific response by a specific date, and document it as an action item", "Provide a best estimate and follow up only if the estimate was wrong", "Defer the question to the compliance department", "Suggest the client research the answer independently"], "correct": 0, "explanation": "Admitting uncertainty and committing to a specific follow-up is far more trustworthy than guessing. Clients respect advisors who know their limits." },
      { "id": "q8", "text": "Why does missing a commitment to a client damage trust more than many advisors expect?", "options": ["Clients rely on follow-through as the primary evidence that the advisor is trustworthy and attentive to their interests", "Missing commitments triggers regulatory reporting requirements", "Clients typically fire advisors immediately after a missed commitment", "The financial planning literature identifies missed commitments as the leading cause of client dissatisfaction"], "correct": 0, "explanation": "Trust in an advisory relationship is built through consistent reliability. A missed commitment — however small — signals that the client is not the priority, which undermines the entire relationship." }
    ]
  }
}
$jsonb$::jsonb
WHERE module_number = 8;
