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

cp ./binddocker.service /etc/systemd/system/binddocker.service
systemctl enable binddocker.service
systemctl start binddocker.service

