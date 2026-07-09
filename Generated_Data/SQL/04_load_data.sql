-- ==========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- File        : 04_load_data.sql
-- Purpose     : Import Generated CSV Data into MySQL Tables
-- ==========================================================

-- ==========================================================
-- Prerequisite
-- Ensure LOCAL INFILE is enabled in MySQL Server before
-- executing this script.
-- ==========================================================

/*
==============================================================================
04_load_data.sql

Purpose:
Loads all generated CSV files into the Project Velox database.

Important Note:
The CSV files were generated on Windows, so the final column of each row
contains a carriage return character (\r). During testing this caused:

• ENUM values (Active/Expired) to import as blank
• Boolean values (True/False) to import incorrectly

To ensure consistent imports, REPLACE(..., '\r', '') is used on affected
columns during LOAD DATA LOCAL INFILE.

This script has been validated against MySQL 8.0.
==============================================================================
*/

USE project_velox;

-- ==========================================================
-- Load Cities
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/cities.csv'
INTO TABLE cities
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_cities
FROM cities;

-- ==========================================================
-- Load Delivery Zones
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/delivery_zones.csv'
INTO TABLE delivery_zones
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_delivery_zones
FROM delivery_zones;

-- ==========================================================
-- Load Calendar
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/calendar.csv'
INTO TABLE calendar
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 @calendar_id,
 @full_date,
 @day_name,
 @week_number,
 @month_name,
 @quarter,
 @year,
 @is_weekend,
 @season,
 @festival_flag
)
SET
calendar_id   = @calendar_id,
full_date     = @full_date,
day_name      = @day_name,
week_number   = @week_number,
month_name    = @month_name,
quarter       = @quarter,
year          = @year,
is_weekend    = (REPLACE(@is_weekend, '\r', '') = 'True'),
season        = @season,
festival_flag = (REPLACE(@festival_flag, '\r', '') = 'True');
SELECT COUNT(*) AS total_calendar_entries
FROM calendar;

-- ==========================================================
-- Load Weather
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/weather.csv'
INTO TABLE weather  
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_weather_entries
FROM weather;

-- ==========================================================
-- Load Restaurant Categories
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/restaurant_categories.csv'
INTO TABLE restaurant_categories
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_restaurant_categories
FROM restaurant_categories;

-- ==========================================================
-- Load Restaurants
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/restaurants.csv'
INTO TABLE restaurants
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
restaurant_id,
zone_id,
category_id,
restaurant_name,
average_preparation_time,
average_rating,
@is_premium,
opening_time,
@closing_time
)
SET
is_premium =
CASE
WHEN REPLACE(@is_premium,'\r','')='True' THEN 1
ELSE 0
END,

closing_time = REPLACE(@closing_time,'\r','');

SELECT COUNT(*) AS total_restaurants
FROM restaurants;

-- ==========================================================
-- Load Customers
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id,
 zone_id,
 customer_name,
 gender,
 age,
 signup_date,
 customer_segment,
 @is_active,
 created_at)
SET 
    is_active = (REPLACE(@is_active, '\r', '') = 'True');

SELECT COUNT(*) AS total_customers
FROM customers;

-- ==========================================================
-- Load Riders
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/riders.csv'
INTO TABLE riders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_riders
FROM riders;

-- ==========================================================
-- Load Payments
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_payments
FROM payments;

-- ==========================================================
-- Load Promotions
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/promotions.csv'
INTO TABLE promotions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    promotion_id,
    promotion_name,
    discount_type,
    discount_value,
    @promotion_status
)
SET
    promotion_status = REPLACE(@promotion_status, '\r', '');

SELECT COUNT(*) AS total_promotions
FROM promotions;

-- ==========================================================
-- Load Menu Items
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/menu_items.csv'
INTO TABLE menu_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    menu_item_id,
    restaurant_id,
    item_name,
    item_type,
    @is_veg,
    unit_price,
    @is_available
)
SET
    is_veg = (REPLACE(@is_veg, '\r', '') = 'True'),
    is_available = (REPLACE(@is_available, '\r', '') = 'True');

SELECT COUNT(*) AS total_menu_items
FROM menu_items;

-- ==========================================================
-- Load Orders
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_orders
FROM orders;

-- ==========================================================
-- Load Order Items
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_order_items
FROM order_items;

-- ==========================================================
-- Load Reviews
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:/ProjectVelox/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
review_id,
order_id,
customer_id,
restaurant_id,
rider_id,
rating,
review_sentiment,
@complaint_flag,
complaint_category,
review_text
)
SET 
complaint_flag = (REPLACE(@complaint_flag, '\r', '') = 'True');

