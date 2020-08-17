function video2gif {
    [[ $# != 3 ]] && __sk_video2gif && return -1

    tmp=$( mktemp -d )

    ffmpeg -y -i "$1" -vf palettegen "$tmp/palette.png" && \
    ffmpeg -y -i "$1" -i "$tmp/palette.png" -filter_complex paletteuse -r "$3" "$2"

    rm -f "$tmp/palette.png"
    rmdir "$tmp"
}

function __sk_video2gif() {
    echo "Converts video to gif"
    echo "\nUsage: video2gif <input> <output> <framerate>"
}


function audio2ac3 {
    [[ $# < 2 ]] && __sk_audio2ac3 && return -1

    if [[ -z "$3" ]]; then
        br="1000k"
    else
        br="$3"
    fi
    
    if [[ -z "$4" ]]; then
        thr="5"
    else
        thr="$4"
    fi

    ffmpeg -i "$1" -map 0 -vcodec copy -scodec copy -acodec ac3 -b:a "$br" "$2"  -threads "$thr"
}

function __sk_audio2ac3() {
    echo "Encodes audio tracks from video container with ac3"
    echo "\nUsage: audio2ac3 <input> <output> [audio bitrate] [workers]"
}
