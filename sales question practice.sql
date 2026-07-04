-- 1. Display all records.

select * from sales;

-- 2.Show only Sales_Rep, Region, and Sales_Amount.
select sales_rep,region, sales_amount from sales;

-- 3.Find total number of sales.
select count(*) from sales;

-- 4.Find total sales amount.
select sum(sales_amount) from sales;

-- 5.Find average sales amount.
select avg(sales_amount) from sales;

-- 6.Find maximum and minimum sales amount.
select max(sales_amount),min(sales_amount) from sales;

-- 7.Count sales by region.
select  region,count(*) as total_sales 
from sales
group by region;

-- 7.Count sales by product category.
select  product_category,count(*) as total_sales from sales
group by product_category;


-- 8.Count unique sales representatives
select distinct(count(*)) as total_sales from sales;

-- 9.Display all sales where Sales_Amount > 5000.
select * from sales
where sales_amount>5000;

-- 10.Find total sales by region.
select region,sum(sales_amount) from sales
group by region;

-- 11.Find average sales by product category.
select product_category,avg(sales_amount) from sales
group by product_category;

-- 12.Find total quantity sold by each sales representative.
select sales_rep,sum(quantity_sold) from sales
group by sales_rep;

-- 13.Find the top 5 highest sales.
select sales_amount from sales
order by sales_amount desc
limit 5;

-- 14.Find the sales representative with the highest total sales
select sales_rep, sales_amount from sales
order by sales_rep desc;

-- 15.Find total discount given by each region.
select region, count(discount) from sales
 group by region;
 
 -- 16.Find average unit price by product category.
 select product_category,avg(unit_price) from sales
 group by product_category;
 
 -- 17.Find monthly sales.
select distinct(month(sale_date)), monthname(sale_date),sum(sales_amount) from sales
group by month(sale_date),monthname(sale_date) order by  month(sale_date) asc;

-- 18.Find yearly sales.
select distinct(year(sale_date)),sum(sales_amount) from sales
group by year(sale_date) order by  year(sale_date) asc;

-- 19.Find total sales by customer type.
select  customer_type, sum(sales_amount) from sales
group by customer_type;

-- 20.Find total sales by payment method.
select payment_method ,sum(sales_amount) from sales 
group by payment_method;

-- 21.Find total sales through each sales channel.
select sales_channel,sum(sales_amount) from sales
group by sales_channel;

-- 22.Find region-wise average discount.
select region,avg(discount) from sales
group by region;

-- 23.Find the number of products sold in each category.
select product_category,count(quantity_sold) from sales
group by product_category;

-- 24.Find the top-selling product category based on sales amount.
select product_category ,max(sales_amount) from sales
group by product_category
order by product_category asc;

-- 25.Find the top 3 sales representatives in each region
select  sales_rep,region ,sum(sales_amount) from sales
group by sales_rep,region
order by sum(sales_amount) desc
limit 3;

-- 26.Rank sales representatives based on total sales.
select sales_rep,sum(sales_amount) from sales
group by sales_rep
order by sum(sales_amount) desc;

-- 27.Find the percentage contribution of each region to total sales.
select region,sum(sales_amount) from sales
group by region;

-- 28.Find the cumulative monthly sales.
select distinct(month(sale_date)),monthname(sale_date),sum(sales_amount) from sales
group by (month(sale_date)),monthname(sales_date)
order by month(sales_date);

-- 29.Find the month with the highest sales.

select distinct(month(sale_date)),monthname(sale_date),max(sales_amount) from sales
group by (month(sale_date)),monthname(sale_date)
order by month(sale_date);

-- 30.Which sales representative generated the highest revenue in each region?
 select sales_rep,region,max(sales_amount) from sales
 group by sales_rep,region
 order by max(sales_amount) desc;
 
 -- 31.Which product category has the highest profit?
 
 select product_category,max((Unit_Price - Unit_Cost) * Quantity_Sold) as highest_revenue from sales
 group by product_category
 order  by max((Unit_Price - Unit_Cost) * Quantity_Sold);
 
 -- 32.Which payment method contributes the highest revenue?
 select payment_method,max((Unit_Price - Unit_Cost) * Quantity_Sold) as highest_revenue from sales
 group by payment_method
 order  by max((Unit_Price - Unit_Cost) * Quantity_Sold) desc;
 
 