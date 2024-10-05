-- telescope config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  'nvim-telescope/telescope.nvim',
  cmd = {'Telescope'},
  branch = '0.1.x',
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
        path_display = { 'smart' },
        sorting_strategy = 'ascending',
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-u>'] = false,  -- clear input
            ['<esc>'] = actions.close,

            -- Send selected to quickfix list and open
            ["<C-o>"] = function(p_bufnr) require("telescope.actions").send_selected_to_qflist(p_bufnr) vim.cmd.cfdo("edit") end,
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
  end
}
