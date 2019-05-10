#!/usr/bin/env sh

curl https://raw.githubusercontent.com/Swich1987/vimrc/master/vimrc.vim > ~/.vimrc
sudo apt install exuberant-ctags
sudo apt install cmake python-pip
vim +PlugInstall +qall +silent
python ~/.vim/plugged/YouCompleteMe/install.py
