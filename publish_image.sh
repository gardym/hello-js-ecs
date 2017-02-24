#!/bin/bash
source ./config

eval $(aws ecr get-login --region us-east-1)

docker build -t $IMAGE:latest .
docker push $IMAGE
