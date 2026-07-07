# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_riders.py
# Purpose     : Generate Rider Master Data
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
# Rider Generator Function
# ==========================================================

def generate_riders():

    print("Generating Rider Data...")

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
    # Rider Distribution by City
    # ==========================================================

    rider_distribution = {

        1: 70,      # Mumbai
        2: 45,      # Pune
        3: 55,      # Bengaluru
        4: 45,      # Hyderabad
        5: 40,      # Ahmedabad
        6: 45       # Delhi

    }

    # ==========================================================
    # Gender Probability
    # ==========================================================

    gender_probability = {

        "Male": 0.88,
        "Female": 0.10,
        "Other": 0.02

    }

    # ==========================================================
    # Experience Distribution
    # ==========================================================

    experience_probability = {

        "Beginner": 0.25,
        "Intermediate": 0.50,
        "Experienced": 0.25

    }

    # ==========================================================
    # Employment Type
    # ==========================================================

    employment_probability = {

        "Full Time": 0.70,
        "Part Time": 0.30

    }

    # ==========================================================
    # Shift Distribution
    # ==========================================================

    shift_probability = {

        "Morning": 0.30,
        "Afternoon": 0.40,
        "Night": 0.30

    }

    # ==========================================================
    # Active Rider Probability
    # ==========================================================

    active_probability = {

        True: 0.90,
        False: 0.10

    }

    # ==========================================================
    # Age Rules by Experience
    # ==========================================================

    age_rules = {

        "Beginner": (18, 24),

        "Intermediate": (22, 35),

        "Experienced": (28, 50)

    }

    # ==========================================================
    # Rider Rating Rules
    # ==========================================================

    rating_rules = {

        "Beginner": (3.5, 4.2),

        "Intermediate": (4.0, 4.6),

        "Experienced": (4.4, 5.0)

    }

    # ==========================================================
    # Vehicle Probability by Zone Type
    # ==========================================================

    vehicle_probability = {

        "IT Hub": {

            "Bike": 0.55,
            "Electric Bike": 0.20,
            "Scooter": 0.20,
            "Bicycle": 0.05

        },

        "Commercial": {

            "Bike": 0.60,
            "Scooter": 0.25,
            "Electric Bike": 0.10,
            "Bicycle": 0.05

        },

        "Residential": {

            "Scooter": 0.45,
            "Bike": 0.40,
            "Bicycle": 0.10,
            "Electric Bike": 0.05

        },

        "University": {

            "Bicycle": 0.35,
            "Scooter": 0.35,
            "Bike": 0.25,
            "Electric Bike": 0.05

        }

    }

    # ==========================================================
    # Shared Names (35%)
    # Common Across Customers and Riders
    # ==========================================================

    shared_male = [

        "Aarav",
        "Rohan",
        "Aditya",
        "Yash",
        "Harsh",
        "Akash",
        "Nikhil"

    ]

    shared_female = [

        "Priya",
        "Sneha",
        "Ananya",
        "Pooja",
        "Neha",
        "Riya",
        "Meera"

    ]

    shared_last = [

        "Patil",
        "Joshi",
        "Kulkarni",
        "Patel",
        "Sharma",
        "Reddy",
        "Gupta"

    ]

    # ==========================================================
    # Male First Names by City
    # (35% Shared + 65% Rider Exclusive)
    # ==========================================================

    male_first_names = {

        1: shared_male + [
            "Mahesh","Ganesh","Sunil","Prakash","Dinesh",
            "Santosh","Mangesh","Ramesh","Suresh","Vilas",
            "Umesh","Ashok","Ravindra"
        ],

        2: shared_male + [
            "Sachin","Amol","Nitin","Swapnil","Shailesh",
            "Bharat","Kishor","Datta","Vikas","Vinay",
            "Shrikant","Ajinkya","Mahadev"
        ],

        3: shared_male + [
            "Shankar","Murali","Lokesh","Manjunath","Raghu",
            "Darshan","Shivanna","Nagaraj","Jagadish",
            "Basavaraj","Pradeep","Mohan","Ramesh"
        ],

        4: shared_male + [
            "Venkatesh","Srinivas","Mallesh","Rajesh","Naresh",
            "Madhav","Jagan","Srinath","Krishna","Ravi",
            "Praveen","Ramu","Chandra"
        ],

        5: shared_male + [
            "Bhavin","Jignesh","Chirag","Milan","Paresh",
            "Sanjay","Vipul","Nirav","Ketan","Hitesh",
            "Kalpesh","Mahendra","Hasmukh"
        ],

        6: shared_male + [
            "Manoj","Mukesh","Rajeev","Vikas","Pankaj",
            "Deepak","Anil","Vinod","Naresh","Ashwani",
            "Rakesh","Sanjiv","Rajender"
        ]

    }

    # ==========================================================
    # Female First Names by City
    # (35% Shared + 65% Rider Exclusive)
    # ==========================================================

    female_first_names = {

        1: shared_female + [
            "Rekha","Geeta","Jyoti","Savita","Lata",
            "Shobha","Uma","Kiran","Archana","Kusum",
            "Manisha","Vaishali","Madhuri"
        ],

        2: shared_female + [
            "Prajakta","Madhura","Sonali","Aarti","Monali",
            "Shweta","Swati","Rupali","Vaishali",
            "Sujata","Varsha","Bhagyashree","Dipali"
        ],

        3: shared_female + [
            "Bhavana","Kavitha","Sowmya","Harini","Sindhu",
            "Keerthi","Lavanya","Deepa","Nandini",
            "Meghana","Divya","Anusha","Pavithra"
        ],

        4: shared_female + [
            "Harika","Sravani","Niharika","Bhargavi",
            "Akhila","Ramya","Tejaswini","Madhavi",
            "Deepika","Sushmita","Aparna","Swathi","Keerthana"
        ],

        5: shared_female + [
            "Hetal","Krupa","Jinal","Dhara","Kinjal",
            "Bhavya","Palak","Mitali","Nidhi","Riddhi",
            "Komal","Kajal","Aarti"
        ],

        6: shared_female + [
            "Muskan","Payal","Ritika","Shivani","Sanya",
            "Nikita","Kritika","Mehak","Aditi","Tanya",
            "Pallavi","Anjali","Simran"
        ]

    }

    # ==========================================================
    # Last Names by City
    # (35% Shared + 65% Rider Exclusive)
    # ==========================================================

    last_names = {

        1: shared_last + [
            "Chaudhari","Salunkhe","Dongre","Waghmare",
            "Kamble","Mane","Mohite","Gaikwad",
            "Shitole","Borse","Lokhande","Ghadge","Jagtap"
        ],

        2: shared_last + [
            "Deshpande","Sathe","Apte","Bapat","Phadke",
            "Agashe","Karandikar","Limaye","Gokhale",
            "Nene","Lele","Oak","Ranade"
        ],

        3: shared_last + [
            "Shetty","Hegde","Gowda","Murthy","Pai",
            "Kamath","Shenoy","Acharya","Prasad",
            "Shekar","Bhat","Naik","Rao"
        ],

        4: shared_last + [
            "Naidu","Varma","Goud","Chowdary","Raju",
            "Yadav","Sai","Kumar","Ramesh",
            "Krishna","Rao","Patel","Reddy"
        ],

        5: shared_last + [
            "Shah","Mehta","Trivedi","Bhatt","Pandya",
            "Parikh","Dave","Desai","Modi",
            "Vyas","Thakkar","Brahmbhatt","Gandhi"
        ],

        6: shared_last + [
            "Singh","Malhotra","Arora","Kapoor","Verma",
            "Mathur","Goyal","Chopra","Batra",
            "Tandon","Saxena","Agarwal","Khanna"
        ]

    }

        # ==========================================================
    # Create Unique Rider Name Pools
    # ==========================================================

    male_name_pool = {}
    female_name_pool = {}
    other_name_pool = {}

    for city_id in rider_distribution.keys():

        male_names = []

        for first_name in male_first_names[city_id]:

            for last_name in last_names[city_id]:

                male_names.append(
                    f"{first_name} {last_name}"
                )

        np.random.shuffle(male_names)

        male_name_pool[city_id] = male_names

        female_names = []

        for first_name in female_first_names[city_id]:

            for last_name in last_names[city_id]:

                female_names.append(
                    f"{first_name} {last_name}"
                )

        np.random.shuffle(female_names)

        female_name_pool[city_id] = female_names

        other_names = []

        combined_names = (

            male_first_names[city_id]

            +

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
    # Zone Weight
    # Used While Allocating Riders
    # ==========================================================

    zone_weight = {

        "IT Hub": 1.35,

        "Commercial": 1.20,

        "Residential": 1.00,

        "University": 0.90

    }

        # ==========================================================
    # Create Rider Blueprint
    # ==========================================================

    rider_blueprint = []

    for city_id, total_riders in rider_distribution.items():

        city_zones = delivery_zones_df[

            delivery_zones_df["city_id"] == city_id

        ].copy()

        city_zones["weight"] = (

            city_zones["zone_type"]

            .map(zone_weight)

        )

        total_weight = city_zones["weight"].sum()

        city_zones["allocated_riders"] = (

            city_zones["weight"]

            /

            total_weight

            *

            total_riders

        ).round().astype(int)

        difference = (

            total_riders

            -

            city_zones["allocated_riders"].sum()

        )

        if difference != 0:

            city_zones.loc[

                city_zones["allocated_riders"].idxmax(),

                "allocated_riders"

            ] += difference

        for _, zone in city_zones.iterrows():

            rider_blueprint.extend(

                [

                    {

                        "city_id": city_id,

                        "zone_id": zone["zone_id"],

                        "zone_type": zone["zone_type"]

                    }

                ]

                *

                zone["allocated_riders"]

            )

    rider_blueprint = pd.DataFrame(

        rider_blueprint

    )

        # ==========================================================
    # Validate Rider Blueprint
    # ==========================================================

    print("\nRider Blueprint Created Successfully!")

    print(rider_blueprint.head())

    print("\nTotal Riders")

    print(len(rider_blueprint))

    print("\nRiders Per City")

    print(

        rider_blueprint["city_id"]

        .value_counts()

        .sort_index()

    )

    print("\nRiders Per Zone")

    print(

        rider_blueprint["zone_type"]

        .value_counts()

    )

        # ==========================================================
    # Shuffle Rider Blueprint
    # ==========================================================

    rider_blueprint = (
        rider_blueprint
        .sample(
            frac=1,
            random_state=42
        )
        .reset_index(drop=True)
    )

    # ==========================================================
    # Store Riders
    # ==========================================================

    riders = []

    rider_id = 1

    # ==========================================================
    # Generate Riders
    # ==========================================================

    for _, row in rider_blueprint.iterrows():

        city_id = row["city_id"]
        zone_id = row["zone_id"]
        zone_type = row["zone_type"]

        # ------------------------------------------------------
        # Gender
        # ------------------------------------------------------

        gender = np.random.choice(

            ["Male", "Female", "Other"],

            p=[

                gender_probability["Male"],
                gender_probability["Female"],
                gender_probability["Other"]

            ]

        )

        # ------------------------------------------------------
        # Rider Name
        # ------------------------------------------------------

        if gender == "Male":

            rider_name = male_name_pool[
                city_id
            ].pop()

        elif gender == "Female":

            rider_name = female_name_pool[
                city_id
            ].pop()

        else:

            rider_name = other_name_pool[
                city_id
            ].pop()

        # ------------------------------------------------------
        # Experience
        # ------------------------------------------------------

        experience_level = np.random.choice(

            [

                "Beginner",
                "Intermediate",
                "Experienced"

            ],

            p=[

                experience_probability["Beginner"],
                experience_probability["Intermediate"],
                experience_probability["Experienced"]

            ]

        )

        # ------------------------------------------------------
        # Age
        # ------------------------------------------------------

        minimum_age, maximum_age = age_rules[
            experience_level
        ]

        age = np.random.randint(

            minimum_age,

            maximum_age + 1

        )

                # ------------------------------------------------------
        # Vehicle Type
        # ------------------------------------------------------

        vehicle_type = np.random.choice(

            list(vehicle_probability[zone_type].keys()),

            p=list(vehicle_probability[zone_type].values())

        )

        # ------------------------------------------------------
        # Employment Type
        # ------------------------------------------------------

        employment_type = np.random.choice(

            ["Full Time", "Part Time"],

            p=[

                employment_probability["Full Time"],
                employment_probability["Part Time"]

            ]

        )

        # ------------------------------------------------------
        # Shift
        # ------------------------------------------------------

        shift = np.random.choice(

            ["Morning", "Afternoon", "Night"],

            p=[

                shift_probability["Morning"],
                shift_probability["Afternoon"],
                shift_probability["Night"]

            ]

        )

        # ------------------------------------------------------
        # Rider Rating
        # ------------------------------------------------------

        minimum_rating, maximum_rating = rating_rules[
            experience_level
        ]

        rider_rating = round(

            np.random.uniform(

                minimum_rating,

                maximum_rating

            ),

            1

        )

        # ------------------------------------------------------
        # Joining Date
        # ------------------------------------------------------

        joining_year = np.random.choice(

            [2024, 2025],

            p=[0.45, 0.55]

        )

        joining_dates = calendar_df[

            calendar_df["year"] == joining_year

        ]

        joining_date = np.random.choice(

            joining_dates["full_date"]

        )

        # ------------------------------------------------------
        # Active Status
        # ------------------------------------------------------

        is_active = np.random.choice(

            [True, False],

            p=[

                active_probability[True],

                active_probability[False]

            ]

        )

        # ------------------------------------------------------
        # Store Rider
        # ------------------------------------------------------

        riders.append({

            "rider_id": rider_id,

            "zone_id": zone_id,

            "rider_name": rider_name,

            "gender": gender,

            "age": age,

            "vehicle_type": vehicle_type,

            "experience_level": experience_level,

            "rider_rating": rider_rating,

            "employment_type": employment_type,

            "shift": shift,

            "joining_date": joining_date,

            "is_active": is_active

        })

        rider_id += 1

        # ==========================================================
    # Create Riders DataFrame
    # ==========================================================

    riders_df = pd.DataFrame(riders)

    # ==========================================================
    # Preview Generated Data
    # ==========================================================

    print("\nFirst 5 Records")

    print(riders_df.head())

    print("\nLast 5 Records")

    print(riders_df.tail())

    print(f"\nTotal Riders Generated : {len(riders_df)}")

    # ==========================================================
    # Validation Reports
    # ==========================================================

    print("\nVehicle Distribution")

    print(
        riders_df["vehicle_type"]
        .value_counts()
    )

    print("\nExperience Distribution")

    print(
        riders_df["experience_level"]
        .value_counts()
    )

    print("\nEmployment Type")

    print(
        riders_df["employment_type"]
        .value_counts()
    )

    print("\nShift Distribution")

    print(
        riders_df["shift"]
        .value_counts()
    )

    print("\nGender Distribution")

    print(
        riders_df["gender"]
        .value_counts()
    )

    print("\nActive Riders")

    print(
        riders_df["is_active"]
        .value_counts()
    )

    print("\nAverage Rider Rating")

    print(
        round(
            riders_df["rider_rating"].mean(),
            2
        )
    )

    print("\nAverage Rider Age")

    print(
        round(
            riders_df["age"].mean(),
            1
        )
    )

    # ==========================================================
    # Export CSV
    # ==========================================================

    riders_df.to_csv(

        OUTPUT_FOLDER + "riders.csv",

        index=False

    )

    print("\nRider data successfully exported!")
    
    
if __name__ == "__main__":
    generate_riders()