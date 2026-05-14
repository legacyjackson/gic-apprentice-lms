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
