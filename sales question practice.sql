-- 1. Display all records.

select * from sales;

-- 2.Show only Sales_Rep, Region, and Sales_Amount.
select sales_rep,region, sales_amount from sales;

-- 3.Find total number of sales.
select count(product_id) from sales;

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
select distinct(count(Sales_Rep)) as total_sales from sales;

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
select sales_rep, sum(sales_amount) from sales
group by Sales_Rep
order by sum(sales_amount) desc;

-- 15.Find total discount given by each region.
select region, sum(discount) from sales
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
select region, avg(discount)*100 from sales
group by region;

-- 23.Find the number of products sold in each category.
select product_category,sum(quantity_sold) from sales
group by product_category;

-- 24.Find the top-selling product category based on sales amount.
select product_category ,sum(sales_amount) from sales
group by product_category
order by sum(sales_amount) desc;

-- 25.Find the top 3 sales representatives in each region
select  sales_rep,region ,sum(sales_amount) from sales
group by sales_rep,region
order by sum(sales_amount) desc
limit 3;

-- 26.Rank sales representatives based on total sales.

SELECT
    sales_rep,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT
        sales_rep,
        SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY sales_rep
) AS t;

-- 27.Find the percentage contribution of each region to total sales.

select Region,(sum(Sales_Amount)/(SELECT SUM(Sales_Amount) FROM sales))*100 from sales
group by region;

-- 28.Find the cumulative monthly sales.
SELECT
    MONTHNAME(sale_date) AS Month,
    SUM(sales_amount) AS Monthly_Sales,
    SUM(SUM(sales_amount)) OVER (
        ORDER BY MONTH(sale_date)
    ) AS Cumulative_Sales
FROM sales
GROUP BY MONTH(sale_date), MONTHNAME(sale_date)
ORDER BY MONTH(sale_date);

-- 29.Find the month with the highest sales.

select month(sale_date),monthname(sale_date),sum(sales_amount) from sales
group by month(sale_date),monthname(sale_date)
order by sum(sales_amount) desc ;

-- 30.Which sales representative generated the highest revenue in each region?
 SELECT
    Region,
    Sales_Rep,
    Total_Sales
FROM (
    SELECT
        Region,
        Sales_Rep,
        SUM(Sales_Amount) AS Total_Sales,
        RANK() OVER (
            PARTITION BY Region
            ORDER BY SUM(Sales_Amount) DESC
        ) AS rnk
    FROM sales
    GROUP BY Region, Sales_Rep
) t
WHERE rnk = 1;
 
 -- 31.Which product category has the highest profit?
 
 select product_category,max((Unit_Price - Unit_Cost) * Quantity_Sold) as highest_revenue from sales
 group by product_category
 order  by max((Unit_Price - Unit_Cost) * Quantity_Sold);
 
 
 
 -- 32.Which payment method contributes the highest revenue?
 select payment_method,sum(sales_amount) as highest_revenue from sales
 group by payment_method
 order  by sum(sales_amount) desc;
 
 -- 33.Which customer type receives the highest average discount?
 select customer_type,avg(discount)*100 from sales
group by customer_type
order by avg(discount) desc;

-- 34.Which sales channel generates more revenue: Online or Retail?
select sales_channel ,sum(Sales_Amount) from sales
group by sales_channel;

-- 35.Find the top 10 most profitable transactions.
select  
Product_ID,
    Sale_Date,
    Sales_Rep,
    Region,payment_method,sum((unit_price-unit_cost)*quantity_sold) from sales
group by Product_ID,
    Sale_Date,
    Sales_Rep,
    Region,payment_method
order by sum((unit_price-unit_cost)*quantity_sold)desc
limit 10;

-- 36.Calculate profit margin (%) for each product category
select product_category,(sum((unit_price-unit_cost)*quantity_sold)/(select sum(Sales_Amount) from sales))*100 from sales
group by product_category;

-- 37.Compare sales before and after discounts.
SELECT
    SUM(Sales_Amount) AS Sales_Before_Discount,
    SUM(Sales_Amount * (1 - Discount)) AS Sales_After_Discount
FROM sales;


select * from sales;

-- 38. Find the top-performing sales representative every month using window functions

select months,
sales_rep,
Total_Sales from
 (select month(sale_date) as Months, sales_rep, sum(sales_amount) as Total_Sales,
rank() over (partition by month(sale_date) order by sum(sales_amount) desc) as rnk from sales
group by month(sale_date), sales_rep) t where rnk = 1;

-- 39.Month-over-Month Growth %.
WITH monthly_sales AS (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        MONTHNAME(sale_date) AS month_name,
        SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY YEAR(sale_date), MONTH(sale_date), MONTHNAME(sale_date)
)

SELECT
    year,
    month_name,
    total_sales,
    LAG(total_sales) OVER (ORDER BY year, month) AS previous_month_sales,

    ROUND(
        (
            (total_sales - LAG(total_sales) OVER (ORDER BY year, month))
            / LAG(total_sales) OVER (ORDER BY year, month)
        ) * 100,
        2
    ) AS mom_growth_percentage

FROM monthly_sales
ORDER BY year, month;

-- 40. Running Profit
SELECT
    sale_date,
    Daily_Profit,
    SUM(Daily_Profit) OVER (
        ORDER BY sale_date
    ) AS Running_Profit
FROM (
    SELECT
        sale_date,
        SUM((unit_price - unit_cost) * quantity_sold) AS Daily_Profit
    FROM sales
    GROUP BY sale_date
) AS t
ORDER BY sale_date;
