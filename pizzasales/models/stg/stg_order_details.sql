{{ config(
    materialized="table"
) }}

WITH order_details as (
    SELECT * FROM {{ ref('src_order_details') }}
),

pizza_price as (
    SELECT * FROM {{ ref('src_pizzas') }}
)

SELECT
    od.order_details_id as sales_id,
    od.order_id,
    pp.pizza_type,
    od.order_quantity,
    pp.pizza_size,
    (od.order_quantity * pp.price) as order_amount
FROM order_details od 
INNER JOIN pizza_price pp 
    ON od.pizza_id = pp.pizza_order_id
