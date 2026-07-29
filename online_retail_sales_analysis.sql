-- ==========================================
-- Online Retail Sales Analysis using SQL
-- Database : MySQL
-- Dataset  : Online Retail Dataset (Kaggle)
-- Total Records: 524,878
-- Author   : Prem Ranjan
-- ==========================================

-- ==========================================
-- Online Retail Sales Analysis using SQL
-- Level 1 : Basic SQL Queries
-- ==========================================

-- Query 1 : Create Database

CREATE DATABASE IF NOT EXISTS online_retail_db;

-- Query 2 : Use Database

USE online_retail_db;

-- Query 3 : Display Table Structure

DESC online_retail_sale;

-- Query 4 : View Complete Dataset

SELECT *
FROM online_retail_sale;

-- Query 5 : Display First 10 Records

SELECT * FROM online_retail_sale
LIMIT 10;

-- Query 6 : Count Total Records

SELECT COUNT(*) AS Total_Records 
FROM online_retail_sale;

-- Query 7 : Show All Column Names

SHOW COLUMNS FROM online_retail_sale;

-- Query 8 : Calculate Total Revenue

SELECT ROUND(SUM(TotalSales),2) AS Total_Revenue
FROM online_retail_sale;

-- Query 9 : Count Total Orders

SELECT COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail_sale;

-- Query 10 : Count Total Customers

SELECT COUNT(DISTINCT CustomerID) AS Total_Customers
FROM online_retail_sale
WHERE CustomerID > 0;

-- Query 11 : Count Total Products

SELECT COUNT(DISTINCT StockCode) AS Total_Products
FROM online_retail_sale;

-- Query 12 : Count Total Countries

SELECT COUNT(DISTINCT Country) AS Total_Countries
FROM online_retail_sale;

-- Query 13 : Find Minimum and Maximum Sale

SELECT
    MIN(TotalSales) AS Minimum_Sale,
    MAX(TotalSales) AS Maximum_Sale
FROM online_retail_sale;

-- Query 14 : Calculate Average Sale

SELECT ROUND(AVG(TotalSales),2) AS Average_Sale
FROM online_retail_sale;

-- Query 15 : Find Minimum, Maximum and Average Unit Price

SELECT
    MIN(UnitPrice) AS Minimum_UnitPrice,
    MAX(UnitPrice) AS Maximum_UnitPrice,
    ROUND(AVG(UnitPrice),2) AS Average_UnitPrice
FROM online_retail_sale;

-- Query 16 : Calculate Total Quantity Sold

SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM online_retail_sale;

-- Query 17 : Find First and Last Order Date

SELECT
    MIN(InvoiceDate) AS First_Order,
    MAX(InvoiceDate) AS Last_Order
FROM online_retail_sale;

-- Query 18 : Count Orders by Country

SELECT Country, COUNT(*) AS Total_Orders
FROM online_retail_sale
GROUP BY Country
ORDER BY Total_Orders DESC;

-- ==========================================
-- Level 2 : Intermediate SQL Queries
-- ==========================================

-- Query 1 : Top 10 Products by Quantity Sold

SELECT Description, SUM(Quantity) AS Total_Quantity
FROM online_retail_sale
GROUP BY Description
ORDER BY Total_Quantity DESC
LIMIT 10;

-- Query 2 : Top 10 Products by Revenue

SELECT Description, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

-- Query 3 : Top 10 Customers by Revenue

SELECT CustomerID, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
WHERE CustomerID > 0
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;

-- Query 4 : Top 10 Countries by Revenue

SELECT Country, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 10;

-- Query 5 : Monthly Revenue

SELECT Year, Month, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY Year, Month
ORDER BY Year, Month;

-- Query 6 : Monthly Orders

SELECT Year, Month, COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail_sale
GROUP BY Year, Month
ORDER BY Year, Month;

-- Query 7 : Sales by Day of Week

SELECT DayName, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY DayName
ORDER BY Revenue DESC;

-- Query 8 : Sales by Hour

SELECT Hour, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY Hour
ORDER BY Hour;

-- Query 9 : Top 10 Highest Value Orders

SELECT InvoiceNo, ROUND(SUM(TotalSales),2) AS Order_Value
FROM online_retail_sale
GROUP BY InvoiceNo
ORDER BY Order_Value DESC
LIMIT 10;

-- Query 10 : Customers with Highest Number of Orders

SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail_sale
WHERE CustomerID > 0
GROUP BY CustomerID
ORDER BY Total_Orders DESC
LIMIT 10;

-- Query 11 : Countries with Revenue Greater than 100000

