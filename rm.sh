#!/bin/bash
set -e
set -u

docker stop -t 1 action-runner
docker rm action-runner
