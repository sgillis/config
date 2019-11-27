#! /usr/bin/env bash

if [[ $(gsettings get org.gnome.shell.extensions.dash-to-dock app-hotkey-4) = *[]* ]]; then
    gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-4 "['<Super>4']"
else
    gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-4 "[]"
fi
