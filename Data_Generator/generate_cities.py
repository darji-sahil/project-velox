# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_cities.py
# Purpose     : Generate Cities Master Data
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
# Cities Generator Function
# ==========================================================

def generate_cities():

    print("Generating Cities Data...")

    cities = [

        [1, "Mumbai", "Maharashtra", "West"],
        [2, "Pune", "Maharashtra", "West"],
        [3, "Bengaluru", "Karnataka", "South"],
        [4, "Hyderabad", "Telangana", "South"],
        [5, "Ahmedabad", "Gujarat", "West"],
        [6, "Delhi", "Delhi", "North"]

    ]

    cities_df = pd.DataFrame(
        cities,
        columns=[
            "city_id",
            "city_name",
            "state",
            "region"
        ]
    )

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(cities_df.head())

    print("\nLast 5 Records")
    print(cities_df.tail())

    print(f"\nTotal Records Generated : {len(cities_df)}")

    # ==========================================================
    # Export CSV
    # ==========================================================

    cities_df.to_csv(
        OUTPUT_FOLDER + "cities.csv",
        index=False
    )

    print("\nCities data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":
    generate_cities()