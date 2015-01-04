#!/bin/zsh

if [[ ! "$UID" -eq "0"  ]]; then
    alias dnf='sudo dnf';
    alias yum='sudo yum';
fi
