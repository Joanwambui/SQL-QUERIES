

WITH WeeklySales AS (
    SELECT
        DATEPART(WEEK, invoicedate) AS week_number,
        SUM(quantity * unitprice) AS total_weekly_sales
    FROM early_sales
    WHERE invoicedate BETWEEN '2023-01-01' AND '2023-02-26'
    GROUP BY DATEPART(WEEK, invoicedate)
),
SalesByDay AS (
    SELECT
        DATEPART(WEEK, invoicedate) AS week_number,
        DATEPART(WEEKDAY, invoicedate) AS day_of_week,
        SUM(quantity * unitprice) AS daily_sales
    FROM early_sales
    WHERE invoicedate BETWEEN '2023-01-01' AND '2023-02-28'
    GROUP BY DATEPART(WEEK, invoicedate), DATEPART(WEEKDAY, invoicedate)
),
FirstAndLastDaySales AS (
    SELECT
        s.week_number,
        COALESCE(SUM(CASE WHEN s.day_of_week = 2 THEN s.daily_sales END), 0) AS monday_sales,
        COALESCE(SUM(CASE WHEN s.day_of_week = 7 THEN s.daily_sales END), 0) AS sunday_sales
    FROM SalesByDay s
    GROUP BY s.week_number
)
SELECT
    ws.week_number,
    ROUND(100.0 * fl.monday_sales / ws.total_weekly_sales, 0) AS monday_sales_percentage,
    ROUND(100.0 * fl.sunday_sales / ws.total_weekly_sales, 0) AS sunday_sales_percentage
FROM WeeklySales ws
JOIN FirstAndLastDaySales fl ON ws.week_number = fl.week_number
ORDER BY ws.week_number;
