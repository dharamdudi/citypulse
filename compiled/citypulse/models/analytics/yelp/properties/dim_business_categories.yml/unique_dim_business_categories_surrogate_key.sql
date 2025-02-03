
    
    

select
    surrogate_key as unique_field,
    count(*) as n_records

from production.public.dim_business_categories
where surrogate_key is not null
group by surrogate_key
having count(*) > 1


