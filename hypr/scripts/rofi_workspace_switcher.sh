#!/bin/bash

case "$ROFI_RETV" in
  0)
    active_ws_id=$( hyprctl activeworkspace -j | jq '.id' )

    declare -A workspaces

    readarray -t all_workspaces <<< \
      $( hyprctl workspaces -j | jq -r '.[] | select(.id > 0) | .id' | sort -n )

    for id in "${all_workspaces[@]}"; do
      echo -n "$id: "

      ws_title=$( hyprctl workspaces -j | jq -r ".[] | select(.id == $id) | .lastwindowtitle" )

      echo -n "${ws_title:--}"

      echo -e "\0info\x1f$id"
      
      if [[ "$id" = "$active_ws_id" ]]; then
        echo -en "\0icon\x1ffolder-bookmark\n"
      else
        echo
      fi
    done
    ;;
  
  1)
    hyprctl dispatch workspace "$ROFI_INFO" &> /dev/null
    ;;
  *)
    exit 1
    ;;
esac
