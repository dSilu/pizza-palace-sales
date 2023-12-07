{% macro find_percentage(col_name) %}
    round(((sum({{ col_name }}) / sum(sum({{ col_name }})) over()) * 100),2)
{% endmacro %}