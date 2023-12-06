SELECT *
FROM {{ ref('dim_order_details') }}
WHERE order_amount <1