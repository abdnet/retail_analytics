WITH source as (

    select * from {{ source('EVENT', 'EVENT_CUSTOMERS') }}
),

last_items as (
    
    select
        customer_id,
        name,
        sex,
        region,
        country,
        email,
        postal_code,
        city,
        _airbyte_extracted_at as event_time


    from source

    {% if is_incremental() %}

        where event_time > (select max(event_time) from {{ this }})

    {% endif %}

)

select * from last_items