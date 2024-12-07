SELECT SalesRepID
FROM #Orders
GROUP BY SalesRepID
HAVING count(Salestype)>1

--separate solution
with cte as (
SELECT V.vendor_name, S.vendor_id, S.item_name, S.quantity_Sold,
S.price_per_unit, S.quantity_Sold*S.price_per_unit AS total_revenue
FROM sales S
INNER JOIN vendors V
ON S.vendor_id = V.vendor_id)

SELECT vendor_name, SUM(total_revenue)
FROM cte
GROUP BY vendor_name
ORDER BY SUM(total_revenue) DESC
LIMIT 2
