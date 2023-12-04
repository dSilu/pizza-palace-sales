{{ config(
    materialized='table'
) }}

WITH stg_order_details AS (
    select * from {{ ref('stg_order_details') }}
)

SELECT
    ORDER_ID,
    SUM(ORDER_QUANITY) AS TOTAL_ORDER_QUANTITY,
    SUM(ORDER_AMOUNT) AS TOTAL_ORDER_AMOUNT
FROM stg_order_details