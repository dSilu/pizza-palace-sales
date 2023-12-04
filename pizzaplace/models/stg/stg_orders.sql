WITH stg_orders as (
    SELECT
        id as order_id,
        date as order_date,
        time as order_time,
        TO_TIMESTAMP(CONCAT(date::string, ' ',time), 'YYYY-MM-DD HH24:MI:SS') AS order_datetime,
        DAYNAME(date) as order_day
    FROM {{ source('pizza_place_sales', 'ORDERS') }}
)
SELECT * FROM stg_orders