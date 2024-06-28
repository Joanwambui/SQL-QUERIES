WITH cte AS (
    SELECT 
        S.ID AS Student_ID,
        S.Name AS Student_Name,
        F.Friend_ID,
        PS.Salary AS Student_Salary, 
        PF.Salary AS Friends_Salary
    FROM 
        Students S
    INNER JOIN 
        Friends F ON S.ID = F.ID
    INNER JOIN 
        Packages PS ON S.ID = PS.ID
    INNER JOIN 
        Packages PF ON F.Friend_ID = PF.ID
)
SELECT 
    Student_Name
FROM 
    cte
WHERE 
    Friends_Salary > Student_Salary
ORDER BY 
    Friends_Salary;
