# 基于ros-noetic,ubuntu20.04的alom镜像

## 1.准备

下载文件
```bash
git clone https://github.com/Lavinci/aloam-docker.git
```
Download [一个可用的bag](https://drive.google.com/file/d/1s05tBQOLNEDDurlg48KiUWxCp-YqYyGH/view)

在目录下运行
```bash
docker build -t loam .
```

## 2.运行
将倒数第二行的<path_to_your_bag>替换为你自己的
```bash
docker run -it --rm \
--device /dev/dri \
--env "DISPLAY=$DISPLAY" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v <path_to_your_bag>.bag:/data/aloam/test.bag \
loam:latest bash
```
进入容器后
```bash
rosbag play test.bag
```
![picture](assert/screenshot.png)
