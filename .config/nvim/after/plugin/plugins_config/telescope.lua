-- telescope config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

local actions = require('telescope.actions')
local config = require('telescope.config')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

-- Grep hidden files, except .git
table.insert(vimgrep_arguments, '--hidden')
table.insert(vimgrep_arguments, '--glob')
table.insert(vimgrep_arguments, '!.git/*')

require('telescope').setup{
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-u>'] = false,  -- clear input
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
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
