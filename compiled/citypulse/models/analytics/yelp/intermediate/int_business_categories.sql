

select
    business_id,
    value::text as category
from raw.yelp.view_business,
lateral flatten(input => categories) as f