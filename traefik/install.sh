#!/bin/bash

#
# Check for systemd-docker

if [[ ! -f /usr/local/bin/systemd-docker ]]
then
	echo "need to install systemd-docker"
	echo "https://github.com/ibuildthecloud/systemd-docker"
	exit 1
fi

#
# Copy over the config files and autostart the container

mkdir -p /opt/traefik/certs
cp ./traefik.toml /opt/traefik/
cp ./traefik.service /etc/systemd/system/traefik.service
ln -s /etc/systemd/system/traefik.service /opt/traefik/
systemctl enable traefik.service
systemctl start traefik.service

