

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
    '2025-03-31 14:59:21.723829+00:00'::timestamp_tz as executed_at
from raw.yelp.view_business
qualify row_number() over (partition by business_id order by null desc) = 1

