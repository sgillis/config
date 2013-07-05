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
    $ ln -s ~/config/powerline ~/.config/powerline
    $ ln -s ~/config/tmuxgo ~/usr/bin/tmuxgo
    $ export PATH=$PATH:~/usr/bin/tmuxgo

We need exuberant-ctags for the Tagbar Vim plugin

    $ sudo apt-get install exuberant-ctags

Next clone Vundle (https://github.com/gmarik/vundle/) and extra fonts for Powerline
    
    $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    $ git clone https://github.com/Lokaltog/powerline-fonts ~/.fonts

Cache the new fonts

    $ fc-cache -vf ~/.fonts

The terminal should be configured to use one of these new fonts in order for the Powerline to display correctly.

Install the Vim plugins
    
    $ vim +BundleInstall +qall

We need to run the Powerline install script

    $ sudo python ~/.vim/bundle/powerline/setup.py install
