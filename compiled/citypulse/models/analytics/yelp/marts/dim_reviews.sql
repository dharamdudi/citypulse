

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
    '2025-02-03 11:21:44.340172+00:00'::timestamp_tz as executed_at
from raw.yelp.view_reviews