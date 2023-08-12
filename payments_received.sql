WITH cte_transform_payments AS 
(
 SELECT sender_id AS ID,created_at as tran_date,payment_state, ABS(amount_cents) AS amount_cents, 1 AS s_r FROM payments
 UNION ALL 
 SELECT recipient_id AS ID,created_at as tran_date,payment_state, ABS(amount_cents) AS amount_cents , 0 AS s_r FROM payments
),
cte_time_differences AS (
 SELECT a.*,b.created_at AS user_reg_date, DATEDIFF(tran_date,b.created_at) AS date_diff FROM cte_transform_payments a
 JOIN users b on a.ID = b.id
),
cte_data_filtering AS (
 SELECT * FROM cte_time_differences 
 WHERE user_reg_date>='2020-01-01 00:00:00' AND user_reg_date<'2020-01-31 00:00:00' 
  AND date_diff >= 0 AND date_diff <= 30 AND payment_state = 'success'
),
cte_grouping AS (
 SELECT id , SUM(amount_cents) FROM cte_data_filtering  
 GROUP BY id  
 HAVING SUM(amount_cents) > 10000
) 
SELECT COUNT(*) AS num_customers FROM cte_grouping
