{{ config(
    materialized='table',
    schema='gold'
)}}

{{ dbt_utils.deduplicate(
    relation=ref('stg_orders_items'),
    partition_by='orderitemid',
    order_by='orderitemid desc'
)}}