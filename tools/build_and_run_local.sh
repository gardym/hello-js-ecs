#!/bin/sh

docker build -t adoptapuffin/hello-js:latest .

echo "Running locally on 43000"
docker run -p 43000:3000 adoptapuffin/hello-js:latest
