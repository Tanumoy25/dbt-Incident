{{ config(schema='curated') }}

with status as (
    select
        distinct incident_status
    from {{ ref('landing_table') }}
)
SELECT *, row_number() over (order by incident_status) as row_num,current_timestamp() as loading_time
from status