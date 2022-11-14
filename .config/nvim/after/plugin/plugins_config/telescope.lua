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
        ['<C-u>'] = false,  -- clear input
      },
    },
  },
}

require('telescope').load_extension('fzf')

function search_dotfiles()
  require('telescope.builtin').find_files {
    find_command = {'dotfiles', 'ls-files'},
    cwd = '$HOME',
    prompt_title = 'Dotfiles',
  }
end

-- Create commands for DRY code
vim.api.nvim_create_user_command('TeNotes', 'Telescope find_files cwd=$NOTES/notes prompt_title=Notes hidden=true', {})
vim.api.nvim_create_user_command('TeCode', 'Telescope find_files cwd=$HOME/Code prompt_title=Code hidden=true', {})
vim.api.nvim_create_user_command('TeDotfiles', search_dotfiles, {})
