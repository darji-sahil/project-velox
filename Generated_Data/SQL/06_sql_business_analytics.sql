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

/******************************************************************************
SECTION 4 : MARKETING ANALYTICS

Primary Stakeholder : Marketing Manager

Purpose

Evaluates promotional effectiveness, customer acquisition, campaign
performance, customer purchasing behaviour, seasonal demand, and
marketing-driven revenue opportunities to optimize growth strategies.

******************************************************************************/

/*==============================================================================
Business Question

Which promotions generate the highest total revenue?

==============================================================================

Business Objective
------------------
Identify the most successful promotional campaigns based on total revenue
generated from delivered orders.

Business Value
--------------
Helps the marketing team evaluate campaign performance and allocate future
marketing investments toward high-performing promotions.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS promotion_rank,
    p.promotion_name,
    ROUND(SUM(o.final_amount),2) AS total_revenue
FROM orders o
JOIN promotions p
    ON o.promotion_id = p.promotion_id
WHERE o.order_status='Delivered'
GROUP BY
    p.promotion_name
ORDER BY
    promotion_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Family Pack generated the highest promotional revenue at ₹1.05 million,
  making it the platform's best-performing marketing campaign.

• The top six promotional campaigns generated very similar revenue,
  indicating balanced customer engagement across multiple offers.

• No single promotion overwhelmingly dominates revenue generation,
  demonstrating a diversified promotional strategy.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue investing in high-performing campaigns such as Family Pack
  while periodically refreshing campaign messaging.

• Maintain a balanced promotional portfolio instead of relying on a
  single flagship campaign.

• Monitor campaign performance regularly to identify opportunities for
  optimization and sustained revenue growth.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which promotions are used most frequently by customers?

==============================================================================

Business Objective
------------------
Measure customer adoption across promotional campaigns based on completed
orders.

Business Value
--------------
Helps identify the most popular campaigns and supports future promotion
planning based on customer engagement.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS promotion_rank,
    p.promotion_name,
    COUNT(*) AS total_orders
FROM orders o
JOIN promotions p
    ON o.promotion_id = p.promotion_id
WHERE o.order_status='Delivered'
GROUP BY
    p.promotion_name
ORDER BY
    promotion_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Family Pack was the most frequently redeemed promotion with 1,244
  completed promotional orders.

• Customer adoption remains highly consistent across all promotional
  campaigns, indicating widespread acceptance of marketing offers.

• The balanced redemption pattern reduces dependence on any single
  promotional campaign for customer engagement.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue offering a diverse mix of promotional campaigns to appeal
  to different customer segments.

• Periodically introduce new campaign variations to sustain customer
  engagement and prevent promotion fatigue.

• Monitor redemption trends to identify campaigns requiring refinement
  or replacement.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments respond most actively to promotional campaigns?

==============================================================================

Business Objective
------------------
Analyze promotional order distribution across customer segments.

Business Value
--------------
Helps marketing teams identify high-response customer segments and improve
campaign targeting.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS segment_rank,
    c.customer_segment,
    COUNT(*) AS promotional_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals accounted for the highest promotional response
  with 18,688 completed promotional orders.

• Family and Student segments also demonstrated strong campaign
  participation, while Food Enthusiasts represented the smallest
  promotional audience.

• Promotional campaigns appear to resonate particularly well with
  customers placing frequent everyday orders.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Prioritize marketing campaigns targeting Working Professionals,
  as they represent the platform's largest promotional audience.

• Design personalized campaigns for Student and Family segments to
  further improve customer engagement.

• Develop niche promotional strategies to increase participation
  among Food Enthusiasts.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which promotions generate the highest revenue relative to the discounts
offered?

==============================================================================

Business Objective
------------------
Evaluate the efficiency of promotional campaigns by comparing revenue
generated against discounts provided.

Business Value
--------------
Supports marketing budget optimization by identifying promotions that
deliver strong revenue with controlled discount costs.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (
        ORDER BY SUM(o.final_amount)/SUM(o.discount_amount) DESC
    ) AS efficiency_rank,
    p.promotion_name,
    ROUND(SUM(o.discount_amount),2) AS total_discount_given,
    ROUND(SUM(o.final_amount),2) AS total_revenue,
    ROUND(
        SUM(o.final_amount)/SUM(o.discount_amount),
        2
    ) AS revenue_per_discount_rupee
FROM orders o
JOIN promotions p
    ON o.promotion_id=p.promotion_id
WHERE
    o.order_status='Delivered'
    AND o.discount_amount>0
GROUP BY
    p.promotion_name
ORDER BY
    efficiency_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• All promotional campaigns generated approximately ₹10 of revenue
  for every ₹1 of discount provided.

• Revenue efficiency remains remarkably consistent across campaigns,
  indicating balanced promotional performance.

• No campaign demonstrates a clear financial advantage over others
  based solely on discount efficiency.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring promotion efficiency alongside customer
  acquisition and repeat purchase metrics.

• Evaluate future campaigns using additional KPIs such as incremental
  revenue and customer retention rather than discount efficiency alone.

• Periodically review promotional structures to maintain sustainable
  marketing investments.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities generate the highest promotional revenue?

==============================================================================

Business Objective
------------------
Measure promotional revenue contribution across operating cities.

Business Value
--------------
Helps marketing teams identify geographic markets that respond most
effectively to promotional campaigns.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS city_rank,
    ci.city_name,
    ROUND(SUM(o.final_amount),2) AS promotional_revenue
FROM orders o
JOIN customers cu
    ON o.customer_id=cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id=dz.zone_id
JOIN cities ci
    ON dz.city_id=ci.city_id
WHERE o.order_status='Delivered'
GROUP BY
    ci.city_name
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai generated the highest promotional revenue at ₹10.80 million,
  followed by Bengaluru and Hyderabad.

• The top three cities contribute a substantial share of promotional
  revenue, highlighting their importance to marketing performance.

• Ahmedabad generated the lowest promotional revenue, indicating
  comparatively lower campaign impact.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue allocating marketing resources toward high-performing
  metropolitan markets to maximize campaign returns.

• Investigate customer behaviour in lower-performing cities to identify
  opportunities for market expansion.

• Tailor regional promotional campaigns based on city-specific demand
  characteristics.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How do promotional orders vary across different seasons?

==============================================================================

Business Objective
------------------
Analyze seasonal demand patterns for promotional campaigns.

Business Value
--------------
Supports seasonal marketing planning and campaign scheduling throughout
the year.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS season_rank,
    cal.season,
    COUNT(*) AS promotional_orders
FROM orders o
JOIN calendar cal
    ON o.calendar_id=cal.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    cal.season
ORDER BY
    season_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Winter recorded the highest number of promotional orders with
  19,465 completed transactions.

• Monsoon generated moderate promotional demand, while Summer
  experienced the lowest promotional activity.

• Promotional performance demonstrates clear seasonal demand
  variations throughout the year.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Increase promotional activity during Winter to capitalize on peak
  customer demand.

• Introduce season-specific marketing campaigns to improve customer
  engagement during lower-demand periods.

• Incorporate seasonal demand forecasting into future campaign
  planning.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How do promotional orders perform during festival and non-festival periods?

==============================================================================

Business Objective
------------------
Compare customer demand during festival and regular business periods.

Business Value
--------------
Helps marketing teams evaluate whether promotional campaigns should be
intensified around festivals.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN cal.festival_flag=1 THEN 'Festival'
        ELSE 'Non-Festival'
    END AS period,
    COUNT(*) AS promotional_orders,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN calendar cal
    ON o.calendar_id=cal.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    period
ORDER BY
    average_order_value DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Non-Festival periods accounted for the vast majority of promotional
  orders due to substantially higher transaction volume.

• Average order value remained highly consistent between Festival
  (₹886.62) and Non-Festival (₹891.00) periods.

• Festival periods did not produce a significant increase in customer
  spending despite promotional campaigns.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Design exclusive festival campaigns that encourage higher customer
  spending rather than relying solely on standard promotions.

• Evaluate festival-specific offers using incremental revenue and
  customer acquisition metrics.

• Continue monitoring seasonal campaign effectiveness to optimize
  future promotional strategies.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments generate the highest promotional revenue?

==============================================================================

Business Objective
------------------
Evaluate the revenue contribution of each customer segment from
promotional orders.

Business Value
--------------
Helps marketing teams prioritize customer segments that generate the
greatest revenue through promotional campaigns.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS segment_rank,
    c.customer_segment,
    ROUND(SUM(o.final_amount),2) AS promotional_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals generated ₹16.74 million in promotional
  revenue, making them the platform's most valuable customer segment.

• Family and Student segments contributed comparable promotional
  revenue, together representing a substantial share of campaign
  performance.

• Promotional campaigns appear to resonate most strongly with
  customers who order frequently throughout the week.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue prioritizing Working Professionals for premium promotional
  campaigns and personalized offers.

• Design segment-specific campaigns for Family and Student customers
  to further improve campaign effectiveness.

• Develop niche campaigns for Food Enthusiasts to increase engagement
  and revenue contribution.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments generate the highest average promotional order value?

==============================================================================

Business Objective
------------------
Measure the average spending behavior of each customer segment during
promotional purchases.

Business Value
--------------
Helps marketing teams identify high-value customer segments for premium
campaigns and personalized offers.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY AVG(o.final_amount) DESC) AS segment_rank,
    c.customer_segment,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals recorded the highest promotional average
  order value at ₹895.51.

• Average promotional spending varies only moderately across customer
  segments, indicating consistent purchasing behaviour.

• Promotional campaigns successfully encourage spending across all
  customer groups rather than benefiting only one segment.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue offering personalized promotions to high-value customer
  segments.

• Monitor average order value alongside campaign redemption to
  maximize marketing ROI.

• Introduce premium promotional bundles targeting customers with
  higher spending potential.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which days of the week generate the highest promotional demand?

==============================================================================

Business Objective
------------------
Identify customer ordering behaviour throughout the week.

Business Value
--------------
Supports campaign scheduling and helps maximize customer engagement by
launching promotions on high-demand days.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS day_rank,
    cal.day_name,
    COUNT(*) AS promotional_orders
FROM orders o
JOIN calendar cal
    ON o.calendar_id = cal.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    cal.day_name
ORDER BY
    day_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Tuesday generated the highest promotional demand with 6,878
  completed promotional orders.

• Promotional demand remains relatively balanced throughout the week,
  with only modest variation between weekdays.

• Customer engagement is distributed consistently, reducing reliance
  on a single peak business day.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Schedule major promotional launches early in the week to leverage
  strong customer activity.

• Maintain campaign visibility throughout the week due to the
  relatively balanced ordering pattern.

• Continuously monitor weekday performance to optimize campaign timing.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities generate the highest average promotional order value?

==============================================================================

Business Objective
------------------
Evaluate customer spending patterns across cities during promotional
campaigns.

Business Value
--------------
Helps marketing teams identify cities where customers spend more per
transaction, enabling geographically optimized campaigns.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY AVG(o.final_amount) DESC) AS city_rank,
    ci.city_name,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id = dz.zone_id
JOIN cities ci
    ON dz.city_id = ci.city_id
WHERE o.order_status='Delivered'
GROUP BY
    ci.city_name
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Hyderabad achieved the highest promotional average order value at
  ₹968.22, followed by Mumbai and Pune.

• Customers in Hyderabad demonstrate significantly higher spending
  during promotional campaigns compared to other cities.

• Bengaluru recorded the lowest promotional average order value,
  indicating comparatively lower customer spending per transaction.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Prioritize premium promotional campaigns in Hyderabad, Mumbai and
  Pune where customer spending is strongest.

• Investigate customer purchasing behaviour in lower-performing cities
  to identify opportunities for growth.

• Tailor city-specific marketing strategies based on regional spending
  patterns.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which discount types generate the highest promotional revenue?

==============================================================================

Business Objective
------------------
Evaluate the performance of different discount strategies based on
revenue generated from completed promotional orders.

Business Value
--------------
Helps marketing teams determine whether Percentage, Flat, or Cashback
discounts produce the strongest business results.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS discount_type_rank,
    p.discount_type,
    ROUND(SUM(o.final_amount),2) AS promotional_revenue
FROM orders o
JOIN promotions p
    ON o.promotion_id = p.promotion_id
WHERE o.order_status = 'Delivered'
GROUP BY
    p.discount_type
ORDER BY
    discount_type_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Percentage-based promotions generated ₹6.78 million in promotional
  revenue, outperforming Flat discount campaigns by a significant margin.

• Percentage discounts appear to provide stronger customer engagement
  while maintaining higher overall sales performance.

• The revenue gap suggests that customers perceive percentage-based
  offers as more attractive than flat-value discounts.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue prioritizing percentage-based promotional campaigns during
  major marketing initiatives.

• Experiment with different percentage discount levels to maximize
  customer acquisition while protecting profit margins.

• Periodically compare promotion profitability alongside revenue to
  optimize future campaign strategies.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which discount values generate the highest promotional revenue?

==============================================================================

Business Objective
------------------
Compare campaign performance across different discount values.

Business Value
--------------
Supports pricing strategy by identifying the most effective discount
levels for maximizing revenue.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.final_amount) DESC) AS discount_rank,
    CONCAT(p.discount_value,'%') AS discount_value,
    ROUND(SUM(o.final_amount),2) AS promotional_revenue
FROM orders o
JOIN promotions p
    ON o.promotion_id = p.promotion_id
WHERE o.order_status='Delivered'
GROUP BY
    p.discount_value
ORDER BY
    discount_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• The 15% discount generated the highest promotional revenue at
  ₹1.89 million, outperforming all other discount levels.

• Moderate discount percentages consistently delivered strong
  promotional performance, indicating that larger discounts are not
  always necessary to drive customer purchases.

• Revenue performance varies across discount values, highlighting the
  importance of optimizing promotional pricing.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Use moderate discount levels as the baseline for future marketing
  campaigns to balance customer attraction and revenue generation.

• Evaluate campaign performance continuously before increasing
  promotional discounts.

• Optimize discount structures based on both customer response and
  overall profitability.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments receive the highest total promotional discounts?

==============================================================================

Business Objective
------------------
Measure promotional investment across customer segments.

Business Value
--------------
Helps marketing teams understand where promotional budgets are being
allocated and evaluate customer targeting strategies.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.discount_amount) DESC) AS segment_rank,
    c.customer_segment,
    ROUND(SUM(o.discount_amount),2) AS total_discount_given
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals received the highest promotional investment,
  with total discounts exceeding ₹463.94 thousand.

• Family and Student segments received comparable promotional
  investments, demonstrating balanced campaign allocation.

• Promotional spending aligns closely with customer revenue
  contribution across major customer segments.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue allocating promotional budgets toward high-value customer
  segments that generate substantial revenue.

• Review campaign allocation periodically to ensure promotional
  investments produce proportional business returns.

• Develop targeted campaigns for lower-engagement customer segments
  to improve overall marketing effectiveness.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities receive the highest total promotional discounts?

==============================================================================

Business Objective
------------------
Analyze promotional investment across operating cities.

Business Value
--------------
Supports regional campaign planning and marketing budget allocation.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY SUM(o.discount_amount) DESC) AS city_rank,
    ci.city_name,
    ROUND(SUM(o.discount_amount),2) AS total_discount_given
FROM orders o
JOIN customers cu
    ON o.customer_id = cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id = dz.zone_id
JOIN cities ci
    ON dz.city_id = ci.city_id
WHERE o.order_status='Delivered'
GROUP BY
    ci.city_name
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai received the highest promotional investment with discounts
  exceeding ₹303.10 thousand.

• Bengaluru and Hyderabad also received significant promotional
  allocations, reflecting their strategic market importance.

• Promotional investment generally aligns with overall city revenue,
  supporting a balanced regional marketing strategy.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue prioritizing promotional investment in high-performing
  metropolitan markets.

• Evaluate campaign effectiveness in lower-investment cities before
  increasing promotional budgets.

• Incorporate regional demand trends into future promotional planning.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which promotions generate the highest average customer discount?

==============================================================================

Business Objective
------------------
Compare promotional campaigns based on the average discount offered
per completed order.

Business Value
--------------
Helps evaluate whether campaigns are providing balanced customer value
while maintaining marketing efficiency.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER (ORDER BY AVG(o.discount_amount) DESC) AS promotion_rank,
    p.promotion_name,
    ROUND(AVG(o.discount_amount),2) AS average_discount
FROM orders o
JOIN promotions p
    ON o.promotion_id = p.promotion_id
WHERE o.order_status='Delivered'
GROUP BY
    p.promotion_name
ORDER BY
    promotion_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Lunch Combo provided the highest average customer discount at
  ₹85.04 per promotional order.

• The average discount offered across campaigns remains relatively
  consistent, indicating standardized promotional pricing.

• No promotional campaign appears to rely on excessive discounting to
  generate customer engagement.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining balanced promotional discount structures to
  preserve customer value while protecting revenue.

• Regularly review average discount levels alongside campaign
  performance to maximize marketing efficiency.

• Reserve higher-value discounts for strategic campaigns and seasonal
  marketing events.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What are the overall marketing campaign KPIs for Project Velox?

==============================================================================

Business Objective
------------------
Provide an executive summary of promotional campaign performance.

Business Value
--------------
Offers marketing leadership a consolidated view of campaign scale,
customer savings, and promotional revenue generation.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    ROUND(SUM(final_amount),2) AS promotional_revenue,
    ROUND(SUM(discount_amount),2) AS total_discount_given,
    ROUND(AVG(discount_amount),2) AS average_discount_per_order,
    COUNT(*) AS promotional_orders,
    ROUND(AVG(final_amount),2) AS average_order_value
FROM orders
WHERE order_status='Delivered';

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Marketing campaigns generated ₹41.89 million in promotional
  revenue from 47,017 completed promotional orders.

• Customers collectively received ₹1.17 million in promotional
  discounts while maintaining a healthy average order value of
  ₹890.91.

• The average promotional discount of ₹24.78 per order indicates
  efficient campaign execution without significantly reducing
  customer spending.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring campaign KPIs regularly to evaluate marketing
  effectiveness and promotional ROI.

• Balance customer incentives with sustainable discount strategies to
  preserve long-term profitability.

• Expand future marketing analysis by incorporating customer retention,
  repeat purchase behaviour, and campaign conversion metrics.

----------------------------------------------------------------------------*/

