# E-Commerce Inventory Analysis Using SQL

This is a real-world data analyst project using an e-commerce inventory dataset scraped from Zepto. The project simulates real analyst workflows — from raw data exploration to business-focused data analysis.


## Project Overview

- Build a real-world e-commerce inventory database using SQL. 
- Perform exploratory data analysis (EDA) to understand product categories, pricing, and availability.
- Clean and prepare data by handling null values and invalid entries.
- Write SQL queries to generate business insights on pricing, inventory, and revenue.


## Dataset Overview

The dataset was sourced from Kaggle (https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv).
Each row represents a unique SKU (Stock Keeping Unit) for a product.
Duplicate product names may exist because the same product can appear in multiple package sizes, weights, discounts or categories.

### Columns in the Dataset

- **sku_id** – Unique identifier for each product entry (synthetic primary key)  
- **name** – Product name as it appears on the app  
- **category** – Product category such as fruits, snacks, or beverages  
- **mrp** – Maximum Retail Price (originally in paise and converted to rupees)  
- **discountPercent** – Discount applied on MRP  
- **discountedSellingPrice** – Final price after discount (converted to rupees)  
- **availableQuantity** – Units available in inventory  
- **weightInGms** – Product weight in grams  
- **outOfStock** – Boolean flag indicating stock availability  
- **quantity** – Number of units per package  


## Project Workflow

### 1. Create Database and Table

A SQL table was created with appropriate data types:

```sql
CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock VARCHAR(10),
    quantity INTEGER
);
````

### 2. Data Import

* Loaded the CSV file using the Table Data Import Wizard
* Ensured correct data types during import
* Resolved encoding issues by saving the CSV file in UTF-8 format

### 3. Data Exploration

* Count total records in the dataset
* View sample records
* Check for null values across all columns
* Identify distinct product categories
* Compare in-stock and out-of-stock counts
* Detect products appearing multiple times under different SKUs

### 4. Data Cleaning

* Remove rows where MRP or discounted selling price is zero (missing data)
* Convert `mrp` and `discountedSellingPrice` from paise to rupees

---

## Business Insights

* Find top 10 best-value products based on discount percentage
* Identify high-MRP products that are out of stock
* Estimate potential revenue for each product category
* Filter expensive products with minimal discount
* Rank top categories offering the highest average discounts
* Calculate price per gram to identify value-for-money products
* Group products based on weight into low, medium, and bulk categories
* Identify top categories by inventory value
* Determine which categories are at highest risk of stockout
* Identify products generating the most potential revenue
* Determine which categories contribute most to total inventory value
* Detect duplicate products with large price variation (pricing inconsistencies)
* Identify slow-moving products (high stock but low discount) for promotional planning
