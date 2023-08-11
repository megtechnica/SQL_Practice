-- write a query to get the total three-day rolling average for deposits by day

WITH valid_transactions AS (
   SELECT DATE_FORMAT(created_at, '%Y-%m-%d') AS dt
       , SUM(transaction_value) AS total_deposits
   FROM bank_transactions AS bt
   WHERE transaction_value > 0
   GROUP BY 1
)

SELECT vt2.dt,
   AVG(vt1.total_deposits) AS rolling_three_day
FROM valid_transactions AS vt1
INNER JOIN valid_transactions AS vt2
   -- set conditions for greater than three days
   ON vt1.dt > DATE_ADD(vt2.dt, INTERVAL -3 DAY)
   -- set conditions for max date threshold
       AND vt1.dt <= vt2.dt
GROUP BY 1
