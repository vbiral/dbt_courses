with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payment as (
    select * from {{ ref('stg_stripe__payments') }}
),

order_payments as (
    select
        order_id,
        sum(case when payment_status='sucess' then payment_amount else 0 end) as amount
    from payments
    group by order_id
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.amount,0) as amount
    from orders
    left join order_payments using (order_id)
)

SELECT * FROM final