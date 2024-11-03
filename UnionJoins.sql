WITH cte AS (
    SELECT date, consumption
    FROM fb_eu_energy E

    UNION 

    SELECT date, consumption
    FROM fb_asia_energy A

    UNION 

    SELECT date, consumption
    FROM fb_na_energy N
),

cte1 AS (
    SELECT date, SUM(consumption) AS total
    FROM cte
    GROUP BY date
)

SELECT *
FROM cte1
WHERE total = (SELECT MAX(total) FROM cte1);
