function pprint_xml() {
    [[ $# != 1 ]] && __sk_pprint_xml && return -1
	xmllint --pretty 1 "$1" | pygmentize -l xml
}

function __sk_pprint_xml() {
    echo 'Pretty prints XML'
    echo
    echo 'Usage: pprint_xml <filename>'
}

function format_xml() {
    [[ $# != 1 ]] && __sk_format_xml && return -1
	dir=$( mktemp -d )
	xmllint --pretty 1 "$1" > "${dir}/formatted.xml"
	mv -i "${dir}/formatted.xml" "$1";
    rm -rf "${dir}"
}

function __sk_format_xml() {
    echo 'Reformats XML file'
    echo
    echo 'Usage: format_xml <filename>'
}
