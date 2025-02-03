

select
    business_id,
    value::timestamp as checkin_date
from raw.yelp.view_checkins,
lateral flatten(input => checkin_datetimes) as f