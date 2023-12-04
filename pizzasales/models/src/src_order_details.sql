WITH RAW_ORDER_DETAILS AS (
    SELECT 
        order_details_id,
        order_id,
        pizza_id,
        quantity as order_quantity
    FROM {{ source('pizza_place', 'order_details') }}
)
SELECT * FROM RAW_ORDER_DETAILS
