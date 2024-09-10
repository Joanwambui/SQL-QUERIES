DROP TABLE IF EXISTS #ElevatorOrder;
GO

CREATE TABLE #ElevatorOrder
(
LineOrder  INTEGER PRIMARY KEY,
[Name]     VARCHAR(100) NOT NULL,
[Weight]   INTEGER NOT NULL
);
GO




INSERT INTO #ElevatorOrder ([Name], [Weight], LineOrder)
VALUES
('Haruto',611,1),('Minato',533,2),('Haruki',623,3),
('Sota',569,4),('Aoto',610,5),('Hinata',525,6);
GO


SELECT *
FROM #ElevatorOrder;

WITH cte_Running_Total AS
(
SELECT  [Name], [Weight], LineOrder,
        SUM(Weight) OVER (ORDER BY LineOrder) AS Running_Total
FROM    #ElevatorOrder
)
SELECT  TOP 1
        [Name], [Weight], LineOrder, Running_Total
FROM    cte_Running_Total
WHERE   Running_Total <= 2000
ORDER BY Running_Total DESC;
GO