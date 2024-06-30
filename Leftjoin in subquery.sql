SELECT C.customer_id, C.customer_name, P.product_name AS last_product_name
FROM Customers C
LEFT JOIN (
    SELECT O.customer_id, O.product_id
    FROM Orders O
    INNER JOIN (
        SELECT customer_id, MAX(order_date) AS last_order_date
        FROM Orders
        GROUP BY customer_id
    ) AS L
    ON O.customer_id = L.customer_id AND O.order_date = L.last_order_date
) AS LastOrder
ON C.customer_id = LastOrder.customer_id
LEFT JOIN Products P
ON LastOrder.product_id = P.product_id;

'''
Write an SQL query to list all customers and their last ordered product name. 
If a customer has never placed an order, the product name should be displayed as NULL. 
Include the columns customer_id, customer_name, and last_product_name in the result.
'''