# zshrc
# Author: Rafael Cavalcanti - rafaelc.org


#####################################################################
# History
####################################################################
HISTFILE="$ZSH_CACHE_DIR/history"
HISTSIZE=5000
SAVEHIST=10000

# Record timestamp of command
setopt extended_history

# Ignore commands that start with space
setopt hist_ignore_space

# Share history between terminals
setopt share_history


#####################################################################
# Completion
#####################################################################
autoload -Uz compinit
compinit

# Show hidden files on completion
setopt globdots

# Use arrow-key driven interface for completion
zstyle ':completion:*' menu select

# Small letters to match small and capital letters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Complete ssh hosts with ~/.ssh/config
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users


#####################################################################
# Interface
#####################################################################
# Use emacs bindings
bindkey -e

# History with arrow up/down
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# Move to beginning/end of words with ctrl
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Move to beginning/end of line with Home/End
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Add keybinding for editing in VIM
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line


######################################################################
# Behaviour
######################################################################
# Globbing: Use ^ to negate
setopt extendedglob


#####################################################################
# Plugins
#####################################################################
source "$ZDOTDIR/antigen/antigen.zsh"

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle autojump
antigen bundle command-not-found
antigen bundle git
antigen bundle last-working-dir
antigen bundle systemd

# Other bundles
$SLOW_HOST || antigen bundle zsh-users/zsh-autosuggestions
antigen bundle denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-syntax-highlighting # should be last

antigen apply


######################################################################
# Non-zsh
######################################################################
source $ALIASES

# Hub aliasing
if command -v hub > /dev/null; then
  eval "$(hub alias -s)"
fi

# Prompt active tmux sessions
if [[ -z "$TMUX" ]]; then
  tmux_sessions="$(tmux ls 2>/dev/null | wc -l)"
  if [[ "$tmux_sessions" != "0" ]]; then
    printf "Sessões tmux ativas: %s\n" $tmux_sessions
  fi
fi
