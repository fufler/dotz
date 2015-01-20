#!/bin/zsh

if [[ ! "$UID" -eq "0"  ]]; then
    alias dnf='sudo dnf';
    alias yum='sudo yum';

    alias dnfi='sudo dnf install';
    alias dnfiy='sudo dnf install -y';

    alias dnfs='sudo dnf search';
    alias dnfp='sudo dnf provides';

    alias dnfr='sudo dnf remove';
    alias dnfry='sudo dnf remove -y';

    alias dnfu='sudo dnf update';
    alias dnfuy='sudo dnf update -y';
fi
