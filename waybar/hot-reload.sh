CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"

while true; do
    inotifywait -e create,modify $CONFIG_FILES
    if ! killall -SIGUSR2 waybar; then
        waybar &
    fi
done
