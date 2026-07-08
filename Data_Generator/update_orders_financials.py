# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : update_orders_financials.py
# Purpose     : Update Orders Financial Data
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
# Update Orders Financials Function
# ==========================================================

def update_orders_financials():

    print("Updating Orders Financial Data...")

    # ==========================================================
    # Read Fact Tables
    # ==========================================================

    orders_df = pd.read_csv(

        OUTPUT_FOLDER +

        "orders.csv"

    )

    order_items_df = pd.read_csv(

        OUTPUT_FOLDER +

        "order_items.csv"

    )

    print("\nFact Tables Loaded Successfully!")

    # ==========================================================
    # Validation
    # ==========================================================

    print("\nTotal Orders")

    print(len(orders_df))

    print("\nTotal Order Items")

    print(len(order_items_df))

    # ==========================================================
    # Calculate Order Subtotal
    # ==========================================================

    subtotal_df = (

        order_items_df

        .groupby(

            "order_id"

        )["line_total"]

        .sum()

        .reset_index()

    )

    subtotal_df.rename(

        columns={

            "line_total": "subtotal"

        },

        inplace=True

    )

    # ==========================================================
    # Remove Existing Financial Columns
    # ==========================================================

    orders_df = orders_df.drop(

        columns=[

            "subtotal",

            "gst_amount",

            "discount_amount",

            "final_amount"

        ],

        errors="ignore"

    )

    # ==========================================================
    # Merge Subtotal
    # ==========================================================

    orders_df = orders_df.merge(

        subtotal_df,

        on="order_id",

        how="left"

    )

    print("\nColumns after merge:")

    print(orders_df.columns.tolist())

    print("\nFirst 5 Records")

    print(

        orders_df[

            ["order_id", "subtotal"]

        ].head()

    )

    print("\nLast 5 Records")

    print(

        orders_df[

            ["order_id", "subtotal"]

        ].tail()

    )

    print("\nAverage Order Subtotal")

    print(

        round(

            orders_df["subtotal"].mean(),

            2

        )

    )

        # ==========================================================
    # GST Amount
    # ==========================================================

    orders_df["gst_amount"] = (

        orders_df["subtotal"]

        * 0.05

    ).round(2)

    # ==========================================================
    # Discount Amount
    # ==========================================================

    orders_df["discount_amount"] = np.where(

        orders_df["promotion_id"].notna(),

        (

            orders_df["subtotal"]

            * 0.10

        ).round(2),

        0

    )

    # ==========================================================
    # Final Amount
    # ==========================================================

    orders_df["final_amount"] = (

        orders_df["subtotal"]

        +

        orders_df["gst_amount"]

        +

        orders_df["delivery_fee"]

        +

        orders_df["platform_fee"]

        -

        orders_df["discount_amount"]

    ).round(2)

    # ==========================================================
    # Cancelled Orders Financial Adjustment
    # ==========================================================

    cancelled_orders = (

        orders_df["order_status"] == "Cancelled"

    )

    orders_df.loc[

        cancelled_orders,

        [

            "subtotal",

            "gst_amount",

            "discount_amount",

            "final_amount"

        ]

    ] = 0

        # ==========================================================
    # Financial Validation
    # ==========================================================

    print("\nFinancial Summary")

    print(

        orders_df[[

            "subtotal",

            "gst_amount",

            "discount_amount",

            "delivery_fee",

            "platform_fee",

            "final_amount"

        ]].head()

    )

    print("\nAverage Subtotal")

    print(

        round(

            orders_df["subtotal"]

            .mean(),

            2

        )

    )

    print("\nAverage GST")

    print(

        round(

            orders_df["gst_amount"]

            .mean(),

            2

        )

    )

    print("\nAverage Discount")

    print(

        round(

            orders_df["discount_amount"]

            .mean(),

            2

        )

    )

    print("\nAverage Final Amount")

    print(

        round(

            orders_df["final_amount"]

            .mean(),

            2

        )

    )

        # ==========================================================
    # Export Updated Orders
    # ==========================================================

    orders_df.to_csv(

        OUTPUT_FOLDER +

        "orders.csv",

        index=False

    )

    print("\nOrders Financial Data Updated Successfully!")

# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":

    update_orders_financials()