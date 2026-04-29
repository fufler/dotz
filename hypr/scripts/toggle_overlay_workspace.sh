#!/bin/bash


ws_id=$( hyprctl activeworkspace -j | jq -r '.id' )
hyprctl dispatch togglespecialworkspace overlay-${ws_id}
