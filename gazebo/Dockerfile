FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    curl lsb-release gnupg git cmake build-essential \
    && rm -rf /var/lib/apt/lists/*

# OSRF / Gazebo repository
RUN curl https://packages.osrfoundation.org/gazebo.gpg \
    --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] \
    http://packages.osrfoundation.org/gazebo/ubuntu-stable \
    $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/gazebo-stable.list

RUN apt update && apt install -y \
    protobuf-compiler \
    libprotobuf-dev \
    libgz-sim8-dev \
    libgz-transport13-dev \
    rapidjson-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libopencv-dev \
    libdebuginfod1 \
    gz-harmonic \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/hiro

RUN git clone https://github.com/ArduPilot/ardupilot_gazebo.git && \
    cd ardupilot_gazebo && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

ENV GZ_SIM_SYSTEM_PLUGIN_PATH=/root/ardupilot_gazebo/build
ENV GZ_SIM_RESOURCE_PATH=/root/ardupilot_gazebo/models:/root/ardupilot_gazebo/worlds

CMD ["gz", "sim", "-v4", "-r", "-s", "/root/ardupilot_gazebo/worlds/iris_runway.sdf"]