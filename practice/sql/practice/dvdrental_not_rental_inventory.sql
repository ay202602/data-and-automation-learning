-- 一度も貸し出されていない作品を抽出するクエリ
WITH rental_stock AS (
    SELECT
        f.film_id,
        f.title,
        c.name AS film_category,
        COUNT(i.inventory_id) AS stock
    FROM category AS c
    INNER JOIN film_category AS fc  USING(category_id)
    INNER JOIN film          AS f   USING(film_id)
    INNER JOIN inventory     AS i   USING(film_id)
    GROUP BY f.film_id, f.title, c.name
),
not_rental_exists AS (
    SELECT
        rs.film_id,
        rs.title,
        rs.film_category,
        rs.stock
    FROM rental_stock AS rs
    WHERE NOT EXISTS (
        SELECT 1
        FROM inventory AS i
        INNER JOIN rental AS r USING(inventory_id)
        WHERE i.film_id = rs.film_id
    )
)
SELECT
    nre.title,
    nre.film_category,
    nre.stock
FROM not_rental_exists AS nre;

SELECT i.inventory_id, i.film_id
FROM inventory AS i
LEFT JOIN rental AS r USING(inventory_id)
WHERE r.rental_id IS NULL;
