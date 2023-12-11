{{
    config(
        alias='sales_size',
        materialized='table'
    )
}}


WITH order_percentage_by_size AS (
    select 
        pizza_size,
        sum(order_quantity) AS total_orders,
        {{ find_percentage('order_quantity') }} AS order_percentage,
        sum(order_amount) as total_sales,
        {{ find_percentage('order_amount') }} AS sales_percentage
    from {{ ref('dim_order_details') }}
    GROUP BY 1
)
select * from order_percentage_by_size

