WITH RAW_PIZZAS AS (
    SELECT 
        id as pizza_order_id,
        type_id as pizza_type,
        size as pizza_size,
        price
    FROM {{ source('pizza_place', 'pizzas') }}
)
SELECT * FROM RAW_PIZZAS
