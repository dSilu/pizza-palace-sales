{{ config(
    materialized='table'
) }}

WITH stg_order_details AS (
    select * from {{ ref('stg_order_details') }}
),
stg_orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
) 

SELECT
    od.ORDER_ID,
    o.ORDER_DATETIME,
    SUM(od.ORDER_QUANITY) AS TOTAL_ORDER_QUANTITY,
    SUM(od.ORDER_AMOUNT) AS TOTAL_ORDER_AMOUNT
FROM stg_order_details od.
LEFT JOIN stg_orders o 
    USING (ORDER_ID)