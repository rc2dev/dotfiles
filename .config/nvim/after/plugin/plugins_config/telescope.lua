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

-- Create commands for DRY code
vim.api.nvim_create_user_command('TeNotes', 'Telescope find_files cwd=$NOTES/notes', {})
vim.api.nvim_create_user_command('TeCode', 'Telescope find_files cwd=$HOME/Code', {})
-- Dotfiles
vim.api.nvim_create_user_command('TeDotfiles', 'let $GIT_DIR=$HOME . "/.local/share/dotfiles/repo.git" | let $GIT_WORK_TREE=$HOME | Telescope git_files', {})
vim.api.nvim_create_user_command('DotfilesUnset', 'unlet $GIT_DIR | unlet $GIT_WORK_TREE | echo "Dotfiles repo unset."', {})
