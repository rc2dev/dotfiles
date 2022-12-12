# tmux theming
#
# Based on <https://github.com/hamvocke/dotfiles/tree/master/tmux>
# by Rafael Cavalcanti <https://rafaelc.org/dev>


# modes
setw -g clock-mode-colour colour5
setw -g mode-style 'fg=colour1 bg=colour18 bold'

# panes
set -g pane-border-style 'fg=colour19 bg=colour0'
set -g pane-active-border-style 'bg=colour0 fg=colour5'

# statusbar
set -g status-position bottom
set -g status-justify left
set -g status-style 'bg=black fg=colour4'
set -g status-left ' #S '
set -g status-left-style 'fg=colour1 bg=colour19'
set -g status-right '#[fg=red]#{pomodoro_status} #[fg=default]#H'
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-style 'fg=colour1 bg=colour19 bold'
setw -g window-status-current-format ' #I #[fg=colour7]#W#F '

setw -g window-status-style 'fg=colour1 bg=default'
setw -g window-status-format ' #I #[fg=colour250]#W#[fg=colour244]#F '

setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'

# messages
set -g message-style 'fg=colour18 bg=colour4 bold'
