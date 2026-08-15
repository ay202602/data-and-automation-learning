# xlsxファイルにデータ入力・表を作成するプログラム
import openpyxl as px
from openpyxl.styles import Border, Side, PatternFill
from pathlib import Path

DATA_PATH = Path(__file__).parent / "excelfiles"

wb = px.Workbook()
ws = wb.active
ws.title = "data"

data = [
    ["名前", "部署", "役職", "雇用形態"],
    ["Aさん", "営業部", "主任", "正社員"],
    ["Bさん", "総務部", "なし", "パート"],
    ["Cさん", "営業部", "係長", "正社員"],
    ["Dさん", "開発部", "課長", "正社員"],
    ["Eさん", "総務部", "なし", "契約社員"],
]

for row in data:
    ws.append(row)

thin_border = Border(
    left=Side(style="thin"),
    right=Side(style="thin"),
    top=Side(style="thin"),
    bottom=Side(style="thin"),
)

for row in ws.iter_rows(min_row=1, max_row=len(data), min_col=1, max_col=4):
    for cell in row:
        cell.border = thin_border

# DDEBF7 = 薄い水色
header_fill = PatternFill(start_color="DDEBF7", end_color="DDEBF7", fill_type="solid")

# ws[1] = 1行目全体を取得
header_row = ws[1]

for cell in header_row:
    cell.fill = header_fill

wb.save(DATA_PATH / "output_data.xlsx")
