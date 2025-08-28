#!/bin/bash
set -e

# パラメータファイルを作成
#mkdir -p /ardupilot/params
#echo -e "ARMING_CHECK 0\nPREARM_CHECK 0" > /ardupilot/params/rover_noarm.parm

cd /ardupilot

export SIM_HOME_LAT=32.6976
export SIM_HOME_LON=129.7823
export SIM_HOME_ALT=10
export SIM_HOME_HEADING=0

# SITL 起動（MAVProxyなし、sim_vehicle.sh互換モード）
sim_vehicle.py -v ArduCopter -f quad  \
  --no-rebuild "$@" \
  -C --no-mavproxy \
  --out=udp:mavros:14553 
