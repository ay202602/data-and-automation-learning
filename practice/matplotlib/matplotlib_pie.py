import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

"""東海地方（1975~2020年度すべて）の労働力人口を割合で表示する"""
# データ出典：総務省統計局「労働力調査」（e-Stat）
# 取得データ：調査年,地域,労働力人口,労働力人口（男）,労働力人口（女）,就業者数,就業者数（男）,就業者数（女）
# 調査年：1975~2020年度

# グラフの文字化け防止（日本語表示）
plt.rcParams["font.family"] = "MS Gothic"

FILE_PATH = Path(__file__).parent.parent / "data" / "FEI_PREF_260525140950.csv"

df = pd.read_csv(FILE_PATH, thousands= ",")
print(df.dtypes)

labor = df.groupby("地域")["労働力人口"].sum()
print(f"\n{labor.map("{:,.0f}".format)}")

#労働力人口数と割合を表示する関数を作成
def make_label(ratio: float) -> str:
    value = ratio * labor.sum() / 100
    return f"{value:,.0f}人\n{ratio:.1f}%"
    
labor.plot(kind="pie", autopct=make_label) 
plt.title("1975～2020年度までの東海地方の労働力人口数（割合）")
plt.tight_layout()
plt.ylabel("")
plt.show()

