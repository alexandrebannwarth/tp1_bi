{{ config(
    materialized='table',
    schema='gold'
) }}

WITH orders_count AS (
    SELECT
        storeid,
        COUNT(DISTINCT orderid) AS nb_orders
    FROM {{ ref('stg_orders') }}
    GROUP BY storeid
),

actual_revenue AS (
    SELECT
        storeid,
        SUM(total_amount) AS current_revenue
    FROM {{ ref('fct_orders') }}
    GROUP BY storeid
),

targets AS (
    SELECT
        storeid,
        SUM(salestarget) AS target_revenue
    FROM {{ ref('salestarget') }}
    GROUP BY storeid
)

SELECT
    t.storeid,
    COALESCE(o.nb_orders, 0) AS nb_orders,
    COALESCE(r.current_revenue, 0) AS current_revenue,
    COALESCE(t.target_revenue, 0) AS target_revenue,
    COALESCE(r.current_revenue, 0) - COALESCE(t.target_revenue, 0) AS variance
FROM targets t
LEFT JOIN orders_count o
    ON t.storeid = o.storeid
LEFT JOIN actual_revenue r
    ON t.storeid = r.storeid