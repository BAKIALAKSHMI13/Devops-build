#!/bin/bash
set -e

# Usage: ./deploy.sh <branch_name>
BRANCH=${1:-dev}  # Default to 'dev' if not provided

DEV_IMAGE="bakialakshmi/dev:$BRANCH"
PROD_IMAGE="bakialakshmi/prod:$BRANCH"

echo "Stopping old container if it exists..."
docker-compose down || true

# Update docker-compose.yml image dynamically
if [ "$BRANCH" == "dev" ]; then
    sed -i "s|image: .*|image: $DEV_IMAGE|" docker-compose.yml
    echo "Deploying Dev image: $DEV_IMAGE"
elif [ "$BRANCH" == "master" ]; then
    sed -i "s|image: .*|image: $PROD_IMAGE|" docker-compose.yml
    echo "Deploying Prod image: $PROD_IMAGE"
else
    echo "Unknown branch '$BRANCH'. Using default image."
fi

echo "Starting new container..."
docker-compose up -d

echo "Deployment completed successfully for branch: $BRANCH"