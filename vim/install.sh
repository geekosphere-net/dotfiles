#!/usr/bin/env bash
# Install vim plugins via pathogen

set -e

mkdir -p ~/.vim/autoload ~/.vim/bundle

# pathogen
curl -fsSLo ~/.vim/autoload/pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# solarized theme
if [[ ! -d ~/.vim/bundle/vim-colors-solarized ]]; then
    git clone https://github.com/altercation/vim-colors-solarized.git \
        ~/.vim/bundle/vim-colors-solarized
fi
