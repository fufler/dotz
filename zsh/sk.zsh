# Load custom shell functions
[[ -d "$HOME/.zsh/sk/" ]] && for f in $HOME/.zsh/sk/*.zsh(N); source "$f";

function sk_list() {
    funcs=( $( print -l ${(ok)functions} | egrep '^__sk_' | sed 's/^__sk_//g') )

    for f in $funcs; do
        help_text=$( eval "__sk_${f}" )
        help_preview=$( head -n1 <<< "${help_text}")
    
        echo "${f}␣${help_preview}␣$( echo ${help_text} | tr '\n' '␤' )";
    done | column -t -s ␣ -o ' '
}

function sk_list_fzf() {
    sk_list | fzf -d ' ' --with-nth=1,2 --nth=2 --preview "echo {3} | tr  '␤' '\n'" --preview-window=bottom
}

function sk_pick_command() {
    cmd=$(sk_list_fzf | egrep -ao '^\w+')
    LBUFFER="${LBUFFER}${cmd} "
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
}

zle     -N   sk_pick_command
bindkey '^K' sk_pick_command
