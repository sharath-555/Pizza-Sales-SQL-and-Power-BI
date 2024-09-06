--PART 1 CALCULATE KPI'S FOR THE PIZZA SALES DB

-- Find out the total revenue of the pizzas sold
select round(sum(total_price),2) as Total_revenue
from pizza_sales

--Find out the average order value
select round(sum(total_price)/count(distinct order_id),2) as Average_order_value
from pizza_sales

--Total Pizza Sold 
select sum(quantity) as Total_pizzas_sold
from pizza_sales

--findout total orders placed
select count(distinct order_id) as total_orders
from pizza_sales

-- Average pizzas per order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_pizza_per_order
from pizza_sales

-- PART 2 GENERATE CHARTS FROM THE PIZZA SALES DB

--Daily trend for Total orders
select datename(dw,order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by datename(dw,order_date)

--Monthly trend of total orders
select datename(month,order_date) as order_month, count(distinct order_id) as Total_orders
from pizza_sales
group by datename(month,order_date), month(order_date)
order by month(order_date)

--Percentage of sales by category for month of january
select pizza_category, round(sum(total_price)*100/ 
(select sum(total_price) from pizza_sales where month(order_date) = 1),2) as percentage_of_total_sales
from pizza_sales
where month(order_date) = 1
group by pizza_category

--Percentage of sales by pizza_size for 1 st quater
select pizza_size, round(sum(total_price)*100/
(select sum(total_price) from pizza_sales where datepart(quarter,order_date) = 1),2) as PCT
from pizza_sales
where datepart(quarter,order_date) = 1
group by pizza_size
order by PCT desc

-- top and bottom 5 sellers of revenue, total quatity and total orders
select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc

select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc

select top 5 pizza_name,sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc

select top 5 pizza_name,sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity asc

select top 5 pizza_name,count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc

select top 5 pizza_name,count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders asc
