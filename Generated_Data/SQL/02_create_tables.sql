-- ==========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- File        : 02_create_tables.sql
-- Purpose     : Create Warehouse Tables
-- ==========================================================

-- ==========================================================
-- Cities Table
-- ==========================================================

CREATE TABLE cities (

    city_id INT PRIMARY KEY,

    city_name VARCHAR(100) NOT NULL,

    state VARCHAR(100) NOT NULL,

    region ENUM(

        'North',
        'South',
        'East',
        'West',
        'Central'

    ) NOT NULL

);

-- ==========================================================
-- Delivery Zones Table
-- ==========================================================

CREATE TABLE delivery_zones (

    zone_id INT PRIMARY KEY,

    city_id INT NOT NULL,

    zone_name VARCHAR(100) NOT NULL,

    zone_type ENUM(

        'Residential',
        'Commercial',
        'Mixed'

    ) NOT NULL

);

-- ==========================================================
-- Calendar Table
-- ==========================================================

CREATE TABLE calendar (

    calendar_id INT PRIMARY KEY,

    full_date DATE NOT NULL,

    day_name VARCHAR(10) NOT NULL,

    week_number TINYINT UNSIGNED NOT NULL,

    month_name VARCHAR(15) NOT NULL,

    quarter ENUM(

        'Q1',
        'Q2',
        'Q3',
        'Q4'

    ) NOT NULL,

    year SMALLINT NOT NULL,

    is_weekend BOOLEAN NOT NULL,

    season ENUM(

        'Winter',
        'Summer',
        'Monsoon'

    ) NOT NULL,

    festival_flag BOOLEAN NOT NULL

);

-- ==========================================================
-- Weather Table
-- ==========================================================

CREATE TABLE weather (

    weather_id INT PRIMARY KEY,

    calendar_id INT NOT NULL,

    weather_condition ENUM(

        'Sunny',
        'Cloudy',
        'Rainy',
        'Storm',
        'Foggy',
        'Heatwave'

    ) NOT NULL,

    temperature_category ENUM(

        'Cold',
        'Pleasant',
        'Hot'

    ) NOT NULL,

    weather_severity ENUM(

        'Low',
        'Medium',
        'High'

    ) NOT NULL

);

-- ==========================================================
-- Restaurant Categories Table
-- ==========================================================

CREATE TABLE restaurant_categories (

    category_id INT PRIMARY KEY,

    category_name VARCHAR(50) NOT NULL

);

-- ==========================================================
-- Restaurants Table
-- ==========================================================

CREATE TABLE restaurants (

    restaurant_id INT PRIMARY KEY,

    zone_id INT NOT NULL,

    category_id INT NOT NULL,

    restaurant_name VARCHAR(120) NOT NULL,

    average_preparation_time TINYINT UNSIGNED NOT NULL,

    average_rating DECIMAL(2,1) NOT NULL,

    is_premium BOOLEAN NOT NULL,

    opening_time TIME NOT NULL,

    closing_time TIME NOT NULL

);

-- ==========================================================
-- Customers Table
-- ==========================================================

CREATE TABLE customers (

    customer_id INT PRIMARY KEY,

    zone_id INT NOT NULL,

    customer_name VARCHAR(100) NOT NULL,

    gender ENUM(

        'Male',
        'Female',
        'Other'

    ) NOT NULL,

    age TINYINT UNSIGNED NOT NULL,

    signup_date DATE NOT NULL,

    customer_segment ENUM(
    'Student',
    'Working Professional',
    'Family',
    'Food Enthusiast'
    ) NOT NULL,

    is_active BOOLEAN NOT NULL,

    created_at DATETIME NOT NULL

);

-- ==========================================================
-- Riders Table
-- ==========================================================

