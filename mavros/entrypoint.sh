#!/bin/bash
set -e

# ROS 2 環境をソース
source /opt/ros/humble/setup.bash

# SITL が起動するまで待つ（簡易）
echo "Waiting 5 seconds for SITL..."
sleep 5

# IP アドレスを環境変数から取得。指定がなければデフォルト値
FCU_IP=${FCU_IP:-tcp://ardupilot-sitl:5760}  # SITLから受信
GCS_IP=${GCS_IP:-192.168.11.47}   

# MAVROS 起動
ros2 run mavros mavros_node --ros-args \
    -p fcu_url:="$FCU_IP" \
    -p gcs_url:="udp://0.0.0.0:14551@$GCS_IP:14550"