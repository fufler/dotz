#!/bin/bash

workspace_name=$( hyprctl activeworkspace -j | jq '.name' )
workspace_id=$( hyprctl activeworkspace -j | jq '.id' )

new_workspace_name=$(
  rofi \
    -dmenu \
    -p "Rename workspace " \
    -theme-str 'listview { enabled: false;} entry { placeholder: ""; }' \
    -filter "$workspace_name"
)

if [[ ! -z "$new_workspace_name" ]]; then
  hyprctl dispatch renameworkspace "$workspace_id" "$new_workspace_name"
fi
