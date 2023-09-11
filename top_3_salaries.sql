-- write a solution to find the employees who are high earners in each of the departments

select t.d_name as department,
t.e_name as employee,
t.Salary from (
  select e.name as e_name,
  e.salary,
  d.name as d_name,
  dense_rank() over (partition by departmentid order by salary desc)
  as row_num
  from employee as e inner join department as d on e.departmentid = d.id
) t
where row_num <= 3
