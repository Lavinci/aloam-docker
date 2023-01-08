#!/bin/bash
set -e
# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
cd /data/aloam/
source devel/setup.bash
(roslaunch aloam_velodyne aloam_velodyne_VLP_16.launch)&  rosbag play test.bag
exec "$@"