/******************************************************************************
SECTION 5 : FINANCE ANALYTICS

Primary Stakeholder : Finance Manager / Chief Financial Officer (CFO)

Purpose

Provides comprehensive financial visibility into Project Velox by
analyzing revenue generation, platform fees, delivery costs,
discount expenditure, profitability, and financial efficiency
across the business.

******************************************************************************/

/*==============================================================================
Business Question

How is customer payment distributed between subtotal, GST, discounts,
platform fees, delivery fees, and final revenue?

==============================================================================

Business Objective
------------------
Break down the financial composition of customer payments.

Business Value
--------------
Helps finance leadership understand where revenue originates and
how discounts and fees impact the final customer payment.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    ROUND(SUM(subtotal),2) AS total_subtotal,
    ROUND(SUM(gst_amount),2) AS total_gst,
    ROUND(SUM(discount_amount),2) AS total_discount,
    ROUND(SUM(platform_fee),2) AS total_platform_fee,
    ROUND(SUM(delivery_fee),2) AS total_delivery_fee,
    ROUND(SUM(final_amount),2) AS total_revenue
FROM orders
WHERE order_status='Delivered';

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Project Velox generated ₹41.89 Million in completed order revenue,
  comprising ₹39.25 Million in food subtotal, ₹1.96 Million in GST,
  ₹1.37 Million in delivery fees, and ₹0.47 Million in platform fees.

• Total promotional discounts amounted to ₹1.17 Million, representing
  strategic marketing investment while maintaining strong overall revenue.

• The financial composition indicates that food sales remain the primary
  revenue driver, with delivery and platform fees providing additional
  monetization streams.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining a balanced revenue structure by optimizing
  both core food sales and ancillary revenue streams.

• Periodically evaluate discount expenditure to ensure promotional
  investments continue generating profitable customer acquisition.

• Monitor the contribution of delivery and platform fees as order
  volumes scale across new markets.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities generate the highest platform fee revenue?

==============================================================================

Business Objective
------------------
Evaluate platform fee contribution across operating cities.

Business Value
--------------
Helps finance teams identify markets generating the strongest
platform revenue.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(ORDER BY SUM(o.platform_fee) DESC) AS city_rank,
    ci.city_name,
    ROUND(SUM(o.platform_fee),2) AS platform_fee_revenue
FROM orders o
JOIN customers cu
    ON o.customer_id=cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id=dz.zone_id
JOIN cities ci
    ON dz.city_id=ci.city_id
WHERE o.order_status='Delivered'
GROUP BY
    ci.city_name
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai generated the highest platform fee revenue at ₹116,020,
  followed by Bengaluru and Delhi.

• Platform fee revenue closely follows completed order volumes,
  demonstrating consistent fee collection across cities.

• Higher-volume metropolitan markets contribute the largest share
  of platform monetization.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue expanding order volumes in high-performing cities to
  maximize platform fee earnings.

• Evaluate opportunities to increase platform adoption in lower
  contributing cities through localized growth initiatives.

• Monitor platform fee performance alongside customer satisfaction
  to maintain sustainable revenue growth.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurant categories generate the highest platform fee revenue?

==============================================================================

Business Objective
------------------
Measure platform fee contribution by restaurant category.

Business Value
--------------
Helps evaluate which cuisine categories contribute the greatest
platform earnings.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(ORDER BY SUM(o.platform_fee) DESC) AS category_rank,
    rc.category_name,
    ROUND(SUM(o.platform_fee),2) AS platform_fee_revenue
FROM orders o
JOIN restaurants r
    ON o.restaurant_id=r.restaurant_id
JOIN restaurant_categories rc
    ON r.category_id=rc.category_id
WHERE o.order_status='Delivered'
GROUP BY
    rc.category_name
ORDER BY
    category_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• North Indian restaurants generated the highest platform fee revenue,
  followed closely by Chinese and Cafe & Bakery categories.

• The top cuisine categories contribute a significant proportion of
  recurring platform earnings.

• Beverage outlets generated comparatively lower platform fee revenue,
  reflecting smaller order values and fewer completed transactions.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Prioritize strategic partnerships with high-performing cuisine
  categories to strengthen platform revenue.

• Encourage lower-performing restaurant categories through
  promotional visibility and targeted campaigns.

• Continuously monitor category-level financial contribution when
  expanding restaurant partnerships.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments generate the highest platform fee revenue?

==============================================================================

Business Objective
------------------
Measure platform earnings contributed by different customer segments.

Business Value
--------------
Supports customer profitability analysis and long-term pricing
strategy.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(ORDER BY SUM(o.platform_fee) DESC) AS segment_rank,
    c.customer_segment,
    ROUND(SUM(o.platform_fee),2) AS platform_fee_revenue
FROM orders o
JOIN customers c
    ON o.customer_id=c.customer_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals generated the highest platform fee revenue,
  contributing ₹186,880.

• Family and Student customers contributed nearly similar platform
  fee revenue despite differences in overall order volume.

• Food Enthusiasts represent the smallest platform fee contribution,
  indicating a relatively smaller customer base.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue focusing acquisition strategies on Working Professionals,
  the platform's most valuable customer segment.

• Design personalized engagement campaigns for Family and Student
  customers to increase repeat ordering frequency.

• Explore premium offerings for Food Enthusiasts to improve their
  long-term financial contribution.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which seasons generate the highest delivery fee revenue?

==============================================================================

Business Objective
------------------
Analyze delivery fee collection across seasons.

Business Value
--------------
Supports seasonal financial planning and operational budgeting.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(ORDER BY SUM(o.delivery_fee) DESC) AS season_rank,
    cal.season,
    ROUND(SUM(o.delivery_fee),2) AS delivery_fee_revenue
FROM orders o
JOIN calendar cal
    ON o.calendar_id=cal.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    cal.season
ORDER BY
    season_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Winter generated the highest delivery fee revenue at ₹568,195,
  followed by Monsoon and Summer.

• Delivery fee revenue aligns closely with seasonal order demand,
  indicating stable pricing across the year.

• Seasonal fluctuations primarily reflect changes in order volume
  rather than changes in delivery pricing.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Prepare delivery capacity for high-demand Winter periods to
  maximize delivery fee revenue.

• Continue monitoring seasonal demand trends when forecasting
  logistics expenditure.

• Review seasonal delivery pricing only if operational costs
  change significantly.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How much discount expenditure is incurred across different customer
segments?

==============================================================================

Business Objective
------------------
Compare promotional spending across customer segments.

Business Value
--------------
Helps finance evaluate promotional cost allocation and marketing
investment.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(ORDER BY SUM(o.discount_amount) DESC) AS segment_rank,
    c.customer_segment,
    ROUND(SUM(o.discount_amount),2) AS total_discount_cost
FROM orders o
JOIN customers c
    ON o.customer_id=c.customer_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Working Professionals received the highest promotional investment,
  accounting for ₹463,938.60 in total discounts.

• Student and Family segments received comparable discount spending,
  reflecting balanced promotional distribution.

• Discount allocation closely mirrors customer order volumes,
  indicating targeted promotional investment.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue evaluating promotional spending alongside customer
  lifetime value to maximize marketing ROI.

• Periodically assess whether discount allocation generates
  proportional revenue growth across customer segments.

• Optimize promotional budgets based on long-term customer
  profitability rather than order volume alone.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What are the average financial components per completed order?

==============================================================================

Business Objective
------------------
Measure the average financial contribution of every completed order.

Business Value
--------------
Provides finance leadership with standardized financial KPIs for
business monitoring.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    ROUND(AVG(subtotal),2) AS average_subtotal,
    ROUND(AVG(gst_amount),2) AS average_gst,
    ROUND(AVG(discount_amount),2) AS average_discount,
    ROUND(AVG(platform_fee),2) AS average_platform_fee,
    ROUND(AVG(delivery_fee),2) AS average_delivery_fee,
    ROUND(AVG(final_amount),2) AS average_revenue
FROM orders
WHERE order_status='Delivered';

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• The average completed order generated ₹834.78 in food subtotal,
  ₹41.74 in GST, ₹29.17 in delivery fees, and ₹10.00 in platform fees.

• Customers received an average promotional discount of ₹24.78 per
  completed order while still generating an average final payment
  of ₹890.91.

• The financial KPIs demonstrate a healthy balance between customer
  incentives and overall revenue generation.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue monitoring average order financial metrics as key
  finance performance indicators.

• Optimize promotional spending to sustain revenue growth while
  maintaining attractive customer pricing.

• Benchmark these financial KPIs periodically to evaluate pricing
  strategy and operational efficiency.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities generate the highest average revenue per completed order?

==============================================================================

Business Objective
------------------
Evaluate average customer spending across cities.

Business Value
--------------
Helps finance teams identify premium markets with stronger revenue generation
per transaction.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(o.final_amount) DESC
    ) AS city_rank,
    c.city_name,
    ROUND(AVG(o.final_amount),2) AS average_order_value
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
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Hyderabad recorded the highest average order value at ₹968.22,
  followed by Mumbai and Pune.

• Bengaluru generated the lowest average order value despite being
  one of the platform's largest markets by order volume.

• Premium customer spending is concentrated in Hyderabad and Mumbai,
  indicating stronger per-order revenue generation.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Analyze the product mix and pricing strategies used in Hyderabad
  to replicate high-value purchasing behaviour in other cities.

• Develop premium menu offerings in Bengaluru to improve average
  customer spending without relying solely on order volume.

• Monitor city-level average order values alongside order growth
  to maximize long-term revenue.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which restaurant categories generate the highest average revenue per order?

==============================================================================

Business Objective
------------------
Compare category profitability at the transaction level.

Business Value
--------------
Supports pricing strategy and category-level financial planning.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(o.final_amount) DESC
    ) AS category_rank,
    rc.category_name,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN restaurant_categories rc
    ON r.category_id = rc.category_id
WHERE o.order_status='Delivered'
GROUP BY
    rc.category_name
ORDER BY
    category_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Beverage restaurants generated the highest average order value
  at ₹1,752.04, significantly outperforming every other category.

• Pizza and Healthy & Salads also achieved strong average order
  values, exceeding ₹970 per transaction.

• South Indian restaurants recorded the lowest average order value,
  indicating comparatively lower customer spending per visit.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Investigate the pricing strategy of Beverage outlets to identify
  successful upselling opportunities across other restaurant categories.

• Encourage bundled meal offerings within lower-value categories to
  improve average transaction size.

• Monitor category-level average order values when onboarding new
  restaurant partners.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does average discount vary across customer segments?

==============================================================================

Business Objective
------------------
Measure promotional investment by customer segment.

Business Value
--------------
Helps finance teams optimize promotional spending.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(o.discount_amount) DESC
    ) AS segment_rank,
    c.customer_segment,
    ROUND(AVG(o.discount_amount),2) AS average_discount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Students received the highest average promotional discount at ₹25.61
  per completed order.

• Working Professionals and Family customers received similar average
  discount values, indicating balanced promotional allocation.

• Food Enthusiasts received the lowest average discount, reflecting
  comparatively lower promotional investment.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue evaluating promotional effectiveness by customer segment
  to maximize return on discount spending.

• Review whether higher student discounts generate proportional
  increases in customer retention and repeat purchases.

• Optimize future promotional budgets using customer lifetime value
  rather than discount levels alone.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which seasons generate the highest average revenue per completed order?

==============================================================================

Business Objective
------------------
Measure seasonal spending behaviour.

Business Value
--------------
Supports seasonal pricing and revenue forecasting.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(o.final_amount) DESC
    ) AS season_rank,
    cal.season,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN calendar cal
    ON o.calendar_id = cal.calendar_id
WHERE o.order_status='Delivered'
GROUP BY
    cal.season
ORDER BY
    season_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Summer recorded the highest average order value at ₹891.88,
  narrowly exceeding Winter and Monsoon.

• Average customer spending remains highly consistent across all
  three seasons.

• Seasonal demand affects transaction volume more than individual
  customer spending behaviour.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue maintaining consistent pricing strategies throughout
  the year given the stable seasonal spending patterns.

• Focus seasonal campaigns on increasing order frequency rather
  than changing menu pricing.

• Use seasonal demand forecasts primarily for operational and
  inventory planning.

----------------------------------------------------------------------------*/    

