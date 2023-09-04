-- vim-tmux-navigator config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

-- It also needs a plugin on tmux.
return {
  "christoomey/vim-tmux-navigator",

  -- Load even outside tmux, as keybindings always call these commands.
  cmd = { 'TmuxNavigateUp', 'TmuxNavigateDown', 'TmuxNavigateLeft', 'TmuxNavigateRight' }
}

