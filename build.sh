#!/bin/bash
set -e

# Usage: ./build.sh <branch_name>
BRANCH=$GIT_BRANCH # Default to 'dev' if not provided

IMAGE_NAME="react-static-app"
DEV_IMAGE="bakialakshmi/dev:$BRANCH"
PROD_IMAGE="bakialakshmi/prod:$BRANCH"

echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .

# Docker Login (non-interactive mode for Jenkins)
echo "Logging in to Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [ "$BRANCH" == "dev" ]; then
    echo "Tagging and pushing image to dev repo..."
    docker tag $IMAGE_NAME:latest $DEV_IMAGE
    docker push $DEV_IMAGE
elif [ "$BRANCH" == "master" ]; then
    echo "Tagging and pushing image to prod repo..."
    docker tag $IMAGE_NAME:latest $PROD_IMAGE
    docker push $PROD_IMAGE
else
    echo "Unknown branch '$BRANCH'. Tagging as latest locally."
fi

echo "Build and push complete for branch: $BRANCH"