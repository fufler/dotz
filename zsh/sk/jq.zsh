function jq_shell() {
    [[ $# != 1 ]] && __sk_jq_shell && return -1
    jq_shell_query=.
	while true; do
        vared -e -p '> ' jq_shell_query
        jq "$jq_shell_query" < "$1";
    done
}

function __sk_jq_shell() {
    echo 'Runs jq in interactive mode on specified file'
    echo
    echo 'Usage: jq_shell <filename>'
}
