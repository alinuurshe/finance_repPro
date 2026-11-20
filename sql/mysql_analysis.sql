-- MySQL 8 learning companion for the Power BI finance dashboard.
-- Adapt names and types after checking the fields in the PBIX model.

CREATE DATABASE IF NOT EXISTS finance_analytics;
USE finance_analytics;

CREATE TABLE IF NOT EXISTS finance_transactions (
    transaction_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    amount DECIMAL(14, 2) NOT NULL,
    department VARCHAR(100) NOT NULL,
    expense_type VARCHAR(100) NOT NULL,
    project VARCHAR(150) NOT NULL,
    approved_by VARCHAR(100) NULL,
    PRIMARY KEY (transaction_id),
    INDEX idx_finance_date (transaction_date),
    INDEX idx_finance_project_date (project, transaction_date)
);

-- Monthly spend, with calendar year and month number for correct sorting.
SELECT
    YEAR(transaction_date) AS report_year,
    MONTH(transaction_date) AS month_number,
    DATE_FORMAT(transaction_date, '%M') AS month_name,
    SUM(amount) AS total_spend,
    COUNT(*) AS transaction_count
FROM finance_transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date), DATE_FORMAT(transaction_date, '%M')
ORDER BY report_year, month_number;

-- Spend by department and expense type.
SELECT
    department,
    expense_type,
    SUM(amount) AS total_spend,
    COUNT(*) AS transaction_count
FROM finance_transactions
GROUP BY department, expense_type
ORDER BY total_spend DESC;

-- Project spend and share of all spend (window functions require MySQL 8+).
WITH project_totals AS (
    SELECT project, SUM(amount) AS total_spend
    FROM finance_transactions
    GROUP BY project
)
SELECT
    project,
    total_spend,
    ROUND(100 * total_spend / NULLIF(SUM(total_spend) OVER (), 0), 2) AS spend_share_pct
FROM project_totals
ORDER BY total_spend DESC;

-- Basic data quality review.
SELECT
    SUM(transaction_date IS NULL) AS missing_dates,
    SUM(amount IS NULL) AS missing_amounts,
    SUM(amount < 0) AS negative_amounts,
    COUNT(*) AS row_count
FROM finance_transactions;
