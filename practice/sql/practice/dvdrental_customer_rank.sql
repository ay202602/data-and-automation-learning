-- 顧客を3つのランクに分けるクエリ
WITH customer_payment AS (
    SELECT
        p.customer_id,
        SUM(p.amount)  AS total_amount,
        COUNT(p.amount) AS payment_count
    FROM payment AS p
    GROUP BY p.customer_id
),
total_amount_tile AS (
    SELECT
        cp.customer_id,
        cp.total_amount,
        cp.payment_count,
        NTILE(3) OVER (ORDER BY cp.total_amount DESC) AS tile
    FROM customer_payment AS cp
),
customer_rank AS (
    SELECT
        tat.customer_id,
        tat.total_amount,
        tat.payment_count,
    CASE tat.tile
        WHEN 1 THEN 'rank_A'
        WHEN 2 THEN 'rank_B'
        ELSE 'rank_C'
    END AS customer_rank
    FROM total_amount_tile AS tat
)
SELECT
    cr.customer_rank,
    COUNT(cr.customer_id)                                  AS customer,
    SUM(cr.total_amount)                                   AS total_sales,
    ROUND(SUM(cr.total_amount) / SUM(cr.payment_count), 2) AS avg_amount
FROM customer_rank AS cr
GROUP BY cr.customer_rank
ORDER BY cr.customer_rank ASC;