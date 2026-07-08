# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_reviews.py
# Purpose     : Generate Reviews Data
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
# Reviews Generator Function
# ==========================================================

def generate_reviews():

    print("Generating Reviews Data...")

    np.random.seed(42)

    # ==========================================================
    # Read Fact Tables
    # ==========================================================

    orders_df = pd.read_csv(

        OUTPUT_FOLDER +

        "orders.csv"

    )

    print("\nOrders Loaded Successfully!")

        # ==========================================================
    # Store Reviews
    # ==========================================================

    reviews = []

    review_id = 1

        # ==========================================================
    # Validation
    # ==========================================================

    print("\nTotal Orders")

    print(len(orders_df))

    # ==========================================================
    # Generate Reviews
    # ==========================================================

    for _, order in orders_df.iterrows():

        order_id = order["order_id"]

        customer_id = order["customer_id"]

        restaurant_id = order["restaurant_id"]

        rider_id = order["rider_id"]

        order_status = order["order_status"]

        if order_status == "Cancelled":

            continue

        review_given = np.random.choice(

        [True, False],

        p=[0.60, 0.40]

        )

        if not review_given:

            continue

        # ==========================================================
        # Generate Rating
        # ==========================================================

        rating = np.random.choice(

            [1, 2, 3, 4, 5],

            p=[0.04, 0.06, 0.15, 0.35, 0.40]

        )

        # ==========================================================
        # Review Sentiment
        # ==========================================================

        if rating >= 4:

            review_sentiment = "Positive"

        elif rating == 3:

            review_sentiment = "Neutral"

        else:

            review_sentiment = "Negative"

        # ==========================================================
        # Complaint Flag
        # ==========================================================

        complaint_flag = rating <= 2

        # ==========================================================
        # Complaint Category
        # ==========================================================

        if complaint_flag:

            complaint_category = np.random.choice(

                [

                    "Late Delivery",

                    "Food Quality",

                    "Wrong Item",

                    "Packaging Issue",

                    "Rider Behaviour"

                ]

            )

        else:

            complaint_category = None

        # ==========================================================
        # Review Text
        # ==========================================================

        if review_sentiment == "Positive":

            review_text = np.random.choice([

                "Excellent service!",

                "Loved the food.",

                "Quick delivery and tasty food.",

                "Highly recommended.",

                "Will definitely order again."

            ])

        elif review_sentiment == "Neutral":

            review_text = np.random.choice([

                "Average experience.",

                "Food was okay.",

                "Delivery was acceptable.",

                "Nothing special.",

                "Could be better."

            ])

        else:

            review_text = np.random.choice([

                "Food quality was poor.",

                "Delivery took too long.",

                "Received the wrong order.",

                "Packaging was damaged.",

                "Very disappointing experience."

            ])

        # ==========================================================
        # Store Review
        # ==========================================================

        reviews.append({

            "review_id": review_id,

            "order_id": order_id,

            "customer_id": customer_id,

            "restaurant_id": restaurant_id,

            "rider_id": rider_id,

            "rating": rating,

            "review_sentiment": review_sentiment,

            "complaint_flag": complaint_flag,

            "complaint_category": complaint_category,

            "review_text": review_text

        })

        if review_id <= 5:

            print(

                f"Review {review_id} | "

                f"Rating {rating} ⭐ | "

                f"{review_sentiment} | "

                f"Complaint: {complaint_flag} | "

                f"Text: {review_text}"

            )

        review_id += 1

        # ==========================================================
    # Create Reviews DataFrame
    # ==========================================================

    reviews_df = pd.DataFrame(

        reviews

    )

    # ==========================================================
    # Validation
    # ==========================================================

    print("\nFirst 5 Records")

    print(

        reviews_df.head()

    )

    print("\nLast 5 Records")

    print(

        reviews_df.tail()

    )

    print("\nTotal Reviews Generated")

    print(

        len(reviews_df)

    )

    print("\nRating Distribution")

    print(

        reviews_df["rating"]

        .value_counts()

        .sort_index()

    )

    print("\nReview Sentiment Distribution")

    print(

        reviews_df["review_sentiment"]

        .value_counts()

    )

    print("\nComplaint Distribution")

    print(

        reviews_df["complaint_flag"]

        .value_counts()

    )

    print("\nAverage Rating")

    print(

        round(

            reviews_df["rating"]

            .mean(),

            2

        )

    )

    # ==========================================================
    # Export Reviews
    # ==========================================================

    reviews_df.to_csv(

        OUTPUT_FOLDER +

        "reviews.csv",

        index=False

    )

    print("\nReviews data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":

    generate_reviews()  