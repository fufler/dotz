function dcu() {
    docker-compose $@ up
}

function __sk_dcu() {
    echo 'Shortcut for docker-compose up'
    echo
    echo 'Usage: dcu <options>'
    echo 'Example: dcu -f /a/b/c/docker-compose.yml -H host:2375'
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
