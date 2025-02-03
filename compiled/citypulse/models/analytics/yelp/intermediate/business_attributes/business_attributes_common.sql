

with __dbt__cte__business_attributes_flattened as (


select
    business_id,
    lower(a.key) as attribute_key,
    try_parse_json(a.value) as attribute_value
from raw.yelp.view_business,
lateral flatten(input => attributes) as a
) select
    business_id,
    noiselevel::text as noiselevel,
    byappointmentonly::boolean as byappointmentonly,
    wifi::text as wifi,
    smoking::text as smoking,
    open24hours::boolean as open24hours
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in ('noiselevel', 'byappointmentonly', 'wifi', 'smoking', 'open24hours')
) as p (business_id, noiselevel, byappointmentonly, wifi, smoking, open24hours)