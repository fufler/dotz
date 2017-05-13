#!/bin/zsh

if [[ ! "$UID" -eq "0"  ]]; then
    alias emerge='sudo emerge'
    alias xmerge='FEATURES="candy distcc distcc-pump" MAKEOPTS="-j9 -l3" sudo -E emerge';
fi
