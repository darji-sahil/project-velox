-- ==========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- File        : 03_add_foreign_keys.sql
-- Purpose     : Create Foreign Key Relationships
-- ==========================================================

-- ==========================================================
-- Delivery Zones → Cities
-- ==========================================================

ALTER TABLE delivery_zones
ADD CONSTRAINT fk_delivery_zone_city
FOREIGN KEY (city_id)
REFERENCES cities(city_id);

-- ==========================================================
-- Weather → Calendar
-- ==========================================================

ALTER TABLE weather
ADD CONSTRAINT fk_weather_calendar
FOREIGN KEY (calendar_id)
REFERENCES calendar(calendar_id);

-- ==========================================================
-- Restaurants → Delivery Zones
-- ==========================================================

ALTER TABLE restaurants
ADD CONSTRAINT fk_restaurant_zone
FOREIGN KEY (zone_id)
REFERENCES delivery_zones(zone_id);

-- ==========================================================
-- Restaurants → Restaurant Categories
-- ==========================================================

ALTER TABLE restaurants
ADD CONSTRAINT fk_restaurant_category
FOREIGN KEY (category_id)
REFERENCES restaurant_categories(category_id);

-- ==========================================================
-- Customers → Delivery Zones
-- ==========================================================

ALTER TABLE customers
ADD CONSTRAINT fk_customer_zone
FOREIGN KEY (zone_id)
REFERENCES delivery_zones(zone_id);

-- ==========================================================
-- Riders → Delivery Zones
-- ==========================================================

ALTER TABLE riders
ADD CONSTRAINT fk_rider_zone
FOREIGN KEY (zone_id)
REFERENCES delivery_zones(zone_id);

-- ==========================================================
-- Menu Items → Restaurants
-- ==========================================================

ALTER TABLE menu_items
ADD CONSTRAINT fk_menu_restaurant
FOREIGN KEY (restaurant_id)
REFERENCES restaurants(restaurant_id);

-- ==========================================================
-- Orders → Customers
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- ==========================================================
-- Orders → Restaurants
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_restaurant
FOREIGN KEY (restaurant_id)
REFERENCES restaurants(restaurant_id);

-- ==========================================================
-- Orders → Riders
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_rider
FOREIGN KEY (rider_id)
REFERENCES riders(rider_id);

-- ==========================================================
-- Orders → Calendar
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_calendar
FOREIGN KEY (calendar_id)
REFERENCES calendar(calendar_id);

-- ==========================================================
-- Orders → Weather
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_weather
FOREIGN KEY (weather_id)
REFERENCES weather(weather_id);

-- ==========================================================
-- Orders → Payments
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_payment
FOREIGN KEY (payment_id)
REFERENCES payments(payment_id);

-- ==========================================================
-- Orders → Promotions
-- ==========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_order_promotion
FOREIGN KEY (promotion_id)
REFERENCES promotions(promotion_id);

-- ==========================================================
-- Order Items → Orders
-- ==========================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_order_item_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- ==========================================================
-- Order Items → Menu Items
-- ==========================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_order_item_menu
FOREIGN KEY (menu_item_id)
REFERENCES menu_items(menu_item_id);

-- ==========================================================
-- Reviews → Orders
-- ==========================================================

ALTER TABLE reviews
ADD CONSTRAINT fk_review_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- ==========================================================
-- Reviews → Customers
-- ==========================================================

ALTER TABLE reviews
ADD CONSTRAINT fk_review_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- ==========================================================
-- Reviews → Restaurants
-- ==========================================================

ALTER TABLE reviews
ADD CONSTRAINT fk_review_restaurant
FOREIGN KEY (restaurant_id)
REFERENCES restaurants(restaurant_id);

-- ==========================================================
-- Reviews → Riders
-- ==========================================================

ALTER TABLE reviews
ADD CONSTRAINT fk_review_rider
FOREIGN KEY (rider_id)
REFERENCES riders(rider_id);

-- ==========================================================
-- Validate Foreign Keys
-- ==========================================================

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'project_velox'
AND REFERENCED_TABLE_NAME IS NOT NULL;