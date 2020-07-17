#!/usr/bin/env bash

#
# This file should be used to start the Core Service Compose, you must set the .env file before starting
# Source: 
# This project is based on a similer project by evertramos
#

# 1 - Check and load the .env file
if [ -e .env ]; then
    source .env
else
    echo "You don't have a .env file. Please create one before continuing."
    exit 1
fi

# 2 - Stop the compose
docker-compose down

# 3 - Remove networks
# 3a - Main network
docker network rm $network

# 3b - Secondary Network
if [ ! -z ${SERVICE_NETWORK} ]; then
    docker network rm $SERVICE_NETWORK
fi

