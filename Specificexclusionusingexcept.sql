DROP TABLE IF EXISTS #Orders;
GO

CREATE TABLE #Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
Amount      MONEY NOT NULL
);
GO

INSERT INTO #Orders (OrderID, CustomerID, Amount) VALUES
(1,1001,25),(2,1001,50),(3,2002,65),(4,3003,50);
GO

SELECT *
FROM #Orders

--Solutions 1 and 2 show Morgan's Law.
--Solution 1
--NOT
SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
WHERE   NOT(CustomerID = 1001 AND Amount = 50);
GO

--Solution 2 
--OR
SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
WHERE   CustomerID <> 1001 OR Amount <> 50;
GO

--Solution 3
--EXCEPT
SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
EXCEPT
SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
WHERE   CustomerID = 1001 AND Amount = 50;
GO