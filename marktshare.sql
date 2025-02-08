WITH sales_data AS (
    SELECT
        mct.territory_id,
        dp.prod_brand,
        COUNT(fcs.prod_sku_id) AS brand_sales
    FROM fct_customer_sales fcs
    JOIN map_customer_territory mct ON fcs.cust_id = mct.cust_id
    JOIN dim_product dp ON fcs.prod_sku_id = dp.prod_sku_id
    WHERE fcs.order_date >= '2021-10-01' AND fcs.order_date < '2022-01-01'
    GROUP BY mct.territory_id, dp.prod_brand
),
total_sales_per_territory AS (
    SELECT
        territory_id,
        SUM(brand_sales) AS total_sales
    FROM sales_data
    GROUP BY territory_id
)
SELECT
    s.territory_id,
    s.prod_brand,
    ROUND((CAST(s.brand_sales AS FLOAT) / t.total_sales) * 100, 2) AS market_share_percentage
FROM sales_data s
JOIN total_sales_per_territory t ON s.territory_id = t.territory_id
ORDER BY s.territory_id, market_share_percentage DESC;
