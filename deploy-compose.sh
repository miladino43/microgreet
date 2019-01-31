#!/bin/bash

TAG=$1

if [ -z "$1" ]
  then
    echo "No tag supplied"
    exit 1
fi

export TAG=$TAG

docker-compose up -d