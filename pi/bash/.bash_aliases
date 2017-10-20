# Autor: Rafael Cavalcanti
# Aliases para facilitar minha vida

# System
alias t="/opt/vc/bin/vcgencmd measure_temp"
alias m="sudo mount /airport"
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
#alias kt="echo 'Iniciando Kodi e VNC...' && tvservice -p && sudo systemctl start mediacenter && \
#	sudo systemctl start vnc"
#alias kr="echo 'Reiniciando Kodi...' && tvservice -p && sudo systemctl restart mediacenter"
#alias ks="echo 'Parando Kodi...' && sudo systemctl stop mediacenter"
#alias kt="tvservice -p && sudo -b -u kodi kodi"
#alias ks="sudo killall -u kodi"
alias kt="tvservice -p; sudo systemctl start kodi"
alias kr="tvservice -p; sudo systemctl restart kodi"
alias ks="sudo systemctl stop kodi"
#alias tt="echo 'Iniciando Thin...' && sudo /etc/init.d/thin start"
#alias tr="echo 'Reiniciando Thin...' && sudo /etc/init.d/thin restart"
#alias ts="echo 'Parando Thin...' && sudo /etc/init.d/thin stop"
#alias nt="echo 'Iniciando Nginx...' && sudo systemctl start nginx"
#alias nr="echo 'Reiniciando Nginx...' && sudo systemctl restart nginx"
#alias lt="echo 'Iniciando Lighthttpd...' && sudo systemctl start lighttpd"
#alias lr="echo 'Reiniciando Lighttpd...' && sudo systemctl restart lighttpd"

# rcradio
alias rcradio-update="cd /srv/http/rcradio/ && ts && git pull && tt"

# TV and HDMI output
alias td='tvservice --off && echo "standby 0" | cec-client -s'
alias tl='echo "on 0" | cec-client -s'
alias hd="tvservice -o"
alias hl="tvservice -p"

# Misc
alias d="mpc pause && sleep 4 && mpc play"
#alias add="sudo ip address add 192.168.0.89/24 dev wlan0"

