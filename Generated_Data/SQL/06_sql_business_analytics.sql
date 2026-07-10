/*=============================================================================

 Project Velox
 SQL Business Analytics

 Database    : project_velox
 SQL Engine  : MySQL 8.0.43
 Script      : 06_sql_business_analytics.sql
 Version     : 1.1
 Author      : Sahil Darji

------------------------------------------------------------------------------
Purpose

Implements stakeholder-driven SQL analytics for Project Velox by answering
strategic, tactical, and operational business questions.

Each analysis is aligned with the Business Requirements Document (BRD) and
Analytics & KPI Specification (AKSD) and is designed to support business
decision-making, KPI computation, and Power BI dashboard development.

=============================================================================*/

/******************************************************************************
SECTION 1 : CEO ANALYTICS

Primary Stakeholder : Chief Executive Officer (CEO)

Purpose

Provides a strategic overview of overall business performance by analyzing
revenue, customer growth, operational efficiency, restaurant performance,
delivery network health, and executive-level KPIs.

******************************************************************************/

/*==============================================================================
Business Question

How is the overall business performing in terms of revenue, orders,
customers, restaurants, and riders?
==============================================================================

Business Objective
------------------
Provide the CEO with a high-level snapshot of the platform's overall
business performance.

Business Value
--------------
Enables executive leadership to quickly evaluate the scale of business
operations and monitor key operational metrics from a single summary.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    ROUND(SUM(final_amount),2) AS total_revenue,
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT restaurant_id) AS total_restaurants,
    COUNT(DISTINCT rider_id) AS total_riders
FROM orders;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Project Velox currently operates at a significant production scale,
  processing 50,000 customer orders and generating ₹41.89 million in
  platform revenue.

• The platform serves 2,000 customers through a network of 120 restaurants
  supported by 276 active riders, indicating a mature marketplace with
  balanced participation across demand and supply.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring these executive KPIs through a real-time executive
  dashboard to track business growth, customer acquisition, restaurant
  expansion, and delivery capacity.

• Regularly benchmark these metrics against previous periods to evaluate
  business growth and support strategic planning.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities generate the highest revenue and order volume?
==============================================================================

Business Objective
------------------
Identify the strongest performing markets across all operating cities.

Business Value
--------------
Supports strategic investment decisions by identifying markets that
contribute the highest business value.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    c.city_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.final_amount),2) AS total_revenue
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id = dz.zone_id
JOIN cities c
    ON dz.city_id = c.city_id
GROUP BY
    c.city_name
ORDER BY
    total_revenue DESC,
    total_orders DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai is the highest-performing market, contributing ₹10.80 million from
  12,313 orders.

• Bengaluru ranks second, followed by Hyderabad and Pune.

• Although Delhi processed more orders than Pune (7,700 vs. 7,495), Pune
  generated higher revenue, indicating a higher average order value.

• Ahmedabad contributes the lowest revenue and order volume among the six
  operating cities, representing an opportunity for future market expansion.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue investing in Mumbai and Bengaluru to sustain market leadership.

• Analyze the factors contributing to Pune's higher revenue per order and
  replicate successful strategies across other cities.

• Strengthen restaurant acquisition and customer growth initiatives in
  Ahmedabad to improve market penetration and revenue contribution.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What is the weekly revenue and order trend across the platform?
==============================================================================

Business Objective
------------------
Monitor weekly business performance by analyzing revenue generation and
customer demand over time.

Business Value
--------------
Helps executive leadership identify growth trends, seasonal demand patterns,
and weeks requiring strategic intervention.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    c.year,
    c.week_number,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.final_amount),2) AS total_revenue
FROM orders o
JOIN calendar c
    ON o.calendar_id = c.calendar_id
GROUP BY
    c.year,
    c.week_number
ORDER BY
    c.year,
    c.week_number;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Weekly order volume remained consistently between approximately 430 and
  540 orders throughout the two-year period, demonstrating stable customer
  demand without significant fluctuations.

• Weekly revenue generally ranged between ₹350K and ₹470K, indicating
  consistent revenue generation across the platform.

• The highest weekly revenue was recorded during Week 22 of 2025 with
  ₹468.22K generated from 518 completed orders.

• Overall, the platform exhibits stable operational performance without any
  prolonged decline in order volume or revenue.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring weekly business performance to identify seasonal demand
  patterns and evaluate the effectiveness of promotional campaigns.

• Investigate high-performing weeks to identify successful business drivers
  that can be replicated during comparatively weaker periods.

• Incorporate weekly trend monitoring into the executive dashboard for
  continuous performance tracking.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments contribute the most revenue?
==============================================================================

Business Objective
------------------
Evaluate revenue contribution across customer segments.

Business Value
--------------
Supports customer acquisition and retention strategies by identifying
high-value customer groups.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    cu.customer_segment,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.final_amount),2) AS total_revenue,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
GROUP BY
    cu.customer_segment
ORDER BY
    total_revenue DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals represent the platform's highest-value customer
  segment, contributing ₹16.74 million across 19,862 orders.

• Family and Student segments contribute comparable revenue, each generating
  approximately ₹10.5 million despite differences in total order volume.

• Food Enthusiasts represent the smallest customer segment in terms of both
  order volume and revenue contribution.

• Average order value remains remarkably consistent across all customer
  segments (approximately ₹833-₹843), indicating similar spending behaviour
  regardless of customer segment.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Prioritize customer retention initiatives for Working Professionals, as
  they contribute the largest share of platform revenue.

• Develop targeted campaigns to increase ordering frequency among Students,
  Families, and Food Enthusiasts.

• Focus on improving purchase frequency rather than average order value,
  since spending behaviour is already consistent across customer segments.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What is the overall order fulfillment performance of the platform?
==============================================================================

Business Objective
------------------
Evaluate the platform's ability to successfully fulfill customer orders.

Business Value
--------------
Provides executive leadership with visibility into delivery success,
cancellation levels, and overall operational reliability.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage_of_orders
FROM orders
GROUP BY
    order_status
ORDER BY
    total_orders DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Project Velox successfully fulfilled 94.03% of all customer orders,
  demonstrating strong operational reliability.

• Only 5.97% of orders were cancelled, indicating effective coordination
  between restaurants, riders, and platform operations.

• The high delivery success rate reflects a stable operational ecosystem and
  a positive customer fulfillment experience.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring cancellation trends to identify operational bottlenecks
  before they significantly impact customer satisfaction.

• Analyze cancellation reasons periodically to support continuous process
  improvement across restaurants and delivery operations.

• Maintain current fulfillment standards while pursuing incremental
  improvements in delivery efficiency and customer experience.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants generate the highest revenue across the platform?
==============================================================================

Business Objective
------------------
Identify the highest revenue-generating restaurant partners.

Business Value
--------------
Helps executive leadership recognize top-performing restaurant partners
and strengthen strategic business partnerships.

SQL Analysis
----------------------------------------------------------------------------*/

WITH restaurant_revenue AS
(
    SELECT
        r.restaurant_name,
        ROUND(SUM(o.final_amount),2) AS total_revenue
    FROM orders o
    JOIN restaurants r
        ON o.restaurant_id = r.restaurant_id
    GROUP BY
        r.restaurant_name
)

SELECT
    RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank,
    restaurant_name,
    total_revenue
FROM restaurant_revenue
ORDER BY
    revenue_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Pizza Nation Corner is the highest revenue-generating restaurant on the
  platform, contributing ₹1.27 million, followed by Orient Kitchen Kitchen
  (₹1.09 million) and Cool Drinks Kitchen (₹0.97 million).

• The top ten restaurants collectively contribute a substantial share of
  platform revenue, indicating that revenue generation is concentrated among
  a relatively small group of high-performing restaurant partners.

• Several restaurant brands appear multiple times within the rankings,
  suggesting strong brand presence across different locations and consistent
  customer demand.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Strengthen strategic partnerships with the highest revenue-generating
  restaurants through exclusive campaigns and long-term business incentives.

• Analyze operational practices adopted by top-performing restaurants and
  replicate successful strategies across lower-performing restaurant partners.

• Monitor revenue concentration regularly to reduce dependency on a limited
  number of restaurant partners.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants generate the highest average order value (AOV)?
==============================================================================

Business Objective
------------------
Identify restaurants consistently receiving higher-value customer orders.

Business Value
--------------
Supports premium partnership decisions and helps identify restaurants
with stronger customer spending behaviour.

SQL Analysis
----------------------------------------------------------------------------*/

WITH restaurant_aov AS
(
    SELECT
        r.restaurant_name,
        ROUND(AVG(o.final_amount),2) AS average_order_value
    FROM orders o
    JOIN restaurants r
        ON o.restaurant_id = r.restaurant_id
    GROUP BY
        r.restaurant_name
)

