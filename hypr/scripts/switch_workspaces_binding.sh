#!/bin/bash

if [[ -z "$1" ]]; then
  exit 1
fi

# hyprctl dispatch workspace previous

echo "source = workspaces/workspaces_$1.conf" > ~/.config/hypr/conf.d/workspaces.conf

# hyprpanel -q
# (hyprpanel &)

