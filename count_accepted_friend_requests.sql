-- find the people who have the most friends and the most friends number.  

with friends as (select requester_id id from RequestAccepted union all select accepter_id id from RequestAccepted) select id, count(*) num from friends group by 1 order by 2 desc limit 1
