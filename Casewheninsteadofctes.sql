WITH cte_cake AS (
    SELECT date_sold, COALESCE(amount_sold, 0) AS amount_sold
    FROM desserts 
    WHERE product = 'Cake'
),

    
cte_pie AS (
    SELECT date_sold, COALESCE(amount_sold, 0) AS amount_sold
    FROM desserts 
    WHERE product = 'Pie'
)

SELECT 
    c.date_sold, 
    ABS(c.amount_sold - p.amount_sold) AS difference,
    CASE 
        WHEN c.amount_sold > p.amount_sold THEN 'Cake'
        WHEN p.amount_sold > c.amount_sold THEN 'Pie'
        ELSE 'Equal' 
    END AS sold_more
FROM cte_cake c
INNER JOIN cte_pie p 
    ON c.date_sold = p.date_sold
ORDER BY c.date_sold;


SELECT
    date_sold,
    ABS(SUM(CASE WHEN product = 'Cake' THEN amount_sold ELSE 0 END) -
        SUM(CASE WHEN product = 'Pie' THEN amount_sold ELSE 0 END)) AS difference,
    CASE
        WHEN SUM(CASE WHEN product = 'Cake' THEN amount_sold ELSE 0 END) >
            SUM(CASE WHEN product = 'Pie' THEN amount_sold ELSE 0 END)
        THEN 'Cake'
        ELSE 'Pie'
    END AS sold_more
FROM
    desserts
GROUP BY
    date_sold
ORDER BY
    date_sold;
