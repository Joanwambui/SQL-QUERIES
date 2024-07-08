DROP TABLE IF EXISTS #WorkflowSteps;
GO

CREATE TABLE #WorkflowSteps
(
Workflow        VARCHAR(100),
StepNumber      INTEGER,
CompletionDate  DATE NULL,
PRIMARY KEY (Workflow, StepNumber)
);
GO

INSERT INTO #WorkflowSteps (Workflow, StepNumber, CompletionDate) VALUES
('Alpha',1,'7/2/2018'),('Alpha',2,'7/2/2018'),('Alpha',3,'7/1/2018'),
('Bravo',1,'6/25/2018'),('Bravo',2,NULL),('Bravo',3,'6/27/2018'),
('Charlie',1,NULL),('Charlie',2,'7/1/2018');
GO

SELECT *
FROM #WorkflowSteps

--NULL operators
WITH cte_NotNull AS
(
SELECT  DISTINCT
        Workflow
FROM    #WorkflowSteps
WHERE   CompletionDate IS NOT NULL
),
cte_Null AS
(
SELECT  Workflow
FROM    #WorkflowSteps
WHERE   CompletionDate IS NULL
)
SELECT  Workflow
FROM    cte_NotNull
WHERE   Workflow IN (SELECT Workflow FROM cte_Null);
GO