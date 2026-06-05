#!/usr/bin/env bash

# pathogen loader
#mkdir -p ~/.vim/autoload ~/.vim/bundle 
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# solarized themes
#git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized/
curl -fLo ~/.vim/colors/solarized.vim --create-dirs https://raw.githubusercontent.com/ericbn/vim-solarized/master/colors/solarized.vim
