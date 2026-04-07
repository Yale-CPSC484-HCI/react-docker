# Run container with specified image name and interactive terminal
# usage: run_container.sh <image_name> (e.g., run_container.sh react-env:latest)
#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $0 <image_name>"
  exit 1
fi
IMAGE_NAME=$1

# export DISPLAY variable to allow GUI applications to display on the host
# we do this in slightly different ways based on whether we are in OSX or Ubuntu, since the way Docker handles networking is different on these platforms
# first, let's check if environment is OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
    # in OSX, you problable need to install XQuartz and allow connections from network clients (XQuartz > Preferences > Security > check "Allow connections from network clients")
    # XQuartz can be installed with: $ brew install --cask xquartz (and then adding export PATH="/opt/X11/bin:$PATH" to your .bash_profile or .zshrc)
    # or by downloading it from https://www.xquartz.org/
    xhost +localhost
    export MYDISPLAY=host.docker.internal:0
else
    # for Ubuntu, use the local IP address of the host
    xhost +local:docker
    export MYDISPLAY=$DISPLAY
fi

# -it starts interactive session
# -net=host allows the container to use the host's network stack, which is necessary for ROS communication
# -rm automatically removes the container when it exits, keeping your system clean
# -e DISPLAY=$MYDISPLAY passes the host's DISPLAY environment variable to the container, allowing GUI applications to display on the host
# -v /tmp/.X11-unix:/tmp/.X11-unix mounts the X11 socket from the host to the container, enabling GUI applications to communicate with the X server on the host
docker run -it --net=host --rm \
    -e DISPLAY=$MYDISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    $IMAGE_NAME