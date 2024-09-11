DROP TABLE IF EXISTS #ProductsA;
DROP TABLE IF EXISTS #ProductsB;
GO

CREATE TABLE #ProductsA
(
ProductName  VARCHAR(100) PRIMARY KEY,
Quantity     INTEGER NOT NULL
);
GO

CREATE TABLE #ProductsB
(
ProductName  VARCHAR(100) PRIMARY KEY,
Quantity     INTEGER NOT NULL
);
GO

INSERT INTO #ProductsA (ProductName, Quantity) VALUES
('Widget',7),
('Doodad',9),
('Gizmo',3);
GO

INSERT INTO #ProductsB (ProductName, Quantity) VALUES
('Widget',7),
('Doodad',6),
('Dingbat',9);
GO

WITH cte_FullOuter AS
(
SELECT  a.ProductName AS ProductNameA,
        b.ProductName AS ProductNameB,
        a.Quantity AS QuantityA,
        b.Quantity AS QuantityB
FROM    #ProductsA a FULL OUTER JOIN
        #ProductsB b ON a.ProductName = b.ProductName
)
SELECT  'Matches in both table A and table B' AS [Type],
        ProductNameA
FROM    cte_FullOuter
WHERE   ProductNameA = ProductNameB AND QuantityA = QuantityB
UNION
SELECT  'Product does not exist in table B' AS [Type],
        ProductNameA
FROM    cte_FullOuter
WHERE   ProductNameB IS NULL
UNION
SELECT  'Product does not exist in table A' AS [Type],
        ProductNameB
FROM   cte_FullOuter
WHERE  ProductNameA IS NULL
UNION
SELECT  'Quantities in table A and table B do not match' AS [Type],
        ProductNameA
FROM    cte_FullOuter
WHERE   ProductNameA = ProductNameB AND QuantityA <> QuantityB;
GO