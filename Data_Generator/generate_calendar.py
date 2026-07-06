# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_calendar.py
# Purpose     : Generate Calendar Dimension Data
# ==========================================================

# Import required libraries
import pandas as pd

# Import configuration variables
from config import START_DATE, END_DATE, OUTPUT_FOLDER

from festival_dates import FESTIVALS


# ==========================================================
# Calendar Generator Function
# ==========================================================
def generate_calendar():

    print("Generating Calendar Data...")

    # Generate all dates between start and end date
    date_range = pd.date_range(
        start=START_DATE,
        end=END_DATE,
        freq="D"
    )

    # Create DataFrame
    calendar_df = pd.DataFrame({
        "full_date": date_range
    })

    # Generate Calendar ID
    calendar_df.insert(
        0,
        "calendar_id",
        range(1, len(calendar_df) + 1)
    )

    # ==========================================================
    # Generate Date Attributes
    # ==========================================================

    # Generate Day Name
    calendar_df["day_name"] = calendar_df["full_date"].dt.day_name()

    # Generate Week Number
    calendar_df["week_number"] = (
        calendar_df["full_date"]
        .dt
        .isocalendar()
        .week
    )

    # Generate Month Name
    calendar_df["month_name"] = calendar_df["full_date"].dt.month_name()

    # Generate Quarter
    calendar_df["quarter"] = (
        "Q" +
        calendar_df["full_date"]
        .dt
        .quarter
        .astype(str)
    )

    # Generate Year
    calendar_df["year"] = calendar_df["full_date"].dt.year

    # Generate Weekend Flag
    calendar_df["is_weekend"] = (
        calendar_df["full_date"]
        .dt
        .dayofweek
        >= 5
    )

    # ==========================================================
    # Generate Business Calendar Attributes
    # ==========================================================

    # Generate Season
    calendar_df["season"] = calendar_df["full_date"].dt.month.map(
        {
            1: "Winter",
            2: "Winter",

            3: "Summer",
            4: "Summer",
            5: "Summer",

            6: "Monsoon",
            7: "Monsoon",
            8: "Monsoon",
            9: "Monsoon",

            10: "Winter",
            11: "Winter",
            12: "Winter"
        }
    )

    # ==========================================================
    # Generate Festival Flag
    # ==========================================================

    calendar_df["festival_flag"] = (
        calendar_df["full_date"]
        .astype(str)
        .isin(FESTIVALS)
    )

    print("\nFirst 5 Records")
    print(calendar_df.head())

    print("\nLast 5 Records")
    print(calendar_df.tail())

    print(f"\nTotal Records Generated: {len(calendar_df)}")

    # ==========================================================
    # Export Calendar Data to CSV
# ==========================================================

    calendar_df.to_csv(
        OUTPUT_FOLDER + "calendar.csv",
        index=False
    )


    print("\nCalendar data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================
if __name__ == "__main__":
    generate_calendar()