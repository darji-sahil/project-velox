# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_orders.py
# Purpose     : Generate Restaurant Orders
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
# Order Generator Function
# ==========================================================

def generate_orders():

    print("Generating Orders Data...")

    np.random.seed(42)

    # ==========================================================
    # Read Master Data
    # ==========================================================

    customers_df = pd.read_csv(
        OUTPUT_FOLDER + "customers.csv"
    )

    restaurants_df = pd.read_csv(
        OUTPUT_FOLDER + "restaurants.csv"
    )

    riders_df = pd.read_csv(
        OUTPUT_FOLDER + "riders.csv"
    )

    calendar_df = pd.read_csv(
        OUTPUT_FOLDER + "calendar.csv"
    )

    weather_df = pd.read_csv(
        OUTPUT_FOLDER + "weather.csv"
    )

    print("\nCalendar Columns:")
    print(calendar_df.columns.tolist())

    print("\nWeather Columns:")
    print(weather_df.columns.tolist())

    promotions_df = pd.read_csv(
        OUTPUT_FOLDER + "promotions.csv"
    )

    payments_df = pd.read_csv(
        OUTPUT_FOLDER + "payments.csv"
    )

    print("\nMaster Data Loaded Successfully!")

    # ==========================================================
    # Total Orders
    # ==========================================================

    TOTAL_ORDERS = 50000

    # ==========================================================
    # Create Order Blueprint
    # ==========================================================

    order_blueprint = pd.DataFrame({

        "order_id": np.arange(

            1,

            TOTAL_ORDERS + 1

        )

    })

    print("\nOrder Blueprint Created Successfully!")

    print(order_blueprint.head())

    print("\nTotal Orders")

    print(len(order_blueprint))

    # ==========================================================
    # Store Orders
    # ==========================================================

    orders = []

    # ==========================================================
    # Generate Orders
    # ==========================================================

    for _, row in order_blueprint.iterrows():

        order_id = row["order_id"]

        customer = customers_df.sample(
            1
        ).iloc[0]

        customer_id = customer["customer_id"]

        customer_zone = customer["zone_id"]

        customer_segment = customer["customer_segment"]

        available_restaurants = restaurants_df[

            restaurants_df["zone_id"] == customer_zone

        ]

        restaurant = available_restaurants.sample(
            1
        ).iloc[0]

        restaurant_id = restaurant["restaurant_id"]

        calendar = calendar_df.sample(
            1
        ).iloc[0]

        calendar_id = calendar["calendar_id"]

        order_date = calendar["full_date"]

        meal_period = np.random.choice(

            ["Breakfast", "Lunch", "Evening", "Dinner"],

            p=[0.15, 0.35, 0.10, 0.40]

        )

        if meal_period == "Breakfast":

            order_time = pd.Timestamp(order_date) + pd.Timedelta(

                hours=np.random.randint(7, 11),

                minutes=np.random.randint(60)

            )

        elif meal_period == "Lunch":

            order_time = pd.Timestamp(order_date) + pd.Timedelta(

                hours=np.random.randint(12, 15),

                minutes=np.random.randint(60)

            )

        elif meal_period == "Evening":

            order_time = pd.Timestamp(order_date) + pd.Timedelta(

                hours=np.random.randint(16, 18),

                minutes=np.random.randint(60)

            )

        else:

            order_time = pd.Timestamp(order_date) + pd.Timedelta(

                hours=np.random.randint(19, 23),

                minutes=np.random.randint(60)

            )

        weather = weather_df[
            weather_df["calendar_id"] == calendar_id
        ].iloc[0]

        weather_id = weather["weather_id"]

        payment = payments_df.sample(
            1
        ).iloc[0]

        payment_id = payment["payment_id"]

        if np.random.random() < 0.30:

            promotion = promotions_df.sample(
                1
            ).iloc[0]

            promotion_id = promotion["promotion_id"]

        else:

            promotion_id = None

        restaurant_zone = restaurant["zone_id"]

        available_riders = riders_df[

            (riders_df["zone_id"] == restaurant_zone)

            &

            (riders_df["is_active"] == True)

        ]

        rider = available_riders.sample(
            1
        ).iloc[0]

        rider_id = rider["rider_id"]

        order_status = np.random.choice(

            ["Delivered", "Cancelled"],

            p=[0.94, 0.06]

        )

        if order_status == "Delivered":

            delivery_minutes = np.random.randint(

                20,

                61

            )

        else:

            delivery_minutes = None

        if order_status == "Delivered":

            delivered_time = (

                order_time +

                pd.Timedelta(

                    minutes=delivery_minutes

                )

            )

        else:

            delivered_time = None

        if order_status == "Cancelled":

            cancellation_reason = np.random.choice([

                "Customer Cancelled",

                "Restaurant Closed",

                "Rider Unavailable",

                "Payment Failed"

            ])

        else:

            cancellation_reason = None

        # ==========================================================
        # Delivery Fee
        # ==========================================================

        delivery_fee = np.random.choice(

            [0, 25, 40, 60],

            p=[0.15, 0.45, 0.30, 0.10]

        )

        # ==========================================================
        # Platform Fee
        # ==========================================================

        platform_fee = 10

        orders.append({

            "order_id": order_id,

            "customer_id": customer_id,

            "restaurant_id": restaurant_id,

            "rider_id": rider_id,

            "calendar_id": calendar_id,

            "weather_id": weather_id,

            "payment_id": payment_id,

            "promotion_id": promotion_id,

            "order_timestamp": order_time,

            "delivered_timestamp": delivered_time,

            "order_status": order_status,

            "delivery_minutes": delivery_minutes,

            "delivery_fee": delivery_fee,

            "platform_fee": platform_fee,

            "cancellation_reason": cancellation_reason

        })

    # ==========================================================
    # Create Orders DataFrame
    # ==========================================================

    orders_df = pd.DataFrame(
        orders
     )

    print("\nFirst 5 Records")

    print(orders_df.head())

    print("\nLast 5 Records")

    print(orders_df.tail())

    print("\nTotal Orders Generated")

    print(len(orders_df))

    print("\nOrder Status Distribution")

    print(

        orders_df["order_status"]

        .value_counts()

    )

    print("\nAverage Delivery Time")

    print(

           round(

               orders_df["delivery_minutes"]

              .dropna()

              .mean(),

              2

          )

    )

    print("\nPayment Distribution")

    print(

        orders_df["payment_id"]

        .value_counts()

    )

    print("\nPromotion Usage")

    print(

        orders_df["promotion_id"]

        .notna()

        .value_counts()

    )

    orders_df.to_csv(

        OUTPUT_FOLDER +

        "orders.csv",

        index=False

    )

    print("\nOrders data successfully exported!")



if __name__ == "__main__":
    generate_orders()    