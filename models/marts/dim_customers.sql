/*
  dim_customers.sql
*/

{{
  config(
    materialized = 'table'
  )
}}

with

customers as (
    select * from {{ ref('stg_tpch__customers') }}
),

final as (
    select
        -- Surrogate key
        {{ dbt_utils.generate_surrogate_key(['c.customer_id']) }} as customer_sk,

        -- Natural key
        c.customer_id,
        c.customer_name,
        c.customer_address,
        c.customer_phone,
        c.market_segment,
        c.account_balance,
        c.nation_id,
        coalesce(o.total_orders, 0)             as total_orders,
        coalesce(o.lifetime_order_value, 0)     as lifetime_order_value,
        o.first_order_date,
        o.most_recent_order_date,
        coalesce(o.open_order_count, 0)         as open_order_count,
        current_timestamp() as dbt_loaded_at

    from customers c
)

select * from final