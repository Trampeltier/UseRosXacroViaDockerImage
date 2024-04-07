#!/bin/bash

# Validate inputs
if [ -z "${ROBOT_PROJECT_FOLDER}" ] || [ -z "${ROBOT_FILENAME}" ]; then
  echo "ROBOT_PROJECT_FOLDER and ROBOT_FILENAME must be set."
  exit 1
fi


# Source the ROS setup and workspace
source /opt/ros/noetic/setup.bash
source /home/ros/catkin_ws/devel/setup.bash

xacro /home/ros/catkin_ws/src/${ROBOT_PROJECT_FOLDER}/${ROBOT_FILENAME} > /home/share/output_of_${ROBOT_FILENAME}.urdf


