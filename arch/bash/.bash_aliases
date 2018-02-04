#
# ~/.bash_aliases
#
# Autor: Rafael Cavalcanti

# Also check command after sudo for alias (see man bash)
alias sudo="sudo "
alias watch="watch "

# Increase verbosity and prompt before overwriting (for rm, prompt
# before removing directory or more than 3 files)
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -vI"
alias ln="ln -vi"

# Human-readable output
alias df="df -h"
alias free="free -h"

# Coloured output
alias ls="ls --color=auto"
alias grep="grep --color=auto"
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

# Easy access to ls options
alias la="ls -a"
alias ll="ls -lh"

# Bash commands
alias c="clear"
alias x="exit"

# Arch's Pacman
if [ -e /usr/bin/pacman ]; then
	alias update="sudo pacman -Syu && pacaur -u --devel --needed"
	alias pm="sudo reflector --country Brazil -l 5 --sort rate \
		--save /etc/pacman.d/mirrorlist && echo 'OK.' && sudo pacman -Syy"
fi

# Apt
if [ -e /usr/bin/apt ]; then
	alias update="sudo apt update && sudo apt upgrade && sudo apt clean"
fi

# Energy in remote connections
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	alias poweroff="sudo poweroff"
fi

# Criar snapshot Btrfs
function snap() {
	echo "Criaremos um snapshot do sistema. Home e data não estão inclusos."
	read -p "Descrição: " desc
	echo $desc
	sudo snapper -c @ create --description "$desc" --userdata "important=yes"
	sudo snapper -c @var create --description "$desc" --userdata "important=yes"
}
#LVM: alias snap="sudo lvcreate -s /dev/ssd/arch -n snap -L 5G && sudo lvcreate -s /dev/hdd/arch -n snap -L 5G"

# Systemd
alias ju="journalctl -u"
alias jb="journalctl -b -u"
alias jf="journalctl -b -f -u"

## R509
#[ -e /usr/bin/samsung-tools ] && alias si="samsung-tools -c silent"

# Gerar string a partir de /dev/urandom (http://www.commandlinefu.com/commands/view/7234/create-random-string-from-devurandom-or-another-length)
alias ger="cat /dev/urandom | tr -dc "[:alnum:]" | head -c64 && echo"
alias ger2="cat /dev/urandom | tr -dc "[:lower:]" | head -c64 && echo"

# Git log bonito (copiado do Reddit)
alias gitlog='git log --graph --oneline --all --decorate --pretty="%C(bold)%ad%C(reset) %C(yellow)%h%C(reset) %an %C(blue)%s" --date=format:"%y/%m/%d"'
alias gitl="git log --name-only"

# HTTP server
alias hs="python -m http.server"

# Vídeos
alias ym="youtube-dl --extract-audio --audio-format mp3"
alias yd480="youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' --recode-video mp4"
alias cs="convert-video --to-small"
alias c4="convert-video --to-mp4"

# Misc utils
alias zim-fav="vim /home/rafael/Private/Notebooks/Notes/.zim/state.conf"

# Mobile
alias send="kdeconnect-cli -d 'd161511559e94818' --share"

# Browsing
alias gc="cd ~/Code"
alias g.="cd ~/Code/dotfiles/arch"
alias gs="cd ~/Code/scripts"
alias gt="cd ~/Code/data"
alias gd="cd ~/Downloads"
alias ge="cd ~/Sync/Para\ enviar"
alias gS="cd ~/Sync"
alias gv="cd ~/Vídeos"
alias gr="cd /"
alias ga="cd /mnt/airport"
alias gar="mount_and_cd /mnt/airport/rafael"
alias gad="mount_and_cd /mnt/airport/Data"



# ========================================
# FUNCTIONS
# ========================================

# Mkdir and cd to it
mkdirr() {
	mkdir -p -- "$1" && cd -P -- "$1"
}

# Aux - mount if not, and cd
mount_and_cd() {
	[ $# -ne 1 ] && printf "Provide exactly one argument.\n" && return
	mount | grep "$1" > /dev/null || mount "$1" && cd "$1"
}

