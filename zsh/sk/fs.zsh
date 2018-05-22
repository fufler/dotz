function rename_with_order() {
    zmodload zsh/mathfunc

    lg=$(( log10($#) ))
    rounded=$( printf "%0.0f" ${lg} )
    pad=$(( 1 + rounded ))
    
    for ((i = 1; i <= $#; i++)); do
        f=${@[i]}
        number=$( printf %0${pad}d ${i} )
        mv -v -i "${f}" "${number}.${f:e}"
    done
}

function __sk_rename_with_order() {
    echo 'Renames files passed as arguments with respect to their order'
    echo
    echo 'Usage: rename_with_order <list of files>'
    echo 'Example: rename_with_order a.txt b.txt … z.txt will result in following:'
    echo 'a.txt → 01.txt'
    echo 'b.txt → 02.txt'
    echo '…'
    echo 'z.txt → 26.txt'
}
