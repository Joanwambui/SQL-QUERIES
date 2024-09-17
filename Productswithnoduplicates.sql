DROP TABLE IF EXISTS #Products;
GO

CREATE TABLE #Products
(
Product      VARCHAR(10),
ProductCode  VARCHAR(2),
PRIMARY KEY (Product, ProductCode)
);
GO

INSERT INTO #Products (Product, ProductCode) VALUES
('Alpha','01'),
('Alpha','02'),
('Bravo','03'),
('Bravo','04'),
('Charlie','02'),
('Delta','01'),
('Echo','EE'),
('Foxtrot','EE'),
('Gulf','GG');
GO


with products_duplicate as (
SELECT Product
FROM #Products
GROUP BY Product
HAVING count(*)>2),

productcodes_Cte as (
SELECT ProductCode
FROM #Products
WHERE Product IN (SELECT Product FROM products_duplicate)
)

SELECT DISTINCT ProductCode
FROM #Products
WHERE ProductCode NOT IN (SELECT ProductCode FROM productcodes_Cte)
