--Your output should contain the product ID, total units sold in descending order, and its categorized ad performance.
--Following a recent advertising campaign, the marketing department wishes to classify its efforts based on the total number of units sold for each product.

--You have been tasked with calculating the total number of units sold for each product and categorizing ad performance based on the following criteria for items sold:


--Outstanding: 30+
--Satisfactory: 20 - 29
--Unsatisfactory: 10 - 19
--Poor: 1 - 9
SELECT 
    product_id, 
    SUM(quantity) AS total_units_sold,
    CASE 
        WHEN SUM(quantity) > 30 THEN 'Outstanding'
        WHEN SUM(quantity) >= 20 AND SUM(quantity) < 30 THEN 'Satisfactory'
        WHEN SUM(quantity) >= 10 AND SUM(quantity) < 20 THEN 'Unsatisfactory'
        WHEN SUM(quantity) >= 1 AND SUM(quantity) < 10 THEN 'Poor'
        ELSE 'No Sales'
    END AS performance
FROM 
    marketing_campaign
GROUP BY 
    product_id
ORDER BY 
    total_units_sold DESC;
