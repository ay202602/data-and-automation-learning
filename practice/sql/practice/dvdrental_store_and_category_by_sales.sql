-- 店舗ごとにどのカテゴリで稼いでいるか比較するクエリ
WITH store_and_category AS (
    SELECT
        i.store_id, 
        c.name AS category,
        SUM(p.amount) AS sales
    FROM payment AS p
    INNER JOIN rental AS r          USING(rental_id)
    INNER JOIN inventory AS i       USING(inventory_id)
    INNER JOIN film_category AS fc  USING(film_id)
    INNER JOIN category AS c        USING(category_id)
    GROUP BY i.store_id, c.name
),
store_total_sales AS (
    SELECT
        sac.store_id,
        sac.category,
        sac.sales,
        SUM(sac.sales) OVER (PARTITION BY sac.store_id) AS store_total
    FROM store_and_category AS sac
),
store_composition_ratio AS (
    SELECT
        sts.store_id,
        sts.category,
        sts.sales,
        sts.store_total,
        ROUND(sts.sales / sts.store_total * 100, 2) AS store_ratio
    FROM store_total_sales AS sts
)
SELECT
    scr.store_id,
    scr.category,
    scr.sales,
    scr.store_ratio
FROM store_composition_ratio AS scr
ORDER BY scr.store_id ASC, scr.sales DESC;
