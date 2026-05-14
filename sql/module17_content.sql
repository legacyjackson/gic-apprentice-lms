-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 17 CONTENT
-- Implementation & Coordination
-- ============================================================================
update public.modules set
  title = 'Implementation & Coordination',
  competency_id = 'OJL-8',
  ri_hours = 0,
  ojl_hours = 100,
  short_description = 'Move from agreed plan to executed plan — opening accounts, transferring assets, coordinating with the CPA and attorney, and tracking every moving piece without dropping any of them.',
  learning_objectives = ARRAY[
    'Sequence implementation steps in the right order to avoid avoidable mistakes',
    'Execute account opens, transfers, and rollovers cleanly',
    'Coordinate with external professionals — CPA, estate attorney, insurance broker',
    'Track implementation status across multiple workstreams without dropping items',
    'Recognize when an implementation step is going wrong and intervene early'
  ],
  content = $jsonb$
  {
    "lessons": [
      {
        "id": "lesson-1",
        "title": "Implementation Is Where Plans Die",
        "summary": "Excellent plans that never get implemented are common. The implementation phase is operational, detail-heavy, and where most relationships either prove their value or quietly fail.",
        "read_time": "9 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most clients who switch advisors do so not because the previous advisor gave bad advice but because the previous advisor never finished implementing the advice they gave. The plan landed in a binder. The action items decayed. The beneficiary update never happened. The 401(k) increase was set up incorrectly. The Roth conversion the client agreed to was never executed before year-end. Implementation is unglamorous, repetitive, deadline-driven work — and it is the work that determines whether the plan was real."},
          {"type": "callout", "kind": "key", "content": "A plan is not a recommendation. A plan is a sequence of completed actions. Until each action is done and documented, the plan is aspirational."},
          {"type": "subheading", "content": "Why implementation breaks down"},
          {"type": "list", "items": [
            "Too many items moving at once with no master list and no owner per item",
            "Sequence errors — a step happens before its prerequisite is done, creating rework",
            "Hand-offs without confirmation — assuming the client did their part, or the custodian processed the form, without verifying",
            "External professionals not looped in or looped in too late",
            "Tax deadlines missed because the calendar was not respected"
          ]},
          {"type": "subheading", "content": "The implementation tracker"},
          {"type": "paragraph", "content": "Every client should have a single implementation tracker — a document or CRM record listing every action item, owner, status, and completion date. This is not the action list from the presentation meeting. That list seeded the tracker. The tracker grows as the work surfaces sub-items (the beneficiary form needs notarization; the rollover requires a Letter of Acceptance from the receiving custodian; the Roth conversion has to happen before December 31 and after the client's CPA confirms the year's marginal bracket). The tracker is reviewed at every internal review of the relationship and updated weekly while implementation is active."},
          {"type": "subheading", "content": "Status discipline"},
          {"type": "paragraph", "content": "Each item on the tracker has a status. Useful states: Not Started, In Progress (with sub-state), Waiting On Client, Waiting On Custodian, Waiting On External Pro, Complete, Blocked. The 'Waiting On' states are the danger zones — items in 'Waiting On Client' for three weeks need a follow-up. Items in 'Waiting On Custodian' for ten business days need an escalation. The status is not just a label. It is a trigger for a specific next action."},
          {"type": "callout", "kind": "warn", "content": "An item that has been 'In Progress' for more than two weeks without sub-state explanation is almost always actually stuck. Investigate. Things do not unstick themselves."}
        ]
      },
      {
        "id": "lesson-2",
        "title": "Sequencing — What Has to Happen Before What",
        "summary": "Some implementation tasks have dependencies. Doing them out of order creates rework, missed deadlines, and avoidable client confusion. Learn the common sequences.",
        "read_time": "11 min read",
        "blocks": [
          {"type": "paragraph", "content": "The order of implementation matters as much as the items themselves. A few classic sequence rules — break them and you create avoidable problems."},
          {"type": "subheading", "content": "Account opens before transfers"},
          {"type": "paragraph", "content": "If a recommendation involves transferring assets from one custodian to another, the receiving account has to exist before the transfer can be initiated. Sounds obvious. Gets missed routinely when the transfer paperwork goes out before the receiving account has been fully funded with its initial deposit and is in 'active' status. Open the account, fund it with a small initial deposit if required, confirm active status, then initiate the transfer."},
          {"type": "subheading", "content": "Beneficiaries updated immediately when accounts open"},
          {"type": "paragraph", "content": "Every new account — IRA, Roth, 401(k), brokerage, life insurance — has a beneficiary designation. Default beneficiary is usually 'estate' if you do not designate, which is the worst outcome for almost every client. Update beneficiaries the same day the account opens. Do not wait. People die unexpectedly. Beneficiaries trump wills. This is one of the most important and most neglected items in implementation."},
          {"type": "callout", "kind": "do", "content": "On every new account opened, the same-day checklist includes: beneficiaries designated, contingent beneficiaries designated, beneficiary percentages add to 100%, transfer-on-death (TOD) registration on taxable accounts where appropriate, and the client has a copy of the confirmed designation."},
          {"type": "subheading", "content": "Tax-aware sequencing within the calendar year"},
          {"type": "list", "items": [
            "Roth conversions should happen as early in the year as you can confirm the year's bracket, or as late as you can with enough lead time to settle before December 31",
            "Required Minimum Distributions (RMDs) must complete by December 31 (with the first one optionally by April 1 of the year after the client turns 73)",
            "Mega-backdoor Roth in-plan conversions are typically annual or per-pay-period; align with the plan's rules",
            "Tax-loss harvesting is most relevant in volatile years and must complete before December 31 with attention to wash-sale rules (30 days before or after)",
            "Charitable contributions — DAF funding, QCDs from IRAs — must complete and clear by December 31 to count for that tax year"
          ]},
          {"type": "subheading", "content": "Rollovers — direct vs indirect"},
          {"type": "paragraph", "content": "When moving money between retirement accounts — say a 401(k) at a former employer to an IRA — the direct rollover (also called a trustee-to-trustee transfer) is almost always the right choice. The check, if any, is made payable to the receiving custodian for benefit of the client. No tax withholding. No 60-day clock. An indirect rollover — where the check is made payable to the client and the client has 60 days to redeposit — triggers mandatory 20% federal tax withholding on pre-tax balances and requires the client to come up with that 20% from their own pocket to complete the full rollover. The IRS one-rollover-per-12-months rule also restricts indirect rollovers. Avoid indirect rollovers unless there is a specific reason."},
          {"type": "callout", "kind": "warn", "content": "If a rollover check arrives at the client's house made payable to the client, it is an indirect rollover. Stop the implementation, document the situation, and call the sending custodian to reissue properly. Depositing the check to the client's checking account starts the 60-day clock and the tax consequences. Time is of the essence."},
          {"type": "subheading", "content": "Insurance changes — apply before canceling"},
          {"type": "paragraph", "content": "If a client is replacing one insurance policy with another, the new policy must be issued and in force before the old policy is canceled. Otherwise the client may end up uninsured during the gap, or worse, develop a health condition that makes them uninsurable at the new policy. This is so basic it gets violated routinely. Issued, in force, premiums paid on the new policy — only then cancel the old."},
          {"type": "case_study", "title": "The rollover that took six weeks instead of two", "scenario": "An apprentice initiates a 401(k) rollover from a client's former employer to an IRA at the new custodian. The receiving IRA was opened but had no initial deposit. The former employer's plan custodian processed the rollover request, generated a check, and held it pending receipt of the new account being active. Two weeks later, nothing had happened. The apprentice discovered the receiving account was sitting in 'pending funding' status. They made a $25 initial deposit to activate the account, which took another four business days to clear. The rollover check was finally issued — but to the wrong address because the new custodian's record had a typo from the original form. Total elapsed time: six weeks. Avoidable.", "discussion": "Two errors compounded: not funding the receiving account at open, and not double-checking address fields on the receiving paperwork. Both are one-minute checks that prevent multi-week delays. Implementation is detail work. The details matter."}
        ]
      },
      {
        "id": "lesson-3",
        "title": "Coordinating With External Professionals",
        "summary": "Tax planning lives at the CPA. Estate planning lives at the attorney. Insurance lives at the broker. You orchestrate. Doing it well means clear hand-offs and shared records.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Most clients have a roster of professionals — financial advisor, CPA or tax preparer, estate attorney, insurance broker, sometimes a business attorney or a banker. Each of these professionals has expertise the financial advisor does not have and authority over decisions the advisor cannot make. Implementation usually requires getting work done across this roster, with the client in the center and the advisor often as the coordinator."},
          {"type": "subheading", "content": "Get authorization first"},
          {"type": "paragraph", "content": "Before reaching out to a client's CPA or attorney, you need the client's written authorization to communicate with that professional. Most firms have a 'Authorization to Release Information' form for this. Without it, the CPA cannot legally discuss the client's tax situation with you, and the attorney cannot share estate documents. Get the authorization signed early in the relationship for everyone the client wants in the loop. It saves weeks of friction later."},
          {"type": "subheading", "content": "Working with the CPA"},
          {"type": "list", "items": [
            "Send the CPA a written summary of any tax-relevant moves before executing — Roth conversion, harvesting transaction, sizable charitable contribution, distribution from an inherited IRA",
            "Ask the CPA to confirm the projected tax impact in writing before you execute",
            "After execution, send the CPA the confirmation and 1099 reporting details",
            "Coordinate timing — March through April the CPA is unreachable; do not plan major moves with a tax deadline in tax season",
            "Year-end planning conversations should happen in October or early November, not December"
          ]},
          {"type": "subheading", "content": "Working with the estate attorney"},
          {"type": "list", "items": [
            "Estate documents — will, revocable trust, durable power of attorney, healthcare directive — usually need to be reviewed every 3-5 years or after any major life event",
            "When the attorney updates documents, request copies of the executed final versions for your file",
            "Beneficiary designations on retirement accounts and life insurance often need to be coordinated with the trust structure; do not assume the attorney did this — verify",
            "Account titling matters as much as beneficiaries; if the attorney recommends retitling assets into a trust, track which accounts are completed",
            "Be explicit about who is responsible for funding the trust — the attorney may draft the trust but funding is often the client's or advisor's responsibility"
          ]},
          {"type": "subheading", "content": "Working with the insurance professional"},
          {"type": "paragraph", "content": "If the client uses a separate insurance broker — common — coordinate on policy changes carefully. Beneficiary changes on life insurance need to match the estate plan. Disability and long-term care coverage assumptions in the financial plan need to match the actual policy terms (which the insurance broker has). Annuity decisions in particular benefit from a three-way conversation between client, advisor, and insurance broker so the client is not navigating product complexity alone."},
          {"type": "subheading", "content": "Shared documentation"},
          {"type": "paragraph", "content": "When professionals coordinate, share the relevant documents — with client consent — in a single shared folder or via direct exchange. Avoid forwarding chains. Avoid attaching documents the client did not approve to share. Each professional should be working from the same numbers; if estate plan projections are using one net worth figure and the financial plan is using a different one, decisions get made on inconsistent data."},
          {"type": "case_study", "title": "The Roth conversion that needed three people", "scenario": "A client wants to convert $80,000 from a Traditional IRA to a Roth in October. The financial advisor's apprentice runs the projection and identifies $80,000 as the amount that fills the 24% bracket without spilling into 32%. Before executing, the apprentice emails the client's CPA with the calculation. The CPA replies — appreciates the math, notes the client also has a large planned bonus arriving in November that will push the bracket boundary down by about $14,000. Revised conversion: $66,000. The apprentice updates the projection, gets the client's written approval for the new figure, executes the conversion in October. The 1099-R goes to the CPA in January. Tax filed cleanly.", "discussion": "Without the CPA loop, the apprentice would have over-converted by $14,000, generating an avoidable tax bill in the 32% bracket and a frustrated client. The CPA's information existed; the apprentice's coordination unlocked it. Coordination is not an extra step — it is part of the recommendation."},
          {"type": "callout", "kind": "key", "content": "If a recommendation has tax implications and you have not talked to the CPA, you have not finished the recommendation. If it has estate implications and you have not coordinated with the attorney, you are working blind."}
        ]
      },
      {
        "id": "lesson-4",
        "title": "The Operational Mechanics — Forms, Signatures, Custodian Workflows",
        "summary": "The day-to-day of implementation is paperwork, signatures, and custodian-specific quirks. Knowing what each step actually requires saves time and prevents errors.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "Every custodian — Schwab, Fidelity, Pershing, Goldman Sachs Custody Solutions, others — has its own forms, its own workflows, its own quirks. Multiply this by the dozens of operational tasks in a typical client relationship and the operational load gets significant. Master the basic toolkit and you can navigate any custodian's specifics."},
          {"type": "subheading", "content": "Common forms an apprentice will handle"},
          {"type": "glossary", "terms": [
            {"term": "New account application", "definition": "Opens a new account with the custodian. Requires identity verification (KYC), investment objectives, risk tolerance, source of funds, and signed agreements."},
            {"term": "ACAT transfer", "definition": "Automated Customer Account Transfer Service. The industry standard for transferring securities between brokerage accounts. Typically 5-10 business days."},
            {"term": "Letter of Acceptance (LOA)", "definition": "Document from the receiving custodian confirming they will accept the transfer. Required for some non-standard transfers."},
            {"term": "TOD (Transfer on Death) registration", "definition": "Allows a taxable account to pass directly to a named beneficiary outside probate."},
            {"term": "Beneficiary designation form", "definition": "Names primary and contingent beneficiaries for retirement accounts and insurance products. Must specify percentages totaling 100% within each category."},
            {"term": "Standing instruction / Letter of Authorization", "definition": "Allows recurring transfers or specific authority. Some are good only for one occurrence; some are durable."},
            {"term": "W-9 / W-8BEN", "definition": "Tax certification forms. W-9 for U.S. persons, W-8BEN for non-U.S. persons."},
            {"term": "Distribution form", "definition": "Authorizes a distribution from a retirement account. Specifies amount, tax withholding, payment method."}
          ]},
          {"type": "subheading", "content": "Signature mechanics"},
          {"type": "paragraph", "content": "Most custodians now accept e-signature via DocuSign or equivalent. A few specific forms still require wet signature or notarization — older life insurance policies, certain bank accounts, some retirement plan beneficiary changes when the client is married and the spouse must consent. Know which forms in your firm's typical workflow require wet signature or notarization, and warn the client at the start so they are not surprised by a notary trip."},
          {"type": "subheading", "content": "Spousal consent — easy to miss, expensive when missed"},
          {"type": "paragraph", "content": "Qualified retirement plans (ERISA 401(k)s, profit-sharing plans) require spousal consent for non-spouse beneficiary designations and certain distribution choices. The spouse's signature must be witnessed by a plan representative or notarized. Miss this step and the designation may not be valid. IRAs are not subject to the same federal spousal consent rule (though community property states have their own treatment). Know the rules that apply to the specific account type."},
          {"type": "subheading", "content": "Standard quality checks before submission"},
          {"type": "list", "items": [
            "All required fields completed — no blanks the custodian will reject the form for",
            "Date is current — most forms have a 30-90 day shelf life from signature date",
            "Account numbers match the actual accounts on the custodian's system, not a typo",
            "Dollar amounts and percentages internally consistent — 60/40/0 adds to 100, not 100 with a 5 hiding somewhere",
            "Names spelled exactly as on the account — Robert vs Bob, middle initial vs not",
            "Notary block completed if required — notary's signature, seal, expiration date all present"
          ]},
          {"type": "callout", "kind": "do", "content": "Have a second person on the team review any consequential form before submission. Two sets of eyes catch errors one set misses. The marginal time cost is minutes. The cost of a rejected form is days."},
          {"type": "case_study", "title": "The beneficiary form that did not count", "scenario": "An apprentice helps a client update the beneficiary on a 401(k) from 'estate' to 'spouse 100%.' The form is signed by the client and submitted. Three months later when the apprentice does a routine review, they pull up the plan portal and notice the designation still shows 'estate.' On investigation: the plan's beneficiary form requires spousal consent for the change to be valid, and the spousal consent line was blank. The plan administrator processed the form as 'incomplete — no change recorded' but did not notify the apprentice or client. The original beneficiary remained in effect.", "discussion": "Two failures: the form was submitted without spousal consent that was required, and the plan administrator's silent rejection was not detected because nobody verified the change took effect. Process fix: any consequential designation change should be confirmed by pulling the post-change record from the source system within a week of submission. Trust but verify."}
        ]
      },
      {
        "id": "lesson-5",
        "title": "Closing the Loop — Confirming Everything Actually Happened",
        "summary": "Submission is not completion. The implementation phase ends only when every action has been verified on the source system and documented. Closing the loop is the discipline that separates working plans from theatrical ones.",
        "read_time": "10 min read",
        "blocks": [
          {"type": "paragraph", "content": "An apprentice's instinct is to mark an action 'done' when they submit it. The correct discipline is to mark it 'done' only when verified — when the change has appeared in the actual source system, when the beneficiary shows correctly in the plan portal, when the rollover has settled in the receiving account at the right amount, when the form has been processed by the custodian rather than rejected, when the trust has been funded with the asset rather than just listed in the trust document. Trust the system once. Verify the system always."},
          {"type": "subheading", "content": "Verification practices for common tasks"},
          {"type": "list", "items": [
            "Account opening — pull the new account record and confirm: title is correct, registration matches, beneficiaries are populated, all features (TOD, check-writing, debit access) are configured as intended",
            "Asset transfer — confirm the dollar amount that arrived matches what was sent (within reasonable cost-basis transfer accuracy); review the cost basis on transferred securities for accuracy",
            "Beneficiary change — pull the post-change designation page and confirm the new beneficiaries are present at the correct percentages",
            "Contribution change — confirm the change is reflected in the next pay period or contribution cycle, not just in the request",
            "Distribution — confirm the dollar amount received matches the requested amount and withholding; confirm tax withholding was correctly applied",
            "Roth conversion — confirm the converted amount left the traditional account and arrived in the Roth, with the correct tax-year coding for reporting"
          ]},
          {"type": "subheading", "content": "Document everything"},
          {"type": "paragraph", "content": "Every implementation action generates an artifact — a confirmation number, a screenshot, an email, a paper statement. File each one in the client folder with a date and a short description. This is not paranoia. This is the audit trail that protects the client and the firm if a question arises a year or five years later. 'I submitted that change' is not a defensible statement. 'Here is the confirmation showing the change was made on March 14 at 11:42am' is."},
          {"type": "subheading", "content": "Communicate completion to the client"},
          {"type": "paragraph", "content": "When an action is verified complete, tell the client. A simple email — 'The Roth conversion of $66,000 was completed on October 12; you will receive a 1099-R from the custodian in January. The CPA has been copied' — gives the client confidence that the work is happening and creates a record they can refer back to. The cumulative effect of these small communications is enormous over the course of a year. Clients who hear from their advisor about completed work feel taken care of. Clients who never hear anything assume nothing is happening."},
          {"type": "subheading", "content": "The implementation review at the end"},
          {"type": "paragraph", "content": "Once the implementation phase of a new plan or a major change is complete, hold a brief internal review: did every action item complete, what took longer than expected, what surfaced unexpected complications, what should we do differently next time. This is not a long meeting. Twenty minutes. The point is to keep getting better at the operational work, which compounds across hundreds of clients over a career."},
          {"type": "case_study", "title": "Closing out Marcus and Tasha's first 90 days", "scenario": "Of the six action items from the presentation meeting, five completed within the target dates. The sixth — the auto-transfer setup for $400 bi-weekly — was set up but the initial transfer date was set to the wrong day, missing the first paycheck cycle. The apprentice caught it because they had a tracker item to verify the first transfer hit. They corrected the date, the second cycle ran clean, and they emailed Tasha to confirm. Six of six items now verified complete. The apprentice writes a one-page summary for the client: what was done, current state of accounts, next review date.", "discussion": "Without the verification step, the missed first transfer would have surfaced months later as 'wait, we have less in the emergency fund than I expected.' The discipline of confirming each action on the source system caught the error within days. The summary email also doubled as a touchpoint that reinforced the client relationship."},
          {"type": "callout", "kind": "key", "content": "Implementation ends when verified, not when submitted. The verification habit, more than any other operational skill, separates apprentices who become trusted counselors from those who stay junior forever."},
          {"type": "divider"},
          {"type": "paragraph", "content": "Next module: the relationship does not end with implementation. Ongoing reviews, life events, and the long-term cadence of the planning relationship."}
        ]
      }
    ],
    "quiz": {
      "passing_score": 80,
      "questions": [
        {"id": "q1", "prompt": "An action item should be marked complete when:", "options": ["The form was submitted", "The client confirmed they did their part", "The change has been verified on the source system", "The follow-up meeting is scheduled"], "correct": 2, "explanation": "Submission is not completion. Verification on the actual system the change affects is the only valid completion signal."},
        {"id": "q2", "prompt": "On a new account, beneficiary designations should be:", "options": ["Updated within 30 days of opening", "Updated at the next annual review", "Updated the same day the account opens, with primary and contingent beneficiaries both designated", "Optional — wills cover everything"], "correct": 2, "explanation": "Beneficiaries trump wills. Default beneficiary on most accounts is 'estate,' which is the worst outcome. Update same-day, always."},
        {"id": "q3", "prompt": "Direct rollover versus indirect rollover — the direct rollover is preferred because:", "options": ["It is faster", "It avoids mandatory 20% tax withholding and the 60-day redeposit risk", "It costs less", "It is required by law"], "correct": 1, "explanation": "Direct rollovers move funds custodian-to-custodian without withholding and without the 60-day clock. Indirect rollovers trigger 20% mandatory federal withholding on pre-tax balances."},
        {"id": "q4", "prompt": "Before reaching out to a client's CPA to discuss their tax situation, you need:", "options": ["The CPA's business card", "Written authorization from the client to communicate with the CPA", "The client's verbal okay on the phone", "Nothing — CPAs can always discuss their clients"], "correct": 1, "explanation": "Written authorization (Authorization to Release Information) is required. Without it, the CPA legally cannot discuss the client's tax situation with you."},
        {"id": "q5", "prompt": "When replacing one insurance policy with another, the correct sequence is:", "options": ["Cancel the old policy first to save money during application", "Apply for the new policy, get it issued and in force with premiums paid, then cancel the old", "Submit both simultaneously", "Let the policies overlap for at least six months"], "correct": 1, "explanation": "Never leave the client uninsured during a gap. The new policy must be issued and in force before the old policy is canceled."},
        {"id": "q6", "prompt": "A Roth conversion intended for the current tax year must be completed:", "options": ["By April 15 of the following year", "By the client's tax filing deadline", "Before December 31 of the conversion year", "Within 60 days of starting the process"], "correct": 2, "explanation": "Roth conversions count for the tax year in which the conversion completes — funds must leave the traditional IRA and arrive in the Roth before December 31."},
        {"id": "q7", "prompt": "Qualified ERISA retirement plans like 401(k)s require spousal consent for:", "options": ["All distributions of any size", "Non-spouse beneficiary designations and certain distribution choices, with the spouse's signature witnessed or notarized", "Account opening", "Investment changes"], "correct": 1, "explanation": "ERISA spousal consent applies to non-spouse beneficiary designations and certain distribution elections. Missing the consent invalidates the change."},
        {"id": "q8", "prompt": "Implementation status of 'Waiting On Custodian' for ten business days should trigger:", "options": ["Continued patience", "Escalation — something is likely stuck and needs follow-up", "Automatic reassignment to another team member", "Marking the item complete"], "correct": 1, "explanation": "Items do not unstick themselves. Ten business days of waiting on a custodian is the threshold to escalate and find out what is blocking."},
        {"id": "q9", "prompt": "The Letter of Acceptance (LOA) is used in implementation to:", "options": ["Confirm a client's identity", "Document that the receiving custodian will accept a non-standard transfer", "Authorize standing instructions", "Acknowledge fee disclosures"], "correct": 1, "explanation": "An LOA from the receiving custodian confirms they will accept the inbound transfer, especially for non-standard assets or registrations."},
        {"id": "q10", "prompt": "Year-end tax planning conversations with the CPA should ideally happen:", "options": ["In December, just before deadlines", "In October or early November, before tax season pressure", "In April after returns are filed", "Anytime in the year"], "correct": 1, "explanation": "October/early November leaves enough time to execute moves before December 31 and avoids the March-April CPA unavailability."},
        {"id": "q11", "prompt": "If a rollover check arrives at the client's house made payable to the client, the right move is to:", "options": ["Deposit it to the client's checking account immediately", "Stop, document, and call the sending custodian to reissue the check made payable to the receiving custodian for the benefit of the client", "Cash it and use the proceeds for the rollover", "Hold it for 60 days"], "correct": 1, "explanation": "A check payable to the client is an indirect rollover. Reissue properly as a direct rollover to avoid the 20% withholding and 60-day clock."},
        {"id": "q12", "prompt": "The post-implementation review with the team should focus on:", "options": ["Assigning blame for any items that took longer than expected", "Identifying what surfaced unexpected complications and what to do differently next time", "Renegotiating client fees", "Marketing the firm's services"], "correct": 1, "explanation": "The review is a process improvement exercise — capture what surfaced, what slowed things down, and what should change going forward. Operational learning compounds across hundreds of clients."}
      ]
    }
  }
  $jsonb$::jsonb,
  updated_at = now()
where module_number = 17;
