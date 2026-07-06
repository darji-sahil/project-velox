# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_payments.py
# Purpose     : Generate Payment Methods Master Data
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
# Payments Generator Function
# ==========================================================

def generate_payments():

    print("Generating Payments Data...")

    payments = [

        [1, "UPI", "Successful"],
        [2, "Credit Card", "Successful"],
        [3, "Debit Card", "Successful"],
        [4, "Cash", "Successful"],
        [5, "Wallet", "Successful"]

    ]

    payments_df = pd.DataFrame(
        payments,
        columns=[
            "payment_id",
            "payment_method",
            "payment_status"
        ]
    )

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(payments_df.head())

    print("\nLast 5 Records")
    print(payments_df.tail())

    print(f"\nTotal Records Generated : {len(payments_df)}")

    # ==========================================================
    # Export CSV
    # ==========================================================

    payments_df.to_csv(
        OUTPUT_FOLDER + "payments.csv",
        index=False
    )

    print("\nPayments data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":
    generate_payments()