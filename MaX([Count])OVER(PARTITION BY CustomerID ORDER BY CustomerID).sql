DROP TABLE IF EXISTS #Orders;
GO

CREATE TABLE #Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
[Count]     INTEGER NOT NULL,
Vendor      VARCHAR(100) NOT NULL
);
GO

INSERT INTO #Orders (OrderID, CustomerID, [Count], Vendor) VALUES
(1,1001,12,'Direct Parts'),
(2,1001,54,'Direct Parts'),
(3,1001,32,'ACME'),
(4,2002,7,'ACME'),
(5,2002,16,'ACME'),
(6,2002,5,'Direct Parts');
GO

SELECT *
FROM #Orders

WITH cte_Max AS
(
SELECT  OrderID, CustomerID, [Count], Vendor,
        MAX([Count]) OVER (PARTITION BY CustomerID ORDER BY CustomerID) AS MaxCount
FROM    #Orders
)
SELECT  CustomerID, Vendor
FROM    cte_Max
WHERE   [Count] = MaxCount
ORDER BY 1, 2;
GO