/*==============================================================================
Business Question

Which promotional campaigns generated the highest average order value?

==============================================================================

Business Objective
------------------
Evaluate campaign quality instead of campaign volume.

Business Value
--------------
Helps identify campaigns attracting higher-value customers.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(o.final_amount) DESC
    ) AS campaign_rank,
    pr.promotion_name,
    ROUND(AVG(o.final_amount),2) AS average_order_value
FROM orders o
JOIN promotions pr
    ON o.promotion_id = pr.promotion_id
WHERE o.order_status='Delivered'
GROUP BY
    pr.promotion_name
ORDER BY
    campaign_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Lunch Combo generated the highest average order value at ₹846.90,
  followed closely by Welcome Offer and Family Pack.

• Wallet Cashback recorded the lowest average order value among
  promotional campaigns.

• Campaign performance varies by customer basket size rather than
  promotional popularity alone.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue prioritizing high-performing campaigns such as Lunch
  Combo and Welcome Offer during peak demand periods.

• Review Wallet Cashback campaign structure to improve customer
  basket value while maintaining campaign attractiveness.

• Evaluate future promotions using average order value alongside
  campaign adoption.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which cities receive the highest average promotional discount per completed order?

==============================================================================

Business Objective
------------------
Compare promotional investment across cities.

Business Value
--------------
Helps finance evaluate discount allocation across geographic markets.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(o.discount_amount) DESC
    ) AS city_rank,
    c.city_name,
    ROUND(AVG(o.discount_amount),2) AS average_discount
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
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Hyderabad received the highest average promotional discount at
  ₹26.73 per completed order.

• Mumbai and Pune also received above-average promotional investment,
  indicating stronger marketing expenditure in major cities.

• Ahmedabad received the lowest average discount, reflecting a more
  conservative promotional strategy.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Periodically evaluate whether higher city-level promotional
  investment produces proportional revenue growth.

• Benchmark promotional efficiency across cities to optimize
  future marketing budgets.

• Balance promotional spending with customer acquisition and
  profitability objectives across all markets.

----------------------------------------------------------------------------*/

