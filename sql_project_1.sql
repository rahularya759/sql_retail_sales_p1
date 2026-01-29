SELECT * FROM sql_project.projectsql
where ï»¿transactions_id is null
limit 10
-- data cleaning 
select count(*) from sql_project.projectsql

SELECT * FROM sql_project.projectsql
where ï»¿transactions_id is null

SELECT * FROM sql_project.projectsql
where sale_date is null

SELECT * FROM sql_project.projectsql
where sale_time is null

SELECT * FROM sql_project.projectsql
where customer_id is null

-- instead of checking line by line ,we can check all columns at a time ,by writing the following code
SELECT * FROM sql_project.projectsql
where 
    ï»¿transactions_id is null
    or 
    sale_date is null
    or
     customer_id is null
     or 
    gender is null
    or 
    category is null
    or 
    quantiy is null
    or 
    cogs is null
    or
    total_sale is null
    
    -- data exploration
    -- how many sales we have?
    select count(*) from sql_project.projectsql
    
   -- how many customer we have?
     select count(customer_id) from sql_project.projectsql
     
     -- knowing how many category ,from the output we got : clothing,beauty,electronics
	select distinct category from sql_project.projectsql
    
    -- data analysis and business key problems and answers
    -- q1.write a sql query to retrive all coloumns for sales made on 2022-11-05
    select * from sql_project.projectsql
    where sale_date='2022-11-05'
    
    -- q2.write a sql query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in 
    -- month of nov-2022
     select
    *
     from sql_project.projectsql
     where category ='clothing'
     and date_format(sale_date,'%Y-%m') = '2022-11'
     and 
     quantiy>=4
     
     -- q3.write a sql query to calculate the total sales(total_sale) for each category.
      select
			  category,
              sum(total_sale)
     from sql_project.projectsql
     group by category
  
-- q4.write a sql query to find the average age of customers who purschased items from  the 'beauty' category.
 select
      category,
     round ( avg(age),2) as average_age
from sql_project.projectsql
where category ='beauty'
group by category

-- q5.write a sql query to find all transaction where the total_sales is greater than 1000.

select
*
from sql_project.projectsql
where total_sale >1000    
    
-- q5 write a sql query to find the total number of transaction (transaction_id) made by each gender in each category.    
   select
gender,category,
count(*) as total_transaction
from sql_project.projectsql
group by gender,category    
    

-- q6 write a sql query to calculate  the average sale for each month .find out best selling month in each year.

 select * from(
				select
				year(sale_date) as years,
				month(sale_date)  as months,
				avg(total_sale) as avg_sale,
				rank() over(partition by year(sale_date)  order by avg(total_sale)  desc ) as ranks
				from sql_project.projectsql 
				group by  year(sale_date),month(sale_date)
                
	) as t3
where ranks =1
    
-- q7 write a sql query to find the top 5 customers based on the highest total sales.    
    
    select 
    customer_id,
    sum(total_sale) as total_sales
    
    from sql_project.projectsql
    group by customer_id
    order by sum(total_sale) desc
 limit 5
 
 -- q8. write a sql query to find the number of unique customers who purchased items from each category.
    
    select 
    category,
	count(distinct customer_id) as unique_customer
    from sql_project.projectsql
    group by category
    
-- q.10.write a sql query to create each shift and number of orders(Example morning  <=12 , Afternoon BEtween 12 & 17 , evening  > 17).
    select *,
    case 
			when hour(sale_time)< 12 then 'morning '
			when hour(sale_time) between 12 and 17 then 'afternoon'
            else 'night'
			end as shift
           
    from  sql_project.projectsql
 
    
    
    -- for each shift and number of orders
       select 
    case 
			when hour(sale_time)< 12 then 'morning '
			when hour(sale_time) between 12 and 17 then 'afternoon'
            else 'night'
			end as shift,
            count(*) as total_orders
    from  sql_project.projectsql
    group by shift
    
    
    
    
    
    
    
    
    
    