-- ===========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- Database    : MySQL 8.0.43
-- Created On  : 06-Jul-2026
-- ===========================================================

-- ===========================================================
-- Project Velox
-- Schema Evolution Script
-- ===========================================================
-- Purpose:
-- Applies improvements identified after the
-- initial database design.
--
-- Includes:
-- • CHECK Constraints
-- • Weather Model Enhancement
-- • Orders Table Refinement
-- • Calendar Enhancements
--
-- Execution Order:
-- Run after 02_create_tables.sql
-- ===========================================================


-- ===========================================================
-- Section 1
-- CHECK Constraints
-- ===========================================================
-- Purpose:
-- Ensures business rules and data integrity by
-- preventing invalid values from entering the database.
-- ===========================================================

ALTER TABLE orders
ADD CONSTRAINT chk_orders_food_amount
CHECK (food_amount >= 0);


ALTER TABLE orders
ADD CONSTRAINT chk_orders_delivery_fee
CHECK (delivery_fee >= 0);


ALTER TABLE orders
ADD CONSTRAINT chk_orders_tip_amount
CHECK (tip_amount >= 0);


ALTER TABLE orders
ADD CONSTRAINT chk_orders_overall_rating
CHECK (
    overall_rating IS NULL
    OR overall_rating BETWEEN 1.0 AND 5.0
);


ALTER TABLE order_items
ADD CONSTRAINT chk_order_items_quantity
CHECK (quantity > 0);


ALTER TABLE orders
ADD CONSTRAINT chk_discount_amount
CHECK (discount_amount >= 0);


ALTER TABLE orders
ADD CONSTRAINT chk_platform_fee
CHECK (platform_fee >= 0);


ALTER TABLE orders
ADD CONSTRAINT chk_tax_amount
CHECK (tax_amount >= 0);


ALTER TABLE orders
ADD CONSTRAINT chk_final_amount
CHECK (final_amount >= 0);

-- ===========================================================
-- Section 2
-- Weather Table Enhancements
-- ===========================================================
-- Purpose:
-- Converts the Weather table from a lookup table
-- into a daily operational weather table linked
-- with the Calendar dimension.
-- ===========================================================

ALTER TABLE weather
ADD COLUMN calendar_id INT NOT NULL;


ALTER TABLE weather
ADD CONSTRAINT uq_weather_calendar
UNIQUE (calendar_id);


ALTER TABLE weather
ADD CONSTRAINT fk_weather_calendar
FOREIGN KEY (calendar_id)
REFERENCES calendar(calendar_id);


ALTER TABLE weather
MODIFY weather_condition ENUM(
    'Sunny',
    'Cloudy',
    'Rainy',
    'Storm',
    'Foggy',
    'Heatwave'
) NOT NULL;

-- ===========================================================
-- Section 3
-- Orders Table Refinement
-- ===========================================================
-- Purpose:
-- Removes redundant weather reference since weather
-- is now derived through the Calendar table.
-- ===========================================================

ALTER TABLE orders
DROP FOREIGN KEY fk_orders_weather;


ALTER TABLE orders
DROP COLUMN weather_id;

-- ===========================================================
-- Section 4
-- Calendar Enhancement
-- ===========================================================
-- Purpose:
-- Adds seasonal information to support realistic
-- weather generation and seasonal business analysis.
-- ===========================================================

ALTER TABLE calendar
ADD COLUMN season ENUM(
    'Winter',
    'Summer',
    'Monsoon'
) NOT NULL
