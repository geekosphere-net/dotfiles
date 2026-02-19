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

# WSL-specific setup
if uname -r | grep -qi microsoft; then
    echo "WSL detected — installing wslu..."
    sudo add-apt-repository -y ppa:wslutilities/wslu
    sudo $PKG_MANAGER update
    sudo $PKG_MANAGER install -y wslu
    WSL=true
fi

# VMware shared folder symlinks (no-op on non-VMware VMs)
[[ -d /mnt/hgfs/c && ! -L /mnt/c ]] && sudo ln -s /mnt/hgfs/c /mnt/c
[[ -d /mnt/hgfs/d && ! -L /mnt/d ]] && sudo ln -s /mnt/hgfs/d /mnt/d

# VM-local config files — created once, never overwritten, never committed
echo "Creating VM-local config files..."

if [[ ! -f ~/.zshrc.local.pre ]]; then
    cat > ~/.zshrc.local.pre <<'LOCALEOF'
# VM-local pre-config — loaded before oh-my-zsh.
# Do NOT commit to dotfiles repo. Use for machine-specific PATH, env vars, etc.
# Secrets (API keys, tokens) belong in .zshrc.local.post.

# oh-my-zsh plugins for this VM.
# Base defaults apply if this is omitted:
#   git git-flow-avh zsh-syntax-highlighting sudo extract colored-man-pages
# Add from these based on what's installed on this VM:
#   Kubernetes:  kubectl helm kube-ps1 kubectx k9s
#   Cloud:       aws gcloud azure
#   Containers:  docker docker-compose
#   Go:          golang
#   Quality of life: zsh-autosuggestions zsh-completions zsh-navigation-tools
plugins=(git git-flow-avh zsh-syntax-highlighting sudo extract colored-man-pages
         zsh-autosuggestions zsh-completions zsh-navigation-tools)

# Machine-specific PATH and environment — uncomment and adjust as needed:
# export GOROOT=/usr/local/go
# export GOPATH=$HOME/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
LOCALEOF

    # WSL: append BROWSER setting with wslview
    if [[ ${WSL:-false} == true ]]; then
        echo 'export BROWSER=/usr/bin/wslview  # WSL: open URLs in Windows browser' >> ~/.zshrc.local.pre
    else
        echo '# export BROWSER=/usr/bin/wslview  # WSL: open URLs in Windows browser' >> ~/.zshrc.local.pre
    fi
    echo "  created ~/.zshrc.local.pre"
else
    echo "  ~/.zshrc.local.pre already exists — skipped"
fi

if [[ ! -f ~/.zshrc.local.post ]]; then
    cat > ~/.zshrc.local.post <<'LOCALEOF'
# VM-local post-config — loaded after oh-my-zsh and all dotfiles customizations.
# Do NOT commit to dotfiles repo. Use for machine-specific overrides and secrets
# (API keys, tokens, credentials) that must not be shared across VMs.

# Examples:
# export SOME_API_KEY=your-key-here
# export IBMCLOUD_API_KEY=your-key-here
# eval "$(some-tool shellenv)"

# WSL: prepend the WSL lib path to avoid missing library errors
# export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH
LOCALEOF
    echo "  created ~/.zshrc.local.post"
else
    echo "  ~/.zshrc.local.post already exists — skipped"
fi

echo ""
echo "All done! Log out and back in for zsh to take effect."
echo "Review ~/.zshrc.local.pre to add VM-specific plugins and PATH config."
echo "Then run ~/.dotfiles/script/install for optional tool installs (aws, nvm, yq, etc.)"
