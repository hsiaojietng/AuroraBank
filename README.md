# AuroraBank
This is a fictional bank where I am a Data Analyst tasked to solve a problem the management is facing. 

## I. Business Context

AuroraBank is a mid-sized retail and digital bank headquartered in Singapore, serving mass retail and affluent customers across Southeast Asia through branches, mobile banking, and card/loan products. Over the last 18 months, AuroraBank has seen slowing growth in card and personal loan portfolios despite rising customer acquisition costs and increased digital engagement marketing.

The bank’s leadership suspects that while acquisition is strong, portfolio quality and customer profitability are deteriorating due to higher credit risk, suboptimal cross-sell, and missed early-warning signals in transaction behavior. To remain competitive and meet tightening regulatory expectations around credit risk and conduct, they want a more data-driven view of customer behavior across products and channels.

## II. Problem Background

Recent internal reports show:

- Rising 90+ days delinquency in credit cards and personal loans, especially in younger and recently onboarded segments.
- Higher fraud write-offs and chargebacks on e-commerce transactions, suggesting gaps in transaction monitoring and rules.

At the same time, marketing campaigns drive many first-time card sign-ups that transact heavily in the first three months and then become inactive, lowering overall portfolio profitability. Business heads receive fragmented reports from different teams (risk, marketing, operations) and lack a unified, customer-level view that connects acquisition channel, transaction patterns, risk outcomes, and profitability.

## III. Stakeholder Request (Problem Statement)

The Head of Retail Banking and Cards sends the following request to the Data Analytics team:

> “We are acquiring customers, but portfolio risk and profitability trends are worrying. Can you build a unified view of our card and personal loan customers to identify:which segments are driving delinquencies and fraud,which segments are profitable and engaged,and what early behavioral signals predict future risk or inactivity,so we can adjust our underwriting, credit limits, and marketing strategies?”
> 

This request reflects a need for descriptive, diagnostic, and early predictive analytics across customer, risk, and transaction data, typical for banking data analyst roles.

## IV. Synthetic Dataset Sample

Synthetic sample dataset (80 rows) representing a 12‑month snapshot of credit card and personal loan customers at AuroraBank is provided as an Excel file. It mimics typical banking data with deliberate noise: missing values, inconsistent date formats, typos, and mixed categorical labels.

## V. Output
The analyst is expected to produce:

- A cleaned, documented dataset
- A set of dashboards or slide-based visuals
- A concise insight report highlighting 3–5 key patterns
- Suggested next steps

## Phase 1: Define
My first thought process is to ensure I understand the problem faced. I will break down the problem into smaller chunks for me to use data to identify the reasons for those problems and ultimately suggest recommendations for them.
These are the smaller points that the Head of Retail Banking and Cards is concerned about:
- Identify the card and personal loan customer segments that are driving delinquencies and fraud
- Identify the card and personal loan customer segments that are profitable and engaged
- Identify early behavioral signals predicting future risk/inactivity for card and personal loan customer segments

After breaking down the problem, I then focus on understanding the dataset.

### Definitions of data:
customer_id: Unique identifier for each customer record in the portfolio.
join_date: Date the customer first joined AuroraBank or was first booked for this product (card or loan).
first_txn_date: Date of the customer’s first financial transaction on this product (first card spend or first loan repayment).
region: Customer or account region, here represented by city or shorthand (e.g., “Singapore”, “SG”, “Jakarta”, “JKT”).
product_type: Type of product the customer holds - CreditCard – revolving credit line with card transactions, PersLoan – fixed-term personal loan.
risk_segment: Bank-assigned risk band at onboarding (e.g., Low, Med, High), usually based on scorecards, income, bureau data, and internal rules.
monthly_txn_cnt: Number of transactions in a typical month for this product (e.g., card purchases or loan payments).
monthly_spend_sgd: Approximate total transaction value per month, in Singapore dollars, for this product.
days_past_due: Number of days a customer is late on required payments (e.g., missed card minimum payment or loan installment).
delinquency_bucket: Categorical version of days_past_due, grouped into standard banking bands: Current – 0 days past due. 1-29 – early-stage arrears. 30-59 – mid-stage delinquency. 60-89 – late-stage delinquency. 90+ – serious delinquency, often considered “non-performing”.
credit_limit_sgd: Approved credit limit (for cards) or notional exposure cap (for loans) in Singapore dollars.
utilization_rate: Ratio of current outstanding balance to credit_limit_sgd, often averaged over a period (e.g., month).
fraud_flag: 1 = customer has at least one confirmed fraud case. 0 = no confirmed fraud.
acquisition_channel: How the customer was acquired for this product, e.g.: Branch – in-person onboarding. Online – digital acquisition through website/app. Partner – via partnerships such as merchants, fintechs, or campaigns.


