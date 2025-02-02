DROP TABLE IF EXISTS #Ungroup;
DROP TABLE IF EXISTS #Numbers;
GO

CREATE TABLE #Ungroup
(
ProductDescription  VARCHAR(100) PRIMARY KEY,
Quantity            INTEGER NOT NULL
);
GO

        
INSERT INTO #Ungroup (ProductDescription, Quantity) VALUES
('Pencil',3),('Eraser',4),('Notebook',2);
GO

SELECT *
FROM #Ungroup


--Numbers Table
SELECT IntegerValue
INTO   #Numbers
FROM   (VALUES(1),(2),(3),(4)) a(IntegerValue) 
GO

ALTER TABLE #Ungroup ADD FOREIGN KEY (Quantity) REFERENCES #Numbers(IntegerValue);
GO

SELECT  a.ProductDescription,
        1 AS Quantity
FROM    #Ungroup a CROSS JOIN
        #Numbers b
WHERE   a.Quantity >= b.IntegerValue;
GO

--Recursion
WITH cte_Recursion AS
(
SELECT  ProductDescription,Quantity 
FROM    #Ungroup
UNION ALL
SELECT  ProductDescription,Quantity-1 
FROM    cte_Recursion
WHERE   Quantity >= 2
    )
SELECT  ProductDescription,1 AS Quantity
FROM   cte_Recursion
ORDER BY ProductDescription DESC;
GO
