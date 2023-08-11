-- write a sql query to output the average number of right swipes for two different variants of a feed ranking
-- algorithm by comparing users tht have swiped 10, 50 and 100 swipes.

WITH swipe_ranks AS (
    SELECT 
        swipes.user_id
        , variant
        , RANK() OVER (
            PARTITION BY user_id ORDER BY created_at ASC
        ) AS ranks
        , is_right_swipe
    FROM swipes
    INNER JOIN variants 
        ON swipes.user_id = variants.user_id
    WHERE experiment = 'feed_change'
)

SELECT 
    variant
    , CAST(SUM(is_right_swipe) AS DECIMAL)/COUNT(DISTINCT sr.user_id) AS mean_right_swipes
    , 10 AS swipe_threshold
    , COUNT(DISTINCT sr.user_id) AS num_users
FROM swipe_ranks AS sr
INNER JOIN (
    SELECT user_id
    FROM swipe_ranks
    WHERE ranks >= 10
    GROUP BY 1
) AS subset 
    ON subset.user_id = sr.user_id
WHERE ranks <= 10
GROUP BY 1

UNION ALL

SELECT 
    variant
    , CAST(SUM(is_right_swipe) AS DECIMAL)/COUNT(DISTINCT sr.user_id) AS mean_right_swipes
    , 50 AS swipe_threshold
    , COUNT(DISTINCT sr.user_id) AS num_users
FROM swipe_ranks AS sr
INNER JOIN (
    SELECT user_id
    FROM swipe_ranks
    WHERE ranks >= 50
    GROUP BY 1
) AS subset 
    ON subset.user_id = sr.user_id
WHERE ranks <= 50
GROUP BY 1

UNION ALL

SELECT 
    variant
    , CAST(SUM(is_right_swipe) AS DECIMAL)/COUNT(DISTINCT sr.user_id) AS mean_right_swipes
    , 100 AS swipe_threshold
    , COUNT(DISTINCT sr.user_id) AS num_users
FROM swipe_ranks AS sr
INNER JOIN (
    SELECT user_id
    FROM swipe_ranks
    WHERE ranks >= 100
    GROUP BY 1
) AS subset 
    ON subset.user_id = sr.user_id
WHERE ranks <= 100
GROUP BY 1
