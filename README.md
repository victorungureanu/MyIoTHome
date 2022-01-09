# MyIoTHome
Setup and configuration for my IoT project. Uses Docker, HomeAssistant, Grafana, InfluxDb, Homer and a bunch of other stuff

# My setup

I am using a raspberry pi 4 8GB RAM connectected to the network using a cable. On it, I'm running raspberry pi os and I manually installed Docker.

## Zigbee
I am using Zigbee to MQTT see [this article](https://thesmarthomejourney.com/2020/05/11/guide-zigbee2mqtt/)
CC2531 Zigbee2MQTT Firmware with Antenna for Home Assistant, Open HAB etc.

# Prerequisites

* raspberry pi is configured to allow ssh connections using an ssh key
* on the development machine the following are installed:
  * powershell
  * ssh

# Running the scripts
* Make sure to create configuration files in the config folder. You can copy the .example files, remove the .example file extension and update the values with your configuration.

## deploy.ps1
Copies the docker-compose file to the raspberry pi and runs ```docker-compose down && docker-compose up -d```

## backup_volumes.ps1
Creates an archive containing the docker volumes from the raspberry pi

## restore_volumes.ps1
Overrides the docker volumes on the raspberry pi using a selected archive
