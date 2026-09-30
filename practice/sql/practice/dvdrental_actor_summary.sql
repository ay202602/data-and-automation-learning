-- 各俳優陣の出演回数を集計するクエリ
SELECT 
    actor_id,
    first_name || ' ' || last_name  AS actor_name,
    COUNT(film_id) AS film_count,
    ROUND(AVG(rental_rate), 2) AS avg_rental_rate
FROM actor
LEFT JOIN film_actor USING(actor_id)
LEFT JOIN film USING(film_id)
GROUP BY actor_id, first_name, last_name
ORDER BY film_count DESC;

