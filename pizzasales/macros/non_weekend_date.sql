{% macro get_weekday(date) %}
    {% set day_of_week= run_query('select dayofweek(date)') %}
    {% if day_of_week==6 %}
        {% set previous_date = date - timedelta(days=1) %}
        {{ previous_date }}
    {% elif day_of_week==7 %}
        {% set next_date = date + timedelta(days=1) %}
        {{ next_date }}
    {% else %}
        {{ date }}
    {% endif %}
{% endmacro %}