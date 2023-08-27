-- alpha.nvim config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return  {
  "goolord/alpha-nvim",
  config = function()
    require("alpha").setup(require("alpha.themes.dashboard").config)
  end,
}

