# Autor: Rafael Cavalcanti
# Aliases para facilitar minha vida

# System
alias t="/opt/vc/bin/vcgencmd measure_temp"
alias reb="sudo reboot"
alias wel="/etc/profile.d/999-rcwelcome.sh"

# Console
alias watch="watch "
alias x="exit"
alias la="ls -a"
alias ll="ls -lh"
alias df="df -h"
alias free="free -h"

# Services
alias kt="sudo systemctl start kodi"
alias kr="sudo systemctl restart kodi"
alias ks="sudo systemctl stop kodi"
alias lt="sudo systemctl start lightdm"
alias lst="sudo systemctl stop lightdm"
alias tr="sudo systemctl restart thin"
#alias tt="echo 'Iniciando Thin...' && sudo /etc/init.d/thin start"
#alias tr="echo 'Reiniciando Thin...' && sudo /etc/init.d/thin restart"
#alias ts="echo 'Parando Thin...' && sudo /etc/init.d/thin stop"

# TV and HDMI output
alias td='tvservice --off && echo "standby 0" | cec-client -s'
alias tl='echo "on 0" | cec-client -s'
alias hd="tvservice -o"
alias hl="tvservice -p"

# Videos
alias yd="cd /airport/Downloads && youtube-dl"
alias y480="cd /airport/Downloads && youtube-dl \
	-f 'bestvideo[height<=480]+bestaudio/best[height<=480]' --recode-video mp4"
alias cs="convert-video --to-small"
alias c4="convert-video --to-mp4"

# Browsing
alias ga="cd /airport"
alias gd="cd /airport/Downloads"
alias gm="cd /airport/Músicas"
alias gr="cd /opt/rc"
alias gs="cd /opt/rc/scripts/pi"
alias g.="cd /opt/rc/dotfiles/pi"
alias gt="cd /opt/rc/data"
alias gh="cd /srv/http"

# Misc
alias d="mpc pause && sleep 1 && mpc play"
#alias add="sudo ip address add 192.168.0.89/24 dev wlan0"
