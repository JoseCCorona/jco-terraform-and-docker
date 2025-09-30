#!/bin/bash

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
<!doctype html>
<html>
 <body style="backgroud-color:rgb(49, 214, 220);"><center>
    <head>
     <title>DevOps Terraform and Docker HandsOn</title>
    </head>
    <body>
     <p>This is DevOps Terraform and Docker HandsOn<p>
    </body>
</html>
EOF
# Image creation
touch Dockerfile
cat <<EOF > Dockerfile
FROM nginx:latest
COPY ./index.html /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
EOF
docker build . -t josekr/ngnix
docker push josekr/ngnix
docker run -d -p 80:8080 nginx