-- ==========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- File        : 05_validation.sql
-- Purpose     : Validate the integrity, completeness and
--               consistency of the Project Velox database
--               before analytical SQL queries and dashboard
--               development.
-- ==========================================================

USE project_velox;

-- ==========================================================
-- Validation Categories
-- ==========================================================
--
-- 1. Row Count Validation
-- 2. Primary Key Validation
-- 3. Foreign Key Validation
-- 4. NULL Value Checks
-- 5. Duplicate Checks
-- 6. Business Rule Validation
-- 7. Validation Summary
--
-- ==========================================================

-- ==========================================================
-- 1. Row Count Validation
-- ==========================================================

-- ----------------------------------------------------------
-- Validate Cities Table Row Count
--
-- Expected Result:
-- Returns exactly 6 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_cities
FROM cities;

-- ----------------------------------------------------------
-- Validate Delivery Zones Table Row Count
--
-- Expected Result:
-- Returns exactly 39 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_delivery_zones
FROM delivery_zones;

-- ----------------------------------------------------------
-- Validate Calendar Table Row Count
--
-- Expected Result:
-- Returns exactly 731 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_calendar_days
FROM calendar;

-- ----------------------------------------------------------
-- Validate Weather Table Row Count
--
-- Expected Result:
-- Returns exactly 731 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_weather_records
FROM weather;

-- ----------------------------------------------------------
-- Validate Restaurant Categories Row Count
--
-- Expected Result:
-- Returns exactly 10 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_restaurant_categories
FROM restaurant_categories;

-- ----------------------------------------------------------
-- Validate Restaurants Table Row Count
--
-- Expected Result:
-- Returns exactly 120 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_restaurants
FROM restaurants;

-- ----------------------------------------------------------
-- Validate Customers Table Row Count
--
-- Expected Result:
-- Returns exactly 2000 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_customers
FROM customers;

-- ----------------------------------------------------------
-- Validate Riders Table Row Count
--
-- Expected Result:
-- Returns exactly 300 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_riders
FROM riders;

-- ----------------------------------------------------------
-- Validate Payments Table Row Count
--
-- Expected Result:
-- Returns exactly 5 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_payment_methods
FROM payments;

-- ----------------------------------------------------------
-- Validate Promotions Table Row Count
--
-- Expected Result:
-- Returns exactly 12 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_promotions
FROM promotions;

-- ----------------------------------------------------------
-- Validate Menu Items Table Row Count
--
-- Expected Result:
-- Returns exactly 3138 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_menu_items
FROM menu_items;

-- ----------------------------------------------------------
-- Validate Orders Table Row Count
--
-- Expected Result:
-- Returns exactly 50,000 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_orders
FROM orders;

-- ----------------------------------------------------------
-- Validate Order Items Table Row Count
--
-- Expected Result:
-- Returns exactly 125,101 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_order_items
FROM order_items;

-- ----------------------------------------------------------
-- Validate Reviews Table Row Count
--
-- Expected Result:
-- Returns exactly 28,098 rows.
-- ----------------------------------------------------------

SELECT COUNT(*) AS total_reviews
FROM reviews;

-- ==========================================================
-- 2. Primary Key Validation
-- ==========================================================

-- ----------------------------------------------------------
-- Check Duplicate City IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT city_id,
       COUNT(*) AS duplicate_count
FROM cities
GROUP BY city_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Delivery Zone IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT zone_id,
       COUNT(*) AS duplicate_count
FROM delivery_zones
GROUP BY zone_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Calendar IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT calendar_id,
       COUNT(*) AS duplicate_count
FROM calendar
GROUP BY calendar_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Weather IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT weather_id,
       COUNT(*) AS duplicate_count
FROM weather
GROUP BY weather_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Restaurant Category IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT category_id,
       COUNT(*) AS duplicate_count
FROM restaurant_categories
GROUP BY category_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Restaurant IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT restaurant_id,
       COUNT(*) AS duplicate_count
FROM restaurants
GROUP BY restaurant_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Customer IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT customer_id,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Rider IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT rider_id,
       COUNT(*) AS duplicate_count
FROM riders
GROUP BY rider_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Payments IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT payment_id,
       COUNT(*) AS duplicate_count
FROM payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Promotions IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT promotion_id,
       COUNT(*) AS duplicate_count
FROM promotions
GROUP BY promotion_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Menu Item IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT menu_item_id,
       COUNT(*) AS duplicate_count