CREATE TABLE riders (

    rider_id INT PRIMARY KEY,

    zone_id INT NOT NULL,

    rider_name VARCHAR(100) NOT NULL,

    gender ENUM(

        'Male',
        'Female',
        'Other'

    ) NOT NULL,

    age TINYINT UNSIGNED NOT NULL,

    vehicle_type ENUM(

        'Bike',
        'Scooter',
        'Bicycle'

    ) NOT NULL,

    experience_level ENUM(

        'Beginner',
        'Intermediate',
        'Experienced'

    ) NOT NULL,

    rider_rating DECIMAL(2,1) NOT NULL,

    employment_type ENUM(

        'Full-Time',
        'Part-Time'

    ) NOT NULL,

    shift ENUM(

        'Morning',
        'Afternoon',
        'Evening',
        'Night'

    ) NOT NULL,

    joining_date DATE NOT NULL,

    is_active BOOLEAN NOT NULL

);

-- ==========================================================
-- Payments Table
-- ==========================================================

CREATE TABLE payments (

    payment_id INT PRIMARY KEY,

    payment_method VARCHAR(50) NOT NULL,

    payment_status VARCHAR(20) NOT NULL

);

-- ==========================================================
-- Promotions Table
-- ==========================================================

CREATE TABLE promotions (

    promotion_id INT PRIMARY KEY,

    promotion_name VARCHAR(100) NOT NULL,

    discount_type ENUM(

        'Percentage',
        'Flat'

    ) NOT NULL,

    discount_value DECIMAL(6,2) NOT NULL,

    promotion_status ENUM(

        'Active',
        'Expired'

    ) NOT NULL

);

-- ==========================================================
-- Menu Items Table
-- ==========================================================

CREATE TABLE menu_items (

    menu_item_id INT PRIMARY KEY,

    restaurant_id INT NOT NULL,

    item_name VARCHAR(120) NOT NULL,

    item_type ENUM(

        'Starter',
        'Main Course',
        'Dessert',
        'Beverage'

    ) NOT NULL,

    is_veg BOOLEAN NOT NULL,

    unit_price DECIMAL(10,2) NOT NULL,

    is_available BOOLEAN NOT NULL

);

-- ==========================================================
-- Orders Table
-- ==========================================================

CREATE TABLE orders (

    order_id INT PRIMARY KEY,

    customer_id INT NOT NULL,

    restaurant_id INT NOT NULL,

    rider_id INT NOT NULL,

    calendar_id INT NOT NULL,

    weather_id INT NOT NULL,

    payment_id INT NOT NULL,

    promotion_id INT NULL,

    order_timestamp DATETIME NOT NULL,

    delivered_timestamp DATETIME NULL,

    order_status ENUM(

        'Delivered',
        'Cancelled'

    ) NOT NULL,

    delivery_minutes INT NULL,

    delivery_fee DECIMAL(10,2) NOT NULL,

    platform_fee DECIMAL(10,2) NOT NULL,

    cancellation_reason VARCHAR(100) NULL,

    subtotal DECIMAL(10,2) NOT NULL,

    gst_amount DECIMAL(10,2) NOT NULL,

    discount_amount DECIMAL(10,2) NOT NULL,

    final_amount DECIMAL(10,2) NOT NULL

);

-- ==========================================================
-- Order Items Table
-- ==========================================================

CREATE TABLE order_items (

    order_item_id INT PRIMARY KEY,

    order_id INT NOT NULL,

    menu_item_id INT NOT NULL,

    quantity INT NOT NULL,

    unit_price DECIMAL(10,2) NOT NULL,

    line_total DECIMAL(10,2) NOT NULL

);

-- ==========================================================
-- Reviews Table
-- ==========================================================

CREATE TABLE reviews (

    review_id INT PRIMARY KEY,

    order_id INT NOT NULL,

    customer_id INT NOT NULL,

    restaurant_id INT NOT NULL,

    rider_id INT NOT NULL,

    rating TINYINT NOT NULL,

    review_sentiment ENUM(

        'Positive',
        'Neutral',
        'Negative'

    ) NOT NULL,

    complaint_flag BOOLEAN NOT NULL,

    complaint_category VARCHAR(100) NULL,

    review_text TEXT NOT NULL

);

-- ==========================================================
-- Validate Tables
-- ==========================================================

SHOW TABLES;