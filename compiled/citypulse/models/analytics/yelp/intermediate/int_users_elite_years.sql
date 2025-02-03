

with flattened as (
    select
        user_id,
        try_to_numeric(value::text) as elite_year
    from raw.yelp.view_users,
    lateral flatten(input => elite_years) as f
)

select
    user_id,
    case when elite_year = 20 then 2020 else elite_year end as year
from flattened
where elite_year is not null