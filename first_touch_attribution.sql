WITH conv AS (
    SELECT us.user_id
    FROM attribution AS a
    INNER JOIN user_sessions AS us 
        ON a.session_id = us.session_id
    WHERE conversion = 1
    GROUP BY 1 -- group by to get distinct user_ids
),

-- get the first session by user_id and created_at time. 
first_session AS (
    SELECT 
        min(us.created_at) AS min_created_at
        , conv.user_id
    FROM user_sessions AS us
    INNER JOIN conv 
        ON us.user_id = conv.user_id
    INNER JOIN attribution AS a 
        ON a.session_id = us.session_id
    GROUP BY conv.user_id
)

-- join user_id and created_at time back to the original table.
SELECT us.user_id, channel
FROM attribution
JOIN user_sessions AS us 
    ON attribution.session_id = us.session_id
-- now join the first session to get a single row for each user_id
JOIN first_session
-- double join 
    ON first_session.min_created_at = us.created_at 
        AND first_session.user_id = us.user_id
