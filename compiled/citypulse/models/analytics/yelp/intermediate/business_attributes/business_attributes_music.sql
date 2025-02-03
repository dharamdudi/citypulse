

with  __dbt__cte__business_attributes_flattened as (


select
    business_id,
    lower(a.key) as attribute_key,
    try_parse_json(a.value) as attribute_value
from raw.yelp.view_business,
lateral flatten(input => attributes) as a
), flattened as (
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