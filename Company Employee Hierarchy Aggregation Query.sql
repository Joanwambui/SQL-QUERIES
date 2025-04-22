SELECT c.company_code, c.founder, COUNT(DISTINCT l.lead_manager_code), COUNT(DISTINCT s.senior_manager_code),
COUNT(DISTINCT m.manager_code), COUNT(DISTINCT e.employee_code)
FROM Company c
JOIN Lead_Manager l
ON c.company_code = l.company_code
JOIN Senior_Manager s
ON l.company_code = s.company_code
JOIN Manager m
ON s.company_code = m.company_code
JOIN Employee e
ON m.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY company_code


  
'''
Company: The company_code is the code of the company and founder is the founder of the company.

Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company.

Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.

Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.

Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.

Sample Input

Company Table:Lead_Manager Table:Senior_Manager Table:Manager Table:Employee Table:

Sample Output

C1 Monika 1 2 1 2
C2 Samantha 1 1 2 2
'''
