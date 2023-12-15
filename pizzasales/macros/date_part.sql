{% macro part_of_the_day(colname) %}
    {% set hour=colname|strftime('%H')|int %}
    {% if hour < 5 %}
        Midnight
    {% elif hour>=5 and hour < 11 %}
        Morning
    {% elif hour>=11 and hour < 14 %}
        Noon
    {% elif hour>=14 and hour < 17 %}
        Afternoon
    {% elif hour >=17 and hour < 21 %}
        Evening
    {% else %}
        Night
    {% endif %}
{% endmacro %}