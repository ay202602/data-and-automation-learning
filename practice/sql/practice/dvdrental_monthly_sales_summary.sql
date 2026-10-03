-- 月ごとの売上と前月比を出力するクエリ
WITH monthly_payment AS (
    SELECT
        DATE_TRUNC('month', payment_date) AS month_payment_date,
        SUM(amount) AS total_amount
    FROM payment
    GROUP BY month_payment_date
),
with_prev AS (
    SELECT
        month_payment_date,
        total_amount,
        LAG(total_amount) OVER (ORDER BY month_payment_date) AS prev_amount
    FROM monthly_payment
)
SELECT
    TO_CHAR(month_payment_date, 'YYYY-MM') AS month,
    total_amount,
    ROUND(
        (total_amount - prev_amount) / NULLIF(prev_amount, 0) * 100 , 2
    ) AS mom_pct
FROM with_prev
ORDER BY month_payment_date ASC;

SELECT
    DATE_TRUNC('month', payment_date) AS month,
    MIN(payment_date) AS first_payment,
    MAX(payment_date) AS last_payment,
    COUNT(*)          AS payment_count
FROM payment
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY month;
