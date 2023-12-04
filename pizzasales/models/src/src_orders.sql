WITH RAW_ORDERS AS (
    SELECT * FROM {{ source('pizza_place', 'orders') }}
)
SELECT * FROM RAW_ORDERS
