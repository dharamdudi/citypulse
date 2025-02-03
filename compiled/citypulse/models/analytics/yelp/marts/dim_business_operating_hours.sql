-- pivot


with
 __dbt__cte__business_opening_hrs as (


with flattened as (
    select
        business_id,
        lower(h.key) as day_of_week,
        split_part(h.value::text, '-', 1)::time as open_time
    from raw.yelp.view_business,
    lateral flatten(input => hours) as h
)

select *
from flattened
pivot(
    max(open_time)
    for day_of_week in ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')
) as p (business_id, monday_open, tuesday_open, wednesday_open, thursday_open, friday_open, saturday_open, sunday_open)
),  __dbt__cte__business_closing_hrs as (


with flattened as (
    select
        business_id,
        lower(h.key) as day_of_week,
        split_part(h.value::text, '-', 2)::time as close_time
    from raw.yelp.view_business,
    lateral flatten(input => hours) as h
)

select *
from flattened
pivot(
    max(close_time)
    for day_of_week in ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')
) as p (business_id, monday_close, tuesday_close, wednesday_close, thursday_close, friday_close, saturday_close, sunday_close)
), opening_hrs as (
    select *
    from __dbt__cte__business_opening_hrs
),

closing_hrs as (
    select *
    from __dbt__cte__business_closing_hrs
)

select
    o.business_id,
    o.monday_open,
    c.monday_close,
    o.tuesday_open,
    c.tuesday_close,
    o.wednesday_open,
    c.wednesday_close,
    o.thursday_open,
    c.thursday_close,
    o.friday_open,
    c.friday_close,
    o.saturday_open,
    c.saturday_close,
    o.sunday_open,
    c.sunday_close
from opening_hrs as o
inner join closing_hrs as c
    on o.business_id = c.business_id

