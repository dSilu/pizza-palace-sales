{{ config(
    materialized="table"
) }}


WITH stg_orders as (
    SELECT
        id as order_id,
        date as order_date,
        TO_TIMESTAMP(CONCAT(date::string, ' ',time), 'YYYY-MM-DD HH24:MI:SS') AS order_datetime,
        year(date) as order_year,
        QUARTER(date) as order_quarter,
        MONTHNAME(date) as order_month_name,
        MONTH(date) as order_month,
        DAYNAME(date) as order_day,
        DAYOFWEEK(date) as order_week_day
    FROM {{ source('pizza_place', 'orders') }}
)
SELECT * FROM stg_orders