/******************************************************************************
SECTION 6 : CUSTOMER EXPERIENCE ANALYTICS

Primary Stakeholder : Customer Experience Manager

Purpose

Evaluates customer satisfaction by analyzing ratings, delivery quality,
complaints, cancellations, service consistency, and overall customer
experience across the platform.

******************************************************************************/

/*==============================================================================
Business Question

How do customer ratings vary across different cities?

==============================================================================

Business Objective
------------------
Measure customer satisfaction across operating cities.

Business Value
--------------
Helps identify cities delivering the best customer experience and
highlights locations requiring service improvement.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(r.rating) DESC
    ) AS city_rank,
    c.city_name,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN customers cu
    ON r.customer_id = cu.customer_id
JOIN delivery_zones dz
    ON cu.zone_id = dz.zone_id
JOIN cities c
    ON dz.city_id = c.city_id
GROUP BY
    c.city_name
ORDER BY
    city_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Mumbai achieved the highest average customer rating of 4.03,
  closely followed by Ahmedabad and Hyderabad.

• All six cities maintain customer ratings around 4.0,
  demonstrating consistently positive customer experiences.

• The minimal variation across cities indicates standardized
  service quality throughout the delivery network.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Benchmark operational best practices from the highest-rated
  cities and replicate them across all markets.

• Continuously monitor city-level customer ratings to identify
  early signs of declining customer satisfaction.

• Combine rating analysis with customer feedback to uncover
  location-specific improvement opportunities.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does customer satisfaction vary under different weather conditions?

==============================================================================

Business Objective
------------------
Understand the relationship between weather and customer experience.

Business Value
--------------
Helps evaluate whether adverse weather affects perceived service quality.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(r.rating) DESC
    ) AS weather_rank,
    w.weather_condition,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN weather w
    ON o.weather_id = w.weather_id
GROUP BY
    w.weather_condition
ORDER BY
    weather_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Rainy weather recorded the highest average customer rating
  at 4.02.

• Heatwave conditions received the lowest average rating,
  although customer satisfaction remained close to 4.0.

• Customer experience remained remarkably stable despite
  varying weather conditions.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue supporting delivery operations during adverse
  weather to preserve customer satisfaction.

• Monitor weather-specific operational challenges that may
  influence customer experience.

• Strengthen rider support and delivery planning during
  extreme weather conditions.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which customer segments provide the highest ratings?

==============================================================================

Business Objective
------------------
Measure customer satisfaction across different customer segments.

Business Value
--------------
Helps understand how various customer groups perceive platform quality.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(r.rating) DESC
    ) AS segment_rank,
    c.customer_segment,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN customers c
    ON r.customer_id = c.customer_id
GROUP BY
    c.customer_segment
ORDER BY
    segment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Food Enthusiasts provided the highest average customer
  rating at 4.02.

• Working Professionals and Students closely followed with
  consistently high satisfaction levels.

• Customer ratings remain highly consistent across all
  customer segments.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue delivering personalized experiences across all
  customer segments.

• Collect detailed customer feedback from comparatively
  lower-rated segments to identify improvement areas.

• Maintain consistent service quality irrespective of
  customer demographics.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does delivery time influence customer ratings?

==============================================================================

Business Objective
------------------
Evaluate whether faster deliveries improve customer satisfaction.

Business Value
--------------
Supports operational improvements aimed at increasing customer ratings.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN o.delivery_minutes <= 30 THEN 'Within 30 Minutes'
        WHEN o.delivery_minutes <= 45 THEN '31–45 Minutes'
        ELSE 'Above 45 Minutes'
    END AS delivery_time_group,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
WHERE o.order_status='Delivered'
GROUP BY
    delivery_time_group
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Orders delivered within 31-45 minutes achieved the highest
  average customer rating at 4.02.

• Customer ratings remain nearly identical across all
  delivery-time categories.

• Overall satisfaction appears to depend on multiple service
  factors beyond delivery speed alone.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue focusing on complete customer experience rather
  than delivery speed alone.

• Monitor food quality, packaging, and communication alongside
  delivery performance.

• Investigate additional service factors influencing customer
  satisfaction beyond delivery time.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

What is the overall distribution of customer ratings?

==============================================================================

Business Objective
------------------
Analyze the spread of customer ratings across the platform.

Business Value
--------------
Provides an overall view of customer satisfaction and review quality.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    rating,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*)*100.0/
        (SELECT COUNT(*) FROM reviews),
        2
    ) AS percentage_of_reviews
FROM reviews
GROUP BY
    rating
ORDER BY
    rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Nearly 75% of all customer reviews consist of 4-star and
  5-star ratings, indicating strong overall satisfaction.

• Five-star ratings account for approximately 39.78% of all
  customer feedback.

• Only a small proportion of customers provided 1-star or
  2-star ratings, reflecting relatively few poor experiences.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Maintain existing operational standards that consistently
  generate high customer satisfaction.

• Analyze low-rated reviews to identify recurring service
  issues and improvement opportunities.

• Recognize high-performing restaurants and delivery partners
  contributing to exceptional customer experiences.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do promotional discounts improve customer satisfaction?

==============================================================================

Business Objective
------------------
Evaluate whether customers receiving higher promotional discounts
provide better ratings.

Business Value
--------------
Helps determine whether promotional spending positively influences
customer satisfaction and customer perception.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN o.discount_amount = 0 THEN 'No Discount'
        WHEN o.discount_amount <= 25 THEN 'Low Discount'
        WHEN o.discount_amount <= 40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY
    discount_category
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Orders receiving medium discounts achieved the highest average
  customer rating (4.03), followed closely by high-discount orders
  (4.02).

• Orders without discounts still maintained a strong customer rating
  of 4.00, indicating that service quality drives satisfaction beyond
  promotional offers.

• Low-discount orders recorded the lowest average rating (3.97),
  suggesting smaller discounts may not significantly influence the
  overall customer experience.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue offering meaningful promotional discounts during targeted
  campaigns rather than frequent low-value discounts.

• Focus on improving delivery and food quality alongside promotions,
  as customer satisfaction remains high even without discounts.

• Periodically evaluate whether promotional spending produces
  measurable improvements in customer satisfaction.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Which payment methods are associated with the highest customer satisfaction?

==============================================================================

Business Objective
------------------
Measure customer satisfaction across different payment methods.

Business Value
--------------
Helps identify whether payment experience influences customer ratings.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    DENSE_RANK() OVER(
        ORDER BY AVG(r.rating) DESC
    ) AS payment_rank,
    p.payment_method,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN payments p
    ON o.payment_id = p.payment_id
GROUP BY
    p.payment_method
ORDER BY
    payment_rank;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Credit Card and UPI transactions achieved the highest average
  customer rating (4.02).

• Debit Card, Cash and Wallet payments all maintained ratings close
  to 4.00, indicating consistently positive customer experiences
  across payment methods.

• The narrow rating variation demonstrates that payment method has
  minimal influence on overall customer satisfaction.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue supporting all major payment options to maximize customer
  convenience.

• Prioritize payment reliability and transaction success rates rather
  than promoting one payment method over another.

• Partner with digital payment providers for cashback campaigns
  without compromising checkout simplicity.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does order value influence customer satisfaction?

==============================================================================

Business Objective
------------------
Analyze customer ratings across different order value ranges.

Business Value
--------------
Determines whether higher-value orders receive better customer
experiences.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN o.final_amount < 500 THEN 'Below ₹500'
        WHEN o.final_amount < 1000 THEN '₹500–₹999'
        ELSE '₹1000 & Above'
    END AS order_value_range,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY
    order_value_range
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Customers placing orders below ₹500 provided the highest average
  rating (4.02), while orders exceeding ₹1000 received the lowest
  average rating (3.99).

• Customer satisfaction remains consistently high across all spending
  levels, with only a marginal variation of 0.03 rating points.

• Higher order values do not necessarily translate into better
  customer experiences, suggesting expectations increase with
  larger purchases.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Focus on maintaining premium service quality for high-value
  orders to match customer expectations.

• Monitor customer feedback on expensive orders to identify
  service gaps affecting satisfaction.

• Consider offering personalized post-order support or loyalty
  benefits for high-value customers to enhance their experience.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

Do repeat customers provide higher ratings than infrequent customers?

==============================================================================

Business Objective
------------------
Compare customer satisfaction based on purchase frequency.

Business Value
--------------
Helps understand whether customer loyalty translates into
better customer experience.

SQL Analysis
----------------------------------------------------------------------------*/

