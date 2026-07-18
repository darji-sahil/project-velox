# VELOX Business Intelligence Dashboard

> Executive Decision Intelligence platform built in Power BI to monitor operational performance, customer behavior, restaurant health, and financial leakage through stakeholder-focused dashboards.

---

# Executive Summary

VELOX is an end-to-end Business Intelligence solution developed to simulate how executive teams monitor and improve the performance of a large-scale food delivery platform.

Instead of creating a generic reporting dashboard, the project focuses on stakeholder-specific decision intelligence by transforming operational data into actionable business insights. Each dashboard is designed around a specific business function, allowing executives and operational managers to quickly identify performance gaps, investigate root causes, and prioritize interventions.

The solution combines dynamic KPIs, contextual alerts, interactive tooltips, and cross-filtering to provide a comprehensive view of business performance across operations, customers, restaurants, and financial health.

---

# Business Problem

Food delivery platforms generate large volumes of operational data across multiple business functions, including customer activity, restaurant performance, rider operations, promotional campaigns, and payment transactions.

While individual metrics are available, decision-makers often struggle to identify:

- Operational bottlenecks affecting delivery performance.
- Restaurants requiring immediate intervention.
- Customer segments showing declining loyalty.
- Revenue quality and promotional effectiveness.
- Sources of financial leakage caused by discounts and cancellations.

VELOX addresses these challenges by consolidating business data into a unified decision intelligence platform that enables faster and more informed decision-making.

---

# Project Objectives

The primary objectives of VELOX are to:

- Build an executive-ready Business Intelligence solution using Microsoft Power BI.
- Monitor operational performance across multiple business functions.
- Detect high-priority operational risks through dynamic scoring models.
- Improve stakeholder decision-making using contextual business KPIs.
- Deliver interactive business exploration through cross-filtering and custom tooltips.
- Present complex operational metrics in an intuitive executive dashboard.

---

# Dataset Overview

The project is built on a relational business dataset representing the operations of a food delivery platform.

The semantic model consists of **17 interconnected tables**, combining operational transactions, business dimensions, supporting lookup tables, and analytical metadata.

### Core Business Tables

- Orders
- Order Items
- Customers
- Restaurants
- Riders
- Menu Items
- Reviews
- Payments
- Promotions

### Geographic & Environmental Dimensions

- Cities
- Delivery Zones
- Weather
- Calendar

### Supporting Model Tables

- Executive Risk Signals (Dynamic executive alert mapping)
- Priority Drivers (Priority messaging and executive focus)
- Strategic Health Dimensions (Strategic KPI categorization)
- Dedicated Measure Table (_Measures) for centralized DAX organization

The semantic model is designed to support efficient filtering, time intelligence, and stakeholder-specific analytical reporting across the dashboard.

---

## Data Model

The semantic model integrates operational, customer, restaurant, financial, geographic, and environmental data into a unified reporting layer optimized for executive analytics. Supporting model tables organize DAX measures, strategic KPI classifications, and dynamic executive messaging while maintaining a clean and scalable semantic model.

<p align="center">
  <img src="Documentation/Data Model.png" width="95%">
</p>

---

# Dashboard Overview

VELOX is organized into five stakeholder-focused dashboards, each designed to support a specific business function within a food delivery platform.

Rather than presenting all metrics on a single report page, the solution separates business intelligence by decision-making responsibility. This enables executives and operational managers to focus on the KPIs, analytical visuals, and intervention signals that are most relevant to their role.

Each dashboard combines:

- Executive KPIs
- Dynamic health scores
- Contextual alert messaging
- Interactive cross-filtering
- Drill-through style tooltip pages
- Trend analysis
- Operational risk visualizations

The dashboard consists of five stakeholder views:

| Dashboard | Primary Stakeholder |
|------------|--------------------|
| Executive Decision Intelligence | CEO / Executive Leadership |
| Operations Command Center | Operations Manager |
| Customer & Revenue Intelligence | Customer Success & Revenue Teams |
| Restaurant Success Intelligence | Restaurant Operations Manager |
| Financial Leakage Intelligence | Finance & Strategy Teams |

---

# Dashboard Architecture

The dashboard is structured around stakeholder responsibilities rather than traditional reporting categories.

Each page follows a consistent design language consisting of:

- Five strategic KPI cards
- Dynamic executive alert banner
- Four analytical visuals
- Interactive filtering between related visuals
- Dedicated tooltip pages for contextual business investigation

This architecture enables users to move from high-level executive monitoring to detailed operational investigation with minimal navigation.

---

# Executive Decision Intelligence

