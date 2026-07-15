{{ config(materialized='view') }}

--query di pulizia duplicati
with source_data as (
    select * from {{ ref('raw_customers') }}
),

cleaned_data as (
    select
        id as customer_id,
        upper(first_name) as first_name,
        upper(last_name) as last_name,
        signup_date
    from source_data
)

-- dbt automatically handles deduplication if we write a group by or distinct
select distinct * from cleaned_data