WITH customer_orders AS
(
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
)

SELECT
    CASE
        WHEN co.total_orders = 1 THEN 'One-Time Customer'
        WHEN co.total_orders <= 5 THEN 'Occasional Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN customer_orders co
    ON r.customer_id = co.customer_id
GROUP BY
    customer_type
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Repeat customers submitted over 28,000 reviews with an average
  rating of 4.01.

• Existing customers continue to report consistently positive
  experiences, indicating strong customer retention and satisfaction.

• Sustaining high ratings among repeat customers strengthens
  long-term customer loyalty and lifetime value.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue investing in loyalty programs that encourage repeat
  purchases.

• Regularly analyze repeat customer feedback to identify improvement
  opportunities before satisfaction declines.

• Reward highly engaged customers through exclusive offers and
  personalized experiences to strengthen retention.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does customer satisfaction vary across different times of the day?

==============================================================================

Business Objective
------------------
Evaluate customer ratings during Morning, Afternoon,
and Night deliveries.

Business Value
--------------
Helps identify time periods delivering the best customer
experience.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN HOUR(o.order_timestamp) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(o.order_timestamp) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Night'
    END AS time_of_day,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY
    time_of_day
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Morning orders achieved the highest customer satisfaction with an
  average rating of 4.03.

• Afternoon and Night orders received nearly identical ratings of
  4.00 despite accounting for the majority of customer reviews.

