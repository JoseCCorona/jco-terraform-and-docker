#!/bin/bash

DOCKER_USER=$(aws ssm get-parameter --name "/docker/user" --with-decryption --query "Parameter.Value" --output text --region us-east-1)
IMAGE_NAME="jco-devops-academy"
TAG="latest"
# Update system packages
sudo yum update -y
sleep 1
# Install docker
sudo yum install -y docker
sleep 1
# Start docker service
sudo service docker start
sleep 1
# Wait for the image to appear in Docker Hub
echo "Waiting for Docker image ${DOCKER_USER}/${IMAGE_NAME}:${TAG} to become available..."
for i in {1..10}; do
  if curl -fsL "https://hub.docker.com/v2/repositories/${DOCKER_USER}/${IMAGE_NAME}/tags/${TAG}/" > /dev/null; then
    echo "Docker image was found. Proceeding..."
    break
  fi
  echo "Image not found yet (attempt $i). Waiting 30 seconds..."
  sleep 30
done
# Login to Docker
docker pull ${DOCKER_USER}/${IMAGE_NAME}:${TAG}
docker save $DOCKER_USER/${IMAGE_NAME}:${TAG} -o jco-devops-academy.tar
aws s3 cp jco-devops-academy.tar s3://jco-task2/jco-devops-academy.tar