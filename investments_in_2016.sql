-- write a solution to report the sum of all total investment values in 2016 "tiv_2016" for all policyholders who:
-- have the same "tiv_2015" value as one or more other policyholders and 
-- are not located in the same city as any other policyholder

select round(sum(tiv_2016), 2) as tiv_2016 From insurance
where pid not in 
(select a.pid from insurance a inner join insurance b on (a.lat, a.lon) =(b.lat, b.lon) where
a.pid <> b.pid) 
and 
tiv_2015 in 
(select tiv_2015 from insurance group by tiv_2015 having count(pid)> 1)