• Service quality remains consistently strong across different
  periods of the day with only minimal rating variation.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Maintain current operational standards during morning hours
  as a benchmark for service quality.

• Review staffing levels and delivery efficiency during afternoon
  and night peak periods to preserve customer satisfaction.

• Continue monitoring ratings by time of day to detect any
  emerging operational bottlenecks.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How do delivery fee ranges influence customer satisfaction?

==============================================================================

Business Objective
------------------
Analyze customer ratings across different delivery fee ranges.

Business Value
--------------
Determines whether higher delivery charges affect
customer perception.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN o.delivery_fee = 0 THEN 'Free Delivery'
        WHEN o.delivery_fee <= 30 THEN '₹1–₹30'
        WHEN o.delivery_fee <= 60 THEN '₹31–₹60'
        ELSE 'Above ₹60'
    END AS delivery_fee_range,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
GROUP BY
    delivery_fee_range
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Orders with free delivery achieved the highest average customer
  rating (4.03).

• Orders with delivery fees between ₹31–₹60 maintained a strong
  average rating of 4.01, while ₹1–₹30 delivery charges recorded
  a slightly lower rating (3.99).

• Delivery charges have only a marginal impact on customer
  satisfaction, indicating customers value overall service quality
  more than delivery pricing alone.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Continue offering free-delivery campaigns during targeted
  acquisition and retention initiatives.

