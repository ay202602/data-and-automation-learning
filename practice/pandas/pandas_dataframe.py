import pandas as pd

# values = データ本体
# columns = 列名（列ラベル）
# index = 行名（行ラベル）

df = pd.DataFrame({
    "名前": ["A", "B", "C", "D", "E"],
    "年齢": ["20","18","45", "32", "34"],
    "部署": ["総務", "経理", "営業", "庶務", "開発"]},
    index= ["a001", "a002", "a003", "a004", "a005"]
)


print(f"\n{df}")
print(f"\n{df.values}")
print(f"\n{df.columns}")
print(f"\n{df.index}")
print(f"\n{df["名前"]}")
print(f"\n{df["年齢"]}")
print(f"\n{df["部署"]}")
print(f"\npandas version  {pd.__version__}")
