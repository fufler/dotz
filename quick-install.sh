#!/bin/sh

set -e

git clone --recurse-submodules https://github.com/fufler/dotz.git ~/.dotz
cd ~/.dotz
zsh ./install.sh
