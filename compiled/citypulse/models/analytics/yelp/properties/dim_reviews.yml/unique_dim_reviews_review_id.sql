
    
    

select
    review_id as unique_field,
    count(*) as n_records

from production.public.dim_reviews
where review_id is not null
group by review_id
having count(*) > 1


