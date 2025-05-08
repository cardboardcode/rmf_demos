FROM osrf/ros:jazzy-desktop-full

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    build-essential \
    ros-jazzy-rmf-dev \
    python3-colcon-common-extensions \
    && pip3 install flask-socketio fastapi uvicorn nudged --break-system-packages \
    && rm -rf /var/lib/apt/lists/*

RUN pip install fastapi --break-system-packages

# Copy over rmf_core ROS 2 package with utilities
WORKDIR /rmf_demo_ws/

# Fix for bug for lifts whose names are integers
WORKDIR /rmf_demo_ws/src
RUN git clone https://github.com/open-rmf/rmf_simulation.git --depth 1 --branch jazzy --single-branch
COPY rmf_demos rmf_demos
COPY rmf_demos_assets rmf_demos_assets
COPY rmf_demos_bridges rmf_demos_bridges
COPY rmf_demos_fleet_adapter rmf_demos_fleet_adapter
COPY rmf_demos_gz rmf_demos_gz
COPY rmf_demos_maps rmf_demos_maps
COPY rmf_demos_tasks rmf_demos_tasks
WORKDIR /rmf_demo_ws

# Build rmf_core
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
  && colcon build --merge-install

# Source rmf_core with standard /ros_entrypoint.sh.
RUN sed -i '$isource "/rmf_demo_ws/install/setup.bash"' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]