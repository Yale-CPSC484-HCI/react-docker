# build docker container with dockerfile in current directory
# usage: build_container.sh <image_name> (e.g., build_container.sh react-env:latest)
#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $0 <image_name>"
  exit 1
fi
IMAGE_NAME=$1
docker build --pull --rm -f ./Dockerfile -t $IMAGE_NAME .
