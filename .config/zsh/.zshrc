# zshrc
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>


ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR"


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
# Interface
#####################################################################
# Use emacs keybindings
set -o emacs

# Use vim navigation keys in menu completion
zmodload zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# History with arrow up/down and vim's ctrl+jk
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search

# Move to beginning/end of words with ctrl
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Delete word with ctrl+delete and ctrl+backspace
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey ';5~' kill-word

# Move to beginning/end of line with Home/End
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line

# Fix delete key on Termux
bindkey "^[[P" delete-char

# Add keybinding for editing in text editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# Add keybinding for going to parent dir
bindkey -s "^U" 'cd ..^M'

# Set cursor as bar
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

######################################################################
# Behaviour
######################################################################
# Globbing: Use ^ to negate
setopt extendedglob

# Automatically quote pasted URLs
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Don't prompt on `rm *` (rm is already aliased to do it)
setopt rm_star_silent


#####################################################################
# Plugins framework
#####################################################################
# Source zinit
declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.local/share/zsh/zinit"
source "$ZINIT[HOME_DIR]/bin/zinit.zsh"


#####################################################################
# Plugins sourcing
#####################################################################
# Plugins from robbyrussell's oh-my-zsh
for plugin in "command-not-found" "git"; do
  zinit snippet OMZ::plugins/$plugin/$plugin.plugin.zsh
done

# fzf
zinit snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh'
zinit snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh'

[[ $SLOW_HOST == 1 ]] || zinit light zsh-users/zsh-autosuggestions

zinit light denysdovhan/spaceship-prompt

# Should be last
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# RVM: Load RVM into a shell session *as a function*
zinit ice wait lucid
[[ -s "$HOME/.rvm/scripts/rvm" ]] && zinit snippet "$HOME/.rvm/scripts/rvm"

zinit ice wait lucid
# Don't create aliases (z, zi); we'll define later
command -v zoxide >/dev/null && eval "$(zoxide init --no-aliases zsh)"


#####################################################################
# Plugins configuration
#####################################################################
# fzf
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FD_DIRS"
# Rebind ^T to ^P (bring back default bind)
bindkey "^P" fzf-file-widget
bindkey "^T" self-insert


#####################################################################
# Completion (should be after loading plugins with zinit)
#####################################################################
autoload -Uz compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump"

# Show hidden files on completion
setopt globdots

# Use arrow-key driven interface for completion
zstyle ':completion:*' menu select

# Use colors
eval "$(dircolors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Small letters to match small and capital letters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Complete ssh hosts with ~/.ssh/config
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users

# Complete all processes with kill and killall
zstyle ':completion:*:processes' command ps axh -o user,pid,%cpu,%mem,start,cmd
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command ps axh -o cmd


######################################################################
# Non-zsh
######################################################################
source $ALIASES

# Prompt active tmux sessions
if [[ -z "$TMUX" ]]; then
  tmux_sessions="$(tmux ls 2>/dev/null | wc -l)"
  if [[ "$tmux_sessions" != "0" ]]; then
    printf "Sessões tmux ativas: %s\n" $tmux_sessions
  fi
fi

