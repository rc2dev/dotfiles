#!/bin/sh
# Rafael Cavalcanti - based on /etc/X11/xinit/xinitrc

userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

#if [ -f "$usermodmap" ]; then
    #xmodmap "$usermodmap"
#fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi



# Set default session
session=${2:-i3}

case $session in
	i3)
		export XDG_CURRENT_DESKTOP="i3"
		[ -f ~/.xprofile ] && source ~/.xprofile
		exec i3
		;;

	kde)
		export XDG_CURRENT_DESKTOP="KDE"
		[ -f ~/.xprofile ] && source ~/.xprofile
		exec startkde
		;;

	# No known session, try to run it as command
	*)
		exec "$session"
		;;
esac

