-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 5 CONTENT
-- Tax Fundamentals
-- ============================================================================

update public.modules set
  title = 'Tax Fundamentals',
  competency_id = 'CORE-5',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How the U.S. tax system actually works, the levers an advisor can pull, and the lines that require referring out to a CPA.',
  learning_objectives = ARRAY[
    'Distinguish marginal from effective tax rates and explain both clearly to a client.',
    'Identify the seven federal income tax brackets and how they apply to ordinary income.',
    'Distinguish ordinary income, long-term capital gains, and qualified dividend tax treatment.',
    'Explain the difference between Traditional and Roth tax-advantaged accounts and when each fits.',
    'Apply standard vs. itemized deduction logic and identify common itemizable deductions.',
    'Recognize when a tax situation requires referral to a CPA or tax attorney.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "How the U.S. Income Tax Actually Works",
      "summary": "Marginal vs. effective rates, brackets, and the structural picture every counselor must hold.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax is the single largest line item over most working-class households' lifetimes, and one of the most misunderstood. A Wealth Solutions Counselor isn't a CPA — and shouldn't pretend to be — but does need to hold a clear structural picture of how income tax works to give competent advice on saving, investing, and retirement decisions." },

        { "type": "heading", "text": "The U.S. uses a progressive bracket system" },
        { "type": "paragraph", "text": "Federal income tax is calculated in <strong>brackets</strong>. Each layer of income is taxed at a different rate. The marginal rate is the rate on the <em>next dollar earned</em>. The effective rate is the <em>average</em> rate paid across all income." },
        { "type": "callout", "kind": "key", "title": "The most common misunderstanding", "text": "Clients frequently believe that crossing a tax bracket means all of their income is taxed at the higher rate. <strong>This is wrong.</strong> Only the income in that bracket is taxed at that rate. A single filer earning $100,000 doesn't \"jump to 24%\" on everything — only the dollars above the 24% bracket threshold are taxed at 24%." },

        { "type": "subheading", "text": "2025 federal brackets (single filer, ordinary income)" },
        { "type": "paragraph", "text": "Approximate brackets — refer to the IRS official tables for exact figures, which are inflation-adjusted yearly:" },
        { "type": "list", "items": [
          "10% — up to ~$11,925",
          "12% — ~$11,925 to ~$48,475",
          "22% — ~$48,475 to ~$103,350",
          "24% — ~$103,350 to ~$197,300",
          "32% — ~$197,300 to ~$250,525",
          "35% — ~$250,525 to ~$626,350",
          "37% — above ~$626,350"
        ]},
        { "type": "callout", "kind": "note", "title": "Married filing jointly brackets are different", "text": "Generally roughly double the single-filer thresholds (though not exactly, due to historical \"marriage penalty\" considerations). Head of household brackets sit between single and MFJ. Always verify filing status before quoting rates." },

        { "type": "heading", "text": "The marginal rate calculation" },
        { "type": "paragraph", "text": "A single filer with $75,000 taxable income:" },
        { "type": "list", "items": [
          "First ~$11,925 taxed at 10% = ~$1,193",
          "Next ~$36,550 (from $11,925 to $48,475) taxed at 12% = ~$4,386",
          "Next ~$26,525 (from $48,475 to $75,000) taxed at 22% = ~$5,836",
          "<strong>Total federal tax: ~$11,415</strong>",
          "<strong>Marginal rate (rate on next dollar): 22%</strong>",
          "<strong>Effective rate ($11,415 / $75,000): ~15.2%</strong>"
        ]},

        { "type": "callout", "kind": "key", "title": "When to use which", "text": "Use the <strong>marginal rate</strong> when evaluating decisions about additional income or deductions (\"how much will I save by contributing $10,000 to a traditional 401(k)?\"). Use the <strong>effective rate</strong> when describing overall tax burden (\"how much of my income goes to federal tax?\")." },

        { "type": "divider" },

        { "type": "heading", "text": "Other federal taxes to know" },
        { "type": "list", "items": [
          "<strong>FICA</strong> — Social Security (6.2% on wages up to ~$168,600 in 2025) + Medicare (1.45% on all wages). Self-employed pay both halves (15.3% total) but deduct half on Schedule SE.",
          "<strong>Additional Medicare tax</strong> — 0.9% on wages over $200,000 single / $250,000 MFJ.",
          "<strong>Net investment income tax (NIIT)</strong> — 3.8% on investment income for high earners (over $200K single / $250K MFJ AGI).",
          "<strong>Capital gains tax</strong> — separate rate schedule for long-term gains and qualified dividends (covered in next lesson)."
        ]},

        { "type": "heading", "text": "State and local" },
        { "type": "paragraph", "text": "Vary enormously. Nine states have no income tax (including Texas, Florida, Washington, Nevada). High-tax states like California can add 13.3% at the top bracket. Some states (like California) also tax capital gains as ordinary income. Always know the state context before quoting an effective rate." },

        { "type": "callout", "kind": "do", "title": "The fluency reflex", "text": "When a client mentions a financial decision, your reflex should include: <em>what's their marginal rate?</em> A traditional 401(k) contribution saves the marginal rate now and is taxed at the future marginal rate at withdrawal. A Roth contribution saves nothing now and is tax-free later. Whether to choose Traditional or Roth depends entirely on the comparison between current and future marginal rates." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Capital Gains, Dividends, and Investment Income",
      "summary": "How investment income is taxed differently — and why that matters for every plan.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Not all income is taxed the same. Investment income gets preferential treatment in several ways, and understanding those preferences is half the job of an advisor working with anyone who has taxable investments." },

        { "type": "heading", "text": "Capital gains: short-term vs. long-term" },
        { "type": "list", "items": [
          "<strong>Short-term capital gain</strong> — sale of an asset held for one year or less. Taxed as <em>ordinary income</em>, at the client's marginal rate.",
          "<strong>Long-term capital gain</strong> — sale of an asset held more than one year. Taxed at preferential rates: 0%, 15%, or 20% federal, depending on total taxable income."
        ]},
        { "type": "callout", "kind": "key", "title": "The 0% long-term bracket", "text": "Long-term capital gains are taxed at <strong>0%</strong> federally when total taxable income (including the gain) is below approximately $48,350 single or $96,700 MFJ in 2025. This is an enormous planning opportunity for clients in lower-income years — early retirement before Social Security, between jobs, during a sabbatical. Selling appreciated assets in a 0% bracket year is materially different from selling in a high-income year." },

        { "type": "heading", "text": "Long-term capital gains brackets (2025 approximate)" },
        { "type": "list", "items": [
          "<strong>0%</strong> — taxable income up to ~$48,350 single / ~$96,700 MFJ",
          "<strong>15%</strong> — taxable income up to ~$533,400 single / ~$600,050 MFJ",
          "<strong>20%</strong> — above those thresholds"
        ]},
        { "type": "paragraph", "text": "Plus the 3.8% Net Investment Income Tax for clients with AGI over $200K single / $250K MFJ, which stacks on top. So the practical top federal rate on long-term gains can be 23.8%." },

        { "type": "heading", "text": "Dividends: qualified vs. ordinary" },
        { "type": "list", "items": [
          "<strong>Qualified dividends</strong> — paid by U.S. corporations and certain foreign corporations on stock held more than 60 days. Taxed at long-term capital gains rates (0/15/20%).",
          "<strong>Ordinary (non-qualified) dividends</strong> — most REIT distributions, money market fund dividends, dividends on stock held under 60 days. Taxed as ordinary income at the marginal rate."
        ]},
        { "type": "callout", "kind": "note", "title": "Why REITs go in tax-advantaged accounts", "text": "REIT distributions are mostly ordinary dividends, taxed at ordinary rates — often the client's highest rate. For taxable accounts this is inefficient. The standard recommendation is to hold REITs inside an IRA or 401(k), where the distributions are sheltered. This is one of the most common asset-location moves an advisor will make." },

        { "type": "heading", "text": "Interest income" },
        { "type": "paragraph", "text": "Most interest — bank interest, CD interest, corporate bond interest — is ordinary income, taxed at the marginal rate. A few categories get preferential treatment:" },
        { "type": "list", "items": [
          "<strong>Treasury interest</strong> — federally taxable, but exempt from state and local tax. Material in high-tax states.",
          "<strong>Municipal bond interest</strong> — federally tax-exempt; often also state-exempt if issued by the client's home state.",
          "<strong>I-bond and EE-bond interest</strong> — federally taxable when redeemed (or accrued), state-exempt."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Tax-loss harvesting (introduction)" },
        { "type": "paragraph", "text": "When an investment is sold at a loss, the loss can offset capital gains and up to $3,000/year of ordinary income. Unused losses carry forward indefinitely. This creates a planning opportunity: selling losers strategically to capture tax savings while maintaining market exposure (via similar but not \"substantially identical\" replacements)." },
        { "type": "callout", "kind": "warn", "title": "The wash sale rule", "text": "If you sell at a loss and buy the same security (or a substantially identical one) within 30 days before or after, the loss is disallowed. Cost basis is adjusted. The IRS rule exists to prevent fake losses; advisors navigate it by buying a similar-but-not-identical replacement (e.g., sell VTI, buy ITOT) or by waiting 31+ days before buying back." },
        { "type": "callout", "kind": "note", "title": "Deeper treatment ahead", "text": "Module 24 covers tax-loss harvesting and tax-aware investing in depth. This module establishes the foundation; that module shows the execution." },

        { "type": "case_study",
          "title": "Why long-term matters",
          "scenario": "A client buys $50,000 of a stock at the start of the year and watches it rise to $70,000 in 11 months. They want to lock in the gain. Should they sell now, or hold one more month?",
          "discussion": "<p>Selling at 11 months: $20,000 short-term gain, taxed as ordinary income. If the client is in the 32% bracket, the federal tax is $6,400.</p><p>Selling at 12 months and 1 day: $20,000 long-term gain, taxed at 15%. Federal tax: $3,000. Possibly plus 3.8% NIIT if AGI is high enough.</p><p><strong>Difference: $3,400 in federal tax for one month of patience.</strong></p><p>The 30+ day patience is one of the highest-yield single-decision wins an advisor can flag. It doesn't apply when the market thesis genuinely demands selling now, and it doesn't apply when the gain is small enough that the bracket math doesn't matter. But for many clients in many situations, this conversation is pure value-add.</p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Tax-Advantaged Accounts and the Traditional vs. Roth Decision",
      "summary": "Where saving lives, and the trade-off every contribution decision boils down to.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax-advantaged accounts are the most powerful wealth-building tools available to ordinary households. They come in two main flavors — tax-deferred and tax-free — and choosing between them is a recurring decision throughout a working life." },

        { "type": "heading", "text": "The two flavors" },
        { "type": "glossary", "terms": [
          { "term": "Tax-deferred (Traditional)", "definition": "Contributions are deductible now. Growth is deferred. Withdrawals in retirement are taxed as ordinary income. Saves taxes today; pays taxes tomorrow. Includes Traditional 401(k), Traditional IRA, 403(b), 457(b)." },
          { "term": "Tax-free (Roth)", "definition": "Contributions are after-tax (no deduction now). Growth is tax-free. Qualified withdrawals in retirement are tax-free. Pays taxes today; saves taxes tomorrow. Includes Roth 401(k), Roth IRA, Roth 403(b)." }
        ]},

        { "type": "callout", "kind": "key", "title": "The simple framework", "text": "<strong>Higher marginal rate today than expected in retirement</strong> → favor Traditional (defer at the higher rate, pay at the lower rate).<br/><strong>Lower marginal rate today than expected in retirement</strong> → favor Roth (pay at the lower rate now, take it out tax-free at the higher rate).<br/><strong>Uncertain or roughly equal</strong> → diversify across both for tax flexibility in retirement." },

        { "type": "heading", "text": "Contribution limits (2025, approximate)" },
        { "type": "list", "items": [
          "<strong>401(k) / 403(b)</strong>: $23,500 employee contribution. Catch-up $7,500 if 50+. New 'super catch-up' of ~$11,250 for ages 60–63.",
          "<strong>IRA (Traditional or Roth)</strong>: $7,000. Catch-up $1,000 if 50+.",
          "<strong>HSA</strong>: $4,300 single / $8,550 family. Catch-up $1,000 if 55+.",
          "<strong>SEP-IRA</strong>: up to ~25% of compensation, capped at $70,000.",
          "<strong>Solo 401(k)</strong>: same employee limit as workplace 401(k) plus employer profit-sharing up to combined ~$70,000."
        ]},
        { "type": "callout", "kind": "note", "title": "Roth IRA income limits", "text": "Roth IRA contributions phase out for high earners: $150K–$165K MAGI single, $236K–$246K MFJ in 2025 (approximate). Above those limits, direct Roth contributions aren't allowed — but the 'backdoor Roth' (contribute to Traditional IRA, immediately convert to Roth) remains legal for those without other pretax IRA balances. Workplace Roth 401(k) has no income limit." },

        { "type": "heading", "text": "The employer match" },
        { "type": "paragraph", "text": "If an employer offers a 401(k) match, contributing enough to capture the full match is the universal first move. A 50% or 100% match is an immediate, guaranteed return on the contribution before any market exposure. Almost no other recommendation outranks capturing employer match." },
        { "type": "callout", "kind": "do", "title": "The order of operations", "text": "<strong>(1)</strong> Capture full employer 401(k) match. <strong>(2)</strong> Max HSA if HDHP-eligible. <strong>(3)</strong> Max Roth IRA. <strong>(4)</strong> Increase 401(k) toward the contribution limit. <strong>(5)</strong> Taxable brokerage. This order maximizes tax efficiency for most middle- and upper-middle-income households. Exceptions exist for very high earners (mega backdoor Roth) and for households still building their starter emergency fund, but the order is the default." },

        { "type": "divider" },

        { "type": "heading", "text": "Required minimum distributions (RMDs)" },
        { "type": "paragraph", "text": "Tax-deferred accounts can't grow forever untaxed. The IRS requires withdrawals starting at age 73 (rising to 75 by 2033 under SECURE 2.0). RMDs are calculated based on account balance and life expectancy tables. Missing an RMD carries severe penalties — historically 50%, reduced to 25% (or 10% if corrected quickly) under SECURE 2.0." },
        { "type": "list", "items": [
          "RMDs apply to Traditional IRAs, 401(k)s, 403(b)s, and inherited retirement accounts.",
          "Roth IRAs do NOT have RMDs during the original owner's lifetime — one of their structural advantages.",
          "Roth 401(k)s previously had RMDs but SECURE 2.0 eliminated them starting in 2024."
        ]},

        { "type": "case_study",
          "title": "Naomi reconsiders the Roth question",
          "scenario": "Naomi (analyst, $90K salary, single, 34) currently contributes $500/month to a Traditional 401(k). Her marginal federal rate is 22%, plus 9.3% California state — roughly 31% combined. She expects to retire in California or another high-tax state. Should she be contributing to Traditional or Roth?",
          "discussion": "<p>The simple rule: contribute Traditional if today's marginal rate is higher than expected retirement rate; Roth if lower.</p><p>Naomi's current combined rate: ~31%. Expected retirement rate depends on retirement income. If she retires with $1.5M and draws $60K/year, her retirement marginal rate is likely 12% federal + state — call it ~21% combined. <strong>Today's rate is higher than retirement rate → Traditional is the better default for her right now.</strong></p><p>But Naomi is 34 with rising earning potential. As her income grows, the calculus shifts. By the time her marginal rate is 35–40%, Traditional still likely wins on math. But she has a long Roth-friendly window: any year her income drops (sabbatical, transition, layoff), Roth contributions become attractive.</p><p><strong>Recommendation:</strong> Continue Traditional 401(k) for now, but open a Roth IRA on the side and contribute up to the limit ($7,000/year for 2025). This builds a tax-diversified base — half deferred, half tax-free — and gives her flexibility in retirement to manage which bucket to pull from in which year. The split tends to outperform either pure strategy over a long career.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Deductions, Credits, and the Standard Choice",
      "summary": "How the tax base is reduced — and the moves a client can plan for.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax liability is computed on <em>taxable income</em>, not gross income. Deductions and credits are the two main mechanisms that reduce what's owed. Understanding the difference, and recognizing which moves are available, is the foundation for any tax conversation." },

        { "type": "heading", "text": "Deductions reduce taxable income" },
        { "type": "paragraph", "text": "A $10,000 deduction for a client in the 24% bracket reduces tax owed by $2,400 (24% of $10,000). The benefit scales with the bracket — same deduction is worth more to a higher earner." },

        { "type": "subheading", "text": "Standard vs. itemized" },
        { "type": "paragraph", "text": "Every filer can choose the standard deduction (a flat dollar amount based on filing status) OR itemize specific deductions. Take whichever is larger." },
        { "type": "list", "items": [
          "<strong>Standard deduction (2025 approximate)</strong>: $15,000 single / $30,000 MFJ / $22,500 HoH. Plus additional amounts for age 65+ and blind filers.",
          "<strong>Itemized deductions</strong> (on Schedule A): state and local taxes (capped at $10,000), mortgage interest (on up to $750,000 of acquisition debt for post-2017 loans), charitable contributions, medical expenses above 7.5% of AGI, and a few specialty categories."
        ]},
        { "type": "callout", "kind": "note", "title": "Why most clients now take the standard", "text": "The 2017 Tax Cuts and Jobs Act roughly doubled the standard deduction and capped the state/local tax (SALT) deduction at $10,000. The combination pushed roughly 90% of filers to the standard deduction. Itemizing typically only beats the standard for high-mortgage, high-SALT, or large-charitable households." },

        { "type": "heading", "text": "Above-the-line deductions" },
        { "type": "paragraph", "text": "Some deductions are available <em>without</em> itemizing — they reduce AGI directly. The most important to a counselor:" },
        { "type": "list", "items": [
          "<strong>Traditional 401(k) and 403(b) contributions</strong> — reduce taxable wages reported on W-2.",
          "<strong>Traditional IRA contributions</strong> — deductible subject to income phaseouts if the filer is covered by a workplace plan.",
          "<strong>HSA contributions</strong> — pre-tax through payroll, or deductible if made directly.",
          "<strong>Self-employed retirement contributions</strong> — SEP, Solo 401(k), SIMPLE deducted on Schedule 1.",
          "<strong>Student loan interest</strong> — up to $2,500/year, with income phaseouts.",
          "<strong>Self-employed health insurance</strong> — premiums for self-employed and their families."
        ]},
        { "type": "callout", "kind": "do", "title": "Where the planning happens", "text": "Above-the-line moves are where advisors create the most consistent value. They reduce AGI, which cascades into eligibility for other benefits (IRA deductibility, education credits, marketplace subsidies, child tax credit). Even a small reduction in AGI can unlock substantial downstream savings. Always check eligibility for every above-the-line opportunity." },

        { "type": "heading", "text": "Credits reduce tax owed dollar-for-dollar" },
        { "type": "paragraph", "text": "A $2,000 credit is worth $2,000 of tax savings, regardless of bracket. Credits are more valuable than deductions of the same dollar amount." },
        { "type": "subheading", "text": "Major federal credits relevant to typical households" },
        { "type": "list", "items": [
          "<strong>Child Tax Credit</strong> — currently $2,000 per qualifying child under 17, phasing out at high incomes.",
          "<strong>Child and Dependent Care Credit</strong> — for daycare and similar costs, up to 35% of qualifying expenses depending on income.",
          "<strong>Earned Income Tax Credit (EITC)</strong> — refundable credit for lower-income working families. Often missed by eligible filers.",
          "<strong>Saver's Credit</strong> — up to $1,000 ($2,000 MFJ) for retirement contributions by lower-income filers.",
          "<strong>American Opportunity / Lifetime Learning</strong> — education credits.",
          "<strong>Residential energy credits</strong> — solar, electric vehicles, energy-efficient home improvements (current rules subject to legislative change).",
          "<strong>Premium Tax Credit</strong> — for ACA marketplace health insurance enrollees."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "AMT (alternative minimum tax) — briefly" },
        { "type": "paragraph", "text": "Parallel tax calculation that disallows certain deductions and applies a flat rate (26% or 28%) above an exemption threshold. Once a much bigger issue; the 2017 TCJA significantly raised the exemption, so AMT now affects relatively few filers — mostly very high earners and those exercising large amounts of incentive stock options (ISOs). Worth knowing exists; rare to actually navigate." },

        { "type": "callout", "kind": "key", "title": "The line that requires referring out", "text": "Tax planning conversation is in scope for a counselor. <em>Tax preparation and filing</em> is not. Once a client has a complex tax situation — small business, rental property, multiple states, equity compensation, significant capital gains, foreign income, partnership interests — the right move is to bring in a CPA, ideally one your firm has a referral relationship with. The advisor's role is to identify the moves and coordinate; the CPA executes the filing." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Tax-Aware Planning Through the Year",
      "summary": "The recurring moves and the once-a-year audit that turn tax from cost into lever.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax planning isn't an April activity. Most useful tax moves happen during the year — contributions adjusted in real time, harvesting executed at the right window, Roth conversions sized to fill specific brackets. The annual tax review is when the year's moves are checked and next year's are planned." },

        { "type": "heading", "text": "The recurring moves" },

        { "type": "subheading", "text": "Quarterly: estimated tax payments" },
        { "type": "paragraph", "text": "Required for anyone with substantial non-W2 income (self-employment, large capital gains, RMDs). Due April 15, June 15, September 15, and January 15. Safe harbor: pay 100% of last year's tax liability (110% if AGI over $150K), or 90% of current year's liability. Underpayment penalties are non-trivial." },

        { "type": "subheading", "text": "October: open enrollment + benefit elections" },
        { "type": "paragraph", "text": "Confirm 401(k) contribution rate, FSA/HSA elections, dependent care FSA, commuter benefits. These are pre-tax dollars locked in for the next year — the advisor's role is to make sure none are left on the table." },

        { "type": "subheading", "text": "November–December: end-of-year planning window" },
        { "type": "list", "items": [
          "Capital gain/loss harvesting before year-end",
          "Sizing Roth conversions to fill a target bracket",
          "Bunching charitable contributions if itemizing is close (Donor-Advised Funds enable this)",
          "Confirming RMDs taken if 73+",
          "Maximizing remaining 401(k) contributions if room exists",
          "Year-end gifts using annual gift exclusion ($19,000 per recipient in 2025) if estate planning is in scope"
        ]},

        { "type": "subheading", "text": "January–April: tax preparation season" },
        { "type": "paragraph", "text": "Documents arrive (W-2, 1099s, K-1s, mortgage interest statements). Filing happens by April 15 (or extension). Final IRA and HSA contributions for the prior year can be made through April 15 — last chance to deduct." },

        { "type": "divider" },

        { "type": "heading", "text": "Roth conversions" },
        { "type": "paragraph", "text": "Convert money from a Traditional IRA to a Roth IRA. The converted amount is treated as taxable income in the conversion year. Once converted, the money grows and withdraws tax-free." },
        { "type": "subheading", "text": "When conversions make sense" },
        { "type": "list", "items": [
          "<strong>Low-income year</strong> — between jobs, early retirement before RMDs and Social Security, sabbatical. Fill up brackets that would otherwise be empty.",
          "<strong>Expected future tax increase</strong> — pay tax at today's rate to lock in tomorrow's tax-free growth.",
          "<strong>Estate planning</strong> — Roth IRAs pass to heirs tax-free; Traditional IRAs are taxable income to the heir. A taxable Roth conversion paid by the original owner effectively pre-pays the heir's tax bill at the owner's lower bracket.",
          "<strong>Filling a target bracket</strong> — convert exactly enough to use the 12% or 22% bracket without spilling into 24% or higher."
        ]},
        { "type": "callout", "kind": "warn", "title": "The IRMAA and ACA cliffs", "text": "Conversions add to MAGI, which can trigger higher Medicare premiums (IRMAA) for retirees on Medicare, or push families off ACA marketplace subsidies. Always check downstream effects before sizing the conversion. The tax savings may be smaller than they look once you factor in lost benefits." },

        { "type": "heading", "text": "The annual tax review checklist" },
        { "type": "paragraph", "text": "Once a year, work through the following for every client:" },
        { "type": "numbered", "items": [
          "Look at last year's return — what's the marginal rate, effective rate, total tax paid?",
          "Are all available pre-tax contributions being maximized? (401k, HSA, IRA where deductible)",
          "Is the Traditional/Roth balance appropriate given current vs. expected future rates?",
          "Were there capital gains realized that could have been harvested earlier or deferred?",
          "Are tax-inefficient assets (REITs, taxable bonds, high-turnover funds) inside tax-advantaged accounts?",
          "Is the client maximizing employer match?",
          "Are there charitable contributions that could be bunched, donated as appreciated securities, or routed through a DAF?",
          "Are state-tax considerations being captured (residency, source of income, state-specific deductions)?",
          "Is the filing status optimal (especially relevant in years of major life events)?",
          "Are estimated tax payments on track to avoid underpayment penalty?"
        ]},

        { "type": "callout", "kind": "key", "title": "The frame", "text": "Tax is not a fixed cost. It's the line item where consistent, knowledgeable attention pays the most for the least work. A counselor who covers the items in this list each year creates value far in excess of their fee — often without the client noticing. That's the standard." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A single filer with $75,000 of taxable income is in the 22% bracket. What does that mean?",
        "options": [
          "All $75,000 of income is taxed at 22%.",
          "The next dollar earned is taxed at 22%, but income within lower brackets is taxed at lower rates. The effective rate is lower than 22%.",
          "The client pays 22% in tax to the federal government.",
          "Only state tax applies; federal is 22%."
        ],
        "correct": 1,
        "explanation": "Marginal rate is the rate on the next dollar. Effective rate is the average across all dollars. The client's effective rate is around 15%, not 22%, because lower-bracket dollars are taxed at lower rates."
      },
      {
        "id": "q2",
        "prompt": "Why does the timing of selling an appreciated asset (just before vs. just after the one-year mark) often matter so much?",
        "options": [
          "Because the asset's price will change.",
          "Because long-term capital gains (held more than one year) are taxed at preferential rates (0/15/20%) instead of ordinary income rates that can exceed 37%.",
          "Because the IRS audits short-term gains more often.",
          "Because the client's bracket changes by the calendar."
        ],
        "correct": 1,
        "explanation": "Short-term gain = ordinary income, up to 37% federal. Long-term gain = 0/15/20% federal. The difference on a large gain can be tens of thousands of dollars for one extra month of patience."
      },
      {
        "id": "q3",
        "prompt": "Which of the following is generally the right ordering for an early-career employee's retirement savings?",
        "options": [
          "Max Traditional IRA, then taxable brokerage, then 401(k) match.",
          "Capture full employer 401(k) match, max HSA if eligible, max Roth IRA, increase 401(k) toward contribution limit, then taxable brokerage.",
          "Max 401(k) regardless of match, then ignore IRA.",
          "Whole life insurance, then any of the above."
        ],
        "correct": 1,
        "explanation": "The match is the highest-priority free money. HSA is structurally one of the best accounts available. Roth IRA contributions are limited and disappear with income, so they should be captured during eligible years. Beyond that, raise 401(k) toward the limit before going to taxable."
      },
      {
        "id": "q4",
        "prompt": "A client with a $1M Traditional IRA wants to convert $50,000 to a Roth this year. What's the most important downstream consideration before sizing the conversion?",
        "options": [
          "Whether the client likes Roth IRAs.",
          "Whether the conversion will push the client past Medicare IRMAA thresholds, ACA subsidy cliffs, or into a higher marginal bracket than intended.",
          "Whether the market is currently up or down.",
          "Whether the client is married."
        ],
        "correct": 1,
        "explanation": "Roth conversions add to MAGI. That can raise Medicare premiums (IRMAA), kill ACA marketplace subsidies, and push income into higher brackets than intended. Always check downstream effects before sizing the conversion."
      },
      {
        "id": "q5",
        "prompt": "What is the wash sale rule?",
        "options": [
          "Investors can't sell a stock at a loss and buy the same (or substantially identical) security within 30 days before or after; the loss is disallowed for that year.",
          "Investors must wait 30 days between buys.",
          "All capital losses are disallowed.",
          "Only applies to mutual funds, not individual stocks."
        ],
        "correct": 0,
        "explanation": "Sell at a loss and buy back the same security within 30 days (before or after the sale) and the loss is disallowed. Cost basis is adjusted. Workaround: buy a similar but not 'substantially identical' security, or wait 31+ days."
      },
      {
        "id": "q6",
        "prompt": "Why are REITs typically held in tax-advantaged accounts rather than taxable accounts?",
        "options": [
          "They have higher fees in taxable accounts.",
          "REIT distributions are mostly ordinary dividends taxed at the client's marginal rate, which is usually higher than the capital gains rate. Sheltering them inside a tax-advantaged account avoids that ordinary-income drag.",
          "REITs are illegal in taxable accounts.",
          "REITs only pay dividends in tax-advantaged accounts."
        ],
        "correct": 1,
        "explanation": "REIT distributions don't qualify as qualified dividends — they're taxed at ordinary rates. Inside an IRA or 401(k), the ordinary-income drag disappears. This is one of the most common asset-location moves an advisor makes."
      },
      {
        "id": "q7",
        "prompt": "What is the structural difference between a deduction and a credit?",
        "options": [
          "They are the same thing.",
          "A deduction reduces taxable income (so its value depends on bracket). A credit reduces tax owed dollar-for-dollar (so its value is independent of bracket).",
          "A credit is only for low-income filers.",
          "A deduction is more valuable than a credit."
        ],
        "correct": 1,
        "explanation": "Deduction of $1,000 saves $220 in 22% bracket, $370 in 37% bracket. Credit of $1,000 saves $1,000 regardless of bracket. Credits are more valuable than deductions of the same dollar amount."
      },
      {
        "id": "q8",
        "prompt": "What does it mean that long-term capital gains have a '0% bracket'?",
        "options": [
          "All long-term gains are tax-free.",
          "Long-term capital gains are taxed at 0% federally when total taxable income (including the gain) is below approximately $48,350 single / $96,700 MFJ — a major planning opportunity in lower-income years.",
          "The first 0% of gains is tax-free.",
          "Only retirees get 0%."
        ],
        "correct": 1,
        "explanation": "The 0% LTCG bracket is one of the most underused planning windows. Early retirees, sabbatical years, transition years often offer the opportunity to realize appreciated gains entirely tax-free at the federal level."
      },
      {
        "id": "q9",
        "prompt": "When is Roth (rather than Traditional) generally the better contribution choice?",
        "options": [
          "Always — tax-free is best.",
          "When the client's current marginal tax rate is LOWER than their expected marginal rate in retirement. Pay the tax at today's lower rate; take the money out tax-free at tomorrow's higher rate.",
          "When the client is older than 50.",
          "When the client has children."
        ],
        "correct": 1,
        "explanation": "The Roth vs. Traditional decision rests on the comparison between current and expected future marginal rates. Lower today → Roth. Higher today → Traditional. Uncertain or equal → diversify."
      },
      {
        "id": "q10",
        "prompt": "A client says, 'I don't itemize because the standard deduction is bigger.' What's the right advisor move?",
        "options": [
          "Confirm and move on.",
          "Acknowledge, then check whether bunching deductions across years (especially charitable contributions via a Donor-Advised Fund) could push them over the standard deduction every other year and produce material additional savings.",
          "Tell them to itemize anyway.",
          "Recommend they buy a house to get mortgage interest."
        ],
        "correct": 1,
        "explanation": "Bunching is a real technique: stack two years' worth of charitable giving into one calendar year (via a DAF), itemize that year, take the standard in the other. Useful when itemizable totals fall just below the standard."
      },
      {
        "id": "q11",
        "prompt": "Roth IRAs differ from Traditional IRAs in which important way for retirement planning?",
        "options": [
          "Roth IRAs have higher contribution limits.",
          "Roth IRAs do not have required minimum distributions during the owner's lifetime — money can keep growing tax-free indefinitely, then pass to heirs with continued tax advantages.",
          "Roth IRAs are tax-deferred.",
          "Roth IRAs have employer matches."
        ],
        "correct": 1,
        "explanation": "No RMDs for Roth IRAs during the original owner's lifetime is a structural advantage. It enables longer compounding, lets the owner manage withdrawal timing for tax efficiency, and supports estate planning by passing the asset tax-free to heirs."
      },
      {
        "id": "q12",
        "prompt": "What is the right professional response when a client has equity compensation (ISOs, RSUs, ESPP), small business income, and rental property?",
        "options": [
          "File their return for them; the advisor knows enough.",
          "Recognize the complexity exceeds tax-planning scope and bring in a CPA. Advisor coordinates the moves; CPA executes the filing and confirms the technical positions.",
          "Tell the client to look it up online.",
          "Move all their assets to a trust to avoid tax."
        ],
        "correct": 1,
        "explanation": "Tax planning is in scope for the advisor. Tax preparation, especially for complex situations, is out of scope. The right move is referral to a CPA — ideally one in the firm's network — with the advisor staying coordinated."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 5;

-- ============================================================================
-- DONE.
-- ============================================================================
