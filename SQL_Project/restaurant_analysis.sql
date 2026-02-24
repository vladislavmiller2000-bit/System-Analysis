-- =============================================================================
-- RESTAURANT SALES ANALYSIS — SQL Portfolio Project
-- Author: Vladislav Orekhov
-- Date: February 2026
-- Description: Analytical SQL queries on a restaurant sales dataset
--              demonstrating SQL proficiency for a System/Business Analyst role
-- =============================================================================

-- =============================================================================
-- PART 1: DATABASE SCHEMA (DDL)
-- =============================================================================

CREATE TABLE IF NOT EXISTS menu_items (
    item_id     INTEGER PRIMARY KEY,
    item_name   TEXT NOT NULL,
    category    TEXT NOT NULL,          -- 'Appetizer', 'Main Course', 'Dessert', 'Beverage', 'Side'
    price       REAL NOT NULL,          -- selling price
    cost        REAL NOT NULL           -- cost to prepare
);

CREATE TABLE IF NOT EXISTS orders (
    order_id        INTEGER PRIMARY KEY,
    order_date      TEXT NOT NULL,       -- 'YYYY-MM-DD'
    order_time      TEXT NOT NULL,       -- 'HH:MM'
    total_amount    REAL NOT NULL,
    payment_method  TEXT NOT NULL,       -- 'Cash', 'Card', 'Online'
    customer_type   TEXT NOT NULL        -- 'Dine-in', 'Takeaway', 'Delivery'
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id   INTEGER PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    item_id         INTEGER NOT NULL,
    quantity        INTEGER NOT NULL DEFAULT 1,
    item_price      REAL NOT NULL,       -- price at the time of order
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id)  REFERENCES menu_items(item_id)
);


-- =============================================================================
-- PART 2: SAMPLE DATA
-- =============================================================================

-- Menu items (20 items across 5 categories)
INSERT INTO menu_items (item_id, item_name, category, price, cost) VALUES
(1,  'Caesar Salad',        'Appetizer',    450,  150),
(2,  'Tomato Soup',         'Appetizer',    350,  100),
(3,  'Bruschetta',          'Appetizer',    380,  120),
(4,  'Spring Rolls',        'Appetizer',    320,  110),
(5,  'Grilled Salmon',      'Main Course',  890,  350),
(6,  'Beef Steak',          'Main Course', 1200,  500),
(7,  'Chicken Pasta',       'Main Course',  650,  220),
(8,  'Mushroom Risotto',    'Main Course',  580,  190),
(9,  'Veggie Burger',       'Main Course',  520,  170),
(10, 'Pork Ribs',           'Main Course',  950,  380),
(11, 'French Fries',        'Side',         250,   70),
(12, 'Mashed Potatoes',     'Side',         280,   80),
(13, 'Grilled Vegetables',  'Side',         320,  100),
(14, 'Tiramisu',            'Dessert',      420,  140),
(15, 'Cheesecake',          'Dessert',      390,  130),
(16, 'Ice Cream',           'Dessert',      280,   80),
(17, 'Americano',           'Beverage',     180,   40),
(18, 'Cappuccino',          'Beverage',     250,   60),
(19, 'Fresh Juice',         'Beverage',     300,   90),
(20, 'Lemonade',            'Beverage',     220,   50);

