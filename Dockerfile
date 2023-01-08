FROM osrf/ros:noetic-desktop-focal

COPY ./aloam_ws/ /data/aloam/
COPY ./entrypoint.sh /entrypoint.sh
WORKDIR /data/aloam/
SHELL ["/bin/bash", "-c"]
RUN set -x \
    && buildDeps="libpcl-dev libceres-dev ros-noetic-pcl-conversions tmux" \
    && sed -i 's/archive.ubuntu.com/mirrors.nju.edu.cn/g' /etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ focal main" > /etc/apt/sources.list.d/ros1-latest.list \
#    && sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && source /opt/ros/noetic/setup.sh \
    && catkin_make \
    && rm -rf /var/lib/apt/lists/*
#    && apt-get purge -y --auto-remove $buildDeps 
ENTRYPOINT ["/entrypoint.sh"]

