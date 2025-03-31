

select
    review_id,
    user_id,
    business_id,
    stars,
    review_date,
    review,
    useful_votes,
    funny_votes,
    cool_votes,
    '2025-03-31 15:49:54.234692+00:00'::timestamp_tz as executed_at
from raw.yelp.view_reviews