{{
    config(
        materialized='table'
    )
}}

with pizza_src as (
    select * from {{ ref("src_pizzas") }}
),
pizza_type as (
    select * from {{ ref('pizza_types') }}
),
pizza_details as (
    SELECT 
        PS.PIZZA_ORDER_ID,
        PS.PIZZA_TYPE PIZZA_ID,
        PT.NAME AS PIZZA_NAME,
        PT.CATEGORY AS PIZZA_CATEGORY,
        PS.PIZZA_SIZE,
        PT.INGREDIENTS AS USED_INGREDIENTS
    FROM pizza_type PT
    RIGHT JOIN pizza_src PS
        ON PT.PIZZA_TYPE_ID=PS.PIZZA_TYPE
)
select * from pizza_details