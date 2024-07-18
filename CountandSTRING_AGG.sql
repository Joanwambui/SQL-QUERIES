DROP TABLE IF EXISTS #ProcessLog;
GO

CREATE TABLE #ProcessLog
(
Workflow    VARCHAR(100),
StepNumber  INTEGER,
RunStatus   VARCHAR(100) NOT NULL,
PRIMARY KEY (Workflow, StepNumber)
);
GO

INSERT INTO #ProcessLog (Workflow, StepNumber, RunStatus) VALUES
('Alpha',1,'Error'),('Alpha',2,'Complete'),('Alpha',3,'Running'),
('Bravo',1,'Complete'),('Bravo',2,'Complete'),
('Charlie',1,'Running'),('Charlie',2,'Running'),
('Delta',1,'Error'),('Delta',2,'Error'),
('Echo',1,'Running'),('Echo',2,'Complete');
GO

--Solution 1
--MIN and MAX
WITH cte_MinMax AS
(
SELECT  Workflow,
        MIN(RunStatus) AS MinStatus,
        MAX(RunStatus) AS MaxStatus
FROM    #ProcessLog
GROUP BY Workflow
),
cte_Error AS
(
SELECT  Workflow,
        MAX(CASE RunStatus WHEN 'Error' THEN RunStatus END) AS ErrorState,
        MAX(CASE RunStatus WHEN 'Running' THEN RunStatus END) AS RunningState
FROM    #ProcessLog
WHERE   RunStatus IN ('Error','Running')
GROUP BY Workflow
)
SELECT  a.Workflow,
        CASE WHEN a.MinStatus = a.MaxStatus THEN a.MinStatus
             WHEN b.ErrorState = 'Error' THEN 'Indeterminate'
             WHEN b.RunningState = 'Running' THEN b.RunningState END AS RunStatus
FROM    cte_MinMax a LEFT OUTER JOIN
        cte_Error b ON a.WorkFlow = b.WorkFlow
ORDER BY 1;
GO

--Solution 2
--COUNT and STRING_AGG
WITH cte_Distinct AS
(
SELECT DISTINCT
       Workflow,
       RunStatus
FROM   #ProcessLog
),
cte_StringAgg AS
(
SELECT  Workflow,
        STRING_AGG(RunStatus,', ') AS RunStatus_Agg,
        COUNT(DISTINCT RunStatus) AS DistinctCount
FROM    cte_Distinct
GROUP BY Workflow
)
SELECT  Workflow,
        CASE WHEN DistinctCount = 1 THEN RunStatus_Agg
             WHEN RunStatus_Agg LIKE '%Error%' THEN 'Indeterminate'
             WHEN RunStatus_Agg LIKE '%Running%' THEN 'Running' END AS RunStatus
FROM    cte_StringAgg
ORDER BY 1;
GO