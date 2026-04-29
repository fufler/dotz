#!/bin/bash

case "$ROFI_RETV" in
  0)
    active_ws_id=$( hyprctl activeworkspace -j | jq '.id' )

    readarray -t all_windows <<< $( hyprctl clients -j | jq -r ".[] | select(.workspace.id == ${active_ws_id}) | .address" )

    for w in "${all_windows[@]}"; do
      title=$( hyprctl clients -j | jq -r ".[] | select(.address == \"$w\") | .title" )

      echo -e "$title\0info\x1f$w"
    done
    ;;
  
  1)
    active_ws_id=$( hyprctl activeworkspace -j | jq '.id' )
    active_window_address=$( hyprctl activewindow -j | jq -r '.address' )
 
    hyprctl dispatch workspace "$active_ws_id" &> /dev/null

    killall -9 rofi
    
    if [[ "$active_window_address" != "$ROFI_INFO" ]]; then
      hyprctl dispatch fullscreen 1 unset &> /dev/null
      hyprctl dispatch focuswindow "address:$ROFI_INFO" &> /dev/null
    fi


    hyprctl dispatch fullscreen 1 &> /dev/null
    ;;
  *)
    exit 1
    ;;
esac
