-- zen-mode config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",

  opts = {
    window = {
      width = 80,
      height = 0.9,
    },

    on_open = function (win)
      -- This fixes opacity when using catppuccine colorscheme
      -- with transparency and dim_inactive.
      vim.cmd("hi NormalNC guibg=NONE")
    end,

    on_close = function ()
      -- Reapply current colorscheme to undo changes
      vim.cmd.colorscheme(vim.g.colors_name)
    end,
  }
}
