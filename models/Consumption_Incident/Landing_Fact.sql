{{
    config(
        schema='consumption',
        materialized='incremental',
        unique_key='number'
    )
}}

Select i.opened,i.number,i.summary,i.assigned_to,p.row_num as priority_num,s.row_num as status_num,i.ci,current_timestamp() as load_time
from {{ ref('landing_table') }} i
join {{ ref('Incident_Priority') }} p
on i.priority=p.priority_num 
join {{ ref('Incident_Status') }} s
on i.incident_status=s.incident_status

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where load_time >= (select max(load_time) from {{ this }})

{% endif %}

group by 1