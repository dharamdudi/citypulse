

with __dbt__cte__business_attributes_flattened as (


select
    business_id,
    lower(a.key) as attribute_key,
    try_parse_json(a.value) as attribute_value
from raw.yelp.view_business,
lateral flatten(input => attributes) as a
),  __dbt__cte__business_attributes_restaurent as (


select
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
),  __dbt__cte__business_attributes_pets as (


select
    business_id,
    dogsallowed::boolean as dogsallowed
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in ('dogsallowed')
) as p (business_id, dogsallowed)
),  __dbt__cte__business_attributes_ages as (


select
    business_id,
    agesallowed::text as agesallowed,
    goodforkids::boolean as goodforkids
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in ('agesallowed', 'goodforkids')
) as p (business_id, agesallowed, goodforkids)
),  __dbt__cte__business_attributes_ambience as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'ambience'
),

ambience_flattened as (
    select
        business_id,
        lower(a.key) as ambience_key,
        a.value::boolean as ambience_value
    from flattened,
    lateral flatten(input => attribute_value) as a
)

select *
from ambience_flattened
pivot(
    max(ambience_value)
    for ambience_key in ('romantic', 'intimate', 'classy', 'hipster', 'divey', 'touristy', 'trendy', 'upscale', 'casual')
) as p (business_id, amb_romantic, amb_intimate, amb_classy, amb_hipster, amb_divey, amb_touristy, amb_trendy, amb_upscale, amb_casual)
),  __dbt__cte__business_attributes_music as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'music'
),

music_flattened as (
    select
        business_id,
        lower(a.key) as music_key,
        a.value::boolean as music_value
    from flattened,
    lateral flatten(input => attribute_value) as a
)

select *
from music_flattened
pivot(
    max(music_value)
    for music_key in ('dj', 'background_music', 'jukebox', 'live', 'video', 'karaoke')
) as p (business_id, music_dj, music_background_music, music_jukebox, music_live, music_video, music_karaoke)
),  __dbt__cte__business_attributes_parking as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'businessparking'
),

bp_flattened as (
    select
        business_id,
        lower(a.key) as business_parking_key,
        a.value::boolean as business_parking_value
    from flattened,
    lateral flatten(input => attribute_value) as a
),

business_parking as (
    select *
    from bp_flattened
    pivot(
        max(business_parking_value)
        for business_parking_key in ('garage', 'street', 'validated', 'lot', 'valet')
    ) as p (business_id, business_parking_garage, business_parking_street, business_parking_validated, business_parking_lot, business_parking_valet)
),

other_parking as (
    select *
    from __dbt__cte__business_attributes_flattened
    pivot(
        max(attribute_value)
        for attribute_key in ('bikeparking', 'wheelchairaccessible')
    ) as p (business_id, bike_parking, wheelchair_accessible)
)

select
    bp.business_id,
    bp.business_parking_garage,
    bp.business_parking_street,
    bp.business_parking_validated,
    bp.business_parking_lot,
    bp.business_parking_valet,
    try_parse_json(op.bike_parking)::boolean as bike_parking,
    try_parse_json(op.wheelchair_accessible)::boolean as wheelchair_accessible
from business_parking bp
inner join other_parking op
    on bp.business_id = op.business_id
),  __dbt__cte__business_attributes_bestnights as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'bestnights'
),

bestnights_flattened as (
    select
        business_id,
        lower(a.key) as bestnights_key,
        a.value::boolean as bestnights_value
    from flattened,
    lateral flatten(input => attribute_value) as a
)

select *
from bestnights_flattened
pivot(
    max(bestnights_value)
    for bestnights_key in ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')
) as p (business_id, bestnights_monday, bestnights_tuesday, bestnights_wednesday, bestnights_thursday, bestnights_friday, bestnights_saturday, bestnights_sunday)
),  __dbt__cte__business_attributes_common as (


select
    business_id,
    noiselevel::text as noiselevel,
    byappointmentonly::boolean as byappointmentonly,
    wifi::text as wifi,
    smoking::text as smoking,
    open24hours::boolean as open24hours
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in ('noiselevel', 'byappointmentonly', 'wifi', 'smoking', 'open24hours')
) as p (business_id, noiselevel, byappointmentonly, wifi, smoking, open24hours)
),  __dbt__cte__business_attributes_goodformeal as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'goodformeal'
),

goodformeal_flattened as (
    select
        business_id,
        lower(a.key) as goodformeal_key,
        a.value::boolean as goodformeal_value
    from flattened,
    lateral flatten(input => attribute_value) as a
)

select *
from goodformeal_flattened
pivot(
    max(goodformeal_value)
    for goodformeal_key in ('dessert', 'latenight', 'lunch', 'dinner', 'brunch', 'breakfast')
) as p (business_id, goodformeal_dessert, goodformeal_latenight, goodformeal_lunch, goodformeal_dinner, goodformeal_brunch, goodformeal_breakfast)
),  __dbt__cte__business_attributes_payments as (


select
    business_id,
    acceptsinsurance::boolean as acceptsinsurance,
    businessacceptscreditcards::boolean as businessacceptscreditcards,
    businessacceptsbitcoin::boolean as businessacceptsbitcoin
from __dbt__cte__business_attributes_flattened
pivot(
    max(attribute_value)
    for attribute_key in ('acceptsinsurance', 'businessacceptscreditcards', 'businessacceptsbitcoin')
) as p (business_id, acceptsinsurance, businessacceptscreditcards, businessacceptsbitcoin)
),  __dbt__cte__business_attributes_dietary_restrictions as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'dietaryrestrictions'
),

