-- write a sql query that creates a cumulative distribution of the number of comments per user.
-- 

WITH hist AS (
    SELECT users.id, COUNT(c.user_id) AS frequency
    FROM users
    LEFT JOIN comments as c
        ON users.id = c.user_id
    GROUP BY 1
),

freq AS (
    SELECT frequency, COUNT(*) AS num_users
    FROM hist
    GROUP BY 1
)

SELECT f1.frequency, SUM(f2.num_users) AS cum_total
FROM freq AS f1
LEFT JOIN freq AS f2
    ON f1.frequency >= f2.frequency
GROUP BY 1
