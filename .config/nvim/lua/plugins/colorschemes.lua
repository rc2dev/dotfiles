-- colorscheme plugins config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  {
    "joshdick/onedark.vim",
    init = function ()
      -- Enable italics (must precede theme setting)
      vim.g.onedark_terminal_italics = 1
    end,
  },

  {
    "morhetz/gruvbox",
    init = function ()
      -- Enable italics (must precede theme setting)
      vim.g.gruvbox_italic=1
    end,
  }
}
