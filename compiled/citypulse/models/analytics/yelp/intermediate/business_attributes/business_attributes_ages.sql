

with __dbt__cte__business_attributes_flattened as (


select
    business_id,
    lower(a.key) as attribute_key,
    try_parse_json(a.value) as attribute_value
from raw.yelp.view_business,
lateral flatten(input => attributes) as a
) select
    business_id,
    agesallowed::text as agesallowed,
    goodforkids::boolean as goodforkids
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in ('agesallowed', 'goodforkids')
) as p (business_id, agesallowed, goodforkids)