WITH employee_ranks AS(
  SELECT
    department_id,
    first_name,
    last_name,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS ranks
  FROM employees
 
)
 
SELECT
  CONCAT(er.first_name,' ', er.last_name) AS employee_name,
  d.name AS department_name,
  salary
FROM employee_ranks er
LEFT JOIN departments d ON d.id=er.department_id
WHERE ranks < 4
ORDER BY department_name ASC, salary DESC

