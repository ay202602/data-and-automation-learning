-- 一番レンタル数が多い作品はどこかを出力するクエリ
WITH top_rental AS (
    SELECT
        RANK() OVER(ORDER BY COUNT(f.film_id) DESC) AS rental_rank,
        f.title,
        COUNT(film_id) AS rental_count
    FROM rental AS r
    INNER JOIN inventory AS i USING(inventory_id)
    INNER JOIN film AS f USING(film_id)
    GROUP BY f.film_id, f.title
)
SELECT *
FROM top_rental
WHERE rental_rank = 1;

SELECT
    f.title,
    COUNT(film_id) AS rental_count
FROM rental AS r
INNER JOIN inventory AS i USING(inventory_id)
INNER JOIN film AS f USING(film_id)
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
FETCH FIRST 1 ROWS WITH TIES;