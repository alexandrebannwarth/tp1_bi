{{ config(
    materialized='table',
    schema='gold'
) }}

SELECT
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    o.StatusDescription,
    COUNT(DISTINCT o.orderid) AS nb_orders,
    SUM(oi.TotalPrice) AS total_amount
FROM {{ ref('stg_orders') }} o
INNER JOIN {{ ref('stg_orders_items') }} oi
    ON o.orderid = oi.orderid
GROUP BY
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    o.StatusDescription