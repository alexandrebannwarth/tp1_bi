{{ config(materialized='table', schema='gold') }}

{{ generate_profit_model('training', 'sales_india', var('eur_rate_inde')) }}