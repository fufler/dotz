function video2gif {
    [[ $# != 3 ]] && __sk_video2gif && return -1

    tmp=$( mktemp -d )

    ffmpeg -y -i "$1" -vf palettegen "$tmp/palette.png" && \
    ffmpeg -y -i "$1" -i "$tmp/palette.png" -filter_complex paletteuse -r "$3" "$2"

    rm -y "$tmp/palette.png"
    rmdir "$tmp"
}

function __sk_video2gif() {
    echo "Converts video to gif"
    echo "\nUsage: video2gif <input> <output> <framerate>"
}