SELECT
    RANK() OVER(ORDER BY average_order_value DESC) AS aov_rank,
    restaurant_name,
    average_order_value
FROM restaurant_aov
ORDER BY
    aov_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Juice Junction Cafe records the highest Average Order Value (₹1,724.10),
  followed closely by Fresh Sip House and Smoothie Point Corner.

• Beverage-focused restaurants dominate the highest Average Order Value
  rankings, indicating that customers purchasing from these outlets tend to
  place higher-value orders.

• Several restaurants generating the highest revenue are different from those
  achieving the highest Average Order Value, demonstrating that revenue growth
  depends on both order frequency and customer spending behaviour.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Develop premium meal combinations and upselling strategies based on the
  practices of high Average Order Value restaurants.

• Promote premium restaurant offerings through targeted marketing campaigns to
  encourage higher customer spending.

• Monitor both revenue and Average Order Value simultaneously when evaluating
  restaurant performance.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How much does each city contribute to total platform revenue?
==============================================================================

Business Objective
------------------
Measure each city's contribution to overall platform revenue.

Business Value
--------------
Helps executives understand market dependency and identify cities
driving overall business performance.

SQL Analysis
----------------------------------------------------------------------------*/

WITH city_revenue AS
(
    SELECT
        c.city_name,
        ROUND(SUM(o.final_amount),2) AS total_revenue
    FROM orders o
    JOIN customers cu
        ON o.customer_id = cu.customer_id
    JOIN delivery_zones dz
        ON cu.zone_id = dz.zone_id
    JOIN cities c
        ON dz.city_id = c.city_id
    GROUP BY
        c.city_name
)

SELECT
    RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank,
    city_name,
    total_revenue,
    ROUND(
        total_revenue * 100 /
        SUM(total_revenue) OVER(),
        2
    ) AS revenue_contribution_percentage
FROM city_revenue
ORDER BY
    revenue_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai contributes the largest share of platform revenue (25.78%),
  establishing itself as the primary revenue-generating market.

• Bengaluru (18.29%) and Hyderabad (16.37%) together account for a significant
  proportion of total platform revenue, making these cities strategically
  important to business growth.

• Revenue contribution gradually declines across Pune, Delhi and Ahmedabad,
  with Ahmedabad contributing only 9.50% of overall revenue.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue strengthening market leadership within Mumbai while maintaining
  customer acquisition initiatives in Bengaluru and Hyderabad.

• Develop region-specific growth strategies for Ahmedabad to improve its
  contribution to overall platform revenue.

• Allocate future expansion investments according to each city's revenue
  contribution and long-term growth potential.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities demonstrate the highest average order value?
==============================================================================

Business Objective
------------------
Compare customer spending behaviour across operating cities.

Business Value
--------------
Helps identify premium markets and supports city-level pricing
and marketing strategies.

SQL Analysis
----------------------------------------------------------------------------*/

WITH city_aov AS
(
    SELECT
        c.city_name,
        ROUND(AVG(o.final_amount),2) AS average_order_value
    FROM orders o
    JOIN customers cu
        ON o.customer_id = cu.customer_id
    JOIN delivery_zones dz
        ON cu.zone_id = dz.zone_id
    JOIN cities c
        ON dz.city_id = c.city_id
    GROUP BY
        c.city_name
)

SELECT
    RANK() OVER(ORDER BY average_order_value DESC) AS aov_rank,
    city_name,
    average_order_value
FROM city_aov
ORDER BY
    aov_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Hyderabad records the highest Average Order Value (₹908.82), indicating
  stronger customer spending compared to other operating cities.

• Mumbai ranks second while Pune also demonstrates relatively high customer
  spending behaviour despite processing fewer orders than Delhi.

• Bengaluru records the lowest Average Order Value among all cities,
  suggesting opportunities to increase basket size through targeted marketing
  and cross-selling initiatives.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Investigate customer purchasing behaviour in Hyderabad to identify
  successful strategies that can be replicated across other cities.

• Introduce premium product bundles and personalized promotions within
  Bengaluru and Ahmedabad to improve Average Order Value.

• Track city-level spending trends continuously to support pricing and
  promotional decision-making.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants consistently maintain the highest customer ratings?
==============================================================================

Business Objective
------------------
Identify restaurant partners delivering the highest customer satisfaction.

Business Value
--------------
Supports quality benchmarking and long-term partnership decisions.

SQL Analysis
----------------------------------------------------------------------------*/

WITH restaurant_rating AS
(
    SELECT
        r.restaurant_name,
        ROUND(AVG(rv.rating),2) AS average_rating
    FROM reviews rv
    JOIN restaurants r
        ON rv.restaurant_id = r.restaurant_id
    GROUP BY
        r.restaurant_name
)

SELECT
    DENSE_RANK() OVER(ORDER BY average_rating DESC) AS rating_rank,
    restaurant_name,
    average_rating
FROM restaurant_rating
ORDER BY
    rating_rank,
    restaurant_name;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Grill Nation Kitchen achieves the highest average customer rating (4.23),
  followed closely by Biryani Junction House and Smoothie Point Corner.

• A large proportion of restaurants maintain customer ratings above 4.00,
  indicating consistently high service quality across the platform.

• The relatively small variation between restaurant ratings suggests that
  Project Velox maintains strong quality standards among its restaurant
  partners.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Recognize top-rated restaurant partners through premium visibility and
  partnership incentive programs.

• Conduct periodic quality assessments for lower-rated restaurants to
  maintain consistent customer satisfaction.

• Incorporate customer ratings into restaurant performance evaluations and
  partnership review processes.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What percentage of revenue is generated by premium restaurants versus
regular restaurants?
==============================================================================

Business Objective
------------------
Evaluate the revenue contribution of premium restaurant partners.

Business Value
--------------
Helps determine whether premium partnerships justify continued
business investment.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN r.is_premium = 1 THEN 'Premium'
        ELSE 'Regular'
    END AS restaurant_type,
    ROUND(SUM(o.final_amount),2) AS total_revenue,
    ROUND(
        SUM(o.final_amount) * 100 /
        (SELECT SUM(final_amount) FROM orders),
        2
    ) AS revenue_contribution_percentage
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
GROUP BY
    restaurant_type
ORDER BY
    total_revenue DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Regular restaurants contribute 79.78% of total platform revenue, while
  Premium restaurants account for the remaining 20.22%.

• Although Premium restaurants represent a smaller portion of the restaurant
  network, they contribute a meaningful share of overall business revenue.

• The current revenue distribution indicates that business growth remains
  largely dependent on regular restaurant partners.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue expanding premium restaurant partnerships while maintaining strong
  relationships with regular restaurant partners.

• Evaluate opportunities to increase Premium restaurant participation in
  high-performing markets.

• Measure Premium restaurant performance periodically to assess return on
  partnership investments.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurant categories generate the highest platform revenue?
==============================================================================

Business Objective
------------------
Determine which restaurant categories contribute the highest revenue.

Business Value
--------------
Supports future restaurant acquisition strategy and category expansion.

SQL Analysis
----------------------------------------------------------------------------*/

WITH category_revenue AS
(
    SELECT
        rc.category_name,
        ROUND(SUM(o.final_amount),2) AS total_revenue
    FROM orders o
    JOIN restaurants r
        ON o.restaurant_id = r.restaurant_id
    JOIN restaurant_categories rc
        ON r.category_id = rc.category_id
    GROUP BY
        rc.category_name
)

SELECT
    RANK() OVER(ORDER BY total_revenue DESC) AS category_rank,
    category_name,
    total_revenue
FROM category_revenue
ORDER BY
    category_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• North Indian cuisine generates the highest platform revenue (₹5.77 million),
  followed by Pizza (₹5.25 million) and Chinese (₹5.20 million).

• Cafe & Bakery and Beverages also contribute significantly to platform
  revenue, indicating strong customer demand across multiple cuisine
  categories.

• South Indian cuisine currently generates the lowest revenue among the ten
  restaurant categories, representing an opportunity for future category
  expansion.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue onboarding high-performing restaurant categories such as North
  Indian, Pizza and Chinese to sustain platform revenue growth.

• Develop targeted promotional campaigns for lower-performing cuisine
  categories to improve customer demand and category diversification.

• Use category-level performance insights to guide future restaurant
  acquisition and expansion strategies.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities are experiencing the fastest year-over-year revenue growth?
==============================================================================

Business Objective
------------------
Evaluate annual revenue growth across operating cities.

Business Value
--------------
Helps executive leadership identify emerging markets and prioritize future
business expansion.

SQL Analysis
----------------------------------------------------------------------------*/

