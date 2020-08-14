function im_rotate_180() {
    for f in "$@"; do
        echo -e -n "convert  '$f' -rotate 180 '$f'\0";
    done | parallel --eta --bar -0
}

function __sk_im_rotate_180() {
    echo "Performs 180° rotation on all images passed as arguments"
    echo "\nUsage: im_rotate_180 <list of image files>"
}

function im_grayscale() {
    for f in "$@"; do
        echo -e -n "convert '$f' -set colorspace Gray -separate -average '$f'\0";
    done | parallel --eta --bar -0
}

function __sk_im_grayscale() {
    echo "Converts all images passed as arguments to grayscale"
    echo "\nUsage: im_grayscale  <list of image files>"
}

function im_scale() {
    for f in "${@:2}"; do
        echo -e -n "convert '$f' -scale '$1' '$f'\0";
    done | parallel --eta --bar -0
}

function __sk_im_scale() {
    echo "Scales all images passed as arguments"
    echo "\nUsage: im_scale <scale factor> <list of image files>"
}

function im_quality() {
    for f in "${@:2}"; do
        echo -e -n "mogrify -quality '$1' '$f'\0";
    done | parallel --eta --bar -0
}

function __sk_im_quality() {
    echo "Adjust quality for all images passed as arguments"
    echo "\nUsage: im_quality <quality> <list of image files>"
}

function im_pack() {
    convert -units PixelsPerInch -density $1 ${@:3} $2
}

function __sk_im_pack() {
    echo "«Packs» all images passed as arguments into single file"
    echo "\nUsage: im_to_pdf <dpi> <output file name> <list of image files>"
}