The Executive Decision Intelligence dashboard provides senior leadership with a consolidated view of organizational performance through strategic health indicators and executive-level KPIs.

Instead of monitoring operational metrics individually, the dashboard summarizes overall business performance using composite scoring models that highlight operational health, customer loyalty, revenue quality, and growth momentum.

Primary objectives of this dashboard include:

- Monitor overall organizational performance.
- Identify the weakest strategic business area.
- Track business health over time.
- Prioritize executive intervention.
- Detect emerging operational risks.

### Key Performance Indicators

- Executive Health Index
- Operational Health Score
- Customer Loyalty Score
- Revenue Quality Score
- Growth Momentum Index

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/CEO Dashboard.png" width="95%">
</p>

---

# Operations Command Center

The Operations Command Center focuses on daily delivery execution and operational efficiency by monitoring rider performance, service levels, delivery success, and geographical risk.

This dashboard enables operations managers to identify operational bottlenecks, monitor service quality, and prioritize corrective actions across delivery zones, restaurants, and riders.

### Key Performance Indicators

- Operational Health Score
- SLA Compliance Rate
- Average Delivery Time
- Delivery Success Rate
- Rider Performance Score

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Operations Dashboard.png" width="95%">
</p>

### Dashboard Highlights

- Monitors operational performance trends.
- Identifies high-risk delivery zones.
- Highlights restaurants requiring operational intervention.
- Detects rider performance issues.
- Supports operational decision-making through cross-filtering.

---

# Customer & Revenue Intelligence

The Customer & Revenue Intelligence dashboard focuses on customer retention, loyalty, revenue quality, and promotional effectiveness.

Rather than measuring revenue alone, this dashboard evaluates the quality and sustainability of revenue by combining customer behavior, repeat purchasing, customer experience, promotional dependency, and financial performance into a unified decision-making view.

Primary objectives of this dashboard include:

- Monitor customer loyalty across segments.
- Evaluate revenue quality and sustainability.
- Measure promotion effectiveness.
- Detect declining customer experience.
- Identify customer segments requiring strategic attention.

### Key Performance Indicators

- Customer Loyalty Score
- Monthly Repeat Customer Rate
- Customer Experience Score
- Revenue Quality Score
- Revenue Growth %

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Customer Dashboard.png" width="95%">
</p>

### Dashboard Highlights

- Customer segmentation based on loyalty performance.
- Revenue quality trend analysis over time.
- Promotion effectiveness analysis.
- Customer loyalty matrix for behavioral comparison.
- Dynamic alerts highlighting the highest-priority customer or revenue concern.

---

# Restaurant Success Intelligence

The Restaurant Success Intelligence dashboard evaluates restaurant operational performance, intervention priority, rider efficiency, and delivery zone stability.

This dashboard enables restaurant operations teams to quickly identify underperforming restaurants, delivery bottlenecks, rider efficiency issues, and geographical operational risks requiring immediate attention.

### Key Performance Indicators

- Restaurant Performance Score
- Restaurant Priority Score
- Rider Intelligence Score
- Zone Stability Index
- Restaurant Completion Rate

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Restaurant Dashboard.png" width="95%">
</p>

### Dashboard Highlights

- Restaurant intervention prioritization.
- Restaurant performance trend monitoring.
- Rider efficiency risk analysis.
- Zone stability visualization.
- Dynamic operational alerts driven by the weakest performance dimension.

---

# Financial Leakage Intelligence

The Financial Leakage Intelligence dashboard focuses on identifying revenue leakage caused by promotional discounts and order cancellations.

Instead of measuring revenue generation, this dashboard evaluates how discounts and cancellations affect financial performance by highlighting leakage sources across restaurants and monitoring financial risk over time.

Primary objectives include:

- Monitor discount exposure.
- Track cancellation-related financial leakage.
- Identify restaurants contributing to financial leakage.
- Evaluate leakage trends over time.
- Support financial optimization decisions.

### Key Performance Indicators

- Total Discount Exposure
- Discount Rate
- Cancellation Rate
- Discount Dependency Score
- Cancellation Score

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Financial Dashboard.png" width="95%">
</p>

### Dashboard Highlights

- Restaurant discount exposure analysis.
- Financial leakage trend monitoring.
- Cancellation risk assessment.
- Leakage driver matrix for restaurant comparison.
- Dynamic financial alerts highlighting the dominant leakage source.

---

# Interactive Tooltip Pages

To support deeper business investigation without disrupting the primary dashboard layout, VELOX incorporates dedicated report page tooltips across analytical visuals.

