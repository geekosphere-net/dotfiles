#!/bin/bash

PIP=$(command -v pip3 || command -v pip) || echo "Can't find pip"
[[ -z $PIP ]] && exit 255

${PIP} install awscli --upgrade --user