-- Orders (50 sample orders over Jan-Mar 2026)
INSERT INTO orders (order_id, order_date, order_time, total_amount, payment_method, customer_type) VALUES
(1,  '2026-01-05', '12:30', 1720, 'Card',   'Dine-in'),
(2,  '2026-01-05', '13:15', 890,  'Cash',   'Dine-in'),
(3,  '2026-01-06', '19:45', 2450, 'Card',   'Dine-in'),
(4,  '2026-01-07', '11:00', 650,  'Online', 'Delivery'),
(5,  '2026-01-08', '20:30', 1870, 'Card',   'Dine-in'),
(6,  '2026-01-10', '12:00', 520,  'Cash',   'Takeaway'),
(7,  '2026-01-10', '18:30', 1580, 'Card',   'Dine-in'),
(8,  '2026-01-12', '14:00', 960,  'Online', 'Delivery'),
(9,  '2026-01-13', '19:00', 2100, 'Card',   'Dine-in'),
(10, '2026-01-15', '13:30', 750,  'Cash',   'Takeaway'),
(11, '2026-01-17', '12:15', 1340, 'Card',   'Dine-in'),
(12, '2026-01-18', '20:00', 1950, 'Card',   'Dine-in'),
(13, '2026-01-20', '11:30', 480,  'Online', 'Delivery'),
(14, '2026-01-22', '19:30', 2680, 'Card',   'Dine-in'),
(15, '2026-01-24', '13:00', 890,  'Cash',   'Dine-in'),
(16, '2026-01-26', '18:00', 1200, 'Card',   'Takeaway'),
(17, '2026-01-28', '21:00', 1560, 'Card',   'Dine-in'),
(18, '2026-02-01', '12:45', 1100, 'Cash',   'Dine-in'),
(19, '2026-02-02', '19:15', 2350, 'Card',   'Dine-in'),
(20, '2026-02-03', '11:45', 720,  'Online', 'Delivery'),
(21, '2026-02-05', '13:30', 1450, 'Card',   'Dine-in'),
(22, '2026-02-06', '20:15', 1890, 'Card',   'Dine-in'),
(23, '2026-02-08', '12:00', 580,  'Cash',   'Takeaway'),
(24, '2026-02-09', '18:45', 2100, 'Card',   'Dine-in'),
(25, '2026-02-11', '14:30', 950,  'Online', 'Delivery'),
(26, '2026-02-13', '19:00', 1680, 'Card',   'Dine-in'),
(27, '2026-02-14', '20:00', 3200, 'Card',   'Dine-in'),
(28, '2026-02-16', '12:30', 780,  'Cash',   'Dine-in'),
(29, '2026-02-18', '13:15', 1350, 'Card',   'Takeaway'),
(30, '2026-02-20', '19:30', 2450, 'Card',   'Dine-in'),
(31, '2026-02-22', '11:00', 620,  'Online', 'Delivery'),
(32, '2026-02-24', '18:30', 1780, 'Card',   'Dine-in'),
(33, '2026-02-26', '21:15', 1420, 'Card',   'Dine-in'),
(34, '2026-03-01', '12:00', 1150, 'Cash',   'Dine-in'),
(35, '2026-03-02', '19:45', 2580, 'Card',   'Dine-in'),
(36, '2026-03-03', '13:00', 890,  'Online', 'Delivery'),
(37, '2026-03-05', '20:30', 1960, 'Card',   'Dine-in'),
(38, '2026-03-06', '11:30', 540,  'Cash',   'Takeaway'),
(39, '2026-03-08', '18:00', 1720, 'Card',   'Dine-in'),
(40, '2026-03-09', '14:15', 1050, 'Online', 'Delivery'),
(41, '2026-03-10', '19:00', 2300, 'Card',   'Dine-in'),
(42, '2026-03-11', '12:45', 680,  'Cash',   'Takeaway'),
(43, '2026-03-12', '20:00', 1850, 'Card',   'Dine-in'),
(44, '2026-03-13', '13:30', 1100, 'Card',   'Dine-in'),
(45, '2026-03-14', '19:15', 2750, 'Card',   'Dine-in'),
(46, '2026-03-15', '11:00', 490,  'Online', 'Delivery'),
(47, '2026-03-16', '18:30', 1580, 'Card',   'Dine-in'),
(48, '2026-03-17', '21:00', 1350, 'Card',   'Dine-in'),
(49, '2026-03-18', '12:15', 920,  'Cash',   'Dine-in'),
(50, '2026-03-19', '19:30', 2100, 'Card',   'Dine-in');