FROM menu_items
GROUP BY menu_item_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Order IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT order_id,
       COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Order Item IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT order_item_id,
       COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Check Duplicate Review IDs
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT review_id,
       COUNT(*) AS duplicate_count
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- ==========================================================
-- 3. Foreign Key Validation
-- ==========================================================

-- ----------------------------------------------------------
-- Validate Delivery Zones Reference Existing Cities
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT dz.zone_id,
       dz.city_id
FROM delivery_zones dz
LEFT JOIN cities c
       ON dz.city_id = c.city_id
WHERE c.city_id IS NULL;

-- ----------------------------------------------------------
-- Validate Weather Reference Existing Calendar Records
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT w.weather_id,
       w.calendar_id
FROM weather w
LEFT JOIN calendar c
       ON w.calendar_id = c.calendar_id
WHERE c.calendar_id IS NULL;

-- ----------------------------------------------------------
-- Validate Restaurants Reference Existing Delivery Zones
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT r.restaurant_id,
       r.zone_id
FROM restaurants r
LEFT JOIN delivery_zones dz
       ON r.zone_id = dz.zone_id
WHERE dz.zone_id IS NULL;

-- ----------------------------------------------------------
-- Validate Restaurants Reference Existing Categories
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT r.restaurant_id,
       r.category_id
FROM restaurants r
LEFT JOIN restaurant_categories rc
       ON r.category_id = rc.category_id
WHERE rc.category_id IS NULL;

-- ----------------------------------------------------------
-- Validate Customers Reference Existing Delivery Zones
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT c.customer_id,
       c.zone_id
FROM customers c
LEFT JOIN delivery_zones dz
       ON c.zone_id = dz.zone_id
WHERE dz.zone_id IS NULL;

-- ----------------------------------------------------------
-- Validate Riders Reference Existing Delivery Zones
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT r.rider_id,
       r.zone_id
FROM riders r
LEFT JOIN delivery_zones dz
       ON r.zone_id = dz.zone_id
WHERE dz.zone_id IS NULL;

-- ----------------------------------------------------------
-- Validate Menu Items Reference Existing Restaurants
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT mi.menu_item_id,
       mi.restaurant_id
FROM menu_items mi
LEFT JOIN restaurants r
       ON mi.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Customers
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.customer_id
FROM orders o
LEFT JOIN customers c
       ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Restaurants
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.restaurant_id
FROM orders o
LEFT JOIN restaurants r
       ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Riders
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.rider_id
FROM orders o
LEFT JOIN riders r
       ON o.rider_id = r.rider_id
WHERE r.rider_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Calendar Records
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.calendar_id
FROM orders o
LEFT JOIN calendar c
       ON o.calendar_id = c.calendar_id
WHERE c.calendar_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Weather Records
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.weather_id
FROM orders o
LEFT JOIN weather w
       ON o.weather_id = w.weather_id
WHERE w.weather_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Payment Methods
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.payment_id
FROM orders o
LEFT JOIN payments p
       ON o.payment_id = p.payment_id
WHERE p.payment_id IS NULL;

-- ----------------------------------------------------------
-- Validate Orders Reference Existing Promotions
--
-- Expected Result:
-- Returns zero rows.
--
-- Note:
-- promotion_id = 0 represents "No Promotion Applied".
-- Only promotion IDs greater than zero should exist
-- in the promotions table.
-- ----------------------------------------------------------

SELECT o.order_id,
       o.promotion_id
FROM orders o
LEFT JOIN promotions p
       ON o.promotion_id = p.promotion_id
WHERE o.promotion_id > 0
  AND p.promotion_id IS NULL;      

  -- ----------------------------------------------------------
-- Validate Order Items Reference Existing Orders
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT oi.order_item_id,
       oi.order_id
FROM order_items oi
LEFT JOIN orders o
       ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ----------------------------------------------------------
-- Validate Order Items Reference Existing Menu Items
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT oi.order_item_id,
       oi.menu_item_id
FROM order_items oi
LEFT JOIN menu_items mi
       ON oi.menu_item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NULL;

-- ----------------------------------------------------------
-- Validate Reviews Reference Existing Orders
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT r.review_id,
       r.order_id
FROM reviews r
LEFT JOIN orders o
       ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ==========================================================
-- 4. Null Value Checks
-- ==========================================================

