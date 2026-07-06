-- ===========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- Database    : MySQL 8.0.43
-- Created On  : 06-Jul-2026
-- ===========================================================

-- ===========================================================
-- Project Velox
-- Physical Database Schema
-- ===========================================================
-- Purpose:
-- Creates all database tables, primary keys,
-- foreign keys, and core business entities.
--
-- Execution Order:
-- Run after 01_create_database.sql
--
-- Total Tables:
-- 13
-- ===========================================================


-- ===========================================================
-- Table: Cities
-- Purpose:
-- Stores all operational cities served by the
-- Velox Food Delivery Platform.
-- ===========================================================

CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL UNIQUE,
    state VARCHAR(50) NOT NULL,
    region ENUM('North','South','East','West','Central') NOT NULL
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Delivery Zones
-- Purpose:
-- Represents delivery regions within each city.
-- Used for operational and geographical analysis.
-- ===========================================================

CREATE TABLE delivery_zones (
    zone_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    zone_name VARCHAR(100) NOT NULL,
    zone_type ENUM('Residential','Commercial','Mixed') NOT NULL,
    avg_traffic_level ENUM('Low','Medium','High') NOT NULL,

    CONSTRAINT fk_delivery_zone_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Restaurant Categories
-- Purpose:
-- Stores cuisine and restaurant category information.
-- ===========================================================

CREATE TABLE restaurant_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Restaurants
-- Purpose:
-- Stores restaurant partner information including
-- category, operating hours, pricing and location.
-- ===========================================================

CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(120) NOT NULL,
    category_id INT NOT NULL,
    city_id INT NOT NULL,
    zone_id INT NOT NULL,
    average_cost DECIMAL(10,2) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
    restaurant_status ENUM(
        'Active',
        'Temporarily Closed',
        'Inactive'
    ) DEFAULT 'Active',

    CONSTRAINT fk_restaurant_category
        FOREIGN KEY (category_id)
        REFERENCES restaurant_categories(category_id),
        
    CONSTRAINT fk_restaurant_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id),

    CONSTRAINT fk_restaurant_zone
        FOREIGN KEY (zone_id)
        REFERENCES delivery_zones(zone_id)

) ENGINE=InnoDB;

-- ===========================================================
-- Table: Riders
-- Purpose:
-- Stores delivery partner information including
-- employment details and assigned city.
-- ===========================================================

