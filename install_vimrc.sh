#!/usr/bin/env sh

wget -O .vimrc https://raw.githubusercontent.com/Swich1987/vimrc/master/vimrc.vim
sudo apt -y install vim exuberant-ctags cmake python-pip
vim +PlugInstall +qall +silent
python ~/.vim/plugged/YouCompleteMe/install.py