WITH city_yearly_revenue AS
(
    SELECT
        c.city_name,
        cal.year,
        ROUND(SUM(o.final_amount),2) AS total_revenue
    FROM orders o
    JOIN customers cu
        ON o.customer_id = cu.customer_id
    JOIN delivery_zones dz
        ON cu.zone_id = dz.zone_id
    JOIN cities c
        ON dz.city_id = c.city_id
    JOIN calendar cal
        ON o.calendar_id = cal.calendar_id
    GROUP BY
        c.city_name,
        cal.year
)

SELECT
    city_name,
    MAX(CASE WHEN year = 2024 THEN total_revenue END) AS revenue_2024,
    MAX(CASE WHEN year = 2025 THEN total_revenue END) AS revenue_2025,
    ROUND(
        (
            MAX(CASE WHEN year = 2025 THEN total_revenue END) -
            MAX(CASE WHEN year = 2024 THEN total_revenue END)
        ) * 100 /
        MAX(CASE WHEN year = 2024 THEN total_revenue END),
        2
    ) AS growth_percentage
FROM city_yearly_revenue
GROUP BY
    city_name
ORDER BY
    growth_percentage DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai recorded the highest year-over-year revenue growth (1.14%),
  strengthening its position as the platform's strongest performing market.

• Ahmedabad also achieved positive revenue growth (0.41%), indicating
  gradual business expansion despite contributing the lowest overall revenue.

• Bengaluru, Delhi, Hyderabad and Pune experienced marginal declines in
  annual revenue, with Pune recording the largest decrease (-2.03%).

• The overall revenue variation across cities remains relatively small,
  indicating stable business performance across all operating markets.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue investing in Mumbai and Ahmedabad to sustain positive revenue
  momentum and accelerate market expansion.

• Investigate the underlying factors contributing to revenue decline in
  Pune, Hyderabad, Delhi and Bengaluru to identify opportunities for
  business improvement.

• Monitor year-over-year city performance regularly to support strategic
  investment and expansion decisions.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which payment methods generate the highest revenue and transaction volume?
==============================================================================

Business Objective
------------------
Evaluate customer payment preferences across the platform.

Business Value
--------------
Supports strategic payment partnerships and improves payment experience.

SQL Analysis
----------------------------------------------------------------------------*/

WITH payment_performance AS
(
    SELECT
        p.payment_method,
        COUNT(o.order_id) AS total_orders,
        ROUND(SUM(o.final_amount),2) AS total_revenue
    FROM orders o
    JOIN payments p
        ON o.payment_id = p.payment_id
    GROUP BY
        p.payment_method
)

SELECT
    RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank,
    payment_method,
    total_orders,
    total_revenue
FROM payment_performance
ORDER BY
    revenue_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Wallet payments generated the highest platform revenue (₹8.55 million)
  while also processing the largest number of customer transactions.

• Debit Card, Cash, Credit Card and UPI contributed comparable revenue,
  indicating balanced customer adoption across multiple payment methods.

• No single payment method dominates platform transactions, reducing
  dependency on a specific payment channel and improving payment resilience.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue strengthening digital payment partnerships while maintaining
  reliable support for all customer payment methods.

• Introduce payment-specific promotional campaigns to encourage greater
  adoption of digital payment options.

• Periodically monitor payment trends to optimize customer payment
  experience and banking partnerships.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does weather influence customer demand and platform revenue?
==============================================================================

Business Objective
------------------
Measure business performance under different weather conditions.

Business Value
--------------
Supports demand forecasting and operational planning.

SQL Analysis
----------------------------------------------------------------------------*/

WITH weather_performance AS
(
    SELECT
        w.weather_condition,
        COUNT(o.order_id) AS total_orders,
        ROUND(SUM(o.final_amount),2) AS total_revenue
    FROM orders o
    JOIN weather w
        ON o.weather_id = w.weather_id
    GROUP BY
        w.weather_condition
)

SELECT
    RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank,
    weather_condition,
    total_orders,
    total_revenue
FROM weather_performance
ORDER BY
    revenue_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Sunny weather generated the highest customer demand, contributing
  19,413 orders and ₹16.27 million in platform revenue.

• Customer demand gradually declined as weather conditions became more
  severe, with Heatwave producing the lowest revenue contribution.

• Despite weather fluctuations, the platform maintained consistent business
  activity across all weather conditions, demonstrating operational
  resilience throughout the year.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Increase rider availability and restaurant preparedness during favourable
  weather conditions to capitalize on higher customer demand.

• Develop weather-based promotional campaigns during adverse weather to
  maintain customer engagement and order volume.

• Integrate weather forecasting into operational planning to improve demand
  prediction and delivery resource allocation.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What are the platform's busiest ordering hours?
==============================================================================

Business Objective
------------------
Identify peak customer ordering hours.

Business Value
--------------
Supports restaurant staffing, rider allocation and demand planning.

SQL Analysis
----------------------------------------------------------------------------*/

WITH hourly_orders AS
(
    SELECT
        HOUR(order_timestamp) AS order_hour,
        COUNT(order_id) AS total_orders,
        ROUND(SUM(final_amount),2) AS total_revenue
    FROM orders
    GROUP BY
        HOUR(order_timestamp)
)

SELECT
    RANK() OVER(ORDER BY total_orders DESC) AS demand_rank,
    order_hour,
    total_orders,
    total_revenue
FROM hourly_orders
ORDER BY
    demand_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• The highest customer ordering activity occurred between 12 PM and 2 PM,
  with 12 PM recording the maximum order volume (5,921 orders).

• A second demand peak was observed during the evening period between
  7 PM and 10 PM, reflecting typical lunch and dinner ordering behaviour.

• Morning hours generated comparatively lower demand, indicating customer
  ordering patterns are concentrated around major meal times.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Allocate additional delivery riders and restaurant staff during peak lunch
  and dinner hours to improve operational efficiency.

• Schedule promotional campaigns during off-peak periods to balance demand
  throughout the day.

• Use hourly demand trends to optimize workforce scheduling and delivery
  resource planning.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which order statuses contribute to total revenue?
==============================================================================

Business Objective
------------------
Evaluate revenue generated from successfully completed orders.

Business Value
--------------
Provides executive visibility into revenue realization and losses due to
order cancellations.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount),2) AS total_revenue,
    ROUND(
        SUM(final_amount) * 100 /
        SUM(SUM(final_amount)) OVER(),
        2
    ) AS revenue_contribution_percentage
FROM orders
GROUP BY
    order_status
ORDER BY
    total_revenue DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Delivered orders generated 100% of platform revenue, contributing
  ₹41.89 million across 47,017 successfully completed transactions.

• Cancelled orders generated no revenue, highlighting the direct financial
  impact of unsuccessful order fulfilment.

• The platform's high delivery success rate ensures that revenue leakage due
  to order cancellations remains minimal.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining high delivery success rates to maximize revenue
  realization.

• Regularly analyze cancellation reasons to identify opportunities for
  reducing operational losses.

• Track order fulfilment performance as a key executive KPI for measuring
  overall business health.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What are the Executive KPIs that summarize the overall health of Project Velox?
==============================================================================

Business Objective
------------------
Provide a consolidated executive summary of the platform's key business
performance indicators.

Business Value
--------------
Enables executive leadership to monitor overall business health through a
single KPI dashboard.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    ROUND(SUM(final_amount),2) AS total_revenue,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(final_amount),2) AS average_order_value,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT restaurant_id) AS total_restaurants,
    COUNT(DISTINCT rider_id) AS total_riders,
    ROUND(
        SUM(order_status = 'Delivered') * 100.0 /
        COUNT(*),
        2
    ) AS delivery_success_rate
FROM orders;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Project Velox generated ₹41.89 million in revenue from 50,000 customer
  orders with an Average Order Value of ₹837.75.

• The platform currently serves 2,000 customers through a network of
  120 restaurant partners supported by 276 active delivery riders.

• An overall delivery success rate of 94.03% demonstrates strong operational
  efficiency and a reliable customer fulfilment process.

• These KPIs collectively indicate a stable, scalable and well-balanced
  food delivery marketplace capable of supporting future business growth.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Monitor these executive KPIs continuously through the CEO dashboard to
  support data-driven strategic decision-making.

• Establish quarterly performance benchmarks for revenue growth, customer
  acquisition and operational efficiency.

• Use this KPI summary as the primary executive performance scorecard for
  monitoring overall platform health.

/******************************************************************************
SECTION 2 : OPERATIONS ANALYTICS

Primary Stakeholder : Operations Manager

Purpose

Provides operational visibility into delivery performance, rider utilization,
restaurant efficiency, order fulfillment, cancellation analysis, service level
performance, and operational KPIs to support day-to-day decision-making and
continuous process improvement.

******************************************************************************/

