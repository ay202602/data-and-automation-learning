# dvdrental テーブルと結合キー

既存の `practice/sql/practice/*.sql` で実際に使われている結合から確認できたもの。
ここに無いカラム名・テーブルは推測で書かず、不明なら「`\d テーブル名` で確認してください」と案内する。

## 結合の関係（確認済み）

| 結合 | キー | 確認元 |
|---|---|---|
| rental → customer | customer_id | dvdrental_country |
| customer → address | address_id | dvdrental_country |
| address → city | city_id | dvdrental_country |
| city → country | country_id | dvdrental_country |
| rental → inventory | inventory_id | dvdrental_top_rental_count |
| inventory → film | film_id | dvdrental_top_rental_count |
| payment → rental | rental_id | dvdrental_month_summary |
| payment → customer | customer_id | dvdrental_top_customer |
| actor → film_actor → film | actor_id / film_id | dvdrental_actor_summary |
| film → film_category → category | film_id / category_id | dvdrental_store_and_category_by_sales |
| inventory.store_id | 店舗（在庫が属する店） | dvdrental_store_and_category_by_sales |

## 確認済みカラム
- customer: customer_id, first_name, last_name, email, address_id
- rental: rental_id, rental_date, return_date, inventory_id, customer_id
- payment: payment_id, customer_id, rental_id, amount, payment_date
- inventory: inventory_id, film_id, store_id
- film: film_id, title, rental_duration（日数）, rental_rate
- category: category_id, name
- actor: actor_id, first_name, last_name
- country: country_id, country ／ city: city_id, country_id ／ address: address_id, city_id

## 注意点（学習者が迷いやすい所）
- 売上は `payment.amount`。レンタル回数は `rental` を数える（`payment` が無い貸出がありうるので、起点テーブルで結果が変わる）
- 店舗は `inventory.store_id` 経由（`rental` に直接 store_id はない）
- 全15テーブルのうち上記以外（staff, store, language 等）は未確認
