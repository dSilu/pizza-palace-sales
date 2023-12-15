{% macro testing_return() %}
    {% set results = run_query('select 1 as id') %}
    {% do print(results.columns[0]) %}
{% endmacro %}
-- do something with `results` here...

{% macro converted_todate(any_date) %}
    {% set any_date = any_date|string %}
    {% set any_date_parts=any_date.split('-') %}
    {# {% set final_date = dbt_date.date(any_date) %} #}
    {# {% set query %}
        SELECT {{ dbt_function.from_date(any_date) }} AS datetime
    {% endset %} #}
    {# {% set result = run_query(query)%} #}
    {% do print(any_date_parts) %}
{% endmacro %}

{% macro get_name_of_the_date(any_date) %}
    {% do print(any_date) %}
    {% set query %}
        select date({{ any_date|string }}) as given_date, dayname(date({{ any_date }})) as of_week_short_name
    {% endset %}
    {% set result = run_query(query) %}
    {% do result.print_table() %}
{% endmacro %}