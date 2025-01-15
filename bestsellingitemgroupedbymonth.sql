with cte AS (
SELECT description,MONTH(invoicedate) AS Month,MAX(unitprice * quantity) as best_Selling_item
FROM online_retails
GROUP BY description,MONTH(invoicedate))


SELECT 
    Month,
    best_Selling_item,
    description
FROM 
    cte
GROUP BY Month, description,best_Selling_item
ORDER BY best_Selling_item DESC





SELECT
    MONTH(r1.invoicedate) AS month,
    r1.description,
    MAX(r1.unitprice * r1.quantity) AS amount_paid
FROM
    online_retails r1
JOIN (
    SELECT
        MONTH(invoicedate) AS month,
        invoiceno,
        MAX(SUM(unitprice * quantity)) OVER (PARTITION BY MONTH(invoicedate)) AS max_invoice_amount
    FROM
        online_retails
    GROUP BY
        MONTH(invoicedate), invoiceno
) AS max_invoice ON
    MONTH(r1.invoicedate) = max_invoice.month
    AND r1.invoiceno = max_invoice.invoiceno
WHERE
    r1.unitprice * r1.quantity > 0
GROUP BY
    MONTH(r1.invoicedate), r1.description
ORDER BY
    month;
