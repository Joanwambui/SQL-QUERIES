SELECT company, ROUND(CAST(employees_fired AS DECIMAL) / company_size * 100, 2) AS Percentage_Laid_Off
FROM tech_layoffs
ORDER BY company ASC;