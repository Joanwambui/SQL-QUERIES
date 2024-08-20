DROP TABLE IF EXISTS #Orders;
GO

CREATE TABLE #Orders
(
InvoiceID   INTEGER PRIMARY KEY,
SalesRepID  INTEGER NOT NULL,
Amount      MONEY NOT NULL,
SalesType   VARCHAR(100) NOT NULL
);
GO

INSERT INTO #Orders (InvoiceId, SalesRepID, Amount, SalesType) VALUES
(1,1001,13454,'International'),
(2,1001,3434,'International'),
(3,2002,54645,'International'),
(4,3003,234345,'International'),
(5,4004,776,'International'),
(6,1001,4564,'Domestic'),
(7,2002,34534,'Domestic'),
(8,2002,345,'Domestic'),
(9,5005,6543,'Domestic'),
(10,6006,67,'Domestic');
GO

SELECT *
FROM #Orders

WITH cte_InterDomestic AS
(
SELECT  SalesRepID
FROM    #Orders
GROUP BY SalesRepID
HAVING   COUNT(DISTINCT SalesType) = 2
)
SELECT  DISTINCT SalesRepID
FROM    #Orders 
WHERE   SalesRepID NOT IN (SELECT SalesRepID FROM cte_InterDomestic);
GO