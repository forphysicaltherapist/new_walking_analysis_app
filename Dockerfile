# ベースイメージ
FROM python:3.10-slim

# 作業ディレクトリの設定
WORKDIR /app

# 必要なシステムパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        libx11-xcb1 \
        libxcb-dri3-0 \
        libxcb-present0 \
        libxcb-randr0 \
        libxcb-xfixes0 \
        libxcb-sync1 \
        libxcb-shape0 \
        libxcb-glx0 \
        libxkbcommon0 \
        mesa-utils \
        libgl1-mesa-dri \
        ffmpeg \
        wget \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Python パッケージのインストール
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# アプリのソースコードをコピー
COPY . /app

# アプリの起動
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]

