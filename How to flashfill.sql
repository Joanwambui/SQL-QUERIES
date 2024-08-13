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


--Solution 1
--MAX and COUNT function
WITH cte_Count AS
(
SELECT RowNumber,
       TestCase,
       COUNT(TestCase) OVER (ORDER BY RowNumber) AS DistinctCount
FROM #Gaps
)
SELECT  RowNumber,
        MAX(TestCase) OVER (PARTITION BY DistinctCount) AS TestCase
FROM    cte_Count
ORDER BY RowNumber;
GO


