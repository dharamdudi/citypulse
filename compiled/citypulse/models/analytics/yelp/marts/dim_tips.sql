

select
    md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(business_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(tip_date as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as surrogate_key,
    user_id,
    business_id,
    tip_date,
    tip_msg,
    compliment_count,
    '2025-03-20 19:27:28.271935+00:00'::timestamp_tz as executed_at
from raw.yelp.view_tips
where tip_date is not null
qualify row_number() over (partition by surrogate_key order by tip_date desc) = 1