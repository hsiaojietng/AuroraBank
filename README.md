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

Based on deeper research with the respective stakeholders, I found out:
Engaged customer (Card) - 
- Has at least 1–2 transactions in the last month (monthly_txn_cnt > 0, ideally > 5).
- Shows meaningful monthly_spend_sgd relative to their credit_limit_sgd (e.g., utilization_rate between ~20–60%, not zero and not constantly maxed out).
- Uses the card regularly over several months (not just a one-time welcome offer).
- Has delinquency bucket in Current or 1-29

Engaged customer (Personal Loan) - 
- Pays installments on time (days_past_due = 0, delinquency_bucket = Current).

Profitable customer - 
- Credit, Low/Med risk segment
- utilization_rate between ~20–60%
- fraud_flag = 0 and no persistent days_past_due
- Monthly spend in SGD >= 500

Early risk signals (Card) -
- Utilization spike metric: High utilization rate > 80 - 90%
- Minimum monthly spend in SGD: < 500

After breaking down the problem, I then focus on obtaining the dataset.

## Phase 2: Data Collection
This is the phase where I will reach out to the relevant stakeholders from the different teams (risk, marketing, operations) to collect relevant data for me to analyze. 
Since this is just a role-play scenario, let's assume that is done and we now have a combined required data within the excel Dataset.

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

## Phase 3: Data Cleaning
Now the raw data collected needs to be cleaned to be accurately analyzed. This is where I handle the missing data, removing duplicates, standardizing formats and setting the correct data types, enhancing data accuracy and reliability.

While looking through the data, I realized there are 
1) Missing data:
![NA for column "first_txn_date"](/Screenshots/NA.png)
2) Inconsistent standard:
![Inconsistent country standard for column region](/Screenshots/InconsistentStandard.png)
3) Inconsistent/Invalid data type:
![Inconsistent datatype for column delinquency_bucket](/Screenshots/InconsistentDatatype.png)

So I perform some research and reach out to the relevant stakeholders for some clarifications.
Turns out the missing data is because the customer has not made any transactions yet.
Based on the team, I also found out that the region should be in shorthand. Therefore, I made some bulk changes to the data under that column.
Additionally, the inconsistent data type is because of the column data type recognizing the data as a date (29-Jan) from the bucket "1-29". Hence I made changes to the data type of that column.

## Phase 4: Data Analysis
With the data on hand, I want to find patterns and trends in the data to get answers for this statement: Identify the card and personal loan customer segments that are driving delinquencies and fraud.

I found that for most personal loan customers that are grouped in the serious delinquency band (90+) are mostly from Manila. With most customers acquired in a branch.
![Delinquency Customer Segment](/Screenshots/DelinquencyCustomerSegment.png)

Within the card customer segments, there is lower delinquency rate as the highest delinquency band is 1-29 (early stage arrears), with the customers from multiple regions and multiple acquisition channels.

Analyzing the data on fraud, you can see that product type credit card is frequent in the region of BKK (Bangkok) and they are all acquired "Online".
![Fraud Card Product Type](/Screenshots/FraudCardProductType.png)

Lastly, there is no customer that has a fraud flag for the product type personal loan.
![Fraud Loan Product Type](/Screenshots/FraudLoanProductType.png)

The next point I want to find out is: Identify the card and personal loan customer segments that are profitable and engaged.

As per the definition of engaged, these are the customers that fall in that category for the product type, Credit:
![Engaged Credit Customers](/Screenshots/EngagedCreditCustomers.png)

And these are the customers for the product type, Personal Loan:
![Engaged Personal Loan Customers](/Screenshots/EngagedPersonalLoanCustomers.png)
So there's actually no customers in this dataset that falls in this category as all of them have a number of days past due.

As per the definition of profitable, these are the customers that fall in that category for the product type, Credit:
![Profitable Credit Customers](/Screenshots/ProfitableCreditCustomers.png)

