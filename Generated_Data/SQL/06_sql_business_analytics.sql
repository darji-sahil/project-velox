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

----------------------------------------------------------------------------*/