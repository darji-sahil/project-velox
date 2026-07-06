# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_promotions.py
# Purpose     : Generate Promotions Master Data
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
# Promotions Generator Function
# ==========================================================

def generate_promotions():

    print("Generating Promotions Data...")

    promotions = [

        [1, "Welcome Offer", "Flat", 100.00, "Active"],
        [2, "Weekend Feast", "Percentage", 20.00, "Active"],
        [3, "Monsoon Saver", "Percentage", 15.00, "Active"],
        [4, "Free Delivery", "Flat", 40.00, "Active"],
        [5, "Lunch Combo", "Percentage", 10.00, "Active"],
        [6, "Midnight Munchies", "Flat", 75.00, "Active"],
        [7, "Festival Special", "Percentage", 25.00, "Active"],
        [8, "Family Pack", "Percentage", 18.00, "Active"],
        [9, "Student Saver", "Flat", 60.00, "Active"],
        [10, "Wallet Cashback", "Percentage", 12.00, "Active"],
        [11, "Summer Splash", "Percentage", 15.00, "Expired"],
        [12, "Winter Warmers", "Flat", 80.00, "Expired"]

    ]

    promotions_df = pd.DataFrame(
        promotions,
        columns=[
            "promotion_id",
            "promotion_name",
            "discount_type",
            "discount_value",
            "promotion_status"
        ]
    )

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(promotions_df.head())

    print("\nLast 5 Records")
    print(promotions_df.tail())

    print(f"\nTotal Records Generated : {len(promotions_df)}")

    # ==========================================================
    # Export CSV
    # ==========================================================

    promotions_df.to_csv(
        OUTPUT_FOLDER + "promotions.csv",
        index=False
    )

    print("\nPromotions data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":
    generate_promotions()