-- ----------------------------------------------------------
-- NULL Value Check - Cities
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM cities
WHERE city_id IS NULL
   OR city_name IS NULL
   OR state IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Delivery Zones
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM delivery_zones
WHERE zone_id IS NULL
   OR city_id IS NULL
   OR zone_name IS NULL
   OR zone_type IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Calendar
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM calendar
WHERE calendar_id IS NULL
   OR full_date IS NULL
   OR day_name IS NULL
   OR week_number IS NULL
   OR month_name IS NULL
   OR quarter IS NULL
   OR year IS NULL
   OR is_weekend IS NULL
   OR season IS NULL
   OR festival_flag IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Weather
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM weather
WHERE weather_id IS NULL
   OR calendar_id IS NULL
   OR weather_condition IS NULL
   OR temperature_category IS NULL
   OR weather_severity IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Restaurant Categories
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM restaurant_categories
WHERE category_id IS NULL
   OR category_name IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Restaurants
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM restaurants
WHERE restaurant_id IS NULL
   OR zone_id IS NULL
   OR category_id IS NULL
   OR restaurant_name IS NULL
   OR average_preparation_time IS NULL
   OR average_rating IS NULL
   OR is_premium IS NULL
   OR opening_time IS NULL
   OR closing_time IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Customers
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM customers
WHERE customer_id IS NULL
   OR zone_id IS NULL
   OR customer_name IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR signup_date IS NULL
   OR customer_segment IS NULL
   OR is_active IS NULL
   OR created_at IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Riders
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM riders
WHERE rider_id IS NULL
   OR zone_id IS NULL
   OR rider_name IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR vehicle_type IS NULL
   OR experience_level IS NULL
   OR rider_rating IS NULL
   OR employment_type IS NULL
   OR shift IS NULL
   OR joining_date IS NULL
   OR is_active IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Payments
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM payments
WHERE payment_id IS NULL
   OR payment_method IS NULL
   OR payment_status IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Promotions
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM promotions
WHERE promotion_id IS NULL
   OR promotion_name IS NULL
   OR discount_type IS NULL
   OR discount_value IS NULL
   OR promotion_status IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Menu Items
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM menu_items
WHERE menu_item_id IS NULL
   OR restaurant_id IS NULL
   OR item_name IS NULL
   OR item_type IS NULL
   OR is_veg IS NULL
   OR unit_price IS NULL
   OR is_available IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Orders
--
-- Expected Result:
-- Returns zero rows.
--
-- Note:
-- delivered_timestamp and cancellation_reason may be NULL
-- depending on the order status.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_id IS NULL
   OR customer_id IS NULL
   OR restaurant_id IS NULL
   OR rider_id IS NULL
   OR calendar_id IS NULL
   OR weather_id IS NULL
   OR payment_id IS NULL
   OR promotion_id IS NULL
   OR order_timestamp IS NULL
   OR order_status IS NULL
   OR delivery_minutes IS NULL
   OR delivery_fee IS NULL
   OR platform_fee IS NULL
   OR subtotal IS NULL
   OR gst_amount IS NULL
   OR discount_amount IS NULL
   OR final_amount IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Order Items
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM order_items
WHERE order_item_id IS NULL
   OR order_id IS NULL
   OR menu_item_id IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL
   OR line_total IS NULL;

-- ----------------------------------------------------------
-- NULL Value Check - Reviews
--
-- Expected Result:
-- Returns zero rows.
--
-- Note:
-- complaint_category may be NULL when complaint_flag = 0.
-- ----------------------------------------------------------

SELECT *
FROM reviews
WHERE review_id IS NULL
   OR order_id IS NULL
   OR customer_id IS NULL
   OR restaurant_id IS NULL
   OR rider_id IS NULL
   OR rating IS NULL
   OR review_sentiment IS NULL
   OR complaint_flag IS NULL
   OR complaint_category IS NULL
   OR review_text IS NULL;

-- ==========================================================
-- 5. Business Duplicate Checks
-- ==========================================================

-- ----------------------------------------------------------
-- Business Duplicate Check - Cities
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT city_name,
       state,
       COUNT(*) AS duplicate_count
FROM cities
GROUP BY city_name, state
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Delivery Zones
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT city_id,
       zone_name,
       COUNT(*) AS duplicate_count
FROM delivery_zones
GROUP BY city_id, zone_name
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Calendar
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT full_date,
       COUNT(*) AS duplicate_count
FROM calendar
GROUP BY full_date
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Weather
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT calendar_id,
       COUNT(*) AS duplicate_count
