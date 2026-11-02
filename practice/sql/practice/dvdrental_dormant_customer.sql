-- 最新の貸出日から90日以上貸出がない有効顧客を割り出すクエリ
-- 基準日はデータ全体の最新貸出日（CURRENT_DATE ではない）
-- 一度も貸出のない顧客は対象外
WITH final_rental_date AS (
    SELECT
        r.customer_id,
        MAX(r.rental_date) AS max_rental_date
    FROM rental AS r
    GROUP BY r.customer_id
),
reference_date AS (
    SELECT
        frd.customer_id,
        frd.max_rental_date,
        MAX(frd.max_rental_date) OVER () AS reference_rental_date
    FROM final_rental_date AS frd
)
SELECT
    rd.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    rd.max_rental_date,
    EXTRACT(DAY FROM (rd.reference_rental_date - rd.max_rental_date)) AS number_of_days
FROM reference_date AS rd
JOIN customer AS c USING(customer_id)
WHERE
    (rd.reference_rental_date - rd.max_rental_date) >= INTERVAL '90 days'
    AND c.activebool
ORDER BY number_of_days DESC;

SELECT *
FROM customer LIMIT 5;

SELECT *
FROM rental LIMIT 5;

SELECT
    MIN(rental_date) AS min_rental_date,
    MAX(rental_date) AS max_rental_date
FROM rental;

