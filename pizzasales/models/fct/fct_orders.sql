{{ config(
    materialized='table'
) }}

WITH stg_order_details AS (
    select * from {{ ref('dim_order_details') }}
),
stg_orders AS (
    SELECT * FROM {{ ref('dim_orders') }}
) 

SELECT
    od.ORDER_ID,
    o.ORDER_DATETIME,
    SUM(od.ORDER_QUANTITY) AS TOTAL_ORDER_QUANTITY,
    SUM(od.ORDER_AMOUNT) AS TOTAL_ORDER_AMOUNT
FROM stg_order_details od
LEFT JOIN stg_orders o 
    USING (ORDER_ID)
GROUP BY 1,2