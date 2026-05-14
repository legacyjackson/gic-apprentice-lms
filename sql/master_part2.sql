-- ================================================================
-- GIC LMS — MASTER SETUP PART 2
-- Run parts in order: 1 → 2 → 3 → 4 → 5
-- ================================================================


-- ── module6_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 6 CONTENT
-- Investment Vehicles & Markets
-- ============================================================================

update public.modules set
  title = 'Investment Vehicles & Markets',
  competency_id = 'CORE-6',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The asset classes, fund wrappers, and market mechanics every counselor must understand before recommending anything.',
  learning_objectives = ARRAY[
    'Distinguish the major asset classes by risk, return, and role in a portfolio.',
    'Explain the structural differences between mutual funds, ETFs, and individual securities.',
    'Compare active and passive management honestly, including evidence on persistence and cost.',
    'Read an expense ratio and convert it into dollar terms over a lifetime.',
    'Describe how a stock trade actually executes, from order to settlement.',
    'Identify common fee structures and the most material costs that erode client returns.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Asset Classes",
      "summary": "What stocks, bonds, cash, and real estate actually are — and how they behave differently.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Before talking about how to invest, an advisor must be fluent in what's being invested in. Asset classes are the categories with distinct risk and return characteristics. The portfolio is a deliberate mix of them, balanced to serve a specific client's goals." },

        { "type": "heading", "text": "Cash and cash equivalents" },
        { "type": "paragraph", "text": "Checking accounts, savings accounts, money market funds, Treasury bills, short-term CDs. Defining characteristics: low volatility, immediate or near-immediate access, low return." },
        { "type": "list", "items": [
          "<strong>Role in a portfolio:</strong> liquidity, emergency reserves, near-term spending needs.",
          "<strong>Long-run real return:</strong> approximately 0%. Cash preserves nominal capital but loses purchasing power to inflation over time.",
          "<strong>When to hold:</strong> emergency fund, money needed within 1–3 years, dry powder for opportunities."
        ]},

        { "type": "heading", "text": "Bonds (fixed income)" },
        { "type": "paragraph", "text": "Loans from investor to borrower (corporation, government, municipality) at a stated interest rate for a stated term. The borrower repays principal at maturity and pays periodic interest in between." },
        { "type": "subheading", "text": "Sub-categories" },
        { "type": "list", "items": [
          "<strong>Treasuries</strong> — U.S. government debt. Considered the safest fixed income. Short-term: T-bills (under 1 year). Medium: T-notes (2–10 years). Long: T-bonds (20–30 years). Treasury Inflation-Protected Securities (TIPS) adjust principal for inflation.",
          "<strong>Investment-grade corporate</strong> — debt of strong corporations (rated BBB- and above). Slightly higher yield than Treasuries; modest default risk.",
          "<strong>High-yield (junk) corporate</strong> — debt of weaker corporations (rated below BBB-). Higher yield, higher default risk, behaves more like equity in downturns.",
          "<strong>Municipal bonds</strong> — issued by state and local governments. Federal tax-exempt interest; sometimes state-exempt for in-state holders. Generally lower coupon but higher after-tax yield for high-bracket investors.",
          "<strong>Mortgage-backed securities (MBS)</strong> — pools of mortgages packaged into bonds. Prepayment risk: when interest rates fall, homeowners refinance and the bonds pay off earlier than expected."
        ]},
        { "type": "callout", "kind": "key", "title": "The bond-price-vs-rate relationship", "text": "When interest rates rise, existing bond prices fall (the existing lower-coupon bonds are worth less than new higher-coupon ones). When rates fall, existing bond prices rise. Long-duration bonds are more sensitive than short-duration. This inverse relationship explains why 2022 was such a difficult year for bond investors — rates rose sharply, and bond prices dropped accordingly." },

        { "type": "heading", "text": "Stocks (equities)" },
        { "type": "paragraph", "text": "Ownership shares in a public company. Investors receive a share of profits (via dividends) and a share of growth (via price appreciation). No maturity date; can be held indefinitely." },
        { "type": "subheading", "text": "Sub-categories" },
        { "type": "list", "items": [
          "<strong>Market cap</strong>: Large-cap (>$10B), mid-cap ($2–10B), small-cap (<$2B), micro-cap. Smaller-cap historically more volatile but higher long-run return.",
          "<strong>Style</strong>: Value (lower P/E, higher dividend) vs. Growth (higher P/E, reinvesting profits for expansion). Both have outperformed in different decades.",
          "<strong>Geography</strong>: U.S., developed international (Europe, Japan), emerging markets (China, India, Brazil). Each provides diversification.",
          "<strong>Sector</strong>: Technology, financials, healthcare, consumer staples, energy, etc. Different sensitivities to economic cycles."
        ]},

        { "type": "heading", "text": "Real estate" },
        { "type": "paragraph", "text": "Physical property (direct ownership) or securitized exposure (REITs). Provides income (rent or REIT dividends) and potential appreciation. Generally less correlated with stocks and bonds, which is why it appears in diversified portfolios." },
        { "type": "list", "items": [
          "<strong>Direct ownership</strong> — illiquid, requires management, concentrated risk in one property/market.",
          "<strong>REITs</strong> — publicly traded real estate companies. Liquid, diversified, but correlate more with stocks than direct real estate.",
          "<strong>Long-run return</strong> — historically similar to stocks (roughly 7–10% nominal, depending on timeframe) but with different cyclical behavior."
        ]},

        { "type": "heading", "text": "Commodities and alternatives" },
        { "type": "paragraph", "text": "Gold, oil, agricultural products, hedge funds, private equity, private credit. Generally lower allocation in most plans (or zero); harder to access, often more expensive, performance varies." },
        { "type": "callout", "kind": "note", "title": "Don't reach for alternatives early", "text": "Most retail clients do not need a meaningful alternatives allocation to achieve their financial goals. Hedge funds and private equity sound sophisticated, but they often come with high fees, illiquidity, and limited performance advantages relative to a well-built stock-and-bond portfolio. If a client doesn't have a diversified base of stocks and bonds, the right move is to build that first, not to chase alpha in alternatives." },

        { "type": "divider" },

        { "type": "heading", "text": "Long-run real returns (approximate, U.S. data)" },
        { "type": "paragraph", "text": "Useful planning anchors. These are long-run averages and not promises:" },
        { "type": "list", "items": [
          "Cash / T-bills: ~0% to 1% real",
          "Investment-grade bonds: ~1% to 3% real",
          "U.S. stocks (broad market): ~5% to 7% real",
          "International developed stocks: ~4% to 6% real",
          "Emerging markets stocks: ~5% to 7% real with much higher volatility",
          "REITs: ~4% to 6% real",
          "Gold: ~0% to 2% real (highly variable by period)"
        ]},
        { "type": "callout", "kind": "warn", "title": "Past is not prologue", "text": "These numbers describe history. They are useful for planning anchors but they are not guarantees. The next 30 years could differ from the last 100. Always use 'expected' or 'long-run assumption' language with clients — never 'will return' or 'is going to make'." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Funds: Mutual Funds, ETFs, and the Wrapper Question",
      "summary": "How clients access asset classes in practice, and why the wrapper choice matters.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients don't own individual stocks and bonds. They own funds — pools of securities packaged together. The wrapper around the pool — mutual fund, ETF, or other — affects taxation, trading, cost, and accessibility. Knowing the differences is core counselor literacy." },

        { "type": "heading", "text": "Mutual funds" },
        { "type": "paragraph", "text": "The traditional structure. A mutual fund pools investor money to buy a portfolio of securities managed by an investment company. Shares are bought and sold once a day, at the closing net asset value (NAV)." },
        { "type": "subheading", "text": "Key characteristics" },
        { "type": "list", "items": [
          "<strong>Priced once daily at 4pm ET.</strong> Orders during the day are filled at end-of-day NAV.",
          "<strong>Often have minimums</strong> — $1,000 to $3,000 is typical for the initial purchase.",
          "<strong>Can have sales charges (loads)</strong> — front-end (paid on purchase), back-end (paid on sale), or 12b-1 (annual marketing fee). Increasingly rare; many fund families offer no-load shares.",
          "<strong>Tax inefficiency</strong> — required to distribute capital gains realized by the fund manager to shareholders annually. Even if you don't sell, you may receive a taxable distribution."
        ]},

        { "type": "heading", "text": "Exchange-traded funds (ETFs)" },
        { "type": "paragraph", "text": "Started in the 1990s; now hold trillions of dollars in U.S. assets. Same basic concept as a mutual fund — pooled portfolio managed by an investment company — but with a different legal and trading structure that produces material practical advantages." },
        { "type": "subheading", "text": "Key characteristics" },
        { "type": "list", "items": [
          "<strong>Trade like stocks throughout the day.</strong> Price changes continuously based on supply and demand, hovering near the NAV.",
          "<strong>No minimums</strong> — can buy a single share. With fractional shares (available at most brokers), can buy any dollar amount.",
          "<strong>No loads</strong> — pay only the bid-ask spread plus expense ratio plus commissions if charged (most brokers now offer commission-free ETF trading).",
          "<strong>Tax efficiency</strong> — the in-kind creation/redemption mechanism (which is structural and built into how ETFs operate) means most ETFs distribute very few capital gains compared to equivalent mutual funds. For taxable accounts, this is often the deciding factor."
        ]},

        { "type": "callout", "kind": "key", "title": "When to prefer one over the other", "text": "<strong>ETFs win in most cases</strong> for taxable accounts due to tax efficiency, and for cost-conscious clients due to lower expense ratios on equivalent strategies. <strong>Mutual funds are fine in tax-advantaged accounts</strong> (IRAs, 401(k)s), where their tax inefficiency doesn't matter, and they're still the standard inside most 401(k) plans. <strong>Index mutual funds at Vanguard, Fidelity, Schwab</strong> often have expense ratios as low as ETFs and may be the more convenient choice when you're already doing automatic recurring investments." },

        { "type": "heading", "text": "Other common wrappers" },
        { "type": "glossary", "terms": [
          { "term": "Index fund", "definition": "A fund (mutual fund or ETF) that holds securities matching a published index — S&P 500, Total Stock Market, Total Bond Market. Passive management. Low cost." },
          { "term": "Closed-end fund (CEF)", "definition": "A pool that issues a fixed number of shares, then trades on an exchange. Price often diverges from NAV. Older structure, less common now." },
          { "term": "Unit investment trust (UIT)", "definition": "Holds a fixed portfolio for a set period. Less common; sometimes encountered with brokerage account legacy holdings." },
          { "term": "SMA (separately managed account)", "definition": "A portfolio of individual securities held in the client's name and managed to a specified strategy. Used by higher-net-worth clients. Can offer tax customization (tax-loss harvesting on the individual lots)." }
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Index funds vs. actively managed funds" },
        { "type": "paragraph", "text": "An <strong>index fund</strong> aims to match the return of a published index by holding the same securities in the same weights. An <strong>actively managed fund</strong> aims to outperform the index by picking stocks the manager believes will do better." },
        { "type": "subheading", "text": "What the evidence actually shows" },
        { "type": "list", "items": [
          "Over 10–15 year windows, approximately 80–90% of actively managed U.S. equity funds underperform their benchmark index after fees (SPIVA data, multiple years).",
          "Past outperformance does not predict future outperformance. The funds that beat the index in the prior decade rarely beat it in the next.",
          "Cost is the most reliable predictor of fund return. Lower-cost funds, on average, outperform higher-cost funds in the same category."
        ]},
        { "type": "callout", "kind": "key", "title": "The honest default", "text": "For most clients, a portfolio built largely from low-cost broad-market index funds — total U.S. stock, total international stock, total bond market — captures the bulk of available return at minimum cost. Active management has a place (particularly in less efficient asset classes), but it should be the exception requiring justification, not the default." },

        { "type": "case_study",
          "title": "Two funds, twenty years",
          "scenario": "Client invests $10,000 in two funds. Fund A is an S&P 500 index fund with a 0.04% expense ratio. Fund B is an actively managed large-cap fund with a 0.85% expense ratio. Assume both deliver the same gross return — 8% annually — for 20 years. What's the difference at the end?",
          "discussion": "<p>Fund A: $10,000 × (1.0796)^20 = approximately $46,184.</p><p>Fund B: $10,000 × (1.0715)^20 = approximately $39,499.</p><p>The actively managed fund — same gross return — leaves the client roughly <strong>$6,685</strong> behind after 20 years, just from the higher expense ratio. And the assumption that both deliver the same gross return is generous: most active funds in the same category trail the index on gross returns too. The real-world gap is typically larger. <em>Fees compound the same way returns do.</em></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "How Markets Actually Work",
      "summary": "Exchanges, market makers, settlement — the mechanics behind every trade.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients click 'buy' on a stock; the order is filled. What actually happens between those two events is invisible to them but worth understanding for any counselor. The mechanics affect pricing, fees, tax treatment, and what's possible." },

        { "type": "heading", "text": "Exchanges and market participants" },
        { "type": "list", "items": [
          "<strong>Exchanges</strong> — NYSE, Nasdaq, Cboe, and others. Centralized venues where buyers and sellers meet. Most stocks are listed on one or more exchanges.",
          "<strong>Brokers</strong> — the firms clients interact with (Schwab, Fidelity, Vanguard, IBKR, Robinhood). Brokers route client orders to the market.",
          "<strong>Market makers</strong> — firms that stand ready to buy or sell a security at posted prices. They earn the bid-ask spread.",
          "<strong>Specialists / designated market makers</strong> — for stocks listed on NYSE, a designated firm ensures orderly trading.",
          "<strong>Clearing firms</strong> — handle the settlement process. The largest is DTCC, which acts as the clearinghouse for most U.S. securities transactions."
        ]},

        { "type": "heading", "text": "Order types" },
        { "type": "glossary", "terms": [
          { "term": "Market order", "definition": "Buy or sell immediately at the best available price. Fast execution but no price protection." },
          { "term": "Limit order", "definition": "Buy at a specified price or lower; sell at a specified price or higher. Price protection but no guarantee of execution." },
          { "term": "Stop order (stop-loss)", "definition": "Becomes a market order when the security crosses a specified trigger price. Used to limit losses or lock in gains. Note: in fast markets, can execute far from the trigger price." },
          { "term": "Stop-limit order", "definition": "Becomes a limit order at a specified price. Adds price protection but may not execute at all." }
        ]},
        { "type": "callout", "kind": "do", "title": "Order-type discipline", "text": "For most long-term investors buying broad-market funds, market orders are fine — the bid-ask spread on a liquid ETF is pennies. For less liquid securities (small-cap, thin trading volume), limit orders should be the default to avoid surprising fill prices. Stop-loss orders have a checkered history; they're easy to trigger during temporary volatility and can sell at exactly the wrong moment." },

        { "type": "heading", "text": "Settlement" },
        { "type": "paragraph", "text": "When you buy a stock, you receive the shares; when you sell, you receive the cash. That handoff is called <strong>settlement</strong>, and it happens on a delay." },
        { "type": "list", "items": [
          "<strong>Equities and most ETFs</strong>: T+1 (trade date plus one business day) as of May 2024. Previously T+2.",
          "<strong>Treasuries</strong>: T+1 typically.",
          "<strong>Mutual funds</strong>: typically T+1 for redemptions to settle as cash."
        ]},
        { "type": "callout", "kind": "warn", "title": "Why settlement matters for clients", "text": "A client who sells $50,000 of an ETF on Friday cannot wire that money out the same day — it doesn't settle until Monday. For tax purposes, the sale is recognized on the trade date (Friday); for cash availability, it's the settlement date. Clients planning to use proceeds (closing on a home, sending tuition) need this lead time built in." },

        { "type": "heading", "text": "Bid, ask, and spread" },
        { "type": "paragraph", "text": "Every security has a <strong>bid</strong> (highest price someone is willing to pay) and an <strong>ask</strong> or <strong>offer</strong> (lowest price someone is willing to sell). The difference is the <strong>spread</strong>." },
        { "type": "list", "items": [
          "Highly liquid securities (SPY, AAPL, MSFT): spread is often $0.01 or less.",
          "Less liquid securities (small-cap, niche ETFs): spread can be $0.05–$0.50 or more — material.",
          "Buying at the ask and selling at the bid means losing the spread on every round-trip. For frequent traders, this adds up; for buy-and-hold investors, it's negligible."
        ]},

        { "type": "divider" },

        { "type": "heading", "text": "Dividends, splits, and corporate actions" },
        { "type": "list", "items": [
          "<strong>Dividend</strong> — cash payment per share, paid to shareholders of record on a specified date.",
          "<strong>Ex-dividend date</strong> — the date by which an investor must own the stock to receive the next dividend.",
          "<strong>Stock split</strong> — increases share count, proportionally decreases share price. No change in total value. 2-for-1 split: 100 shares at $200 become 200 shares at $100.",
          "<strong>Reverse split</strong> — opposite. Often signals a struggling company trying to keep share price above exchange listing minimums.",
          "<strong>Spin-off</strong> — parent company creates a separate publicly traded subsidiary. Shareholders receive shares in the new entity proportional to their parent holdings.",
          "<strong>Merger/acquisition</strong> — shareholders may receive cash, shares of the acquiring company, or both."
        ]},
        { "type": "callout", "kind": "note", "title": "DRIP (dividend reinvestment)", "text": "Most brokers offer the option to automatically reinvest dividends into more shares of the same security. For long-term accumulation, this is usually fine and removes a friction. For taxable accounts, dividend reinvestment can complicate tax-loss harvesting (reinvested shares create new lots and wash sale risk if a near-term sale happens at a loss). Check the client's DRIP settings during reviews." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Fees and What They Actually Cost",
      "summary": "Layered costs, expressed as percentages, compounding against the client. The largest hidden line item in most portfolios.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Fees are the most predictable destroyer of long-term return. Markets are uncertain; fees are certain. Every dollar paid in fees is a dollar the client doesn't keep. A counselor who systematically reduces fees in a client's portfolio is creating real, measurable, lasting value." },

        { "type": "heading", "text": "The layers of fees in a typical portfolio" },
        { "type": "numbered", "items": [
          "<strong>Expense ratio</strong> — annual fee charged by the fund or ETF. Expressed as a percentage of assets. Deducted daily from fund value. The most visible fee.",
          "<strong>Trading commissions</strong> — fee per trade. Many brokers now offer zero commissions on stocks and ETFs. Mutual funds may have transaction fees ($25–$75 outside the broker's no-fee list).",
          "<strong>Bid-ask spread</strong> — invisible cost on every trade. Material in less liquid securities.",
          "<strong>Loads</strong> — front-end (paid on purchase) or back-end (paid on sale) sales charges on some mutual funds. Common in older accounts; usually avoidable.",
          "<strong>12b-1 fees</strong> — annual marketing fee, baked into the expense ratio of some mutual funds. Up to 1% annually. A reason to scrutinize the expense ratio breakdown.",
          "<strong>Advisor fee</strong> — what the client pays the advisor or advisory firm. Typically 0.5%–1.5% of assets under management for traditional firms; some hourly or flat-fee.",
          "<strong>Platform fee</strong> — some 401(k) plans charge an additional administrative fee on top of fund expense ratios.",
          "<strong>Custodian/wrap fees</strong> — bundled fees that include trading, custody, and sometimes advice."
        ]},

        { "type": "callout", "kind": "key", "title": "Expense ratios in dollar terms", "text": "An expense ratio of 1% on a $500,000 portfolio is $5,000/year. Same ratio on a $1M portfolio is $10,000/year. Whether it's labeled as a small decimal or a fund-family name, it's a real annual cost. Reframing it in dollars often unlocks the client conversation about whether the value justifies the cost." },

        { "type": "heading", "text": "Expense ratio benchmarks" },
        { "type": "paragraph", "text": "For broad-market index funds, the floor has fallen dramatically over the past decade:" },
        { "type": "list", "items": [
          "<strong>Top-tier U.S. total market index (Vanguard VTI, Fidelity FZROX, etc.)</strong>: 0.00% to 0.04%",
          "<strong>Top-tier international index</strong>: 0.04% to 0.08%",
          "<strong>Top-tier total bond market index</strong>: 0.03% to 0.06%",
          "<strong>Average actively managed equity mutual fund</strong>: 0.45% to 0.90%",
          "<strong>Higher-cost specialty funds, certain target-date funds, certain insurance subaccounts</strong>: 0.80% to 1.50%+"
        ]},
        { "type": "callout", "kind": "warn", "title": "Where high fees still hide", "text": "Old employer 401(k)s left behind, variable annuity subaccounts, broker-sold mutual fund classes with loads or 12b-1 fees, certain bank-sold managed accounts, target-date funds at the wrong fund family. The first job when taking on a new client is auditing the existing portfolio for fee leakage. Often, the fee reduction alone pays for the first year of the advisor relationship." },

        { "type": "divider" },

        { "type": "heading", "text": "The 1% advisor fee question" },
        { "type": "paragraph", "text": "Many advisors charge approximately 1% of assets under management annually. On a $1M portfolio, that's $10,000/year. Over 30 years, with a 7% gross return, the difference between a portfolio that pays 1% AUM and one that doesn't is roughly $1 million in final value." },
        { "type": "subheading", "text": "When the 1% fee creates value" },
        { "type": "list", "items": [
          "Comprehensive financial planning (cash flow, tax, retirement, estate, insurance)",
          "Behavioral coaching that prevents costly mistakes (panic-selling, performance-chasing)",
          "Tax-aware investing (asset location, harvesting, Roth conversions)",
          "Coordination with CPA, attorney, insurance, lender",
          "Major life-event planning (career transition, inheritance, business sale)"
        ]},
        { "type": "subheading", "text": "When the 1% fee doesn't" },
        { "type": "list", "items": [
          "Pure investment management with no planning",
          "Off-the-shelf models with no customization",
          "Limited contact and reactive service",
          "Clients with very large portfolios — the math no longer works on a flat percentage"
        ]},
        { "type": "callout", "kind": "note", "title": "The counselor's role here", "text": "GIC operates on a fee-for-service / advisory model — not commission. Apprentices should be able to articulate exactly what value the client is receiving for the fee they pay. \"You're paying me to think about your money, not just to manage it,\" is the spirit. Vague answers about \"long-term relationship\" are a sign that the value proposition isn't fully thought through." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Risk-Return Relationship",
      "summary": "Why higher returns come with higher volatility — and what that means for real portfolios.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "There is no free lunch. Every additional dollar of expected return, in efficient markets, comes paired with additional risk. A portfolio of Treasury bills will produce reliable but modest returns; a portfolio of small-cap emerging markets stocks will produce highly variable returns with higher long-run expectations. The client's job (with the advisor's help) is to choose where on this spectrum they belong." },

        { "type": "heading", "text": "Measuring risk" },
        { "type": "paragraph", "text": "Common measures, each with limits:" },
        { "type": "glossary", "terms": [
          { "term": "Standard deviation (volatility)", "definition": "Measures how much returns vary around the average. Higher = more variable returns. U.S. stocks historically ~15–17% annual standard deviation; high-quality bonds ~5–7%." },
          { "term": "Drawdown / maximum drawdown", "definition": "The peak-to-trough decline in value. The worst loss from a high-water mark. U.S. stocks have had multiple 40%+ drawdowns historically." },
          { "term": "Beta", "definition": "Sensitivity to overall market movements. Beta of 1 = moves with market. Beta of 1.5 = amplified. Beta of 0.5 = damped. Beta of 0 = uncorrelated." },
          { "term": "Sharpe ratio", "definition": "Excess return over risk-free rate, divided by standard deviation. Higher = better risk-adjusted return. A way to compare investments across risk levels." }
        ]},

        { "type": "heading", "text": "What clients actually experience" },
        { "type": "paragraph", "text": "Standard deviation is a useful technical concept. But in practice, clients don't experience volatility — they experience drawdowns. A portfolio with a 15% standard deviation can drop 40% in a serious bear market and stay there for years before recovering." },
        { "type": "callout", "kind": "key", "title": "The drawdowns to remember", "text": "<strong>1973–74:</strong> S&P 500 dropped about 48% (in nominal terms; worse in real terms with high inflation). <strong>2000–2002:</strong> S&P 500 dropped about 49%; tech-heavy Nasdaq dropped about 78%. <strong>2007–2009:</strong> S&P 500 dropped about 57% peak-to-trough. <strong>2020:</strong> S&P 500 dropped about 34% in five weeks (and recovered quickly). <strong>2022:</strong> S&P 500 dropped about 25%; bonds dropped about 13% simultaneously. The client who hasn't lived through one of these may genuinely not understand what they're agreeing to when they say they're \"comfortable with risk.\"" },

        { "type": "heading", "text": "Risk tolerance vs. risk capacity" },
        { "type": "glossary", "terms": [
          { "term": "Risk tolerance", "definition": "How much volatility the client can emotionally handle. A behavioral measure." },
          { "term": "Risk capacity", "definition": "How much volatility the client's financial situation can absorb without harming their plan. A structural measure." }
        ]},
        { "type": "paragraph", "text": "These can differ. A young client with stable income and a 30-year horizon has high capacity — they can afford a 50% drawdown because they have time and income to recover. But their tolerance may be much lower, especially if they've never lived through a real bear market. A retiree drawing on their portfolio has low capacity (drawdowns plus withdrawals compound badly) but may have high tolerance from years of investing experience." },
        { "type": "callout", "kind": "do", "title": "Build the portfolio for the lower of the two", "text": "If tolerance is lower than capacity, build for tolerance — a too-aggressive portfolio that triggers panic-selling produces worse outcomes than a too-conservative one held faithfully. If capacity is lower than tolerance, build for capacity — the client's situation can't actually support what their stomach wants. This is the conversation. Document the rationale." },

        { "type": "divider" },

        { "type": "heading", "text": "The investor's true return" },
        { "type": "paragraph", "text": "Dalbar and similar studies have shown that the average investor's actual return is materially lower than the market's return — often by 3% or more annually. The gap isn't because the market did something secret; it's because investors buy high (after bull runs) and sell low (during bear markets), miss the best days, switch strategies after underperformance, and otherwise behave their way into a worse outcome." },
        { "type": "callout", "kind": "key", "title": "The thing the advisor protects against", "text": "The biggest source of return destruction in a typical client's lifetime isn't fees, isn't market drops, isn't tax. It's behavior — selling at the bottom, buying at the top, abandoning a plan when it's working but feels bad. The single largest source of value an advisor delivers is preventing the client from doing this. Coaching matters more than picking. Always." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What happens to existing bond prices when interest rates rise?",
        "options": [
          "They rise.",
          "They fall.",
          "They stay the same.",
          "It depends on the issuer."
        ],
        "correct": 1,
        "explanation": "Bond prices and rates move inversely. New bonds at higher rates make existing lower-coupon bonds less valuable. Long-duration bonds are more sensitive than short. This relationship explains why 2022 was so difficult for bond investors."
      },
      {
        "id": "q2",
        "prompt": "Why are ETFs generally more tax-efficient than equivalent mutual funds in taxable accounts?",
        "options": [
          "ETFs are exempt from federal tax.",
          "ETFs' in-kind creation/redemption mechanism allows them to distribute very few capital gains, whereas mutual funds must distribute realized gains annually to shareholders.",
          "ETFs use different accounting.",
          "Mutual funds are taxed twice; ETFs once."
        ],
        "correct": 1,
        "explanation": "The structural in-kind mechanism of ETFs lets the fund manager avoid realizing capital gains in most cases. Mutual funds, by contrast, must distribute realized gains to shareholders annually — even shareholders who didn't sell. For taxable accounts, this is often the deciding factor."
      },
      {
        "id": "q3",
        "prompt": "What do SPIVA and similar studies consistently show about actively managed U.S. equity funds?",
        "options": [
          "They outperform their benchmarks roughly 80% of the time.",
          "They roughly match their benchmarks.",
          "Approximately 80–90% underperform their benchmark over 10–15 year windows, after fees.",
          "Past performance reliably predicts future performance."
        ],
        "correct": 2,
        "explanation": "The data consistently show roughly 80–90% of actively managed U.S. equity funds trail their benchmark over long periods. And past outperformance does not reliably predict future. Low-cost index funds win in the aggregate."
      },
      {
        "id": "q4",
        "prompt": "A $500,000 portfolio is charged a 1% annual advisor fee. What is the annual fee in dollar terms?",
        "options": [
          "$500",
          "$1,000",
          "$5,000",
          "$50,000"
        ],
        "correct": 2,
        "explanation": "1% of $500,000 = $5,000/year. Reframing percentage fees in dollar terms is one of the most useful tools for evaluating whether the value justifies the cost."
      },
      {
        "id": "q5",
        "prompt": "Which order type should typically be used for a small-cap, thinly traded ETF?",
        "options": [
          "Market order — speed matters most.",
          "Limit order — to avoid surprising fill prices in a thin market.",
          "Stop order — to lock in gains.",
          "Order type doesn't matter."
        ],
        "correct": 1,
        "explanation": "Less liquid securities can have wide bid-ask spreads. A market order might execute at a much worse price than the last quote. Limit orders provide price protection at the cost of execution uncertainty."
      },
      {
        "id": "q6",
        "prompt": "What is the current standard settlement period for U.S. equities?",
        "options": [
          "Same day (T+0)",
          "T+1 (trade date plus one business day)",
          "T+3",
          "Five business days"
        ],
        "correct": 1,
        "explanation": "U.S. equity settlement moved to T+1 in May 2024. A sale on Friday settles Monday for cash availability. The trade date is what counts for tax purposes; settlement date for cash."
      },
      {
        "id": "q7",
        "prompt": "Why are REITs typically held in tax-advantaged accounts rather than taxable accounts?",
        "options": [
          "REITs are riskier than other investments.",
          "REIT distributions are mostly taxed as ordinary income (not qualified dividends), making them tax-inefficient in taxable accounts.",
          "REITs are required to be held in IRAs.",
          "REITs have higher expense ratios."
        ],
        "correct": 1,
        "explanation": "REIT distributions don't qualify for the lower qualified-dividend rates. Holding them in an IRA or 401(k) shelters the ordinary-income drag. This is one of the most common asset-location moves."
      },
      {
        "id": "q8",
        "prompt": "Which best describes the difference between risk tolerance and risk capacity?",
        "options": [
          "They are the same thing.",
          "Tolerance is the emotional ability to handle volatility; capacity is the financial ability of the plan to absorb volatility. Build the portfolio to the lower of the two.",
          "Tolerance applies to bonds; capacity applies to stocks.",
          "Tolerance is for retirees; capacity is for young investors."
        ],
        "correct": 1,
        "explanation": "Tolerance and capacity can differ. A young investor may have high capacity (long horizon, income) but low tolerance (no bear-market experience). A retiree may have high tolerance but low capacity (drawdowns plus withdrawals compound badly). Build for the lower number, document the reasoning."
      },
      {
        "id": "q9",
        "prompt": "Two funds deliver identical 8% gross returns over 20 years. Fund A has a 0.04% expense ratio; Fund B has 0.85%. What's the approximate difference on a $10,000 initial investment after 20 years?",
        "options": [
          "Negligible — basis points don't matter over long periods.",
          "Roughly $6,000–$7,000.",
          "Roughly $500.",
          "Fund B wins because of active management."
        ],
        "correct": 1,
        "explanation": "Fund A: $10,000 × (1.0796)^20 ≈ $46,184. Fund B: $10,000 × (1.0715)^20 ≈ $39,499. Difference ≈ $6,685. And that assumes identical gross returns — in practice, higher-cost funds typically also have lower gross returns in the same category. Fees compound."
      },
      {
        "id": "q10",
        "prompt": "What does the Dalbar research suggest about typical investor returns?",
        "options": [
          "Investors typically beat the market by 3% annually.",
          "Investor returns are usually within 1% of market returns.",
          "Investors typically underperform the market by several percentage points annually, primarily due to behavioral mistakes — buying high, selling low, chasing performance.",
          "Investor returns are unmeasurable."
        ],
        "correct": 2,
        "explanation": "The behavioral gap — buying high, selling low, performance-chasing — typically costs the average investor 2–4% per year compared to the index they're invested in. This is the largest source of value an advisor delivers: preventing the behavior, not picking the funds."
      },
      {
        "id": "q11",
        "prompt": "Which is the most defensible default for a typical long-term investor's core portfolio?",
        "options": [
          "Single-stock concentrated bet in a high-conviction company.",
          "Diversified mix of low-cost index funds covering U.S. stocks, international stocks, and bonds, sized to the client's risk tolerance and capacity.",
          "Aggressive trading using stop-loss orders.",
          "Hedge funds and private equity."
        ],
        "correct": 1,
        "explanation": "Broad, low-cost, index-based diversification captures the bulk of available return at minimum cost. Active management, alternatives, and concentrated bets have specific use cases but should be the exception, requiring justification, not the default."
      },
      {
        "id": "q12",
        "prompt": "What is the single largest source of long-term return destruction in the typical client's lifetime?",
        "options": [
          "Market downturns.",
          "Behavioral mistakes — selling at the bottom, buying at the top, abandoning plans during stress.",
          "Inflation.",
          "Taxes."
        ],
        "correct": 1,
        "explanation": "Markets recover. Tax can be managed. Inflation is steady. Behavior is the variable that destroys plans repeatedly. The advisor's most important job is helping clients stay on the plan when staying feels bad. That's the value proposition."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 6;

-- ============================================================================
-- DONE.
-- ============================================================================

-- ── module7_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 7 CONTENT
-- Retirement Planning Foundations
-- ============================================================================

update public.modules set
  title = 'Retirement Planning Foundations',
  competency_id = 'CORE-7',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The math, accounts, and tradeoffs behind every retirement plan — accumulation, distribution, and the risks that derail both.',
  learning_objectives = ARRAY[
    'Compute a retirement income need and a corresponding nest-egg target.',
    'Compare 401(k), IRA, Roth, SEP, Solo 401(k), and SIMPLE structures and recommend the right vehicle for a given client.',
    'Explain sequence-of-returns risk and how to mitigate it near and into retirement.',
    'Apply the 4% withdrawal rule, identify its assumptions, and adapt it when those assumptions don''t fit.',
    'Articulate the Social Security claim-timing decision and its trade-offs.',
    'Build a defensible Monte Carlo-style projection or interpret one produced by planning software.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The Retirement Equation",
      "summary": "Time, return, savings rate, and withdrawal — the four levers, and what they actually do.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every retirement plan reduces to four variables: how much the client saves, for how long, at what rate of return, and how much they withdraw later. Holding any three constant, the fourth is determined. A counselor's job is to make the client see which of those levers they can move, and what each move costs." },

        { "type": "callout", "kind": "key", "title": "The accumulation question", "text": "<strong>How big a nest egg does this client need, and what monthly savings rate gets them there by their target retirement age?</strong>" },

        { "type": "heading", "text": "Step 1 — Estimate retirement spending" },
        { "type": "paragraph", "text": "Start with current spending. Subtract things that disappear in retirement (commuting, work clothes, mortgage if paid off, retirement contributions themselves). Add things that may grow (healthcare before Medicare, travel, hobbies). Most clients spend roughly <strong>70–85% of their pre-retirement net spending</strong> in retirement — but the range is wide, and the only honest way to estimate is to look at their actual current spending and adjust line by line." },
        { "type": "callout", "kind": "warn", "title": "The 80% rule of thumb is too rough", "text": "Pre-retirees with high mortgage payments that will be paid off, high commuting costs, and big retirement contributions might need 60% of current income. Pre-retirees who plan extensive travel, have ongoing mortgage, or expect to support adult children might need 100%+. Do the work; don't apply the rule blindly." },

        { "type": "heading", "text": "Step 2 — Subtract guaranteed income sources" },
        { "type": "paragraph", "text": "Many clients have income streams in retirement that aren't from their portfolio:" },
        { "type": "list", "items": [
          "<strong>Social Security</strong> — covered in detail later; varies by claim age and earnings history.",
          "<strong>Pension</strong> — defined-benefit plan, often from public-sector or older private-sector employment.",
          "<strong>Annuities</strong> — purchased income streams.",
          "<strong>Rental income</strong> — net of expenses.",
          "<strong>Part-time work</strong> — many retirees continue some level of paid work, at least for the first decade."
        ]},
        { "type": "paragraph", "text": "The <strong>income gap</strong> — annual spending minus guaranteed income — is what the portfolio must cover." },

        { "type": "heading", "text": "Step 3 — Translate the gap into a nest-egg target" },
        { "type": "paragraph", "text": "The standard rule: use a <strong>safe withdrawal rate</strong> to convert annual income need into total portfolio size. A 4% withdrawal rate corresponds to multiplying annual need by 25:" },
        { "type": "list", "items": [
          "Annual gap of $40,000 → $40,000 × 25 = $1,000,000 portfolio target",
          "Annual gap of $60,000 → $60,000 × 25 = $1,500,000 portfolio target",
          "Annual gap of $100,000 → $100,000 × 25 = $2,500,000 portfolio target"
        ]},
        { "type": "callout", "kind": "note", "title": "The 4% rule's caveats", "text": "Originally derived from Bengen (1994) and Trinity Study research. Assumes a balanced portfolio, 30-year horizon, and inflation-adjusted withdrawals. Has held up reasonably across most historical periods but is not a guarantee. For longer retirements (early retirees), more conservative (3.0–3.5%). For shorter (late retirees), can be higher. Detailed treatment later in the module." },

        { "type": "heading", "text": "Step 4 — Back into a savings rate" },
        { "type": "paragraph", "text": "Given current savings, years to retirement, and expected return, compute the monthly contribution required to hit the target. Use the future-value-of-an-annuity formula from Module 2, or a financial calculator." },

        { "type": "case_study",
          "title": "Walking through Marcus and Tasha",
          "scenario": "Marcus and Tasha, early 40s, want to retire at 65. Current household spending: $108,000/year ($9,000/month). Expected retirement spending: ~$90,000/year (mortgage gone, no work expenses, slightly more travel). Combined Social Security at 67 estimated at $50,000/year. Current retirement savings: $250,000. Current combined retirement contributions: $1,800/month.",
          "discussion": "<p><strong>Income gap in retirement:</strong> $90,000 spending − $50,000 SS = $40,000 from portfolio.</p><p><strong>Nest egg target:</strong> $40,000 × 25 = $1,000,000 (in today's dollars).</p><p><strong>Years to retirement:</strong> 23 (from age 42 to 65).</p><p><strong>Projection at current pace:</strong> $250,000 grows for 23 years at 7% real = ~$1,180,000. Plus contributions of $1,800/month for 23 years at 7% = ~$1,140,000. Total: ~$2,320,000 (in today's dollars). <strong>They are comfortably on track</strong> if those assumptions hold.</p><p>This is the kind of analysis that turns a 'we want to save more' goal into a defensible plan. The numbers say they don't need to save more — they need to <em>not screw it up</em>: stay invested through downturns, manage health-related risks, get insurance right, avoid lifestyle creep that pushes retirement spending past $90K.</p>"
        }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Retirement Accounts: The Vehicles",
      "summary": "Workplace plans, IRAs, self-employed plans — what fits whom and why.",
      "read_time": "10 min read",
      "blocks": [
        { "type": "paragraph", "text": "Tax-advantaged retirement accounts are the structural foundation of nearly every retirement plan. Knowing the rules — contribution limits, eligibility, withdrawal terms — well enough to recommend the right vehicle is core competence." },

        { "type": "heading", "text": "Workplace plans" },

        { "type": "subheading", "text": "401(k) and 403(b)" },
        { "type": "paragraph", "text": "Workplace defined-contribution plans. 401(k) is private sector; 403(b) is nonprofit and education. Mechanically very similar. Employee contributions are pre-tax (Traditional) or after-tax (Roth, if offered). Employer match is common." },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: $23,500 employee. Catch-up $7,500 if age 50+. New super catch-up of about $11,250 for ages 60–63 under SECURE 2.0.",
          "<strong>Employer match</strong>: free money. Capture the full match before anything else.",
          "<strong>Vesting</strong>: employer contributions may have a vesting schedule (typically 3–6 years to fully vest). Important for clients considering a job change.",
          "<strong>Investment menu</strong>: limited to the plan's selected fund lineup. Quality varies enormously by employer.",
          "<strong>Withdrawals before 59½</strong>: generally subject to ordinary income tax plus 10% penalty. Exceptions exist (rule of 55 if separating from service)."
        ]},

        { "type": "subheading", "text": "457(b)" },
        { "type": "paragraph", "text": "State and local government, plus some nonprofits. Similar to 401(k) with two important differences: no 10% early-withdrawal penalty after separation from service at any age, and contributions can be stacked with 401(k) for clients with access to both (e.g., teachers in some states)." },

        { "type": "subheading", "text": "TSP (Thrift Savings Plan)" },
        { "type": "paragraph", "text": "Federal employees and uniformed services. Among the lowest-cost workplace plans in existence. Treats Traditional and Roth contributions similarly to private-sector 401(k)." },

        { "type": "divider" },

        { "type": "heading", "text": "Individual retirement accounts" },

        { "type": "subheading", "text": "Traditional IRA" },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: $7,000 ($8,000 if 50+).",
          "<strong>Deductibility</strong>: full deduction if neither spouse is covered by a workplace plan. Phaseout if covered: $79K–$89K single, $126K–$146K MFJ (2024 figures, approximate; check current).",
          "<strong>Tax treatment</strong>: deductible contribution (if eligible), tax-deferred growth, taxable withdrawals as ordinary income."
        ]},

        { "type": "subheading", "text": "Roth IRA" },
        { "type": "list", "items": [
          "<strong>2025 contribution limit</strong>: same as Traditional — $7,000 ($8,000 if 50+).",
          "<strong>Income limits</strong>: contribution phases out at $150K–$165K single, $236K–$246K MFJ (2025 approximate).",
          "<strong>Tax treatment</strong>: after-tax contribution, tax-free growth, tax-free qualified withdrawals.",
          "<strong>Contribution withdrawal</strong>: contributions (not earnings) can be withdrawn at any time, tax- and penalty-free. This makes the Roth IRA quietly liquid.",
          "<strong>No RMDs</strong> during the original owner's lifetime."
        ]},
        { "type": "callout", "kind": "key", "title": "The backdoor Roth", "text": "Clients above the Roth IRA income limit can still effectively contribute by: (1) making a nondeductible Traditional IRA contribution, (2) immediately converting to Roth. As long as the client has no other pre-tax IRA balances (the pro-rata rule), the conversion is largely tax-free. Legal as of this writing; worth executing for high earners." },

        { "type": "heading", "text": "Self-employed plans" },

        { "type": "subheading", "text": "SEP-IRA" },
        { "type": "paragraph", "text": "Simplified Employee Pension. Employer-only contributions up to about 25% of compensation, capped at $70,000 (2025). Cheap and easy to administer. Best for solo self-employed or very small businesses with no employees." },

        { "type": "subheading", "text": "Solo 401(k)" },
        { "type": "paragraph", "text": "For self-employed with no employees other than a spouse. Combines employee contributions (same $23,500 limit as workplace 401(k)) with employer profit-sharing (up to ~25% of compensation), total capped at about $70,000. Often offers higher contribution capacity than SEP at the same income level. Many Solo 401(k)s now offer Roth contributions and a mega backdoor Roth strategy." },

        { "type": "subheading", "text": "SIMPLE IRA" },
        { "type": "paragraph", "text": "For small employers (under 100 employees). Lower contribution limit ($16,000 in 2025 plus $3,500 catch-up). Required employer match or contribution. Less common; SEP and 401(k) generally preferred when feasible." },

        { "type": "callout", "kind": "do", "title": "The matching framework", "text": "<strong>W-2 employee with workplace 401(k):</strong> contribute at least up to the match, then maximize Roth IRA, then increase 401(k) toward the limit. <strong>Self-employed with no employees:</strong> Solo 401(k) typically optimal. <strong>Self-employed with employees:</strong> SEP-IRA for simplicity if employees are few, regular 401(k) if practical to administer. <strong>Government employee:</strong> 457(b) plus IRA for tax diversification; TSP if federal." },

        { "type": "divider" },

        { "type": "heading", "text": "Rollovers and consolidation" },
        { "type": "paragraph", "text": "When clients leave jobs, their workplace plans can be rolled to an IRA without tax. Common counselor work:" },
        { "type": "list", "items": [
          "<strong>401(k) to IRA rollover</strong> — direct rollover preferred (the money moves trustee-to-trustee without coming to the client). Avoids withholding and potential 60-day-rollover headaches.",
          "<strong>Roth 401(k) to Roth IRA</strong> — also tax-free.",
          "<strong>When to leave it</strong> — sometimes the old 401(k) has better/cheaper funds, creditor protection, or an in-service rollover restriction that means it can't be moved. Audit before recommending rollover.",
          "<strong>Backdoor Roth complications</strong> — clients executing backdoor Roth need to keep pretax IRA balances at zero. Rolling an old 401(k) into a Traditional IRA can ruin their backdoor Roth strategy. Sometimes the right move is rolling 401(k) into a current 401(k), or leaving it."
        ]}
      ]
    },

    {
      "id": "lesson-3",
      "title": "Sequence-of-Returns Risk",
      "summary": "Why the order of good and bad years matters — and what to do about it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Two retirees can have identical average returns over their retirement years and dramatically different outcomes. The difference is when the bad years happen. Bad years early in retirement, while the portfolio is being drawn down, are devastating. The same bad years late in retirement are almost harmless." },

        { "type": "callout", "kind": "key", "title": "The core mechanic", "text": "When the portfolio is in <em>accumulation</em>, a downturn is opportunity — contributions buy more shares at lower prices. When the portfolio is in <em>distribution</em>, a downturn is destruction — withdrawals lock in losses, leaving less to recover when markets rebound." },

        { "type": "heading", "text": "The numerical demonstration" },
        { "type": "paragraph", "text": "Two retirees, each with $1 million, withdrawing $50,000/year, retiring with average annual return of 7% over the retirement period." },

        { "type": "subheading", "text": "Retiree A — bad returns at the start" },
        { "type": "list", "items": [
          "Year 1: −20% return. Portfolio: $1,000,000 × 0.80 − $50,000 = $750,000.",
          "Year 2: −10% return. Portfolio: $750,000 × 0.90 − $50,000 = $625,000.",
          "Years 3–30: average ~9% per year recovery.",
          "Roughly 25 years before the portfolio depletes."
        ]},

        { "type": "subheading", "text": "Retiree B — bad returns at the end" },
        { "type": "list", "items": [
          "Years 1–28: average ~9% per year.",
          "Year 29: −20% return.",
          "Year 30: −10% return.",
          "Portfolio still has substantial balance at age 95."
        ]},

        { "type": "paragraph", "text": "Same average return. Same withdrawals. Very different outcomes. This is sequence-of-returns risk." },

        { "type": "callout", "kind": "warn", "title": "When the risk is highest", "text": "The five years before retirement and the first ten years of retirement are the danger zone. A bear market in this window can permanently damage a retiree's portfolio — there's no time to wait it out without withdrawing during the trough." },

        { "type": "heading", "text": "Mitigating the risk" },

        { "type": "subheading", "text": "1. Glide path — reduce equity exposure entering retirement" },
        { "type": "paragraph", "text": "Most target-date funds reduce equity allocation as the target date approaches. By age 65, a typical target-date fund might hold 50–60% stocks and 40–50% bonds. Less aggressive = less drawdown risk in the danger zone." },

        { "type": "subheading", "text": "2. Cash reserves and the bucket strategy" },
        { "type": "paragraph", "text": "Hold 1–3 years of expenses in cash. In a downturn, draw from cash rather than selling equities at depressed prices. Refill the cash bucket from equities in good years. Some advisors expand this to three buckets: cash (1–2 years), bonds (next 3–7 years), stocks (8+ years)." },

        { "type": "subheading", "text": "3. Flexible withdrawals" },
        { "type": "paragraph", "text": "The 4% rule assumes fixed real withdrawals regardless of market conditions. In practice, retirees who reduce spending in bear-market years (skip the big vacation, postpone the new car) significantly increase plan durability. Even a 10–15% temporary spending reduction has outsize effect." },

        { "type": "subheading", "text": "4. Guaranteed income floor" },
        { "type": "paragraph", "text": "If Social Security, pension, and (sometimes) a single-premium immediate annuity (SPIA) cover essential expenses, the portfolio only needs to fund discretionary spending. The retiree can absorb portfolio drawdowns without changing their basic standard of living." },

        { "type": "subheading", "text": "5. Delay retirement or work part-time" },
        { "type": "paragraph", "text": "Working one extra year, or part-time for several years, reduces the years of withdrawal needed and shrinks the sequence-risk window. For retirees willing and able, this is the most powerful mitigation available." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "A 2008 retiree",
          "scenario": "A retiree who retired in late 2007 with $1 million in a 60/40 portfolio and a 4% withdrawal rate watched the portfolio drop nearly 30% by early 2009 while still drawing $40,000/year. How does this play out?",
          "discussion": "<p>At the trough, the portfolio is well below $700,000. Continuing $40,000 withdrawals is now ~6% of the depressed portfolio — a much higher real withdrawal rate than the 4% rule assumes. If the retiree maintained the withdrawal schedule rigidly, the plan has a meaningful probability of failure across the full 30-year retirement.</p><p>Mitigations that saved many such retirees: (1) flexibility — reducing spending during 2008–2010 by 10–20%; (2) cash buffers — drawing from cash rather than equities during the worst years; (3) Social Security being available to cushion the gap; (4) recovery — markets rebounded substantially by 2013, and a portfolio that survived to 2013 was largely restored.</p><p>The structural lesson: <strong>build flexibility into the plan up front</strong>. The retiree who locks in fixed real withdrawals and never reduces spending is most exposed to sequence risk. The retiree who built a cash buffer, kept some equity exposure, and is willing to flex spending almost always comes out the other side.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Social Security: Timing and Trade-offs",
      "summary": "The decision most clients make poorly, and the analysis that gets it right.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Social Security claim timing is one of the most consequential single decisions a retiree makes. Claim at 62 and benefits are permanently reduced. Claim at full retirement age (currently 67 for most clients) and you get the baseline benefit. Wait until 70 and benefits are permanently increased. The math, and a few often-missed structural considerations, decide the right answer." },

        { "type": "heading", "text": "The basic math" },
        { "type": "paragraph", "text": "Each year of delay between age 62 and full retirement age increases the benefit by roughly 6–7% per year. Each year of delay beyond FRA up to age 70 adds an additional 8% per year. The total difference between claiming at 62 and claiming at 70 is roughly <strong>76% more lifetime monthly benefit</strong>." },

        { "type": "subheading", "text": "Approximate benefit at each age" },
        { "type": "list", "items": [
          "<strong>Claim at 62</strong>: ~70% of full benefit (early-claim reduction of 30%)",
          "<strong>Claim at 67 (FRA for most current clients)</strong>: 100% of full benefit",
          "<strong>Claim at 70</strong>: ~124% of full benefit (delayed-retirement credits)"
        ]},

        { "type": "callout", "kind": "key", "title": "The break-even age", "text": "Compare cumulative benefits. Claiming early gives more checks earlier; claiming later gives larger checks. Break-even between claiming at 62 vs. 67 is typically around age 78–79. Break-even between 67 vs. 70 is typically around age 82–83. <strong>Clients who expect to live past these ages are mathematically better off waiting. Clients who don't, aren't.</strong>" },

        { "type": "heading", "text": "Factors that argue for claiming earlier" },
        { "type": "list", "items": [
          "<strong>Health</strong> — serious health issues, low expected longevity.",
          "<strong>Need</strong> — no other income, can't afford to wait.",
          "<strong>Spousal coordination</strong> — sometimes one spouse claims early to provide income while the other delays.",
          "<strong>Behavioral</strong> — some clients value the certainty of income they receive over a larger income they might not live to collect."
        ]},

        { "type": "heading", "text": "Factors that argue for claiming later" },
        { "type": "list", "items": [
          "<strong>Longevity</strong> — family history of long life, current good health.",
          "<strong>Higher-earning spouse</strong> — delaying the higher earner's benefit also increases the surviving spouse's benefit after the first death (survivor benefit is based on the higher earner's claim).",
          "<strong>Tax planning</strong> — delaying Social Security creates room for Roth conversions in the meantime at low rates.",
          "<strong>Longevity insurance</strong> — Social Security is the cheapest longevity insurance available. Higher benefits in the years a retiree is most likely to need them are structurally valuable."
        ]},

        { "type": "callout", "kind": "do", "title": "The default for healthy clients", "text": "For most healthy clients with adequate resources to bridge the gap, delaying Social Security — at least to FRA, and often to 70 — is the right default. The higher inflation-adjusted income later in life is structurally valuable, and it's the cheapest longevity insurance available. Document when departing from this default and why." },

        { "type": "divider" },

        { "type": "heading", "text": "Spousal and survivor benefits" },
        { "type": "list", "items": [
          "<strong>Spousal benefit</strong>: at FRA, equals up to 50% of the spouse's primary insurance amount (PIA). Available even if the lower-earning spouse never worked.",
          "<strong>Survivor benefit</strong>: equals 100% of the deceased spouse's benefit at the time of death (or what it would have been at FRA if they died before claiming). The surviving spouse gets the higher of the two benefits — not both.",
          "<strong>Divorced spouse benefit</strong>: marriage lasted at least 10 years, current unmarried, ex-spouse is at least 62. Up to 50% of ex's PIA. Doesn't affect ex-spouse's benefit."
        ]},

        { "type": "heading", "text": "Working while claiming" },
        { "type": "paragraph", "text": "Claiming before FRA while still working triggers earnings-test reductions: $1 of benefit withheld for every $2 of earnings above an annual exempt amount (~$23,400 in 2025). The amount returns to you later in higher benefits at FRA, but in the meantime, claiming-while-working can reduce or eliminate the check entirely. Often a reason to delay." },

        { "type": "case_study",
          "title": "Two-earner couple, planning Social Security",
          "scenario": "Both spouses are 64, both worked similar careers, both have estimated FRA benefits of about $30,000/year. Combined retirement spending need: $90,000/year. Portfolio: $1.5M. Both in good health, family longevity into mid-80s.",
          "discussion": "<p>Several reasonable strategies:</p><p><strong>Both delay to 70</strong> — maximizes lifetime benefit (~$48K each at age 70). Requires bridge income from portfolio for 6 years. Best longevity insurance. Best survivor benefit. Default for two healthy spouses.</p><p><strong>One claims early, one delays</strong> — provides some income immediately, larger benefit later. Often used when one spouse has health concerns.</p><p><strong>Both claim at FRA</strong> — middle ground. Avoids the cost of delay for those uncomfortable bridging from portfolio.</p><p>For this couple, recommendation depends on tolerance for portfolio drawdown in the bridge years and view on longevity. Default: delay both. Document the reasoning. Revisit if health or markets change materially.</p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "The Distribution Phase",
      "summary": "Drawing the money down — withdrawal rates, tax sequencing, and managing the spend.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Accumulation gets the attention; distribution is harder. Once a client retires, the questions get more complex: how much can they safely spend, in what order do they draw from accounts, when do they take RMDs, how do they manage taxes across the rest of their life? Distribution is where the planning shifts from saving to deploying." },

        { "type": "heading", "text": "Safe withdrawal rates" },
        { "type": "paragraph", "text": "The 4% rule (covered earlier) remains the most-cited starting point. Refinements:" },
        { "type": "list", "items": [
          "<strong>Retirement length matters.</strong> 4% works for 30-year retirements. For 40+ year retirements (early retirees), drop to 3.0–3.5%.",
          "<strong>Portfolio composition matters.</strong> 4% assumes a diversified stock/bond portfolio. Too conservative (all bonds) supports lower withdrawals; too aggressive (all stocks) is volatile.",
          "<strong>Flexibility increases safe rate.</strong> A retiree willing to reduce spending in bad years can sustainably withdraw 4.5–5%.",
          "<strong>Guaranteed income reduces portfolio strain.</strong> If Social Security + pension cover 50% of spending, the portfolio is supporting less of the burden and effective rates are different."
        ]},

        { "type": "heading", "text": "Withdrawal sequencing" },
        { "type": "paragraph", "text": "When a retiree has multiple account types — taxable, traditional, Roth — the order of withdrawal materially affects total taxes paid over retirement. The conventional ordering (with significant nuance):" },
        { "type": "numbered", "items": [
          "<strong>Required minimum distributions first.</strong> RMDs from traditional accounts are mandatory starting at 73 (rising to 75 by 2033). Penalty for missing is harsh. Take them.",
          "<strong>Taxable accounts next.</strong> Each year, sell long-term holdings as needed to fill the spending gap. Take advantage of low LTCG brackets when total income is modest. Use tax-loss harvesting to offset gains.",
          "<strong>Traditional IRA/401(k) before Roth.</strong> Generally. The reasoning: traditional withdrawals are taxed; Roth withdrawals aren't. Burning through traditional first uses up your bracket capacity at moderate rates rather than letting it grow into RMDs at potentially higher rates.",
          "<strong>Roth last.</strong> Roth grows tax-free and has no RMDs. Letting it grow as long as possible maximizes tax-free wealth. Also: Roth is the most beneficiary-friendly asset to leave to heirs."
        ]},
        { "type": "callout", "kind": "warn", "title": "The conventional ordering is not always right", "text": "For some clients — especially those with very large traditional balances facing massive future RMDs — partial Roth conversions during the bridge years (early retirement, before Social Security and RMDs) are more valuable than strictly following conventional ordering. The right answer depends on bracket math at every age. Planning software helps, but the advisor's job is checking the model against reality." },

        { "type": "heading", "text": "Tax considerations through retirement" },
        { "type": "list", "items": [
          "<strong>Pre-Social Security, pre-RMD window (e.g., 65–72)</strong>: often the lowest-tax years of retirement. Excellent window for Roth conversions and capital gains realization in the 0% LTCG bracket.",
          "<strong>Post-RMD (age 73+)</strong>: traditional withdrawals plus Social Security plus pensions pile up income. Higher brackets. Less planning flexibility.",
          "<strong>Survivor years</strong>: when one spouse passes, surviving spouse files single — brackets compress sharply. Marginal rates can jump even though income hasn't changed. Plan ahead with Roth conversions while both spouses are alive."
        ]},

        { "type": "heading", "text": "Medicare and IRMAA" },
        { "type": "paragraph", "text": "At 65, clients enroll in Medicare. Premiums have a tiered structure based on income (IRMAA — Income-Related Monthly Adjustment Amount). High-income retirees pay more, sometimes dramatically more, for Medicare Part B and Part D." },
        { "type": "list", "items": [
          "IRMAA looks at modified AGI from <em>two years prior</em> (2025 premiums based on 2023 income).",
          "Roth conversions, large capital gains, and one-time income events can spike a year's income and trigger higher premiums two years later.",
          "Cliffs exist at specific income thresholds — being $1 over a threshold can cost $1,000+ in higher annual premiums.",
          "Form SSA-44 allows appeal of IRMAA for life-changing events (retirement itself qualifies)."
        ]},
        { "type": "callout", "kind": "do", "title": "The plan that doesn't surprise the client", "text": "Map IRMAA brackets onto the retirement plan from day one. Coordinate Roth conversions, Social Security timing, and capital gains realization to manage AGI around the brackets. Many retirees discover the cost of IRMAA only after they've triggered it — the advisor's job is to see it coming and adjust." },

        { "type": "divider" },

        { "type": "heading", "text": "Monte Carlo and the projection question" },
        { "type": "paragraph", "text": "Most retirement planning software now runs <strong>Monte Carlo simulations</strong> — generating hundreds or thousands of randomized return sequences to estimate the probability that a given plan succeeds. A 'success rate' of 85% means the plan worked in 85% of simulated paths." },
        { "type": "callout", "kind": "note", "title": "What success rate to aim for", "text": "100% is typically too conservative — it forces unnecessarily low spending. 50% is too aggressive — too high a failure risk. Most planners target 75–90% success. Lower success rates can be appropriate when (1) the retiree has flexibility to reduce spending if needed, (2) there are non-portfolio resources to fall back on, (3) the alternative is unacceptable scrimping in retirement." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "A client has annual retirement spending of $80,000, expected Social Security of $30,000, and no pension. What's the rough nest-egg target using the 4% rule?",
        "options": [
          "$500,000",
          "$1,250,000",
          "$2,000,000",
          "$3,200,000"
        ],
        "correct": 1,
        "explanation": "Income gap: $80,000 − $30,000 = $50,000. Nest egg = $50,000 × 25 = $1,250,000. The portfolio must support only the gap between spending and guaranteed income, not the full spending number."
      },
      {
        "id": "q2",
        "prompt": "What is sequence-of-returns risk?",
        "options": [
          "The risk that returns will be negative on average.",
          "The risk that the ORDER of returns (bad years early in retirement while withdrawing) damages a portfolio far more than the same returns occurring later.",
          "The risk that returns vary year to year.",
          "The risk that the client doesn't follow the plan."
        ],
        "correct": 1,
        "explanation": "Two retirees with the same average return can have very different outcomes depending on when the bad years happen. Withdrawals during a drawdown lock in losses and reduce the base from which the portfolio can recover. Bad years early are far more damaging than bad years late."
      },
      {
        "id": "q3",
        "prompt": "Roughly how much larger is a Social Security benefit if claimed at 70 vs. 62?",
        "options": [
          "About 10% larger",
          "About 30% larger",
          "About 76% larger",
          "About 200% larger"
        ],
        "correct": 2,
        "explanation": "Claim at 62 = ~70% of full benefit. Claim at 70 = ~124% of full benefit. 124/70 ≈ 1.77 — about 76% more lifetime monthly income for the patient claimant."
      },
      {
        "id": "q4",
        "prompt": "Which is the strongest reason a healthy client with adequate bridge resources should consider delaying Social Security past full retirement age?",
        "options": [
          "Tax advantages of delaying are large.",
          "Higher benefits are inflation-adjusted and represent the cheapest longevity insurance available; for higher-earning spouse, also raises the survivor benefit.",
          "It's required by law for high earners.",
          "Markets will be lower then."
        ],
        "correct": 1,
        "explanation": "Delayed-retirement credits add ~8% per year of inflation-adjusted lifetime income — extraordinarily valuable longevity insurance. For couples, the higher earner's delay also raises the survivor benefit, protecting the longer-living spouse."
      },
      {
        "id": "q5",
        "prompt": "What is the conventional withdrawal sequencing in retirement (after RMDs)?",
        "options": [
          "Roth → Traditional → Taxable",
          "Taxable → Traditional → Roth",
          "All accounts proportionally each year",
          "Traditional → Taxable → Roth"
        ],
        "correct": 1,
        "explanation": "Conventional: required minimums first, then taxable, then traditional, then Roth. Taxable funds use lower-rate LTCG brackets, traditional uses up bracket capacity at moderate rates, Roth grows tax-free as long as possible. Not always the optimal — Roth conversions in the bridge years often improve on this."
      },
      {
        "id": "q6",
        "prompt": "Why is the early-retirement, pre-RMD window so valuable for tax planning?",
        "options": [
          "Brackets are lower than they'll be later when Social Security and RMDs both fill them. Excellent window for Roth conversions and realizing capital gains at low rates.",
          "Tax rates are temporarily lower by law.",
          "The IRS doesn't audit during this period.",
          "It's the only time Roth conversions are legal."
        ],
        "correct": 0,
        "explanation": "Early retirement before Social Security, before RMDs, can be the lowest-tax window of a client's lifetime. Use it to do Roth conversions, harvest gains in the 0% LTCG bracket, and reduce future tax pressure."
      },
      {
        "id": "q7",
        "prompt": "What is IRMAA?",
        "options": [
          "An IRS retirement account.",
          "Medicare's Income-Related Monthly Adjustment Amount — higher-income retirees pay higher Medicare Part B and Part D premiums; looks at AGI from two years prior.",
          "An annuity product.",
          "A type of Social Security benefit."
        ],
        "correct": 1,
        "explanation": "IRMAA tiers Medicare premiums by income, using AGI from two years prior. Roth conversions, capital gains, and large one-time income events can spike a year's MAGI and trigger higher premiums two years later. Cliffs exist — $1 over a threshold can cost $1,000+ annually."
      },
      {
        "id": "q8",
        "prompt": "What's the right move for a client who has both a workplace 401(k) match and is otherwise on the fence about contributions?",
        "options": [
          "Skip the 401(k) and contribute to an IRA instead.",
          "Always contribute at least up to the full employer match — it's an immediate guaranteed return that almost always outranks other priorities.",
          "Wait until pay raises arrive.",
          "Use a Roth IRA only."
        ],
        "correct": 1,
        "explanation": "The match is free money — typically a 50% or 100% return on contributions up to a cap. Almost no other use of those dollars produces a comparable risk-free return. Capture the match first; everything else is secondary."
      },
      {
        "id": "q9",
        "prompt": "What is the backdoor Roth, and who uses it?",
        "options": [
          "An illegal tax shelter.",
          "A two-step process — make a nondeductible Traditional IRA contribution, then convert to Roth — that effectively allows high earners (above the Roth income limit) to contribute to a Roth.",
          "A Roth IRA available only to government employees.",
          "An emergency-withdrawal feature."
        ],
        "correct": 1,
        "explanation": "Legal as of this writing. Critical caveat: only works cleanly if the client has no other pretax IRA balances (the pro-rata rule). Common move for high earners; should be checked annually against current tax law."
      },
      {
        "id": "q10",
        "prompt": "A retiree's portfolio drops 25% in the first year of retirement. They are still drawing the originally planned $50K/year. What is the best advisor move?",
        "options": [
          "Sell stocks immediately to reduce risk.",
          "Have an honest conversation about flexibility — temporarily reducing withdrawals or drawing from cash reserves rather than depressed equities. Sequence-of-returns risk is acute right now.",
          "Reassure the client that returns will average out.",
          "Recommend buying more stocks at the dip."
        ],
        "correct": 1,
        "explanation": "Sequence risk is most acute in the first decade of retirement. Flexibility (reducing spending, drawing from cash) preserves the portfolio for recovery. Selling equities into the depressed market and replacing with bonds locks in losses. Reassurance alone misses the structural risk."
      },
      {
        "id": "q11",
        "prompt": "What is the bucket strategy in retirement planning?",
        "options": [
          "Diversifying across multiple investment platforms.",
          "Holding cash/short-term assets for near-term spending and longer-duration assets for later spending — so a market drop doesn't force selling equities at depressed prices.",
          "Holding only one asset class.",
          "Spreading withdrawals across the calendar year."
        ],
        "correct": 1,
        "explanation": "The classic three-bucket: cash (1–2 years of spending), bonds (next 3–7 years), stocks (8+ years). In a downturn, draw from cash and bonds; let stocks recover. Refill the cash bucket from stocks in good years. Mitigates sequence risk structurally."
      },
      {
        "id": "q12",
        "prompt": "What is a reasonable target for Monte Carlo simulation 'success rate' in a retirement plan?",
        "options": [
          "100% — anything less is too risky.",
          "50% — coin flip is fine.",
          "75–90% — high enough to be confident, low enough to avoid unnecessary spending restrictions.",
          "Success rates are meaningless."
        ],
        "correct": 2,
        "explanation": "100% can force unrealistically low spending. 50% is too risky. Most planners target 75–90%, lower when retirees have flexibility to adapt if results trail expectation. Always pair the number with a plan for what changes if the projection trends bad."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 7;

-- ============================================================================
-- DONE.
-- ============================================================================

-- ── module8_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 8 CONTENT
-- Estate Planning & Wealth Transfer
-- ============================================================================
update public.modules set
  title = 'Estate Planning & Wealth Transfer',
  competency_id = 'CORE-8',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'How families move wealth across generations and across moments of crisis. Wills, trusts, powers of attorney, beneficiaries, and the documents that matter when something goes wrong.',
  learning_objectives = ARRAY[
    'Distinguish probate from non-probate assets and explain why this drives most estate planning.',
    'Identify the four core documents every adult should have, regardless of net worth.',
    'Distinguish revocable from irrevocable trusts and articulate when each is the right tool.',
    'Explain why beneficiary designations override wills and how to audit them.',
    'Articulate the basics of federal estate, gift, and generation-skipping taxes at current thresholds.',
    'Coordinate with an estate planning attorney effectively without practicing law.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Why Estate Planning Is Not Just for the Wealthy",
      "summary": "The four documents every adult needs, and what happens when they don't have them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Estate planning is one of the most over-postponed conversations in personal finance. Clients hear \"estate\" and think \"rich people problem\" — and so the documents that protect a family in a crisis go unwritten. A Wealth Solutions Counselor's job is to translate: this is not about taxes for most clients, it's about <em>what happens when something goes wrong</em>." },

        { "type": "callout", "kind": "key", "title": "The four core documents", "text": "<strong>(1) Will</strong>, <strong>(2) Durable power of attorney for finances</strong>, <strong>(3) Healthcare power of attorney / advance directive</strong>, <strong>(4) HIPAA authorization</strong>. Every adult — regardless of net worth — should have all four. Cost via an estate attorney: typically $500–$2,500 for a basic plan. Cost of not having them: incalculable when needed." },

        { "type": "heading", "text": "What happens without a will (intestacy)" },
        { "type": "paragraph", "text": "If a person dies without a will, state law decides who inherits. The state's default rules are called <strong>intestacy laws</strong>, and they rarely match what the deceased would have wanted." },
        { "type": "list", "items": [
          "Surviving spouse may share inheritance with parents or siblings of the deceased, depending on state and whether there are children.",
          "If there are children from prior relationships, the surviving spouse may share with stepchildren.",
          "Unmarried partners typically inherit nothing under intestacy.",
          "Minor children's inheritance is held by court-appointed conservators, often with high court costs.",
          "The state appoints a guardian for minor children — without input from the parents."
        ]},
        { "type": "callout", "kind": "warn", "title": "The argument that ends the conversation", "text": "\"If you die without a will, the state writes one for you — and they don't know your family.\" That sentence often opens the door for clients who've been avoiding the topic for years." },

        { "type": "heading", "text": "The four documents in plain language" },
        { "type": "subheading", "text": "Will" },
        { "type": "paragraph", "text": "Directs distribution of <em>probate</em> assets at death. Names an executor to settle the estate. Names guardians for minor children. Doesn't override beneficiary designations or jointly owned property — more on that in the next lesson." },

        { "type": "subheading", "text": "Durable power of attorney for finances" },
        { "type": "paragraph", "text": "Names someone (an \"agent\" or \"attorney-in-fact\") to manage finances if the principal becomes incapacitated. \"Durable\" means it survives incapacity (the entire point — a non-durable POA terminates when the principal can't make decisions). Critical for: paying bills, managing investments, dealing with the IRS, handling real estate, and a hundred other tasks the household needs done when someone is unable to do them." },

        { "type": "subheading", "text": "Healthcare power of attorney" },
        { "type": "paragraph", "text": "Names someone to make medical decisions when the principal can't. Often paired with an <strong>advance directive</strong> (also called a living will) that specifies preferences for end-of-life care, life support, organ donation. Without these documents, family members fight over medical decisions or hospitals follow defaults that may not match the patient's wishes." },

        { "type": "subheading", "text": "HIPAA authorization" },
        { "type": "paragraph", "text": "Federal medical privacy law (HIPAA) restricts who can receive a patient's health information. A HIPAA authorization tells providers it's OK to share the patient's medical information with named individuals — usually the agents under the healthcare POA. Without it, even spouses can be told \"I can't discuss the patient with you.\"" },

        { "type": "callout", "kind": "do", "title": "The minimum-viable estate plan", "text": "Will + durable POA + healthcare POA/advance directive + HIPAA authorization. These four documents take care of the structural risks for most clients. More sophisticated planning (trusts, advanced tax strategies) builds on top — but starts with the core four." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Probate, Beneficiaries, and How Assets Actually Transfer",
      "summary": "Why the beneficiary designation on a 401(k) overrides everything in the will.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "One of the most expensive misunderstandings in personal finance is the belief that a will controls everything. It doesn't. Knowing exactly what transfers <em>by</em> the will and what transfers <em>around</em> the will is the difference between an estate plan that works and one that explodes." },

        { "type": "heading", "text": "Probate vs. non-probate" },
        { "type": "glossary", "terms": [
          { "term": "Probate", "definition": "The court-supervised process of validating a will, paying debts and taxes, and distributing remaining assets. Public, can take 6 months to 2+ years, costs typically 3–7% of estate value." },
          { "term": "Probate assets", "definition": "Assets that pass through the will and through probate. Examples: individually-owned bank accounts without payable-on-death designations, individually-owned vehicles, real estate held solely in the decedent's name, personal property." },
          { "term": "Non-probate assets", "definition": "Assets that pass outside the will, by their own legal mechanism. They transfer faster, more privately, and sometimes more cheaply — but only if set up correctly." }
        ]},

        { "type": "heading", "text": "The four ways non-probate assets transfer" },
        { "type": "numbered", "items": [
          "<strong>Beneficiary designation</strong> — retirement accounts (401(k), IRA, Roth IRA), life insurance, annuities. Goes directly to the named beneficiary at death, bypassing the will entirely.",
          "<strong>Joint ownership with right of survivorship</strong> — bank accounts, real estate, vehicles. Surviving owner immediately becomes sole owner.",
          "<strong>Transfer-on-death (TOD) / Payable-on-death (POD) designation</strong> — many states allow these on brokerage accounts, bank accounts, even real estate. Functions like a beneficiary designation.",
          "<strong>Trust ownership</strong> — assets owned by a trust transfer according to the trust document, not by will. Major reason to use a revocable living trust."
        ]},

        { "type": "callout", "kind": "key", "title": "The rule that saves families", "text": "<strong>Beneficiary designations override wills.</strong> Always. If the will leaves everything to the second spouse but the 401(k) still names the first spouse as beneficiary, the 401(k) goes to the first spouse. This has destroyed countless second marriages' financial plans. Auditing beneficiary designations is one of the most important things an advisor can do annually." },

        { "type": "subheading", "text": "What to audit on beneficiary designations" },
        { "type": "list", "items": [
          "Every retirement account: 401(k), 403(b), IRA, Roth IRA, SEP, SIMPLE.",
          "Every life insurance policy — employer-provided AND individual.",
          "Annuities of every kind.",
          "HSAs.",
          "Brokerage accounts with TOD designations.",
          "Bank accounts with POD designations."
        ]},
        { "type": "subheading", "text": "What to check for each" },
        { "type": "list", "items": [
          "Is there a primary beneficiary?",
          "Is there a contingent beneficiary in case the primary dies first?",
          "Are the beneficiaries the right people for the current life situation? (Common errors: ex-spouses, deceased parents, minor children listed directly.)",
          "Are the percentages adding to 100%?",
          "Are spouses properly named (with full legal name, date of birth, and SSN if required)?"
        ]},

        { "type": "callout", "kind": "warn", "title": "The ex-spouse trap", "text": "After divorce, retirement accounts and life insurance still name the ex as beneficiary in a stunning percentage of cases. Some states have laws that automatically revoke ex-spouse designations on divorce, but those laws don't apply to federally-regulated plans (like 401(k)s) — federal law preempts. Result: ex-spouse legally inherits, regardless of what the will or divorce decree says. Every divorce should trigger a beneficiary audit." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The blended family disaster",
          "scenario": "Marcus (from prior modules, now imagining a remarriage scenario) divorced his first wife and remarried Tasha. He updated his will to leave everything to Tasha and his two children. He died unexpectedly. His will was clean. His 401(k) still named his first wife as primary beneficiary — he'd never updated it after the divorce.",
          "discussion": "<p>The $340,000 401(k) goes to the first wife. By law. There's no provision for the surviving family to challenge it successfully — the beneficiary designation is contractually binding on the plan administrator.</p><p>Tasha inherits the house (jointly titled), the cars, the bank accounts (which had her as a co-owner or POD beneficiary), and the rest of the will-controlled assets — but the largest single asset, the retirement account, is gone to someone he hadn't lived with in 12 years.</p><p>This story is not rare. The advisor who, in a routine annual review, asks \"can we pull up your beneficiary designations and confirm they're current?\" is doing structural risk management that quietly prevents these disasters. <strong>That is what this profession is for.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Trusts — Revocable and Irrevocable",
      "summary": "When a will is enough, and when a trust earns its keep.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "Trusts are misunderstood in roughly equal measure as estate-planning savior and unnecessary complication. They are useful for specific purposes; for many clients with simple situations, they're overkill. A Wealth Solutions Counselor needs to know when to suggest a trust to the client and when to leave well enough alone." },

        { "type": "heading", "text": "What a trust actually is" },
        { "type": "paragraph", "text": "A trust is a legal arrangement where one party (the <strong>grantor</strong> or <strong>settlor</strong>) gives property to a <strong>trustee</strong> to hold and manage for the benefit of <strong>beneficiaries</strong>, according to terms spelled out in the trust document. The trust itself owns the property; the trustee operates under fiduciary duty." },

        { "type": "heading", "text": "Revocable living trust" },
        { "type": "paragraph", "text": "A revocable trust is one the grantor can change or terminate during their lifetime. Most commonly used for:" },
        { "type": "list", "items": [
          "<strong>Avoiding probate</strong> — assets owned by the trust pass per the trust document, not through court probate. In states with painful probate processes (California, Florida), this alone justifies the cost.",
          "<strong>Privacy</strong> — wills become public record in probate. Trust distributions don't.",
          "<strong>Incapacity planning</strong> — the successor trustee can step in if the grantor becomes incapacitated, without a court-appointed conservatorship.",
          "<strong>Multi-state property</strong> — owning real estate in multiple states normally triggers probate in each. Trust ownership avoids this.",
          "<strong>Blended family planning</strong> — can specify complex distributions across multiple sets of beneficiaries with more nuance than a will."
        ]},
        { "type": "callout", "kind": "note", "title": "What revocable trusts do NOT do", "text": "They do <em>not</em> save federal estate taxes (because the grantor still controls and owns the assets for tax purposes). They do <em>not</em> protect assets from the grantor's creditors during their lifetime. They are estate-administration tools, not tax-avoidance or asset-protection tools." },

        { "type": "heading", "text": "Irrevocable trusts" },
        { "type": "paragraph", "text": "An irrevocable trust, once created, generally cannot be changed by the grantor. The grantor has surrendered control over the assets. This makes irrevocable trusts powerful for specific planning purposes that revocable trusts can't accomplish:" },
        { "type": "list", "items": [
          "<strong>Estate tax reduction</strong> — assets transferred to certain irrevocable trusts are removed from the grantor's taxable estate.",
          "<strong>Asset protection</strong> — properly structured irrevocable trusts can shield assets from future creditors (rules vary widely by state).",
          "<strong>Special needs planning</strong> — a special needs trust preserves a disabled beneficiary's eligibility for government benefits while providing supplemental support.",
          "<strong>Life insurance ownership (ILIT)</strong> — an irrevocable life insurance trust owns the policy so death proceeds are not part of the taxable estate.",
          "<strong>Charitable planning</strong> — charitable remainder trusts and charitable lead trusts have specialized estate and income tax benefits."
        ]},

        { "type": "callout", "kind": "warn", "title": "The cost of irrevocability", "text": "An irrevocable trust gives up control. If circumstances change, the trust is generally stuck. Most clients should not enter irrevocable arrangements until the basic planning is solid and the specific tax/protection benefit clearly justifies the loss of flexibility. Always involve an experienced estate attorney." },

        { "type": "divider" },

        { "type": "heading", "text": "When a will alone is fine" },
        { "type": "paragraph", "text": "Most clients do not need a trust. A well-drafted will, combined with proper beneficiary designations and joint ownership where appropriate, handles their estate cleanly." },
        { "type": "subheading", "text": "Will-only is typically sufficient when..." },
        { "type": "list", "items": [
          "Estate is well below federal exemption (currently $13+ million per individual, sunset reverts lower in 2026).",
          "Single state of residence with reasonable probate (most states are not California or Florida).",
          "Simple family structure — first marriage, no special-needs beneficiaries.",
          "No business interests requiring sophisticated succession planning.",
          "No need for incapacity-driven trust management (powers of attorney suffice)."
        ]},

        { "type": "case_study",
          "title": "Trust or no trust?",
          "scenario": "Two clients each have $1.4 million net worth, two adult children, simple family situations. Client A lives in Texas. Client B lives in California.",
          "discussion": "<p>Client A (Texas): probate in Texas is relatively painless and quick — independent administration is common, court oversight minimal. A well-drafted will plus beneficiary designations and joint titling on the house likely suffices. <strong>Trust adds cost without much benefit.</strong></p><p>Client B (California): California probate is famously slow, expensive (statutory attorney fees on a $1.4M estate run roughly $25,000+), and public. A revocable living trust costs $2,000–$5,000 to set up but saves the probate process entirely. <strong>The trust pays for itself many times over.</strong></p><p>The trust decision is jurisdictional more than wealth-based. Always ask about the client's state and whether real estate is owned in multiple states.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Gifts, Estate Tax, and the Federal Exemption",
      "summary": "When taxes matter, who they apply to, and how to use the annual exclusion.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Federal estate and gift tax affects a small fraction of households — but for the clients it affects, the stakes are enormous. And the rules around the annual gift exclusion and lifetime exemption matter in planning conversations even when the client isn't currently above the threshold." },

        { "type": "heading", "text": "The lifetime exemption" },
        { "type": "paragraph", "text": "Federal estate tax applies to the value transferred at death (or by gift during life) that exceeds the <strong>lifetime exemption</strong>. As of 2025, the exemption is approximately <strong>$13.99 million per individual</strong> ($27.98 million per couple). For estates above this threshold, the marginal federal estate tax rate is 40%." },
        { "type": "callout", "kind": "warn", "title": "The 2026 sunset", "text": "Unless Congress acts, the lifetime exemption is currently scheduled to be roughly cut in half at the end of 2025, dropping to approximately $7 million per individual. Clients with estates in the $7–14M range may move from \"not subject to estate tax\" to \"subject to estate tax\" based on legislative action alone. This is a real planning consideration; high-net-worth clients should be discussing it with an estate attorney now. <em>Always verify the current threshold before quoting it to clients — legislation changes.</em>" },

        { "type": "heading", "text": "Annual gift exclusion" },
        { "type": "paragraph", "text": "Separate from the lifetime exemption, every individual can gift up to a certain amount per recipient per year with no tax consequence and no use of the lifetime exemption. As of 2025: <strong>$19,000 per recipient per year</strong>. A married couple can jointly gift $38,000 per recipient. There is no limit on the number of recipients." },
        { "type": "subheading", "text": "Annual exclusion examples" },
        { "type": "list", "items": [
          "A couple gifts $38,000 to each of their three children annually: $114,000 per year transferred, no gift tax filing required, no use of lifetime exemption.",
          "Grandparents (a couple) gift $38,000 to each of five grandchildren plus three children: $304,000 per year transferred.",
          "Over a 10-year period, the same couple could transfer over $3 million using only annual exclusions — sizable wealth movement with no tax cost."
        ]},
        { "type": "callout", "kind": "key", "title": "Why this matters for high-net-worth families", "text": "Systematic use of the annual gift exclusion reduces the taxable estate over time. Combined with strategic use of the lifetime exemption (especially before any reduction), it can move enormous wealth across generations tax-free. The window is open until it isn't — and unlike many planning ideas, this one runs on a literal calendar." },

        { "type": "divider" },

        { "type": "heading", "text": "Step-up in basis" },
        { "type": "paragraph", "text": "When an asset is inherited at death, the recipient's tax basis is generally reset to the asset's value at the date of death — the <strong>step-up in basis</strong>. This can be a far more valuable tax provision than the estate tax exemption for many families." },
        { "type": "subheading", "text": "Why step-up matters" },
        { "type": "list", "items": [
          "A client buys $50,000 of stock that grows to $500,000 over 30 years. If she sells, she owes capital gains tax on the $450,000 gain.",
          "If she instead holds the stock until death, her heirs inherit it at the $500,000 stepped-up basis. They can sell immediately and owe no capital gains tax.",
          "This is why planners often recommend that highly-appreciated assets be held until death rather than sold during life, particularly when heirs will receive them anyway."
        ]},
        { "type": "callout", "kind": "do", "title": "The planning move", "text": "When a client has both highly-appreciated assets and assets without much gain, sell the low-gain assets first if cash is needed. Leave the appreciated assets for the step-up at death. This is one of the highest-leverage tax planning moves available to anyone with taxable investments, and it costs nothing to execute correctly." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Working with the Estate Attorney",
      "summary": "How a Wealth Solutions Counselor coordinates without practicing law.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Drafting wills and trusts is the practice of law and requires a licensed attorney. A Wealth Solutions Counselor's role in estate planning is to identify the need, prepare the client for the conversation, coordinate with the attorney, and implement and maintain the plan over time. Done well, the counselor multiplies the value of the attorney's work." },

        { "type": "heading", "text": "What the counselor does" },
        { "type": "list", "items": [
          "<strong>Identify the gap.</strong> Most clients haven't done estate planning, or did it many years ago. The counselor notices and raises the conversation.",
          "<strong>Gather information.</strong> Before the attorney meeting, help the client prepare: asset inventory, beneficiaries, family details, goals for distribution.",
          "<strong>Explain plain-language basics.</strong> Walk the client through what a will does, why beneficiary designations matter, what powers of attorney accomplish. Demystify the conversation before they meet with the attorney.",
          "<strong>Refer to a qualified attorney.</strong> Have a short list of vetted estate planning attorneys. Match the complexity to the right attorney.",
          "<strong>Coordinate implementation.</strong> Once documents are signed, help the client retitle assets into the trust, update beneficiary designations, and store documents safely.",
          "<strong>Monitor and update.</strong> Life changes (marriage, divorce, new child, inheritance, business sale, move) and law changes both trigger reviews."
        ]},

        { "type": "callout", "kind": "warn", "title": "What the counselor does NOT do", "text": "Draft documents. Provide legal advice on which provisions to choose. Opine on trust selection, executor selection, or specific clauses. Witness signing of estate documents (unless explicitly part of firm procedure, and even then under attorney supervision). Be the trustee, executor, or POA agent for a client (unless your firm has a formal corporate trustee arrangement). The line is real — when in doubt, defer to the attorney." },

        { "type": "heading", "text": "Storing the documents" },
        { "type": "paragraph", "text": "An estate plan that can't be found is no plan at all. Help clients establish a system:" },
        { "type": "list", "items": [
          "Original signed documents stored in a fireproof safe or with the attorney (not in a bank safe deposit box — those can be sealed at death until court order).",
          "Copies provided to the executor, POA agents, and healthcare agents.",
          "Family members told where the originals are kept.",
          "Beneficiary designations stored alongside or referenced — they're not part of the will but are part of the plan.",
          "Digital asset inventory: passwords, accounts, cryptocurrency. This is a growing gap; courts and family struggle to access digital assets without documentation."
        ]},

        { "type": "case_study",
          "title": "The first estate planning conversation",
          "scenario": "Naomi (now 36) is single, no children, $250K net worth, lives in California. She's never had any estate documents drafted. In a routine planning meeting, you ask: 'What happens if you can't make medical decisions tomorrow?' She doesn't know.",
          "discussion": "<p>Naomi doesn't need a trust at this stage. Her assets are still below the California probate hassle threshold, her situation is simple, and she has no dependents requiring complex distribution. What she needs:</p><ul><li>Will — names a beneficiary (likely her parents or a sibling) and an executor.</li><li>Durable POA for finances — names someone to manage her finances if she's incapacitated.</li><li>Healthcare POA + advance directive — names a medical decision-maker and her preferences.</li><li>HIPAA authorization — allows the medical agent to access her records.</li><li>Beneficiary designations updated on her Roth IRA, 401(k), HSA, and any life insurance.</li></ul><p>Cost: probably $500–$1,500 with a flat-fee estate attorney. Time: one or two meetings.</p><p>The advisor's contribution: noticing the gap, framing it without scaring her, providing a vetted attorney, and helping her implement after signing. As her net worth grows or her family situation changes, she'll come back for revisions. <strong>This is what 'preparing the next generation of Wealth Solutions Counselors' actually looks like in practice — taking a smart 36-year-old from 'I should do that someday' to 'I have all the documents' in less than a month.</strong></p>"
        }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Which four documents make up the minimum-viable estate plan every adult should have?",
        "options": [
          "Will, 401(k), homeowners insurance, life insurance",
          "Will, durable financial POA, healthcare POA / advance directive, HIPAA authorization",
          "Will, trust, deed, mortgage",
          "Living will, last will, holographic will, codicil"
        ],
        "correct": 1,
        "explanation": "Every adult — regardless of net worth — should have these four. They handle the structural risks of death and incapacity. Trusts and advanced planning layer on top of this base."
      },
      {
        "id": "q2",
        "prompt": "If a person dies without a will, their estate is distributed:",
        "options": [
          "Equally among all surviving relatives.",
          "To the federal government.",
          "According to the state's intestacy laws, which often produce surprising results.",
          "To whomever filed the death certificate."
        ],
        "correct": 2,
        "explanation": "State intestacy laws set default distribution. They rarely match what the deceased would have chosen — surviving spouses may share with parents, unmarried partners may inherit nothing, minor children's funds get held by court-appointed conservators."
      },
      {
        "id": "q3",
        "prompt": "Beneficiary designations on retirement accounts and life insurance:",
        "options": [
          "Are controlled by the will.",
          "Override the will and pass directly to the named beneficiary, regardless of what the will says.",
          "Only apply if the will is missing or contested.",
          "Require probate court approval to be honored."
        ],
        "correct": 1,
        "explanation": "Beneficiary designations override wills. Always. The most common estate-planning disaster: a will leaving everything to the second spouse, while the 401(k) still names the ex-spouse from 15 years ago. The 401(k) goes to the ex. Auditing beneficiaries annually prevents this."
      },
      {
        "id": "q4",
        "prompt": "What is the primary purpose of a revocable living trust?",
        "options": [
          "Save federal estate taxes.",
          "Protect assets from creditors during the grantor's lifetime.",
          "Avoid probate, plan for incapacity, and provide privacy for asset distribution.",
          "Generate income tax deductions."
        ],
        "correct": 2,
        "explanation": "Revocable trusts are estate-administration tools, not tax tools. They bypass probate, allow seamless management at incapacity, and keep distributions private. They do NOT save estate taxes (grantor still owns the assets for tax purposes) or protect from grantor's creditors during life."
      },
      {
        "id": "q5",
        "prompt": "Which factor makes a revocable trust most clearly worth the cost?",
        "options": [
          "The client lives in a state with painful probate (California, Florida, etc.) or owns real estate in multiple states.",
          "The client's net worth is above $1 million.",
          "The client has more than one child.",
          "The client is over age 65."
        ],
        "correct": 0,
        "explanation": "The trust decision is jurisdictional more than wealth-based. In states with slow, expensive, public probate processes, even modest estates benefit from trust ownership. Conversely, in states with streamlined probate, the same wealth level may not justify the trust."
      },
      {
        "id": "q6",
        "prompt": "What is the 2025 federal estate tax lifetime exemption per individual (approximate)?",
        "options": [
          "$1 million",
          "$5.5 million",
          "$13.99 million",
          "$25 million"
        ],
        "correct": 2,
        "explanation": "Approximately $13.99 million per individual in 2025. Note: scheduled to roughly halve at end of 2025 absent congressional action. Verify the current threshold before quoting to clients — this number moves."
      },
      {
        "id": "q7",
        "prompt": "What is the 2025 annual gift tax exclusion per recipient?",
        "options": [
          "$5,000",
          "$15,000",
          "$19,000",
          "$50,000"
        ],
        "correct": 2,
        "explanation": "$19,000 per recipient per giver in 2025. A married couple can jointly gift $38,000 per recipient. No limit on number of recipients. Systematic use can transfer significant wealth across generations tax-free."
      },
      {
        "id": "q8",
        "prompt": "What is the 'step-up in basis' and why does it matter?",
        "options": [
          "An IRS penalty on gifts made within one year of death.",
          "When assets are inherited at death, the recipient's tax basis is reset to the asset's value at date of death — eliminating capital gains tax on prior appreciation.",
          "A method of valuing real estate for property tax purposes.",
          "The increase in retirement contribution limits at age 50."
        ],
        "correct": 1,
        "explanation": "Step-up in basis often saves more tax for middle-class families than estate tax exemption ever could. Highly appreciated assets held until death allow heirs to sell immediately with no capital gains tax on the prior growth. This is why advisors often recommend selling low-gain assets first and holding high-gain assets for inheritance."
      },
      {
        "id": "q9",
        "prompt": "When does an irrevocable trust make sense versus a revocable trust?",
        "options": [
          "Always — irrevocable trusts are more flexible.",
          "When the planning goal specifically requires loss of grantor control: estate tax reduction, asset protection, special-needs planning, or specific tax structures.",
          "When the client doesn't trust their family members.",
          "Whenever net worth exceeds $1 million."
        ],
        "correct": 1,
        "explanation": "Irrevocable trusts surrender grantor control. They're appropriate when a specific goal — estate tax reduction, asset protection, special needs preservation, life insurance trust structures — justifies giving up the flexibility. They are never the default; always involve experienced estate counsel."
      },
      {
        "id": "q10",
        "prompt": "Which life event MOST commonly creates a beneficiary designation problem advisors must catch?",
        "options": [
          "Birth of a child",
          "Buying a home",
          "Divorce — ex-spouses often remain beneficiaries on retirement accounts and life insurance long after the divorce.",
          "Job change"
        ],
        "correct": 2,
        "explanation": "Divorce is the highest-stakes trigger. State law sometimes auto-revokes ex-spouse designations, but federal law preempts for ERISA-governed plans (401(k)s) and the ex remains beneficiary unless manually changed. Every divorce should trigger a beneficiary audit on every retirement account and life insurance policy."
      },
      {
        "id": "q11",
        "prompt": "What is the role of a Wealth Solutions Counselor in estate planning?",
        "options": [
          "Draft the will and trust documents themselves.",
          "Identify the need, prepare the client, refer to and coordinate with an estate attorney, and implement and maintain the plan over time.",
          "Serve as executor and trustee for all clients.",
          "Provide specific legal advice on which provisions to choose."
        ],
        "correct": 1,
        "explanation": "Drafting documents is the practice of law and requires a licensed attorney. The counselor's role is identifying the need, preparing the client, coordinating with the attorney, and handling implementation (retitling, beneficiaries, ongoing review). The boundary is real — when in doubt, defer to the attorney."
      },
      {
        "id": "q12",
        "prompt": "Why is a bank safe deposit box generally a BAD place to store original estate documents?",
        "options": [
          "Banks don't keep them secure.",
          "They can be sealed at death until a court order is issued — exactly the moment the family needs access.",
          "Banks charge too much rent for the boxes.",
          "Documents fade in safe deposit boxes."
        ],
        "correct": 1,
        "explanation": "Safe deposit boxes can be sealed at the owner's death, requiring court intervention to access. The family needs the documents at precisely that moment. Better options: fireproof home safe, with the attorney, or with the executor. Always tell the family where the originals are."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 8;

-- ── module9_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 9 CONTENT
-- Ethics, Fiduciary Duty & Regulation
-- ============================================================================
update public.modules set
  title = 'Ethics, Fiduciary Duty & Regulation',
  competency_id = 'CORE-9',
  ri_hours = 16,
  ojl_hours = 0,
  short_description = 'The standards that separate a professional from a salesperson. Fiduciary duty, suitability, the regulatory landscape, and the daily judgment calls that make or break a career.',
  learning_objectives = ARRAY[
    'Distinguish fiduciary duty from suitability and explain why the difference matters.',
    'Identify the major U.S. regulators (SEC, FINRA, state regulators, CFP Board) and who they oversee.',
    'Recognize conflicts of interest and apply the disclose/mitigate/avoid framework.',
    'Explain Regulation Best Interest (Reg BI) and the Investment Advisers Act of 1940 at a working level.',
    'Apply the CFP Board Code of Ethics to common client scenarios.',
    'Identify the red flags that require immediate escalation to compliance.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Fiduciary Duty vs. Suitability",
      "summary": "The single most important distinction in the financial services industry.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "If a client asked you, \"is my advisor required to act in my best interest?\" — would you know how to answer? The answer depends on what kind of advisor they have, what regulator oversees that advisor, and what they're being advised on. This lesson teaches the distinction every counselor must be able to make in plain language." },

        { "type": "heading", "text": "Fiduciary duty" },
        { "type": "callout", "kind": "key", "title": "The fiduciary standard, plainly", "text": "A fiduciary is legally required to act in the client's best interest, putting the client's interests <em>ahead</em> of the fiduciary's own. This includes a duty of loyalty (no self-dealing), a duty of care (reasonable competence and prudence), and a duty of full disclosure of material conflicts of interest." },
        { "type": "paragraph", "text": "Fiduciary duty applies to:" },
        { "type": "list", "items": [
          "Registered Investment Advisers (RIAs) under the Investment Advisers Act of 1940.",
          "Investment Adviser Representatives (IARs) — the individuals registered with RIAs.",
          "Trustees, executors, attorneys, doctors, and many other professional roles.",
          "CFP® professionals when providing financial advice (per CFP Board's Code of Ethics, since 2019)."
        ]},

        { "type": "heading", "text": "Suitability" },
        { "type": "paragraph", "text": "A lower standard. Historically applied to brokers (registered representatives of broker-dealers): the recommended product must be \"suitable\" given the client's profile, but the broker is not required to recommend the <em>best</em> option for the client — only one that fits." },
        { "type": "callout", "kind": "warn", "title": "Why this difference matters", "text": "Under suitability, a broker could recommend a product paying them a 5% commission when an identical product at 0.5% existed — as long as the recommended product was \"suitable.\" Under fiduciary duty, that recommendation would be a violation. Same product. Same client. Different legal duty. Different outcome." },

        { "type": "heading", "text": "Regulation Best Interest (Reg BI)" },
        { "type": "paragraph", "text": "Adopted by the SEC in 2019. Raised the broker standard from \"suitability\" to \"best interest\" for retail customers, but stopped short of full fiduciary duty. Reg BI requires brokers to:" },
        { "type": "list", "items": [
          "Act in the retail customer's best interest at the time of recommendation.",
          "Not place the broker's financial interests ahead of the customer's.",
          "Have policies to identify and mitigate conflicts.",
          "Provide a customer relationship summary (Form CRS) disclosing relationships, fees, and conflicts."
        ]},
        { "type": "callout", "kind": "note", "title": "Reg BI is NOT full fiduciary duty", "text": "Reg BI applies to brokers at the moment of recommendation; fiduciary duty under the Advisers Act applies to investment advisers continuously across the relationship. Reg BI permits commission-based compensation; full fiduciary duty doesn't prohibit it but treats it as a conflict requiring management. The standards have converged somewhat but are not the same — and the difference still matters in client conversations." },

        { "type": "divider" },

        { "type": "heading", "text": "Why this lives at the center of the profession" },
        { "type": "paragraph", "text": "Financial advice is the rare service where the advisor's compensation can be structured in ways that conflict with what's best for the client. A real estate agent earns a commission only if you buy. A car salesperson is compensated when the car sells. Financial advisors can be paid by fees, commissions, asset-based percentages, sales contests, or product-specific compensation — and the structure shapes the recommendation, whether or not the advisor consciously realizes it." },
        { "type": "callout", "kind": "key", "title": "The honest frame", "text": "Don't ask <em>\"is this advisor a fiduciary?\"</em> Ask <em>\"how does this advisor get paid, and what would they recommend differently if they were paid another way?\"</em> That question gets to the heart of the matter and respects the client's intelligence." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Regulatory Map",
      "summary": "Who regulates whom — and where Global Investment Company fits.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Financial services regulation in the U.S. is a maze. A counselor doesn't need to be a compliance attorney, but does need to know who oversees each piece of the work — and who to call when something goes wrong." },

        { "type": "heading", "text": "The major regulators" },
        { "type": "glossary", "terms": [
          { "term": "SEC — Securities and Exchange Commission", "definition": "Federal regulator of securities markets, broker-dealers (jointly with FINRA), and Registered Investment Advisers with assets under management above $100 million." },
          { "term": "FINRA — Financial Industry Regulatory Authority", "definition": "Self-regulatory organization overseeing broker-dealers and registered representatives. Administers the Series 7, Series 6, Series 65, Series 66 and other licensing exams." },
          { "term": "State securities regulators", "definition": "Oversee Investment Advisers with AUM below $100 million (mid-sized advisers split by state-specific thresholds) and broker-dealers operating within the state." },
          { "term": "CFP Board", "definition": "Private organization that grants and maintains the Certified Financial Planner® credential. Enforces its own Code of Ethics and Standards of Conduct for CFP professionals." },
          { "term": "DOL — Department of Labor", "definition": "Regulates advice and management of ERISA-covered retirement plans (most 401(k)s, pensions). Issues fiduciary regulations for retirement plan investment advice." },
          { "term": "CFPB — Consumer Financial Protection Bureau", "definition": "Regulates consumer financial products: mortgages, credit cards, credit reporting, debt collection. Less directly relevant to investment advice but matters for advisors discussing debt and credit." },
          { "term": "State insurance commissioners", "definition": "Regulate insurance products and producers. Insurance is largely a state regulatory matter." }
        ]},

        { "type": "heading", "text": "Three kinds of advisor licensure" },
        { "type": "subheading", "text": "Investment Adviser Representative (IAR)" },
        { "type": "paragraph", "text": "Provides investment advice for compensation. Registered with an RIA firm, which is registered with the SEC (large firms) or state regulators (smaller firms). Operates under fiduciary duty. Typically passes the Series 65 (or Series 66 with Series 7). Compensation usually fee-based: percentage of AUM, hourly, flat fees." },

        { "type": "subheading", "text": "Registered Representative (RR)" },
        { "type": "paragraph", "text": "Sometimes called a stockbroker. Sells securities through a broker-dealer. Regulated by FINRA. Operates under suitability + Reg BI. Typically passes Series 7 (full securities) or Series 6 (mutual funds and variable annuities only). Compensation often commission-based." },

        { "type": "subheading", "text": "Insurance producer" },
        { "type": "paragraph", "text": "Sells insurance and annuity products. State-licensed. Operates under state insurance laws (suitability standards for annuities; variable annuities are securities and require additional FINRA licensing). Compensation typically commission-based, sometimes with renewals." },

        { "type": "callout", "kind": "key", "title": "Most modern advisors are 'dual-registered'", "text": "Carry both IAR and RR credentials. They can provide advisory services under fiduciary duty <em>and</em> sell commission products under Reg BI. The duty applied to a specific transaction depends on which capacity the advisor is acting in. Client confusion about \"hats\" is endemic; the advisor's job is to make the hat clear at every relevant moment." },

        { "type": "divider" },

        { "type": "heading", "text": "Where Global Investment Company fits" },
        { "type": "paragraph", "text": "Global Investment Company operates as a Registered Investment Adviser under the Investment Advisers Act of 1940. Wealth Solutions Counselors at GIC operate under fiduciary duty. This is the firm's chosen standard and is reflected in our compensation model (fee-based, no commissions), our disclosure practices (Form ADV available to all clients), and our standards of practice (documented in this curriculum)." },
        { "type": "callout", "kind": "do", "title": "Form ADV", "text": "Every RIA must file <strong>Form ADV</strong> with the SEC or state regulators. Parts 2A and 2B are written in plain English and disclose services, fees, conflicts, disciplinary history of the firm and its representatives. Every client must receive these. As a counselor, you should be able to point clients to GIC's Form ADV and walk them through the relevant sections. Memorize where they live in your firm's onboarding kit." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Conflicts of Interest",
      "summary": "What they are, why they're inevitable, and the framework for handling them.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Conflicts of interest are not bad in themselves — they're inherent to almost every advisor-client relationship. The professional question is not \"are there conflicts?\" The professional question is \"are the conflicts disclosed, mitigated, or avoided — and which one is appropriate for each conflict?\"" },

        { "type": "heading", "text": "Common conflicts to recognize" },
        { "type": "list", "items": [
          "<strong>Compensation structure</strong> — fee-based, commission-based, AUM-based all create different incentives. AUM advisors are paid more when assets grow, including incentivizing the advisor to keep client assets under management even when paying down debt or buying a home would be a better use.",
          "<strong>Product compensation differentials</strong> — some products pay the firm more than others. The advisor's recommendation should not be driven by what pays better.",
          "<strong>Proprietary products</strong> — firms with their own mutual funds, annuities, or insurance products face conflicts when recommending in-house vs. third-party alternatives.",
          "<strong>Cross-selling pressure</strong> — banks and large firms often expect advisors to refer clients to other product lines (mortgages, insurance, trust services). Each referral creates a potential conflict.",
          "<strong>Sales contests and incentives</strong> — quarterly contests, trips, bonuses tied to product sales create strong incentives that can override fiduciary judgment.",
          "<strong>Outside relationships</strong> — when the advisor has a personal or business relationship with a product provider, custodian, or referral source.",
          "<strong>Personal investments</strong> — when the advisor owns the same securities being recommended (front-running, etc.)."
        ]},

        { "type": "heading", "text": "The framework: disclose, mitigate, avoid" },
        { "type": "subheading", "text": "Disclose" },
        { "type": "paragraph", "text": "Most conflicts cannot be eliminated. They can be disclosed — in writing, in plain language, ideally before the recommendation is acted on. Disclosure shifts the question to the client: \"given that I am paid this way, here is my recommendation.\" Disclosure alone does not satisfy fiduciary duty if the conflict actually drives the recommendation — but it's the floor." },

        { "type": "subheading", "text": "Mitigate" },
        { "type": "paragraph", "text": "Some conflicts can be reduced. Examples:" },
        { "type": "list", "items": [
          "Internal review of recommendations involving products paying higher compensation.",
          "Required documentation of why a recommendation was made (especially when alternatives exist).",
          "Compensation grids that pay the advisor the same regardless of which product within a category is recommended.",
          "Refusing certain compensation arrangements that create structural pressure (sales contests, etc.).",
          "Pre-trade approval requirements for personal securities trades."
        ]},

        { "type": "subheading", "text": "Avoid" },
        { "type": "paragraph", "text": "Some conflicts are sufficiently serious that the only correct response is to walk away from them. Examples:" },
        { "type": "list", "items": [
          "Accepting gifts or entertainment beyond modest, customary levels.",
          "Personal financial relationships with clients beyond the advisory relationship (loans, joint investments, romantic relationships).",
          "Serving as a beneficiary of a client's estate (other than for the advisor's own family).",
          "Trading client securities for personal benefit ahead of client trades.",
          "Recommending a product that pays significantly more in compensation when an alternative is clearly better for the client."
        ]},

        { "type": "callout", "kind": "key", "title": "The decision rule", "text": "<em>If I had to defend this recommendation in front of regulators, a judge, and the client's adult children, knowing they would learn how I was compensated — would my recommendation still hold up?</em> If yes, document it and proceed. If no, change the recommendation or escalate." },

        { "type": "case_study",
          "title": "The product recommendation",
          "scenario": "Your firm offers two retirement income products in roughly the same category. Product A pays your firm a 1% advisory fee on assets; Product B is a proprietary annuity with a 5% upfront commission to the firm and to you personally. Both products are 'suitable' for the client.",
          "discussion": "<p>Under suitability, either product is acceptable. Under fiduciary duty, the standard is harder: which is actually in the client's best interest?</p><p>To answer honestly, compare on dimensions that matter to the client: total fees over expected holding period, surrender charges, flexibility of access, expected returns, tax treatment, complexity, and the client's actual planning need. If after that analysis the proprietary annuity is genuinely the better product for the client, then it's the right recommendation — and the documentation should clearly show why.</p><p>If after that analysis the open-architecture advisory fee product is better and you still recommend the annuity because of compensation, you've violated fiduciary duty regardless of whether the annuity is 'suitable.' The honest test isn't whether the product fits — it's whether it's the best available option for this client.</p><p><strong>Document the analysis, every time.</strong> If you can't explain why a higher-compensation product was chosen over a lower-compensation alternative in writing, don't choose it.</p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "The CFP Board Standards and Ethical Decision-Making",
      "summary": "How professionals decide when the right answer isn't obvious.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Many of the hardest moments in advisory practice are not technical questions — they're ethical ones. The CFP Board Code of Ethics and Standards of Conduct provides a framework for these moments. Even if a counselor is not yet a CFP professional, knowing the framework strengthens judgment." },

        { "type": "heading", "text": "The CFP Code of Ethics" },
        { "type": "paragraph", "text": "The CFP Board requires its certificants to commit to six principles:" },
        { "type": "numbered", "items": [
          "<strong>Act with honesty, integrity, competence, and diligence.</strong>",
          "<strong>Act in the client's best interests.</strong>",
          "<strong>Exercise due care.</strong>",
          "<strong>Avoid or disclose and manage conflicts of interest.</strong>",
          "<strong>Maintain the confidentiality and protect the privacy of client information.</strong>",
          "<strong>Act in a manner that reflects positively on the financial planning profession and CFP® certification.</strong>"
        ]},

        { "type": "heading", "text": "The fiduciary duty within the CFP Standards" },
        { "type": "paragraph", "text": "When providing financial advice to a client, a CFP professional is bound by a <strong>fiduciary duty</strong> consisting of:" },
        { "type": "list", "items": [
          "<strong>Duty of loyalty</strong> — place the client's interests above the CFP's own and the firm's.",
          "<strong>Duty of care</strong> — provide advice with care, skill, prudence, and diligence reasonable under the circumstances.",
          "<strong>Duty to follow client instructions</strong> — within the scope of the engagement and consistent with the law."
        ]},

        { "type": "heading", "text": "Ethical decision-making in practice" },
        { "type": "paragraph", "text": "When the right answer isn't obvious, the structured approach is:" },
        { "type": "numbered", "items": [
          "<strong>Identify the parties and their interests.</strong> Whose interests are affected and how?",
          "<strong>Identify the relevant duties.</strong> What does fiduciary duty require? What does the firm's policy require? What do applicable regulations require?",
          "<strong>Identify the conflict.</strong> Where do interests or duties collide?",
          "<strong>Consider alternatives.</strong> What are the possible courses of action?",
          "<strong>Evaluate each alternative.</strong> Against client interest, against duties, against the optics of the decision.",
          "<strong>Decide and act.</strong> Choose the course of action best aligned with duty and document the reasoning.",
          "<strong>Escalate when uncertain.</strong> When the stakes are meaningful or the answer unclear, involve a supervisor or compliance officer."
        ]},

        { "type": "callout", "kind": "do", "title": "The simple test before any tough call", "text": "<em>If this decision became public tomorrow — to my client, to my employer, to regulators, to the press — would I be comfortable defending it?</em> If yes, proceed and document. If no, reconsider or escalate. The discomfort of escalating is far smaller than the discomfort of a violation that surfaces later." },

        { "type": "divider" },

        { "type": "case_study",
          "title": "The friend-of-a-friend referral",
          "scenario": "A new client is referred by an existing client, who calls and says, 'I told her you'd take care of her, she's recently widowed and inherited $1.2M, just put it somewhere safe.' The widow is 64, grieving, hasn't yet processed the situation, and signs whatever you put in front of her in the first meeting.",
          "discussion": "<p>Several ethical issues at once:</p><ul><li><strong>Capacity to engage.</strong> A grieving client immediately after a major loss may not be in a state to make informed long-term decisions. The 30-day-rule (some advisors won't make major recommendations within 30–60 days of a significant life event) exists for this reason.</li><li><strong>Discovery.</strong> You can't make a fiduciary recommendation without understanding the client's situation. 'Put it somewhere safe' is not a goal — it's a feeling.</li><li><strong>Referring-client pressure.</strong> The implicit \"I told her you'd take care of her\" creates pressure to act quickly to deliver for the referrer. That pressure runs counter to taking the time the situation requires.</li><li><strong>Signing documents.</strong> The widow signing without comprehension is not informed consent.</li></ul><p>The right move: slow down. Express condolences clearly. Do a thorough discovery over multiple meetings. Park the $1.2M in a high-yield savings account or short-term Treasuries while you both work toward clarity. Document everything. Resist any temptation to recommend investment products in the first few weeks. If the referring client gets impatient, that's a signal about the referring client, not about the work — explain calmly that this is how you serve clients well, regardless of how they came in the door.</p><p><strong>This is fiduciary duty in practice: not the technical right product, but the right pace and the right care.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Red Flags and Escalation",
      "summary": "What to do when something doesn't sit right — and the price of not doing it.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Ethical practice is shaped less by big decisions and more by daily judgment calls. The counselor who learns to recognize red flags and act on them is the counselor whose career lasts. The one who lets things slide accumulates risk that eventually erupts." },

        { "type": "heading", "text": "Client-side red flags" },
        { "type": "list", "items": [
          "<strong>Diminished capacity.</strong> Client confusion about their own finances, memory lapses, unusual decisions, vulnerability to family pressure. Escalate and follow firm protocols (which may include reaching out to a trusted contact on file).",
          "<strong>Suspected elder financial abuse.</strong> Caregiver involvement in unusual transactions, new \"friend\" appearing in financial matters, isolation from family. Many states require advisors to report suspected abuse.",
          "<strong>Sudden, unexplained changes</strong> in beneficiaries, withdrawal patterns, or risk tolerance — particularly from clients who have previously been consistent.",
          "<strong>Pressure to make a transaction.</strong> 'I need this done today.' Urgency is a red flag, not a justification.",
          "<strong>Requests on accounts the client doesn't own.</strong> Anything involving an elderly parent, an adult child, an ex-spouse, a business partner.",
          "<strong>Disclosure of marital problems, depression, or addiction.</strong> Not directly an investment issue, but each affects judgment and may signal need for caution and slowing down.",
          "<strong>Mention of large unsolicited investment opportunities</strong> — friend's startup, crypto scheme, real estate fund, etc. Often legitimate, sometimes fraud, sometimes outside the advisor's scope."
        ]},

        { "type": "heading", "text": "Advisor-side red flags" },
        { "type": "paragraph", "text": "Equally important: notice when something about <em>your own</em> situation or another colleague's situation crosses a line." },
        { "type": "list", "items": [
          "Personal financial pressure that might influence recommendations.",
          "Compensation structure that's pushing toward a specific product or behavior.",
          "Personal relationship with a client that's becoming non-professional.",
          "Receiving gifts or entertainment that feels disproportionate.",
          "Colleague's behavior toward clients, accounts, or compliance procedures that doesn't add up.",
          "Pressure from a supervisor to skip steps, rush decisions, or sell specific products."
        ]},

        { "type": "callout", "kind": "warn", "title": "What to do with red flags", "text": "Document the observation in client notes. Escalate to a supervisor or compliance officer. If the conduct is criminal or fraudulent, internal whistleblower protections apply, and external reporting channels exist (SEC tip line, FINRA complaint, state regulator). Inaction is not a neutral choice — silence becomes complicity." },

        { "type": "heading", "text": "The career arc this protects" },
        { "type": "paragraph", "text": "The vast majority of advisors who are sanctioned, fined, or barred from the industry didn't intend to commit a violation. They drifted. A small ethical compromise here, a missed disclosure there, a friend's deal that seemed harmless. The accumulation eventually reaches a regulator or a lawsuit, and at that point the documentation either tells a clean story or it doesn't." },

        { "type": "callout", "kind": "key", "title": "The advisor who lasts", "text": "Treats every recommendation as if it might be reviewed five years from now. Documents conflicts before they're noticed. Escalates uncomfortable conversations rather than swallowing them. Operates with the assumption that clean practice <em>is</em> the business model — not friction that interferes with it. <strong>This is what \"professional\" means in the deepest sense.</strong> It's also what makes a 40-year career possible." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the most important practical difference between fiduciary duty and suitability?",
        "options": [
          "Fiduciary duty applies only to lawyers; suitability applies to financial advisors.",
          "Fiduciary duty requires acting in the client's best interest; suitability requires only that a recommendation be appropriate.",
          "Fiduciary duty applies only to retirement accounts; suitability applies to taxable accounts.",
          "They are the same standard with different names."
        ],
        "correct": 1,
        "explanation": "Fiduciary requires the client's interests come first. Suitability allows a 'fitting' recommendation even when better options exist. Same product, same client, different legal duty, different acceptable outcome."
      },
      {
        "id": "q2",
        "prompt": "Which federal law makes Registered Investment Advisers (RIAs) fiduciaries?",
        "options": [
          "Sarbanes-Oxley Act of 2002",
          "Investment Advisers Act of 1940",
          "Securities Act of 1933",
          "Dodd-Frank Act of 2010"
        ],
        "correct": 1,
        "explanation": "The Investment Advisers Act of 1940 establishes the regulatory framework for RIAs and the fiduciary duty under which they operate."
      },
      {
        "id": "q3",
        "prompt": "What is Regulation Best Interest (Reg BI)?",
        "options": [
          "A 2019 SEC regulation requiring brokers to act in the retail customer's best interest at the time of recommendation, raising the standard from pure suitability but stopping short of full fiduciary duty.",
          "A FINRA rule about insider trading.",
          "A state-level fiduciary requirement.",
          "A DOL rule about retirement accounts only."
        ],
        "correct": 0,
        "explanation": "Reg BI raised the broker standard above pure suitability for retail customers but did not impose full fiduciary duty. It applies at the moment of recommendation, requires conflicts disclosure, and mandates Form CRS. Distinct from the continuous fiduciary duty under the Advisers Act."
      },
      {
        "id": "q4",
        "prompt": "An advisor compares two retirement products: Product A is fee-based (1% AUM), Product B is a proprietary annuity paying 5% upfront commission. Both are 'suitable.' Under fiduciary duty, the advisor must:",
        "options": [
          "Recommend Product A because lower fees are always better.",
          "Recommend Product B because the firm benefits more.",
          "Compare them honestly on dimensions that matter to the client and recommend the genuinely better option — documenting why if Product B is chosen.",
          "Let the client decide without a recommendation."
        ],
        "correct": 2,
        "explanation": "Fiduciary duty requires honest comparison and a recommendation in the client's best interest. If Product B is genuinely better despite higher compensation, recommending it is fine — but the analysis must demonstrate why, not just that the product is 'suitable.'"
      },
      {
        "id": "q5",
        "prompt": "Which form must every Registered Investment Adviser file and provide to clients?",
        "options": [
          "Form 1099",
          "Form ADV",
          "Form W-9",
          "Form 5500"
        ],
        "correct": 1,
        "explanation": "Form ADV (Parts 2A and 2B in plain English) disclose services, fees, conflicts, disciplinary history of the firm and its representatives. Required for every RIA. Counselors should know where these live in the firm's onboarding materials."
      },
      {
        "id": "q6",
        "prompt": "Conflicts of interest in advisory practice are best handled by:",
        "options": [
          "Eliminating all conflicts entirely.",
          "Ignoring them since they're inherent to the business.",
          "Disclosing, mitigating, or avoiding each conflict as appropriate — applying the right level of response to the level of conflict.",
          "Letting compliance handle all of them."
        ],
          "correct": 2,
          "explanation": "Most conflicts cannot be eliminated and are inherent to advisor compensation structures. The professional response: disclose lower-stakes conflicts, mitigate larger ones through process and policy, and avoid the conflicts that cannot be ethically managed (personal financial relationships with clients, beneficiary designations, etc.)."
      },
      {
        "id": "q7",
        "prompt": "Which of the following are core principles of the CFP Board Code of Ethics?",
        "options": [
          "Aggressively grow client assets, generate referrals, minimize taxes, maximize returns.",
          "Honesty, integrity, competence and diligence; act in client's best interest; due care; manage conflicts; maintain confidentiality; reflect positively on the profession.",
          "Sell suitable products, document recommendations, supervise junior staff.",
          "Pass continuing education, file annual reports, pay dues on time."
        ],
        "correct": 1,
        "explanation": "These are the six core principles of the CFP Board Code of Ethics. They apply to all CFP professionals and form the foundation of professional standards in financial planning."
      },
      {
        "id": "q8",
        "prompt": "A grieving client recently inherited $1.2M and wants you to 'put it somewhere safe today.' What's the right counselor move?",
        "options": [
          "Recommend an immediate purchase of a balanced mutual fund — she said somewhere safe.",
          "Slow down, do thorough discovery over multiple meetings, park the funds in a high-yield savings or short Treasuries until the client has clarity, and document the approach.",
          "Refuse the client because she's not making informed decisions.",
          "Have her sign documents quickly while she's motivated."
        ],
        "correct": 1,
        "explanation": "A grieving client immediately after a major loss may not be in a state to make informed long-term decisions. The right move: slow down, build understanding through discovery, park the money in safe and liquid options, and resist external pressure to act quickly. This is fiduciary duty in practice — not just product selection."
      },
      {
        "id": "q9",
        "prompt": "Which is a red flag requiring immediate escalation to a supervisor?",
        "options": [
          "Client asks a question about an unfamiliar product.",
          "A request involving an account the client doesn't legally own (e.g., an elderly parent's account).",
          "Client wants to change asset allocation.",
          "Client misses a quarterly meeting."
        ],
        "correct": 1,
        "explanation": "Requests involving accounts the client doesn't legally control may signal elder abuse, unauthorized activity, or the need for proper authorization. Escalate immediately rather than proceed. The cost of escalation is small; the cost of doing nothing can be enormous."
      },
      {
        "id": "q10",
        "prompt": "Why are commission-based sales contests a particular concern under fiduciary duty?",
        "options": [
          "They violate the law.",
          "They are illegal under all circumstances.",
          "They create structural incentives that can override fiduciary judgment by paying advisors more for one product over another regardless of client benefit.",
          "They are taxed at higher rates."
        ],
        "correct": 2,
        "explanation": "Sales contests financially incentivize the advisor to recommend specific products, which can drive recommendations toward higher-commission options rather than the best client outcome. They're not necessarily illegal but they create powerful pressure against fiduciary duty. Many firms have eliminated them; many haven't."
      },
      {
        "id": "q11",
        "prompt": "The 'simple test' to apply before making a difficult ethical call is:",
        "options": [
          "Would my supervisor approve?",
          "Is it technically legal?",
          "If this decision became public tomorrow — to my client, my employer, regulators, and the press — would I be comfortable defending it?",
          "Will it generate revenue for the firm?"
        ],
        "correct": 2,
        "explanation": "The public-defensibility test captures the spirit of fiduciary duty better than any single technical rule. If you'd be comfortable defending the decision openly, document and proceed. If not, reconsider or escalate. This single question prevents most career-ending mistakes."
      },
      {
        "id": "q12",
        "prompt": "What characterizes the advisor who builds a 40-year career without regulatory issues?",
        "options": [
          "Generates the most fees and commissions.",
          "Treats every recommendation as if it might be reviewed five years from now; documents conflicts proactively; escalates uncomfortable conversations rather than swallowing them.",
          "Has the most clients.",
          "Avoids all regulators and lawyers."
        ],
        "correct": 1,
        "explanation": "The advisors who get sanctioned didn't usually intend violations — they drifted. Clean documentation, proactive disclosure, willingness to escalate, and the assumption that clean practice IS the business model are what makes a long career possible."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 9;

-- ── module10_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 10 CONTENT
-- Client Discovery & Intake
-- ============================================================================
update public.modules set
  title = 'Client Discovery & Intake',
  competency_id = 'OJL-1',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'The first conversation. How to gather what you need without making a client feel interrogated, and why the qualitative information matters more than the quantitative.',
  learning_objectives = ARRAY[
    'Conduct a structured first meeting that builds trust and surfaces the right information.',
    'Distinguish quantitative discovery (numbers) from qualitative discovery (goals, values, fears).',
    'Use open-ended questions effectively and listen actively.',
    'Recognize and adapt to family dynamics, money scripts, and emotional history with money.',
    'Document a discovery meeting in a way that allows a colleague to pick up the file cleanly.',
    'Identify when to defer questions or split discovery across multiple meetings.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "The First Meeting",
      "summary": "The structure that gets discovery right — and the mistakes that derail it.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The first meeting with a client sets the tone for everything that follows. A good first meeting is half listening, half clarifying, and ends with both parties knowing exactly what happens next. A bad first meeting is half pitch, half data collection, and leaves the client wondering why they came." },

        { "type": "callout", "kind": "key", "title": "The frame", "text": "Discovery is not data entry. Discovery is <em>understanding a household well enough to give them advice that fits them</em>. The numbers matter, but they're the easy part — the bank statements will arrive whether or not the meeting went well. The qualitative information either gets surfaced in the first conversations or doesn't surface at all." },

        { "type": "heading", "text": "A working structure for the first meeting" },
        { "type": "numbered", "items": [
          "<strong>Welcome and orientation (5 min).</strong> Make them comfortable. Explain how the meeting will run, how long it will take, that they can stop or ask questions anytime.",
          "<strong>Their story (15–20 min).</strong> Open with the broadest possible question and listen. \"Tell me what's going on in your financial life right now\" or \"What brought you in?\" Resist the urge to redirect, even if they wander.",
          "<strong>Goals and concerns (15 min).</strong> Surface what they want, what they're worried about, what's keeping them up. Ask follow-ups, not just the next question on the form.",
          "<strong>Quick quantitative scan (10–15 min).</strong> Get high-level numbers — income, savings, debts, family structure. Detailed gathering happens later via documents.",
          "<strong>Family and life context (10 min).</strong> Children, parents, dependents, health, expected changes.",
          "<strong>How you work (5 min).</strong> Explain your firm, your fiduciary duty, fees, services. Don't sell — orient.",
          "<strong>Next steps (5 min).</strong> Document what they'll send you (statements, tax returns, plan documents), when the next meeting is, what it will cover.",
          "<strong>Disclosures and Form ADV (during meeting or at end).</strong> Required for compliance. Set expectations for documents that will arrive in their inbox."
        ]},

        { "type": "callout", "kind": "do", "title": "The two questions to ask in every first meeting", "text": "<strong>(1)</strong> \"What would have to be true a year from now for you to feel like working with us was a good decision?\" — surfaces real goals.<br/><strong>(2)</strong> \"Tell me about your relationship with money growing up.\" — surfaces money scripts that shape every financial decision." },

        { "type": "heading", "text": "What a good first meeting feels like — to the client" },
        { "type": "list", "items": [
          "They did more talking than the advisor.",
          "They were asked at least one question no one had asked them before.",
          "They left with a written list of what to send and when.",
          "They felt understood rather than processed.",
          "They are clear on what the next meeting will accomplish and when it is."
        ]},

        { "type": "callout", "kind": "warn", "title": "Mistakes that destroy first meetings", "text": "Reading off the intake form. Selling services in the first half of the meeting. Cutting the client off when they're telling a story that doesn't seem 'on topic' — those stories ARE the topic. Making recommendations before discovery is complete. Pretending to understand when you don't. Avoiding awkward questions about death, divorce, illness, or family conflict — these are exactly the questions that produce the most planning value." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Quantitative Discovery",
      "summary": "Numbers, sources, and the documents that tell the real story.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Numbers are the easier half of discovery. A standard set of documents tells you almost everything you need about a household's quantitative situation. The skill is knowing what to ask for, how to organize it, and what to do when something is missing." },

        { "type": "heading", "text": "The standard intake document set" },
        { "type": "subheading", "text": "Income and employment" },
        { "type": "list", "items": [
          "Most recent pay stubs (showing gross, deductions, net, year-to-date) for each working adult.",
          "Most recent two years of W-2s.",
          "Self-employment: most recent two years Schedule C or business return, year-to-date P&L.",
          "Variable income (RSU, bonus, commission): vesting schedules, recent annual statements.",
          "Pension and Social Security statements (if applicable)."
        ]},

        { "type": "subheading", "text": "Tax returns" },
        { "type": "list", "items": [
          "Most recent two years of federal and state returns, all schedules.",
          "If pending an extension or amendment, status of that.",
          "Any IRS or state correspondence open."
        ]},

        { "type": "subheading", "text": "Assets" },
        { "type": "list", "items": [
          "Bank statements (checking, savings, money market) — most recent.",
          "Investment account statements — all of them. Brokerage, retirement, education savings, HSA.",
          "Real estate: current value estimate, mortgage balance, original cost basis if available.",
          "Business interests: most recent valuation if applicable.",
          "Other significant assets: collectibles, art, cryptocurrency, private investments."
        ]},

        { "type": "subheading", "text": "Liabilities" },
        { "type": "list", "items": [
          "Mortgage statement(s) showing current balance, rate, term.",
          "Other loan statements (auto, student, personal).",
          "Credit card statements showing balances and rates.",
          "Any other debts (medical, tax debt, personal loans)."
        ]},

        { "type": "subheading", "text": "Insurance" },
        { "type": "list", "items": [
          "Life insurance: declarations pages of all policies.",
          "Disability insurance: policy documents and employer benefit summaries.",
          "Health insurance: current plan and recent annual benefit statement.",
          "Property/casualty: declarations pages for auto, homeowners/renters, umbrella.",
          "Other: long-term care, annuities, specialty coverages."
        ]},

        { "type": "subheading", "text": "Estate documents" },
        { "type": "list", "items": [
          "Will (current version, all amendments).",
          "Trust documents (if any).",
          "Powers of attorney — durable financial and healthcare.",
          "Advance directives.",
          "Beneficiary designations on retirement accounts and life insurance — most recent confirmations."
        ]},

        { "type": "callout", "kind": "do", "title": "The intake checklist", "text": "Every firm should have a standard intake checklist organized by category. Send it before the first meeting if possible, or after the first meeting with deadlines. Reduce it to one page when possible — long lists trigger procrastination. Follow up at one week, two weeks, four weeks if items aren't arriving." },

        { "type": "callout", "kind": "warn", "title": "What incomplete information signals", "text": "When a client can't or won't produce a routine document, take it seriously. Sometimes it's disorganization. Sometimes it's shame about the actual numbers (especially debt). Sometimes it's marital secrecy. Sometimes there's a problem the client hasn't admitted to themselves yet. The advisor's job is to notice and proceed gently — not to demand or to ignore." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Qualitative Discovery",
      "summary": "Money scripts, family dynamics, and the questions that produce real insight.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Qualitative discovery is the harder half. It asks: <em>what does this household actually want, what are they afraid of, and what shapes their decisions?</em> No spreadsheet answers these questions. They emerge through conversation, careful listening, and questions that go beneath the surface." },

        { "type": "heading", "text": "Money scripts" },
        { "type": "paragraph", "text": "Coined by financial psychologists Brad and Ted Klontz, money scripts are unconscious beliefs about money formed in childhood and carried into adulthood. They shape financial behavior more than income does. Four common scripts:" },
        { "type": "list", "items": [
          "<strong>Money avoidance</strong> — money is bad, dirty, corrupting. Rich people are immoral. Result: subconscious sabotage of wealth-building. Underearning despite capability.",
          "<strong>Money worship</strong> — more money will solve life's problems. Happiness comes from accumulation. Result: workaholism, chronic dissatisfaction, debt to fund lifestyle.",
          "<strong>Money status</strong> — net worth equals self-worth. Spending signals identity. Result: lifestyle inflation, financial decisions driven by appearance.",
          "<strong>Money vigilance</strong> — money should be saved, not spent. Discussing finances is taboo. Generally the healthiest script, though extreme cases produce miserliness and inability to enjoy wealth."
        ]},
        { "type": "callout", "kind": "key", "title": "The advisor's role", "text": "You don't change a client's money scripts in a single meeting. You recognize them. The 60-year-old physician who 'doesn't deserve' to retire despite millions in assets is operating on a money script, not on numbers. The recently-promoted executive who immediately upgrades the house, the car, and the lifestyle is operating on a script too. Knowing the script shapes which recommendation will actually land." },

        { "type": "heading", "text": "Questions that surface qualitative information" },
        { "type": "subheading", "text": "About values and goals" },
        { "type": "list", "items": [
          "If money were no object, what would you do with the next ten years?",
          "What's a recent purchase that brought you real, lasting satisfaction?",
          "What do you wish you had more time for?",
          "What does \"enough\" look like for you?",
          "What's something you'd want to leave behind?"
        ]},

        { "type": "subheading", "text": "About fears" },
        { "type": "list", "items": [
          "What's the financial concern that wakes you up at 3 AM?",
          "What's the worst-case scenario you find yourself preparing for?",
          "What financial conversation are you avoiding?",
          "What would have to happen for things to go really wrong?"
        ]},

        { "type": "subheading", "text": "About the past" },
        { "type": "list", "items": [
          "Tell me about your relationship with money growing up.",
          "Did your parents argue about money? Talk about it?",
          "What's the best money decision you've ever made?",
          "What's a money mistake you'd want to avoid making again?"
        ]},

        { "type": "subheading", "text": "About family" },
        { "type": "list", "items": [
          "Who else has a stake in these decisions? Spouse, children, parents?",
          "Are there conversations happening at home about this we should know about?",
          "Are there family members who depend on you financially? Or might in the future?",
          "Has there been a financial event in your family — inheritance, business sale, illness — that shaped how you think about money now?"
        ]},

        { "type": "callout", "kind": "do", "title": "The technique that matters most", "text": "<strong>Silence after the question.</strong> Most advisors fill the silence after an open-ended question, robbing the client of the space to think and answer fully. Ask, then wait. The client's first answer is often surface-level; the second is often the real answer. The silence is what produces the second answer." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Family Dynamics and the Couple's Meeting",
      "summary": "When you're advising a household, you're advising a relationship.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Most clients are not individuals — they're households. And household financial decisions are made by relationships, not by spreadsheets. A counselor who can read the relationship dimension produces planning that actually gets implemented." },

        { "type": "heading", "text": "The couple in the first meeting" },
        { "type": "subheading", "text": "Things to notice" },
        { "type": "list", "items": [
          "Who's doing the talking? Often one spouse handles money and the other defers. This isn't necessarily bad, but it's information about how decisions get made.",
          "Where do they disagree? Watch for body language when one answers a question — eye rolls, slight shake of the head, a look between them. Pause and ask: 'I get the sense you two might see this a little differently — am I right?'",
          "What language do they use? 'My money' vs. 'our money' is a window into the relationship structure, especially in second marriages.",
          "Who's anxious about what? Common pattern: one spouse worries about market risk, the other worries about not having enough."
        ]},

        { "type": "callout", "kind": "key", "title": "The seven topics couples disagree about", "text": "Most couples have at least one fundamental disagreement about: (1) <strong>how much risk is acceptable</strong>, (2) <strong>how much to give to adult children</strong>, (3) <strong>when to retire</strong>, (4) <strong>where to live in retirement</strong>, (5) <strong>how generous to be with charity</strong>, (6) <strong>how to handle aging parents</strong>, (7) <strong>what to leave to heirs</strong>. Get these surfaced early. The plan that ignores them isn't a plan — it's a paper exercise that breaks the first time real money is at stake." },

        { "type": "heading", "text": "When to recommend separate conversations" },
        { "type": "paragraph", "text": "Most discovery should happen with both spouses present. Some moments call for one-on-one conversation:" },
        { "type": "list", "items": [
          "Disclosure of past financial issues (debt, addiction, prior bankruptcy) the client may not have shared with the spouse.",
          "Disclosure of impending changes (job loss, intent to leave the marriage, health concerns).",
          "Family financial issues affecting one spouse's parents or siblings.",
          "Disagreements between spouses that are too charged to work through in front of each other."
        ]},
        { "type": "callout", "kind": "warn", "title": "The boundary", "text": "If a client tells you something privately that materially affects the planning — for example, an affair, a plan to divorce, a hidden account — you have a real ethical problem. You cannot plan honestly for the household while holding undisclosed information that would change the recommendations. Most firms have specific policies on this; know yours and consult compliance. The general principle: gently encourage disclosure, document the conversation, and decline to proceed on plans that depend on the undisclosed information." },

        { "type": "divider" },

        { "type": "heading", "text": "Multi-generational dynamics" },
        { "type": "paragraph", "text": "Increasingly, advisory engagements involve multiple generations: adult children advising aging parents, parents trying to help adult children, grandparents funding grandchildren's education. Each pattern has its own complexity." },
        { "type": "subheading", "text": "Common dynamics" },
        { "type": "list", "items": [
          "<strong>Adult child overstepping.</strong> Well-meaning child making decisions for capable parent. Watch for the autonomy of the actual client.",
          "<strong>Hidden caregiving costs.</strong> One adult child carrying most of the load for elderly parents; that cost rarely shows up in the parents' net worth statement.",
          "<strong>Inheritance expectations.</strong> Adult children making spending decisions based on expected inheritance that the parents have no intention of leaving them (or vice versa).",
          "<strong>Grandparent education funding.</strong> Generous but sometimes structured in ways that complicate financial aid, gift tax, or family relationships."
        ]},

        { "type": "case_study",
          "title": "The discovery meeting that surfaces what matters",
          "scenario": "A married couple comes in. He talks about retirement planning, target portfolio returns, the inheritance they'll receive from his mother eventually. She is quiet through most of the meeting. Toward the end you ask her: 'I'd love to hear what you most want to be true ten years from now.' She pauses, then says: 'I want to know that if something happens to him, I won't have to figure out the money alone.'",
          "discussion": "<p>In one sentence, the entire discovery just shifted. The plan he wants is about wealth accumulation. The plan she needs is about financial autonomy and her ability to manage the household alone if necessary.</p><p>A planner who builds the portfolio he asked for and skips her concern produces a 'plan' that completely misses what would make this a successful engagement for the household. The right move: pause, acknowledge what she just said, ask follow-ups (\"What would it look like for you to feel confident? What do you wish you knew that you don't?\"), and build her requirements explicitly into the goals.</p><p>The deliverable for this couple includes everything he wanted PLUS structures that make her financial life manageable on her own — simpler portfolios, named contingent contacts, clear documentation of what to do and who to call, regular check-ins with her specifically. <strong>This is what \"financial planning is half listening\" actually means in practice.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Documentation and Handoff",
      "summary": "How to leave a trail that lets a colleague pick up the file at any moment.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "The work of discovery is only as good as the documentation of it. A 90-minute meeting in your head is worth nothing two months later when you can't remember the details. The discipline of writing things up — promptly, completely, in your own words — is what makes discovery durable." },

        { "type": "heading", "text": "The discovery memo" },
        { "type": "paragraph", "text": "Within 24 hours of the meeting, capture in writing:" },
        { "type": "list", "items": [
          "<strong>Date, time, attendees.</strong>",
          "<strong>Format.</strong> In-person, video, phone.",
          "<strong>Top-line summary.</strong> One paragraph: who they are, what they want, where they are now, what's next.",
          "<strong>Quantitative snapshot.</strong> Income, current net worth, major assets, major debts. Note sources for each number.",
          "<strong>Goals.</strong> In their words first, then in planning terms. Time-bound when possible.",
          "<strong>Concerns and constraints.</strong> What worries them, what's off the table, what's non-negotiable.",
          "<strong>Family and life context.</strong> Marital status, dependents, parents, expected life changes.",
          "<strong>Money story.</strong> Brief — what came up about their relationship with money.",
          "<strong>Discovery gaps.</strong> What you didn't get to, what you still need to learn.",
          "<strong>Documents requested and status.</strong> What they're sending you and when.",
          "<strong>Next steps and next meeting.</strong> Scheduled or pending.",
          "<strong>Open issues for follow-up.</strong> Things flagged that need attention later."
        ]},

        { "type": "callout", "kind": "do", "title": "Capture impressions, not just facts", "text": "Good discovery memos include things like: 'She seemed visibly uncomfortable when discussing her mother's care needs — likely a sensitive area to revisit gently.' Or: 'He emphasized risk avoidance three times despite an aggressive current portfolio — possible mismatch between stated and actual tolerance.' These observations are planning gold and disappear if not captured." },

        { "type": "heading", "text": "The handoff principle" },
        { "type": "paragraph", "text": "Imagine you're hit by a bus tomorrow and a colleague has to take over this engagement. Can they read your files and continue the work with the client experiencing minimal disruption? If yes, your documentation is good enough. If no, fix it." },

        { "type": "callout", "kind": "key", "title": "Why this matters beyond bus accidents", "text": "Discovery files are read by: future-you in six months, a colleague covering during your vacation, the team lead reviewing the case, compliance during periodic audits, and (rarely) regulators in a complaint. Each of these readers needs to understand what happened and why. The discipline of documenting for those readers is the same discipline that protects your career, serves the client, and makes the firm professional." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What is the primary purpose of a first discovery meeting?",
        "options": [
          "Sell the firm's services.",
          "Collect the standard data set in the intake form.",
          "Understand the household well enough to advise them — surfacing both quantitative AND qualitative information.",
          "Make initial recommendations."
        ],
        "correct": 2,
        "explanation": "Discovery is about understanding, not data entry or selling. Documents will arrive whether or not the meeting goes well. Qualitative information (goals, fears, money scripts) either surfaces in conversation or doesn't surface at all."
      },
      {
        "id": "q2",
        "prompt": "Which two questions are most powerful in a first meeting?",
        "options": [
          "What's your risk tolerance? What's your income?",
          "What would have to be true a year from now for this to feel like a good decision? Tell me about your relationship with money growing up.",
          "What's your net worth? What's your time horizon?",
          "Have you worked with an advisor before? What did you not like?"
        ],
        "correct": 1,
        "explanation": "These two questions surface real goals (vs. surface answers) and money scripts (vs. behavior alone). Both produce information no standardized form will."
      },
      {
        "id": "q3",
        "prompt": "What is a 'money script'?",
        "options": [
          "A budget spreadsheet template.",
          "An unconscious belief about money formed in childhood that shapes adult financial behavior.",
          "The script a salesperson uses to close.",
          "A note on a check or wire transfer."
        ],
        "correct": 1,
        "explanation": "Money scripts (Klontz & Klontz) — money avoidance, money worship, money status, money vigilance — shape decisions more than income does. A counselor doesn't change a script in one meeting, but recognizing it shapes which recommendations will actually land."
      },
      {
        "id": "q4",
        "prompt": "After asking an open-ended question, what is the most important technique?",
        "options": [
          "Ask the next question immediately.",
          "Summarize what they said before they finish.",
          "Stay silent. Wait. Give them space to give a deeper second answer.",
          "Take notes loudly so they can see you're engaged."
        ],
        "correct": 2,
        "explanation": "Most advisors fill the silence after an open-ended question, robbing the client of space to think. Ask, then wait. The first answer is often surface; the second is often the real answer."
      },
      {
        "id": "q5",
        "prompt": "When a client can't or won't produce a routine document during intake (like a recent tax return), the most appropriate response is:",
        "options": [
          "Demand it immediately or refuse to continue.",
          "Ignore it and proceed with planning.",
          "Notice it, take it seriously — it may indicate shame, marital secrecy, or unresolved issues — and proceed gently while documenting.",
          "Drop the client; they're not serious."
        ],
        "correct": 2,
        "explanation": "Missing documents often signal something real beneath the surface — debt the client hasn't admitted to, marital secrecy, or a problem they haven't acknowledged. The advisor's job is to notice, not demand or ignore. Proceeding gently while watching for patterns is the right approach."
      },
      {
        "id": "q6",
        "prompt": "In a couples' first meeting, what is the right move when you notice one spouse subtly disagreeing with the other's answer?",
        "options": [
          "Ignore it and continue with the agenda.",
          "Press them to argue it out.",
          "Pause and ask: 'I get the sense you two might see this a little differently — am I right?' — surfacing the disagreement gently.",
          "Recommend they go to counseling."
        ],
        "correct": 2,
        "explanation": "Disagreements that get hidden in discovery become plan failures later. A gentle, named question opens the door without forcing an argument. Couples generally appreciate being seen accurately."
      },
      {
        "id": "q7",
        "prompt": "Which is NOT one of the seven topics couples commonly disagree about?",
        "options": [
          "How much risk is acceptable.",
          "When to retire.",
          "How much to give to adult children.",
          "Which mutual funds to buy."
        ],
        "correct": 3,
        "explanation": "The seven common disagreements: risk tolerance, support for adult children, retirement timing, retirement location, charity, aging parent decisions, and inheritance. Mutual fund selection is downstream — it's a product decision, not a values disagreement."
      },
      {
        "id": "q8",
        "prompt": "When a client privately tells you something they haven't shared with their spouse that would materially affect the planning (hidden debt, plans to divorce, hidden account), the right action is:",
        "options": [
          "Plan with the information, but keep the secret.",
          "Tell the spouse immediately.",
          "Gently encourage disclosure, document the conversation, decline to proceed on plans that depend on the undisclosed info, and consult firm compliance policy.",
          "Refuse to plan for the household at all."
        ],
        "correct": 2,
        "explanation": "Planning honestly while holding undisclosed material information is an ethical violation. The right path: encourage disclosure, document, refuse to build plans that depend on hidden information, and engage firm compliance. Know your firm's specific policy."
      },
      {
        "id": "q9",
        "prompt": "When should the discovery memo be written?",
        "options": [
          "Whenever there's time.",
          "Within 24 hours of the meeting, while memory is fresh.",
          "Quarterly, in batch.",
          "Only if requested by compliance."
        ],
        "correct": 1,
        "explanation": "Within 24 hours. Details fade fast. The 90-minute meeting that lives in your head Monday is half gone by Friday. The discipline of writing things up promptly is what makes discovery durable across time."
      },
      {
        "id": "q10",
        "prompt": "A good discovery memo includes:",
        "options": [
          "Only the verified quantitative numbers.",
          "Quantitative snapshot, goals, concerns, family context, money story, gaps, next steps, and YOUR impressions — including observations that flag sensitive areas.",
          "Just a list of documents received.",
          "Only what compliance requires."
        ],
        "correct": 1,
        "explanation": "Facts and impressions both. Notes like 'visibly uncomfortable discussing her mother's care' or 'emphasized risk avoidance despite an aggressive portfolio' are planning gold. Capture them while fresh."
      },
      {
        "id": "q11",
        "prompt": "A counselor's documentation should be good enough that:",
        "options": [
          "The client never has to repeat themselves.",
          "A colleague could pick up the file tomorrow and continue serving the client with minimal disruption.",
          "The compliance officer is happy.",
          "All of the above — but especially (B)."
        ],
        "correct": 3,
        "explanation": "All three are true, but the colleague-handoff test is the strongest version of the standard. If your files survive that test, they also satisfy the others — and they protect both the client and your career across vacations, departures, and reviews."
      },
      {
        "id": "q12",
        "prompt": "A client says she wants 'to know that if something happens to him, I won't have to figure out the money alone.' What does this require of the plan?",
        "options": [
          "Higher portfolio returns.",
          "Structures that make her financial life manageable on her own — simpler portfolios, named contacts, clear documentation, separate check-ins with her.",
          "More insurance on him.",
          "Estate planning documents only."
        ],
        "correct": 1,
        "explanation": "Her goal isn't returns — it's autonomy. The plan must build for her ability to manage independently if needed. This is qualitative discovery shaping concrete recommendations: simpler structures, documentation she can use, contact protocols, and meetings designed around her engagement. Missed by an advisor who only listens to the spouse who talks more."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 10;

-- ── module11_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 11 CONTENT
-- Goal-Setting & Prioritization
-- ============================================================================
update public.modules set
  title = 'Goal-Setting & Prioritization',
  competency_id = 'OJL-2',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'Turning vague aspirations into specific, time-bound, fundable goals — and helping clients choose between competing priorities when the math says they can''t have everything.',
  learning_objectives = ARRAY[
    'Translate vague client wishes into SMART planning goals.',
    'Apply a goal hierarchy that distinguishes survival, security, freedom, and legacy.',
    'Run trade-off conversations when client goals exceed available resources.',
    'Match each goal to an appropriate time horizon and funding strategy.',
    'Document goals in a way both client and colleague can reference.',
    'Update goals as life events and priorities shift over time.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "From Vague Wish to Plannable Goal",
      "summary": "What 'I want to retire someday' actually means when you turn it into something you can plan.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "Clients rarely arrive with planning-ready goals. They arrive with wishes — 'I want to retire,' 'I want to be okay,' 'I want to give my kids a head start.' Half the value of a financial planning engagement is helping the client move from the wish to a specific, time-bound, fundable goal. Without that translation, the rest of the work is just guessing." },

        { "type": "callout", "kind": "key", "title": "The SMART standard, adapted for planning", "text": "<strong>Specific</strong> (what exactly), <strong>Measurable</strong> (in dollars or some unit), <strong>Actionable</strong> (achievable through identifiable steps), <strong>Relevant</strong> (connected to the client's actual values), and <strong>Time-bound</strong> (with a target year or age). Goals that lack any of these dimensions resist planning." },

        { "type": "heading", "text": "Examples of the translation" },
        { "type": "subheading", "text": "Vague: 'I want to retire someday.'" },
        { "type": "paragraph", "text": "Plannable: 'I want to retire by age 65 (in 23 years) with $75,000/year of inflation-adjusted spending power, lasting through age 95.'" },

        { "type": "subheading", "text": "Vague: 'I want to be financially comfortable.'" },
        { "type": "paragraph", "text": "Plannable: 'I want a fully funded 6-month emergency fund within 18 months, debt-free outside of mortgage within 5 years, and on track for retirement by age 50.'" },

        { "type": "subheading", "text": "Vague: 'I want to help my kids with college.'" },
        { "type": "paragraph", "text": "Plannable: 'I want to fund 4 years of in-state public university for each of my two kids — approximately $30,000/year in today's dollars, starting in 8 years for the older and 12 for the younger.'" },

        { "type": "subheading", "text": "Vague: 'I want to leave something for my children.'" },
        { "type": "paragraph", "text": "Plannable: 'I want at least $250,000 each to go to my two children after both my spouse and I are gone, in addition to whatever we use for our own care.'" },

        { "type": "heading", "text": "Why specificity matters" },
        { "type": "paragraph", "text": "Once a goal is specific, it can be:" },
        { "type": "list", "items": [
          "<strong>Costed.</strong> You know what it requires.",
          "<strong>Tracked.</strong> You can measure progress quarter-over-quarter.",
          "<strong>Traded off.</strong> When two goals compete, you can have the conversation in numbers, not feelings.",
          "<strong>Defended.</strong> The plan you build can be evaluated against the goal years later."
        ]},

        { "type": "callout", "kind": "do", "title": "The translation technique", "text": "When a client gives you a vague wish, ask the follow-ups that turn it into a SMART goal — gently, conversationally: \"When you imagine retiring, what age comes to mind?\" \"What does that look like — what would a typical week be?\" \"What kind of lifestyle — current spending, more, less?\" \"And if it doesn't work — if you couldn't retire then, what's the latest acceptable date?\" Each question adds a dimension. By the end you have a plannable goal in the client's own words." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "The Goal Hierarchy",
      "summary": "Survival, security, freedom, legacy — and which one wins when they collide.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Not all goals are equal. A simple hierarchy helps both advisor and client decide what comes first when resources are constrained — which is most of the time." },

        { "type": "callout", "kind": "key", "title": "The four levels", "text": "<strong>(1) Survival</strong> — meet current needs, protect against catastrophe.<br/><strong>(2) Security</strong> — eliminate destructive debt, build emergency reserves, ensure income protection.<br/><strong>(3) Freedom</strong> — accumulate assets that fund the life the client wants, with optionality.<br/><strong>(4) Legacy</strong> — transfer wealth or impact beyond the client's life." },

        { "type": "heading", "text": "Survival goals" },
        { "type": "list", "items": [
          "Meet monthly basic needs (housing, food, utilities, transportation, healthcare).",
          "Maintain employer health insurance or equivalent coverage.",
          "Make minimum payments on all debts to avoid default and credit damage.",
          "Protect against catastrophic income loss with appropriate insurance (life, disability, health)."
        ]},
        { "type": "paragraph", "text": "Survival goals win every trade-off. A plan that pushes investing or aggressive debt paydown while letting health insurance lapse or skipping mortgage payments is not a plan." },

        { "type": "heading", "text": "Security goals" },
        { "type": "list", "items": [
          "Build full 3–6 month emergency fund.",
          "Eliminate high-interest debt (credit cards, payday loans, anything 7%+).",
          "Capture employer 401(k) match.",
          "Establish adequate liability and umbrella coverage.",
          "Establish minimum-viable estate documents (will, POA, healthcare directive)."
        ]},

        { "type": "heading", "text": "Freedom goals" },
        { "type": "list", "items": [
          "Fully fund retirement (within tax-advantaged accounts, then taxable).",
          "Build assets that allow career flexibility, business launch, or other major life options.",
          "Pay down moderate-interest debt (mortgage acceleration, student loans).",
          "Fund children's education or other major dependent expenses.",
          "Build cash for major life purchases (home, second home, business)."
        ]},

        { "type": "heading", "text": "Legacy goals" },
        { "type": "list", "items": [
          "Estate planning above the minimum (trusts, advanced tax strategies).",
          "Wealth transfer to heirs.",
          "Charitable giving programs.",
          "Family business succession planning."
        ]},

        { "type": "callout", "kind": "do", "title": "The diagnostic question", "text": "<em>Which level of the hierarchy is this household truly secure at?</em> Many clients arrive saying 'I want to think about legacy' while their security level is incomplete. The advisor's job is to gently re-anchor: legacy planning is wonderful AND we need to make sure the foundation is solid first. The Marcus and Tasha households of the world don't need to talk about generational wealth transfer — they need to fix the periodic-expense gap from Module 1." },

        { "type": "callout", "kind": "warn", "title": "The exception to the hierarchy", "text": "Capture of employer 401(k) match (Security level) is typically worth doing even before the emergency fund is complete, because the match is effectively a 50–100% guaranteed return that disappears if not captured each year. Most planners adjust the hierarchy slightly for this single exception." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Trade-Offs When Goals Compete",
      "summary": "What to do when the math says the client can't have everything.",
      "read_time": "8 min read",
      "blocks": [
        { "type": "paragraph", "text": "The most common moment in financial planning is the moment when the client's stated goals require more than their resources can produce. The advisor either runs an honest trade-off conversation or quietly builds an unrealistic plan that disappoints later. The first option is harder. It's also the job." },

        { "type": "heading", "text": "The trade-off conversation, structurally" },
        { "type": "numbered", "items": [
          "<strong>State the gap clearly.</strong> \"At your current savings rate, projected to retirement at 65, you'd have approximately $1.1M. Your stated need is approximately $1.8M. There's a gap of roughly $700,000 we need to close.\"",
          "<strong>Identify the levers.</strong> Save more, work longer, spend less in retirement, take more investment risk, get higher returns. Maybe inherit something. Those are the levers — there aren't others.",
          "<strong>Quantify each lever.</strong> What would it take? \"To close the gap by saving more, we'd need an additional $X per month. By delaying retirement to 67, the gap drops to $Y. By reducing retirement spending by 15%, $Z.\"",
          "<strong>Hand the choice to the client.</strong> The client decides which combination of levers fits their life. The advisor's job is to make the trade-off visible, not to choose for them.",
          "<strong>Document the decision and the alternatives considered.</strong> Years from now, both client and advisor should be able to remember why the plan looks the way it does."
        ]},

        { "type": "callout", "kind": "key", "title": "The reframe that helps", "text": "Don't ask <em>'what are you willing to give up?'</em> — it puts everything in the language of loss. Ask <em>'given these options, which version of this plan feels most like the life you want?'</em> Same trade-off, different emotional posture. The first frame produces resistance; the second produces choices." },

        { "type": "divider" },

        { "type": "heading", "text": "Trade-off scenarios" },
        { "type": "subheading", "text": "Retirement vs. kids' college" },
        { "type": "paragraph", "text": "The clearest competing-goal scenario for parents. The right answer almost always tilts toward retirement because:" },
        { "type": "list", "items": [
          "Children can borrow for college; parents cannot borrow for retirement.",
          "Time-value-of-money math heavily favors letting retirement assets compound longer.",
          "If parents under-save and can't retire, the burden may eventually fall on the children anyway."
        ]},
        { "type": "paragraph", "text": "Most planners recommend funding retirement first, then funding college from the remaining capacity. This is not what most parents want to hear, and the conversation requires care — but the math is consistent." },

        { "type": "subheading", "text": "Debt paydown vs. investing" },
        { "type": "paragraph", "text": "Generally, compare guaranteed debt rate to expected after-tax investment return:" },
        { "type": "list", "items": [
          "Debt rate above expected investment return → pay debt first (mathematical certainty).",
          "Debt rate near or below expected investment return → behavioral and tax considerations dominate. Many clients sleep better with debt paid down, even if math is slightly against it. Tax-deductibility of mortgage interest can shift the comparison.",
          "Very low-rate debt (e.g., 2.5% mortgage in 2021) — most planners recommend investing instead of accelerating paydown."
        ]},

        { "type": "subheading", "text": "Lifestyle now vs. wealth later" },
        { "type": "paragraph", "text": "The deepest values question in personal finance. The advisor's role is not to impose a value, but to make the trade-off visible:" },
        { "type": "list", "items": [
          "What does an extra $1,000/month of current lifestyle cost in eventual retirement income? (Use TVM from Module 2.)",
          "What does saving an extra $1,000/month now buy in retirement income?",
          "Neither answer is right. Clients have to choose, and they choose better when they see the math."
        ]},

        { "type": "case_study",
          "title": "The Marcus and Tasha trade-off",
          "scenario": "Marcus (42) and Tasha (41) want to: (1) save more for retirement, (2) help both their kids go to college without student debt, (3) take a major family trip every other year, and (4) eventually buy a second home in the mountains for retirement. Combined gross income $148,000. Current saving capacity after the fixes from Module 1: roughly $30,000/year.",
          "discussion": "<p>The total cost of all four goals far exceeds what $30,000/year can fund over the remaining 23 years to retirement. Trade-off conversation:</p><ul><li><strong>Retirement (must-fund):</strong> $20,000/year going into 401(k)s and Roth IRAs. Realistic projected balance at 65: roughly $1.6M.</li><li><strong>College (modify the goal):</strong> $5,000/year into 529 accounts. Won't fully fund both kids at private schools, but covers in-state public university with modest gap they could finance.</li><li><strong>Travel (annualize):</strong> $3,000/year into a sinking fund for trips every other year. They don't give it up — they fund it explicitly.</li><li><strong>Mountain home (defer or modify):</strong> Honestly tabled for the next 5 years. Revisit when retirement is more secure and college is more in view. Possibly funded by a downsize of the primary home at retirement.</li></ul><p>The plan now fits the available resources, and the client makes the choices about which goals get priority. Both Marcus and Tasha know what's funded, what's modified, and what's deferred. <strong>That's planning. The plan that quietly fails to mention the mountain home is fragile until the day they bring it up.</strong></p>"
        }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Matching Goals to Time Horizons",
      "summary": "Money for next year and money for 30 years from now do not live in the same place.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Every goal has a time horizon. The time horizon determines where the money should live — cash, bonds, stocks, real estate, illiquid alternatives — because the right investment for one horizon is the wrong investment for another." },

        { "type": "callout", "kind": "key", "title": "The horizon-allocation principle", "text": "Money needed soon must be safe and liquid. Money needed later can take risk for higher expected returns. Mismatching these is one of the most common and costly errors in personal finance." },

        { "type": "heading", "text": "Standard horizons and allocation" },
        { "type": "subheading", "text": "0–1 year — Cash" },
        { "type": "list", "items": [
          "Emergency fund.",
          "Money for known near-term expenses (taxes due, planned major purchases, tuition coming up).",
          "Vehicle: High-yield savings, money market, short Treasuries. No exposure to market volatility."
        ]},

        { "type": "subheading", "text": "1–5 years — Conservative" },
        { "type": "list", "items": [
          "Down payment on a home being purchased in a couple of years.",
          "Education funding for a child currently in late high school.",
          "Sabbatical or career-transition cash.",
          "Vehicle: Short- to intermediate-term Treasuries, CDs, conservative bond funds, modest equity exposure (15–30%) only if some flexibility on timing exists."
        ]},

        { "type": "subheading", "text": "5–15 years — Balanced" },
        { "type": "list", "items": [
          "Education funding for younger children.",
          "Major lifestyle goals (career change, business launch, second home).",
          "Mid-career retirement assets approaching withdrawal.",
          "Vehicle: Balanced portfolio (40–70% equities), typically diversified across asset classes."
        ]},

        { "type": "subheading", "text": "15+ years — Growth" },
        { "type": "list", "items": [
          "Long retirement.",
          "Young children's college (when child is under 6).",
          "Multi-generational wealth.",
          "Vehicle: Growth-oriented portfolio (70–100% equities), diversified globally. Long horizon allows volatility to wash out."
        ]},

        { "type": "callout", "kind": "warn", "title": "The classic horizon mistake", "text": "Putting house-down-payment money (3-year horizon) into the stock market because returns look attractive. If the market drops 30% in year 2, the timing of the home purchase is broken. Conversely: keeping decades' worth of retirement savings in cash because of fear, missing the growth that long horizons are <em>for</em>. Both are common; both are expensive." },

        { "type": "heading", "text": "When horizons overlap" },
        { "type": "paragraph", "text": "Retirement isn't a single moment — it's a 30-year withdrawal period. Different layers of the retirement portfolio serve different horizons within retirement itself:" },
        { "type": "list", "items": [
          "<strong>Years 1–3</strong> of retirement spending: cash and short bonds, so a market crash doesn't force sales at the bottom.",
          "<strong>Years 4–10</strong>: intermediate bonds and balanced exposure.",
          "<strong>Years 10+</strong>: growth-oriented, because the money won't be touched for a decade."
        ]},
        { "type": "paragraph", "text": "This is the foundation of the bucket strategy or sequence-of-returns management — covered more deeply in the Retirement Planning module (CORE-7). Discovery and goal-setting is where the horizons get clarified; portfolio construction is where they get implemented." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Documenting Goals and Keeping Them Alive",
      "summary": "Goals don't stay set. They evolve as life evolves.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "Goals are not set once and filed away. They change as life changes — and the advisor who treats them as a one-time exercise eventually has a plan that no longer fits the client. Living documents only stay living through ongoing care." },

        { "type": "heading", "text": "What goal documentation includes" },
        { "type": "list", "items": [
          "Goal statement in plain language, in the client's words where possible.",
          "Target dollar amount (in today's dollars and/or future dollars, with assumption documented).",
          "Target date or age.",
          "Priority level — must-fund, important, aspirational. Helps when trade-offs come up later.",
          "Funding source — which account, which monthly contribution.",
          "Status — on track, behind, ahead.",
          "Last review date."
        ]},

        { "type": "heading", "text": "Review cadence" },
        { "type": "list", "items": [
          "<strong>Annually</strong>: full review with the client. What changed? What new goals? What old goals are no longer relevant? Status of each.",
          "<strong>Quarterly</strong>: light check-in. Status updates, any urgent changes flagged.",
          "<strong>Life-event triggered</strong>: marriage, divorce, child, job change, inheritance, health diagnosis, business sale — any of these may demand an unscheduled goals refresh."
        ]},

        { "type": "callout", "kind": "do", "title": "The closing question for every review", "text": "\"Has anything changed in the last 12 months that we should think about?\" Open enough that something might surface. Direct enough that the client knows you actually want to hear it. Specific examples worth probing: jobs, dependents, health, family relationships, business situations, large purchases planned." },

        { "type": "callout", "kind": "key", "title": "Why goals are the deliverable, not the plan", "text": "Clients often think the deliverable of financial planning is the plan document — the binder, the dashboard, the projection. It isn't. The deliverable is <em>clarity about what they're building toward and confidence that the plan supports it</em>. The numbers serve the goals; the goals don't serve the numbers. Counselors who keep this orientation produce better advice and longer-lasting client relationships." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "What does it mean to translate a 'wish' into a SMART goal?",
        "options": [
          "Make it sound more professional in writing.",
          "Make it Specific, Measurable, Actionable, Relevant, and Time-bound.",
          "Use SMART software for tracking.",
          "Add a budget to it."
        ],
        "correct": 1,
        "explanation": "SMART criteria — specificity, measurability, actionability, relevance, and time-bound — convert vague wishes ('I want to retire someday') into plannable goals ('I want to retire at 65 with $75,000/year inflation-adjusted spending lasting through age 95')."
      },
      {
        "id": "q2",
        "prompt": "Which level of the goal hierarchy comes first in trade-offs?",
        "options": [
          "Legacy",
          "Freedom",
          "Security",
          "Survival"
        ],
        "correct": 3,
        "explanation": "Survival (basic needs, catastrophic protection) wins every trade-off. A plan that pushes investing while letting health insurance lapse isn't a plan."
      },
      {
        "id": "q3",
        "prompt": "What is the typical exception to the strict goal hierarchy?",
        "options": [
          "Charitable giving comes before retirement.",
          "Capturing employer 401(k) match is typically done even before the emergency fund is complete, because the match is essentially a guaranteed 50–100% return that disappears if not captured.",
          "Estate planning comes before debt paydown.",
          "Insurance comes after investing."
        ],
        "correct": 1,
        "explanation": "Employer match is the rare guaranteed return that expires annually. Most planners advise capturing the match even before fully building the emergency fund. Few other goals justify departing from the survival → security → freedom → legacy order."
      },
      {
        "id": "q4",
        "prompt": "When client goals exceed available resources, the right move is:",
        "options": [
          "Quietly build the most realistic plan you can and hope they don't notice.",
          "Refuse to plan.",
          "State the gap clearly, identify and quantify the levers (save more, work longer, spend less, take more risk), then hand the choice to the client and document the decision.",
          "Tell them their goals are unrealistic."
        ],
        "correct": 2,
        "explanation": "The trade-off conversation, run honestly, is what financial planning IS. Make the gap visible, quantify the levers, let the client choose the combination that fits their life. Document the alternatives considered."
      },
      {
        "id": "q5",
        "prompt": "When retirement funding and college funding compete for the same dollar, the typical recommendation is to prioritize retirement because:",
        "options": [
          "Retirement is more important than children.",
          "Children can borrow for college, but parents cannot borrow for retirement; under-saved parents may eventually become a burden on the children anyway.",
          "Tax laws favor it.",
          "College is not really necessary."
        ],
        "correct": 1,
        "explanation": "The math and structural logic favor retirement first. Children have access to loans; parents don't. Under-funded retirement often forces eventual reliance on adult children — the very thing parents typically want to avoid. Not what most parents want to hear, but consistent."
      },
      {
        "id": "q6",
        "prompt": "Money needed within 1 year should live in:",
        "options": [
          "A diversified stock portfolio for growth.",
          "Real estate.",
          "High-yield savings, money market, or short Treasuries — safe and liquid.",
          "Long-term bonds."
        ],
        "correct": 2,
        "explanation": "Short horizon = no exposure to market volatility. The right investment for a 30-year goal is the wrong investment for a 1-year goal. Mismatching is one of the most expensive errors in personal finance."
      },
      {
        "id": "q7",
        "prompt": "Money for a goal 15+ years away can appropriately be invested in:",
        "options": [
          "Mostly cash to avoid volatility.",
          "Mostly stocks (70–100%), diversified globally — long horizon allows volatility to wash out and growth to compound.",
          "Only certificates of deposit.",
          "Real estate only."
        ],
        "correct": 1,
        "explanation": "Long horizons are what growth investing is for. Cash for a 30-year goal nearly guarantees underperformance to inflation. Equity volatility, painful in 1-year windows, washes out across 15+ year horizons in historical data."
      },
      {
        "id": "q8",
        "prompt": "Within a retirement portfolio, why might different 'buckets' have different time horizons?",
        "options": [
          "Bucket strategies are gimmicks.",
          "Different years of retirement spending have different time horizons — the first few years are short-horizon and need safety, while later decades remain long-horizon and benefit from growth exposure.",
          "Tax law requires bucketing.",
          "It increases trading fees."
        ],
        "correct": 1,
        "explanation": "Retirement is a 30-year withdrawal period, not a single moment. Money needed in years 1–3 of retirement is short-horizon; money needed in years 15–30 is still long-horizon. Bucketing aligns each layer of the portfolio to its actual time horizon, mitigating sequence-of-returns risk."
      },
      {
        "id": "q9",
        "prompt": "How often should goals be reviewed?",
        "options": [
          "Once when the plan is built, then never.",
          "Annually with the client, with lighter quarterly check-ins and life-event-triggered updates as needed.",
          "Only when the client asks.",
          "Every five years."
        ],
        "correct": 1,
        "explanation": "Annual full reviews. Quarterly light check-ins. Plus immediate refresh on major life events (marriage, divorce, child, job change, inheritance, health, business sale). Goals are living documents."
      },
      {
        "id": "q10",
        "prompt": "What is the closing question worth asking in every review?",
        "options": [
          "Are you happy with our returns?",
          "Has anything changed in the last 12 months that we should think about?",
          "Do you want to add money?",
          "Should we increase your risk?"
        ],
        "correct": 1,
        "explanation": "Open enough to surface things you don't know. Direct enough that the client knows you actually want to hear. Captures the life events that change priorities — job, family, health, relationships, business — before they break the plan."
      },
      {
        "id": "q11",
        "prompt": "What is the deliverable of financial planning, really?",
        "options": [
          "The binder, plan document, or dashboard.",
          "Clarity about what the client is building toward and confidence that the plan supports it.",
          "The portfolio.",
          "A signed agreement."
        ],
        "correct": 1,
        "explanation": "The artifacts are not the deliverable. The deliverable is clarity and confidence. Counselors who keep this orientation produce better advice and longer client relationships. The numbers serve the goals — not the other way around."
      },
      {
        "id": "q12",
        "prompt": "A client says 'I want to think about legacy planning' but their cash flow shows a structural monthly deficit. What's the right reframe?",
        "options": [
          "Build the legacy plan; cash flow is separate.",
          "Refuse to discuss legacy until they fix the cash flow.",
          "Gently re-anchor: legacy planning is wonderful, AND we need to make sure the foundation is solid first. Address the cash flow gap as the immediate priority while keeping the legacy goal in view.",
          "Tell them they can't afford to think about legacy."
        ],
        "correct": 2,
        "explanation": "Honor the aspiration while honestly assessing where they truly are in the goal hierarchy. Most clients who want to discuss legacy planning are still working on security — they may not realize it. The gentle re-anchor preserves the relationship and refocuses on the work that has to happen first."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 11;

-- ── module12_content.sql ──

-- ============================================================================
-- GIC APPRENTICE LMS — MODULE 12 CONTENT
-- Document Collection & Analysis
-- ============================================================================
update public.modules set
  title = 'Document Collection & Analysis',
  competency_id = 'OJL-3',
  ri_hours = 0,
  ojl_hours = 16,
  short_description = 'How to gather, organize, and read the documents that tell the real story of a client''s financial life — tax returns, statements, policies, and the gaps between them.',
  learning_objectives = ARRAY[
    'Gather and organize the standard document set efficiently and securely.',
    'Read a personal tax return (Form 1040 and key schedules) and extract planning-relevant information.',
    'Analyze investment account statements for fees, allocation, and red flags.',
    'Read an insurance policy declarations page and benefit summary.',
    'Identify document gaps and what they typically signal.',
    'Store and protect client documents according to firm and regulatory standards.'
  ],
  content = $jsonb$
{
  "lessons": [
    {
      "id": "lesson-1",
      "title": "Gathering and Organizing the Document Set",
      "summary": "How to ask, how to follow up, and how to keep your sanity through the intake process.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Document collection is the connective tissue between discovery and planning. Without the documents, the advisor is working from client memory — which is unreliable, often optimistic, and full of small errors. With the documents, the advisor can see what's actually happening. Many planning surprises live in pages the client never opens." },

        { "type": "heading", "text": "The standard intake set" },
        { "type": "paragraph", "text": "Building on the categories introduced in Module 10:" },
        { "type": "list", "items": [
          "<strong>Identity and household</strong>: government ID, marriage certificate (if applicable), dependent info.",
          "<strong>Income</strong>: recent pay stubs, two years of W-2s, self-employment financials.",
          "<strong>Tax returns</strong>: two most recent years federal and state, all schedules.",
          "<strong>Bank accounts</strong>: recent statements for all checking, savings, money market.",
          "<strong>Investment accounts</strong>: recent statements for all brokerage, retirement, education, HSA.",
          "<strong>Debts</strong>: mortgage(s), auto loans, student loans, credit cards, any other.",
          "<strong>Insurance</strong>: declarations pages and policy summaries for life, disability, health, P&C, umbrella.",
          "<strong>Employer benefits</strong>: most recent benefits summary, equity comp documents (RSU vesting, options).",
          "<strong>Estate</strong>: will, trust documents, powers of attorney, advance directive, beneficiary designations.",
          "<strong>Real estate</strong>: deeds, recent property tax bills, appraisals if available.",
          "<strong>Business interests</strong>: business returns, operating agreements, partnership/shareholder agreements.",
          "<strong>Other</strong>: anything client flagged as significant — collectibles, crypto wallets, private investments."
        ]},

        { "type": "heading", "text": "How to ask without overwhelming" },
        { "type": "callout", "kind": "do", "title": "The one-page intake checklist", "text": "Reduce the request list to a single, well-organized page. Long lists trigger procrastination. Group items by location: 'Probably in your filing cabinet' / 'Probably in your online accounts' / 'Probably from your employer's HR portal'. Set a target date — typically 2–3 weeks from the first meeting. Follow up at 1, 2, and 3 weeks if items are missing." },

        { "type": "heading", "text": "Secure transmission" },
        { "type": "paragraph", "text": "Client documents contain SSNs, account numbers, addresses, dates of birth, and everything else identity thieves want. Email is not appropriate for this material." },
        { "type": "list", "items": [
          "<strong>Use the firm's secure document portal.</strong> Every modern advisory firm should have one. Train clients to use it before they need to use it.",
          "<strong>Encrypted email with strong password if portal unavailable.</strong> Send the password separately (text, voice, or different email thread).",
          "<strong>Physical drop-off and pickup</strong> remain acceptable, with appropriate chain-of-custody handling at the office.",
          "<strong>Never use unencrypted email for documents containing SSNs, account numbers, or financial details.</strong> Tell clients why."
        ]},

        { "type": "heading", "text": "Organizing what arrives" },
        { "type": "list", "items": [
          "Standard folder structure in the firm's document system — same structure for every client makes audits and handoffs cleaner.",
          "Naming convention: client_name / category / document_type_date (e.g., 'jackson_marcus / tax / 1040_2024.pdf').",
          "Date received and verified noted in client file or CRM.",
          "Acknowledge receipt to client — closes the loop and signals professionalism."
        ]},

        { "type": "callout", "kind": "warn", "title": "What missing documents commonly signal", "text": "Repeat reminders for tax returns: possibly an extension or amendment in progress, possibly an IRS issue. Avoidance of credit card statements: possibly higher debt than disclosed. Missing insurance dec pages: possibly inadequate coverage the client doesn't want to expose. None of these is necessarily nefarious — most are mundane. But notice the pattern and ask gently." }
      ]
    },

    {
      "id": "lesson-2",
      "title": "Reading a Tax Return",
      "summary": "What Form 1040 and its schedules tell you about a client — that they didn't.",
      "read_time": "9 min read",
      "blocks": [
        { "type": "paragraph", "text": "The tax return is the single most informative document in financial planning. Almost everything financially material about a client shows up somewhere in it. A counselor who can read a 1040 fluently extracts in 20 minutes what would otherwise take three meetings to uncover." },

        { "type": "heading", "text": "Form 1040 — the cover page" },
        { "type": "paragraph", "text": "The 1040 is short — typically two pages. Each line tells you something about the client." },
        { "type": "subheading", "text": "Filing status (top of return)" },
        { "type": "paragraph", "text": "Married filing jointly, married filing separately, single, head of household, qualifying widow(er). Confirms household structure. MFS is unusual and often signals a specific issue (asset protection, problematic spouse, separating couple)." },
        { "type": "subheading", "text": "Dependents listed" },
        { "type": "paragraph", "text": "Children, qualifying relatives. Cross-check against discovery — if client mentioned 3 kids but only 2 are listed, ask why." },

        { "type": "subheading", "text": "Income lines (Form 1040 lines 1–8)" },
        { "type": "list", "items": [
          "<strong>Wages (line 1)</strong> — should match the W-2s.",
          "<strong>Interest (line 2)</strong> — taxable interest from bank accounts and bonds. Also notice tax-exempt interest on 2a — often municipal bonds.",
          "<strong>Dividends (line 3)</strong> — taxable and qualified (the second is taxed at long-term cap gains rates). Significant qualified dividends suggest substantial taxable equity holdings.",
          "<strong>IRA distributions (line 4)</strong> — relevant for clients in or near retirement; taxable amount may differ from gross.",
          "<strong>Pensions and annuities (line 5)</strong> — taxable retirement income.",
          "<strong>Social Security (line 6)</strong> — taxable portion of SS benefits (up to 85% can be taxable based on income).",
          "<strong>Capital gains/losses (line 7)</strong> — from Schedule D; positive number means realized gains, negative means realized losses (capped at $3,000/year of net loss deductible against ordinary income).",
          "<strong>Other income (line 8)</strong> — from Schedule 1; gig work, unemployment, alimony received, etc."
        ]},

        { "type": "heading", "text": "Schedules that matter most" },
        { "type": "subheading", "text": "Schedule A — Itemized deductions" },
        { "type": "paragraph", "text": "If filed: state and local taxes (capped at $10,000), mortgage interest, charitable giving, medical expenses above 7.5% of AGI. Charitable giving on Schedule A is a window into values; mortgage interest tells you about the mortgage size and rate stage; SALT cap tells you the client is in a high-tax state. If not filed (took the standard deduction): client likely has fewer planning levers via itemized deductions." },

        { "type": "subheading", "text": "Schedule B — Interest and dividends" },
        { "type": "paragraph", "text": "Required when interest or dividends exceed $1,500. Lists payers — gives you the institutions holding the client's accounts. Useful for confirming you have statements from all of them." },

        { "type": "subheading", "text": "Schedule C — Self-employment" },
        { "type": "paragraph", "text": "Sole proprietor or single-member LLC business income. Reveals: gross revenue, major expense categories, net profit. Net profit drives self-employment tax and qualifies the client for solo 401(k) or SEP-IRA contributions. Sustained Schedule C losses raise IRS hobby-loss concerns and planning questions." },

        { "type": "subheading", "text": "Schedule D and Form 8949 — Capital gains and losses" },
        { "type": "paragraph", "text": "Realized investment gains and losses for the year. Short-term and long-term separated. Useful for: identifying tax-loss harvesting history, spotting concentrated positions being unwound, understanding the client's tendency to trade. Large unused capital loss carryovers (from prior years) are valuable assets — they offset future gains tax-free." },

        { "type": "subheading", "text": "Schedule E — Rental income, royalties, K-1s" },
        { "type": "paragraph", "text": "Investment property income (and expense), royalty income, and pass-through income from partnerships and S-corps (via K-1s). Reveals: rental property ownership the client may not have mentioned in passing, business ownership through entities, complexity that requires specialist coordination." },

        { "type": "subheading", "text": "Schedule 1 — Additional income and adjustments" },
        { "type": "paragraph", "text": "Includes: unemployment, gambling winnings, IRA contribution deductions, HSA contribution deductions, student loan interest, self-employed health insurance, half of SE tax. Quick way to see whether the client is using HSA or IRA deductions." },

        { "type": "callout", "kind": "key", "title": "The single most useful number on the return", "text": "<strong>Adjusted Gross Income (AGI)</strong> — line 11 on the 1040. Drives Roth contribution limits, IRA deductibility, Medicare premium tiers (IRMAA), and many credit phaseouts. Compare current AGI to prior year and to projected next year — trend often matters more than absolute level." },

        { "type": "callout", "kind": "do", "title": "The tax return read-through", "text": "First pass: scan the 1040 cover page, look at every line item with a dollar amount. Second pass: open each schedule, read the totals. Third pass: read the explanation lines and any unusual items. Allow 20–30 minutes for a complex return on first read. Make notes: what surprises you? What's missing? What planning opportunities are visible? Keep these in the client file." }
      ]
    },

    {
      "id": "lesson-3",
      "title": "Investment Statements",
      "summary": "What an account statement tells you — and what to be suspicious of.",
      "read_time": "7 min read",
      "blocks": [
        { "type": "paragraph", "text": "Investment statements share a common structure across custodians, even if the formatting differs. Knowing what to look for converts a stack of paper into a clear picture of the client's portfolio." },

        { "type": "heading", "text": "What every statement contains" },
        { "type": "list", "items": [
          "<strong>Account holder, account number, account type</strong> (taxable, IRA, Roth, 401(k), etc.). Account type drives tax treatment.",
          "<strong>Period covered</strong> — usually monthly, quarterly, or annual.",
          "<strong>Beginning and ending balance.</strong>",
          "<strong>Positions held</strong> — security name, ticker, share count, current value.",
          "<strong>Cost basis</strong> — for taxable accounts, what the position was purchased for. Critical for tax planning.",
          "<strong>Income received</strong> — dividends and interest paid into the account.",
          "<strong>Activity</strong> — purchases, sales, contributions, distributions, dividends reinvested, fees charged."
        ]},

        { "type": "heading", "text": "What to scan for" },
        { "type": "subheading", "text": "Asset allocation" },
        { "type": "paragraph", "text": "What percentage of the account is in stocks, bonds, cash, alternatives? Does it match the stated risk tolerance? A 65-year-old client who says \"I'm conservative, I can't handle losses\" but holds a 95% equity portfolio has a mismatch that will hurt them in the next downturn." },

        { "type": "subheading", "text": "Concentration risk" },
        { "type": "paragraph", "text": "Any single position over 10% of the portfolio? Common scenarios: legacy employer stock, an inherited concentrated position, a winning bet they haven't trimmed. Concentration may be appropriate in specific circumstances, but it needs to be a deliberate choice — and the client needs to know what risk they're carrying." },

        { "type": "subheading", "text": "Fees" },
        { "type": "paragraph", "text": "Expense ratios on each fund. Account-level fees (custodial, IRA maintenance, etc.). Advisor fees if applicable. The cost of holding an investment over decades compounds — a 1.5% expense ratio costs the client roughly 30% of their potential ending wealth over 30 years versus a 0.1% alternative. Read these line items." },

        { "type": "subheading", "text": "Trading activity" },
        { "type": "paragraph", "text": "How often do trades happen? Is there a pattern? Excessive trading drives tax inefficiency in taxable accounts and may signal a previous advisor who churned. Inactivity in a 25-year-old's 401(k) sitting in a money market fund (something not uncommon) signals neglect, not strategy." },

        { "type": "callout", "kind": "warn", "title": "Red flags in investment statements", "text": "Unfamiliar or illiquid private investments (especially in retirement accounts) — high risk and often high fees. Variable annuities with surrender charges still in effect. Significant cash holdings in long-term accounts that have been there for years. Holdings labeled 'proprietary' with names matching a prior advisor's firm. Highly concentrated single-stock positions without a documented reason. Excessive number of overlapping mutual funds (e.g., 8 different large-cap funds doing the same thing)." },

        { "type": "heading", "text": "Cost basis lots — why they matter" },
        { "type": "paragraph", "text": "When the client bought 1,000 shares of a stock over 10 years in 50 separate purchases, each \"lot\" has its own basis. When selling some shares, the choice of which lots to sell affects the tax outcome:" },
        { "type": "list", "items": [
          "<strong>First-in, first-out (FIFO)</strong> — sells oldest shares first. Usually the highest gain (oldest shares appreciated most).",
          "<strong>Specific identification</strong> — pick the exact lots to sell. Used for tax optimization (sell highest-basis lots to minimize realized gain, or sell loss lots for tax-loss harvesting).",
          "<strong>Average cost</strong> — only for mutual funds; uses average basis across all shares. Once chosen, generally stuck with for that fund."
        ]},
        { "type": "callout", "kind": "do", "title": "Default rule for taxable accounts", "text": "Set cost basis tracking to <strong>specific identification</strong> on all taxable accounts unless there's a reason not to. This preserves the flexibility to optimize tax outcomes at sale time. FIFO is fine for mutual funds where averaging happens anyway. Get this set early in the relationship." }
      ]
    },

    {
      "id": "lesson-4",
      "title": "Insurance Policies and Benefit Summaries",
      "summary": "Reading what's covered, what's excluded, and what the costs really are.",
      "read_time": "6 min read",
      "blocks": [
        { "type": "paragraph", "text": "Insurance documents are intimidating because they're written by lawyers, for lawyers. The advisor's job is not to read the entire 80-page policy — it's to read the parts that matter and know when to ask for help with the rest." },

        { "type": "heading", "text": "The declarations page" },
        { "type": "paragraph", "text": "Every P&C and most life and disability policies have a declarations page — usually the first one or two pages. Summarizes the contract. As covered in Module 4, this is the page to read first." },

        { "type": "subheading", "text": "Key items across all types" },
        { "type": "list", "items": [
          "Named insured(s).",
          "Coverage period (effective date, renewal date).",
          "Coverage limits (by type and total).",
          "Deductibles or elimination periods.",
          "Premium and frequency.",
          "Riders or endorsements added."
        ]},

        { "type": "heading", "text": "Type-specific items to verify" },
        { "type": "subheading", "text": "Life insurance" },
        { "type": "list", "items": [
          "Type: term, whole, universal, variable. Each has different planning implications.",
          "Death benefit amount and whether level or increasing.",
          "Term length (if term policy) and date of expiration.",
          "Cash value (if permanent) — recent statement, surrender charges still in effect, loan balances against the policy.",
          "Beneficiaries — primary and contingent."
        ]},

        { "type": "subheading", "text": "Disability insurance" },
        { "type": "list", "items": [
          "Own-occupation or any-occupation definition.",
          "Benefit amount as percentage of pre-disability income.",
          "Elimination period (90 days standard).",
          "Benefit period (to age 65, or shorter).",
          "Inflation rider, residual disability rider, future increase option."
        ]},

        { "type": "subheading", "text": "Homeowners and renters" },
        { "type": "list", "items": [
          "Dwelling coverage (Coverage A) — should approximate replacement cost, not market value.",
          "Personal property (Coverage C) — sub-limits on jewelry, art, electronics.",
          "Liability (Coverage E) — typically inadequate at $100,000–$300,000 default; should match assets.",
          "Endorsements: water backup, scheduled property, identity theft, etc."
        ]},

        { "type": "subheading", "text": "Auto" },
        { "type": "list", "items": [
          "Bodily injury liability limits.",
          "Property damage liability.",
          "UM/UIM (uninsured/underinsured motorist).",
          "Collision and comprehensive — necessary on financed/newer cars; consider dropping on older cars.",
          "Medical payments / PIP."
        ]},

        { "type": "heading", "text": "Employer benefit summaries" },
        { "type": "paragraph", "text": "An often-overlooked source of planning information. The annual benefits summary typically includes:" },
        { "type": "list", "items": [
          "Employer-provided life insurance (often 1–2× salary, sometimes more — useful but not portable).",
          "Short-term and long-term disability — what percentage of salary, taxable or not, owned by employee or employer.",
          "401(k) match formula — what's the trigger and the cap?",
          "Stock plan participation — ESPP discount, RSU vesting schedule, options.",
          "Health, vision, dental coverage details.",
          "Other perks: legal services, identity theft, commuter benefits, dependent care FSA."
        ]},

        { "type": "callout", "kind": "do", "title": "The benefits enrollment season opportunity", "text": "Fall benefits enrollment is one of the best moments to add value to a client. Most employees autofill the same elections every year without optimization. The counselor who reviews the upcoming year's elections — HSA vs. FSA, life insurance buy-up, disability buy-up, dependent care decisions — can produce hundreds to thousands of dollars of value in a 30-minute review. Schedule these conversations proactively." }
      ]
    },

    {
      "id": "lesson-5",
      "title": "Document Storage and Security",
      "summary": "Where files live, who can access them, and what to do when something goes wrong.",
      "read_time": "5 min read",
      "blocks": [
        { "type": "paragraph", "text": "Client documents are sensitive — financial details, SSNs, account numbers, family information. The firm has both regulatory and ethical obligations to protect them. The counselor is a daily participant in that protection." },

        { "type": "heading", "text": "The standard practices" },
        { "type": "list", "items": [
          "<strong>Documents stored in the firm's secure system</strong> — encrypted at rest, access-controlled, audit-logged. Not on personal devices, personal cloud storage, or unencrypted laptop drives.",
          "<strong>Access limited to staff with legitimate need</strong> to know.",
          "<strong>Retention policy followed</strong> — SEC requirements typically mandate 5-year retention for many advisory documents (longer for some); firm policy specifies how long each category of document is kept.",
          "<strong>Disposal handled securely</strong> — paper shredded, digital files deleted from active and backup systems per policy.",
          "<strong>Annual training</strong> on data security, phishing recognition, and incident response."
        ]},

        { "type": "callout", "kind": "warn", "title": "The phishing exposure", "text": "Financial advisors are targeted by phishing because the rewards are large. Common attacks: emails impersonating clients requesting wire transfers, emails impersonating the firm asking for credentials, emails impersonating custodians with urgent requests. Verbal verification on a phone number you have (not the number in the email) before any irregular financial action. Always. Even if the email looks legitimate. Especially if the email looks urgent." },

        { "type": "heading", "text": "What to do if something goes wrong" },
        { "type": "list", "items": [
          "<strong>Lost laptop or device:</strong> Report immediately to firm IT and compliance. Devices should have remote-wipe capability.",
          "<strong>Suspected phishing email opened or clicked:</strong> Report immediately to firm IT. Change passwords. Watch for further attempts.",
          "<strong>Confirmed unauthorized access:</strong> Firm has a defined incident response process. Notification of affected clients is required by state and federal law in most cases. Follow the process; don't try to handle it informally.",
          "<strong>Client reports identity theft:</strong> Help the client through the recovery process (freeze credit, file police report, FTC IdentityTheft.gov, monitor accounts). Document the support provided."
        ]},

        { "type": "callout", "kind": "key", "title": "The professional posture on security", "text": "Treat every client document, login credential, and identity element as if a data breach were costly enough to destroy the firm — because in many cases it would be. The discipline of locking down documents, verifying transactions out-of-band, and reporting anomalies fast isn't optional. It's the work." }
      ]
    }
  ],
  "quiz": {
    "passing_score": 80,
    "questions": [
      {
        "id": "q1",
        "prompt": "Why is the tax return often called the most informative document in financial planning?",
        "options": [
          "It is required by the IRS.",
          "Almost everything financially material about a client appears somewhere in it — income, deductions, investment activity, business interests, real estate, dependents — making it the highest-density source of planning information.",
          "It is the longest document a client provides.",
          "It contains the client's address."
        ],
        "correct": 1,
        "explanation": "A fluent reading of a 1040 plus schedules surfaces in 20 minutes what would take multiple discovery meetings otherwise. Income types, deductions, investment trades, rental property, business activity, retirement contributions — all in one document."
      },
      {
        "id": "q2",
        "prompt": "Which line on Form 1040 is the most useful single number for planning?",
        "options": [
          "Total wages",
          "Adjusted Gross Income (AGI)",
          "Refund amount",
          "Total tax paid"
        ],
        "correct": 1,
        "explanation": "AGI drives Roth contribution limits, IRA deductibility, Medicare premium tiers (IRMAA), credit phaseouts, and many other planning thresholds. Trend year-over-year often matters more than absolute level."
      },
      {
        "id": "q3",
        "prompt": "Why is sending client documents by unencrypted email a problem?",
        "options": [
          "It's slow.",
          "Documents contain SSNs, account numbers, and identity-theft-grade information; email is not secure transmission. Use the firm's portal or encrypted email with separately-transmitted password.",
          "It clutters the client's inbox.",
          "Email attachments are too large."
        ],
        "correct": 1,
        "explanation": "Email is not a secure channel for sensitive financial information. Use the firm's secure document portal, encrypted email with separately-shared password, or physical handoff with proper chain of custody."
      },
      {
        "id": "q4",
        "prompt": "Schedule D on a tax return shows:",
        "options": [
          "Dividends received.",
          "Realized capital gains and losses for the year.",
          "Rental income.",
          "Itemized deductions."
        ],
        "correct": 1,
        "explanation": "Schedule D (with detailed transactions on Form 8949) shows the year's realized investment gains and losses, separated into short-term and long-term. Useful for spotting tax-loss harvesting history and concentrated-position unwinds."
      },
      {
        "id": "q5",
        "prompt": "Schedule E on a tax return reveals:",
        "options": [
          "Self-employment business income.",
          "Rental property income, royalties, and pass-through income from partnerships and S-corps (via K-1s).",
          "Itemized deductions.",
          "Capital gains and losses."
        ],
        "correct": 1,
        "explanation": "Schedule E surfaces rental property ownership the client may not have mentioned, business ownership through entities, and other complexity that requires specialist coordination."
      },
      {
        "id": "q6",
        "prompt": "On a brokerage account statement, what does 'cost basis' mean?",
        "options": [
          "The current value of the position.",
          "What the position was originally purchased for, used to calculate capital gain/loss at sale for tax purposes.",
          "The advisor's fee for managing the position.",
          "The brokerage account's monthly fee."
        ],
        "correct": 1,
        "explanation": "Cost basis is the original purchase price (with adjustments for splits, dividends reinvested, return of capital, etc.). At sale, gain = sale price - cost basis. Lot-level basis tracking is critical for tax optimization."
      },
      {
        "id": "q7",
        "prompt": "What is the default cost-basis method recommendation for taxable brokerage accounts?",
        "options": [
          "First-in, first-out (FIFO).",
          "Specific identification — allows the client to choose which lots to sell at any time, preserving flexibility for tax-loss harvesting and gain optimization.",
          "Last-in, first-out (LIFO).",
          "Average cost."
        ],
        "correct": 1,
        "explanation": "Specific identification preserves the flexibility to optimize tax outcomes. FIFO is the default at most custodians and usually produces the highest gain (oldest, lowest-basis shares sell first). Set to specific identification early."
      },
      {
        "id": "q8",
        "prompt": "Which is a red flag when reviewing an investment statement?",
        "options": [
          "Holdings in low-cost index funds.",
          "Single-stock concentration above 10% with no documented strategic reason; significant cash holdings sitting for years in long-term accounts; or proprietary funds matching a prior advisor's firm.",
          "Cost basis information being tracked.",
          "Dividends being reinvested."
        ],
        "correct": 1,
        "explanation": "These are common findings in transferred accounts that signal prior advisor decisions worth revisiting. Each warrants discussion: the concentration may be intentional or inherited; the cash may be neglect; the proprietary funds were often sold for advisor compensation."
      },
      {
        "id": "q9",
        "prompt": "On an insurance declarations page, which item is most often the source of structural under-insurance?",
        "options": [
          "Coverage period.",
          "Liability limits — auto and homeowners liability often sit at policy defaults ($100K-$300K) while clients have $1M+ in assets to protect.",
          "Premium amount.",
          "Insurance company name."
        ],
        "correct": 1,
        "explanation": "Liability limits are routinely set at low defaults and never updated. A client with $1M net worth and $300K auto liability has a structural mismatch. Annual review should check this and add umbrella where appropriate (covered in Module 4)."
      },
      {
        "id": "q10",
        "prompt": "When in the year is the best time to review a client's employer benefits elections?",
        "options": [
          "January (start of new year).",
          "Fall, before open enrollment for the next plan year — when changes can be made.",
          "Tax season.",
          "Anytime."
        ],
        "correct": 1,
        "explanation": "Most employees autofill elections every fall without optimization. A 30-minute review then — covering HSA vs. FSA, life insurance buy-up, disability buy-up, dependent care — produces real value because changes can be made for the upcoming plan year."
      },
      {
        "id": "q11",
        "prompt": "An email from a client requests an urgent wire transfer of $50,000 to an unfamiliar account. The right response is:",
        "options": [
          "Send the wire immediately to be responsive.",
          "Reply to the email asking for confirmation.",
          "Call the client on a phone number you already have on file (not from the email) to verbally verify before initiating any wire — always, regardless of how legitimate the email looks.",
          "Forward the request to the trading desk."
        ],
        "correct": 2,
        "explanation": "Wire fraud via spoofed emails impersonating clients is one of the most common attacks on advisory firms. Verbal verification on a known phone number — not the number or contact info in the email — is non-negotiable before any irregular financial action. Even if the email looks legitimate. Especially if it's urgent."
      },
      {
        "id": "q12",
        "prompt": "If a counselor suspects a data security incident has occurred, the right action is:",
        "options": [
          "Try to handle it discreetly to avoid alarming anyone.",
          "Wait and see if anything further happens.",
          "Report immediately to firm IT and compliance and follow the defined incident response process — including required client notifications under state/federal law.",
          "Tell the affected client first, then the firm."
        ],
        "correct": 2,
        "explanation": "Incident response has defined steps for legal and operational reasons. Most states and federal law require specific notifications to affected clients on confirmed unauthorized access. Reporting fast is what allows the firm to contain damage and meet obligations. Don't handle informally."
      }
    ]
  }
}
$jsonb$::jsonb,
  updated_at = now()
where module_number = 12;