• Ensure delivery charges remain transparent throughout the ordering
  journey to minimize customer dissatisfaction.

• Optimize delivery operations to improve service quality, as
  customer experience has a greater influence on ratings than
  delivery fees.

----------------------------------------------------------------------------*/

/*==============================================================================
Business Question

How does customer satisfaction differ between festival and
non-festival periods?

==============================================================================

Business Objective
------------------
Measure customer satisfaction during festival and
regular business periods.

Business Value
--------------
Helps evaluate whether increased operational demand during
festivals affects customer experience.

SQL Analysis
----------------------------------------------------------------------------*/

SELECT
    CASE
        WHEN c.festival_flag = 1 THEN 'Festival'
        ELSE 'Non-Festival'
    END AS festival_period,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN calendar c
    ON o.calendar_id = c.calendar_id
GROUP BY
    festival_period
ORDER BY
    average_rating DESC;

/*----------------------------------------------------------------------------
Business Insight
----------------------------------------------------------------------------*/

• Non-festival orders achieved a slightly higher average customer
  rating (4.01) compared to festival orders (3.98).

• Although festival orders represent a smaller portion of total
  reviews, customer satisfaction declines marginally during
  high-demand periods.

• Increased operational pressure during festivals may slightly
  impact the overall customer experience.

----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Recommendation
----------------------------------------------------------------------------*/

• Allocate additional delivery capacity and restaurant support
  during festival periods to maintain service quality.

• Closely monitor operational KPIs during seasonal demand spikes
  to minimize service disruptions.

• Conduct post-festival customer feedback analysis to identify
  recurring pain points and improve future festive operations.

----------------------------------------------------------------------------*/