Instead of displaying simple values on hover, each tooltip presents contextual business metrics that help decision-makers understand the underlying drivers behind a selected entity.

The tooltip pages follow the same executive design language as the dashboards, ensuring a consistent user experience while enabling rapid operational investigation.

The project includes dedicated tooltips for:

- Customer Segment Analysis
- Restaurant Intervention Analysis
- Rider Risk Analysis
- Zone Stability Analysis
- Financial Leakage Driver Analysis

---

## Customer Segment Tooltip

Provides detailed customer performance metrics for the selected customer segment.

Displayed metrics include:

- Customer Loyalty Score
- Monthly Repeat Rate
- Average Customer Rating
- Complaint Rate
- Customer Experience Score

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Customer Tooltip.png" width="80%">
</p>

---

## Restaurant Intervention Tooltip

Provides operational context for restaurants requiring performance improvement.

Displayed metrics include:

- Restaurant Priority Score
- Restaurant Performance Score
- Restaurant Completion Rate
- Order Share

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Restaurant Tooltip.png" width="80%">
</p>

---

## Rider Risk Tooltip

Provides operational insights for individual rider performance.

Displayed metrics include:

- Average Delivery Time
- On-Time Delivery Rate
- Delivered Orders
- Rider Intelligence Score

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Rider Tooltip.png" width="80%">
</p>

---

## Zone Stability Tooltip

Provides additional context behind delivery zone stability.

Displayed metrics include:

- Demand Stability Score
- Weather Impact Score
- Delay Score
- Zone Stability Index

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Zone Tooltip.png" width="80%">
</p>

---

## Financial Leakage Tooltip

Provides detailed financial leakage metrics for the selected restaurant.

Displayed metrics include:

- Discount Rate
- Cancellation Rate
- Discount Exposure
- Leakage Classification

<p align="center">
    <img src="VELOX-Business-Intelligence-Dashboard/Images/Financial Tooltip.png" width="80%">
</p>

---

# Technical Stack

| Category | Technologies |
|-----------|--------------|
| Business Intelligence | Microsoft Power BI Desktop |
| Data Processing | Microsoft Excel |
| Database | MySQL |
| Programming Language | Python |
| Data Modeling | Power BI Semantic Model |
| Data Visualization | Power BI |
| ETL | Power Query |
| Calculations | DAX |
| Version Control | Git & GitHub |

---

# Power BI Features Used

The dashboard leverages several advanced Power BI capabilities to improve analytical depth and user experience.

### Data Modeling

- Star schema modeling
- Relationship management
- Dedicated calendar table
- Dedicated measure table
- Supporting lookup tables

### Data Transformation

- Power Query
- Data cleansing
- Data type optimization

### DAX

- Business KPIs
- Composite scoring models
- Time intelligence
- Dynamic alert generation
- Conditional formatting measures
- Dynamic titles
- Tooltip measures

### Visualization

- KPI Cards
- Line Charts
- Bar Charts
- Scatter Plots
- Matrix Visualizations
- Interactive Report Page Tooltips

### User Experience

- Cross-filtering
- Dynamic alert banners
- Executive health indicators
- Context-aware tooltip pages
- Consistent dashboard design language

---

# Repository Structure

```text
Project Velox
│
├── Data_Generator/
│
├── Documentation/
│
├── Generated_Data/
│   ├── SQL/
│   └── Excel Datasets
│
├── VELOX-Business-Intelligence-Dashboard/
│   ├── Dashboard/
│   │   └── VELOX Business Intelligence Dashboard.pbix
│   │
│   └── Images/
│
├── README.md
└── .gitignore
```

---

# Documentation

The project includes supporting documentation covering business requirements, analytical design, architecture, and data modeling.

Available documents include:

- Business Requirements Document (BRD)
- Analytics & KPI Specification
- Architecture Diagram
- ER Diagram
- Star Schema
- Process Flowcharts
- Data Model

---

# How to Use

1. Clone the repository.
2. Open the Power BI (.pbix) file located inside the Dashboard folder.
3. Refresh the data model if required.
4. Explore each stakeholder dashboard.
5. Hover over supported visuals to view contextual report page tooltips.
6. Use cross-filtering to investigate operational performance.

---

# Future Enhancements

Potential future improvements include:

- Incremental data refresh
- Row-Level Security (RLS)
- Power BI Service deployment
- Mobile report optimization
- Automated data pipeline integration
- Real-time operational monitoring

---

# Author

**Sahil Darji**

B.Tech Artificial Intelligence & Data Science

Business Intelligence | Data Analytics | SQL | Power BI | Python

---

# License

This project is intended for educational and portfolio purposes.