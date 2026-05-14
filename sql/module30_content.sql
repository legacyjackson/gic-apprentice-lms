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