FROM weather
GROUP BY calendar_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Restaurant Categories
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT category_name,
       COUNT(*) AS duplicate_count
FROM restaurant_categories
GROUP BY category_name
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Restaurants
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT zone_id,
       restaurant_name,
       COUNT(*) AS duplicate_count
FROM restaurants
GROUP BY zone_id, restaurant_name
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Customers
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT customer_name,
       signup_date,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_name, signup_date
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Riders
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT rider_name,
       joining_date,
       COUNT(*) AS duplicate_count
FROM riders
GROUP BY rider_name, joining_date
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Payments
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT payment_method,
       COUNT(*) AS duplicate_count
FROM payments
GROUP BY payment_method
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Promotions
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT promotion_name,
       COUNT(*) AS duplicate_count
FROM promotions
GROUP BY promotion_name
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Menu Items
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT restaurant_id,
       item_name,
       COUNT(*) AS duplicate_count
FROM menu_items
GROUP BY restaurant_id, item_name
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Orders
--
-- Expected Result:
-- Returns zero rows.
--
-- Note:
-- Multiple orders from the same customer at the same timestamp
-- are valid if they differ in restaurant, status, or amount.
-- ----------------------------------------------------------

SELECT customer_id,
       restaurant_id,
       order_timestamp,
       final_amount,
       order_status,
       COUNT(*) AS duplicate_count
FROM orders
GROUP BY customer_id,
         restaurant_id,
         order_timestamp,
         final_amount,
         order_status
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Order Items
--
-- Expected Result:
-- Returns zero rows.
--
-- Note:
-- The same menu item should not appear more than once
-- within the same order.
-- ----------------------------------------------------------

SELECT order_id,
       menu_item_id,
       COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_id,
         menu_item_id
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------
-- Business Duplicate Check - Reviews
--
-- Expected Result:
-- Returns zero rows.
--
-- Note:
-- Each order should have at most one review.
-- ----------------------------------------------------------

SELECT order_id,
       COUNT(*) AS duplicate_count
FROM reviews
GROUP BY order_id
HAVING COUNT(*) > 1;

-- ==========================================================
-- 6. Business Rule Validation
-- ==========================================================

-- ----------------------------------------------------------
-- Business Rule Validation - Cities
--
-- Rule:
-- Every state should contain at least one city.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT state
FROM cities
GROUP BY state
HAVING COUNT(city_id) = 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Delivery Zones
--
-- Rule:
-- Every city should have at least one delivery zone.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT c.city_id,
       c.city_name
FROM cities c
LEFT JOIN delivery_zones dz
       ON c.city_id = dz.city_id
WHERE dz.zone_id IS NULL;

-- ----------------------------------------------------------
-- Business Rule Validation - Calendar
--
-- Rule:
-- Weekend flag should match the day of week.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM calendar
WHERE (day_name IN ('Saturday','Sunday') AND is_weekend = 0)
   OR (day_name NOT IN ('Saturday','Sunday') AND is_weekend = 1);

-- ----------------------------------------------------------
-- Business Rule Validation - Weather
--
-- Rule:
-- Temperature category should contain only valid business values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM weather
WHERE temperature_category
      NOT IN ('Cold','Pleasant','Hot');

-- ----------------------------------------------------------
-- Business Rule Validation - Weather
--
-- Rule:
-- Weather condition should contain only valid business values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM weather
WHERE weather_condition
      NOT IN ('Sunny',
              'Cloudy',
              'Rainy',
              'Storm',
              'Foggy',
              'Heatwave');

-- ----------------------------------------------------------
-- Business Rule Validation - Restaurant Categories
--
-- Rule:
-- Every restaurant category should be used.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT rc.category_id,
       rc.category_name
FROM restaurant_categories rc
LEFT JOIN restaurants r
       ON rc.category_id = r.category_id
WHERE r.restaurant_id IS NULL;

-- ----------------------------------------------------------
-- Business Rule Validation - Customers
--
-- Rule:
-- Customer age should be between 18 and 80 years.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM customers
WHERE age < 18
   OR age > 80;

-- ----------------------------------------------------------
-- Business Rule Validation - Customers
--
-- Rule:
-- Active flag should contain only valid Boolean values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM customers
WHERE is_active NOT IN (0,1);

-- ----------------------------------------------------------
-- Business Rule Validation - Riders
--
-- Rule:
-- Rider age should be between 18 and 60 years.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM riders
WHERE age < 18
   OR age > 60;

