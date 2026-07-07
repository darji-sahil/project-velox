# ==========================================================
# Author      : Sahil Darji
# Project     : Project Velox
# File        : generate_menu_items.py
# Purpose     : Generate Restaurant Menu Items
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
# Menu Item Generator Function
# ==========================================================

def generate_menu_items():

    print("Generating Menu Items...")

    np.random.seed(42)

    # ==========================================================
    # Read Master Data
    # ==========================================================

    restaurants_df = pd.read_csv(
        OUTPUT_FOLDER + "restaurants.csv"
    )

    print("\nRestaurant Data Loaded Successfully!")

    # ==========================================================
    # Menu Size by Restaurant Category
    # ==========================================================

    menu_size_rules = {

        1: (30, 40),      # North Indian

        2: (22, 30),      # South Indian

        3: (24, 34),      # Chinese

        4: (20, 28),      # Fast Food

        5: (18, 24),      # Pizza

        6: (18, 25),      # Cafe

        7: (16, 22),      # Biryani

        8: (18, 25),      # Desserts

        9: (40, 55),      # Fine Dining

        10: (18, 26)      # Healthy Food

    }

    # ==========================================================
    # Unit Price Rules
    # Category -> Item Type -> Price Range
    # ==========================================================

    price_rules = {

        1: {  # North Indian
            "Main Course": (220, 480),
            "Starter": (80, 220),
            "Dessert": (90, 220),
            "Beverage": (50, 180)
        },

        2: {  # South Indian
            "Main Course": (120, 280),
            "Starter": (60, 150),
            "Dessert": (80, 180),
            "Beverage": (40, 120)
        },

        3: {  # Chinese
            "Main Course": (180, 420),
            "Starter": (120, 260),
            "Dessert": (100, 220),
            "Beverage": (50, 160)
        },

        4: {  # Fast Food
            "Main Course": (140, 320),
            "Starter": (90, 180),
            "Dessert": (90, 180),
            "Beverage": (50, 140)
        },

        5: {  # Pizza
            "Main Course": (250, 550),
            "Starter": (120, 240),
            "Dessert": (120, 220),
            "Beverage": (60, 140)
        },

        6: {  # Cafe
            "Main Course": (180, 320),
            "Starter": (100, 220),
            "Dessert": (120, 260),
            "Beverage": (100, 280)
        },

        7: {  # Biryani
            "Main Course": (220, 480),
            "Starter": (100, 260),
            "Dessert": (90, 200),
            "Beverage": (50, 140)
        },

        8: {  # Desserts
            "Main Course": (120, 220),
            "Starter": (80, 180),
            "Dessert": (120, 320),
            "Beverage": (80, 220)
        },

        9: {  # Fine Dining
            "Main Course": (550, 950),
            "Starter": (250, 550),
            "Dessert": (220, 450),
            "Beverage": (120, 350)
        },

        10: {  # Healthy Food
            "Main Course": (220, 420),
            "Starter": (100, 220),
            "Dessert": (100, 220),
            "Beverage": (120, 260)
        }

    }

    # ==========================================================
    # Premium Restaurant Price Multiplier
    # ==========================================================

    premium_multiplier = 1.30

    # ==========================================================
    # Item Types
    # ==========================================================

    item_types = [

        "Main Course",

        "Starter",

        "Dessert",

        "Beverage"

    ]

    # ==========================================================
    # Veg Probability by Category
    # ==========================================================

    veg_probability = {

        1: 0.55,

        2: 0.90,

        3: 0.50,

        4: 0.60,

        5: 0.70,

        6: 0.85,

        7: 0.30,

        8: 1.00,

        9: 0.55,

        10: 0.95

    }

    # ==========================================================
    # North Indian Menu
    # ==========================================================

    north_indian_items = [

        {"name": "Paneer Butter Masala", "type": "Main Course", "veg": True},
        {"name": "Butter Chicken", "type": "Main Course", "veg": False},
        {"name": "Dal Makhani", "type": "Main Course", "veg": True},
        {"name": "Kadhai Paneer", "type": "Main Course", "veg": True},
        {"name": "Chicken Curry", "type": "Main Course", "veg": False},
        {"name": "Palak Paneer", "type": "Main Course", "veg": True},
        {"name": "Shahi Paneer", "type": "Main Course", "veg": True},
        {"name": "Chole Masala", "type": "Main Course", "veg": True},
        {"name": "Rajma Masala", "type": "Main Course", "veg": True},
        {"name": "Aloo Gobi", "type": "Main Course", "veg": True},
        {"name": "Jeera Rice", "type": "Main Course", "veg": True},
        {"name": "Veg Pulao", "type": "Main Course", "veg": True},
        {"name": "Chicken Biryani", "type": "Main Course", "veg": False},
        {"name": "Paneer Biryani", "type": "Main Course", "veg": True},
        {"name": "Butter Naan", "type": "Starter", "veg": True},
        {"name": "Garlic Naan", "type": "Starter", "veg": True},
        {"name": "Tandoori Roti", "type": "Starter", "veg": True},
        {"name": "Lassi", "type": "Beverage", "veg": True},
        {"name": "Gulab Jamun", "type": "Dessert", "veg": True},
        {"name": "Rasmalai", "type": "Dessert", "veg": True},
        {"name": "Chicken Tikka", "type": "Starter", "veg": False},
        {"name": "Paneer Tikka", "type": "Starter", "veg": True},
        {"name": "Malai Kofta", "type": "Main Course", "veg": True},
        {"name": "Mutton Rogan Josh", "type": "Main Course", "veg": False},
        {"name": "Fish Curry", "type": "Main Course", "veg": False},
        {"name": "Veg Kolhapuri", "type": "Main Course", "veg": True},
        {"name": "Dal Tadka", "type": "Main Course", "veg": True},
        {"name": "Kofta Curry", "type": "Main Course", "veg": True},
        {"name": "Kheer", "type": "Dessert", "veg": True},
        {"name": "Mango Lassi", "type": "Beverage", "veg": True},
        {"name": "Masala Papad", "type": "Starter", "veg": True},
        {"name": "Tandoori Chicken", "type": "Starter", "veg": False},
        {"name": "Rumali Roti", "type": "Starter", "veg": True},
        {"name": "Lemon Soda", "type": "Beverage", "veg": True},
        {"name": "Masala Chaas", "type": "Beverage", "veg": True},
        {"name": "Kulfi", "type": "Dessert", "veg": True},
        {"name": "Chicken Seekh Kebab", "type": "Starter", "veg": False},
        {"name": "Paneer Lababdar", "type": "Main Course", "veg": True},
        {"name": "Paneer Bhurji", "type": "Main Course", "veg": True},
        {"name": "Methi Malai Matar", "type": "Main Course", "veg": True},
        {"name": "Bhindi Masala", "type": "Main Course", "veg": True},
        {"name": "Amritsari Chole", "type": "Main Course", "veg": True},
        {"name": "Achari Paneer", "type": "Main Course", "veg": True},
        {"name": "Chicken Korma", "type": "Main Course", "veg": False},
        {"name": "Mutton Keema", "type": "Main Course", "veg": False},
        {"name": "Veg Seekh Kebab", "type": "Starter", "veg": True},
        {"name": "Hara Bhara Kebab", "type": "Starter", "veg": True},
        {"name": "Aam Panna", "type": "Beverage", "veg": True},
        {"name": "Jaljeera", "type": "Beverage", "veg": True},
        {"name": "Phirni", "type": "Dessert", "veg": True}

    ]

    # ==========================================================
    # South Indian Menu
    # ==========================================================

    south_indian_items = [

        {"name": "Masala Dosa", "type": "Main Course", "veg": True},
        {"name": "Plain Dosa", "type": "Main Course", "veg": True},
        {"name": "Mysore Masala Dosa", "type": "Main Course", "veg": True},
        {"name": "Rava Dosa", "type": "Main Course", "veg": True},
        {"name": "Onion Uttapam", "type": "Main Course", "veg": True},
        {"name": "Plain Uttapam", "type": "Main Course", "veg": True},
        {"name": "Idli", "type": "Main Course", "veg": True},
        {"name": "Mini Idli", "type": "Starter", "veg": True},
        {"name": "Medu Vada", "type": "Starter", "veg": True},
        {"name": "Sambar Vada", "type": "Starter", "veg": True},
        {"name": "Pongal", "type": "Main Course", "veg": True},
        {"name": "Curd Rice", "type": "Main Course", "veg": True},
        {"name": "Lemon Rice", "type": "Main Course", "veg": True},
        {"name": "Tomato Rice", "type": "Main Course", "veg": True},
        {"name": "Coconut Rice", "type": "Main Course", "veg": True},
        {"name": "Bisibele Bath", "type": "Main Course", "veg": True},
        {"name": "Vegetable Upma", "type": "Main Course", "veg": True},
        {"name": "Poori Bhaji", "type": "Main Course", "veg": True},
        {"name": "Filter Coffee", "type": "Beverage", "veg": True},
        {"name": "Badam Milk", "type": "Beverage", "veg": True},
        {"name": "Kesari Bath", "type": "Dessert", "veg": True},
        {"name": "Payasam", "type": "Dessert", "veg": True},
        {"name": "Rasam", "type": "Starter", "veg": True},
        {"name": "Vegetable Kurma", "type": "Main Course", "veg": True},
        {"name": "Chapati", "type": "Starter", "veg": True},
        {"name": "Appam", "type": "Main Course", "veg": True},
        {"name": "Vegetable Stew", "type": "Main Course", "veg": True},
        {"name": "Podi Idli", "type": "Starter", "veg": True},
        {"name": "Ghee Roast", "type": "Main Course", "veg": True},
        {"name": "Buttermilk", "type": "Beverage", "veg": True},
        {"name": "Neer Dosa", "type": "Main Course", "veg": True},
        {"name": "Set Dosa", "type": "Main Course", "veg": True},
        {"name": "Onion Dosa", "type": "Main Course", "veg": True},
        {"name": "Pesarattu", "type": "Main Course", "veg": True},
        {"name": "Akki Roti", "type": "Main Course", "veg": True},
        {"name": "Mangalore Buns", "type": "Starter", "veg": True},
        {"name": "Banana Chips", "type": "Starter", "veg": True},
        {"name": "Elaneer Payasam", "type": "Dessert", "veg": True},
        {"name": "Mango Lassi", "type": "Beverage", "veg": True},
        {"name": "Fresh Lime Juice", "type": "Beverage", "veg": True}

    ]

    # ==========================================================
    # Chinese Menu
    # ==========================================================

    chinese_items = [

        {"name": "Veg Fried Rice", "type": "Main Course", "veg": True},
        {"name": "Chicken Fried Rice", "type": "Main Course", "veg": False},
        {"name": "Schezwan Fried Rice", "type": "Main Course", "veg": True},
        {"name": "Hakka Noodles", "type": "Main Course", "veg": True},
        {"name": "Chicken Hakka Noodles", "type": "Main Course", "veg": False},
        {"name": "Schezwan Noodles", "type": "Main Course", "veg": True},
        {"name": "Veg Manchurian", "type": "Starter", "veg": True},
        {"name": "Chicken Manchurian", "type": "Starter", "veg": False},
        {"name": "Paneer Chilli", "type": "Starter", "veg": True},
        {"name": "Chicken Chilli", "type": "Starter", "veg": False},
        {"name": "Spring Rolls", "type": "Starter", "veg": True},
        {"name": "Chicken Spring Rolls", "type": "Starter", "veg": False},
        {"name": "Hot and Sour Soup", "type": "Starter", "veg": True},
        {"name": "Sweet Corn Soup", "type": "Starter", "veg": True},
        {"name": "Manchow Soup", "type": "Starter", "veg": True},
        {"name": "Dim Sums", "type": "Starter", "veg": True},
        {"name": "Veg Momos", "type": "Starter", "veg": True},
        {"name": "Chicken Momos", "type": "Starter", "veg": False},
        {"name": "Garlic Noodles", "type": "Main Course", "veg": True},
        {"name": "Singapore Noodles", "type": "Main Course", "veg": True},
        {"name": "Dragon Chicken", "type": "Main Course", "veg": False},
        {"name": "Crispy Corn", "type": "Starter", "veg": True},
        {"name": "Honey Chilli Potato", "type": "Starter", "veg": True},
        {"name": "Veg Triple Rice", "type": "Main Course", "veg": True},
        {"name": "Chicken Triple Rice", "type": "Main Course", "veg": False},
        {"name": "Kung Pao Chicken", "type": "Main Course", "veg": False},
        {"name": "Paneer Fried Rice", "type": "Main Course", "veg": True},
        {"name": "American Chopsuey", "type": "Main Course", "veg": True},
        {"name": "Chilli Garlic Rice", "type": "Main Course", "veg": True},
        {"name": "Ice Tea", "type": "Beverage", "veg": True},
        {"name": "Lemon Soda", "type": "Beverage", "veg": True},
        {"name": "Brownie", "type": "Dessert", "veg": True},
        {"name": "Vanilla Ice Cream", "type": "Dessert", "veg": True},
        {"name": "Chocolate Mousse", "type": "Dessert", "veg": True},
        {"name": "Veg Shanghai Rice", "type": "Main Course", "veg": True},
        {"name": "Chicken Shanghai Rice", "type": "Main Course", "veg": False},
        {"name": "Veg Fried Wonton", "type": "Starter", "veg": True},
        {"name": "Chicken Fried Wonton", "type": "Starter", "veg": False},
        {"name": "Tofu Chilli", "type": "Starter", "veg": True},
        {"name": "Black Pepper Chicken", "type": "Main Course", "veg": False},
        {"name": "Veg Bao", "type": "Starter", "veg": True},
        {"name": "Chicken Bao", "type": "Starter", "veg": False},
        {"name": "Lychee Cooler", "type": "Beverage", "veg": True},
        {"name": "Jasmine Tea", "type": "Beverage", "veg": True},
        {"name": "Sesame Balls", "type": "Dessert", "veg": True}

    ]

    # ==========================================================
    # Fast Food Menu
    # ==========================================================

    fast_food_items = [

        {"name": "Veg Burger", "type": "Main Course", "veg": True},
        {"name": "Chicken Burger", "type": "Main Course", "veg": False},
        {"name": "Cheese Burger", "type": "Main Course", "veg": True},
        {"name": "Double Patty Burger", "type": "Main Course", "veg": False},
        {"name": "French Fries", "type": "Starter", "veg": True},
        {"name": "Peri Peri Fries", "type": "Starter", "veg": True},
        {"name": "Loaded Fries", "type": "Starter", "veg": True},
        {"name": "Veg Wrap", "type": "Main Course", "veg": True},
        {"name": "Chicken Wrap", "type": "Main Course", "veg": False},
        {"name": "Veg Sandwich", "type": "Main Course", "veg": True},
        {"name": "Grilled Sandwich", "type": "Main Course", "veg": True},
        {"name": "Chicken Sandwich", "type": "Main Course", "veg": False},
        {"name": "Chicken Nuggets", "type": "Starter", "veg": False},
        {"name": "Veg Nuggets", "type": "Starter", "veg": True},
        {"name": "Hot Dog", "type": "Main Course", "veg": False},
        {"name": "Cheese Corn Sandwich", "type": "Main Course", "veg": True},
        {"name": "Cold Coffee", "type": "Beverage", "veg": True},
        {"name": "Milkshake", "type": "Beverage", "veg": True},
        {"name": "Pepsi", "type": "Beverage", "veg": True},
        {"name": "Coca Cola", "type": "Beverage", "veg": True},
        {"name": "Sprite", "type": "Beverage", "veg": True},
        {"name": "Brownie", "type": "Dessert", "veg": True},
        {"name": "Chocolate Sundae", "type": "Dessert", "veg": True},
        {"name": "Soft Serve", "type": "Dessert", "veg": True},
        {"name": "Garlic Bread", "type": "Starter", "veg": True},
        {"name": "Onion Rings", "type": "Starter", "veg": True},
        {"name": "Veg Taco", "type": "Main Course", "veg": True},
        {"name": "Chicken Taco", "type": "Main Course", "veg": False}

    ]

    # ==========================================================
    # Pizza Menu
    # ==========================================================

    pizza_items = [

        {"name": "Margherita Pizza", "type": "Main Course", "veg": True},
        {"name": "Farmhouse Pizza", "type": "Main Course", "veg": True},
        {"name": "Veg Supreme Pizza", "type": "Main Course", "veg": True},
        {"name": "Paneer Tikka Pizza", "type": "Main Course", "veg": True},
        {"name": "Cheese Burst Pizza", "type": "Main Course", "veg": True},
        {"name": "Mexican Green Wave", "type": "Main Course", "veg": True},
        {"name": "Chicken Dominator", "type": "Main Course", "veg": False},
        {"name": "Pepperoni Pizza", "type": "Main Course", "veg": False},
        {"name": "BBQ Chicken Pizza", "type": "Main Course", "veg": False},
        {"name": "Chicken Tikka Pizza", "type": "Main Course", "veg": False},
        {"name": "Garlic Bread", "type": "Starter", "veg": True},
        {"name": "Cheesy Garlic Bread", "type": "Starter", "veg": True},
        {"name": "Stuffed Garlic Bread", "type": "Starter", "veg": True},
        {"name": "Veg Pasta", "type": "Main Course", "veg": True},
        {"name": "Chicken Pasta", "type": "Main Course", "veg": False},
        {"name": "Chocolate Lava Cake", "type": "Dessert", "veg": True},
        {"name": "Brownie", "type": "Dessert", "veg": True},
        {"name": "Pepsi", "type": "Beverage", "veg": True},
        {"name": "Coca Cola", "type": "Beverage", "veg": True},
        {"name": "Sprite", "type": "Beverage", "veg": True},
        {"name": "Cold Coffee", "type": "Beverage", "veg": True},
        {"name": "Chocolate Milkshake", "type": "Beverage", "veg": True},
        {"name": "Vanilla Shake", "type": "Beverage", "veg": True},
        {"name": "Mineral Water", "type": "Beverage", "veg": True},
        {"name": "Veg Extravaganza Pizza", "type": "Main Course", "veg": True},
        {"name": "Corn Cheese Pizza", "type": "Main Course", "veg": True},
        {"name": "Spicy Paneer Pizza", "type": "Main Course", "veg": True},
        {"name": "Chicken Sausage Pizza", "type": "Main Course", "veg": False},
        {"name": "Mexican Chicken Pizza", "type": "Main Course", "veg": False},
        {"name": "Cheese Dip", "type": "Starter", "veg": True},
        {"name": "Potato Wedges", "type": "Starter", "veg": True},
        {"name": "Choco Lava Muffin", "type": "Dessert", "veg": True},
        {"name": "Strawberry Shake", "type": "Beverage", "veg": True},
        {"name": "Fresh Lime Soda", "type": "Beverage", "veg": True},
        {"name": "Iced Tea", "type": "Beverage", "veg": True}

    ]

    # ==========================================================
    # Cafe Menu
    # ==========================================================

    cafe_items = [

        {"name": "Cappuccino", "type": "Beverage", "veg": True},
        {"name": "Latte", "type": "Beverage", "veg": True},
        {"name": "Espresso", "type": "Beverage", "veg": True},
        {"name": "Mocha", "type": "Beverage", "veg": True},
        {"name": "Cold Coffee", "type": "Beverage", "veg": True},
        {"name": "Hot Chocolate", "type": "Beverage", "veg": True},
        {"name": "Green Tea", "type": "Beverage", "veg": True},
        {"name": "Masala Tea", "type": "Beverage", "veg": True},
        {"name": "Veg Sandwich", "type": "Main Course", "veg": True},
        {"name": "Grilled Cheese Sandwich", "type": "Main Course", "veg": True},
        {"name": "Chicken Sandwich", "type": "Main Course", "veg": False},
        {"name": "Veg Wrap", "type": "Main Course", "veg": True},
        {"name": "Chicken Wrap", "type": "Main Course", "veg": False},
        {"name": "French Fries", "type": "Starter", "veg": True},
        {"name": "Peri Peri Fries", "type": "Starter", "veg": True},
        {"name": "Garlic Bread", "type": "Starter", "veg": True},
        {"name": "Chocolate Brownie", "type": "Dessert", "veg": True},
        {"name": "Blueberry Cheesecake", "type": "Dessert", "veg": True},
        {"name": "Chocolate Muffin", "type": "Dessert", "veg": True},
        {"name": "Red Velvet Pastry", "type": "Dessert", "veg": True},
        {"name": "Croissant", "type": "Dessert", "veg": True},
        {"name": "Donut", "type": "Dessert", "veg": True},
        {"name": "Lemon Iced Tea", "type": "Beverage", "veg": True},
        {"name": "Fresh Lime Soda", "type": "Beverage", "veg": True},
        {"name": "Mineral Water", "type": "Beverage", "veg": True},
        {"name": "Americano", "type": "Beverage", "veg": True},
        {"name": "Flat White", "type": "Beverage", "veg": True},
        {"name": "Hazelnut Latte", "type": "Beverage", "veg": True},
        {"name": "Club Sandwich", "type": "Main Course", "veg": True},
        {"name": "Chicken Club Sandwich", "type": "Main Course", "veg": False},
        {"name": "Veg Quesadilla", "type": "Main Course", "veg": True},
        {"name": "Chicken Quesadilla", "type": "Main Course", "veg": False},
        {"name": "Chocolate Croissant", "type": "Dessert", "veg": True},
        {"name": "Apple Pie", "type": "Dessert", "veg": True},
        {"name": "Fruit Tart", "type": "Dessert", "veg": True}

    ]

    # ==========================================================
    # Biryani Menu
    # ==========================================================

    biryani_items = [

        {"name": "Chicken Biryani", "type": "Main Course", "veg": False},
        {"name": "Hyderabadi Chicken Biryani", "type": "Main Course", "veg": False},
        {"name": "Mutton Biryani", "type": "Main Course", "veg": False},
        {"name": "Egg Biryani", "type": "Main Course", "veg": False},
        {"name": "Fish Biryani", "type": "Main Course", "veg": False},
        {"name": "Paneer Biryani", "type": "Main Course", "veg": True},
        {"name": "Veg Dum Biryani", "type": "Main Course", "veg": True},
        {"name": "Mushroom Biryani", "type": "Main Course", "veg": True},
        {"name": "Jeera Rice", "type": "Main Course", "veg": True},
        {"name": "Raita", "type": "Starter", "veg": True},
        {"name": "Mirchi Ka Salan", "type": "Starter", "veg": True},
        {"name": "Boiled Egg", "type": "Starter", "veg": False},
        {"name": "Chicken 65", "type": "Starter", "veg": False},
        {"name": "Paneer 65", "type": "Starter", "veg": True},
        {"name": "Double Ka Meetha", "type": "Dessert", "veg": True},
        {"name": "Gulab Jamun", "type": "Dessert", "veg": True},
        {"name": "Soft Drink", "type": "Beverage", "veg": True},
        {"name": "Lassi", "type": "Beverage", "veg": True},
        {"name": "Buttermilk", "type": "Beverage", "veg": True},
        {"name": "Mineral Water", "type": "Beverage", "veg": True},
        {"name": "Chicken Fry Piece Biryani", "type": "Main Course", "veg": False},
        {"name": "Boneless Chicken Biryani", "type": "Main Course", "veg": False},
        {"name": "Prawns Biryani", "type": "Main Course", "veg": False},
        {"name": "Veg Hyderabadi Biryani", "type": "Main Course", "veg": True},
        {"name": "Chicken Kebab", "type": "Starter", "veg": False},
        {"name": "Veg Kebab", "type": "Starter", "veg": True},
        {"name": "Fruit Custard", "type": "Dessert", "veg": True},
        {"name": "Apricot Delight", "type": "Dessert", "veg": True},
        {"name": "Mint Lemonade", "type": "Beverage", "veg": True},
        {"name": "Rose Milk", "type": "Beverage", "veg": True}

    ]

    # ==========================================================
    # Desserts Menu
    # ==========================================================

    desserts_items = [

        {"name": "Chocolate Brownie", "type": "Dessert", "veg": True},
        {"name": "Chocolate Lava Cake", "type": "Dessert", "veg": True},
        {"name": "Red Velvet Pastry", "type": "Dessert", "veg": True},
        {"name": "Black Forest Pastry", "type": "Dessert", "veg": True},
        {"name": "Blueberry Cheesecake", "type": "Dessert", "veg": True},
        {"name": "New York Cheesecake", "type": "Dessert", "veg": True},
        {"name": "Chocolate Truffle Cake", "type": "Dessert", "veg": True},
        {"name": "Vanilla Ice Cream", "type": "Dessert", "veg": True},
        {"name": "Chocolate Ice Cream", "type": "Dessert", "veg": True},
        {"name": "Butterscotch Ice Cream", "type": "Dessert", "veg": True},
        {"name": "Mango Sundae", "type": "Dessert", "veg": True},
        {"name": "Chocolate Sundae", "type": "Dessert", "veg": True},
        {"name": "Kulfi", "type": "Dessert", "veg": True},
        {"name": "Gulab Jamun", "type": "Dessert", "veg": True},
        {"name": "Rasmalai", "type": "Dessert", "veg": True},
        {"name": "Kheer", "type": "Dessert", "veg": True},
        {"name": "Donut", "type": "Dessert", "veg": True},
        {"name": "Chocolate Muffin", "type": "Dessert", "veg": True},
        {"name": "Strawberry Shake", "type": "Beverage", "veg": True},
        {"name": "Chocolate Milkshake", "type": "Beverage", "veg": True},
        {"name": "Cold Coffee", "type": "Beverage", "veg": True},
        {"name": "Fresh Lime Soda", "type": "Beverage", "veg": True},
        {"name": "Mineral Water", "type": "Beverage", "veg": True},
        {"name": "Red Velvet Cake", "type": "Dessert", "veg": True},
        {"name": "Chocolate Pastry", "type": "Dessert", "veg": True},
        {"name": "Mango Cheesecake", "type": "Dessert", "veg": True},
        {"name": "Coffee Walnut Cake", "type": "Dessert", "veg": True},
        {"name": "Caramel Pudding", "type": "Dessert", "veg": True},
        {"name": "Banoffee Pie", "type": "Dessert", "veg": True},
        {"name": "Oreo Shake", "type": "Beverage", "veg": True},
        {"name": "Vanilla Milkshake", "type": "Beverage", "veg": True},
        {"name": "Cold Chocolate", "type": "Beverage", "veg": True},
        {"name": "Mango Smoothie", "type": "Beverage", "veg": True},
        {"name": "Belgian Waffle", "type": "Dessert", "veg": True},
        {"name": "Choco Chip Cookie", "type": "Dessert", "veg": True}

    ]

    # ==========================================================
    # Fine Dining Menu
    # ==========================================================

    fine_dining_items = [

        {"name": "Grilled Salmon", "type": "Main Course", "veg": False},
        {"name": "Herb Roasted Chicken", "type": "Main Course", "veg": False},
        {"name": "Lamb Chops", "type": "Main Course", "veg": False},
        {"name": "Steak with Pepper Sauce", "type": "Main Course", "veg": False},
        {"name": "Mushroom Risotto", "type": "Main Course", "veg": True},
        {"name": "Truffle Pasta", "type": "Main Course", "veg": True},
        {"name": "Paneer Steak", "type": "Main Course", "veg": True},
        {"name": "Grilled Vegetables", "type": "Main Course", "veg": True},
        {"name": "Caesar Salad", "type": "Starter", "veg": True},
        {"name": "Greek Salad", "type": "Starter", "veg": True},
        {"name": "Chicken Caesar Salad", "type": "Starter", "veg": False},
        {"name": "Bruschetta", "type": "Starter", "veg": True},
        {"name": "Garlic Bread", "type": "Starter", "veg": True},
        {"name": "Stuffed Mushrooms", "type": "Starter", "veg": True},
        {"name": "Tomato Basil Soup", "type": "Starter", "veg": True},
        {"name": "Cream of Mushroom Soup", "type": "Starter", "veg": True},
        {"name": "Prawn Tempura", "type": "Starter", "veg": False},
        {"name": "Chocolate Fondant", "type": "Dessert", "veg": True},
        {"name": "Tiramisu", "type": "Dessert", "veg": True},
        {"name": "Crème Brûlée", "type": "Dessert", "veg": True},
        {"name": "Cheesecake", "type": "Dessert", "veg": True},
        {"name": "Sparkling Water", "type": "Beverage", "veg": True},
        {"name": "Fresh Orange Juice", "type": "Beverage", "veg": True},
        {"name": "Espresso", "type": "Beverage", "veg": True},
        {"name": "Herb Grilled Vegetables", "type": "Starter", "veg": True},
        {"name": "Spinach Croquettes", "type": "Starter", "veg": True},
        {"name": "Roasted Bell Peppers", "type": "Starter", "veg": True},
        {"name": "Cheese Platter", "type": "Starter", "veg": True},
        {"name": "Garlic Prawns", "type": "Starter", "veg": False},
        {"name": "Stuffed Zucchini", "type": "Starter", "veg": True},
        {"name": "Smoked Chicken Bites", "type": "Starter", "veg": False},
        {"name": "Avocado Bruschetta", "type": "Starter", "veg": True},
        {"name": "Chicken Alfredo Pasta", "type": "Main Course", "veg": False},
        {"name": "Penne Arrabbiata", "type": "Main Course", "veg": True},
        {"name": "Seafood Risotto", "type": "Main Course", "veg": False},
        {"name": "Spinach Ravioli", "type": "Main Course", "veg": True},
        {"name": "Chicken Lasagna", "type": "Main Course", "veg": False},
        {"name": "Vegetable Lasagna", "type": "Main Course", "veg": True},
        {"name": "Grilled Cottage Cheese", "type": "Main Course", "veg": True},
        {"name": "Stuffed Bell Peppers", "type": "Main Course", "veg": True},
        {"name": "Pesto Pasta", "type": "Main Course", "veg": True},
        {"name": "Chicken Stroganoff", "type": "Main Course", "veg": False},
        {"name": "Herb Rice", "type": "Main Course", "veg": True},
        {"name": "Ratatouille", "type": "Main Course", "veg": True},
        {"name": "Grilled Sea Bass", "type": "Main Course", "veg": False},
        {"name": "Duck Confit", "type": "Main Course", "veg": False},
        {"name": "Beef Wellington Style Mushroom Pie", "type": "Main Course", "veg": True},
        {"name": "Opera Cake", "type": "Dessert", "veg": True},
        {"name": "Chocolate Mousse", "type": "Dessert", "veg": True},
        {"name": "Raspberry Tart", "type": "Dessert", "veg": True},
        {"name": "Lemon Tart", "type": "Dessert", "veg": True},
        {"name": "Panna Cotta", "type": "Dessert", "veg": True},
        {"name": "Macarons", "type": "Dessert", "veg": True},
        {"name": "Belgian Chocolate Cake", "type": "Dessert", "veg": True},
        {"name": "Virgin Mojito", "type": "Beverage", "veg": True},
        {"name": "Signature Mocktail", "type": "Beverage", "veg": True},
        {"name": "Fresh Watermelon Juice", "type": "Beverage", "veg": True},
        {"name": "Fresh Pineapple Juice", "type": "Beverage", "veg": True},
        {"name": "Cappuccino", "type": "Beverage", "veg": True},
        {"name": "Latte", "type": "Beverage", "veg": True},
        {"name": "Iced Tea", "type": "Beverage", "veg": True}

    ]

    # ==========================================================
    # Healthy Food Menu
    # ==========================================================

    healthy_food_items = [

        {"name": "Quinoa Salad", "type": "Main Course", "veg": True},
        {"name": "Grilled Chicken Salad", "type": "Main Course", "veg": False},
        {"name": "Paneer Salad Bowl", "type": "Main Course", "veg": True},
        {"name": "Brown Rice Bowl", "type": "Main Course", "veg": True},
        {"name": "Grilled Fish Bowl", "type": "Main Course", "veg": False},
        {"name": "Veg Protein Bowl", "type": "Main Course", "veg": True},
        {"name": "Chicken Protein Bowl", "type": "Main Course", "veg": False},
        {"name": "Avocado Toast", "type": "Main Course", "veg": True},
        {"name": "Veg Wrap", "type": "Main Course", "veg": True},
        {"name": "Chicken Wrap", "type": "Main Course", "veg": False},
        {"name": "Fruit Bowl", "type": "Starter", "veg": True},
        {"name": "Greek Yogurt", "type": "Starter", "veg": True},
        {"name": "Mixed Sprouts Salad", "type": "Starter", "veg": True},
        {"name": "Roasted Almonds", "type": "Starter", "veg": True},
        {"name": "Protein Smoothie", "type": "Beverage", "veg": True},
        {"name": "Green Smoothie", "type": "Beverage", "veg": True},
        {"name": "Fresh Orange Juice", "type": "Beverage", "veg": True},
        {"name": "Coconut Water", "type": "Beverage", "veg": True},
        {"name": "Green Tea", "type": "Beverage", "veg": True},
        {"name": "Oats Cookie", "type": "Dessert", "veg": True},
        {"name": "Protein Bar", "type": "Dessert", "veg": True},
        {"name": "Chia Pudding", "type": "Dessert", "veg": True},
        {"name": "Mineral Water", "type": "Beverage", "veg": True},
        {"name": "Tofu Bowl", "type": "Main Course", "veg": True},
        {"name": "Mexican Veg Bowl", "type": "Main Course", "veg": True},
        {"name": "Grilled Paneer Bowl", "type": "Main Course", "veg": True},
        {"name": "Chicken Caesar Wrap", "type": "Main Course", "veg": False},
        {"name": "Falafel Wrap", "type": "Main Course", "veg": True},
        {"name": "Roasted Chickpeas", "type": "Starter", "veg": True},
        {"name": "Hummus Platter", "type": "Starter", "veg": True},
        {"name": "Detox Juice", "type": "Beverage", "veg": True},
        {"name": "Beetroot Juice", "type": "Beverage", "veg": True},
        {"name": "Kiwi Smoothie", "type": "Beverage", "veg": True},
        {"name": "Granola Bowl", "type": "Dessert", "veg": True},
        {"name": "Protein Muffin", "type": "Dessert", "veg": True}

    ]

    # ==========================================================
    # Create Menu Blueprint
    # ==========================================================

    menu_blueprint = []

    for _, restaurant in restaurants_df.iterrows():

        restaurant_id = restaurant["restaurant_id"]

        category_id = restaurant["category_id"]

        is_premium = restaurant["is_premium"]

        min_items, max_items = menu_size_rules[category_id]

        menu_size = np.random.randint(
            min_items,
            max_items + 1
        )

        menu_blueprint.append({

            "restaurant_id": restaurant_id,

            "category_id": category_id,

            "is_premium": is_premium,

            "menu_size": menu_size

        })

    menu_blueprint = pd.DataFrame(menu_blueprint)

    print("\nMenu Blueprint Created Successfully!")

    print(menu_blueprint.head())

    print("\nTotal Restaurants")
    print(len(menu_blueprint))

    print("\nAverage Menu Size")
    print(round(menu_blueprint["menu_size"].mean(), 2))

    print("\nMenu Size By Category")

    print(

        menu_blueprint

        .groupby("category_id")["menu_size"]

        .mean()

        .round(1)

    )

    # ==========================================================
    # Store Menu Items
    # ==========================================================

    menu_items = []

    menu_item_id = 1

    # ==========================================================
    # Menu Pools
    # ==========================================================

    menu_pools = {

        1: north_indian_items,
        2: south_indian_items,
        3: chinese_items,
        4: fast_food_items,
        5: pizza_items,
        6: cafe_items,
        7: biryani_items,
        8: desserts_items,
        9: fine_dining_items,
        10: healthy_food_items

    }

    # ==========================================================
    # Generate Menu Items
    # ==========================================================

    for _, row in menu_blueprint.iterrows():

        restaurant_id = row["restaurant_id"]

        category_id = row["category_id"]

        is_premium = row["is_premium"]

        menu_size = row["menu_size"]

        menu_pool = menu_pools[category_id]

        selected_indices = np.random.choice(

            len(menu_pool),

            size=menu_size,

            replace=False

        )

        selected_items = [

            menu_pool[i]

            for i in selected_indices

        ]

        for item in selected_items:

            item_name = item["name"]

            item_type = item["type"]

            is_veg = item["veg"]

            min_price, max_price = price_rules[
                category_id
            ][
                item_type
            ]

            unit_price = np.random.randint(

                min_price,

                max_price + 1

            )

            if is_premium:

                unit_price = round(

                    unit_price * premium_multiplier

                )

            is_available = True

            menu_items.append({

                "menu_item_id": menu_item_id,

                "restaurant_id": restaurant_id,

                "item_name": item_name,

                "item_type": item_type,

                "is_veg": is_veg,

                "unit_price": unit_price,

                "is_available": is_available

            })

            menu_item_id += 1




    # ==========================================================
    # Create Menu Items DataFrame
    # ==========================================================

    menu_items_df = pd.DataFrame(
        menu_items
    )

    print("\nFirst 5 Records")

    print(menu_items_df.head())

    print("\nLast 5 Records")

    print(menu_items_df.tail())

    print("\nTotal Menu Items Generated :")

    print(len(menu_items_df))

    print("\nMenu Items Per Restaurant")

    print(

        menu_items_df

        .groupby("restaurant_id")

        .size()

        .head()

    )

    print("\nItem Type Distribution")

    print(

        menu_items_df["item_type"]

        .value_counts()

    )

    print("\nVeg / Non Veg Distribution")

    print(

        menu_items_df["is_veg"]

        .value_counts()

    )

    print("\nAverage Item Price")

    print(

        round(

            menu_items_df["unit_price"].mean(),

            2

        )

    )

    menu_items_df.to_csv(

        OUTPUT_FOLDER +

        "menu_items.csv",

        index=False

    )

    print("\nMenu Items data successfully exported!")




if __name__ == "__main__":
    generate_menu_items()
