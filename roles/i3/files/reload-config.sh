#!/usr/bin/env sh

ansible-playbook -i $HOME/git/config/inventory $HOME/git/config/configure.yml && notify-send "Configuration reloaded" || notify-send "Configuration failed"
