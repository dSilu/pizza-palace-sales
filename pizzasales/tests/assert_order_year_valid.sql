select *
from {{ source('pizza_place', 'orders') }}
where year(date) < 2000