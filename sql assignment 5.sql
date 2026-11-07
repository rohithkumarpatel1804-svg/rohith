CREATE TABLE analytical_sales (
    transaction_id   INT PRIMARY KEY,
    product_category VARCHAR(30),
    units_sold       INT,
    total_revenue    DECIMAL(8,2)
);
INSERT INTO analytical_sales VALUES
(1, 'Electronics', 2, 1199.98),
(2, 'Apparel', 5, 125.00),
(3, 'Electronics', 1, 45.00),
(4, 'Home Goods', 3, 270.00),
(5, 'Apparel', 1, 45.00),
(6, 'Electronics', 4, 2400.00);

-- 1) Calculating Global Sales Metrics using aggregate function
select sum(total_revenue) as gross_revenue,
 avg(total_revenue) as average_order_value,
COUNT(*) AS total_transactions,
min(total_revenue) as cheapest_sale,
max(total_revenue) as expensive_sale
from analytical_sales;

--2)Counting Distinct Categories using count
select count(distinct product_category) as unique_categories 
from analytical_sales;

--3) Segment Revenue Using GROUP BY
SELECT
    product_category,
    SUM(total_revenue) AS category_revenue,
	SUM(units_sold) AS total_units
FROM
    analytical_sales
GROUP BY
    product_category;

--4) Ranking Categories by Revenue
select 
product_category, 
sum (total_revenue) as highest_revenue
from analytical_sales
group by product_category
order by  highest_revenue asc;

--5) Filtering Individual Records Using WHERE
select * from analytical_sales
where units_sold > 1;

--6) Filtering Aggregated Results Using HAVING
select product_category,
sum(total_revenue) as gross_revenue
from analytical_sales
group by product_category
having sum(total_revenue) > 300
order by gross_revenue desc;

--7) Combining WHERE, GROUP BY, and HAVING
SELECT
    product_category,
    SUM(total_revenue) AS filtered_category_revenue
FROM
    analytical_sales
WHERE
    units_sold > 1
GROUP BY
    product_category
HAVING
    SUM(total_revenue) > 250;

--8) SQL Logical Execution Order

SELECT
    product_category,
    SUM(total_revenue) AS filtered_category_revenue
FROM
    analytical_sales
WHERE
    units_sold > 1
GROUP BY
    product_category
HAVING
    SUM(total_revenue) > 250
ORDER BY filtered_category_revenue DESC
LIMIT 2;

--9)CorrectING an Aggregation Error
--  column "analytical_sales.transaction_id" must appear in the GROUP BY clause or be used in an aggregate function
SELECT
    product_category,
    transaction_id,
    SUM(total_revenue) AS category_revenue
FROM analytical_sales
GROUP BY product_category,
  transaction_id;





