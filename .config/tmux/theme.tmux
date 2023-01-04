# tmux theming
#
# Based on <https://github.com/hamvocke/dotfiles/tree/master/tmux>
# by Rafael Cavalcanti <https://rafaelc.org/dev>


# modes
setw -g clock-mode-colour colour5
setw -g mode-style 'fg=colour1 bg=colour18 bold'

# panes
set -g pane-border-style 'fg=colour21 bg=colour0'
set -g pane-active-border-style 'bg=colour0 fg=colour5'

# statusbar
set -g status-position bottom
set -g status-justify left
set -g status-style 'bg=#373b41 fg=colour4'

set -g status-left ' #S  '
set -g status-left-style 'bold italics'
set -g status-left-length 20

set -g status-right '#[italic]#[fg=default]#(whoami)@#H'
set -g status-right-style 'bold italics'
set -g status-right-length 50

setw -g window-status-current-style 'fg=colour7 bg=colour21 bold'
setw -g window-status-current-format ' #I:#[fg=colour7]#W#F '

setw -g window-status-style 'fg=colour250 bg=default'
setw -g window-status-format ' #I:#W#[fg=colour245]#F '

setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'

# messages
set -g message-style 'fg=colour18 bg=colour4 bold'
