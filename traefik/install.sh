#!/bin/bash

mkdir -p /opt/traefik/certs
cp ./traefik.toml /opt/traefik/
cp ./traefik.service /etc/systemd/system/traefik.service
ln -s /etc/systemd/system/traefik.service /opt/traefik/
systemctl enable traefik.service
systemctl start traefik.service

