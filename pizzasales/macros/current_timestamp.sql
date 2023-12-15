-- {# Find current timestamp #}

{% macro get_current_timestamp() %}
    {% set cur_ts = run_query('select current_timestamp()') %}
    -- {# do print(cur_ts.columns[0].values()[0]) #}
    {{ cur_ts.columns[0].values()[0] }}
{% endmacro %}

-- {# Get week day from a date #}

{% macro get_week_date(user_date) %}


    {% set dayofweek_query %}
        -- {# select dayname(date({{ user_date }})) as day_week, dayofweek(date({{ user_date }})) as day_num #}
        select dayname({{ user_date|string }})
    {% endset %}

    {% set week_day = run_query(dayofweek_query).columns[0].values()[0] %}
    -- {# {% do print(week_day) %} #}
    {% if week_day=='Sat' %}
        {% set previous_friday_query %}
            select previous_day({{ user_date }}, 'fr')
        {% endset %}

        {% set previous_friday = run_query(previous_friday_query).columns[0].values()[0] %}
        {% do print(previous_friday) %}
    {% elif week_day=='Sun' %}
        {% set next_monday_query %}
            select next_day({{ user_date }}, 'mo')
        {% endset %}
        {% set next_monday = run_query(next_month_query).columns[0].values()[0] %}
        {% do print(next_monday) %}
    {% else %}
        {% do print(user_date )%}
    {% endif %}
{% endmacro %}


-- {# Get Nth Week day #}
{% macro get_nth_week_day(nth_week,week_day,user_year,user_month) %}

    {% set week_day_num = {'Mon':1, 'Tue':2, 'Wed':3, 'Thu':4, 'Fri':5, 'Sat':6, 'Sun':7} %}
    {% do print(week_day[:3])%}
    {% do print(week_day_num[week_day[:3]])%}

    {% set first_day_of_month %}
        select date_from_parts({{ user_year|int }}, {{ user_month|int }}, 1)
    {% endset %}

    {% set first_of_month = run_query(first_day_of_month).columns[0].values()[0] %}
    {% do print(first_of_month)%}

    {% do print((week_day_num[week_day[:3]] - 5)%7+(3-1)*7) %}

    {% set get_date %}
        select 
            dateadd(
                day,
                ({{ week_day_num[week_day[:3]] }} - dayofweek(try_to_date({{ first_of_month }}))) % 7 + ({{ nth_week|int }}-1) * 7, 
                try_to_date({{ first_of_month }}, 'YYYY-MM-DD'))
    {% endset %}

    {% set get_date_result = run_query(get_date).columns[0].values()[0] %}
    {% do print(get_date_result) %}
{% endmacro %}

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