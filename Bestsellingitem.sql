--Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid.
--The best selling item is calculated using the formula (unitprice * quantity). Output the month, the description of the item along with the amount paid.


SELECT month_,description , amount_paid
FROM (
SELECT *, MONTH(CAST (invoicedate AS DATE)) AS Month_, (unitprice*quantity) AS amount_paid
FROM online_retail) AS subquery
GROUP BY month_,description,amount_paid
ORDER BY amount_paid DESC


