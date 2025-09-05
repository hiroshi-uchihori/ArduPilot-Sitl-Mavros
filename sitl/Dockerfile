FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 必要パッケージのインストール
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-wheel \
    build-essential \
    wget \
    curl \
    unzip \
    libtool \
    autoconf \
    automake \
    pkg-config \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Python モジュール（MAVProxy と extras）
RUN pip3 install --no-cache-dir \
    future \
    pexpect \
    pymavlink \
    empy==3.3.4 \
    "MAVProxy[extras]"

# ArduPilot クローン
RUN git clone https://github.com/ArduPilot/ardupilot.git /ardupilot
WORKDIR /ardupilot
RUN git submodule update --init --recursive

# PATH に追加
ENV PATH="/ardupilot/Tools/autotest:${PATH}"

# SITL ビルド（Docker build 時に実行）
RUN ./waf configure --board sitl && ./waf build

COPY locations.txt /ardupilot/Tools/autotest/locations.txt

# 起動スクリプトをコピー
COPY start_sitl.sh /start_sitl.sh
RUN chmod +x /start_sitl.sh

ENTRYPOINT ["/start_sitl.sh"]


