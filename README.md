# Description

It's just my vimrc file, which I use from time to time. Currently, I'm using IDEAvim plugin in IDE for coding, so it's not a good vimrc, just something I used to.

You can download only vimrc using this:

    curl https://raw.githubusercontent.com/Swich1987/vimrc/master/vimrc.vim

## Ctags problems
If you get error `Taglist: Exuberant ctags not found in PATH` after vim launch on Ubuntu, you need to install it:

    sudo apt-get install exuberant-ctags

## YouCompleteMe fix installation problems
For correct installation of YouCompleteMe use it:

    sudo apt-get install cmake python-pip
And after first launch of vim and autodownload YouCompleteMe, you need to manualy install it:

    python ./vim/plugged/YouCompleteMe/install.py
