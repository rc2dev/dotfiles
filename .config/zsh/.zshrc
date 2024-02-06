# zshrc
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>


# Automatically start tmux if connected via SSH
# Must come before p10k instant prompt.
if [[ -z "$TMUX" && -n "$SSH_CLIENT" ]]; then
  tmux attach || tmux >/dev/null 2>&1
fi

# Create directories
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
ZSH_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
mkdir -p "$ZSH_CACHE_DIR" "$ZSH_STATE_DIR"


############################################################
### Cursor: Change shape for different vi modes
############################################################

function zle-keymap-select() {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';; # block
    viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


############################################################
### Powerlevel10k instant prompt
############################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


############################################################
### History
############################################################

HISTFILE="${ZSH_STATE_DIR}/history"
HISTSIZE=5000
SAVEHIST=10000

# Record timestamp of command
setopt extended_history

# Ignore commands that start with space
setopt hist_ignore_space

# Share history between terminals
setopt share_history


############################################################
### Behaviour
############################################################

# Globbing: Use ^ to negate
setopt extendedglob

# Automatically quote pasted URLs
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Don't prompt on `rm *` (rm is already aliased to do it)
setopt rm_star_silent

# Allow comments in interactive shells
setopt interactivecomments

# Pushd
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME PUSHD_IGNORE_DUPS
alias d='dirs -v && read index && let "index=$index+0" && cd ~"$index" \
  && let "index=$index+1" && popd -q +"$index"'


############################################################
### Keybindings
############################################################

# Use vim navigation keys in menu completion
zmodload zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# History with arrow up/down
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Move to beginning/end of words with ctrl
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Delete word with ctrl+delete and ctrl+backspace
bindkey '^H' backward-kill-word
bindkey '^[[M' kill-word

# Move to beginning/end of line with Home/End
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line

# Fix delete key
bindkey "^[[P" delete-char  # st
bindkey "^[[3~" delete-char  # tmux

# Add keybinding for editing in text editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line
bindkey -a "^e" edit-command-line  # On vim's normal mode

# Add keybinding for going to parent dir (Alt+Up)
# Redraw powerlevel10k prompt.
redraw-prompt() {
  local f
  for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
    [[ "${+functions[$f]}" == 0 ]] || "$f" &>/dev/null || true
  done
  p10k display -r
}
up-directory() {
  builtin cd .. && redraw-prompt
}
zle -N up-directory
bindkey '^[[1;3A' up-directory


############################################################
### Sourcing and plugins
############################################################

# powerlevel10k prompt
if [[ -e "$HOME/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme"

  # To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
  [[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"
fi

# apt's command-not-found
if [[ -e "/etc/zsh_command_not_found" ]]; then
  source "/etc/zsh_command_not_found"
fi

# zoxide
eval "$(zoxide init zsh)"

# aliases
source "$ZDOTDIR/aliases"


###########################################################
### Completion (should be after loading plugins)
###########################################################

autoload -Uz compinit
compinit -d "${ZSH_CACHE_DIR}/zcompdump-$ZSH_VERSION"

# Show hidden files on completion
setopt globdots

# Use arrow-key driven interface for completion
zstyle ':completion:*' menu select

# Use colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Small letters to match small and capital letters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Complete all processes with kill and killall
zstyle ':completion:*:processes' command ps axh -o user,pid,%cpu,%mem,start,cmd
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command ps axh -o cmd

# ssh, rsync...
# Disable login name completion
zstyle ':completion:*:(rsh|scp|sftp|ssh|rsync):*' users
# Remove localhost from completion
zstyle ':completion:*:(rsh|scp|sftp|ssh|rsync):*:hosts' ignored-patterns 'localhost|localhost[46.]*'


############################################################
### Non-zsh
############################################################

# less: Have less (and man) display colours
# Based on <https://unix.stackexchange.com/a/147>.
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 11)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 15)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For konsole and gnome-terminal