-- Order items (linking orders to menu items)
INSERT INTO order_items (order_item_id, order_id, item_id, quantity, item_price) VALUES
-- Order 1: Caesar Salad + Beef Steak + Cappuccino
(1,  1,  1,  1, 450),
(2,  1,  6,  1, 1200),
(3,  1,  18, 1, 250),
-- Order 2: Grilled Salmon
(4,  2,  5,  1, 890),
-- Order 3: Bruschetta + Pork Ribs + Beef Steak + Lemonade
(5,  3,  3,  1, 380),
(6,  3,  10, 1, 950),
(7,  3,  6,  1, 1200),
(8,  3,  20, 1, 220),
-- Order 4: Chicken Pasta
(9,  4,  7,  1, 650),
-- Order 5: Tomato Soup + Grilled Salmon + Tiramisu + Americano
(10, 5,  2,  1, 350),
(11, 5,  5,  1, 890),
(12, 5,  14, 1, 420),
(13, 5,  17, 1, 180),
-- Order 6: Veggie Burger
(14, 6,  9,  1, 520),
-- Order 7: Caesar Salad + Chicken Pasta + Cheesecake + Fresh Juice
(15, 7,  1,  1, 450),
(16, 7,  7,  1, 650),
(17, 7,  15, 1, 390),
(18, 7,  19, 1, 300),
-- Order 8: Mushroom Risotto + Grilled Vegetables
(19, 8,  8,  1, 580),
(20, 8,  13, 1, 320),
-- Order 9: Spring Rolls + Beef Steak + French Fries + Tiramisu + Cappuccino
(21, 9,  4,  1, 320),
(22, 9,  6,  1, 1200),
(23, 9,  11, 1, 250),
(24, 9,  14, 1, 420),
(25, 9,  18, 1, 250),
-- Order 10: Chicken Pasta + Americano
(26, 10, 7,  1, 650),
(27, 10, 17, 1, 180),
-- Order 11: Caesar Salad + Grilled Salmon + Mashed Potatoes
(28, 11, 1,  1, 450),
(29, 11, 5,  1, 890),
(30, 11, 12, 1, 280),
-- Order 12: Bruschetta + Pork Ribs + Ice Cream + Fresh Juice
(31, 12, 3,  1, 380),
(32, 12, 10, 1, 950),
(33, 12, 16, 1, 280),
(34, 12, 19, 1, 300),
-- Order 13: Veggie Burger
(35, 13, 9,  1, 520),
-- Order 14: Tomato Soup + Beef Steak + Grilled Salmon + Tiramisu + Cappuccino + Lemonade
(36, 14, 2,  1, 350),
(37, 14, 6,  1, 1200),
(38, 14, 5,  1, 890),
(39, 14, 14, 1, 420),
(40, 14, 18, 1, 250),
(41, 14, 20, 1, 220),
-- Order 15: Grilled Salmon
(42, 15, 5,  1, 890),
-- Order 16: Beef Steak
(43, 16, 6,  1, 1200),
-- Order 17: Chicken Pasta + Mushroom Risotto + Cheesecake
(44, 17, 7,  1, 650),
(45, 17, 8,  1, 580),
(46, 17, 15, 1, 390),
-- Order 18: Caesar Salad + Chicken Pasta
(47, 18, 1,  1, 450),
(48, 18, 7,  1, 650),
-- Order 19: Spring Rolls + Beef Steak + Pork Ribs + Lemonade
(49, 19, 4,  1, 320),
(50, 19, 6,  1, 1200),
(51, 19, 10, 1, 950),
(52, 19, 20, 1, 220),
-- Order 20: Mushroom Risotto + Americano
(53, 20, 8,  1, 580),
(54, 20, 17, 1, 180),
-- Orders 21-50: representative mix
(55, 21, 1,  1, 450),  (56, 21, 5,  1, 890),  (57, 21, 14, 1, 420),
(58, 22, 3,  1, 380),  (59, 22, 6,  1, 1200), (60, 22, 11, 1, 250), (61, 22, 18, 1, 250),
(62, 23, 9,  1, 520),
(63, 24, 2,  1, 350),  (64, 24, 10, 1, 950),  (65, 24, 13, 1, 320), (66, 24, 15, 1, 390), (67, 24, 19, 1, 300),
(68, 25, 7,  1, 650),  (69, 25, 12, 1, 280),
(70, 26, 1,  1, 450),  (71, 26, 8,  1, 580),  (72, 26, 14, 1, 420), (73, 26, 18, 1, 250),
(74, 27, 4,  1, 320),  (75, 27, 6,  1, 1200), (76, 27, 5,  1, 890), (77, 27, 14, 1, 420), (78, 27, 15, 1, 390), (79, 27, 19, 1, 300),
(80, 28, 7,  1, 650),  (81, 28, 17, 1, 180),
(82, 29, 1,  1, 450),  (83, 29, 5,  1, 890),
(84, 30, 3,  1, 380),  (85, 30, 6,  1, 1200), (86, 30, 10, 1, 950),
(87, 31, 9,  1, 520),  (88, 31, 17, 1, 180),
(89, 32, 2,  1, 350),  (90, 32, 5,  1, 890),  (91, 32, 11, 1, 250), (92, 32, 16, 1, 280),
(93, 33, 7,  1, 650),  (94, 33, 8,  1, 580),  (95, 33, 20, 1, 220),
(96, 34, 1,  1, 450),  (97, 34, 7,  1, 650),
(98, 35, 4,  1, 320),  (99, 35, 6,  1, 1200), (100,35, 10, 1, 950), (101,35, 14, 1, 420),
(102,36, 5,  1, 890),
(103,37, 3,  1, 380),  (104,37, 6,  1, 1200), (105,37, 15, 1, 390),
(106,38, 9,  1, 520),
(107,39, 1,  1, 450),  (108,39, 5,  1, 890),  (109,39, 13, 1, 320),
(110,40, 7,  1, 650),  (111,40, 12, 1, 280),  (112,40, 17, 1, 180),
(113,41, 2,  1, 350),  (114,41, 6,  1, 1200), (115,41, 10, 1, 950),
(116,42, 8,  1, 580),  (117,42, 17, 1, 180),
(118,43, 1,  1, 450),  (119,43, 5,  1, 890),  (120,43, 14, 1, 420), (121,43, 19, 1, 300),
(122,44, 7,  1, 650),  (123,44, 11, 1, 250),  (124,44, 18, 1, 250),
(125,45, 4,  1, 320),  (126,45, 6,  1, 1200), (127,45, 5,  1, 890), (128,45, 14, 1, 420),
(129,46, 9,  1, 520),
(130,47, 3,  1, 380),  (131,47, 10, 1, 950),  (132,47, 16, 1, 280),
(133,48, 7,  1, 650),  (134,48, 8,  1, 580),  (135,48, 20, 1, 220),
(136,49, 1,  1, 450),  (137,49, 5,  1, 890),
(138,50, 6,  1, 1200), (139,50, 10, 1, 950);


