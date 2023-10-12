-- Plugins loading
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

local function load_lazy ()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  local opts = {
    change_detection = {
      notify = false,
    },
  }
  require("lazy").setup("plugins", opts)
end

-- Must be done before sourcing lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = ","

if vim.fn.has("nvim-0.8") == 1 then
  load_lazy()
end
