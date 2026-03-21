<!-- ultimo aggiornamento: 2026-03-21 -->

# Google Ads

## Overview

The core principle of Google Ads is to capitalize on **search intent** — showing your ad to potential customers at the exact moment they are actively searching for the products or services you offer. Unlike other forms of advertising that target broad audiences based on demographics or past behavior, this direct targeting of immediate need is what makes Google Ads uniquely powerful and effective.

## Setup

### Key Metrics

**Three Fundamental Metrics:**

1. **Cost Per Click (CPC)**
   - The actual amount you pay Google for a single click on your ad.
   - Important Distinction: Different from your "max bid." Your actual CPC is often lower.
   - In Reports: You will typically see "Average CPC."

2. **Conversion Rate**
   - A conversion is any meaningful action a user takes on your website that you deem valuable (sale, form submission, phone call, adding to cart, etc.).
   - Formula: (Number of Conversions / Number of Visitors) × 100
   - Each type of conversion action will have its own distinct conversion rate.

3. **Average Order Value (AOV)**
   - The average amount of revenue from a single successful conversion.
   - For E-commerce: average cart value at checkout.
   - For Service/Lead-Gen: value of initial service, or Customer Lifetime Value (LTV).

### Understanding the Google Ads Auction

Google Ads operates on a real-time auction system with a **Cost-Per-Click (CPC)** model — advertisers only pay when a user clicks their ad.

**What determines your actual CPC:**

1. **Ad Rank** = Max Bid × Quality Score. Highest Ad Rank wins the top position.
2. **Bidding Strategy:**
   - **Manual Bidding:** Set maximum CPC for each keyword manually
   - **Smart Bidding:** Google's automated system. Common goals:
     - Target CPA (Cost Per Acquisition)
     - Target ROAS (Return On Ad Spend)
     - Maximize Conversions
     - Maximize Conversion Value
3. **Quality Score** (1-10 rating):
   - Ad Relevance
   - Landing Page Experience
   - Expected Click-Through Rate (CTR) — **most important component**

**Actual CPC formula (second-price auction):**
$$\text{Actual CPC}= \frac{\text{Ad Rank of advertiser below you}}{\text{Your Quality Score}}+\$0.01$$

### Account Structure

Account → Campaign → Ad Group → Keywords & Ads

- **Account Level:** billing, currency, time zone
- **Campaign Level:** budget, networks, targeting, bid strategy, ad extensions
- **Ad Group Level:** tightly-themed clusters of keywords + ads
- **Keywords & Ads Level:** keywords you bid on, ad creative, landing pages

## Configurazioni standard

### Terminology

- **ROAS:** Total Revenue / Total Ad Spend
- **POAS:** Total Profit / Total Ad Spend
- **CPA:** Total Cost / Total Conversions
- **Conversion Rate:** (Total Conversions / Total Clicks) × 100
- **AOV:** Total Revenue / Total Conversions

### The Principle of Liquidity

Give Google's ML algorithms maximum freedom with as few restrictions as possible:
1. **Placement Liquidity:** Allow ads across various placements
2. **Audience Liquidity:** Don't impose demographic restrictions without data
3. **Budget Liquidity:** Define performance goals, let budget be flexible
4. **Creative Liquidity:** Trust data and A/B testing over subjective preferences

### Three Key Pillars

1. **Understanding the User:** keywords, audience targeting, buyer's funnel messaging
2. **Managing Costs:** bid amounts, bidding strategies, competitor analysis, conversion rate optimization
3. **Leveraging Machine Learning:** conversion tracking, budget/timing optimization, conversion quality

## Workflow

### Keywords and Search Terms

#### Search Query vs Keyword
- **Search Query:** exact word/phrase user types into Google
- **Keyword:** word/phrase advertiser provides to Google as a guideline

#### Negative Keywords
Used to exclude ads from showing on specific irrelevant searches. If a user's search query includes a negative keyword, Google blocks the ad from entering the auction.

#### Keyword Match Types

1. **Broad Match** `women's hats` — most flexible, includes synonyms and related queries
2. **Phrase Match** `"women's hats"` — must include meaning in correct order
3. **Exact Match** `[women's hats]` — exact term or very close variants only
4. **Negative Match** `-kids` — prevents showing if query contains the term

