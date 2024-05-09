with cte AS (
SELECT order_occurrences,item_count
FROM items_per_order
ORDER BY 1 DESC
LIMIT 2)

SELECT item_count AS mode
FROM cte

SELECT item_count
FROM items_per_order
WHERE order_occurrences = (
  SELECT MAX(order_occurrences) 
  FROM items_per_order
);


SELECT item_count
FROM items_per_order
WHERE order_occurrences = (
  SELECT MODE() WITHIN GROUP (ORDER BY order_occurrences DESC) 
  FROM items_per_order
);