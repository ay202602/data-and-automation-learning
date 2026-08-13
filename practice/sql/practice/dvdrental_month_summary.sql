SELECT
    DATE_TRUNC('month', rental_date) AS rental_month,
    COUNT(p.rental_id),
    ROUND(SUM(p.amount), 1) AS total_amount
FROM rental AS r
INNER JOIN payment AS p ON r.rental_id = p.rental_id
INNER JOIN customer AS c ON r.customer_id = c.customer_id
GROUP BY rental_month
ORDER BY rental_month ASC;