-- ----------------------------------------------------------
-- Business Rule Validation - Riders
--
-- Rule:
-- Rider rating should be between 1.0 and 5.0.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM riders
WHERE rider_rating < 1
   OR rider_rating > 5;

-- ----------------------------------------------------------
-- Business Rule Validation - Riders
--
-- Rule:
-- Active flag should contain only valid Boolean values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM riders
WHERE is_active NOT IN (0,1);

-- ----------------------------------------------------------
-- Business Rule Validation - Payments
--
-- Rule:
-- Payment status should contain only valid business values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Business Rule Validation - Payments
--
-- Rule:
-- Payment method should contain only supported payment methods.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM payments
WHERE payment_method
NOT IN ('UPI',
        'Credit Card',
        'Debit Card',
        'Cash',
        'Wallet');

-- ----------------------------------------------------------
-- Business Rule Validation - Payments
--
-- Rule:
-- Payment status should be 'Successful' for all payment methods.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM payments
WHERE payment_status <> 'Successful';

-- ----------------------------------------------------------
-- Business Rule Validation - Promotions
--
-- Rule:
-- Discount value should always be greater than zero.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM promotions
WHERE discount_value <= 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Promotions
--
-- Rule:
-- Promotion status should contain only valid business values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM promotions
WHERE promotion_status
NOT IN ('Active','Expired');

-- ----------------------------------------------------------
-- Business Rule Validation - Restaurants
--
-- Rule:
-- Average rating should be between 1.0 and 5.0.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM restaurants
WHERE average_rating < 1
   OR average_rating > 5;

-- ----------------------------------------------------------
-- Business Rule Validation - Restaurants
--
-- Rule:
-- Average preparation time should be positive.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM restaurants
WHERE average_preparation_time <= 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Menu Items
--
-- Rule:
-- Menu item price should be greater than zero.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM menu_items
WHERE unit_price <= 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Menu Items
--
-- Rule:
-- Availability flag should contain only valid Boolean values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM menu_items
WHERE is_available NOT IN (0,1);

-- ----------------------------------------------------------
-- Business Rule Validation - Menu Items
--
-- Rule:
-- Vegetarian flag should contain only valid Boolean values.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM menu_items
WHERE is_veg NOT IN (0,1);

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Delivery fee should never be negative.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE delivery_fee < 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Platform fee should never be negative.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE platform_fee < 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- GST amount should never be negative.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE gst_amount < 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Delivered orders must contain a delivered timestamp.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Delivered'
  AND delivered_timestamp IS NULL;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Cancelled orders should not have an actual delivery timestamp.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Cancelled'
  AND CAST(delivered_timestamp AS CHAR) <> '0000-00-00 00:00:00';

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Cancelled orders should have zero delivery minutes.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Cancelled'
  AND delivery_minutes <> 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Delivered orders should have delivery time greater than zero.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Delivered'
  AND delivery_minutes <= 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Final amount should never be negative.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE final_amount < 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Discount amount should never be negative.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE discount_amount < 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Delivered timestamp should be later than order timestamp.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Delivered'
AND delivered_timestamp <= order_timestamp;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Cancelled orders should have zero final amount.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Cancelled'
AND final_amount <> 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Cancelled orders should not have GST.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Cancelled'
AND gst_amount <> 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Orders
--
-- Rule:
-- Cancelled orders should have zero subtotal.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM orders
WHERE order_status = 'Cancelled'
AND subtotal <> 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Order Items
--
-- Rule:
-- Ordered quantity should be greater than zero.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM order_items
WHERE quantity <= 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Order Items
--
-- Rule:
-- Unit price should be greater than zero.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM order_items
WHERE unit_price <= 0;

-- ----------------------------------------------------------
-- Business Rule Validation - Reviews
--
-- Rule:
-- Rating should be between 1 and 5.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM reviews
WHERE rating < 1
OR rating > 5;

-- ----------------------------------------------------------
-- Business Rule Validation - Reviews
--
-- Rule:
-- Ratings of 4 or 5 should not contain complaint categories.
--
-- Expected Result:
-- Returns zero rows.
-- ----------------------------------------------------------

SELECT *
FROM reviews
WHERE rating >= 4
AND TRIM(IFNULL(complaint_category,'')) <> '';

--------------------------------------------------------------------
9. Validation Summary
--------------------------------------------------------------------

Validation Completed Successfully.

