#!/bin/bash
set -e
set -u

WORKDIR=$(pwd)
mkdir -p $WORKDIR

docker run -d \
    --env WORKDIR=$WORKDIR \
    -v $WORKDIR:$WORKDIR \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name action-runner \
    action-runner 

echo launch runner configure
echo NOTICE: makesure to configure _work to $(WORKDIR)/_work so docker-in-docker can work
docker exec -it \
    --env WORKDIR=$WORKDIR \
    action-runner \
    ./config.sh

echo starting runner in background
docker exec -d \
    --env WORKDIR=$WORKDIR \
    action-runner \
    ./run.sh
echo runner started


