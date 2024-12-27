WITH cte AS (
    SELECT
        T.customer_id,
        T.store_id,
        T.transaction_amount,
        T.transaction_date,
        T.transaction_id,
        S.area_name,
        S.area_size,
        S.store_location,
        S.store_open_date
    FROM
        transaction_records T
    JOIN
        stores S
    ON
        T.store_id = S.store_id
    WHERE
        S.area_size > 0  -- Ensure area_size is not zero
)
SELECT TOP 3 area_name, customer_density
FROM
    (SELECT
        COUNT(DISTINCT customer_id) AS customercount,
        area_name,
        area_size,
        CAST(COUNT(DISTINCT customer_id) AS FLOAT) / area_size AS customer_density
    FROM
        cte
    GROUP BY
        area_name, area_size) AS subquery
ORDER BY
    customer_density DESC;
