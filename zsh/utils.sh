#!/bin/zsh

# Saves cached videos from Chrmoum browser
save_cached_videos() {
	n=0
	IFS='
	'
	for pid in $( pgrep chromium ); do
		for f in $( ls -1 /proc/$pid/fd 2> /dev/null ); do
			real_path=$( readlink /proc/$pid/fd/$f );
			if [[ "$real_path" == *Flash* ]]; then
				echo "Saving file ./$n.flv"
				cp /proc/$pid/fd/$f ./$n.flv;
				n=$(( n+1 ))
			fi
		done
	done
}

# Runs command using ssh on a group of nodes
dshell() {
	if [[ $# < 2 ]]; then
		echo "Usage: dshell [user@]group cmd"
		return 1
	fi

	IFS='@';
	args=( $1 );
	if (( ${#args} == 2 )); then
		group="${args[2]}";
		runas="${args[1]}";
	else
		group="${args[1]}"
	fi;
	log="/tmp/pdsh-`uuidgen`.log"
	[[ -z "$runas" ]] && runas=$USER;
	scrc="/tmp/dshell-`uuidgen`.screenrc"
	cp ~/.screenrc-dshell $scrc
	IFS='
	'
	for n in `cat $HOME/.dsh/group/${group}`; do
		echo "screen -t dshell@$n ssh $runas@$n \"${@:2} ; echo -e '\\\\n\\\\n\\\\n\\\\nCommand executed. Hit Enter to disconnect…' ; read\"" >> $scrc
	done

	screen -c $scrc
}

rhev() {
	fusermount -u -z .remote/alfdev
	sudo kill -9 `ps ax | grep 'ssh -l root -w 0:0 -p 2020 213.85.113.135 -i /home/lx/.ssh/id_rsa -f sh tunnel.sh' | grep -v grep | awk '{print $1}'`
	sudo ssh -l root -w 0:0 -p 2020 213.85.113.135 -i /home/lx/.ssh/id_rsa -f sh tunnel.sh
	sudo ifconfig tun0 inet 192.168.99.1/24 up
	sudo ip r add 192.168.42.0/24 via 192.168.99.2
	sshfs alfdev:. ~/.remote/alfdev
}

pprint_xml() {
	xmllint --pretty 1 "$1" | pygmentize -l xml
}

proxify() {
	ssh -fND 1080 fufler@elite.bshellz.net
	proxychains $@
	kill -9 $( ps ax | grep 'ssh -fND 1080' | head -n1 | awk '{ print $1 }' )
}

format_xml() {
	rm -f /tmp/formatted.xml
	xmllint --pretty 1 "$1" > /tmp/formatted.xml
	mv /tmp/formatted.xml "$1";
}

update_dotz() {
    cd "$HOME/.dotz"
    git pull && git submodule update --init --recursive
    cd -
}