SELECT COUNT(*) AS total_reviews
FROM reviews;

-- ==========================================================
-- Data Import Completed Successfully
-- ==========================================================
--
-- All generated CSV files have been imported successfully.
-- Row counts should be verified using 05_validation.sql.
--

-- ==============================================================================
-- ISSUES ENCOUNTERED & RESOLUTIONS
-- ==============================================================================

1. LOAD DATA LOCAL INFILE Disabled
----------------------------------
Issue:
MySQL rejected LOAD DATA LOCAL INFILE with Error Code 2068 because the
LOCAL INFILE option was disabled.

Resolution:
• Enabled local_infile = 1 in MySQL Server configuration.
• Restarted MySQL Server.
• Verified using:
      SHOW VARIABLES LIKE 'local_infile';

Status:
Resolved successfully.


2. CSV Import via Table Data Import Wizard
------------------------------------------
Issue:
The Table Data Import Wizard imported some tables successfully but failed
for larger datasets and provided inconsistent results.

Resolution:
Switched to LOAD DATA LOCAL INFILE for all CSV imports, resulting in a
fully script-based, reproducible ETL process.

Status:
Resolved successfully.


3. ENUM Value Mismatch
----------------------
Issue:
Customer segments in the generated dataset did not match the ENUM values
defined in the schema.

Resolution:
Updated the customers table schema so that ENUM values matched the dataset.

Status:
Resolved successfully.


4. Boolean (True/False) Import
------------------------------
Issue:
Boolean values such as True/False were imported into TINYINT columns as
incorrect values.

Resolution:
Imported Boolean columns into user variables and converted them using
SET statements during LOAD DATA.

Example:
    SET is_active = (REPLACE(@is_active, '\r', '') = 'True');

Status:
Resolved successfully.


5. Windows CSV Line Ending (\r\n)
---------------------------------
Issue:
The last column of Windows-generated CSV files contained a trailing
carriage return (\r), causing:
• ENUM values to become blank
• Boolean comparisons to fail

Resolution:
Removed the trailing carriage return during import using:

    REPLACE(@column_name, '\r', '')

Status:
Resolved successfully.


6. Safe Update Mode
-------------------
Issue:
DELETE FROM table_name produced Error Code 1175 because MySQL Workbench
Safe Update Mode was enabled.

Resolution:
Used TRUNCATE TABLE during testing to clear data before re-importing.

Status:
Resolved successfully.

7. Restaurants Table Import Issue
---------------------------------
Issue:
Only 91 restaurant records were imported instead of the expected 120.
The import generated warnings because:
• True/False values could not be inserted into the TINYINT is_premium column.
• The closing_time column contained a trailing carriage return (\r).

Resolution:
Updated the LOAD DATA LOCAL INFILE statement to:
• Import is_premium into a user variable and convert it using CASE.
• Remove the trailing carriage return from closing_time using REPLACE().

Example:

    SET
    is_premium = CASE
                    WHEN REPLACE(@is_premium, '\r', '') = 'True' THEN 1
                    ELSE 0
                 END,
    closing_time = REPLACE(@closing_time, '\r', '');

After re-importing, all 120 restaurant records were loaded successfully.

Status:
Resolved successfully.

8. Partial Menu Items Import
----------------------------
Issue:
The menu_items table contained only 2,359 rows instead of the expected
3,138 rows. Consequently, the Foreign Key validation between
order_items and menu_items reported missing menu_item_id values.

Root Cause:
The CSV contained Boolean values (True/False) for both is_veg and
is_available. During LOAD DATA LOCAL INFILE, MySQL attempted to insert
these strings directly into TINYINT columns, causing many rows to be
skipped during import.

Resolution:
• Updated the LOAD DATA LOCAL INFILE statement to import Boolean columns
  into user variables.
• Converted the values using REPLACE() to remove trailing carriage
  returns (\r).
• Mapped True/False into 1/0 using SET statements.
• Truncated the table and re-imported the CSV using the corrected script.

Example:

    SET
        is_veg = (REPLACE(@is_veg, '\r', '') = 'True'),
        is_available = (REPLACE(@is_available, '\r', '') = 'True');

Result:
• Row count increased from 2,359 to 3,138.
• Foreign Key validation between order_items and menu_items
  returned zero rows.

Status:
Resolved successfully.

-- ==============================================================================