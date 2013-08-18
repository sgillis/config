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
    $ ln -s ~/config/bash_profile ~/.bash_profile

Add 'export PATH=$PATH:~/usr/bin/tmuxgo' to bashrc

We need exuberant-ctags for the Tagbar Vim plugin

    $ sudo apt-get install exuberant-ctags

Next clone Vundle (https://github.com/gmarik/vundle/) and extra fonts for Powerline
    
    $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    $ git clone https://github.com/Lokaltog/powerline-fonts ~/.fonts

Cache the new fonts

    $ fc-cache -vf ~/.fonts

The terminal should be configured to use one of these new fonts in order for the
Powerline to display correctly.

Install the Vim plugins
    
    $ vim +BundleInstall +qall

We need to run the Powerline install script

    $ cd ~/.vim/bundle/powerline
    $ sudo python setup.py install

We need flake8 for vim-flake8

    $ sudo pip install flake8

To make Command-T work properly, we need vim with ruby support (vim-nox) and ruby installed. Then we need to do

    $ sudo apt-get install ruby1.8-dev
    $ cd ~/.vim/bundle/Command-T/ruby/command-t
    $ ruby extconf.rb
    $ make
