WITH added_previous_role AS (
  SELECT user_id, position_name,
  LAG (position_name) 
  OVER (PARTITION BY user_id) 
  AS previous_role
  FROM user_experiences
),
 
experienced_subset AS (
  SELECT *
  FROM added_previous_role
  WHERE position_name = 'Data Scientist' 
    AND previous_role = 'Data Analyst'
)
 
SELECT COUNT(DISTINCT experienced_subset.user_id)/
     COUNT(DISTINCT user_experiences.user_id) 
AS percentage
FROM user_experiences
LEFT JOIN experienced_subset 
    ON user_experiences.user_id = experienced_subset.user_id
