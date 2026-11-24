{{ config(materialized='table', schema='gold') }}

{{ generate_profit_model('training', 'sales_us', var('eur_rate_us')) }}