SELECT Country, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY Country
HAVING SUM(TotalSales) > 100000
ORDER BY Revenue DESC;

-- Query 12 : Products with Quantity Sold Greater than 10000

SELECT Description, SUM(Quantity) AS Total_Quantity
FROM online_retail_sale
GROUP BY Description
HAVING SUM(Quantity) > 10000
ORDER BY Total_Quantity DESC;

-- Query 13 : Customers with Revenue Greater than 50000

SELECT CustomerID, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
WHERE CustomerID > 0
GROUP BY CustomerID
HAVING SUM(TotalSales) > 50000
ORDER BY Revenue DESC;

-- Query 14 : Average Transaction value by Country

SELECT Country, ROUND(AVG(TotalSales),2) AS Average_Revenue
FROM online_retail_sale
GROUP BY Country
ORDER BY Average_Revenue DESC;

-- Query 15 : Average Quantity Sold per Product

SELECT Description, ROUND(AVG(Quantity),2) AS Average_Quantity
FROM online_retail_sale
GROUP BY Description
ORDER BY Average_Quantity DESC
LIMIT 10;

-- Query 16 : Total Revenue by Month Name

SELECT MonthName, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY MonthName
ORDER BY Revenue DESC;

-- Query 17 : Total Orders by Month Name

SELECT MonthName, COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail_sale
GROUP BY MonthName
ORDER BY Total_Orders DESC;

-- Query 18 : Products Sold in More than 100 Orders

SELECT Description, COUNT(DISTINCT InvoiceNo) AS Orders
FROM online_retail_sale
GROUP BY Description
HAVING COUNT(DISTINCT InvoiceNo) > 100
ORDER BY Orders DESC;

-- Query 19 : Revenue and Quantity by Country

SELECT Country, SUM(Quantity) AS Total_Quantity, ROUND(SUM(TotalSales),2) AS Revenue
FROM online_retail_sale
GROUP BY Country
ORDER BY Revenue DESC;

-- Query 20 : Monthly Average Order Value

SELECT Year, Month,
    ROUND(SUM(TotalSales) / COUNT(DISTINCT InvoiceNo),2) AS Avg_Order_Value
FROM online_retail_sale
GROUP BY Year, Month
ORDER BY Year, Month;

-- ==========================================
-- Level 3 : Advanced SQL Queries
-- ==========================================

-- Query 1 : Rank Products by Revenue

SELECT Description,
    ROUND(SUM(TotalSales),2) AS Revenue,
    RANK() OVER(ORDER BY SUM(TotalSales) DESC) AS Product_Rank
FROM online_retail_sale
GROUP BY Description;

-- Query 2 : Rank Customers by Revenue

SELECT CustomerID,
    ROUND(SUM(TotalSales),2) AS Revenue,
    DENSE_RANK() OVER(ORDER BY SUM(TotalSales) DESC) AS Customer_Rank
FROM online_retail_sale
WHERE CustomerID > 0
GROUP BY CustomerID;

-- Query 3 : Running Total of Monthly Revenue

SELECT Year, Month,
    ROUND(SUM(TotalSales),2) AS Monthly_Revenue,
    ROUND(SUM(SUM(TotalSales)) OVER(ORDER BY Year, Month), 2) AS Running_Total
FROM online_retail_sale
GROUP BY Year, Month;

-- Query 4 : Previous Month Revenue using LAG

WITH monthly_sales AS
(
    SELECT Year, Month,
        ROUND(SUM(TotalSales),2) AS Revenue
    FROM online_retail_sale
    GROUP BY Year, Month
)

SELECT Year, Month, Revenue,
    LAG(Revenue) OVER(ORDER BY Year, Month) AS Previous_Month_Revenue
FROM monthly_sales;

-- Query 5 : Monthly Revenue Growth

WITH monthly_sales AS
(
    SELECT Year, Month,
        ROUND(SUM(TotalSales),2) AS Revenue
    FROM online_retail_sale
    GROUP BY Year, Month
)

SELECT Year, Month, Revenue,
    LAG(Revenue) OVER(ORDER BY Year, Month) AS Previous_Revenue,
    ROUND( Revenue - LAG(Revenue) OVER(ORDER BY Year, Month), 2) AS Revenue_Growth
FROM monthly_sales;

-- Query 6 : Top 5 Customers in Each Country

WITH customer_sales AS
(
    SELECT Country, CustomerID,
        ROUND(SUM(TotalSales),2) AS Revenue
    FROM online_retail_sale
    WHERE CustomerID > 0
    GROUP BY Country, CustomerID
)

