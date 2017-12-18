#!/bin/sh
#
# Rafael Cavalcanti

vbox="~/.config/rofi/vbox.sh"
vnc="~/.config/rofi/vnc.sh"

usage() {
	cat <<-EOF
	Usage: $0 <options>

	Options: --launcher, --ssh
	EOF
}

case "$1" in
	--ssh)
		rofi -show ssh -modi ssh,vnc:$vnc
		;;
	--launcher)
		rofi -combi-modi window,drun,vbox:$vbox -show combi -modi combi,vbox:$vbox
		;;
	*)
		usage
		;;
esac