CREATE TABLE riders (
    rider_id INT AUTO_INCREMENT PRIMARY KEY,
    rider_name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,
    vehicle_type ENUM(
        'Bike',
        'Scooter',
        'Bicycle'
    ) NOT NULL,
    joining_date DATE NOT NULL,
    employment_type ENUM(
        'Full-Time',
        'Part-Time'
    ) NOT NULL,
    rider_status ENUM(
        'Active',
        'Inactive',
        'On Leave'
    ) DEFAULT 'Active',
    CONSTRAINT fk_rider_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Customers
-- Purpose:
-- Stores customer demographic and membership
-- information for analytics and personalization.
-- ===========================================================

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    gender ENUM(
        'Male',
        'Female',
        'Other'
    ) NOT NULL,
    age_group ENUM(
        '18-25',
        '26-35',
        '36-45',
        '46-60',
        '60+'
    ) NOT NULL,
    membership_level ENUM(
        'Standard',
        'Gold',
        'Premium'
    ) DEFAULT 'Standard',
    registration_date DATE NOT NULL
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Weather
-- Purpose:
-- Stores daily weather information used to analyse
-- operational performance and delivery efficiency.
-- ===========================================================

CREATE TABLE weather (
    weather_id INT AUTO_INCREMENT PRIMARY KEY,
    weather_condition ENUM(
        'Sunny',
        'Cloudy',
        'Rainy',
        'Storm'
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
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Calendar
-- Purpose:
-- Stores date-related attributes including
-- weekends, festivals and seasonal information.
-- ===========================================================

CREATE TABLE calendar (
    calendar_id INT AUTO_INCREMENT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
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
    festival_flag BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Payments
-- Purpose:
-- Stores payment methods and payment status
-- used during order transactions.
-- ===========================================================

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method ENUM(
        'UPI',
        'Credit Card',
        'Debit Card',
        'Cash',
        'Wallet'
    ) NOT NULL,
    payment_status ENUM(
        'Successful',
        'Failed',
        'Refunded'
    ) NOT NULL
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Promotions
-- Purpose:
-- Stores promotional campaigns and discount
-- information offered by the platform.
-- ===========================================================

CREATE TABLE promotions (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    discount_type ENUM(
        'Flat',
        'Percentage'
    ) NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    promotion_status ENUM(
        'Active',
        'Expired'
    ) DEFAULT 'Active'
) ENGINE=InnoDB;

-- ===========================================================
-- Table: Orders
-- Purpose:
-- Central fact table containing every order placed
-- on the Velox platform.
--
-- This table powers:
-- • Revenue Analysis
-- • Delivery Analytics
-- • Customer Behaviour
-- • Operational KPIs
-- • Restaurant Performance
-- ===========================================================

CREATE TABLE orders (

    -- ==========================
    -- Order Identification
    -- ==========================

    order_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_id INT NOT NULL,

    restaurant_id INT NOT NULL,

    rider_id INT NOT NULL,

    zone_id INT NOT NULL,

    calendar_id INT NOT NULL,

    weather_id INT NOT NULL,

    payment_id INT NOT NULL,

    promotion_id INT NULL,

    -- ==========================
    -- Order Lifecycle
    -- ==========================

    order_time DATETIME NOT NULL,

    accepted_time DATETIME NULL,

    preparation_start_time DATETIME NULL,

    estimated_preparation_minutes SMALLINT UNSIGNED NOT NULL,

    ready_for_pickup_time DATETIME NULL,

    pickup_time DATETIME NULL,

    delivered_time DATETIME NULL,

    -- ==========================
    -- Financial Details
    -- ==========================

    food_amount DECIMAL(10,2) NOT NULL,

    delivery_fee DECIMAL(10,2) NOT NULL,

    platform_fee DECIMAL(10,2) NOT NULL,

    discount_amount DECIMAL(10,2) DEFAULT 0.00,

    tax_amount DECIMAL(10,2) NOT NULL,

    tip_amount DECIMAL(10,2) DEFAULT 0.00,

    final_amount DECIMAL(10,2) NOT NULL,

    -- ==========================
    -- Order Status
    -- ==========================

    order_status ENUM(
        'Delivered',
        'Cancelled',
        'Refunded'
    ) NOT NULL,

    cancellation_reason VARCHAR(100),

    delivery_type ENUM(
        'Standard',
        'Express'
    ) DEFAULT 'Standard',

    -- ==========================
    -- Customer Feedback
    -- ==========================

    overall_rating DECIMAL(2,1),

    food_rating DECIMAL(2,1),

    delivery_rating DECIMAL(2,1),

    review_submitted BOOLEAN DEFAULT FALSE,

    -- ==========================
    -- Operational Metrics
    -- ==========================

    delivery_distance_km DECIMAL(5,2) NOT NULL,

    estimated_delivery_minutes SMALLINT UNSIGNED NOT NULL,

    actual_delivery_minutes SMALLINT UNSIGNED,

    -- ==========================
    -- Audit
    -- ==========================

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    -- ==========================
    -- Foreign Keys
    -- ==========================

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_orders_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),

    CONSTRAINT fk_orders_rider
        FOREIGN KEY (rider_id)
        REFERENCES riders(rider_id),

    CONSTRAINT fk_orders_zone
        FOREIGN KEY (zone_id)
        REFERENCES delivery_zones(zone_id),

    CONSTRAINT fk_orders_calendar
        FOREIGN KEY (calendar_id)
        REFERENCES calendar(calendar_id),

    CONSTRAINT fk_orders_weather
        FOREIGN KEY (weather_id)
        REFERENCES weather(weather_id),

    CONSTRAINT fk_orders_payment
        FOREIGN KEY (payment_id)
        REFERENCES payments(payment_id),

    CONSTRAINT fk_orders_promotion
        FOREIGN KEY (promotion_id)
        REFERENCES promotions(promotion_id)

) ENGINE=InnoDB;

-- ===========================================================
-- Table: Complaints
-- Purpose:
-- Stores customer complaints associated with
-- completed or cancelled orders.
-- ===========================================================

CREATE TABLE complaints (

    complaint_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id INT NOT NULL UNIQUE,

    complaint_category ENUM(
        'Late Delivery',
        'Food Quality',
        'Missing Item',
        'Wrong Order'
    ) NOT NULL,

    resolution_status ENUM(
        'Pending',
        'Resolved'
    ) DEFAULT 'Pending',

    resolution_time_minutes SMALLINT UNSIGNED,

    customer_satisfaction_after_resolution DECIMAL(2,1),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_complaint_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

) ENGINE=InnoDB;

-- ===========================================================
-- Table: Order Items
-- Purpose:
-- Stores every individual item purchased within
-- an order for menu and basket analysis.
-- ===========================================================

CREATE TABLE order_items (

    order_item_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id INT NOT NULL,

    item_name VARCHAR(120) NOT NULL,

    category ENUM(
        'Starter',
        'Main Course',
        'Dessert',
        'Beverage'
    ) NOT NULL,

    quantity TINYINT UNSIGNED NOT NULL,

    unit_price DECIMAL(10,2) NOT NULL,

    total_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

) ENGINE=InnoDB;