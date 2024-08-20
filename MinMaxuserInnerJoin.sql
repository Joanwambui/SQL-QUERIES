DROP TABLE IF EXISTS #Personal;
GO

CREATE TABLE #Personal
(
SpacemanID      INTEGER PRIMARY KEY,
JobDescription  VARCHAR(100) NOT NULL,
MissionCount    INTEGER NOT NULL
);
GO

INSERT INTO #Personal (SpacemanID, JobDescription, MissionCount) VALUES
(1001,'Astrogator',6),(2002,'Astrogator',12),(3003,'Astrogator',17),
(4004,'Geologist',21),(5005,'Geologist',9),(6006,'Geologist',8),
(7007,'Technician',13),(8008,'Technician',2),(9009,'Technician',7);
GO

SELECT *
FROM #Personal

WITH minmaxcte AS (
SELECT MIN(SpacemanID) Minimum, MAX(SpacemanID) Maximum
FROM #Personal)

SELECT m.Minimum, m.Maximum, p.JobDescription, p.MissionCount
FROM  #Personal p 
JOIN minmaxcte m
ON m.SpacemanID = p.SpacemanID


WITH minmaxcte AS (
    SELECT MIN(SpacemanID) AS Minimum, MAX(SpacemanID) AS Maximum
    FROM #Personal
)
SELECT m.Minimum, m.Maximum, p.JobDescription, p.MissionCount
FROM #Personal p
JOIN minmaxcte m
    ON p.SpacemanID = m.Minimum OR p.SpacemanID = m.Maximum;

--MIN and MAX
WITH cte_MinMax AS
(
SELECT  JobDescription,
        MAX(MissionCount) AS MaxMissionCount,
        MIN(MissionCount) AS MinMissionCount
FROM    #Personal
GROUP BY JobDescription
)
SELECT  a.JobDescription,
        b.SpacemanID AS MostExperienced,
        c.SpacemanID AS LeastExperienced
FROM    cte_MinMax a INNER JOIN
        #Personal b ON a.JobDescription = b.JobDescription AND
                       a.MaxMissionCount = b.MissionCount  INNER JOIN
        #Personal c ON a.JobDescription = c.JobDescription AND
                       a.MinMissionCount = c.MissionCount;
GO