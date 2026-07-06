# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_weather.py
# Purpose     : Generate Daily Weather Data
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
# Weather Generator Function
# ==========================================================

def generate_weather():

    print("Generating Weather Data...")
    np.random.seed(42)

    # ==========================================================
    # Read Calendar Data
    # ==========================================================

    calendar_df = pd.read_csv(
        OUTPUT_FOLDER + "calendar.csv"
    )

    # Preview Calendar Data
    print("\nCalendar Data Loaded Successfully!")
    print(calendar_df.head())

    # ==========================================================
    # Generate Weather Condition
    # ==========================================================

    weather_conditions = []

    for season in calendar_df["season"]:

        if season == "Summer":

            weather = np.random.choice(
                ["Sunny", "Heatwave", "Cloudy"],
                p=[0.60, 0.20, 0.20]
            )

        elif season == "Monsoon":

            weather = np.random.choice(
                ["Rainy", "Storm", "Cloudy"],
                p=[0.60, 0.15, 0.25]
            )

        else:

            weather = np.random.choice(
                ["Sunny", "Cloudy", "Foggy"],
                p=[0.55, 0.30, 0.15]
            )

        weather_conditions.append(weather)

    calendar_df["weather_condition"] = weather_conditions

    # ==========================================================
    # Generate Temperature Category
    # ==========================================================

    temperature_mapping = {

        "Sunny": "Pleasant",
        "Cloudy": "Pleasant",
        "Rainy": "Pleasant",
        "Storm": "Pleasant",
        "Heatwave": "Hot",
        "Foggy": "Cold"

    }

    calendar_df["temperature_category"] = (
        calendar_df["weather_condition"]
        .map(temperature_mapping)
    )

    # ==========================================================
    # Generate Weather Severity
    # ==========================================================

    severity_mapping = {

        "Sunny": "Low",
        "Cloudy": "Low",
        "Rainy": "Medium",
        "Storm": "High",
        "Heatwave": "High",
        "Foggy": "Medium"

    }

    calendar_df["weather_severity"] = (
        calendar_df["weather_condition"]
        .map(severity_mapping)
    )

    # ==========================================================
    # Create Weather DataFrame
    # ==========================================================

    weather_df = calendar_df[
        [
            "calendar_id",
            "weather_condition",
            "temperature_category",
            "weather_severity"
        ]
    ].copy()

    weather_df.insert(
        0,
        "weather_id",
        range(1, len(weather_df) + 1)
    )



    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(weather_df.head())

    print("\nLast 5 Records")
    print(weather_df.tail())

    print(f"\nTotal Records Generated : {len(weather_df)}")

    # ==========================================================
    # Weather Distribution
    # ==========================================================

    print("\nWeather Distribution")
    print(weather_df["weather_condition"].value_counts())
    distribution = weather_df["weather_condition"].value_counts()

    percentage = (
        distribution
        / len(weather_df)
        * 100
    ).round(2)

    print("\nWeather Distribution")
    print(distribution)

    print("\nWeather Percentage")
    print(percentage)

    

    # ==========================================================
    # Export CSV
    # ==========================================================

    weather_df.to_csv(
        OUTPUT_FOLDER + "weather.csv",
        index=False
    )

    print("\nWeather data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":
    generate_weather()