-- =============================================================================
-- PART 3: ANALYTICAL QUERIES
-- =============================================================================


-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION A: REVENUE ANALYSIS
-- ─────────────────────────────────────────────────────────────────────────────

-- Query 1: Total revenue, number of orders, average order value
-- Business question: What is our overall financial performance?

SELECT
    COUNT(*)          AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    MIN(total_amount) AS min_order,
    MAX(total_amount) AS max_order
FROM orders;


-- Query 2: Monthly revenue breakdown with month-over-month growth
-- Business question: Is our revenue growing or declining?

SELECT
    substr(order_date, 1, 7)     AS month,
    COUNT(*)                     AS order_count,
    SUM(total_amount)            AS monthly_revenue,
    ROUND(AVG(total_amount), 2)  AS avg_order_value,
    LAG(SUM(total_amount)) OVER (ORDER BY substr(order_date, 1, 7)) AS prev_month_revenue,
    ROUND(
        (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY substr(order_date, 1, 7)))
        * 100.0 / LAG(SUM(total_amount)) OVER (ORDER BY substr(order_date, 1, 7)),
        1
    ) AS growth_pct
FROM orders
GROUP BY substr(order_date, 1, 7)
ORDER BY month;


-- Query 3: Revenue by day of week
-- Business question: Which days generate the most revenue?
-- Note: strftime('%w') returns 0=Sunday, 1=Monday, etc.

SELECT
    CASE CAST(strftime('%w', order_date) AS INTEGER)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,
    COUNT(*)                     AS order_count,
    SUM(total_amount)            AS total_revenue,
    ROUND(AVG(total_amount), 2)  AS avg_order_value
FROM orders
GROUP BY strftime('%w', order_date)
ORDER BY total_revenue DESC;


-- Query 4: Revenue by time period (Lunch / Afternoon / Dinner / Late Night)
-- Business question: When do we earn the most?

SELECT
    CASE
        WHEN CAST(substr(order_time, 1, 2) AS INTEGER) BETWEEN 11 AND 13 THEN '1. Lunch (11-14)'
        WHEN CAST(substr(order_time, 1, 2) AS INTEGER) BETWEEN 14 AND 17 THEN '2. Afternoon (14-18)'
        WHEN CAST(substr(order_time, 1, 2) AS INTEGER) BETWEEN 18 AND 20 THEN '3. Dinner (18-21)'
        ELSE '4. Late Night (21+)'
    END AS time_period,
    COUNT(*)                     AS order_count,
    SUM(total_amount)            AS total_revenue,
    ROUND(AVG(total_amount), 2)  AS avg_order_value
FROM orders
GROUP BY time_period
ORDER BY time_period;


-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION B: MENU PERFORMANCE
-- ─────────────────────────────────────────────────────────────────────────────

-- Query 5: Top 10 best-selling items by quantity
-- Business question: What do our customers order most often?

SELECT
    m.item_name,
    m.category,
    SUM(oi.quantity)              AS total_qty_sold,
    SUM(oi.quantity * oi.item_price) AS total_revenue
