

with __dbt__cte__business_attributes_flattened as (


select
    business_id,
    lower(a.key) as attribute_key,
    try_parse_json(a.value) as attribute_value
from raw.yelp.view_business,
lateral flatten(input => attributes) as a
) select
    business_id,
    restaurantsdelivery::boolean as restaurantsdelivery,
    drivethru::boolean as drivethru,
    byobcorkage::text as byobcorkage,
    byob::boolean as byob,
    coatcheck::boolean as coatcheck,
    happyhour::boolean as happyhour,
    hastv::boolean as hastv,
    restaurantspricerange2,
    restaurantsreservations::boolean as restaurantsreservations,
    restaurantstakeout::boolean as restaurantstakeout,
    restaurantsgoodforgroups::boolean as restaurantsgoodforgroups,
    alcohol::text as alcohol,
    corkage::boolean as corkage,
    caters::boolean as caters,
    outdoorseating::boolean as outdoorseating,
    restaurantsattire::text as restaurantsattire,
    restaurantstableservice::boolean as restaurantstableservice,
    restaurantscounterservice::boolean as restaurantscounterservice,
    goodfordancing::boolean as goodfordancing
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in (
        'restaurantsdelivery', 'drivethru', 'byobcorkage', 'byob', 'coatcheck', 'happyhour', 'hastv',
        'restaurantspricerange2', 'restaurantsreservations', 'restaurantstakeout', 'restaurantsgoodforgroups',
        'alcohol', 'corkage', 'caters', 'outdoorseating', 'restaurantsattire',
        'restaurantstableservice', 'restaurantscounterservice', 'goodfordancing'
    )
) as p (
    business_id, restaurantsdelivery, drivethru, byobcorkage, byob, coatcheck, happyhour, hastv,
    restaurantspricerange2, restaurantsreservations, restaurantstakeout, restaurantsgoodforgroups,
    alcohol, corkage, caters, outdoorseating, restaurantsattire,
    restaurantstableservice, restaurantscounterservice, goodfordancing
)