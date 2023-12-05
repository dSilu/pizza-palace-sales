SELECT *
FROM {{ ref('stg_order_details') }}
WHERE order_amount <1