# zshrc
# Author: Rafael Cavalcanti - rafaelc.org

#####################################################################
# Plugins
#####################################################################
source "$ZDOTDIR/antigen/antigen.zsh"

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle autojump
antigen bundle command-not-found
antigen bundle git
antigen bundle last-working-dir
antigen bundle systemd

# Other bundles
$SLOW_HOST || antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle denysdovhan/spaceship-prompt

antigen apply


#####################################################################
# History
####################################################################
HISTFILE=~/.cache/zsh_history
HISTSIZE=5000
SAVEHIST=10000


#####################################################################
# Completion
#####################################################################
autoload -Uz compinit
compinit

# Show hidden files on completion
setopt globdots

# Use arrow-key driven interface for completion
zstyle ':completion:*' menu select


#####################################################################
# Interface
#####################################################################
# Use emacs bindings
bindkey -e

# History with arrow up/down
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# Move to beginning/end of words with ctrl
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Add keybinding for editing in VIM
bindkey "^E" edit-command-line


######################################################################
# Behaviour
######################################################################
# Globbing: Use ^ to negate
setopt extendedglob

# Execute lines with history expansion directly
setopt nohist_verify


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
