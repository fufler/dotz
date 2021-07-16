function dcu() {
    docker-compose $@ up
}

function __sk_dcu() {
    echo 'Shortcut for docker-compose up'
    echo
    echo 'Usage: dcu <options>'
    echo 'Example: dcu -f /a/b/c/docker-compose.yml -H host:2375'
}

function dcud() {
    docker-compose $@ up -d
}

function __sk_dcud() {
    echo 'Shortcut for docker-compose up -d'
    echo
    echo 'Usage: dcud <options>'
    echo 'Example: dcud -f /a/b/c/docker-compose.yml -H host:2375'
}

function dcd() {
    docker-compose $@ down
}

function __sk_dcd() {
    echo 'Shortcut for docker-compose down'
    echo
    echo 'Usage: dcd <options>'
    echo 'Example: dcd -f /a/b/c/docker-compose.yml -H host:2375'
}

function dcb() {
    docker-compose $@ build
}

function __sk_dcb() {
    echo 'Shortcut for docker-compose build'
    echo
    echo 'Usage: dcb <options>'
    echo 'Example: dcb -f /a/b/c/docker-compose.yml -H host:2375'
}

function dcR() {
    docker-compose $@ down -v && docker-compose $@ up -d
}

function __sk_dcR() {
    echo 'Shortcut for docker-compose down -v && docker-compose up -d'
    echo
    echo 'Usage: dcR <options>'
    echo 'Example: dcR -f /a/b/c/docker-compose.yml -H host:2375'
}


function cleanup_forwarded_docker_socket() {
    [[ -z "$FORWARDED_DOCKER_HOST" ]] && return
    socket=${DOCKER_HOST:7}

    fuser -k "$socket" &> /dev/null

    rm -rf  $( dirname "$socket" )

    unset FORWARDED_DOCKER_HOST DOCKER_HOST
}

function __sk_cleanup_forwarded_docker_socket() {
    echo 'Cleans up forwarded Docker socket'
    echo
    echo 'Usage: cleanup_forwarded_docker_socket'
}

function forward_docker() {
    cleanup_forwarded_docker_socket;

    d=$( mktemp -d )
    socket="$d/docker.sock"

    ssh -fnNT -L "$socket:/var/run/docker.sock" "$1" &> /dev/null

    export DOCKER_HOST="unix://$socket"
    export FORWARDED_DOCKER_HOST="$1"
}

function __sk_forward_docker() {
    echo 'Forwards Docker socket over SSH'
    echo
    echo 'Usage: forward_docker <host>'
    echo 'Example: forward_docker user@docker.ho.st'
}

trap 'cleanup_forwarded_docker_socket' EXIT