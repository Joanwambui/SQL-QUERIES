DROP TABLE IF EXISTS #SeatingChart;
GO

CREATE TABLE #SeatingChart
(
SeatNumber  INTEGER PRIMARY KEY
);
GO

INSERT INTO #SeatingChart (SeatNumber) VALUES
(7),(13),(14),(15),(27),(28),(29),(30),(31),(32),(33),(34),(35),(52),(53),(54);
GO

SELECT *
FROM #SeatingChart


---Odd number/even number count

WITH cte_Seats AS
(
SELECT  *
FROM    #SeatingChart
WHERE   SeatNumber > 0
)
SELECT  (CASE SeatNumber%2 WHEN 1  THEN 'Odd' ELSE 'Even' END) AS Modulus,
        COUNT(*) AS [Count]
FROM    cte_Seats
GROUP BY (CASE SeatNumber%2 WHEN 1 THEN 'Odd' ELSE 'Even' END);
GO