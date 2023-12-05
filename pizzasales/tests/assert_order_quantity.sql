SELECT sales_id, order_quantity
FROM {{ ref('stg_order_details') }}
WHERE (order_quantity != 0) and (order_quantity <0)