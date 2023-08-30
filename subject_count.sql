-- Write a solution to calculate the number of unique subjects each teacher teachers in the university

select count(distinct subject_id) as cnt, teacher_id from Teacher group by teacher_id;
