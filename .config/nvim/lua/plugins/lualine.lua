-- lualine config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  'nvim-lualine/lualine.nvim',

  opts = {
    options = {
      disabled_filetypes = { 'NvimTree', 'alpha' },
    },

    sections = {
      lualine_a = {
        -- Add paste mode section. Still useful in tmux.
        { 'mode', fmt = function(mode) return vim.go.paste == true and mode .. ' (paste)' or mode end },
      },
    }
  }
}
