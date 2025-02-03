

select
    user_id,
    name,
    review_count,
    yelping_since,
    useful_votes,
    funny_votes,
    cool_votes,
    fans,
    average_stars,
    compliment_hot,
    compliment_more,
    compliment_profile,
    compliment_cute,
    compliment_list,
    compliment_note,
    compliment_plain,
    compliment_cool,
    compliment_funny,
    compliment_writer,
    compliment_photos,
    '2025-02-03 11:35:40.791206+00:00'::timestamp_tz as executed_at
from raw.yelp.view_users