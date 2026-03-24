#!/bin/bash

IMAGE="anandrajsingh/nodeapp:latest"
CONTAINER_NAME="nodeapp"

echo "Logging into Docker Hub..."
echo "$DOCKER_HUB_TOKEN" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin

echo "Stopping old container..."
docker stop $CONTAINER_NAME || true

echo "Removing old container..."
docker rm $CONTAINER_NAME || true

echo "Starting new container..."
docker run -d \
  --name $CONTAINER_NAME \
  --pull=always \
  -p 3000:3000 \
  $IMAGE

echo "Deployment complete!"