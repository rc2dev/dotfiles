# Pi aliases
#
# Rafael Cavalcanti

# Check if we are on OSMC
[[ $(cat /etc/issue) = *"OSMC"* ]] && osmc=1 || osmc=0

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

# Kodi - backup aliases
if [[ $osmc == 0 ]]; then
	alias backup-kodi="kodi-send --host=127.0.0.1 --action='RunScript(script.xbmcbackup, mode=backup)'"
fi

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
alias gap="cd /airport_pi"
alias gd="cd /airport/Downloads"
alias gm="cd /airport/Músicas"
alias gk="cd /var/lib/kodi/.kodi"
alias gr="cd /opt/rc"
alias gt="cd /opt/rc/data"
alias g.="cd /opt/rc/dotfiles/pi"
alias gp="cd /opt/rc/pi-scripts"
alias gh="cd /srv/http"

# Misc
alias d="mpc pause && sleep 1 && mpc play"
alias mu="pactl set-sink-mute alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo \
	true && echo Muted."
alias um="pactl set-sink-mute alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo \
	false && echo Unmuted."

#alias add="sudo ip address add 192.168.0.89/24 dev wlan0"
