import pandas as pd
import streamlit as st

df = pd.DataFrame(
    {
        "商品": ["りんご", "みかん", "ぶどう", "もも"],
        "価格": [120, 80, 450, 300],
        "在庫": [30, 50, 10, 0],
    }
)

st.title("DataFrame連携")

st.write(df)  # なんでも表示できる万能型
st.dataframe(df)  # インタラクティブな表（ソート・検索・拡大ができる）
st.table(df)  # 静的な表（操作不可、全行がそのまま出る）


# 表示オプション
st.subheader("表示オプション")

st.dataframe(
    df,
    use_container_width=True,  # 横幅いっぱいに広げる
    hide_index=True,  # 左端のindex列を隠す
    column_config={
        "価格": st.column_config.NumberColumn("価格(円)", format="%d円"),
        "在庫": st.column_config.ProgressColumn(
            "在庫", min_value=0, max_value=50, format="%d個"
        ),
    },
)


# 絞り込み
st.subheader("絞り込み")

max_price = st.slider("価格の上限", min_value=0, max_value=500, value=500, step=10)
only_in_stock = st.checkbox("在庫ありのみ表示")

filtered = df[df["価格"] <= max_price]

if only_in_stock:
    filtered = filtered[filtered["在庫"] > 0]

st.dataframe(filtered, hide_index=True)
st.caption(f"{len(filtered)}件 / 全{len(df)}件")


# 表を編集する
st.subheader("表を編集する")

edited_df = st.data_editor(df, num_rows="dynamic", hide_index=True)

st.write("編集後の合計在庫:", int(edited_df["在庫"].sum()))

# CSVの読み込みとダウンロード
st.subheader("CSVの読み込みとダウンロード")

uploaded = st.file_uploader("CSVをアップロード", type="csv")

if uploaded is not None:
    up_df = pd.read_csv(uploaded)
    st.dataframe(up_df)

csv_bytes = edited_df.to_csv(index=False).encode("utf-8-sig")
st.download_button(
    "編集結果をCSVで保存", data=csv_bytes, file_name="edited.csv", mime="text/csv"
)