FROM order_items oi
JOIN menu_items m ON oi.item_id = m.item_id
GROUP BY m.item_id, m.item_name, m.category
ORDER BY total_qty_sold DESC
LIMIT 10;


-- Query 6: Top 10 items by revenue
-- Business question: Which items contribute most to our revenue?

SELECT
    m.item_name,
    m.category,
    m.price,
    SUM(oi.quantity)                  AS total_qty_sold,
    SUM(oi.quantity * oi.item_price)  AS total_revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.item_price) DESC) AS revenue_rank
FROM order_items oi
JOIN menu_items m ON oi.item_id = m.item_id
GROUP BY m.item_id, m.item_name, m.category, m.price
ORDER BY total_revenue DESC
LIMIT 10;


-- Query 7: Profit margin analysis per item
-- Business question: Which items are most profitable?

SELECT
    m.item_name,
    m.category,
    m.price,
    m.cost,
    m.price - m.cost                         AS profit_per_unit,
    ROUND((m.price - m.cost) * 100.0 / m.price, 1) AS margin_pct,
    SUM(oi.quantity)                          AS total_sold,
    SUM(oi.quantity * (m.price - m.cost))     AS total_profit
FROM menu_items m
LEFT JOIN order_items oi ON m.item_id = oi.item_id
GROUP BY m.item_id, m.item_name, m.category, m.price, m.cost
ORDER BY total_profit DESC;


-- Query 8: Items never ordered (dead menu items)
-- Business question: Do we have menu items that nobody orders?

SELECT
    m.item_name,
    m.category,
    m.price
FROM menu_items m
LEFT JOIN order_items oi ON m.item_id = oi.item_id
WHERE oi.order_item_id IS NULL;


-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION C: CATEGORY ANALYSIS
-- ─────────────────────────────────────────────────────────────────────────────

-- Query 9: Revenue and volume by category
-- Business question: Which food categories drive business?

SELECT
    m.category,
    COUNT(DISTINCT oi.order_id)       AS orders_containing_category,
    SUM(oi.quantity)                  AS total_items_sold,
    SUM(oi.quantity * oi.item_price)  AS total_revenue,
    ROUND(AVG(oi.item_price), 2)     AS avg_item_price,
    ROUND(
        SUM(oi.quantity * oi.item_price) * 100.0 /
        (SELECT SUM(quantity * item_price) FROM order_items),
        1
    ) AS revenue_share_pct
FROM order_items oi
JOIN menu_items m ON oi.item_id = m.item_id
GROUP BY m.category
ORDER BY total_revenue DESC;


-- Query 10: Best-selling item per category using window function
-- Business question: What is the star item in each category?

WITH ranked_items AS (
    SELECT
        m.category,
        m.item_name,
        SUM(oi.quantity) AS total_sold,
        ROW_NUMBER() OVER (PARTITION BY m.category ORDER BY SUM(oi.quantity) DESC) AS rn
    FROM order_items oi
    JOIN menu_items m ON oi.item_id = m.item_id
    GROUP BY m.category, m.item_name
)
SELECT category, item_name, total_sold
FROM ranked_items
WHERE rn = 1
ORDER BY total_sold DESC;


-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION D: ORDER PATTERNS
-- ─────────────────────────────────────────────────────────────────────────────

-- Query 11: Average items per order
-- Business question: How large are typical orders?

SELECT
    ROUND(AVG(items_per_order), 2) AS avg_items_per_order,
    MIN(items_per_order)           AS min_items,
    MAX(items_per_order)           AS max_items
FROM (
    SELECT order_id, SUM(quantity) AS items_per_order
    FROM order_items
    GROUP BY order_id
);


-- Query 12: Order size distribution
-- Business question: What percentage of orders are small vs. large?

SELECT
    CASE
        WHEN items_per_order = 1      THEN '1 item'
        WHEN items_per_order = 2      THEN '2 items'
        WHEN items_per_order = 3      THEN '3 items'
        WHEN items_per_order BETWEEN 4 AND 5 THEN '4-5 items'
        ELSE '6+ items'
    END AS order_size,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT order_id) FROM order_items), 1) AS pct
FROM (
    SELECT order_id, SUM(quantity) AS items_per_order
    FROM order_items
    GROUP BY order_id
)
GROUP BY order_size
ORDER BY order_size;


-- Query 13: Payment method breakdown
-- Business question: How do customers prefer to pay?

