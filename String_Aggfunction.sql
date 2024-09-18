DROP TABLE IF EXISTS #Students;
GO

CREATE TABLE #Students
(
StudentName  VARCHAR(50) PRIMARY KEY,
Birthday     DATE
);
GO

INSERT INTO #Students (StudentName, Birthday) VALUES
('Susan', '2015-04-15'),
('Tim', '2015-04-15'),
('Jacob', '2015-04-15'),
('Earl', '2015-02-05'),
('Mike', '2015-05-23'),
('Angie', '2015-05-23'),
('Jenny', '2015-11-19'),
('Michelle', '2015-12-12'),
('Aaron', '2015-12-18');
GO

SELECT  Birthday, STRING_AGG(StudentName, ', ') AS Students
FROM    #Students
GROUP BY Birthday
HAVING  COUNT(*) > 1;
GO
