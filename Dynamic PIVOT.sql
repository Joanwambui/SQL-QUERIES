DROP TABLE IF EXISTS #Sales;
GO

        
CREATE TABLE #Sales
(
[Year]  INTEGER NOT NULL,
Amount  INTEGER NOT NULL
);
GO

INSERT INTO #Sales ([Year], Amount) VALUES
(YEAR(GETDATE()),352645),
(YEAR(DATEADD(YEAR,-1,GETDATE())),165565),
(YEAR(DATEADD(YEAR,-1,GETDATE())),254654),
(YEAR(DATEADD(YEAR,-2,GETDATE())),159521),
(YEAR(DATEADD(YEAR,-2,GETDATE())),251696),
(YEAR(DATEADD(YEAR,-3,GETDATE())),111894);
GO


--LAG
WITH cte_AggregateTotal AS
(
SELECT  [Year],
        SUM(Amount) AS Amount
FROM    #Sales
GROUP BY [Year]
),
cte_Lag AS
(
SELECT  [Year],
        Amount,
        LAG(Amount,1,0) OVER (ORDER BY Year) AS Lag1,
        LAG(Amount,2,0) OVER (ORDER BY Year) AS Lag2
FROM    cte_AggregateTotal
)
SELECT  Amount AS '2023',
        Lag1 AS '2022',
        Lag2 AS '2021'
FROM    cte_Lag
WHERE   [Year] = 2023;
GO


BEGIN
    
    DECLARE @CurrentYear VARCHAR(MAX) =
                CAST(YEAR(GETDATE()) AS VARCHAR);
    DECLARE @CurrentYearLag1 VARCHAR(MAX) =
                CAST(YEAR(DATEADD(YEAR,-1,GETDATE())) AS VARCHAR);
    DECLARE @CurrentYearLag2 VARCHAR(MAX) =
                CAST(YEAR(DATEADD(YEAR,-2,GETDATE())) AS VARCHAR);
    DECLARE @DynamicSQL NVARCHAR(MAX);

    SET @DynamicSQL =
    'SELECT [' + @CurrentYear + '],
            [' + @CurrentYearLag1 + '],
            [' + @CurrentYearLag2 + ']
    FROM #Sales 
    PIVOT (SUM(AMOUNT) FOR YEAR IN (
            [' + @CurrentYear + '],
            [' + @CurrentYearLag1 + '],
            [' + @CurrentYearLag2 + '])) AS PivotClause;'

    PRINT @DynamicSQL;
    EXECUTE SP_EXECUTESQL @DynamicSQL;

END;

SELECT *
FROM    #Sales
