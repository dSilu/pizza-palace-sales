{{ config(
    materialized="table"
) }}

WITH order_details as (
    SELECT 
        order_details_id,
        order_id,
        pizza_id,
        quantity as order_quantity
    FROM {{ source('pizza_place', 'order_details') }}
),

pizza_price as (
    SELECT 
        id as pizza_order_id,
        type_id as pizza_type,
        size as pizza_size,
        price
    FROM {{ source('pizza_place', 'pizzas') }}
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
