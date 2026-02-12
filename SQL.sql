-- Zepto E-Commerce Inventory Analysis Using SQL

create table zepto (
sku_id INT PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INT,
outOfStock VARCHAR(10) ,	
quantity INT
);



-- Count total records in the dataset.
select count(*) from zepto;



-- View sample records.
select * from zepto
limit 10;



-- Different product categories.
SELECT DISTINCT category
FROM zepto
ORDER BY category;



-- Products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;



-- Product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;



##
-- Data cleaning
##



-- 	View and Remove rows where price is zero. (missing data)
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;



-- Remove
DELETE FROM zepto
WHERE mrp = 0;



-- Convert paise to rupees. (originally in Paise)
UPDATE zepto
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;


-- Check
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;



##
-- Data Analysis
##



-- Q1. Find the top 10 best value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;



-- Q2. What are the Products with High MRP but Out of Stock.
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = 'TRUE' and mrp > 300
ORDER BY mrp DESC;



-- Q3. Calculate Estimated Revenue for each category.
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;



-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;



-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;



-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;



-- Q7. Group the products into categories like small, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'small'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;



-- Q8. Top categories by inventory value.
SELECT category,
ROUND(SUM(discountedSellingPrice * availableQuantity),2) AS inventory_value
FROM zepto
WHERE outOfStock = 'FALSE'
GROUP BY category
ORDER BY inventory_value DESC;



-- Q9. Which categories are at highest risk of stockout?
SELECT category, COUNT(*) AS total_products,
SUM(CASE WHEN outOfStock = 'TRUE' THEN 1 ELSE 0 END) AS out_of_stock,
ROUND( SUM(CASE WHEN outOfStock = 'TRUE' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2 ) AS stockout_percentage
FROM zepto
GROUP BY category
ORDER BY stockout_percentage DESC;



-- Q10. Which products generate the most potential revenue?
SELECT name, category,
(discountedSellingPrice * availableQuantity) AS potential_revenue
FROM zepto
WHERE outOfStock = 'FALSE'
ORDER BY potential_revenue DESC
LIMIT 10;



-- Q11. Which categories contribute most to total inventory value?
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS inventory_value
FROM zepto
GROUP BY category
ORDER BY inventory_value DESC;



-- Q12. Identify duplicate products with large price variation.  (Detect pricing inconsistencies.)
SELECT name,
MIN(discountedSellingPrice) AS lowest_price,
MAX(discountedSellingPrice) AS highest_price,
(MAX(discountedSellingPrice) - MIN(discountedSellingPrice)) AS difference
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY difference DESC;



-- Q.13 Identify slow-moving products (high stock but low discount)(or promotional campaigns.)
SELECT 
    name,
    category,
    availableQuantity,
    discountPercent
FROM zepto
ORDER BY availableQuantity DESC, discountPercent;

