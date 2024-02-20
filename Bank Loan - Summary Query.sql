/*

Bank Loan Report in SQL Queries
for Summary Dashboard

*/

SELECT *
FROM bank_loan


--------------------------------------------------------------------------------------------------------------------------

--Key Performance Indicators (KPIs) Requirements:

-------------------------------------------------

--1. Total Loan Applications
-- overall:
SELECT COUNT(*) AS Total_Loan_Applications
FROM bank_loan;

-- MTD (Month to Date):
SELECT COUNT(*) AS MTD_Total_Loan_Applications
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
);

-- PMTD (Previous Month to Date):
SELECT COUNT(*) AS PMTD_Total_Loan_Applications
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
)-1;

-------------------------------------------------

--2. Total Funded Amount
-- Overall:
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan;


-- MTD (Month to Date):
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
);

-- PMTD (Previous Month to Date):
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
)-1;

-------------------------------------------------

--3. Total Amount Received
--overall:
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan


-- MTD (Month to Date):
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
);


-- PMTD (Previous Month to Date):
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
)-1;


-------------------------------------------------

--4. Average Interest Rate
SELECT ROUND(AVG(int_rate)*100, 2) AS Average_Interest_Rate
FROM bank_loan



--MTD (Month to Date):
SELECT ROUND(AVG(int_rate)*100, 2) AS MTD_Average_Interest_Rate
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
);

--PMTD (Previous Month to Date):
SELECT ROUND(AVG(int_rate)*100, 2) AS PMTD_Average_Interest_Rate
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
)-1;

-------------------------------------------------

--5. AVG DTI
--Overall:
SELECT ROUND(AVG(dti)*100,2) AS avg_dti
FROM bank_loan

--MTD (Month to Date):
SELECT ROUND(AVG(dti)*100,2) AS MTD_Avg_dti
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
);


--PMTD (Previous Month to Date):
SELECT ROUND(AVG(dti)*100,2) AS PMTD_Avg_dti
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
)-1;
--------------------------------------------------------------------------------------------------------------------------

--Good Loan v Bad Loan KPI’s:

-------------------------------------------------

--1. Good Loan KPIs:

--Good Loan Percentage:
SELECT ROUND(
	   SUM(IIF(loan_status IN ('Fully Paid', 'Current'), 1, 0))
	   /
	   CONVERT(float, COUNT(*)) * 100
	   ,2) 
	   AS Good_loan_percentage
FROM bank_loan

--Good Loan Applications:
SELECT COUNT(*) AS Good_loan_applications
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current')

--Good Loan Funded Amount:
SELECT SUM(loan_amount) AS Good_loan_funded_amount
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current')


--Good Loan Amount Received:
SELECT SUM(total_payment) AS Good_loan_amount_received
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current')

-------------------------------------------------

--2. Bad Loan KPIs:

--Bad Loan Percentage:
SELECT ROUND(
	   SUM(IIF(loan_status IN ('Charged Off'), 1, 0))
	   /
	   CONVERT(float, COUNT(*)) * 100
	   ,2) 
	   AS Bad_loan_percentage
FROM bank_loan;

--Bad Loan Applications:
SELECT COUNT(*) AS Bad_loan_applications
FROM bank_loan
WHERE loan_status IN ('Charged Off');

--Bad Loan Funded Amount:
SELECT SUM(loan_amount) AS Bad_loan_funded_amount
FROM bank_loan
WHERE loan_status IN ('Charged Off');


--Bad Loan Amount Received:
SELECT SUM(total_payment) AS Bad_loan_amount_received
FROM bank_loan
WHERE loan_status IN ('Charged Off');


--------------------------------------------------------------------------------------------------------------------------

--Loan Status:
SELECT
	loan_status
	, COUNT(*) AS LoanCount
	, SUM(total_payment) AS Total_amount_received
	, SUM(loan_amount) AS Total_funded_amount
	, AVG(int_rate) AS Interest_rate
	, AVG(dti) AS DTI
FROM bank_loan
GROUP BY loan_status;


SELECT 
	loan_status
	, SUM(total_payment) AS MTD_Total_amount_received
	, SUM(loan_amount) AS MTD_Total_funded_amount
FROM bank_loan
WHERE YEAR(issue_date) = (
    SELECT MAX(YEAR(issue_date)) 
    FROM bank_loan
)
AND MONTH(issue_date) = (
	SELECT MONTH(MAX(issue_date)) FROM bank_loan
)
GROUP BY loan_status
ORDER BY --Just for visual
	CASE
		WHEN loan_status = 'Fully Paid' THEN 1
		WHEN loan_status = 'Current' THEN 2
		ELSE 3
	END;

--------------------------------------------------------------------------------------------------------------------------
