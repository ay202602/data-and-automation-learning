# 目的
- データ分析・業務自動化を学ぶ（現在はPython、SQLを学習中）

# 回答方針
- 新しいライブラリを使うときは初学者向けにわかりやすく説明する
- 提案コードが長くなる場合は、ブロックごとにわかりやすく提案する
- 手打ちでのコーディングを重視するため、コードは提案のみとどめる
- 提案コードはなぜそう書くのか要点をまとめて説明する
- pytestを提案するときは、fixtureなどの概念も初学者向けに説明する

# リポジトリ構成
- `practice/` : ライブラリ別の練習コード（pandas, matplotlib, seaborn, openpyxl, sql）
- `practice/sql/basic/` : SQLの基礎ノートブック
- `practice/sql/practice/` : dvdrental（PostgreSQL）を使ったクエリ練習
- `data/`, `excelfiles/` : 練習用データ置き場（コミットしない。出典は e-Stat、取得手順は各フォルダのREADME参照）
- `daily/` : 過去の学習記録。2026-08-28で運用終了しているため編集しない

# 環境
- Windows 11 / PowerShell
- 仮想環境は `.venv`、依存ライブラリは `requirements.txt` で管理

# 規約
- Pythonファイル名は `ライブラリ名_内容.py`（snake_case）
- SQLファイル名は `dvdrental_内容.sql`
- コメントは日本語で書いてよい
- `data/` と `excelfiles/` のファイルは勝手に変更しない
- ファイルのリネームや削除は、指示があるまで提案のみにとどめる（例：`seabrorn_barplot.py` はスペルミスの可能性あり）

# コミット規約
- 形式は `add:` / `docs:` などのプレフィックス＋日本語
- 本文に「概要」として箇条書きで学んだ内容を書く（学習記録は daily ではなくコミットメッセージに残す方針）
