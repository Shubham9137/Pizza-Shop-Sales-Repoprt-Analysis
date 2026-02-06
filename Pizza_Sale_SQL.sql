DROP TABLE pizza_table;

CREATE TABLE pizza_sales(
	pizza_id INT PRIMARY KEY,
	order_id INT,	
	pizza_name_id VARCHAR(80),
	quantity INT,
	order_date	DATE,
	unit_price	FLOAT,
	total_price	FLOAT,
	pizza_size	VARCHAR(10),
	pizza_category 	VARCHAR(50),
	pizza_ingredients	VARCHAR(200),
	pizza_name VARCHAR(100)
);

SELECT * FROM pizza_sales;

-- Reports & Data Analysis

--Key Performance Indicator Analysis
-- Q.1 Total Revenue

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;


--Q.2 Average Order Value

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

--Q.3 Total Pizzas Sold

SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;
	
--Q.4 Total Orders
	
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;
	
--Q.5 Average Pizzas Per Order
	
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
	CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
	AS Avg_Pizzas_per_order
	FROM pizza_sales;
	
--B. Daily Trend for Total Orders

	
SELECT TO_CHAR(order_date, 'DAY') AS order_day, COUNT(DISTINCT order_id) AS total_orders 
	FROM pizza_sales
	GROUP BY TO_CHAR(order_date, 'DAY');


--C. Monthly Trend for Orders

select TO_CHAR(order_date, 'MONTH') as Month_Name, COUNT(DISTINCT order_id) as Total_Orders
	from pizza_sales
	GROUP BY TO_CHAR(order_date, 'MONTH');

--D. % of Sales by Pizza Category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
	FROM pizza_sales
	GROUP BY pizza_category;

--E. % of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
	FROM pizza_sales
	GROUP BY pizza_size
	ORDER BY pizza_size;

--F. Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
	FROM pizza_sales
	WHERE EXTRACT(MONTH FROM order_date) = 2
	GROUP BY pizza_category
	ORDER BY Total_Quantity_Sold DESC;

--G. Top 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS Total_Revenue
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Revenue DESC
	LIMIT 5;

--H. Bottom 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS Total_Revenue
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Revenue ASC
	LIMIT 5;

--I. Top 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Pizza_Sold DESC
	LIMIT 5;

--J. Bottom 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Pizza_Sold ASC
	LIMIT 5;

--K. Top 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Orders DESC
	LIMIT 5;

--L. Borrom 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Orders ASC
	LIMIT 5;

