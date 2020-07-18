# Docker-Core-Services

![GitHub last commit](https://img.shields.io/github/last-commit/joeizzard/Docker-Core-Services?style=flat-square) [![Actions Panel](https://img.shields.io/badge/actionspanel-enabled-brightgreen?style=flat-square)](https://www.actionspanel.app/app/JoeIzzard/Docker-Core-Services)

![GitHub Bug Issues](https://img.shields.io/github/issues/joeizzard/Docker-Core-Services/Type:%20Bug?label=Bug%20Issues&style=flat-square) ![GitHub Maintenance Issues](https://img.shields.io/github/issues/joeizzard/Docker-Core-Services/Type:%20Maintenance?label=Maintenance%20Issues&style=flat-square) ![GitHub Enhancement Issues](https://img.shields.io/github/issues/joeizzard/Docker-Core-Services/Type:%20Enhancement?label=Enhancement%20Issues&style=flat-square) ![GitHub Question Issues](https://img.shields.io/github/issues/joeizzard/Docker-Core-Services/Type:%20Question?label=Questions&style=flat-square)

The Docker Core Services project is my core services for hosting websites out of Docker. This is largely based on the similar project [docker-compose-letsencrypt-nginx-proxy-companion](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion) by evertramos. This project adds WatchTower to the mix, allowing containers to be automatically updated, and will in future add dev support for generating self signed certificates to test builds locally without letsencrypt.

## Contents

1. [Installation](#Installation)
2. [Usage](#Usage)

## Installation

Installing the project is simple:

1. Clone the repo to your PC/Server
2. Copy `.env.sample` to `.env`
3. Check the settings in `.env` match what you are your environment require

## Usage

To use this compose set up, you need to [install it](#Installation) by following the instructions above. To run the compose set up, run the bash script `start.sh`. This will ensure the settings in your `.env` file are loaded and networks are created.

To add containers to this setup, you will also need to add some environment variables to your sites containers. These will allow the set up to automatically detect the sites and generate certificates where required. The variables are:

| Variable | Example | Required |
| :----- | :----- | :----- |
| `VIRTUAL_HOST` | example.com | Y |
| `VIRTUAL_PORT` | 3000 | N |
| `LETSENCRYPT_HOST` | example.com | Y - For SSL |
| `LETSENCRYPT_EMAIL` | example@example.com | Y - For SSL |


## License

This project is licensed under [MIT](https://opensource.org/licenses/MIT). 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

For the full License, Please see the file [LICENSE.md](LICENSE.md)