-- colorscheme config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

-- Use truecolors
vim.opt.termguicolors = true

return {
  {
    "morhetz/gruvbox",
    init = function ()
      -- Enable italics (must precede theme setting)
      vim.g.gruvbox_italic = 1
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
      dim_inactive = {
        enabled = true,
      },
    },
    init = function ()
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
}
