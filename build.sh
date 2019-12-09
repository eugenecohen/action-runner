#!/bin/bash
set -e
set -u

docker build . --tag action-runner \
    --build-arg HTTP_PROXY=${HTTP_PROXY} \
    --build-arg HTTPS_PROXY=${HTTP_PROXY} 