SELECT
    payment_method,
    COUNT(*)                     AS order_count,
    SUM(total_amount)            AS total_revenue,
    ROUND(AVG(total_amount), 2)  AS avg_order_value,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct_of_orders
FROM orders
GROUP BY payment_method
ORDER BY order_count DESC;


-- Query 14: Customer type analysis (Dine-in vs Takeaway vs Delivery)
-- Business question: Which service channel generates the most revenue?

SELECT
    customer_type,
    COUNT(*)                     AS order_count,
    SUM(total_amount)            AS total_revenue,
    ROUND(AVG(total_amount), 2)  AS avg_order_value,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct_of_orders
FROM orders
GROUP BY customer_type
ORDER BY total_revenue DESC;


-- ─────────────────────────────────────────────────────────────────────────────
-- SECTION E: ADVANCED ANALYTICS (CTEs, Window Functions, Subqueries)
-- ─────────────────────────────────────────────────────────────────────────────

-- Query 15: Running total of revenue (cumulative revenue over time)
-- Business question: How does our revenue accumulate over the quarter?

SELECT
    order_date,
    total_amount,
    SUM(total_amount) OVER (ORDER BY order_date, order_id) AS running_total
FROM orders
ORDER BY order_date, order_id;


-- Query 16: Top 3 revenue days using CTE
-- Business question: What were our best days?

WITH daily_revenue AS (
    SELECT
        order_date,
        COUNT(*)          AS num_orders,
        SUM(total_amount) AS day_revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    num_orders,
    day_revenue,
    RANK() OVER (ORDER BY day_revenue DESC) AS rank
FROM daily_revenue
ORDER BY day_revenue DESC
LIMIT 3;


-- Query 17: Frequently ordered together (item pairs)
-- Business question: What items are commonly ordered together?
-- This is useful for "combo" recommendations.

SELECT
    m1.item_name AS item_1,
    m2.item_name AS item_2,
    COUNT(*)     AS times_together
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.item_id < oi2.item_id
JOIN menu_items m1 ON oi1.item_id = m1.item_id
JOIN menu_items m2 ON oi2.item_id = m2.item_id
GROUP BY m1.item_name, m2.item_name
HAVING COUNT(*) >= 3
ORDER BY times_together DESC;


-- Query 18: Orders above average value
-- Business question: What percentage of orders are above average?

SELECT
    COUNT(*) AS orders_above_avg,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct_above_avg
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);


-- Query 19: Monthly category revenue pivot
-- Business question: How does each category perform month by month?

SELECT
    m.category,
    SUM(CASE WHEN substr(o.order_date, 1, 7) = '2026-01' THEN oi.quantity * oi.item_price ELSE 0 END) AS jan_revenue,
    SUM(CASE WHEN substr(o.order_date, 1, 7) = '2026-02' THEN oi.quantity * oi.item_price ELSE 0 END) AS feb_revenue,
    SUM(CASE WHEN substr(o.order_date, 1, 7) = '2026-03' THEN oi.quantity * oi.item_price ELSE 0 END) AS mar_revenue,
    SUM(oi.quantity * oi.item_price) AS total_revenue
FROM order_items oi
JOIN menu_items m ON oi.item_id = m.item_id
JOIN orders o     ON oi.order_id = o.order_id
GROUP BY m.category
ORDER BY total_revenue DESC;


-- Query 20: Customer type spending pattern with ranking
-- Business question: Which customer types spend the most per visit,
--                    and how does each type rank in terms of total contribution?

WITH customer_stats AS (
    SELECT
        customer_type,
        payment_method,
        COUNT(*)                     AS order_count,
        SUM(total_amount)            AS total_spent,
        ROUND(AVG(total_amount), 2)  AS avg_spent
    FROM orders
    GROUP BY customer_type, payment_method
)
SELECT
    customer_type,
    payment_method,
    order_count,
    total_spent,
    avg_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM customer_stats
ORDER BY spending_rank;


-- =============================================================================
-- END OF ANALYSIS
-- =============================================================================
-- Summary of insights (to be filled after running queries):
--
-- 1. Revenue trend: [growing/stable/declining] month over month
-- 2. Peak time: [lunch/dinner] generates the most revenue
-- 3. Top item: [item name] by revenue, [item name] by quantity
-- 4. Most profitable category: [category] with [X]% margin
-- 5. Dominant payment: [Card/Cash/Online] accounts for [X]% of orders
-- 6. Avg order size: [X] items, avg value: [X] RUB
-- =============================================================================
