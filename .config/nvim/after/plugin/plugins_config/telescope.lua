-- telescope config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

actions = require 'telescope.actions'

require('telescope').setup{
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  },
}

require('telescope').load_extension('fzf')
