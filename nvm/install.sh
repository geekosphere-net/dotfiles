#!/bin/bash

VERSION=${1:-"v0.33.11"}
curl -o- https://raw.githubusercontent.com/creationix/nvm/${VERSION}/install.sh | bash

