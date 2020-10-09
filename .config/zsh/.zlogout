# zlogout
# Author: Rafael Cavalcanti - rafaelc.org

# Termux: Release wake-lock grabbed upon SSH connection
# Check if this is the only session
if [[ "$HOST" == "localhost" && -n "$SSH_CLIENT" && "$(ps ax | grep 'sshd -R' | wc -l)" -le 2 ]]; then
  printf "Releasing wake-lock...\n" 1>&2
  termux-wake-unlock
fi

