

select
    business_id,
    name,
    address,
    city,
    state,
    postal_code,
    latitude,
    longitude,
    stars,
    review_count,
    is_open,
    '2025-02-03 11:35:40.791206+00:00'::timestamp_tz as executed_at
from raw.yelp.view_business
qualify row_number() over (partition by business_id order by null desc) = 1

