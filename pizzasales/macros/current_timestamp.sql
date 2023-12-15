-- {# Find current timestamp #}

{% macro get_current_timestamp() %}
    {{ dbt.current_timestamp() }}
    {{ dbt}}
{% endmacro %}

-- {# Get week day from a date #}


{% macro find_week_day(user_date) %}
    case dayofweek({{ user_date }})
        when 6 then previous_day({{ user_date }}, 'fr')
        when 0 then next_day({{ user_date }}, 'mo')
        else {{ user_date }}
    end
{% endmacro %}


-- {# Get Nth Week day #}
{%- macro find_nth_week_day(nth_week,week_day,user_year,user_month) -%}

    {%- set week_day_num = {'Mon':1, 'Tue':2, 'Wed':3, 'Thu':4, 'Fri':5, 'Sat':6, 'Sun':0} -%}
    
    dateadd(
        day, 
        ({{ week_day_num[week_day[:3]] }} - dayofweek(date_from_parts({{ user_year|int }}, {{ user_month|int }}, 1))) % 7 + ({{ nth_week|int }}) * 7, 
        date_from_parts({{ user_year|int }}, {{ user_month|int }}, 1))

{%- endmacro -%}



-- {# Week day num #}
{% macro find_num(day) %}
    {% set week_day_num = {'Mon':1, 'Tue':2, 'Wed':3, 'Thu':4, 'Fri':5, 'Sat':6, 'Sun':7} %}
    {% do print(day)%}
    {% do print(day[:3]) %}
    {% do print(week_day_num[day[:3]]) %}
{% endmacro %}

{% macro check_date_type(given_date) %}
    {% set find_date %}
        select 
            {{ dbt_function.from_date('2023-12-15') }} AS given_date, 
            dayname({{ dbt_function.from_date('2023-12-15')}}) as given_day
    {% endset %}
    {% set given_date = run_query(find_date) %}
    {% do given_date.print_table() %}
{% endmacro %}