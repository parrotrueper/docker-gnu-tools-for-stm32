#!/usr/bin/env bash
# Build the GNU Tools Arm Embedded toolchain Docker image on Debian Trixie

set -e

IMAGE_NAME="gnu-tools-for-stm32"
DOCKERFILE_PATH="./Dockerfile"

# Build the Docker image

echo "Building Docker image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" .

echo "Build complete. Image tagged as $IMAGE_NAME"
