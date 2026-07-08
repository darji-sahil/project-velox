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