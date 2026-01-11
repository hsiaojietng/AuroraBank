CREATE DATABASE aurora_bank;
USE aurora_bank;

SELECT *
FROM bank_customers;

/* Find high risk and inactive customers (>= 30 days_past_due) */
CREATE TABLE high_risk_customers AS
(SELECT *
FROM bank_customers
WHERE days_past_due >= 30);

SELECT *
FROM high_risk_customers;

/* Find the average monthly spend in SGD for high risk and inactive customers in the Personal Loan product type */
SELECT ROUND(AVG(monthly_spend_sgd), 2) AS avg_monthly_spend_sgd
FROM high_risk_customers
GROUP BY product_type;

/* Find the average utilization rate for high risk and inactive customers in the Personal Loan product type */
SELECT ROUND(AVG(utilization_rate), 2) AS avg_utilization_rate
FROM high_risk_customers
GROUP BY product_type;

/* Find customers in the Medium and Low customer segments that show the average utilization rate and average monthly spend signals
of a high-risk customer */
SELECT *
FROM bank_customers
WHERE utilization_rate <= 0.86
AND monthly_spend_sgd <= 499.29
AND risk_segment IN ("Med", "Low");

/* Find out the number of customers that has those early signs of a high risk customer in the Personal Loan Customer */
CREATE TABLE high_risk_persloan_customer 
(SELECT *
FROM bank_customers
WHERE risk_segment = "High"
AND product_type = "PersLoan");

SELECT COUNT(customer_id) AS high_risk_personal_loan_customer_count
FROM high_risk_persloan_customer
WHERE utilization_rate <= 0.86
AND monthly_spend_sgd <= 499.29;

SELECT *
FROM high_risk_persloan_customer
WHERE utilization_rate <= 0.86
AND monthly_spend_sgd <= 499.29;

/* Find out the number of customers that has those early signs of a high risk customer in the Online Acquired Medium Risk Customer Segment */
CREATE TABLE med_risk_online_credit_customer
(SELECT *
FROM bank_customers
WHERE risk_segment = "Med"
AND product_type = "CreditCard"
AND acquisition_channel = "Online");

SELECT *
FROM med_risk_online_credit_customer
WHERE utilization_rate <= 0.86
AND monthly_spend_sgd <= 499.29;

/* Find those customers where their first_txn_date is more than 60 days after they join as a bank customer */
SELECT customer_id,
	join_date,
    first_txn_date,
    (first_txn_date - join_date) AS txn_days_after_join
FROM bank_customers
WHERE first_txn_date <> "NA"
AND (first_txn_date - join_date) > 2;

