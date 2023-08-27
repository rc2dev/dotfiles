-- telescope config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },

    -- Extension to use fzf as fuzzy finder
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build =  'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
  },


  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        file_ignore_patterns =  { '.git/' },
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-u>'] = false,  -- clear input
            ['<esc>'] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    -- Extensions
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('projects')

    -- Create commands for DRY code
    function search_dotfiles()
      require('telescope.builtin').find_files {
        find_command = {'dotfiles', 'ls-files'},
        cwd = '$HOME',
        prompt_title = 'Dotfiles',
      }
    end
    vim.api.nvim_create_user_command('TeNotes', 'Telescope find_files cwd=$NOTES prompt_title=Notes hidden=true', {})
    vim.api.nvim_create_user_command('TeCode', 'Telescope find_files cwd=$HOME/dev prompt_title=Dev hidden=true', {})
    vim.api.nvim_create_user_command('TeDotfiles', search_dotfiles, {})
  end,
}
