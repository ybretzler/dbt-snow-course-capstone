/*
  int_orders_enriched.sql
*/

with

orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

customers as (
    select * from {{ ref('stg_tpch__customers') }}
),

nations as (
    select * from {{ ref('nation_codes') }}
),

enriched as (
    select
        o.order_id,
        o.customer_id,
        o.order_status_code,
        o.order_status,
        o.order_total_price,
        o.order_date,
        o.order_priority,
        o.clerk_id,
        o.ship_priority,
        c.customer_name,
        c.market_segment    as customer_market_segment,
        c.account_balance   as customer_account_balance,
        n.nation_id,
        n.nation_name,
        n.region_name,
        year(o.order_date)          as order_year,
        quarter(o.order_date)       as order_quarter,

    from orders       o
    left join customers c on o.customer_id  = c.customer_id
    left join nations   n on c.nation_id    = n.nation_id
)

select * from enriched