DROP TABLE IF EXISTS #Promotions;
GO

CREATE TABLE #Promotions (
OrderID   INTEGER NOT NULL,
Product   VARCHAR(255) NOT NULL,
Discount  VARCHAR(255)
);
GO

INSERT INTO #Promotions (OrderID, Product, Discount) VALUES 
(1, 'Item1', 'PROMO'),
(1, 'Item1', 'PROMO'),
(1, 'Item1', 'MARKDOWN'),
(1, 'Item2', 'PROMO'),
(2, 'Item2', NULL),
(2, 'Item3', 'MARKDOWN'),
(2, 'Item3', NULL),
(3, 'Item1', 'PROMO'),
(3, 'Item1', 'PROMO'),
(3, 'Item1', 'PROMO');
GO

SELECT OrderID
FROM   #Promotions
WHERE  Discount = ALL(SELECT 'PROMO')
GROUP BY OrderID
HAVING COUNT(DISTINCT Product) = 1;
GO