SELECT * FROM
(
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY Country ORDER BY Revenue DESC) AS Ranking
    FROM customer_sales
) AS t
WHERE Ranking <= 5;

-- Query 7 : Top 3 Products in Each Country

WITH product_sales AS
(
    SELECT Country, Description,
        ROUND(SUM(TotalSales),2) AS Revenue
    FROM online_retail_sale
    GROUP BY Country, Description
)

SELECT * FROM
(
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Revenue DESC) AS Ranking
    FROM product_sales
) AS t
WHERE Ranking <= 3;

-- Query 8 : Revenue Contribution (%) by Month

SELECT Year, Month,
    ROUND(SUM(TotalSales),2) AS Revenue,
    ROUND( SUM(TotalSales) * 100 / SUM(SUM(TotalSales)) OVER(), 2) AS Revenue_Percentage
FROM online_retail_sale
GROUP BY Year, Month;

-- Query 9 : Customer Performance Summary

SELECT CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Orders,
    ROUND(SUM(TotalSales),2) AS Revenue,
    ROUND(AVG(TotalSales),2) AS Average_Order_Value
FROM online_retail_sale
WHERE CustomerID > 0
GROUP BY CustomerID
ORDER BY Revenue DESC;

-- Query 10 : Rank Customers by Number of Orders

SELECT CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders,
    DENSE_RANK() OVER(ORDER BY COUNT(DISTINCT InvoiceNo) DESC) AS Order_Rank
FROM online_retail_sale
WHERE CustomerID > 0
GROUP BY CustomerID;

-- Query 11 : Highest Value Order in Each Country

WITH order_sales AS
(
    SELECT Country, InvoiceNo,
        ROUND(SUM(TotalSales),2) AS Order_Value
    FROM online_retail_sale
    GROUP BY Country, InvoiceNo
)

SELECT * FROM
(
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Order_Value DESC) AS Ranking FROM order_sales) AS t
WHERE Ranking = 1;

-- Query 12 : Revenue Difference from Overall Average

SELECT Country,
    ROUND(SUM(TotalSales),2) AS Revenue,
    ROUND(SUM(TotalSales) - AVG(SUM(TotalSales)) OVER(), 2) AS Difference_From_Average
FROM online_retail_sale
GROUP BY Country;

-- Query 13 : Top 10 Orders by Revenue with ranking

SELECT InvoiceNo,
    ROUND(SUM(TotalSales),2) AS Order_Value,
    RANK() OVER(ORDER BY SUM(TotalSales) DESC) AS Order_Rank
FROM online_retail_sale
GROUP BY InvoiceNo
LIMIT 10;

-- Query 14 : Revenue Share of Each Country

SELECT Country,
    ROUND(SUM(TotalSales),2) AS Revenue,
    ROUND(SUM(TotalSales) * 100 / SUM(SUM(TotalSales)) OVER(), 2) AS Revenue_Share_Percentage
FROM online_retail_sale
GROUP BY Country
ORDER BY Revenue DESC;

-- ==========================================
-- Project Summary
-- ==========================================

-- This project analyzes the Online Retail Sales dataset
-- using MySQL to understand sales performance, customer
-- purchasing behavior, product performance, and revenue trends.

-- A total of 52 SQL queries were written and divided into
-- three levels:
-- Level 1 : Basic SQL Queries
-- Level 2 : Intermediate SQL Queries
-- Level 3 : Advanced SQL Queries

-- ==========================================
-- Key Business Insights
-- ==========================================

-- • The dataset contains 524,878 cleaned sales records.
-- • Total revenue generated is over 10.64 million.
-- • The United Kingdom is the highest revenue-generating country.
-- • November recorded the highest monthly sales.
-- • Sales activity is highest between 10:00 AM and 3:00 PM.
-- • Thursday generated the highest revenue among all weekdays.
-- • DOTCOM POSTAGE generated the highest revenue.
-- • PAPER CRAFT, LITTLE BIRDIE is the top-selling product by quantity.
-- • A small number of customers contributed a large share of total revenue.
-- • Revenue is concentrated in a few countries, indicating opportunities for market expansion.

-- ==========================================
-- Conclusion
-- ==========================================

-- This project demonstrates practical SQL skills by solving
-- real-world business problems using sales data. The analysis
-- provides valuable insights into customer behavior, product
-- performance, sales trends, and revenue distribution. These
-- insights can support better business decisions related to
-- inventory management, marketing strategies, customer retention,
-- and future sales planning.

-- ==========================================
-- End of Project
-- ==========================================