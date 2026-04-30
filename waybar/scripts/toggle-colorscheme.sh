#!/bin/bash

colorscheme=$( gsettings get org.gnome.desktop.interface color-scheme | tr -d "'" )

if [[ "$1" == toggle ]]; then
  if [[ "$colorscheme" == "prefer-dark" ]]; then
    colorscheme="prefer-light"
  else
    colorscheme="prefer-dark"
  fi

  gsettings set org.gnome.desktop.interface color-scheme "$colorscheme"
fi

if [[ "$colorscheme" == "prefer-dark" ]]; then
  p="0"
else
  p="100"
fi

echo "{\"text\": \"$colorscheme\", \"percentage\": $p }"
