FROM osrf/ros:noetic-desktop-focal
COPY ./aloam_ws/ /data/aloam/
# COPY ./entrypoint.sh /entrypoint.sh
WORKDIR /data/aloam/
RUN sed -i 's@http://archive.ubuntu.com/ubuntu/@http://mirrors.tuna.tsinghua.edu.cn/ubuntu/@g' /etc/apt/sources.list \
    && sed -i 's@deb http://security.ubuntu.com/ubuntu/@# deb http://security.ubuntu.com/ubuntu/@g' /etc/apt/sources.list \
    && sed -i 's@http://packages.ros.org/ros/ubuntu@http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu@g' /etc/apt/sources.list.d/ros1-latest.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends libpcl-dev libceres-dev ros-noetic-pcl-conversions ros-noetic-pcl-ros tmux \
    && rm -rf /var/lib/apt/lists/* 
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc \
    && echo "set -g mouse on" >> /root/.tmux.conf
RUN bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

