FROM ros:noetic
ARG ROBOT_PROJECT_FOLDER
ARG ROBOT_FILENAME

# Install xacro and any other dependencies you might need
RUN apt-get update && apt-get install -y \
    ros-noetic-xacro \
    && rm -rf /var/lib/apt/lists/*

# Create a workspace
RUN mkdir -p /home/ros/catkin_ws/src
WORKDIR /home/ros/catkin_ws

# Initialize the catkin workspace
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin_init_workspace src'

# Build the workspace
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /home/ros/catkin_ws; catkin_make'

# Source the workspace in .bashrc for interactive bash sessions
RUN echo "source /home/ros/catkin_ws/devel/setup.bash" >> ~/.bashrc


COPY ${ROBOT_PROJECT_FOLDER} /home/ros/catkin_ws/src/${ROBOT_PROJECT_FOLDER}
COPY ${ROBOT_PROJECT_FOLDER}/${ROBOT_FILENAME} /home/ros/catkin_ws/src/${ROBOT_PROJECT_FOLDER}/


# Copy your startup script into the container
COPY start.sh /start.sh

# Give execution rights on the start script
RUN chmod +x /start.sh

# Use start.sh to start ROS master and RViz (or your application)
CMD ["/start.sh"]
