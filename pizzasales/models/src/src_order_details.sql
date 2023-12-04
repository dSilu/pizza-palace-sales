WITH RAW_ORDER_DETAILS AS (
    SELECT * FROM {{ source('pizza_place', 'order_details') }}
)
SELECT * FROM RAW_ORDER_DETAILS
