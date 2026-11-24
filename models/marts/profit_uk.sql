{{ config(materialized='table', schema='gold') }}

{{ generate_profit_model('training', 'sales_uk', var('eur_rate_uk')) }}