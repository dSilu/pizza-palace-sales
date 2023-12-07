{{ config(
    materialized="incremental"
) }}


WITH stg_orders as (
    SELECT
        order_id as order_id,
        order_date as order_date,
        TO_TIMESTAMP(CONCAT(order_date::string, ' ',order_time), 'YYYY-MM-DD HH24:MI:SS') AS order_datetime,
        year(order_date) as order_year,
        QUARTER(order_date) as order_quarter,
        MONTHNAME(order_date) as order_month_name,
        MONTH(order_date) as order_month,
        DAYNAME(order_date) as order_day,
        DAYOFWEEK(order_date) as order_week_day
    FROM {{ ref('src_orders') }}
)
SELECT * FROM stg_orders