/*==============================================================================
Business Question

What is the average delivery time across different order statuses?
==============================================================================

Business Objective
------------------
Evaluate delivery performance by comparing delivery times across different
order outcomes.

Business Value
--------------
Helps Operations Managers assess delivery efficiency and identify operational
delays affecting customer experience.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(delivery_minutes),2) AS average_delivery_time
FROM orders
GROUP BY
    order_status
ORDER BY
    average_delivery_time DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Successfully delivered orders required an average delivery time of
  approximately 40 minutes, demonstrating a consistent operational service
  level across the platform.

• Cancelled orders recorded zero delivery time as expected since deliveries
  were not completed.

• The results indicate that delivery time is currently measured only for
  completed deliveries, providing an accurate operational performance metric.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring average delivery time as a primary Service Level
  Agreement (SLA) metric for operational performance.

• Investigate deliveries exceeding the average completion time to identify
  opportunities for improving delivery efficiency.

• Establish delivery time benchmarks to continuously monitor operational
  performance across the platform.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which delivery riders handle the highest number of completed deliveries?
==============================================================================

Business Objective
------------------
Identify the most productive delivery riders based on completed deliveries.

Business Value
--------------
Supports workforce planning, rider recognition programs and performance
evaluation.

SQL Analysis
----------------------------------------------------------------------------*/

WITH rider_delivery_summary AS
(
    SELECT
        r.rider_name,
        COUNT(o.order_id) AS completed_deliveries
    FROM orders o
    JOIN riders r
        ON o.rider_id = r.rider_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        r.rider_name
),
ranked_riders AS
(
    SELECT
        DENSE_RANK() OVER(ORDER BY completed_deliveries DESC) AS rider_rank,
        rider_name,
        completed_deliveries
    FROM rider_delivery_summary
)

SELECT *
FROM ranked_riders
WHERE rider_rank <= 10
ORDER BY
    rider_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Rohan Joshi completed the highest number of successful deliveries (448),
  followed by Aditya Sharma (398) and Aarav Gupta (393).

• The top-performing riders consistently handled substantially higher delivery
  volumes than the remaining workforce, indicating differences in rider
  utilization.

• Delivery workload appears concentrated among a relatively small group of
  highly productive riders.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Recognize high-performing riders through performance incentive and reward
  programs to encourage continued operational excellence.

• Review rider workload distribution to ensure delivery assignments remain
  balanced across the workforce.

• Analyze operational practices adopted by top-performing riders and
  incorporate them into rider training programs.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does delivery performance vary across different weather conditions?
==============================================================================

Business Objective
------------------
Measure the operational impact of weather on delivery efficiency.

Business Value
--------------
Supports delivery planning and resource allocation during adverse weather
conditions.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    w.weather_condition,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.delivery_minutes),2) AS average_delivery_time
FROM orders o
JOIN weather w
    ON o.weather_id = w.weather_id
WHERE o.order_status = 'Delivered'
GROUP BY
    w.weather_condition
ORDER BY
    average_delivery_time DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Average delivery time remained remarkably consistent across all weather
  conditions, ranging between approximately 39.8 and 40.5 minutes.

• Heatwave conditions recorded the highest average delivery time, while
  Cloudy weather demonstrated the fastest deliveries.

• The minimal variation suggests that Project Velox maintains stable delivery
  performance regardless of changing weather conditions.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining current operational standards across all weather
  conditions to preserve delivery reliability.

• Develop contingency plans for extreme weather conditions to minimize any
  potential increase in delivery time.

• Monitor weather-related delivery performance periodically to identify
  emerging operational trends.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which delivery zones process the highest number of customer orders?
==============================================================================

Business Objective
------------------
Identify the busiest operational delivery zones.

Business Value
--------------
Supports rider allocation and operational resource planning.

SQL Analysis
----------------------------------------------------------------------------*/

WITH zone_order_summary AS
(
    SELECT
        dz.zone_name,
        c.city_name,
        COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN customers cu
        ON o.customer_id = cu.customer_id
    JOIN delivery_zones dz
        ON cu.zone_id = dz.zone_id
    JOIN cities c
        ON dz.city_id = c.city_id
    GROUP BY
        dz.zone_name,
        c.city_name
),
ranked_zones AS
(
    SELECT
        DENSE_RANK() OVER(ORDER BY total_orders DESC) AS zone_rank,
        city_name,
        zone_name,
        total_orders
    FROM zone_order_summary
)

SELECT *
FROM ranked_zones
WHERE zone_rank <= 10
ORDER BY
    zone_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Colaba (Mumbai) processed the highest number of customer orders (1,892),
  making it the busiest delivery zone on the platform.

• Mumbai and Pune dominate the busiest operational zones, together accounting
  for the majority of the Top 10 delivery locations.

• These zones represent areas of consistently high customer demand requiring
  efficient operational planning and resource allocation.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Allocate additional delivery riders during peak periods within high-demand
  delivery zones to maintain service quality.

• Continuously monitor order growth across delivery zones to support future
  operational expansion.

• Prioritize operational optimization initiatives within the busiest delivery
  zones to reduce delivery delays.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants experience the highest order cancellation rates?
==============================================================================

Business Objective
------------------
Identify restaurants contributing most to order cancellations.

Business Value
--------------
Helps Operations Managers reduce cancellations through targeted operational
improvements.

SQL Analysis
----------------------------------------------------------------------------*/

WITH restaurant_cancellations AS
(
    SELECT
        r.restaurant_name,
        COUNT(o.order_id) AS cancelled_orders
    FROM orders o
    JOIN restaurants r
        ON o.restaurant_id = r.restaurant_id
    WHERE o.order_status = 'Cancelled'
    GROUP BY
        r.restaurant_name
),
ranked_restaurants AS
(
    SELECT
        DENSE_RANK() OVER(ORDER BY cancelled_orders DESC) AS cancellation_rank,
        restaurant_name,
        cancelled_orders
    FROM restaurant_cancellations
)

SELECT *
FROM ranked_restaurants
WHERE cancellation_rank <= 10
ORDER BY
    cancellation_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Cafe Aroma Express experienced the highest number of cancelled orders (88),
  followed by Orient Kitchen Kitchen (80) and Pizza Nation Corner (76).

• Order cancellations are concentrated among a relatively small number of
  restaurants, indicating potential operational inefficiencies at specific
  restaurant partners.

• Identifying and addressing the causes of cancellations within these
  restaurants could significantly improve overall operational performance.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Conduct operational reviews with the highest cancellation restaurants to
  identify process improvement opportunities.

• Monitor restaurant preparation time, inventory availability and order
  acceptance practices to reduce cancellations.

• Track cancellation trends regularly to measure the effectiveness of
  operational improvement initiatives.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How efficiently are riders utilized across different work shifts?
==============================================================================

Business Objective
------------------
Evaluate rider workload distribution across operational shifts.

Business Value
--------------
Supports workforce scheduling and balanced rider allocation.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    r.shift,
    COUNT(DISTINCT r.rider_id) AS total_riders,
    COUNT(o.order_id) AS completed_orders,
    ROUND(
        COUNT(o.order_id) /
        COUNT(DISTINCT r.rider_id),
        2
    ) AS average_orders_per_rider
FROM riders r
LEFT JOIN orders o
    ON r.rider_id = o.rider_id
    AND o.order_status = 'Delivered'
GROUP BY
    r.shift
ORDER BY
    average_orders_per_rider DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Night shifts recorded the highest rider utilization, averaging
  158.03 completed deliveries per rider despite having the smallest rider
  workforce (78 riders).

• Afternoon shifts processed the highest overall delivery volume
  (20,961 completed orders) due to having the largest rider workforce,
  while maintaining a comparable average workload per rider.

• Rider utilization remained highly consistent across all operational shifts,
  varying by less than two deliveries per rider, indicating balanced workload
  distribution and effective workforce planning.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining balanced rider scheduling across operational shifts to
  sustain consistent delivery performance.

• Monitor future demand growth to ensure rider capacity remains aligned with
  customer ordering patterns.

• Use rider utilization metrics to optimize workforce planning and shift
  allocation decisions.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does delivery time vary across different cities?
==============================================================================

Business Objective
------------------
Compare operational delivery efficiency across all operating cities.

Business Value
--------------
Helps identify cities requiring operational improvements and resource
optimization.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    c.city_name,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(AVG(o.delivery_minutes),2) AS average_delivery_time
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id = dz.zone_id
JOIN cities c
    ON dz.city_id = c.city_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.city_name
ORDER BY
    average_delivery_time DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai recorded the highest average delivery time (40.12 minutes), while
  Ahmedabad achieved the fastest average delivery time (39.83 minutes).

• Average delivery times varied by less than one minute across all operating
  cities, demonstrating highly consistent operational performance.

• The narrow variation indicates standardized delivery processes and effective
  operational execution throughout the platform.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Maintain standardized operational procedures across all cities to preserve
  consistent delivery performance.

