-- 優良顧客トップ10を出力するクエリ
WITH customer_summary AS (
    SELECT
        CONCAT(cu.first_name, ' ', cu.last_name) AS customer_name,
        co.country,
        SUM(p.amount) AS total_amount
    FROM country AS co
    INNER JOIN city AS ci       USING(country_id)
    INNER JOIN address          USING(city_id)
    INNER JOIN customer AS cu   USING(address_id)
    INNER JOIN payment AS p     USING(customer_id)
    GROUP BY p.customer_id, co.country, customer_name
),
amount_summary AS(
    SELECT
        cs.customer_name,
        cs.country,
        cs.total_amount,
        ROUND(cs.total_amount / SUM(cs.total_amount) OVER() * 100, 2) AS amount_pct
    FROM customer_summary AS cs
),
customer_rank AS(
    SELECT
        RANK() OVER(ORDER BY ams.total_amount DESC) AS amount_rank,
        ams.customer_name,
        ams.country,
        ams.total_amount,
        ams.amount_pct
    FROM amount_summary AS ams
)
SELECT *
FROM customer_rank
WHERE amount_rank <= 10
ORDER BY amount_rank ASC;