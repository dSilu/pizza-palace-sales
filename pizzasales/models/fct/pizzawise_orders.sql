{{
    config(
        alias='sales_type',
        materialized='table'
    )
}}


with pizza_order as (
    select
        pizza_type,
        sum(order_quantity) AS total_orders,
        {{ find_percentage('order_quantity') }} AS order_percentage,
        sum(order_amount) AS total_sales,
        {{ find_percentage('order_amount') }} AS sales_percentage
    FROM {{ ref('dim_order_details') }}
    GROUP BY 1
)
SELECT * FROM pizza_order