-- ==========================================================
-- COFFEE SHOP SALES ANALYSIS - 2025
-- Author: Daniel Gonzalez Rodriguez
-- Description: Database creation and data transformation
-- ==========================================================

-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS coffee_shop_db;
USE coffee_shop_db;

-- 2. Create the main table for annual sales
-- We use DOUBLE for precision in currency values
CREATE TABLE IF NOT EXISTS coffee_sales_2025 (
    May DOUBLE,
    June DOUBLE,
    July DOUBLE,
    August DOUBLE,
    September DOUBLE,
    October DOUBLE,
    November DOUBLE,
    December DOUBLE
);

-- Note: After creating the table, use the 'Table Data Import Wizard' 
-- to upload your 'Sales_annual.csv' file into this table.

-- 3. Data Transformation (Unpivoting)
-- This query converts horizontal columns into a vertical list 
-- to make it compatible with Tableau and trend analysis.
CREATE OR REPLACE VIEW v_monthly_revenue AS
SELECT 'May' AS Month, May AS Revenue FROM coffee_sales_2025
UNION ALL SELECT 'June', June FROM coffee_sales_2025
UNION ALL SELECT 'July', July FROM coffee_sales_2025
UNION ALL SELECT 'August', August FROM coffee_sales_2025
UNION ALL SELECT 'September', September FROM coffee_sales_2025
UNION ALL SELECT 'October', October FROM coffee_sales_2025
UNION ALL SELECT 'November', November FROM coffee_sales_2025
UNION ALL SELECT 'December', December FROM coffee_sales_2025;

-- 4. Strategic Analysis Queries
-- Query to find the month with the highest and lowest revenue
SELECT 
    Month, 
    Revenue 
FROM v_monthly_revenue
WHERE Revenue = (SELECT MAX(Revenue) FROM v_monthly_revenue)
   OR Revenue = (SELECT MIN(Revenue) FROM v_monthly_revenue);

-- Query to calculate the Total Revenue and Average per month
SELECT 
    SUM(Revenue) AS Total_Period_Revenue,
    AVG(Revenue) AS Average_Monthly_Revenue
FROM v_monthly_revenue;
