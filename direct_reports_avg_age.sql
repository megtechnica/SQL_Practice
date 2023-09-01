-- write a sql query to report the ids and the names of all managers, the number of employees
-- who report directly to them and the average age of the reports rounded to the nearest integer

select e1.employee_id, e1.name, 
count(*) as reports_count, 
round(avg(e2.age)) as average_age
from employees e2 inner join employees 
e1 on e2.reports_to = e1.employee_id
group by e1.employee_id, 
e1.name
order by e1.employee_id
