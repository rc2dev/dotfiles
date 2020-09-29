# zlogout
# Author: Rafael Cavalcanti - rafaelc.org

# Termux: Release wake-lock grabbed upon SSH connection
if [[ "$HOST" == "localhost" && -n "$SSH_CLIENT" ]]; then
  printf "Releasing wake-lock...\n" 1>&2
  termux-wake-unlock
fi

