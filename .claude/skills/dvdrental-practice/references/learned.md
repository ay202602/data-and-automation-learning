# 学習済み構文リスト

`practice/sql/` の README・ノートブック・`.sql`（2026-10-29時点）から作成。
新しく習ったら1行追加する（ユーザーが承認したときのみ）。

## 基本（basic / SQLite）
- SELECT / FROM / ORDER BY / GROUP BY
- INSERT
- CASE
- INNER JOIN / LEFT JOIN
- 集計関数: SUM / MAX / MIN / AVG / COUNT
- strftime()（SQLite専用。PostgreSQLでは使わない）

## 実践（practice / PostgreSQL）
| 構文 | メモ | 初出ファイル |
|---|---|---|
| WITH（CTE） | 段階ごとに名前を付けて分ける | dvdrental_top_rental_count |
| JOIN ... USING(col) | 同名キーの結合 | dvdrental_country |
| JOIN ... ON | 異名キー／条件付き結合 | dvdrental_month_summary |
| RANK() OVER (ORDER BY ...) | 順位付け | dvdrental_country |
| NTILE(n) OVER (ORDER BY ...) | n分割のランク付け | dvdrental_customer_rank |
| LAG() OVER (ORDER BY ...) | 前の行の値を参照 | dvdrental_monthly_sales_summary |
| SUM() OVER () / SUM() OVER (PARTITION BY ...) | 全体合計・グループ内合計（構成比） | dvdrental_top_customer / dvdrental_store_and_category_by_sales |
| CASE WHEN / CASE col WHEN | 条件分岐 | dvdrental_customer_rank |
| DATE_TRUNC('month', col) | 月単位に切り捨て | dvdrental_month_summary |
| TO_CHAR(col, 'YYYY-MM') | 日付の文字列整形 | dvdrental_monthly_sales_summary |
| EXTRACT(DAY FROM ...) | 日付／間隔から要素を取り出す | dvdrental_late_returns |
| INTERVAL '1 day' | 期間型の計算 | dvdrental_late_returns |
| CONCAT() / `\|\|` | 文字列連結 | dvdrental_top_customer / dvdrental_actor_summary |
| ROUND(x, n) | 丸め | 複数 |
| NULLIF(a, b) | ゼロ除算の回避 | dvdrental_monthly_sales_summary |
| IS NULL / IS NOT NULL | NULL判定 | dvdrental_late_returns |
| NOT EXISTS（相関サブクエリ） | 存在しないものの抽出 | dvdrental_not_rental_inventory |
| LEFT JOIN ... WHERE 右側 IS NULL | 未結合の抽出 | dvdrental_not_rental_inventory |
| FETCH FIRST n ROWS WITH TIES | 同順位を含む上位n件 | dvdrental_top_rental_count |
| 列別名（AS）をGROUP BY/ORDER BYで使う | PostgreSQLの書き方 | 複数 |

## 未習（例・今後の候補）
- SUM() OVER (ORDER BY ...)（累計）、ROWS BETWEEN によるフレーム指定（移動平均）
- ROW_NUMBER() / DENSE_RANK() / LEAD() / FIRST_VALUE()
- HAVING、サブクエリ（IN / スカラー）、UNION / INTERSECT / EXCEPT
- COALESCE、FILTER (WHERE ...)、LATERAL、再帰CTE
- CROSS JOIN、generate_series、STRING_AGG

※「未習（例）」は照合の目安。ノートブック本文までは精査していないため、
　ユーザーが「それは習った」と言ったら上の表に移す。