diet_flattened as (
    select
        business_id,
        lower(a.key) as diet_key,
        a.value::boolean as diet_value
    from flattened,
    lateral flatten(input => attribute_value) as a
)

select
    business_id,
    diet_dairy_free::boolean as diet_dairy_free,
    diet_gluten_free::boolean as diet_gluten_free,
    diet_vegan::boolean as diet_vegan,
    diet_kosher::boolean as diet_kosher,
    diet_halal::boolean as diet_halal,
    diet_soy_free::boolean as diet_soy_free,
    diet_vegetarian::boolean as diet_vegetarian
from diet_flattened
pivot(
    max(diet_value)
    for diet_key in ('dairy-free', 'gluten-free', 'vegan', 'kosher', 'halal', 'soy-free', 'vegetarian')
) as p (business_id, diet_dairy_free, diet_gluten_free, diet_vegan, diet_kosher, diet_halal, diet_soy_free, diet_vegetarian)
),  __dbt__cte__business_attributes_hairspecializesin as (


with flattened as (
    select
        business_id,
        try_parse_json(attribute_value) as attribute_value
    from __dbt__cte__business_attributes_flattened
    where attribute_key = 'hairspecializesin'
),

hair_flattened as (
    select
        business_id,
        lower(a.key) as hair_key,
        a.value::boolean as hair_value
    from flattened,
    lateral flatten(input => attribute_value) as a
)

select *
from hair_flattened
pivot(
    max(hair_value)
    for hair_key in ('coloring', 'extensions', 'perms', 'straightperms', 'africanamerican', 'asian', 'curly', 'kids')
) as p (business_id, hair_coloring, hair_extensions, hair_perms, hair_straightperms, hair_africanamerican, hair_asian, hair_curly, hair_kids)
) select
    rst.business_id,
    rst.restaurantsdelivery,
    rst.drivethru,
    rst.byobcorkage,
    rst.byob,
    rst.coatcheck,
    rst.happyhour,
    rst.hastv,
    rst.restaurantspricerange2,
    rst.restaurantsreservations,
    rst.restaurantstakeout,
    rst.restaurantsgoodforgroups,
    rst.alcohol,
    rst.corkage,
    rst.caters,
    rst.outdoorseating,
    rst.restaurantsattire,
    rst.restaurantstableservice,
    rst.restaurantscounterservice,
    rst.goodfordancing,
    pets.dogsallowed,
    ages.agesallowed,
    ages.goodforkids,
    amb.amb_casual,
    amb.amb_classy,
    amb.amb_divey,
    amb.amb_hipster,
    amb.amb_intimate,
    amb.amb_romantic,
    amb.amb_touristy,
    amb.amb_trendy,
    amb.amb_upscale,
    mus.music_background_music,
    mus.music_dj,
    mus.music_jukebox,
    mus.music_karaoke,
    mus.music_live,
    mus.music_video,
    park.business_parking_garage,
    park.business_parking_street,
    park.business_parking_validated,
    park.business_parking_lot,
    park.business_parking_valet,
    park.bike_parking,
    park.wheelchair_accessible,
    bnt.bestnights_friday,
    bnt.bestnights_monday,
    bnt.bestnights_saturday,
    bnt.bestnights_sunday,
    bnt.bestnights_thursday,
    bnt.bestnights_tuesday,
    bnt.bestnights_wednesday,
    cmn.noiselevel,
    cmn.byappointmentonly,
    cmn.wifi,
    cmn.smoking,
    cmn.open24hours,
    gfm.goodformeal_dessert,
    gfm.goodformeal_latenight,
    gfm.goodformeal_lunch,
    gfm.goodformeal_dinner,
    gfm.goodformeal_brunch,
    gfm.goodformeal_breakfast,
    pmt.acceptsinsurance,
    pmt.businessacceptscreditcards,
    pmt.businessacceptsbitcoin,
    dr.diet_dairy_free,
    dr.diet_gluten_free,
    dr.diet_vegan,
    dr.diet_kosher,
    dr.diet_halal,
    dr.diet_soy_free,
    dr.diet_vegetarian,
    hr.hair_coloring,
    hr.hair_extensions,
    hr.hair_perms,
    hr.hair_straightperms,
    hr.hair_africanamerican,
    hr.hair_asian,
    hr.hair_curly,
    hr.hair_kids,
    '2025-03-31 15:49:54.234692+00:00'::timestamp_tz as executed_at
from __dbt__cte__business_attributes_restaurent as rst
left join __dbt__cte__business_attributes_pets as pets
    on rst.business_id = pets.business_id
left join __dbt__cte__business_attributes_ages as ages
    on rst.business_id = ages.business_id
left join __dbt__cte__business_attributes_ambience as amb
    on rst.business_id = amb.business_id
left join __dbt__cte__business_attributes_music as mus
    on rst.business_id = mus.business_id
left join __dbt__cte__business_attributes_parking as park
    on rst.business_id = park.business_id
left join __dbt__cte__business_attributes_bestnights as bnt
    on rst.business_id = bnt.business_id
left join __dbt__cte__business_attributes_common as cmn
    on rst.business_id = cmn.business_id
left join __dbt__cte__business_attributes_goodformeal as gfm
    on rst.business_id = gfm.business_id
left join __dbt__cte__business_attributes_payments as pmt
    on rst.business_id = pmt.business_id
left join __dbt__cte__business_attributes_dietary_restrictions as dr
    on rst.business_id = dr.business_id
left join __dbt__cte__business_attributes_hairspecializesin as hr
    on rst.business_id = hr.business_id