• Continue monitoring city-level delivery metrics to identify emerging
  operational challenges before they affect customer experience.

• Use city-level delivery performance as a benchmark for evaluating future
  operational expansion.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What are the most common reasons for order cancellations?
==============================================================================

Business Objective
------------------
Identify the primary operational reasons behind order cancellations.

Business Value
--------------
Helps Operations Managers prioritize process improvements that reduce
avoidable order cancellations and improve customer satisfaction.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    cancellation_reason,
    COUNT(order_id) AS cancelled_orders,
    ROUND(
        COUNT(order_id) * 100.0 /
        SUM(COUNT(order_id)) OVER(),
        2
    ) AS cancellation_percentage
FROM orders
WHERE order_status = 'Cancelled'
GROUP BY
    cancellation_reason
ORDER BY
    cancelled_orders DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Restaurant Closed was the leading cause of order cancellations,
  accounting for 769 cancelled orders (25.78%), closely followed by
  Payment Failed (25.75%).

• Customer Cancelled and Rider Unavailable contributed almost equally,
  representing 24.27% and 24.20% of cancellations respectively.

• The cancellation distribution is relatively balanced across all four
  categories, indicating that operational improvements should target
  multiple processes rather than a single failure point.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Collaborate with restaurant partners to improve operating hour management
  and real-time restaurant availability.

• Strengthen payment reliability by monitoring payment gateway failures and
  reducing transaction interruptions.

• Improve rider availability through optimized workforce scheduling during
  peak demand periods.

• Continuously monitor cancellation trends to evaluate the effectiveness of
  operational improvement initiatives.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which weather conditions contribute to the highest order cancellation rates?
==============================================================================

Business Objective
------------------
Measure the relationship between weather conditions and cancelled orders.

Business Value
--------------
Supports proactive operational planning during adverse weather conditions.

SQL Analysis
----------------------------------------------------------------------------*/

WITH weather_cancellations AS
(
    SELECT
        w.weather_condition,
        COUNT(*) AS total_orders,
        SUM(o.order_status = 'Cancelled') AS cancelled_orders,
        ROUND(
            SUM(o.order_status = 'Cancelled') * 100.0 /
            COUNT(*),
            2
        ) AS cancellation_rate
    FROM orders o
    JOIN weather w
        ON o.weather_id = w.weather_id
    GROUP BY
        w.weather_condition
)

SELECT
    DENSE_RANK() OVER(ORDER BY cancellation_rate DESC) AS weather_rank,
    weather_condition,
    total_orders,
    cancelled_orders,
    cancellation_rate
FROM weather_cancellations
ORDER BY
    weather_rank
LIMIT 10;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Rainy weather recorded the highest cancellation rate (6.10%), indicating
  that adverse weather conditions slightly increase operational disruptions.

• Cancellation rates across all weather conditions remained within a narrow
  range of 5.59% to 6.10%, demonstrating consistent operational resilience.

• Despite processing the highest order volume, Sunny weather maintained a
  cancellation rate comparable to other weather conditions.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Increase rider availability during rainy weather to minimize weather-related
  operational disruptions.

• Develop contingency plans for adverse weather conditions to maintain
  delivery reliability.

• Continue monitoring weather-driven operational performance to improve
  demand forecasting and delivery planning.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do promoted orders require longer delivery times than regular orders?
==============================================================================

Business Objective
------------------
Evaluate the operational impact of promotional campaigns.

Business Value
--------------
Helps balance marketing initiatives with delivery capacity planning.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN promotion_id = 0 THEN 'Regular Orders'
        ELSE 'Promotional Orders'
    END AS order_type,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(delivery_minutes),2) AS average_delivery_time
FROM orders
WHERE order_status = 'Delivered'
GROUP BY
    order_type;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Promotional orders required an average delivery time of 40.06 minutes,
  only marginally higher than Regular Orders (39.96 minutes).

• The negligible difference indicates that promotional campaigns do not
  significantly impact operational delivery performance.

• Current delivery capacity appears sufficient to support promotional demand
  without affecting customer service levels.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue running promotional campaigns while maintaining existing delivery
  capacity.

• Monitor delivery performance during large-scale promotional events to
  identify potential operational bottlenecks.

• Coordinate future marketing campaigns with operations planning to ensure
  sufficient delivery resources remain available.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments generate the highest order cancellation rates?
==============================================================================

Business Objective
------------------
Identify customer segments experiencing higher operational failures.

Business Value
--------------
Supports targeted operational improvements for specific customer groups.

SQL Analysis
----------------------------------------------------------------------------*/

WITH segment_cancellation_summary AS
(
    SELECT
        c.customer_segment,
        COUNT(*) AS total_orders,
        SUM(o.order_status = 'Cancelled') AS cancelled_orders,
        ROUND(
            SUM(o.order_status = 'Cancelled') * 100.0 /
            COUNT(*),
            2
        ) AS cancellation_rate
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY
        c.customer_segment
)

SELECT
    DENSE_RANK() OVER(ORDER BY cancellation_rate DESC) AS segment_rank,
    customer_segment,
    total_orders,
    cancelled_orders,
    cancellation_rate
FROM segment_cancellation_summary
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Student customers experienced the highest cancellation rate (6.30%),
  followed by Working Professionals (5.91%).

• Family and Food Enthusiast segments demonstrated slightly lower
  cancellation rates, indicating relatively stable operational performance.

• Although cancellation rates vary across customer segments, the overall
  differences remain modest, suggesting consistent service quality across
  the customer base.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Investigate factors contributing to higher cancellation rates among
  Student customers, particularly during peak demand periods.

• Monitor customer segment performance regularly to identify emerging
  operational trends.

• Develop targeted operational improvements for segments demonstrating
  consistently higher cancellation rates.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants have the longest average delivery times?
==============================================================================

Business Objective
------------------
Identify restaurant partners contributing to slower deliveries.

Business Value
--------------
Supports operational collaboration with restaurant partners to improve
delivery efficiency.

SQL Analysis
----------------------------------------------------------------------------*/

WITH restaurant_delivery_summary AS
(
    SELECT
        r.restaurant_name,
        COUNT(o.order_id) AS completed_orders,
        ROUND(AVG(o.delivery_minutes),2) AS average_delivery_time
    FROM orders o
    JOIN restaurants r
        ON o.restaurant_id = r.restaurant_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        r.restaurant_name
),
ranked_restaurants AS
(
    SELECT
        DENSE_RANK() OVER(ORDER BY average_delivery_time DESC) AS delivery_rank,
        restaurant_name,
        completed_orders,
        average_delivery_time
    FROM restaurant_delivery_summary
)

SELECT *
FROM ranked_restaurants
WHERE delivery_rank <= 10
ORDER BY
    delivery_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Spice Junction Kitchen recorded the highest average delivery time
  (41.52 minutes), followed closely by Dum House Kitchen and
  Noodle House Hub.

• The Top 10 restaurants exhibited only minor differences in average
  delivery time, with all values remaining close to 41 minutes.

• These restaurants represent operational improvement opportunities where
  reducing preparation or dispatch time could further enhance delivery
  efficiency.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Collaborate with restaurant partners to optimize food preparation and
  order dispatch processes.

• Monitor delivery performance for high-volume restaurants to identify
  recurring operational bottlenecks.

• Establish restaurant-level delivery performance benchmarks to encourage
  continuous operational improvement.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do weekend orders require longer delivery times than weekday orders?
==============================================================================

Business Objective
------------------
Compare operational efficiency between weekdays and weekends.

Business Value
--------------
Supports staffing and delivery resource planning based on customer demand.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN c.is_weekend = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.delivery_minutes),2) AS average_delivery_time
FROM orders o
JOIN calendar c
    ON o.calendar_id = c.calendar_id
WHERE o.order_status = 'Delivered'
GROUP BY
    day_type;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Average delivery time remained almost identical between weekdays
  (40.03 minutes) and weekends (39.89 minutes).

• Weekend demand does not appear to negatively impact delivery efficiency,
  indicating effective operational resource planning.

• The platform successfully maintains consistent service levels throughout
  the entire week.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining balanced rider allocation throughout both weekdays
  and weekends.

• Monitor weekend demand growth periodically to ensure delivery capacity
  remains aligned with customer demand.

• Maintain current workforce planning strategies that support consistent
  delivery performance across the week.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which payment methods experience the highest order cancellation rates?
==============================================================================

Business Objective
------------------
Determine whether payment methods influence operational cancellations.

Business Value
--------------
Supports improvements in payment processing reliability and customer
checkout experience.

SQL Analysis
----------------------------------------------------------------------------*/

