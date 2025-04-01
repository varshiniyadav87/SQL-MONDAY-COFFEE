-- QUESTION 1 Coffee Consumers 
-- Count How many people in each city are estimated to consume coffee, given that 25% of the population does?

SELECT 
	city_name,
    round((population*0.25)/1000000,2) as coffee_customers, 
    city_rank
FROM city
ORDER BY 2 DESC
LIMIT 5;


-- QUESTION 2 Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

SELECT c.city_name,SUM(total) as total_revenue
FROM sales as s
JOIN customers as cus 
on s.customer_id=cus.customer_id
JOIN city as c 
ON cus.city_id=c.city_id
WHERE YEAR(sale_date)=2023
AND MONTH(sale_date) IN (9,10,11,12)
GROUP BY c.city_name;


-- QUESTION 3 Sales Count for Each Product
-- How many units of each coffee product have been sold?

select p.product_name,count(s.sale_id) as total_orders
from products as p
left join sales as s
on s.product_id=p.product_id
group by p.product_name;


-- QUESTION 4 Average Sales Amount per City
-- What is the average sales amount per customer in each city?

select ci.city_name,round(avg(s.total),2) as average_sales
from sales as s 
join customers as c 
on s.customer_id=c.customer_id
join city as ci
on c.city_id=ci.city_id
group by ci.city_name;


-- QUESTION 5  City Population and Coffee Consumers
-- Provide a list of cities along with their populations and estimated coffee consumers.

select c.city_name,c.population,count(c.city_id) as coffee_consumers
from city as c
join customers as cu
on c.city_id=cu.city_id
group by c.city_name,c.population;

