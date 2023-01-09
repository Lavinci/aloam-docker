# 基于ros-noetic,ubuntu20.04的alom镜像
---
## 准备
默认已安装docker

[一个可用的bag](https://drive.google.com/file/d/1s05tBQOLNEDDurlg48KiUWxCp-YqYyGH/view)

## 安装
下载
git clone https://github.com/Lavinci/aloam-docker.git

在目录下运行
```bash
docker build -t loam .
```

## 运行
将倒数第二行的<your_bag>替换为你自己的
```bash
docker run -it --rm \
--device /dev/dri \
--env "DISPLAY=$DISPLAY" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /home/lavinci/Desktop/loam/<your_bag.bag>:/data/aloam/test.bag \
loam:latest bash
```
进入容器后会自动播放 test.bag
![show](assert/screenshot.png)
