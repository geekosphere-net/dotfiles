#!/usr/bin/env bash
# Install nvm (Node Version Manager)
# https://github.com/nvm-sh/nvm

set -e

NVM_VERSION=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest \
    | grep '"tag_name"' | cut -d'"' -f4)

echo "Installing nvm ${NVM_VERSION}..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
