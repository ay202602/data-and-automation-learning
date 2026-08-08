-- 一番レンタル数が多い国はどこかを出力するクエリ
SELECT 
    RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS rental_rank,
    co.country, 
    COUNT(r.rental_id) AS rental_count
FROM rental AS r
INNER JOIN customer USING(customer_id)
INNER JOIN address  USING(address_id)
INNER JOIN city     USING(city_id)
INNER JOIN country AS co USING(country_id)
GROUP BY co.country
ORDER BY rental_rank ASC;