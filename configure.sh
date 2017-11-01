#!/bin/bash
# Update pkg lists

PKG_MANAGER=$( command -v yum || command -v apt-get ) || echo "Neither yum nor apt-get found"
[[ -z $PKG_MANAGER ]] && exit 255

echo "Updating package lists..."
sudo $PKG_MANAGER update
# zsh install
echo ''
echo "Now installing zsh +..."
echo ''
sudo $PKG_MANAGER install vim curl wget less figlet zsh -y

# Installing git completion
echo ''
echo "Now installing git and bash-completion..."
sudo $PKG_MANAGER install git bash-completion -y

echo ''
echo "Now configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# oh-my-zsh install
echo ''
echo "Now installing oh-my-zsh..."
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# Bash color scheme
echo ''
echo "Now installing solarized dark WSL color scheme..."
echo ''
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark .dircolors

# Pull down personal dotfiles
echo "Now pulling down geekosphere-net dotfiles..."
git clone https://github.com/geekosphere-net/dotfiles.git ~/.dotfiles
echo ''
cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
echo ''
echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
if [[ $? -eq 0 ]]
then
	echo "Successfully configured your environment with geekosphere-net's dotfiles..."
else
	echo "geekosphere-net's dotfiles were not applied successfully..." >&2
fi


