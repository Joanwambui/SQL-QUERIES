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


---This is how you get gap start and gap end from a list
WITH cte_Gaps AS 
(
SELECT  SeatNumber AS GapStart,
        LEAD(SeatNumber,1,0) OVER (ORDER BY SeatNumber) AS GapEnd,
        LEAD(SeatNumber,1,0) OVER (ORDER BY SeatNumber) - SeatNumber AS Gap
FROM    #SeatingChart
)
SELECT  GapStart + 1 AS GapStart,
        GapEnd - 1 AS GapEnd
FROM    cte_Gaps
WHERE Gap > 1;
GO


LAG() will show previous values from the list 