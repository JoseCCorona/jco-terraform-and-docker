#!/bin/bash

DOCKER_USER=$(aws ssm get-parameter --name "/docker/user" --with-decryption --query "Parameter.Value" --output text --region us-east-1)
DOCKER_PASS=$(aws ssm get-parameter --name "/docker/pass" --with-decryption --query "Parameter.Value" --output text --region us-east-1)
# Update system packages
sudo yum update -y
sleep 1
# Install docker
sudo yum install -y docker
sleep 1
# Start docker service
sudo service docker start
sleep 1
# HTML file creation
mkdir ngnix
cd ngnix
touch index.html
cat <<EOF > index.html
<!DOCTYPE html>
<html>
    <head>
        <title>This is DevOps Terraform and Docker HandsOn</title>
    </head>
    <body style="background-color:rgb(49,214,220);">
        <h1>Jose Corona DevOps Terraform and Docker HandsOn</h1>
    </body>
</html>
EOF
# Image creation
touch Dockerfile
cat <<EOF > Dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF
docker build . -t jco-ngnix
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
docker tag jco-ngnix $DOCKER_USER/jco-devops-academy:latest
docker push $DOCKER_USER/jco-devops-academy:latest
docker run -d -p 80:80 jco-ngnix