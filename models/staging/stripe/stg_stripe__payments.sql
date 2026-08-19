WITH source as (
    select * from {{ source('stripe', 'payment') }}
),

renamed as (

    SELECT
        ID as payment_id,
        ORDERID AS order_id,
        STATUS AS payment_status,
        AMOUNT as payment_amount
    from source
)

SELECT * FROM renamed