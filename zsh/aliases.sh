#!/bin/zsh

if [[ ! "$UID" -eq "0"  ]]; then
    alias emerge='sudo emerge'
    alias xmerge='FEATURES="candy distcc distcc-pump ccache" MAKEOPTS="-j6 -l0" sudo -E emerge';
fi
