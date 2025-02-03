with

final as (

    

        (
            select
                cast('production.public.base_node_columns' as TEXT) as _dbt_source_relation,

                

            from production.public.base_node_columns

            
        )

        union all
        

        (
            select
                cast('production.public.base_source_columns' as TEXT) as _dbt_source_relation,

                

            from production.public.base_source_columns

            
        )

        
)

select * from final