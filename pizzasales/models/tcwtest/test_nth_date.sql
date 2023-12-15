SELECT
    4 as nth_week,
    'Fri' as test_weekday,
    2020 as test_year,
    2 as test_month,
    {{ find_nth_week_day(4, 'Fri', 2020, 2) }} as found_date