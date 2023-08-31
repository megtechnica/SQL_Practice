-- Write a solution to select the product id, year, quantity, and price for the first year of every product sold.


select product_id, year as first_year, quantity, price From Sales where (product_id, year) in (select product_id, MIN(year) from sales group by product_id)