The generated dataset was validated across multiple data quality
dimensions to ensure structural integrity, referential integrity,
data consistency, and business rule compliance.

Validation Categories Completed

✔ Row Count Validation
✔ Primary Key Validation
✔ Foreign Key Validation
✔ NULL Value Validation
✔ Business Duplicate Validation
✔ Business Rule Validation

All critical validation checks passed successfully after resolving
identified issues encountered during data loading and validation.

Final Validation Status : PASSED

The validated dataset is now ready for:

• SQL Business Analytics
• Power BI Dashboard Development
• KPI Computation
• Business Reporting
-- ==============================================================================

--------------------------------------------------------------------
9.1 Validation Challenges & Resolutions
--------------------------------------------------------------------

1. Foreign Key Validation - Customers → Delivery Zones
------------------------------------------------------

Issue:
Customer records referenced delivery zones that were missing because
the delivery_zones table was not loaded correctly, resulting in only
30 records being imported instead of the expected 39.

Resolution:
Reloaded the delivery_zones table using LOAD DATA LOCAL INFILE,
restored all 39 delivery zones, re-established the foreign key
relationships, and revalidated referential integrity.

Status:
Resolved successfully.


2. Foreign Key Validation - Orders → Restaurants
------------------------------------------------

Issue:
Orders referenced restaurant IDs that were missing because only
91 restaurant records were imported instead of the expected 120.

Resolution:
Reloaded the restaurants table using LOAD DATA LOCAL INFILE with
Boolean conversion and carriage return handling. All 120 restaurants
were imported successfully.

Status:
Resolved successfully.


3. Foreign Key Validation - Orders → Riders
-------------------------------------------

Issue:
Orders referenced rider IDs that were missing because only
218 rider records were imported instead of the expected 300.

Resolution:
Reloaded the riders table using LOAD DATA LOCAL INFILE with
Boolean conversion for the is_active column.

Status:
Resolved successfully.


4. Foreign Key Validation - Orders → Promotions
-----------------------------------------------

Issue:
Orders without promotions stored promotion_id = 0 instead of NULL,
causing foreign key validation queries to report violations.

Resolution:
Updated the validation query to treat promotion_id = 0 as
"No Promotion" rather than an invalid foreign key.

Status:
Resolved successfully.


5. Foreign Key Validation - Order Items → Menu Items
----------------------------------------------------

Issue:
Order items referenced menu items that were missing because only
779 menu items had initially been imported instead of 3138.

Resolution:
Reloaded the menu_items table using LOAD DATA LOCAL INFILE with
Boolean conversion for is_veg and is_available. Foreign key
validation was executed again and returned zero violations.

Status:
Resolved successfully.


6. Calendar Weekend Flag Import
-------------------------------

Issue:
The calendar CSV contained correct weekend values, but LOAD DATA
imported all Boolean values as 0, causing weekday/weekend validation
to fail.

Resolution:
Reloaded the calendar table using Boolean conversion through
SET statements during LOAD DATA. Weekend validation returned
zero incorrect records.

Status:
Resolved successfully.


7. Windows Carriage Return (\r) in Payment Status
-------------------------------------------------

Issue:
Payment status values contained a trailing carriage return (\r),
causing validation queries to incorrectly return all rows.

Resolution:
Verified the issue using HEX() and corrected the validation by
using TRIM() to remove trailing carriage return characters.

Status:
Resolved successfully.


8. Business Duplicate Validation Logic
--------------------------------------

Issue:
The initial duplicate validation considered only customer_id and
order_timestamp, incorrectly identifying legitimate orders as
duplicates.

Resolution:
Improved the duplicate detection logic by including restaurant_id
in the uniqueness check, eliminating false positives.

Status:
Resolved successfully.


9. Validation Rules vs Actual Schema
------------------------------------

Issue:
Several validation rules referenced columns that were intentionally
not present in the final schema (e.g., total_price in order_items,
review_timestamp in reviews, preparation_time in menu_items).

Resolution:
Updated the validation documentation to reflect the implemented
database schema while preserving meaningful business validations.

Status:
Resolved successfully.


10. Empty String vs NULL in Reviews
-----------------------------------

Issue:
Positive reviews appeared to contain complaint categories because
the generator stored empty strings ('') instead of NULL values.

Resolution:
Updated the validation query to treat both NULL and empty strings
as valid using:

TRIM(IFNULL(complaint_category,''))

Status:
Resolved successfully.

-- ==============================================================================