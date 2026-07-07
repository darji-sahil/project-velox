# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_delivery_zones.py
# Purpose     : Generate Delivery Zones Master Data
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
# Delivery Zones Generator Function
# ==========================================================

def generate_delivery_zones():

    print("Generating Delivery Zones Data...")

    delivery_zones = [

        # =====================================================
        # Mumbai (8)
        # =====================================================

        [1, 1, "Andheri", "Commercial"],
        [2, 1, "Bandra", "Residential"],
        [3, 1, "Powai", "IT Hub"],
        [4, 1, "Dadar", "Commercial"],
        [5, 1, "Borivali", "Residential"],
        [6, 1, "Ghatkopar", "Residential"],
        [7, 1, "Colaba", "Commercial"],
        [8, 1, "Navi Mumbai", "IT Hub"],


        # =====================================================
        # Pune (5)
        # =====================================================

        [9, 2, "Hinjawadi", "IT Hub"],
        [10, 2, "Baner", "Residential"],
        [11, 2, "Wakad", "Residential"],
        [12, 2, "Kothrud", "Residential"],
        [13, 2, "Viman Nagar", "Commercial"],


        # =====================================================
        # Bengaluru (7)
        # =====================================================

        [14, 3, "Whitefield", "IT Hub"],
        [15, 3, "Electronic City", "IT Hub"],
        [16, 3, "Koramangala", "Commercial"],
        [17, 3, "Indiranagar", "Residential"],
        [18, 3, "HSR Layout", "Residential"],
        [19, 3, "Yelahanka", "Residential"],
        [20, 3, "Jayanagar", "Residential"],


        # =====================================================
        # Hyderabad (6)
        # =====================================================

        [21, 4, "Hitech City", "IT Hub"],
        [22, 4, "Gachibowli", "IT Hub"],
        [23, 4, "Madhapur", "Commercial"],
        [24, 4, "Kukatpally", "Residential"],
        [25, 4, "Banjara Hills", "Residential"],
        [26, 4, "Secunderabad", "Commercial"],


        # =====================================================
        # Ahmedabad (5)
        # =====================================================

        [27, 5, "Satellite", "Residential"],
        [28, 5, "Navrangpura", "Commercial"],
        [29, 5, "Prahlad Nagar", "Commercial"],
        [30, 5, "SG Highway", "IT Hub"],
        [31, 5, "Maninagar", "Residential"],


        # =====================================================
        # Delhi (8)
        # =====================================================

        [32, 6, "Connaught Place", "Commercial"],
        [33, 6, "Dwarka", "Residential"],
        [34, 6, "Saket", "Residential"],
        [35, 6, "Rohini", "Residential"],
        [36, 6, "Nehru Place", "Commercial"],
        [37, 6, "Noida Sector 62", "IT Hub"],
        [38, 6, "Lajpat Nagar", "Commercial"],
        [39, 6, "Karol Bagh", "Commercial"]

    ]

    delivery_zones_df = pd.DataFrame(

        delivery_zones,

        columns=[

            "zone_id",
            "city_id",
            "zone_name",
            "zone_type"

        ]

    )

    # ==========================================================
    # Export CSV
    # ==========================================================

    delivery_zones_df.to_csv(

        OUTPUT_FOLDER + "delivery_zones.csv",

        index=False

    )

    print("\nDelivery Zones data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":

    generate_delivery_zones()