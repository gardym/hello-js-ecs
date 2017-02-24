#!/bin/bash
source ./config

docker build -t $IMAGE:latest .
docker push $IMAGE
