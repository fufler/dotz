#!/bin/bash

if (( "$1" < 1 || "$1" > 10 )); then
  exit 1
fi

ws_id=$( hyprctl activeworkspace -j | jq -r '.name' )
ws_group=$(( ("$ws_id" - 1) / 10 ))
target_ws_id=$(( 10 * "$ws_group" + "$1" ))

hyprctl dispatch workspace "$target_ws_id"
