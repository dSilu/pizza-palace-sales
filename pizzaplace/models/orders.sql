
WITH orders as (
    select * from {{ ref('stg_orders') }}
)