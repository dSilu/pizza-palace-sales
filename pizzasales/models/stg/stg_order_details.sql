{{ config(
    materialized="table"
) }}

WITH order_details as (
    SELECT
        order_details_id,
        order_id,
        pizza_id,
        quantity as order_quantity
    FROM {{ source('pizza_place_sales', 'ORDER_DETAILS') }}
),

pizza_price as (
    SELECT
        id as piza_order_id,
        type_id as pizza_type
        size as piza_size,
        price
)

SELECT
    od.order_details_id as sales_id,
    od.order_id,
    pp.pizza_type,
    od.order_quantity,
    pp.piza_size,
    (od.order_quantity * pp.price) as order_amount
FROM order_details od 
INNER JOIN pizza_price pp 
    ON od.pizza_id = pp.piza_order_id
