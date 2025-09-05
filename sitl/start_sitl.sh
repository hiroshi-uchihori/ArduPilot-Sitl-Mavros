#!/bin/bash
set -e

# パラメータファイルを作成
#mkdir -p /ardupilot/params
#echo -e "ARMING_CHECK 0\nPREARM_CHECK 0" > /ardupilot/params/rover_noarm.parm

cd /ardupilot

# SITL 起動（MAVProxyなし、sim_vehicle.sh互換モード）
sim_vehicle.py -L Ioujima \
  -v ArduCopter -f quad  \
  --no-rebuild "$@" \
  -C --no-mavproxy \
  --out=udp:mavros:14553 
