#!/usr/bin/env bash
# Install AWS CLI v2
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

set -e

ARCH=$(dpkg --print-architecture)
case $ARCH in
    amd64) AWS_ARCH="x86_64"  ;;
    arm64) AWS_ARCH="aarch64" ;;
    *)     echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

TMP=$(mktemp -d)
echo "Installing AWS CLI v2 for linux/${AWS_ARCH}..."
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o "${TMP}/awscliv2.zip"
unzip -q "${TMP}/awscliv2.zip" -d "${TMP}"

if command -v aws &>/dev/null; then
    sudo "${TMP}/aws/install" --update
else
    sudo "${TMP}/aws/install"
fi

rm -rf "${TMP}"
echo "Installed: $(aws --version)"