WITH payment_cancellation_summary AS
(
    SELECT
        p.payment_method,
        COUNT(*) AS total_orders,
        SUM(o.order_status = 'Cancelled') AS cancelled_orders,
        ROUND(
            SUM(o.order_status = 'Cancelled') * 100.0 /
            COUNT(*),
            2
        ) AS cancellation_rate
    FROM orders o
    JOIN payments p
        ON o.payment_id = p.payment_id
    GROUP BY
        p.payment_method
)

SELECT
    DENSE_RANK() OVER(ORDER BY cancellation_rate DESC) AS payment_rank,
    payment_method,
    total_orders,
    cancelled_orders,
    cancellation_rate
FROM payment_cancellation_summary
ORDER BY
    payment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Wallet payments recorded the highest cancellation rate (6.20%), followed
  closely by Credit Card transactions (6.04%).

• Cancellation rates across all payment methods remained relatively
  consistent, varying by less than one percentage point.

• The small variation suggests that payment method is not currently a major
  contributor to operational order cancellations.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring payment performance to identify emerging payment
  reliability issues.

• Collaborate with payment service providers to minimize transaction
  failures and improve checkout reliability.

• Periodically review payment-related operational metrics as part of routine
  service quality monitoring.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What percentage of deliveries meet the platform's Service Level Agreement
(SLA) of 40 minutes?
==============================================================================

Business Objective
------------------
Measure operational compliance against the platform's delivery SLA.

Business Value
--------------
Provides Operations Managers with a key performance indicator for monitoring
delivery efficiency and customer service quality.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN delivery_minutes <= 40 THEN 'Within SLA'
        ELSE 'Outside SLA'
    END AS sla_status,
    COUNT(order_id) AS total_deliveries,
    ROUND(
        COUNT(order_id) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM orders
WHERE order_status = 'Delivered'
GROUP BY
    sla_status;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• 24,143 deliveries (51.35%) were completed within the platform's
  40-minute Service Level Agreement (SLA), while 48.65% exceeded the
  target delivery time.

• The results indicate that approximately half of all completed deliveries
  satisfy the current operational SLA, highlighting opportunities for
  improving delivery efficiency.

• SLA compliance should be continuously monitored as a key operational KPI
  for measuring customer service performance.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Investigate deliveries exceeding the 40-minute SLA to identify operational
  bottlenecks affecting delivery performance.

• Focus improvement initiatives on restaurant preparation time, rider
  allocation and route optimization to increase SLA compliance.

• Establish periodic SLA reviews to monitor operational improvements and
  customer service quality.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities demonstrate the highest rider productivity?
==============================================================================

Business Objective
------------------
Evaluate rider productivity across operating cities.

Business Value
--------------
Supports rider workforce planning and operational resource allocation.

SQL Analysis
----------------------------------------------------------------------------*/

WITH city_rider_productivity AS
(
    SELECT
        c.city_name,
        COUNT(o.order_id) AS completed_orders,
        COUNT(DISTINCT o.rider_id) AS active_riders,
        ROUND(
            COUNT(o.order_id) /
            COUNT(DISTINCT o.rider_id),
            2
        ) AS orders_per_rider
    FROM orders o
    JOIN customers cu
        ON o.customer_id = cu.customer_id
    JOIN delivery_zones dz
        ON cu.zone_id = dz.zone_id
    JOIN cities c
        ON dz.city_id = c.city_id
    WHERE o.order_status='Delivered'
    GROUP BY
        c.city_name
),
ranked_city_productivity AS
(
    SELECT
        DENSE_RANK() OVER(ORDER BY orders_per_rider DESC) AS productivity_rank,
        city_name,
        completed_orders,
        active_riders,
        orders_per_rider
    FROM city_rider_productivity
)

SELECT *
FROM ranked_city_productivity
WHERE productivity_rank <= 10
ORDER BY
    productivity_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Hyderabad achieved the highest rider productivity with an average of
  181.62 completed deliveries per rider, closely followed by Mumbai
  (181.28 orders per rider).

• Bengaluru, Pune and Delhi demonstrated comparable rider productivity,
  while Ahmedabad recorded noticeably lower rider utilization.

• The variation suggests opportunities to optimize rider allocation and
  increase operational efficiency in lower-performing cities.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Review rider deployment strategies in Ahmedabad to improve rider
  productivity and workload utilization.

• Analyze operational practices followed in Hyderabad and Mumbai and
  replicate successful approaches across other cities.

• Continuously monitor rider productivity as an operational KPI to support
  workforce planning and resource optimization.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How are customer orders distributed across operational shifts?
==============================================================================

Business Objective
------------------
Analyze customer demand distribution throughout the day.

Business Value
--------------
Supports rider scheduling and operational workforce planning.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    r.shift,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        COUNT(o.order_id) *100.0/
        SUM(COUNT(*)) OVER(),
        2
    ) AS order_percentage
FROM orders o
JOIN riders r
    ON o.rider_id=r.rider_id
GROUP BY
    r.shift
ORDER BY
    total_orders DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Afternoon shifts processed the highest customer demand, accounting for
  22,329 orders (44.66% of all platform orders).

• Morning and Night shifts contributed 29.13% and 26.21% of total orders
  respectively, indicating a balanced distribution outside peak hours.

• Customer demand is strongly concentrated during the afternoon period,
  making it the most operationally critical shift.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Allocate additional riders during afternoon shifts to support peak
  customer demand and maintain delivery efficiency.

• Optimize workforce scheduling to match customer ordering patterns across
  different operational shifts.

• Continuously monitor shift-level demand to improve operational planning
  and resource allocation.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do festivals increase average delivery time?
==============================================================================

Business Objective
------------------
Measure the operational impact of festival demand.

Business Value
--------------
Supports proactive operational planning during festival periods.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN c.festival_flag=1 THEN 'Festival'
        ELSE 'Non-Festival'
    END AS period,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(AVG(o.delivery_minutes),2) AS average_delivery_time
FROM orders o
JOIN calendar c
    ON o.calendar_id=c.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    period;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Average delivery time remained nearly identical during Festival
  (39.75 minutes) and Non-Festival (39.99 minutes) periods.

• Despite increased customer activity during festivals, operational
  performance remained stable without any significant increase in delivery
  time.

• The results demonstrate that Project Velox effectively maintains service
  quality during high-demand festival periods.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining current operational planning practices during
  festival periods.

• Monitor future festival demand growth to ensure rider capacity remains
  aligned with customer demand.

• Incorporate festival forecasting into workforce planning to maintain
  consistent delivery performance.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does delivery performance vary across different seasons?
==============================================================================

Business Objective
------------------
Evaluate operational efficiency throughout different seasons.

Business Value
--------------
Supports seasonal operational planning and delivery resource allocation.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    c.season,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(AVG(o.delivery_minutes),2) AS average_delivery_time
FROM orders o
JOIN calendar c
    ON o.calendar_id=c.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    c.season
ORDER BY
    average_delivery_time DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Summer recorded the highest average delivery time (40.10 minutes),
  followed by Winter (39.97 minutes) and Monsoon (39.93 minutes).

• Seasonal variation in delivery performance remained minimal, differing by
  less than 0.2 minutes across all seasons.

• The results indicate consistent operational performance regardless of
  seasonal demand fluctuations.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining standardized delivery operations throughout all
  seasons.

• Monitor seasonal demand periodically to identify emerging operational
  trends that may require additional resource allocation.

• Use seasonal performance metrics to support long-term operational
  planning.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do higher delivery fees correspond to faster deliveries?
==============================================================================

Business Objective
------------------
Evaluate whether delivery pricing reflects operational service levels.

Business Value
--------------
Supports delivery pricing strategy and customer value proposition.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    delivery_fee,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(delivery_minutes),2) AS average_delivery_time
FROM orders
WHERE order_status='Delivered'
GROUP BY
    delivery_fee
ORDER BY
    delivery_fee;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Average delivery time remained remarkably consistent across all delivery
  fee categories, ranging between approximately 39.90 and 40.10 minutes.

• Higher delivery fees did not correspond to faster deliveries, indicating
  that pricing is independent of delivery speed.

• Customers receive a consistent delivery experience regardless of the
  delivery fee charged.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining uniform delivery service standards across all
  delivery fee categories.

• Review delivery pricing strategies independently of operational
  performance metrics.

• Regularly monitor delivery fee effectiveness to ensure pricing remains
  aligned with customer expectations.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What are the key operational KPIs summarizing platform efficiency?
==============================================================================

Business Objective
------------------
Provide a consolidated operational KPI summary for Operations Management.

