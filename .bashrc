# ~/.bashrc
#
# Used on some systems such as dietpi.
# Author: Rafael Cavalcanti <dev@rafaelc.org>

# Colorful PS1
# Default on dietpi is... PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$'
PS1='${debian_chroot:+($debian_chroot)}\[\e[32m\]\u@\h:\[\e[0m\]\w\$ '

# History completion
# Check if interactive, so rsync don't throw a warning.
if [ -t 1 ]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# zoxide
eval "$(zoxide init bash)"

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
source "$HOME/.config/zsh/aliases"
