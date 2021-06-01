with priority as (
    select
        distinct priority as priority_num
    from {{ ref('landing_table') }}
)
SELECT *, row_number() over (order by priority_num) as row_num,current_timestamp() as loading_time
 from priority