Business Value
--------------
Enables continuous monitoring of delivery performance, operational efficiency
and service quality through a single KPI report.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    ROUND(AVG(delivery_minutes),2) AS average_delivery_time,
    ROUND(
        SUM(order_status='Delivered')*100.0/
        COUNT(*),
        2
    ) AS delivery_success_rate,
    ROUND(
        SUM(order_status='Cancelled')*100.0/
        COUNT(*),
        2
    ) AS cancellation_rate,
    COUNT(DISTINCT rider_id) AS active_riders,
    COUNT(DISTINCT restaurant_id) AS active_restaurants,
    ROUND(
        COUNT(order_id)/
        COUNT(DISTINCT rider_id),
        2
    ) AS average_orders_per_rider
FROM orders;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Project Velox achieved an average delivery time of 37.60 minutes with a
  delivery success rate of 94.03%, demonstrating strong operational
  efficiency.

• The platform maintained a low cancellation rate of only 5.97% while
  supporting operations through 276 active riders and 120 restaurant
  partners.

• On average, each rider completed approximately 181 deliveries,
  highlighting efficient rider utilization across the delivery network.

• These operational KPIs collectively indicate a stable, scalable and
  well-managed delivery ecosystem capable of supporting future business
  growth.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring operational KPIs through the Operations dashboard to
  support data-driven decision-making.

• Establish operational performance benchmarks for delivery success,
  cancellation rate and rider productivity.

• Review operational KPIs regularly to identify continuous improvement
  opportunities across the delivery network.

----------------------------------------------------------------------------*/

/******************************************************************************
SECTION 3 : RESTAURANT ANALYTICS

Primary Stakeholder : Restaurant Partners / Restaurant Managers

Purpose

Provides restaurant partners with comprehensive insights into revenue,
customer demand, menu performance, business growth, customer satisfaction,
and operational performance to support data-driven decisions that improve
sales, profitability, and customer experience.

******************************************************************************/

/*==============================================================================
Business Question

Which restaurants generate the highest total revenue?

==============================================================================

Business Objective
------------------
Identify the highest revenue-generating restaurant partners across the
platform.

Business Value
--------------
Helps restaurant partners benchmark their financial performance against
competitors and identify top-performing businesses.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS revenue_rank,
    r.restaurant_name,
    ROUND(SUM(o.final_amount),2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    r.restaurant_name
ORDER BY
    revenue_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Pizza Nation Corner generated the highest restaurant revenue on the
  platform with ₹1,265,278.70, followed by Orient Kitchen Kitchen and
  Cool Drinks Kitchen.

• The Top 10 restaurants collectively demonstrate strong revenue
  concentration, indicating that a relatively small group of restaurant
  partners contributes significantly to platform revenue.

• High-performing restaurants provide valuable benchmarks for revenue
  optimization strategies across the platform.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Study the operational and menu strategies of the highest revenue-generating
  restaurants and share best practices across partner restaurants.

• Encourage mid-performing restaurants to adopt successful pricing,
  promotional and customer engagement strategies.

• Monitor revenue rankings regularly to identify emerging high-performing
  restaurant partners.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants receive the highest number of completed orders?

==============================================================================

Business Objective
------------------
Measure customer demand across restaurant partners.

Business Value
--------------
Helps restaurants benchmark customer demand and evaluate overall business
volume.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS order_rank,
    r.restaurant_name,
    COUNT(*) AS completed_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    r.restaurant_name
ORDER BY
    order_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Orient Kitchen Kitchen processed the highest number of completed orders
  (1,264), narrowly outperforming Pizza Nation Corner (1,222).

• Several restaurants maintain consistently high customer demand, indicating
  strong market presence and customer loyalty.

• Order volume does not always correspond directly with total revenue,
  highlighting differences in average customer spending across restaurants.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Help lower-volume restaurants improve customer acquisition through targeted
  promotional campaigns and improved menu visibility.

• Continue monitoring order trends to identify changes in customer demand.

• Benchmark operational practices of high-volume restaurants to improve
  overall restaurant performance.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants achieve the highest average order value?

==============================================================================

Business Objective
------------------
Evaluate the average customer spending per completed order for each
restaurant.

Business Value
--------------
Helps restaurants understand pricing effectiveness and identify
opportunities to increase customer spending.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY AVG(o.final_amount) DESC) AS aov_rank,
    r.restaurant_name,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    r.restaurant_name
HAVING COUNT(*) >= 100
ORDER BY
    aov_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Juice Junction Cafe achieved the highest average order value at
  ₹1,842.88 per completed order, indicating strong customer spending.

• Beverage-focused and premium restaurants dominate the highest average
  order value rankings, suggesting successful pricing or upselling
  strategies.

• Restaurants with high average order values may generate strong revenue
  even with comparatively fewer completed orders.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Encourage restaurants to increase average order value through combo meals,
  premium offerings and personalized upselling strategies.

• Analyze pricing strategies of high-performing restaurants to identify
  practices that can be replicated across the platform.

• Monitor average order value alongside order volume to maintain balanced
  revenue growth.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurant categories generate the highest platform revenue?

==============================================================================

Business Objective
------------------
Compare revenue performance across different restaurant categories.

Business Value
--------------
Supports restaurant investment decisions and identifies cuisine segments
driving overall platform revenue.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS category_rank,
    rc.category_name,
    ROUND(SUM(o.final_amount),2) AS total_revenue
FROM restaurant_categories rc
JOIN restaurants r
    ON rc.category_id = r.category_id
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    rc.category_name
ORDER BY
    category_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• North Indian cuisine generated the highest platform revenue
  (₹5.77 million), followed by Pizza and Chinese restaurants.

• The Top 3 restaurant categories collectively contribute a substantial
  share of overall platform revenue, reflecting strong customer demand.

• Cuisine preferences remain diversified, with multiple categories
  contributing significantly to business performance.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue strengthening partnerships within high-performing cuisine
  categories while expanding successful restaurant brands.

• Promote emerging cuisine categories through targeted marketing campaigns
  to diversify platform revenue.

• Periodically review category performance to support restaurant onboarding
  strategies.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants receive the highest average customer ratings?

==============================================================================

Business Objective
------------------
Measure customer satisfaction across restaurant partners.

Business Value
--------------
Helps restaurants benchmark customer satisfaction and identify businesses
delivering consistently positive dining experiences.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY AVG(rv.rating) DESC) AS rating_rank,
    r.restaurant_name,
    ROUND(AVG(rv.rating),2) AS average_rating
FROM restaurants r
JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY
    r.restaurant_name
HAVING COUNT(*) >= 100
ORDER BY
    rating_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Grill Nation Kitchen recorded the highest average customer rating (4.23),
  closely followed by Smoothie Point Corner and Biryani Junction House.

• Customer ratings remain consistently high across most restaurants,
  reflecting a generally positive customer dining experience.

• The narrow variation in ratings suggests stable service quality throughout
  the restaurant network.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Recognize highly rated restaurants as quality benchmarks across the
  platform.

• Encourage lower-rated restaurants to adopt customer service practices from
  consistently high-performing partners.

• Continue monitoring customer feedback to support continuous quality
  improvement.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants experience the highest cancellation rates?

==============================================================================

Business Objective
------------------
Identify restaurants contributing disproportionately to order
cancellations.

Business Value
--------------
Enables restaurant partners to improve operational reliability and reduce
avoidable order cancellations.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (
        ORDER BY
            SUM(o.order_status = 'Cancelled') * 100.0 / COUNT(*) DESC
    ) AS cancellation_rank,
    r.restaurant_name,
    COUNT(*) AS total_orders,
    SUM(o.order_status = 'Cancelled') AS cancelled_orders,
    ROUND(
        SUM(o.order_status = 'Cancelled') * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_name
HAVING COUNT(*) >= 100
ORDER BY
    cancellation_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• The Curry House Corner recorded the highest cancellation rate (9.20%),
  followed by Urban Slice House and Biryani Junction House.

• Cancellation rates vary considerably across restaurants, indicating that
  operational performance differs significantly between restaurant partners.

• High cancellation rates may negatively impact customer satisfaction,
  restaurant reputation and long-term revenue generation.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Work with restaurants exhibiting high cancellation rates to identify
  operational bottlenecks and improve order fulfillment reliability.

• Monitor cancellation trends regularly and establish acceptable operational
  performance benchmarks.

• Encourage restaurants with consistently low cancellation rates to share
  operational best practices across the partner network.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurants generate the highest average daily revenue?

==============================================================================

Business Objective
------------------
Evaluate the consistency of restaurant revenue generation over time.

Business Value
--------------
Helps restaurant partners identify businesses that sustain strong daily
performance rather than relying solely on total revenue.

SQL Analysis
----------------------------------------------------------------------------*/

WITH daily_revenue AS
(
    SELECT
        restaurant_id,
        DATE(order_timestamp) AS order_date,
        SUM(final_amount) AS daily_revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY
        restaurant_id,
        DATE(order_timestamp)
)

SELECT
    DENSE_RANK() OVER (ORDER BY AVG(d.daily_revenue) DESC) AS daily_rank,
    r.restaurant_name,
    ROUND(AVG(d.daily_revenue),2) AS average_daily_revenue
