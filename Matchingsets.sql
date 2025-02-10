DROP TABLE IF EXISTS #Employees;
GO

CREATE TABLE #Employees
(
EmployeeID  INTEGER,
License     VARCHAR(100),
PRIMARY KEY (EmployeeID, License)
);
GO
        

INSERT INTO #Employees (EmployeeID, License) VALUES
(1001,'Class A'),(1001,'Class B'),(1001,'Class C'),
(2002,'Class A'),(2002,'Class B'),(2002,'Class C'),
(3003,'Class A'),(3003,'Class D'),
(4004,'Class A'),(4004,'Class B'),(4004,'Class D'),
(5005,'Class A'),(5005,'Class B'),(5005,'Class D');
GO


WITH cte_Count AS
(
SELECT  EmployeeID,
        COUNT(*) AS LicenseCount
FROM    #Employees
GROUP BY EmployeeID
),
cte_CountWindow AS
(
SELECT  a.EmployeeID AS EmployeeID_A,
        b.EmployeeID AS EmployeeID_B,
        COUNT(*) OVER (PARTITION BY a.EmployeeID, b.EmployeeID) AS CountWindow
FROM    #Employees a CROSS JOIN
        #Employees b
WHERE   a.EmployeeID <> b.EmployeeID and a.License = b.License
)
SELECT  DISTINCT
        a.EmployeeID_A,
        a.EmployeeID_B,
        a.CountWindow AS LicenseCount
FROM    cte_CountWindow a INNER JOIN
        cte_Count b ON a.CountWindow = b.LicenseCount AND a.EmployeeID_A = b.EmployeeID INNER JOIN
        cte_Count c ON a.CountWindow = c.LicenseCount AND a.EmployeeID_B = c.EmployeeID;
GO
