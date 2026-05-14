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
