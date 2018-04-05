#! /bin/bash

nix-env -q | grep -q $1 || nix-env --install $1
