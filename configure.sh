#!/usr/bin/env bash
# Fresh VM bootstrap — installs prerequisites and sets up dotfiles.
# Usage: bash -c "$(curl -fsSL https://raw.githubusercontent.com/geekosphere-net/dotfiles/master/configure.sh)"

set -e

PKG_MANAGER=$(command -v apt-get || command -v yum) || { echo "Neither apt-get nor yum found"; exit 255; }

echo "Updating package lists..."
sudo $PKG_MANAGER update

echo "Installing core packages..."
sudo $PKG_MANAGER install -y vim curl wget less figlet zsh git net-tools unzip

# oh-my-zsh (RUNZSH=no + CHSH=no prevents it hijacking the script mid-run)
echo "Installing oh-my-zsh..."
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# oh-my-zsh custom plugins
echo "Installing oh-my-zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-completions        "${ZSH_CUSTOM}/plugins/zsh-completions"
git clone https://github.com/zsh-users/zsh-autosuggestions    "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

# Dircolors solarized
echo "Installing dircolors solarized..."
wget -qO ~/.dircolors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

# Clone dotfiles
echo "Cloning dotfiles..."
git clone https://github.com/geekosphere-net/dotfiles.git ~/.dotfiles

# Run bootstrap (creates *.symlink → ~/.<name> symlinks, sets up gitconfig)
echo "Configuring symlinks..."
cd "$HOME/.dotfiles" && script/bootstrap

# vim plugins (pathogen + solarized — always installed)
echo "Installing vim plugins..."
"$HOME/.dotfiles/vim/install.sh"

# Set zsh as default shell
echo "Setting zsh as default shell..."
chsh -s "$(command -v zsh)"

# VMware shared folder symlinks (no-op on non-VMware VMs)
[[ -d /mnt/hgfs/c && ! -L /mnt/c ]] && sudo ln -s /mnt/hgfs/c /mnt/c
[[ -d /mnt/hgfs/d && ! -L /mnt/d ]] && sudo ln -s /mnt/hgfs/d /mnt/d

echo ""
echo "All done! Log out and back in for zsh to take effect."
echo "Then run ~/.dotfiles/script/install for optional tool installs (aws, nvm, yq, etc.)"
