#!/usr/bin/env bash

xhost +local:docker

docker run -it --rm \
  --name rmf_demos_c \
  --network=host \
  -e DISPLAY=$DISPLAY \
  -v /dev/shm:/dev/shm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e RCUTILS_COLORIZED_OUTPUT=1 \
  -e GZ_SIM_RESOURCE_PATH=/rmf_demo_ws/src/rmf_demos_assets/models \
  -e GZ_SIM_SYSTEM_PLUGIN_PATH=/rmf_demo_ws/install/lib:/rmf_demo_ws/install/lib/rmf_building_sim_gz_plugins:/rmf_demo_ws/install/lib/rmf_robot_sim_gz_plugins \
  -e GZ_GUI_PLUGIN_PATH=/rmf_demo_ws/install/lib/rmf_building_sim_gz_plugins \
  rmf_demos:rolling bash -c \
  "source /ros_entrypoint.sh && \
  ros2 launch rmf_demos_gz office.launch.xml"