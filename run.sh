#!/bin/bash
cd $(dirname $0)
BAG_NAME="$1"
if [ -z ${BAG_NAME} ]; then
    echo "Please input bag name.";exit
fi

if [ "${BAG_NAME##*.}"x != "bag"x ]; then
    echo "File <${BAG_NAME}> is not a bag.";exit
fi
if [ ! -s $1 ];then
    echo "File <${BAG_NAME}> doesn't Exist.";exit
fi

echo "using bag: ${BAG_NAME}"
xhost +

tmux kill-session -t loam
tmux new -d -s loam -n w0
tmux set -g mouse on
tmux split -h -t loam:w0
tmux split -v -t loam:w0.0

tmux send -t loam:w0.0 "docker run -it --rm --name loam \
    --device /dev/dri \
    --env "DISPLAY=$DISPLAY" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(pwd)/results:/data/aloam/results/s \
    -v $(pwd)/${BAG_NAME}:/data/aloam/test.bag \
    loam:latest" ENTER
tmux send -t loam:w0.0 "
    source devel/setup.bash \
    && roslaunch aloam_velodyne aloam_velodyne_VLP_16.launch" ENTER

sleep 1

tmux send -t loam:w0.1 "docker exec -it loam bash" ENTER
tmux send -t loam:w0.1 "
    source devel/setup.bash \
    && rosbag play test.bag" ENTER

sleep 1
tmux send -t loam:w0.2 "docker exec -it loam bash" ENTER
tmux send -t loam:w0.2 "
    source devel/setup.bash \
    && cd results \
    && rosrun pcl_ros pointcloud_to_pcd input:=/laser_cloud_map"
    s
tmux a -t loam