**Best Practices:**
- Start with Broad Match + Smart Bidding
- Constantly update negative keywords via Search Terms Report
- 10-20 highly related keywords per ad group
- Match ad copy to keyword intent

### Search Terms Report

Located under "Insights and Reports." Key actions:
1. **Market Research:** learn which search terms are popular
2. **Discover New Keywords:** add high-performing terms directly to ad groups
3. **Find Negative Keywords:** review at least once a week

**Advanced Tips:**
- Use Filters for large campaigns
- Analyze High-CPC terms for profitability
- Don't negate too quickly — wait for significant data
- Run N-gram Analysis for deeper insights

### Brand Inclusions and Exclusions

Manage brand lists at: `Tools > Brand Lists`

**Negative Keywords strategies:**
1. **Account-Level Negatives:** block universally irrelevant terms across all campaigns
2. **Ad Group-Level "Sculpting":** direct traffic to the most relevant ad group

### Audience Targeting

**Core Audiences:**
1. **Affinity Audiences** — long-term interests (top-of-funnel awareness)
2. **Custom Affinity Audiences** — custom-built based on interests, keywords, URLs
3. **In-Market Audiences** — actively researching to purchase (high intent)
4. **Custom Intent Audiences** — recently searched for specific high-intent keywords
5. **Life Events** — major milestones (marriage, moving, graduating)

**Other Targeting:**
6. **Detailed Demographics** — parental status, marital status, education, homeownership
7. **Customer Match** — upload existing customer data
8. **Similar Audiences** — users sharing characteristics with existing customers
9. **Remarketing** — previous website/app visitors
10. **Lookalike Audiences** — statistically similar to best customers

**Three Audience Settings:**
1. **Targeting** (restrictive) — ads only shown to selected audience
2. **Observation** (reporting) — monitor performance without restricting reach
3. **Exclusion** (blocking) — prevent specific audience from seeing ads

**Key Strategy:** Layer broad keywords with high-quality audiences (Customer Match, Lookalike, In-Market).

### Audience Performance Analysis

Review in the **"Audiences" tab**. Compare observed audiences against "Total: Other" for conversion rate, CTR, and other metrics.

**Testing Ideas:**
1. Test RLSA with Broad Keywords or DSA
2. Test Custom Audiences based on query phrasing (upper vs lower funnel)
3. Test Short-Tail vs Long-Tail keywords with audience layers
4. Test different landing page types (product vs informational)

### Ad Copywriting

**Funnel-Based Messaging:**
- **TOFU (Awareness):** emotional/lifestyle benefits, problem awareness
- **MOFU (Consideration):** features and differentiators
- **BOFU (Conversion):** promotions, competitive advantages, trust signals

**BJ Fogg Behavioral Model: B = MAT**
Behavior = Motivation × Ability × Trigger
- High Motivation, Low Ability → focus on making it easy ("Free case review", "60 seconds")
- Low Motivation, High Ability → focus on increasing desire (visuals, features, lifestyle)

**Five Tips for Ad Copy:**
1. Let research inform your writing — use specific facts and numbers
2. Write copy that can't be stolen — unique, factual claims
3. Avoid unsubstantiated superlatives — replace "best" with concrete evidence
4. Favor objective statements over subjective ones
5. Address specific pain points and needs

**Five Tips for Ad Creative:**
1. Hook them fast
2. Use audience-centric creativity
3. Prioritize clarity in design
4. Let data drive creative decisions
5. Develop a consistent visual identity (but don't over-invest)

### Bidding Strategy

**Managing Costs — three primary factors:**
1. **Bid Amount & Strategy:** must align with campaign goals
2. **Competition & Inventory:** market dictates cost of clicks (ROAS Trap)
3. Performance goals cannot be set in isolation from competitive landscape

## Note e benchmark

**Recommended Reading:**
- _Ogilvy on Advertising_ by David Ogilvy
- _The Persuasion Code_ by Christophe Morin and Patrick Renvoise
- _Tested Advertising Methods_ by John Caples
- _Don't Make Me Think_ by Steve Krug
