{{ config(
    materialized='table',
    schema='gold'
) }}

SELECT
    c.customerid,
    c.fullname,
    COALESCE(SUM(fo.nb_orders), 0) AS total_orders,
    COALESCE(SUM(fo.total_amount), 0) AS total_revenue
FROM {{ ref('stg_customers') }} c
LEFT JOIN {{ ref('fct_orders') }} fo
    ON c.customerid = fo.customerid
GROUP BY
    c.customerid,
    c.fullname