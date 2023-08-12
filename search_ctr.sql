WITH ratings AS (
    SELECT query
        , SUM(CASE WHEN 
                rating <= 1 THEN 1 ELSE 0 
            END) AS num_results_rating_one
        , SUM(CASE WHEN 
                rating <= 2 THEN 1 ELSE 0 
            END) AS num_results_rating_two
        , SUM(CASE WHEN 
                rating <= 3 THEN 1 ELSE 0 
            END) AS num_results_rating_three
        , COUNT(*) AS total_results
    FROM search_results
    GROUP BY 1
) 

SELECT
    CASE 
        WHEN total_results - num_results_rating_one = 0 
            THEN 'results_one'
        WHEN total_results - num_results_rating_two = 0 
            THEN 'results_two'
        WHEN total_results - num_results_rating_three = 0 
            THEN 'results_three'
    END AS ratings_bucket
    , SUM(has_clicked)/COUNT(*) AS ctr
FROM search_events AS se 
LEFT JOIN ratings AS r
    ON se.query = r.query
GROUP BY 1
