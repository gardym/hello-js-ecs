#!/bin/sh

docker rmi $(docker images --filter "dangling=true" -q)
