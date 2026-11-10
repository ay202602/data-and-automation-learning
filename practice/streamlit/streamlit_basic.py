import streamlit as st

# 表示
st.title("タイトル")
st.header("ヘッダー")
st.write("こんにちは")
st.markdown("**太字** や `コード` が使える")

# ボタン設置
st.header("ボタン")

if st.button("押してみて"):
    st.success("ボタンが押されました")

# 入力フォーム
st.header("入力")

name = st.text_input("名前を入力してください")
age = st.slider("年齢", min_value=0, max_value=100, value=20)
color = st.selectbox("好きな色", ["赤", "青", "緑"])
agree = st.checkbox("同意する")

# バリデーション、チェックボックス条件でボタン押下できる
if st.button("送信", disabled=not agree):
    cleaned_name = name.strip()

    if not cleaned_name:
        st.error("名前を入力してください")
    elif len(cleaned_name) > 20:
        st.error("名前は20文字以内で入力してください")
    elif not cleaned_name.replace(" ", "").isalpha():
        st.error("名前に数字や記号は使えません")
    else:
        st.write(f"{name}さん({age}歳)、好きな色は{color}ですね")


# 列の配置
st.header("レイアウト")

col1, col2, col3 = st.columns(3)
with col1:
    st.write("左の列")
    st.button("左ボタン")
with col2:
    st.write("真ん中の列")
    st.button("真ん中ボタン")
with col3:
    st.write("右の列")
    st.button("右のボタン")

# サイトバー
st.sidebar.title("サイドバー")
st.sidebar.write("ここにメニューなどを置けます")
