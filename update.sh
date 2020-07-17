#!/bin/bash

#
#
#

# 1 - Load the Environment Variable
if [ -e .env ]; then
    source .env
else
    echo "You don't have a .env file. Please create one before continuing."
    exit 1
fi

# 2 - Update the Repo
git pull
git checkout master

# Check the env file
if [ "$(wc -l .env | cut -f1 -d' ')" != "$(wc -l .env.sample | cut -f1 -d' ')" ]; then
    echo
    echo "The sample .env are different from the your current .env file."
    echo "Please update your .env file to continue."
    echo "It must has the same lines of the sample env file."
    echo
    echo "If you keep receiving this message please check the number of line of both files"
    echo
fi

# 3 - Download new template
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > nginx.tmpl

# 4 - Update the containers
docker-compose up -d --no-deps --build ${WATCHTOWER}
docker-compose up -d --no-deps --build ${NGINX_WEB}
docker-compose up -d --no-deps --build ${NGINX_GEN}
docker-compose up -d --no-deps --build ${NGINX_LETSENCRYPT}