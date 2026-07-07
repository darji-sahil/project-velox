# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_customers.py
# Purpose     : Generate Customer Master Data
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
# Customer Generator Function
# ==========================================================

def generate_customers():

    print("Generating Customer Data...")

    np.random.seed(42)

    # ==========================================================
    # Read Master Data
    # ==========================================================

    cities_df = pd.read_csv(
        OUTPUT_FOLDER + "cities.csv"
    )

    delivery_zones_df = pd.read_csv(
        OUTPUT_FOLDER + "delivery_zones.csv"
    )

    calendar_df = pd.read_csv(
        OUTPUT_FOLDER + "calendar.csv"
    )

    print("\nMaster Data Loaded Successfully!")

    # ==========================================================
    # Customer Distribution by City
    # ==========================================================

    customer_distribution = {

        1: 500,      # Mumbai
        2: 300,      # Pune
        3: 400,      # Bengaluru
        4: 300,      # Hyderabad
        5: 200,      # Ahmedabad
        6: 300       # Delhi

    }

    # ==========================================================
    # Customer Segment Distribution
    # ==========================================================

    segment_distribution = {

        "Student": 500,
        "Working Professional": 800,
        "Family": 500,
        "Food Enthusiast": 200

    }

    # ==========================================================
    # Gender Probability
    # ==========================================================

    gender_probability = {

        "Male": 0.52,
        "Female": 0.46,
        "Other": 0.02

    }

    # ==========================================================
    # Active Customer Probability
    # ==========================================================

    active_probability = {

        True: 0.85,
        False: 0.15

    }

    # ==========================================================
    # Age Rules by Segment
    # ==========================================================

    age_rules = {

        "Student": (18, 25),

        "Working Professional": (23, 40),

        "Family": (30, 55),

        "Food Enthusiast": (22, 45)

    }

    # ==========================================================
    # Male First Names by City
    # ==========================================================

    male_first_names = {

        # Mumbai
        1: [
            "Aarav", "Atharva", "Om", "Vedant", "Rohan",
            "Aditya", "Soham", "Yash", "Karan", "Akash",
            "Harsh", "Nikhil", "Pranav", "Ritvik", "Siddharth",
            "Aryan", "Tanmay", "Aniket", "Swapnil", "Tejas"
        ],

        # Pune
        2: [
            "Omkar", "Atharva", "Rohan", "Vedant", "Aditya",
            "Yash", "Soham", "Akshay", "Harshal", "Aniruddh",
            "Shreyas", "Pratik", "Nilesh", "Rushikesh", "Kunal",
            "Ritesh", "Sagar", "Sameer", "Amol", "Abhishek"
        ],

        # Bengaluru
        3: [
            "Arjun", "Karthik", "Pranav", "Vikram", "Naveen",
            "Rohit", "Manoj", "Harish", "Santosh", "Rakesh",
            "Pavan", "Darshan", "Ganesh", "Deepak", "Mohan",
            "Shreyas", "Abhinav", "Nithin", "Varun", "Suraj"
        ],

        # Hyderabad
        4: [
            "Sai", "Teja", "Vamsi", "Charan", "Nikhil",
            "Rohit", "Abhi", "Kiran", "Sandeep", "Tarun",
            "Lokesh", "Ashwin", "Raghu", "Srinivas", "Praveen",
            "Chaitanya", "Ajay", "Naresh", "Vivek", "Manish"
        ],

        # Ahmedabad
        5: [
            "Meet", "Dhruv", "Harsh", "Dev", "Yash",
            "Jay", "Parth", "Krish", "Aum", "Tirth",
            "Nisarg", "Bhavin", "Ronak", "Chirag", "Jenil",
            "Darsh", "Rutvik", "Smit", "Milan", "Kush"
        ],

        # Delhi
        6: [
            "Aryan", "Vivaan", "Laksh", "Kunal", "Aman",
            "Rahul", "Rajat", "Ansh", "Kabir", "Krish",
            "Mohit", "Tushar", "Rishabh", "Arpit", "Naman",
            "Yuvraj", "Adarsh", "Gaurav", "Manav", "Raghav"
        ]

    }

    # ==========================================================
    # Female First Names by City
    # ==========================================================

    female_first_names = {

        1: [
            "Priya", "Sneha", "Ananya", "Kavya", "Pooja",
            "Neha", "Riya", "Meera", "Diya", "Tanvi",
            "Naina", "Aisha", "Ishita", "Shruti", "Sakshi",
            "Vaishnavi", "Komal", "Rutuja", "Ankita", "Swara"
        ],

        2: [
            "Sneha", "Rutuja", "Prajakta", "Sayali", "Pallavi",
            "Tejal", "Anuja", "Neha", "Komal", "Shraddha",
            "Madhura", "Vaishnavi", "Pooja", "Sonal", "Shweta",
            "Monali", "Aarti", "Riya", "Ankita", "Swati"
        ],

        3: [
            "Ananya", "Divya", "Deepa", "Pavithra", "Aishwarya",
            "Shreya", "Bhavana", "Rashmi", "Nandini", "Meghana",
            "Keerthi", "Sindhu", "Harini", "Sanjana", "Anusha",
            "Lavanya", "Priyanka", "Sowmya", "Kavitha", "Pooja"
        ],

        4: [
            "Sravani", "Keerthi", "Bhargavi", "Niharika", "Harika",
            "Akhila", "Swathi", "Sindhu", "Pooja", "Lavanya",
            "Madhavi", "Divya", "Meghana", "Anusha", "Tejaswini",
            "Aparna", "Ramya", "Sneha", "Sushmita", "Deepika"
        ],

        5: [
            "Khushi", "Hetal", "Jinal", "Krupa", "Riddhi",
            "Nidhi", "Dhara", "Mitali", "Pooja", "Bhavya",
            "Palak", "Kinjal", "Shreya", "Komal", "Aarti",
            "Sneha", "Kajal", "Neha", "Ishita", "Diya"
        ],

        6: [
            "Simran", "Anjali", "Ritika", "Muskan", "Payal",
            "Nikita", "Sanya", "Shivani", "Aditi", "Tanya",
            "Riya", "Priya", "Pallavi", "Mehak", "Sneha",
            "Ishita", "Naina", "Diya", "Kritika", "Sakshi"
        ]

    }

    

    

    # ==========================================================
    # Last Names by City
    # ==========================================================

    last_names = {

        1: [
            "Patil", "Deshmukh", "Kulkarni", "Joshi", "Pawar",
            "Shinde", "Jadhav", "Sawant", "More", "Chavan",
            "Bhosale", "Gawande", "Kale", "Naik", "Kadam"
        ],

        2: [
            "Kulkarni", "Joshi", "Patil", "Deshpande", "Pawar",
            "Shinde", "Gokhale", "Sathe", "Bapat", "Apte",
            "Limaye", "Agashe", "Karandikar", "Nene", "Phadke"
        ],

        3: [
            "Rao", "Shetty", "Hegde", "Gowda", "Murthy",
            "Bhat", "Acharya", "Pai", "Reddy", "Naik",
            "Prasad", "Shenoy", "Shekar", "Kulkarni", "Kamath"
        ],

        4: [
            "Reddy", "Naidu", "Rao", "Krishna", "Raju",
            "Varma", "Chowdary", "Goud", "Yadav", "Patel",
            "Sai", "Ramesh", "Kumar", "Sharma", "Reddy"
        ],

        5: [
            "Patel", "Shah", "Trivedi", "Bhatt", "Gandhi",
            "Mehta", "Parikh", "Dave", "Modi", "Pandya",
            "Joshi", "Desai", "Vyas", "Thakkar", "Brahmbhatt"
        ],

        6: [
            "Sharma", "Singh", "Gupta", "Malhotra", "Khanna",
            "Arora", "Batra", "Verma", "Kapoor", "Saxena",
            "Agarwal", "Mathur", "Chopra", "Tandon", "Goyal"
        ]

    }

    # ==========================================================
    # Customer Persona
    # Used Later While Generating Orders
    # ==========================================================

    customer_persona = {

        "Student": {

            "promotion_probability": 0.80,
            "late_night_probability": 0.75,
            "premium_restaurant_probability": 0.10

        },

        "Working Professional": {

            "promotion_probability": 0.35,
            "late_night_probability": 0.15,
            "premium_restaurant_probability": 0.40

        },

        "Family": {

            "promotion_probability": 0.25,
            "late_night_probability": 0.05,
            "premium_restaurant_probability": 0.45

        },

        "Food Enthusiast": {

            "promotion_probability": 0.40,
            "late_night_probability": 0.20,
            "premium_restaurant_probability": 0.70

        }

    }

    # ==========================================================
    # Create Customer Blueprint
    # ==========================================================

    city_list = []

    for city_id, count in customer_distribution.items():

        city_list.extend([city_id] * count)

    segment_list = []

    for segment, count in segment_distribution.items():

        segment_list.extend([segment] * count)

    np.random.shuffle(segment_list)

    customer_blueprint = pd.DataFrame({

        "city_id": city_list,

        "customer_segment": segment_list

    })

    print("\nCustomer Blueprint Created Successfully!")

    print(customer_blueprint.head())

    print("\nTotal Customers")
    print(len(customer_blueprint))

    print("\nCustomers Per City")
    print(customer_blueprint["city_id"].value_counts().sort_index())

    print("\nCustomers Per Segment")
    print(customer_blueprint["customer_segment"].value_counts())

    # ==========================================================
    # Create Unique Customer Name Pools
    # ==========================================================

    male_name_pool = {}
    female_name_pool = {}
    other_name_pool = {}

    for city_id in customer_distribution.keys():

        # ---------------- Male ----------------

        male_names = []

        for first_name in male_first_names[city_id]:

            for last_name in last_names[city_id]:

                male_names.append(
                    f"{first_name} {last_name}"
                )

        np.random.shuffle(male_names)

        male_name_pool[city_id] = male_names

        # ---------------- Female ----------------

        female_names = []

        for first_name in female_first_names[city_id]:

            for last_name in last_names[city_id]:

                female_names.append(
                    f"{first_name} {last_name}"
                )

        np.random.shuffle(female_names)

        female_name_pool[city_id] = female_names

        # ---------------- Other ----------------

        other_names = []

        combined_names = (
            male_first_names[city_id] +
            female_first_names[city_id]
        )

        for first_name in combined_names:

            for last_name in last_names[city_id]:

                other_names.append(
                    f"{first_name} {last_name}"
                )

        np.random.shuffle(other_names)

        other_name_pool[city_id] = other_names

    # ==========================================================
    # Store Customers
    # ==========================================================

    customers = []

    customer_id = 1

    

    # ==========================================================
    # Generate Customers
    # ==========================================================

    for _, row in customer_blueprint.iterrows():

        city_id = row["city_id"]

        customer_segment = row["customer_segment"]

        city_zones = delivery_zones_df[
        delivery_zones_df["city_id"] == city_id
        ]

        zone = city_zones.sample(1).iloc[0]

        zone_id = zone["zone_id"]

        gender = np.random.choice(

        ["Male", "Female", "Other"],

        p=[

            gender_probability["Male"],

            gender_probability["Female"],

            gender_probability["Other"]

        ]

        )

        if gender == "Male":

            customer_name = male_name_pool[
                city_id
            ].pop()

        elif gender == "Female":

            customer_name = female_name_pool[
                city_id
            ].pop()

        else:

            customer_name = other_name_pool[
                city_id
            ].pop()
        
        # ------------------------------------------------------
        # Generate Customer Age
        # ------------------------------------------------------

        min_age, max_age = age_rules[
            customer_segment
        ]

        age = np.random.randint(
            min_age,
            max_age + 1
        )

        # ------------------------------------------------------
        # Generate Signup Date
        # ------------------------------------------------------

        random_value = np.random.rand()

        if random_value < 0.25:

            signup_pool = calendar_df[
                calendar_df["year"] == 2024
            ].head(180)

        elif random_value < 0.60:

            signup_pool = calendar_df[
                calendar_df["year"] == 2024
            ].tail(186)

        else:

            signup_pool = calendar_df[
                calendar_df["year"] == 2025
            ]

        signup_date = signup_pool.sample(1).iloc[0][
            "full_date"
        ]

        # ------------------------------------------------------
        # Generate Active Status
        # ------------------------------------------------------

        is_active = np.random.choice(

            [True, False],

            p=[

                active_probability[True],

                active_probability[False]

            ]

        )

        # ------------------------------------------------------
        # Created At
        # ------------------------------------------------------

        created_at = signup_date

        # ------------------------------------------------------
        # Store Customer
        # ------------------------------------------------------

        customers.append([

            customer_id,

            zone_id,

            customer_name,

            gender,

            age,

            signup_date,

            customer_segment,

            is_active,

            created_at

        ])

        customer_id += 1

    # ==========================================================
    # Create Customer DataFrame
    # ==========================================================

    customers_df = pd.DataFrame(

        customers,

        columns=[

            "customer_id",
            "zone_id",
            "customer_name",
            "gender",
            "age",
            "signup_date",
            "customer_segment",
            "is_active",
            "created_at"

        ]

    )

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")
    print(customers_df.head())

    print("\nLast 5 Records")
    print(customers_df.tail())

    print(f"\nTotal Customers Generated : {len(customers_df)}")

    print("\nUnique Customer Names")
    print(customers_df["customer_name"].nunique())

    print("\nCustomer Segments")
    print(
        customers_df["customer_segment"]
        .value_counts()
    )

    print("\nGender Distribution")
    print(
        customers_df["gender"]
        .value_counts()
    )

    print("\nActive Customers")
    print(
        customers_df["is_active"]
        .value_counts()
    )

    # ==========================================================
    # Export CSV
    # ==========================================================

    customers_df.to_csv(

        OUTPUT_FOLDER + "customers.csv",

        index=False

    )

    print("\nCustomer data successfully exported!")


# ==========================================================
# Program Entry Point
# ==========================================================

if __name__ == "__main__":

    generate_customers()



