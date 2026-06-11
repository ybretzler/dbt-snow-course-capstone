-- This test fails if any customer_id is null

select *
from {{ ref('stg_tpch__customers') }}
where customer_id is null
