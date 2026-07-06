# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_restaurant_categories.py
# Purpose     : Generate Restaurant Categories Master Data
# ==========================================================

# ==========================================================
# Import Required Libraries
# ==========================================================

import pandas as pd

# ==========================================================
# Import Project Configuration
# ==========================================================

from config import OUTPUT_FOLDER


# ==========================================================
# Restaurant Categories Generator Function
# ==========================================================

def generate_restaurant_categories():

    print("Generating Restaurant Categories Data...")

    categories = [

        [1, "North Indian"],
        [2, "South Indian"],
        [3, "Chinese"],
        [4, "Biryani"],
        [5, "Pizza"],
        [6, "Burger & Fast Food"],
        [7, "Cafe & Bakery"],
        [8, "Desserts"],
        [9, "Beverages"],
        [10, "Healthy & Salads"]

    ]

    categories_df = pd.DataFrame(
        categories,
        columns=[
            "category_id",
            "category_name"
        ]
    )

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(categories_df.head())

    print("\nLast 5 Records")
    print(categories_df.tail())

    print(f"\nTotal Records Generated : {len(categories_df)}")

    # ==========================================================
    # Export CSV
    # ==========================================================

    categories_df.to_csv(
        OUTPUT_FOLDER + "restaurant_categories.csv",
        index=False
    )

    print("\nRestaurant Categories data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":
    generate_restaurant_categories()