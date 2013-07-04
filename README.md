config
======

My personal configuration files

Quick setup
-----------

First clone this directory and symlink
    $ git clone https://github.com/sgillis/config.git ~/config
    $ ln -s ~/config/vim ~/.vim
    $ ln -s ~/config/vimrc ~/.vimrc
    $ ln -s ~/config/tmux.conf ~/.tmux.conf

Next clone Vundle (https://github.com/gmarik/vundle/)
    $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

Install the plugins
    $ vim +BundleInstall +qall
