
-- write a solution to report the customer ids from the customer table that 
-- bought all the products in the product id table

select customer_id from customer group by customer_id having 
count(distinct product_key) = (select count(*) from product)
