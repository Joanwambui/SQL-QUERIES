SELECT 
    cust_id,
    prod_sku_id,
    order_date,
    order_value,
    order_id,
    CONCAT('Q', ((MONTH(order_date) - 1) / 3 + 1), ' ', YEAR(order_date)) AS order_quarter
FROM 
    fct_customer_sale;