DROP TABLE IF EXISTS #Gaps;
GO

CREATE TABLE #Gaps
(
RowNumber  INTEGER PRIMARY KEY,
TestCase   VARCHAR(100) NULL
);
GO

INSERT INTO #Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);
GO

SELECT *, ROW_NUMBER () OVER (ORDER BY RowNumber) AS RN
FROM #Gaps


--LAG with IGNORE NULLS
WITH cte_Lag AS
(
SELECT  *,
         LAG(TestCase) IGNORE NULLS OVER (ORDER BY RowNumber) AS LagIgnoreNulls
FROM    #Gaps
)
SELECT  RowNumber,
        (CASE WHEN TestCase IS NOT NULL THEN TestCase ELSE LagIgnoreNulls END) AS TestCase
FROM    cte_Lag;


