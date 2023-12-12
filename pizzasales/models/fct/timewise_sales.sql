{{
    config(materialized='table')
}}

with part_of_day as (

    SELECT 
        order_id, 
        order_datetime,
        CASE
            WHEN DATE_PART('hour', order_datetime) BETWEEN 0 AND 5 THEN 'Midnight'
            WHEN DATE_PART('hour', order_datetime) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN DATE_PART('hour', order_datetime) BETWEEN 12 AND 13 THEN 'Noon'
            WHEN DATE_PART('hour', order_datetime) BETWEEN 14 AND 17 THEN 'Afternoon'
            WHEN DATE_PART('hour', order_datetime) BETWEEN 18 AND 20 THEN 'Evening'
            WHEN DATE_PART('hour', order_datetime) BETWEEN 21 AND 23 THEN 'Night'
        END AS time_of_day,
        total_order_quantity, 
        total_order_amount
    FROM {{ ref('fct_orders') }}

)
select
    time_of_day,
    sum(total_order_quantity) AS total_orders,
    {{ find_percentage('total_order_quantity') }} AS order_percentage,
    sum(total_order_amount) AS total_sales,
    {{ find_percentage('total_order_amount') }} As sales_percentage
FROM part_of_day
GROUP By 1