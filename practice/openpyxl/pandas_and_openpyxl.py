# pandasとopenpyxlの併用プログラム
import pandas as pd
import openpyxl as px
from openpyxl.styles import Border, Side, PatternFill
from pathlib import Path

# 親ディレクトリ内のexcelfilesのパスを取得（3階層上）
EXCEL_FILE_PATH = (
    Path(__file__).resolve().parents[2] / "excelfiles" / "output" / "output_pandas.xlsx"
)

# ヘッダー部分：名前・点数
# 値：リストの中身
df = pd.DataFrame(
    {
        "名前": ["Aさん", "Bさん", "Cさん", "Dさん", "Eさん"],
        "点数": [100, 23, 41, 96, 56],
    }
)

SHEET_NAME = "Result"

with pd.ExcelWriter(EXCEL_FILE_PATH, engine="openpyxl") as writer:
    df.to_excel(writer, sheet_name=SHEET_NAME, index=False)

wb = px.load_workbook(EXCEL_FILE_PATH)
ws = wb[SHEET_NAME]

BORDER_STYLE = "thin"

thin_border = Border(
    left=Side(style=BORDER_STYLE),
    right=Side(style=BORDER_STYLE),
    top=Side(style=BORDER_STYLE),
    bottom=Side(style=BORDER_STYLE),
)

for row in ws.iter_rows(min_row=1, max_row=len(df) + 1, min_col=1, max_col=2):
    for cell in row:
        cell.border = thin_border

# DDEBF7 = 薄い青色
SET_COLOR = "DDEBF7"

header_fill = PatternFill(start_color=SET_COLOR, end_color=SET_COLOR, fill_type="solid")
for cell in ws[1]:
    cell.fill = header_fill

wb.save(EXCEL_FILE_PATH)
