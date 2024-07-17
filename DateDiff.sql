DROP TABLE IF EXISTS #ProcessLog;
GO

CREATE TABLE #ProcessLog
(
WorkFlow       VARCHAR(100),
ExecutionDate  DATE,
PRIMARY KEY (WorkFlow, ExecutionDate)
);
GO

INSERT INTO #ProcessLog (WorkFlow, ExecutionDate) VALUES
('Alpha','6/01/2018'),('Alpha','6/14/2018'),('Alpha','6/15/2018'),
('Bravo','6/1/2018'),('Bravo','6/2/2018'),('Bravo','6/19/2018'),
('Charlie','6/1/2018'),('Charlie','6/15/2018'),('Charlie','6/30/2018');
GO

SELECT *
FROM #ProcessLog

SELECT 
    WorkFlow, 
    DATEDIFF(DAY, MIN(ExecutionDate), MAX(ExecutionDate))/2 AS Average_Days
FROM 
    #ProcessLog
GROUP BY 
    WorkFlow
ORDER BY WorkFlow ASC;


WITH cte_DayDiff AS
(
SELECT  Workflow,
        (DATEDIFF(DD,LAG(ExecutionDate,1,NULL) OVER
                (PARTITION BY Workflow ORDER BY ExecutionDate),ExecutionDate)) AS DateDifference
FROM    #ProcessLog
)
SELECT  Workflow,
        AVG(DateDifference)
FROM    cte_DayDiff
WHERE   DateDifference IS NOT NULL
GROUP BY Workflow;
GO