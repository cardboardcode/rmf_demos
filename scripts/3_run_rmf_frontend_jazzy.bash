#!/usr/bin/env bash

script_dir="$(dirname "$(realpath "$0")")"

google-chrome http://localhost:3000 >/dev/null 2>&1 &

echo "Initialising [RMF Dashboard] docker container @ http://localhost:3000/dashboard"
echo "Initialising [RMF API Server] docker container @ http://localhost:8000/docs"

echo "Removing docker containers:"
docker container rm rmf_web_rmf_server_demo_c rmf_web_dashboard_demo_c

docker compose -f ${script_dir}/rmf_dashboard_server_jazzy_docker-compose.yaml up

unset script_dir
