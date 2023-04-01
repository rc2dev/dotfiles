-- lualine config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

require'lualine'.setup {
  sections = {
    lualine_a = {
      -- Add paste mode section. Still useful in tmux.
      { 'mode', fmt = function(mode) return vim.go.paste == true and mode .. ' (paste)' or mode end },
    },
  }
}
