{{ config(
    materialized="table"
) }}


WITH stg_orders as (
    SELECT
        id as order_id,
        TO_TIMESTAMP(CONCAT(date::string, ' ',time), 'YYYY-MM-DD HH24:MI:SS') AS order_datetime,
        year(date) as order_year,
        QUARTER(date) as order_quarter,
        MONTHNAME(date) as order_month,
        DAYNAME(date) as order_day
    FROM {{ source('pizza_place_sales', 'ORDERS') }}
)
SELECT * FROM stg_orders
