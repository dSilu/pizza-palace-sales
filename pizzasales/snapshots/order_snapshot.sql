{% snapshot orders_snapshot_check %}

    {{
        config(
          target_database="pizzaplace",
          target_schema='snapshots',
          strategy='check',
          unique_key='id',
          check_cols=['date', 'time'],
        )
    }}

    select * from {{ source('pizza_place', 'orders') }}

{% endsnapshot %}