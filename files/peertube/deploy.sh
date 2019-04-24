#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: $0 <remote git repository>"
    exit 1
fi

. /peertube/deployment.env
export $(cut -d= -f1 /peertube/deployment.env)
export PEERTUBE_REMOTE_GIT="$1"

sudo -E docker-compose -f /peertube/docker-compose.yaml up -d
