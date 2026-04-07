# Run container with specified image name and interactive terminal
# Usage: run_container.sh <image_name> <directory-to-bind> <port-to-bind> (e.g., run_container.sh react-env:latest)
# The optional arguments allow you to bind a local directory with a react app to /app in the container and specify a port to bind for the Vite development server. If no port is provided, it defaults to 5173. 
# Note that the app must be run as "npm run dev -- --host 0.0.0.0" for the app to be accessible from the host machine at http://127.0.0.1:<port-to-bind>.
#!/bin/bash
set -e # exit if any error comes up!

if [ -z "$1" ]; then
  echo "Usage: $0 <image_name> <directory-to-bind> <port-to-bind>"
  exit 1
fi
IMAGE_NAME=$1

# optional arguments
BIND_DIRECTORY=$2
PORT_TO_BIND=$3

# set default port to bind to 5173 if not provided
if [ -z "$PORT_TO_BIND" ]; then
  PORT_TO_BIND=5173
fi


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

# check if the bind directory exists
if [ ! -d "$BIND_DIRECTORY" ]; then
  echo "Error: Directory '$BIND_DIRECTORY' does not exist."
  exit 1
else
  # add the bind directory to the docker arguments
  # and expose port 5173 for Vite development server 
  # once the container is running with "npm run dev -- --host 0.0.0.0", you can access the Vite server at http://127.0.0.1:5173 on your host machine
  DOCKER_ARGS+=(-v "$BIND_DIRECTORY":/app:rw --workdir /app -p 127.0.0.1:$PORT_TO_BIND:$PORT_TO_BIND)
fi

echo "Running container with image: $IMAGE_NAME"
docker run "${DOCKER_ARGS[@]}" "$IMAGE_NAME"