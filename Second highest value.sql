---Getting second highest value

DROP TABLE IF EXISTS #SampleData;
GO

CREATE TABLE #SampleData
(
IntegerValue  INTEGER PRIMARY KEY
);
GO

INSERT INTO #SampleData (IntegerValue) VALUES
(3759),(3760),(3761),(3762),(3763);
GO

SELECT *
FROM #SampleData

SELECT IntegerValue
FROM #SampleData
ORDER BY IntegerValue DESC
OFFSET 1 ROWS FETCH NEXT 1 ROW ONLY;


SELECT  TOP 1
        IntegerValue
FROM    (
        SELECT  TOP 2 *
        FROM    #SampleData
        ORDER BY IntegerValue DESC
        ) a
ORDER BY IntegerValue ASC;
GO


--Rank
WITH cte_Rank AS
(
SELECT  RANK() OVER (ORDER BY IntegerValue DESC) AS MyRank,
        *
FROM    #SampleData
)
SELECT  IntegerValue
FROM    cte_Rank
WHERE   MyRank = 2;
GO