WITH RAW_PIZZAS AS (
    SELECT * FROM {{ source('pizza_place', 'pizzas') }}
)
SELECT * FROM RAW_PIZZAS
