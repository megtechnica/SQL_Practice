-- write a solution to:
-- find the name of the user who has rated the greatest number of movies.  in case of a tie, return the 
-- lexicography smaller user name
-- find the movie name with the hidhest rating in february 2-2-/  in case of a tie, return the lexicography smaller movie name.


SELECT DISTINCT FIRST_VALUE(u.name) OVER(ORDER BY COUNT(r.movie_id) DESC, u.name ASC) AS results
FROM Users AS u LEFT JOIN MovieRating AS r
ON u.user_id=r.user_id
GROUP BY u.user_id
UNION ALL
SELECT DISTINCT FIRST_VALUE(m.title) OVER(ORDER BY AVG(r.rating) DESC, m.title ASC) AS results
FROM Movies AS m join MovieRating AS r
ON m.movie_id=r.movie_id
WHERE r.created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY m.movie_id
