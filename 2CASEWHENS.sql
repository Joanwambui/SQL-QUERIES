WITH cte AS (

    SELECT ID, Name, Marks,
    CASE 

        WHEN Marks BETWEEN 0 AND 9 THEN 1
        WHEN Marks BETWEEN 10 AND 19 THEN 2
        WHEN Marks BETWEEN 20 AND 29 THEN 3
        WHEN Marks BETWEEN 30 AND 39 THEN 4
        WHEN Marks BETWEEN 40 AND 49 THEN 5
        WHEN Marks BETWEEN 50 AND 59 THEN 6
        WHEN Marks BETWEEN 60 AND 69 THEN 7
        WHEN Marks BETWEEN 70 AND 79 THEN 8
        WHEN Marks BETWEEN 80 AND 89 THEN 9
        WHEN Marks BETWEEN 90 AND 100 THEN 10 
    END AS Grade
    FROM Students
)
SELECT 
    CASE 
        WHEN Grade < 8 THEN NULL 
        ELSE Name 
    END AS Name,
    Grade,
    Marks
FROM cte
ORDER BY Grade DESC, Name ASC, Marks ASC;
