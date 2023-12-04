{{ config(
    materialized="table"
) }}

WITH order_details as (
    SELECT
        order_details_id,
        order_id,
        pizza_id,
        quantity as order_quantity
    FROM {{ ref('src_order_details') }}
),

pizza_price as (
    SELECT
        id as piza_order_id,
        type_id as pizza_type,
        size as pizza_size,
        price
    FROM {{ ref('src_pizzas') }}
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
    ON od.pizza_id = pp.piza_order_id
