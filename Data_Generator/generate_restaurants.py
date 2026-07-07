# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_restaurants.py
# Purpose     : Generate Restaurant Master Data
# ==========================================================

# ==========================================================
# Import Required Libraries
# ==========================================================

import pandas as pd
import numpy as np

# ==========================================================
# Import Project Configuration
# ==========================================================

from config import OUTPUT_FOLDER

# ==========================================================
# Restaurant Generator Function
# ==========================================================

def generate_restaurants():

    print("Generating Restaurant Data...")
    np.random.seed(42)

        # ==========================================================
    # Read Master Data
    # ==========================================================

    cities_df = pd.read_csv(
        OUTPUT_FOLDER + "cities.csv"
    )

    delivery_zones_df = pd.read_csv(
        OUTPUT_FOLDER + "delivery_zones.csv"
    )

    restaurant_categories_df = pd.read_csv(
        OUTPUT_FOLDER + "restaurant_categories.csv"
    )

    print("\nMaster Data Loaded Successfully!")

    # ==========================================================
    # Restaurant Distribution by City
    # ==========================================================

    city_distribution = {

        1: 30,      # Mumbai
        2: 18,      # Pune
        3: 24,      # Bengaluru
        4: 18,      # Hyderabad
        5: 12,      # Ahmedabad
        6: 18       # Delhi

    }

    # ==========================================================
    # Restaurant Distribution by Category
    # ==========================================================

    category_distribution = {

        1: 16,      # North Indian
        2: 12,      # South Indian
        3: 12,      # Chinese
        4: 14,      # Biryani
        5: 12,      # Pizza
        6: 16,      # Burger & Fast Food
        7: 12,      # Cafe & Bakery
        8: 10,      # Desserts
        9: 8,       # Beverages
        10: 8       # Healthy & Salads

    }

    # ==========================================================
    # Preparation Time Rules (Minutes)
    # ==========================================================

    preparation_time = {

        1: (20, 35),
        2: (12, 22),
        3: (15, 25),
        4: (25, 40),
        5: (20, 30),
        6: (10, 18),
        7: (8, 15),
        8: (5, 12),
        9: (3, 8),
        10: (8, 15)

    }

    # ==========================================================
    # Opening & Closing Hours
    # ==========================================================

    restaurant_timings = {

        1: ("11:00:00", "23:30:00"),
        2: ("07:00:00", "22:30:00"),
        3: ("11:00:00", "23:30:00"),
        4: ("11:00:00", "23:59:00"),
        5: ("11:00:00", "02:00:00"),
        6: ("10:00:00", "02:00:00"),
        7: ("08:00:00", "23:00:00"),
        8: ("10:00:00", "01:00:00"),
        9: ("09:00:00", "23:00:00"),
        10: ("08:00:00", "22:00:00")

    }

    # ==========================================================
    # Premium Restaurant Probability
    # ==========================================================

    premium_probability = {

        True: 0.20,
        False: 0.80

    }

    # ==========================================================
    # Create Restaurant Blueprint
    # ==========================================================

    city_list = []

    for city_id, count in city_distribution.items():
        city_list.extend([city_id] * count)

    category_list = []

    for category_id, count in category_distribution.items():
        category_list.extend([category_id] * count)

    np.random.shuffle(category_list)

    restaurant_blueprint = pd.DataFrame({

        "city_id": city_list,
        "category_id": category_list

    })

    print("\nRestaurant Blueprint Created Successfully!")

    print(restaurant_blueprint.head())

    print("\nTotal Restaurants")
    print(len(restaurant_blueprint))

    print("\nRestaurants Per City")
    print(restaurant_blueprint["city_id"].value_counts().sort_index())

    print("\nRestaurants Per Category")
    print(restaurant_blueprint["category_id"].value_counts().sort_index())

    # ==========================================================
    # Restaurant Name Templates
    # ==========================================================

    restaurant_names = {

        1: [
            "Spice Junction",
            "Royal Tandoor",
            "The Curry House",
            "Indian Flavours",
            "Punjab Grill",
            "Desi Kitchen",
            "Taste of India",
            "Curry Express"
        ],

        2: [
            "Dosa Corner",
            "South Spice",
            "Udupi Delight",
            "Sambar House",
            "Madras Kitchen",
            "Idli Express"
        ],

        3: [
            "Dragon Bowl",
            "Wok Express",
            "China Town",
            "Orient Kitchen",
            "Noodle House",
            "Golden Wok"
        ],

        4: [
            "Royal Biryani",
            "Biryani Express",
            "Dum House",
            "Hyderabad House",
            "Spice Dum",
            "Biryani Junction"
        ],

        5: [
            "Urban Slice",
            "Fire Crust",
            "Pizza Hub",
            "Stone Oven",
            "Pizza Nation",
            "Cheese Corner"
        ],

        6: [
            "Burger Factory",
            "Grill Nation",
            "Burger Point",
            "Fast Bites",
            "Snack Stop",
            "Burger Junction",
            "Crispy Hub",
            "Food Express"
        ],

        7: [
            "Cafe Aroma",
            "Bean Street",
            "Coffee Junction",
            "Brew Corner",
            "The Coffee Spot",
            "Daily Brew"
        ],

        8: [
            "Sweet Treats",
            "Dessert Hub",
            "Sugar Bowl",
            "Frozen Delights",
            "The Dessert Room"
        ],

        9: [
            "Juice Junction",
            "Fresh Sip",
            "Smoothie Point",
            "Cool Drinks"
        ],

        10: [
            "Healthy Bowl",
            "Green Kitchen",
            "Fresh Harvest",
            "Salad Stop"
        ]

    }

    # ==========================================================
    # Restaurant Name Suffixes
    # ==========================================================

    restaurant_suffixes = [

        "Kitchen",
        "Express",
        "Corner",
        "House",
        "Hub",
        "Point",
        "Bistro",
        "Cafe"

    ]

    # ==========================================================
    # Store Generated Restaurants
    # ==========================================================

    restaurants = []

    restaurant_id = 1

    # ==========================================================
    # Generate Restaurants
    # ==========================================================

    used_restaurant_names = set()

    for _, row in restaurant_blueprint.iterrows():

        city_id = row["city_id"]
        category_id = row["category_id"]

        # ------------------------------------------------------
        # Select Delivery Zone
        # ------------------------------------------------------

        city_zones = delivery_zones_df[
            delivery_zones_df["city_id"] == city_id
        ]

        zone = city_zones.sample(1).iloc[0]

        zone_id = zone["zone_id"]

        # ------------------------------------------------------
        # Generate Unique Restaurant Name
        # ------------------------------------------------------

        while True:

            base_name = np.random.choice(
                restaurant_names[category_id]
            )

            suffix = np.random.choice(
                restaurant_suffixes
            )

            restaurant_name = f"{base_name} {suffix}"

            if restaurant_name not in used_restaurant_names:

                used_restaurant_names.add(
                    restaurant_name
                )

                break

        # ------------------------------------------------------
        # Preparation Time
        # ------------------------------------------------------

        min_time, max_time = preparation_time[
            category_id
        ]

        avg_preparation_time = np.random.randint(
            min_time,
            max_time + 1
        )

        # ------------------------------------------------------
        # Restaurant Rating
        # ------------------------------------------------------

        average_rating = round(

            np.random.uniform(
                3.8,
                4.9
            ),

            1

        )

        # ------------------------------------------------------
        # Premium Restaurant
        # ------------------------------------------------------

        is_premium = np.random.choice(

        [True, False],

         p=[
        premium_probability[True],
        premium_probability[False]
         ]

         )

        # ------------------------------------------------------
        # Restaurant Timings
        # ------------------------------------------------------

        opening_time, closing_time = (
            restaurant_timings[
                category_id
            ]
        )

        # ------------------------------------------------------
        # Store Restaurant
        # ------------------------------------------------------

        restaurants.append([

            restaurant_id,

            zone_id,

            category_id,

            restaurant_name,

            avg_preparation_time,

            average_rating,

            is_premium,

            opening_time,

            closing_time

        ])

        restaurant_id += 1

    # ==========================================================
    # Create Restaurant DataFrame
    # ==========================================================

    restaurants_df = pd.DataFrame(

        restaurants,

        columns=[

            "restaurant_id",
            "zone_id",
            "category_id",
            "restaurant_name",
            "average_preparation_time",
            "average_rating",
            "is_premium",
            "opening_time",
            "closing_time"

        ]

    )

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(restaurants_df.head())

    print("\nLast 5 Records")
    print(restaurants_df.tail())

    print(f"\nTotal Restaurants Generated : {len(restaurants_df)}")

    print("\nUnique Restaurant Names")
    print(restaurants_df["restaurant_name"].nunique())

    # ==========================================================
    # Validation Checks
    # ==========================================================

    print("\nRestaurants Per Category")

    print(

        restaurants_df["category_id"]
        .value_counts()
        .sort_index()

    )

    print("\nPremium Restaurants")

    print(

        restaurants_df["is_premium"]
        .value_counts()

    )

    # ==========================================================
    # Export CSV
    # ==========================================================

    restaurants_df.to_csv(

        OUTPUT_FOLDER + "restaurants.csv",

        index=False

    )

    print("\nRestaurants data successfully exported!")

    

if __name__ == "__main__":
    generate_restaurants()