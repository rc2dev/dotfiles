-- init.lua
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

-- Must be done before sourcing lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = ","

if vim.fn.has("nvim-0.8") == 1 then
  require("lazy-loader")
end
