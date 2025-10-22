#!/bin/bash
set -e

# Usage: ./build.sh <branch_name>

IMAGE_NAME="react-static-app"
DEV_IMAGE="bakialakshmi/dev:$BRANCH_NAME"
PROD_IMAGE="bakialakshmi/prod:$BRANCH_NAME"

echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .

# Docker Login (non-interactive mode for Jenkins)
echo "Logging in to Docker Hub..."

if [ "$BRANCH_NAME" == "dev" ]; then
    echo "Tagging and pushing image to dev repo..."
    docker tag $IMAGE_NAME:latest $DEV_IMAGE
    docker login -u "$DOCKER_USER" -p "$DOCKER_PASS"
    docker push $DEV_IMAGE
elif [ "$BRANCH_NAME" == "master" ]; then
    echo "Tagging and pushing image to prod repo..."
    docker tag $IMAGE_NAME:latest $PROD_IMAGE
    docker login -u "$DOCKER_USER" -p "$DOCKER_PASS"
    docker push $PROD_IMAGE
else
    echo "Unknown branch '$BRANCH_NAME'. Tagging as latest locally."
fi

echo "Build and push completed for branch: $BRANCH_NAME"
