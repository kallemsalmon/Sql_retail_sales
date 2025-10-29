---CREATE TABLE
CREATE TABLE Retail_sales(
            transactions_id INT PRIMARY KEY,
            sale_date	DATE,
            sale_time  TIME,
            customer_id INT,
            gender	VARCHAR(15),
            age	    INT,
            category VARCHAR(15),
            quantiy   INT,
            price_per_unit FLOAT,
            cogs	FLOAT ,
            total_sale float
            );

select count(*) 
from retail_sales;
use sql_prooject_p1;

select * from retail_sales

select * 
from retail_sales
limit 10;

--Data cleaning process
select * 
from 	
retail_sales
where
transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
gender is null
or
category is null
or 
quantiy is null
or
cogs is null
or 
total_sale is null;

----

delete from retail_sales
where
transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
gender is null
or
category is null
or 
quantiy is null
or
cogs is null
or 
total_sale is null;


--- data exploration

---how many sales we have?

select count(*) as Total_sales
from 
retail_sales;

-- how many unique customers we have?

select count( distinct customer_id) as customers
from
retail_sales;

-- how many unique categroy we have?

select count( distinct category) as unq_category
from
retail_sales;

-- names of the categories?

select  distinct category as unq_category
from
retail_sales;

---Data analysis & business key problems & answers

select * from retail_sales

--Q. 1 write a sql query to retrieve all columns from sales made on 2022-11-05?

select * 
from 
       retail_sales
where
       sale_date = '2022-11-05';


--Q.2 write a sql query to retrieve all transactions where the category is 'clothing' and 
-- the quantity sold is more then 10 in  month of nov-2022?

select 
*from  retail_sales
where category = 'Clothing'
and 
to_char(sale_date, 'YYYY-MM')='2022-11'
AND
quantiy >=4

--3Q.write a sql query to calculate the total sales (total_sales) for each category?

select category,
       sum(total_sale) as Total_sale,
	   count(*) as total_orders
from retail_sales
group by category;


--4Q write a sql query to find the average age of customers who purchased items from  the 'beauty' catregory.

select ROUND(AVG(age),2) as average_age
from retail_sales
where category='Beauty'

--5Q Write a sql query to find all transactions where the total_sale is greater than 1000.

select
*
from retail_sales
where total_sale > 1000

--6Q Write a Sql query to find the total number of transaction (transaction_id) made each gender in each category.

select 
   category, 
   gender,
   count(*) as total_trans
from retail_sales
group
by category, gender
order by 1

--7Q Write a sql query to calculate the average sale for each month. find out best selling month in each year

SELECT year,
     month,
	 avg_sale
 from

(select 
EXTRACT(YEAR FROM  sale_date) as year,
EXTRACT(MONTH FROM sale_date) as month,
avg(total_Sale) as avg_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_Sale) DESC ) AS RANK
from retail_sales
group by 1,2
)
 AS T1
where rank = 1

--8Q Write a sql query to find the top 5 customers based  on the highest total sales

select customer_id,
sum(total_sale) as sale

from retail_sales
group by 1
order by 2 desc
limit 5

--9Q Write a sql query to find the number of unique customers who purchased items from each category.


select category, 
       count(distinct customer_id) as cnt_unique_sc
from retail_sales
group by 1

--10Q Write a sql query to create each shift and  number of orders ( example morning <=12, afternoon between 12 & 17,evening>17)


With hourly_sale
As
(
select *, 
         CASE
		 WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN  12 AND 17 THEN 'Afternoon'
		 ELSE 'Evening'
		 END AS shift
		 
from retail_sales
)

select shift,
count(*)
as total_orders
from hourly_sale
group by shift

--end of project
