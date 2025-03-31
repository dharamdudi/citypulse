

with __dbt__cte__int_users_friends as (


select
    user_id,
    value::text as friend_id
from raw.yelp.view_users,
lateral flatten(input => friends) as f
) select
    md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(friend_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as surrogate_key,
    user_id,
    friend_id,
    '2025-03-31 15:49:54.234692+00:00'::timestamp_tz as executed_at
from __dbt__cte__int_users_friends