# Run container with specified image name and interactive terminal
# usage: run_container.sh <image_name> (e.g., run_container.sh react-env:latest)
#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <image_name>"
  exit 1
fi
IMAGE_NAME=$1

# Export DISPLAY so GUI applications inside the container can show on the host.
# Docker Desktop on macOS does not support --net=host, so we use host.docker.internal instead.
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Running on macOS, setting up XQuartz for GUI applications..."
    echo "Make sure XQuartz is installed, running, and has 'Allow connections from network clients' enabled."
    xhost + 127.0.0.1
    MYDISPLAY=host.docker.internal:0
    DOCKER_ARGS=(--rm -it -e DISPLAY="$MYDISPLAY" --add-host=host.docker.internal:host-gateway)
else
    echo "Running on Linux, setting up X11 for GUI applications..."
    xhost +local:docker
    MYDISPLAY=${DISPLAY:-:0}
    DOCKER_ARGS=(--rm -it --net=host -e DISPLAY="$MYDISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix)
fi

echo "Running container with image: $IMAGE_NAME"
docker run "${DOCKER_ARGS[@]}" "$IMAGE_NAME"