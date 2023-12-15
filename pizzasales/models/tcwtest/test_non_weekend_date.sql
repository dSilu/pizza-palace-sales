{% set input_date = '2023-12-15' %}
{% set output_date = get_weekday(date=input_date) %}

SELECT 
    {{ input_date }} AS test_date,
    {{ output_date }} AS result_date
