-- colorscheme config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

-- Use truecolors
vim.opt.termguicolors = true

return {
  {
    "joshdick/onedark.vim",
    init = function ()
      -- Enable italics (must precede theme setting)
      vim.g.onedark_terminal_italics = 1
    end,
    enabled = false,
  },

  {
    "morhetz/gruvbox",
    init = function ()
      -- Enable italics (must precede theme setting)
      vim.g.gruvbox_italic = 1
    end,
    enabled = false,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      dim_inactive = {
        enabled = true,
      },
    },
    init = function ()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
