/*
  stg_tpch__lineitems.sql
*/

with

source as (
    select * from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM
),

renamed as (
    select
        L_ORDERKEY          as order_id,
        L_LINENUMBER        as line_number,
        L_PARTKEY           as part_id,
        L_SUPPKEY           as supplier_id,
        L_QUANTITY          as quantity,
        L_EXTENDEDPRICE     as extended_price,
        L_DISCOUNT          as discount_fraction,
        L_TAX               as tax_fraction,
        round(L_EXTENDEDPRICE * (1 - L_DISCOUNT), 2)          as net_price,
        L_RETURNFLAG        as return_flag,
        L_LINESTATUS        as line_status,
        L_SHIPDATE::date    as ship_date,
        L_COMMITDATE::date  as commit_date,
        L_RECEIPTDATE::date as receipt_date,
        L_SHIPINSTRUCT      as ship_instructions,
        L_SHIPMODE          as ship_mode,
        L_COMMENT           as line_comment

    from source
)

select * from renamed