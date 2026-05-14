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
where module_number = 29;
