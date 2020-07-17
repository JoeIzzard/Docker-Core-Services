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

# 2 - Network Creation
# 2a - Main Network
docker network create $NETWORK $NETWORK_OPTIONS

# 2b - Secondary Network
if [ ! -z ${SERVICE_NETWORK+X} ]; then
    docker network create $SERVICE_NETWORK $SERVICE_NETWORK_OPTIONS
fi

# 3 - Download latest version of nginx.tmpl
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > nginx.tmpl

# 4 - Pull Images
docker-compose pull

# 5 - Special Configuration
if [ ! -z ${USE_NGINX_CONF_FILES+X} ] && [ "${USE_NGINX_CONF_FILES}" = true ]; then

    # Create the Conf Directory if it doesn't exist
    mkdir -p $NGINX_FILES_PATH/conf.d

    # Copy the special configurations to the nginx conf folder
    cp -R ./conf.d/* $NGINX_FILES_PATH/conf.d

    # Check if there was an error and try with sudo
    if [ $? -ne 0 ]; then
        sudo cp -R ./conf.d/* $NGINX_FILES_PATH/conf.d
    fi

    # If there was any errors inform the user
    if [ $? -ne 0 ]; then
        echo
        echo "#######################################################"
        echo
        echo "There was an error trying to copy the nginx conf files."
        echo "The proxy will still work with default options, but"
        echo "the custom settings your have made could not be loaded."
        echo 
        echo "#######################################################"
    fi
fi

# 6 - Start the Proxy
if [ -z ${SERVICE_NETWORK} ]; then
    docker-compose up -d
else
    docker-compose -f docker-compose-multinet.yml up -d
fi

exit 0