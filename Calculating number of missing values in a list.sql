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

--Place a value of 0 in the SeatingChart table
INSERT INTO #SeatingChart (SeatNumber) VALUES (0);
GO


SELECT *
FROM #SeatingChart

WITH cte_Rank
AS
(
SELECT  SeatNumber,
        ROW_NUMBER() OVER (ORDER BY SeatNumber) AS RowNumber,
        SeatNumber - ROW_NUMBER() OVER (ORDER BY SeatNumber) AS Rnk
FROM    #SeatingChart
WHERE   SeatNumber > 0
)
SELECT  MAX(Rnk) AS MissingNumbers 
FROM    cte_Rank;
GO