For analyzing the 3rd point, I want to find this information out using SQL. Therefore I imported the CSV data into MySQL Workbench to perform queries to obtain some information regarding this point: Identify early behavioral signals predicting future risk/inactivity for card and personal loan customer segments.

Based on this project, assuming the 30 days_past_due would mean future risk and inactivity for card and personal loan, I first filtered these customers out.
![More Than 30 Days Past Due Customers](/Screenshots/MoreThan30DaysPastDueCustomers.png)

From this dataset that contains the high-risk customers, I found out their average monthly spend in SGD, which is $499.29.
![Average Monthly Spend for More Than 30 Days Past Due Customers](/Screenshots/AverageMonthlySpendforMoreThan30DaysPastDueCustomers.png)

I also found out that the average utilization rate of this customer segment is 0.86.
![Average Utilization rate for More Than 30 Days Past Due Customers](/Screenshots/AverageUtilizationrateforMoreThan30DaysPastDueCustomers.png)

From this metric, I can use it to find out which customers present these early signs within certain customer segments, for example, high-risk personal loan customers:
![Potential High Risk Personal Loan Customers](/Screenshots/PotentialHighRiskPersonalLoanCustomers.png)

Additionally, I'm able to find out more about their profile by looking at the data on these customers:
![Potential High Risk Personal Loan Customers Data](/Screenshots/PotentialHighRiskPersonalLoanCustomersData.png)

I also found out which customers present these early signs within the med-risk online acquired credit card customers:
![Potential High Risk Credit Card Customers Data](/Screenshots/PotentialHighRiskCreditCardCustomersData.png)

## Phase 5: Data Visualization
- Tree Map: Visualizes the total number of days_past_due in total categorized by regions, allowing a quick comparison of the regions which has customers with high number of days_past_due.
- Line and stacked column chart: Displays the relationship between customers' monthly expenditure and utilization rate categorized by region and different acquisition channels
- Clustered column chart: Depicts the relationship between average monthly transactions of customers over delinquency buckets. 

## Phase 6: Data-Driven Action (Insights and Analysis)
### Key Findings:
- The most profitable customer segments are different within each region and the type of acquisition channels. Taking a look at Singapore's data, most customers acquired through a branch spends the most in a month.
- The regions ranked with the most days_past_due are as such: Manila, Jakarta, Bangkok, Singapore and Kuala Lumpur. Since having higher days_past_due is correlated to delinquency rate, it shows that Manila has the highest delinquency rate.
- There is a clear pattern that shows customers in the lower bracket of the delinquency buckets (Current and 1-29) making 8-9 transactions a month and those in the higher bracket of the delinquency buckets (30-59, 60-89, 90+) making 1-3 transactions a month.

### Recommedations:
- Focus marketing efforts: AuroraBank can focus marketing efforts Singapore Credit Card customers acquired from branches as they are the ones that will spend more, bringing in more profit for the bank.
- Early Intervention Strategies: AuroraBank can implement strategies to identify customers that make 1-3 transactions month on month and put up measures to prevent them from being delinquent. Additionally, they can focus this efforts on the region with the most delinquents, Manila.

## Conclusion
This project demonstrated how data visualization can make complex financial data accessible to decision-makers and drive actionable insights. 

From the findings, AuroraBank can enhance their strategies moving forward by:
- Focusing on marketing efforts: Focus marketing efforts for Credit Card more on Singapore customers acquired from branches to bring in more profit.
- Early Intervention Strategies: Implement strategies to mitigate potential delinquents.

## Future enhancements
- Predictive Analysis: AuroraBank can use historical and real time data, fed into Machine Learning models to learn to identify customers/accounts that are delinquents early and trigger actions/measures to prevent or limit that risk. This is can help to reduce delinquency, directly protecting the profit, capital and ability to grow its lending business.

## Resources
- ![Customer Profile Analysis Report](/Resources/CustomerProfileAnalysisReport.pdf)
- ![Aurora Bank Presentation](/Resources/AuroraBankPresentation.pptx)