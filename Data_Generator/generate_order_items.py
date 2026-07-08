# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_order_items.py
# Purpose     : Generate Order Items Data
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
# Order Items Generator Function
# ==========================================================

def generate_order_items():

    print("Generating Order Items Data...")

    np.random.seed(42)

    # ==========================================================
    # Read Master Data
    # ==========================================================

    orders_df = pd.read_csv(

        OUTPUT_FOLDER +

        "orders.csv"

    )

    menu_items_df = pd.read_csv(

        OUTPUT_FOLDER +

        "menu_items.csv"

    )

    print("\nMaster Data Loaded Successfully!")

    # ==========================================================
    # Store Order Items
    # ==========================================================

    order_items = []

    order_item_id = 1

    # ==========================================================
    # Validation
    # ==========================================================

    print("\nTotal Orders")

    print(len(orders_df))

    print("\nTotal Menu Items")

    print(len(menu_items_df))

    # ==========================================================
    # Generate Order Items
    # ==========================================================

    for _, order in orders_df.iterrows():

        order_id = order["order_id"]

        restaurant_id = order["restaurant_id"]

        restaurant_menu = menu_items_df[

        menu_items_df["restaurant_id"] == restaurant_id

        ]

        basket_size = np.random.choice(

        [1, 2, 3, 4, 5],

        p=[0.20, 0.35, 0.25, 0.15, 0.05]

        )

        selected_items = restaurant_menu.sample(

        n=basket_size,

        replace=False

        )

        for _, item in selected_items.iterrows():

            menu_item_id = item["menu_item_id"]

            unit_price = item["unit_price"]

            quantity = np.random.choice(

                [1, 2, 3],

                p=[0.70, 0.25, 0.05]

            )

            line_total = quantity * unit_price

            order_items.append({

                "order_item_id": order_item_id,

                "order_id": order_id,

                "menu_item_id": menu_item_id,

                "quantity": quantity,

                "unit_price": unit_price,

                "line_total": line_total

            })

            order_item_id += 1

        if order_id <= 5:

            print(

            f"Order {order_id} "

            f"generated successfully."

        )
            
    # ==========================================================
    # Create Order Items DataFrame
    # ==========================================================

    order_items_df = pd.DataFrame(

        order_items

        )
    
    print("\nFirst 5 Records")

    print(order_items_df.head())

    print("\nLast 5 Records")

    print(order_items_df.tail())

    print("\nTotal Order Items Generated")

    print(len(order_items_df))

    print("\nQuantity Distribution")

    print(

        order_items_df["quantity"]

        .value_counts()

    )

    print("\nAverage Quantity")

    print(

        round(

            order_items_df["quantity"]

            .mean(),

            2

        )

    )

    print("\nAverage Line Total")

    print(

        round(

            order_items_df["line_total"]

            .mean(),

            2

        )

    )

    order_items_df.to_csv(

    OUTPUT_FOLDER +

        "order_items.csv",

        index=False

    )

    print("\nOrder Items data successfully exported!")

     

# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":

    generate_order_items()