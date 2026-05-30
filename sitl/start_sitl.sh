#!/bin/bash
set -e

# パラメータファイルを作成
#mkdir -p /ardupilot/params
#echo -e "ARMING_CHECK 0\nPREARM_CHECK 0" > /ardupilot/params/rover_noarm.parm

echo "[SITL] Waiting for Gazebo ArduPilotPlugin UDP port 9002..."

# Gazebo の ArduPilotPlugin が UDP 9002 を開くまで待つ
# docker-compose の depends_on は「起動順」だけで、準備完了までは待たないため
while ! ss -lun | grep -q "127.0.0.1:9002"; do
  sleep 1
done

echo "[SITL] Gazebo UDP port 9002 detected."
echo "[SITL] Starting ArduPilot SITL with Gazebo JSON interface..."

cd /ardupilot

# SITL 起動（MAVProxyなし、sim_vehicle.sh互換モード）
#sim_vehicle.py -L Ioujima \
#  -v Rover \
#  -f Boat \
#  --no-rebuild "$@" \
#  -C --no-mavproxy \
#  --out=udp:mavros:14553 
sim_vehicle.py \
  -v ArduCopter \
  -f gazebo-iris \
  --model JSON \
  --no-rebuild \
  --no-mavproxy \
  --out=udp:127.0.0.1:14550
