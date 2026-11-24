SELECT
    storeid,
    SUM(total_revenue) AS total_store_revenue
FROM {{ ref('store_performance') }}
GROUP BY storeid