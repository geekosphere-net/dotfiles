#!/usr/bin/env bash
# Install mikefarah/yq — Go-based YAML processor (NOT the same as apt's yq/kislyuk)
# https://github.com/mikefarah/yq

set -e

ARCH=$(dpkg --print-architecture)
YQ_URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${ARCH}"

echo "Installing yq for linux/${ARCH}..."
sudo wget -qO /usr/local/bin/yq "${YQ_URL}"
sudo chmod +x /usr/local/bin/yq
echo "Installed: $(yq --version)"
