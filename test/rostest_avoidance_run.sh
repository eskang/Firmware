#! /bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PX4_SRC_DIR=${DIR}/..

source /opt/ros/kinetic/setup.bash
mkdir -p ${PX4_SRC_DIR}/catkin_ws/src
cd ${PX4_SRC_DIR}/catkin_ws/
git clone --depth=1 https://github.com/PX4/avoidance.git src/avoidance/

catkin init
catkin build local_planner --cmake-args -DCMAKE_BUILD_TYPE=Release

source ${PX4_SRC_DIR}/catkin_ws/devel/setup.bash
source /usr/share/gazebo/setup.sh

export CATKIN_SETUP_UTIL_ARGS=--extend
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:${PX4_SRC_DIR}/catkin_ws/src/avoidance/sim/models
export GAZEBO_RESOURCE_PATH=$GAZEBO_RESOURCE_PATH:${PX4_SRC_DIR}/catkin_ws/src/avoidance/sim/worlds

source $DIR/rostest_px4_run.sh "$@"

