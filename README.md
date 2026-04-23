# SQL Customer Intelligence Project

In this project, I used SQL to analyze customer purchase behavior and find hidden insights like top spenders, loyalty, and purchase frequency. This project shows how I can use complex SQL queries (like CTEs and Window Functions) to answer important business questions.

## Project Goals
1. **Find Top Customers**: Identifying the top 10 customers by total spend.
2. **Customer Segmentation**: Splitting customers into Gold, Silver, and Bronze tiers based on their revenue contribution.
3. **Retention Analysis**: Using cohorts to see how many customers return month after month.
4. **Repeat Behavior**: Calculating the average number of days it takes for a customer to make their next purchase.

## Tech Used
- **SQL (SQLite)**: For writing all the analysis queries.
- **Python**: To generate a sample database for testing the queries.
- **Tableau (Mockup)**: I created a dashboard to visualize these SQL results for a business audience.

## Key Files
- `sql/customer_insights.sql`: Contains all the SQL logic for the project.
- `src/setup_db.py`: A Python script that creates a local database with 2,000+ orders to test our SQL.
- `dashboard/index.html`: A visual version of the SQL results.

## What I Learned
- How to use **Windows Functions** (`LAG`, `OVER`) for time-based analysis.
- How to create **Cohorts** to track customer loyalty.
- How to use `CASE` statements to categorize customers into segments.
