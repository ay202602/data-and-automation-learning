-- 返却遅延の一覧を表示するクエリ
WITH customer_rental AS (
    SELECT
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.email,
        f.title,
        (r.return_date - r.rental_date) AS rental_period,
        (f.rental_duration * INTERVAL '1 day') AS authorized_period
    FROM customer AS c
    INNER JOIN rental AS r USING(customer_id)
    INNER JOIN inventory USING(inventory_id)
    INNER JOIN film AS f USING(film_id)
    WHERE r.return_date IS NOT NULL
)
SELECT
    cr.customer_name,
    cr.email,
    cr.title,
    EXTRACT(DAY FROM (cr.rental_period - cr.authorized_period)) AS rental_delay
FROM customer_rental AS cr
WHERE (cr.rental_period - cr.authorized_period) >= INTERVAL '1 day'
ORDER BY rental_delay DESC, cr.customer_name ASC;
