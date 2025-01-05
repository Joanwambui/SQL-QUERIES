--You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases.
--Find the number of users that made additional in-app purchases due to the success of the marketing campaign.

--The marketing campaign doesn't start until one day after the initial in-app purchase 
--so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.


WITH FirstPurchase AS (
    SELECT
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM
        in_app_purchases
    GROUP BY
        user_id
)
SELECT
    COUNT(DISTINCT p.user_id) AS successful_users
FROM
    in_app_purchases p
JOIN
    FirstPurchase fp
ON
    p.user_id = fp.user_id
WHERE
    p.created_at > DATEADD(DAY, 1, fp.first_purchase_date)
    AND NOT EXISTS (
        SELECT 1
        FROM in_app_purchases fp_products
        WHERE
            fp_products.user_id = p.user_id
            AND fp_products.product_id = p.product_id
            AND CAST(fp_products.created_at AS DATE) = CAST(fp.first_purchase_date AS DATE)
    );
