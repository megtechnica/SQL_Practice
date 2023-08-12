WITH purchases AS (
    SELECT  
       user_id
       , created_at
       , products.name 
FROM transactions 
JOIN products 
    ON transactions.product_id = products.id 
)
SELECT 
   t1.name AS p1
   , t2.name AS p2
   , count(*) as qty
FROM purchases AS t1 
JOIN purchases AS t2 
   ON t1.user_id = t2.user_id 
      AND t1.name < t2.name
      AND t1.created_at = t2.created_at
GROUP BY 1,2 ORDER BY  3 DESC, 2 ASC
LIMIT 5
