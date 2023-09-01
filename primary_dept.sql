-- write a query to report all the employees with their primary department.
-- for employees who belong to one department, report their only department

select employee_id, department_id from employee group by employee_id having count(employee_id)=1 
union 
select employee_id, department_id from employee where primary_flag='Y'
