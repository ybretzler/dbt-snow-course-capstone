/*
  stg_tpch__nations.sql
  ──────────────────────
  Staging model for the TPC-H NATION source table.
  Applies:
    • Consistent snake_case column naming
    • Explicit data-type casts
    • No business logic — reference data only
*/

with

source as (
    select * from {{ source('tpch', 'nation') }}
),

renamed as (
    select
        -- Primary key
        N_NATIONKEY              as nation_id,
        -- Attributes
        N_NAME                   as nation_name,
        -- Foreign keys
        N_REGIONKEY              as region_id,
        -- Descriptive
        N_COMMENT                as nation_comment
    from source
)

select * from renamed
