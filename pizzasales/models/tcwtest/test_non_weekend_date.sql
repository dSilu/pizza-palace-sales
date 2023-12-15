{{
    config(
        alias='week_day_test'
    )
}}

WITH raw_date_table as (
    select * from {{ source('pizza_place', 'macro_test') }}
)
SELECT
    id,
    what_date as given_date,
    -- {{ dbt_date.day_name('what_date') }} as week_day,
    {{ find_week_day('what_date') }} as week_day
FROM raw_date_table