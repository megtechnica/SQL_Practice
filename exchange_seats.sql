-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.

SELECT CASE
           WHEN s.id % 2 <> 0 AND s.id = (SELECT COUNT(*) FROM Seat) THEN s.id
           WHEN s.id % 2 = 0 THEN s.id - 1
           ELSE
               s.id + 1
           END AS id,
       student
FROM Seat AS s
ORDER BY id
