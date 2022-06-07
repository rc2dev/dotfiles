# anacrontab: user configuration file for anacron @ rd
#
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

@daily 5 update-ytdlp bash -c 'source ~/.zprofile && chronic pipx upgrade yt-dlp'
