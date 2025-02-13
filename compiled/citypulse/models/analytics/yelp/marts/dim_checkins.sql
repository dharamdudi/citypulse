

with __dbt__cte__int_checkins as (


select
    business_id,
    value::timestamp as checkin_date
from raw.yelp.view_checkins,
lateral flatten(input => checkin_datetimes) as f
) select
    md5(cast(coalesce(cast(business_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(checkin_date as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as surrogate_key,
    business_id,
    checkin_date,
    '2025-02-13 09:26:50.448447+00:00'::timestamp_tz as executed_at
from __dbt__cte__int_checkins