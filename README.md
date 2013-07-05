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

Next clone Vundle (https://github.com/gmarik/vundle/) and extra fonts for Powerline
    
    $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    $ git clone https://github.com/Lokaltog/powerline-fonts ~/.fonts

Cache the new fonts

    $ fc-cache -vf ~/.fonts

Install the Vim plugins
    
    $ vim +BundleInstall +qall
