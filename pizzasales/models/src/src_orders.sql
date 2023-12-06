WITH RAW_ORDERS AS (
    SELECT 
        DISTINCT 
            ID AS ORDER_ID,
            DATE AS ORDER_DATE,
            TIME AS ORDER_TIME 
    FROM {{ source('pizza_place', 'orders') }}
    WHERE ID IS NOT NULL
        AND DATE IS NOT NULL
        AND TIME IS NOT NULL
)
SELECT * FROM RAW_ORDERS
