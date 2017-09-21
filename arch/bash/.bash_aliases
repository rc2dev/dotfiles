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
alias :q="exit"
alias u="unset HISTFILE && export PS1='\n(incognito) $PS1' && echo History unset."

# Apt - quick usage
if  [ -e /usr/bin/apt ]; then
	alias sai="sudo apt install"
	alias sap="sudo aptitude purge"
	alias ash="apt show"
	alias ase="apt search"
	alias sau="sudo apt update"
fi

# Arch's Pacman
if [ -e /usr/bin/pacman ]; then
	alias pu="sudo pacman -Syu && pacaur -u"
	alias pud="sudo pacman -Syu && pacaur -u --devel --needed"
	alias pm="sudo reflector --country Brazil -l 5 --sort rate \
		--save /etc/pacman.d/mirrorlist && echo 'OK.' && sudo pacman -Syy"
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

# Quicker systemd
alias ssc="sudo systemctl"
alias sc="systemctl"

# R509
alias sr9="ssh -t rafael-r509.local sudo "
[ -e /usr/bin/samsung-tools ] && alias si="samsung-tools -c silent"

# Backup
alias jb="journalctl -b -f -u backup"

# Gerar string a partir de /dev/urandom (http://www.commandlinefu.com/commands/view/7234/create-random-string-from-devurandom-or-another-length)
alias ger="cat /dev/urandom | tr -dc "[:alnum:]" | head -c64 && echo"
alias ger2="cat /dev/urandom | tr -dc "[:lower:]" | head -c64 && echo"

# Git log bonito (copiado do Reddit)
alias gitlog='git log --graph --oneline --all --decorate --pretty="%C(bold)%ad%C(reset) %C(yellow)%h%C(reset) %an %C(blue)%s" --date=format:"%y/%m/%d"'
alias gitl="git log --name-only"

# Copy stdin to clipboard
alias clip="xsel -ib"

# HTTP server
alias hs="python -m http.server"

# YouTube
# Baixar áudio em mp3 para Play Music
alias yp="youtube-dl --extract-audio --audio-format mp3"
# Baixar vídeo compatível com iPhone
alias yi="youtube-dl -f '(mp4)[height<480]'"
ycut() {
	if [[ $# != 3 ]]; then
		echo "Usage: ycut URL START-TIME DURATION"
		return
	fi
	youtube-dl --exec "ffmpeg -i {} -ss $2 -t $3 {}_cut.mp4" "$1"
}


# ========== UNUSED ============
# Workaround for WiFi dongle not working after hibernation/suspension
#alias fix_wifi="sudo modprobe -r r8712u && sudo modprobe r8712u && sudo systemctl restart NetworkManager.service"

# C/C++ compilation flags
#alias gcc="gcc -ansi -Wall"
#alias g++="g++ -ansi -Wall"

