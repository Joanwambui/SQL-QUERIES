DROP TABLE IF EXISTS #ProcessLog;
GO

CREATE TABLE #ProcessLog
(
Workflow     VARCHAR(100),
LogMessage   VARCHAR(100),
Occurrences  INTEGER NOT NULL,
PRIMARY KEY (Workflow, LogMessage)
);
GO

INSERT INTO #ProcessLog (Workflow, LogMessage, Occurrences) VALUES
('Alpha','Error: Conversion Failed',5),
('Alpha','Status Complete',8),
('Alpha','Error: Unidentified error occurred',9),
('Bravo','Error: Cannot Divide by 0',3),
('Bravo','Error: Unidentified error occurred',1),
('Charlie','Error: Unidentified error occurred',10),
('Charlie','Error: Conversion Failed',7),
('Charlie','Status Complete',6);
GO



SELECT  WorkFlow,
        LogMessage,
        Occurrences
FROM    #ProcessLog AS e1
WHERE   Occurrences > ALL(SELECT    e2.Occurrences
                            FROM    #ProcessLog AS e2
                            WHERE   e2.LogMessage = e1.LogMessage AND
                                    e2.WorkFlow <> e1.WorkFlow);
