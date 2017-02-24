#!/bin/sh

docker build -t adoptapuffin/hello-js:latest .

echo "Running locally on 43000"
docker run \
  -p 43000:3000 \
  -e "NODE_ENV=production" \
  -u "node" \
  -m "300M" \
  adoptapuffin/hello-js:latest
