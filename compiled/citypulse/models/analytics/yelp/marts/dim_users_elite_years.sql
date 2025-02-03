

with __dbt__cte__int_users_elite_years as (


with flattened as (
    select
        user_id,
        try_to_numeric(value::text) as elite_year
    from raw.yelp.view_users,
    lateral flatten(input => elite_years) as f
)

select
    user_id,
    case when elite_year = 20 then 2020 else elite_year end as year
from flattened
where elite_year is not null
) select
    md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(year as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as surrogate_key,
    user_id,
    year,
    '2025-02-03 11:35:40.791206+00:00'::timestamp_tz as executed_at
from __dbt__cte__int_users_elite_years