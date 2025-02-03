

select
    user_id,
    value::text as friend_id
from raw.yelp.view_users,
lateral flatten(input => friends) as f