-- Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

select count(distinct user_id) as active_users, activity_date as day from Activity group by activity_date having activity_date>='2019-06-28' and activity_date<='2019-07-27'