FROM restaurants r
JOIN daily_revenue d
    ON r.restaurant_id = d.restaurant_id
GROUP BY
    r.restaurant_name
ORDER BY
    daily_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Juice Junction Cafe generated the highest average daily revenue
  (₹2,514.92), followed by Cool Drinks Kitchen and Fresh Sip House.

• Several restaurants demonstrate consistently strong daily revenue,
  indicating stable customer demand rather than isolated sales spikes.

• Average daily revenue provides a more balanced measure of restaurant
  performance than total revenue alone by accounting for day-to-day
  business consistency.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Track average daily revenue alongside total revenue to monitor sustainable
  business growth.

• Identify operational practices of restaurants with consistently strong
  daily performance and encourage wider adoption across partner restaurants.

• Use daily revenue trends to support staffing, inventory planning and
  long-term restaurant growth strategies.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which menu items generate the highest total revenue?

==============================================================================

Business Objective
------------------
Identify the menu items that contribute the highest revenue across the
platform.

Business Value
--------------
Helps restaurant partners understand which products generate the greatest
financial contribution and supports menu engineering decisions.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(oi.line_total) DESC) AS item_rank,
    mi.item_name,
    ROUND(SUM(oi.line_total),2) AS total_revenue
FROM order_items oi
JOIN menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
GROUP BY
    mi.item_name
ORDER BY
    item_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Chicken Biryani generated the highest menu-item revenue at ₹471.38K,
  followed closely by Paneer Biryani and Veg Sandwich.

• The top-performing menu consists primarily of Biryani, Pizza and
  Quick-Service items, indicating strong customer demand for complete
  meal offerings.

• Revenue gradually declines beyond the top-ranked products,
  highlighting that a relatively small group of menu items contributes
  a significant share of restaurant revenue.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Prioritize inventory availability and kitchen capacity for the
  highest-revenue menu items during peak business hours.

• Promote complementary add-on items with top-selling dishes to
  further increase average order value.

• Periodically review lower-performing products for menu optimization,
  pricing adjustments or promotional campaigns.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which menu items are ordered most frequently by customers?

==============================================================================

Business Objective
------------------
Measure customer demand for each menu item.

Business Value
--------------
Supports inventory planning, kitchen preparation and menu optimization.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS popularity_rank,
    mi.item_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
GROUP BY
    mi.item_name
ORDER BY
    popularity_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mineral Water is the most frequently ordered menu item with
  2,369 units sold, followed by Cold Coffee and Garlic Bread.

• Beverage and side items dominate order volume, demonstrating
  strong attachment purchases alongside primary meals.

• High order frequency does not always translate into highest
  revenue, emphasizing the importance of evaluating both demand
  and profitability together.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue bundling frequently ordered beverages and side items
  with popular meals to maximize basket size.

• Maintain adequate inventory levels for high-demand products to
  minimize stock-out situations.

• Monitor high-volume, low-margin items to ensure they remain
  operationally profitable.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which item types contribute the highest restaurant revenue?

==============================================================================

Business Objective
------------------
Evaluate revenue contribution by menu item type.

Business Value
--------------
Helps restaurants optimize their product portfolio and pricing strategy.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(oi.line_total) DESC) AS item_type_rank,
    mi.item_type,
    ROUND(SUM(oi.line_total),2) AS total_revenue
FROM order_items oi
JOIN menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
GROUP BY
    mi.item_type
ORDER BY
    item_type_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Main Course items contribute ₹24.17 million, accounting for the
  majority of restaurant revenue.

• Starter, Dessert and Beverage categories collectively generate
  substantial additional revenue, supporting overall menu diversity.

• The revenue distribution indicates that customers primarily visit
  the platform for complete meal purchases while complementary
  categories enhance overall order value.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue expanding the Main Course portfolio while maintaining
  balanced menu diversity.

• Cross-sell desserts and beverages alongside main meals to increase
  average customer spend.

• Review pricing strategies within each category to maximize overall
  menu profitability.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How do customer ordering preferences differ between Vegetarian and
Non-Vegetarian menu items?

==============================================================================

Business Objective
------------------
Compare customer demand and revenue generated by vegetarian and
non-vegetarian menu items.

Business Value
--------------
Supports menu planning and helps restaurants understand changing customer
food preferences.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN mi.is_veg = 1 THEN 'Vegetarian'
        ELSE 'Non-Vegetarian'
    END AS food_type,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.line_total),2) AS total_revenue,
    ROUND(AVG(oi.line_total),2) AS average_order_value
FROM order_items oi
JOIN menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
GROUP BY
    food_type;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Vegetarian menu items generated ₹30.86 million from nearly
  135 thousand units sold, representing the majority of platform demand.

• Non-Vegetarian items generated fewer sales but achieved a
  significantly higher average revenue per order (₹429.47 vs ₹309.21).

• Customer demand favors Vegetarian offerings, while Non-Vegetarian
  products contribute greater revenue efficiency per purchase.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue strengthening the Vegetarian portfolio to maintain
  high customer demand.

• Position premium Non-Vegetarian products strategically through
  targeted promotions and upselling opportunities.

• Balance menu expansion by optimizing both high-volume and
  high-value product segments.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do promotional campaigns influence restaurant order value?

==============================================================================

Business Objective
------------------
Compare promotional and regular restaurant orders.

Business Value
--------------
Measures whether promotions increase restaurant sales or mainly provide
discounts without increasing customer spending.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN promotion_id IS NULL THEN 'Regular Orders'
        ELSE 'Promotional Orders'
    END AS order_type,
    COUNT(*) AS total_orders,
    ROUND(AVG(subtotal),2) AS average_subtotal,
    ROUND(AVG(discount_amount),2) AS average_discount,
    ROUND(AVG(final_amount),2) AS average_final_bill
FROM orders
WHERE order_status='Delivered'
GROUP BY
    order_type;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• All delivered orders in the dataset utilized promotional offers,
  resulting in an average discount of ₹24.78 per order.

• Despite promotional discounts, the platform maintained a healthy
  average customer bill of approximately ₹890.91.

• Promotions appear to support customer acquisition while preserving
  overall restaurant revenue generation.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue evaluating promotional effectiveness using incremental
  revenue and repeat purchase metrics.

• Introduce targeted promotions instead of blanket discounts to
  improve campaign profitability.

• Periodically review discount policies to maintain an optimal
  balance between customer acquisition and restaurant margins.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which payment methods are most preferred by restaurant customers?

==============================================================================

Business Objective
------------------
Analyze customer payment preferences for completed restaurant orders.

Business Value
--------------
Helps restaurants understand payment behaviour and prioritize convenient
payment options.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS payment_rank,
    p.payment_method,
    COUNT(*) AS total_orders
FROM orders o
JOIN payments p
    ON o.payment_id = p.payment_id
WHERE o.order_status='Delivered'
GROUP BY
    p.payment_method
ORDER BY
    payment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Digital payment methods dominate restaurant transactions,
  with Wallet leading at 9,514 completed orders.

• Debit Card, UPI, Credit Card and Cash exhibit highly comparable
  adoption levels, indicating balanced customer payment preferences.

• The diversified payment distribution reduces dependency on any
  single payment channel.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue supporting multiple payment options to maximize
  customer convenience.

• Monitor payment success rates across providers to maintain
  seamless checkout experiences.

• Collaborate with digital payment partners for targeted cashback
  campaigns during seasonal demand periods.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which menu items generate the highest revenue per unit sold?

==============================================================================

Business Objective
------------------
Identify premium-performing menu items based on revenue generated for every
unit sold.

Business Value
--------------
Supports pricing decisions and helps restaurants identify products with
strong revenue efficiency.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.line_total) / SUM(oi.quantity) DESC
    ) AS efficiency_rank,
    mi.item_name,
    ROUND(
        SUM(oi.line_total) / SUM(oi.quantity),
        2
    ) AS revenue_per_unit
FROM order_items oi
JOIN menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
GROUP BY
    mi.item_name
HAVING SUM(oi.quantity) >= 50
ORDER BY
    efficiency_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Premium menu items such as Grilled Vegetables, Penne Arrabbiata
  and Herb Rice generate the highest revenue per unit sold.

• Several premium dishes achieve strong revenue efficiency despite
  relatively lower order volumes, indicating successful premium pricing.

• Lower-ranked beverage items generate substantially lower revenue
  per unit, reflecting their role as complementary purchases rather
  than primary revenue drivers.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Highlight premium dishes within restaurant menus to improve
  average order value.

• Bundle premium products with complementary beverages or desserts
  to encourage higher-value purchases.

• Periodically review pricing of low-performing items while preserving
  perceived customer value.

----------------------------------------------------------------------------*/