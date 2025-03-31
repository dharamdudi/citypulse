

with __dbt__cte__int_business_categories as (


select
    business_id,
    value::text as category
from raw.yelp.view_business,
lateral flatten(input => categories) as f
) select
    md5(cast(coalesce(cast(business_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as surrogate_key,
    business_id,
    category,
    '2025-03-31 16:12:15.257665+00:00'::timestamp_tz as executed_at
from __dbt__cte__int_business_categories