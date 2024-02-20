/*

Bank Loan Report in SQL Queries
for Overview Dashboard

Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'

*/

SELECT *
FROM bank_loan


--------------------------------------------------------------------------------------------------------------------------

--Monthly Trends by Issue Date:

SELECT
	MONTH(issue_date) AS NumMonth
	, DATENAME(MONTH, issue_date) AS Month_Name
	, COUNT(*) AS Total_Loan_Applications
	, SUM(loan_amount) AS Total_Funded_Amount
	, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY 1;

--------------------------------------------------------------------------------------------------------------------------

--Regional Analysis by State:

SELECT
	address_state
	, COUNT(*) AS Total_Loan_Applications
	, SUM(loan_amount) AS Total_Funded_Amount
	, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY address_state
ORDER BY 3 DESC;

--------------------------------------------------------------------------------------------------------------------------

--Loan Term Analysis:

SELECT
	term Term
	, COUNT(*) AS Total_Loan_Applications
	, SUM(loan_amount) AS Total_Funded_Amount
	, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY term
ORDER BY 3 DESC;

--------------------------------------------------------------------------------------------------------------------------

--Employee Length Analysis:

SELECT
	emp_length
	, COUNT(*) AS Total_Loan_Applications
	, SUM(loan_amount) AS Total_Funded_Amount
	, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY emp_length
ORDER BY 3 DESC;

--------------------------------------------------------------------------------------------------------------------------

--Loan Purpose Breakdown:
SELECT
	purpose
	, COUNT(*) AS Total_Loan_Applications
	, SUM(loan_amount) AS Total_Funded_Amount
	, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY purpose
ORDER BY 3 DESC;

--------------------------------------------------------------------------------------------------------------------------

--Home Ownership Analysis:

SELECT
	home_ownership
	, COUNT(*) AS Total_Loan_Applications
	, SUM(loan_amount) AS Total_Funded_Amount
	, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY home_ownership
ORDER BY 3 DESC;

--------------------------------------------------------------------------------------------------------------------------