-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  "ap/vim-css-color",

  "aperezdc/vim-template",

  -- This also needs a plugin on tmux.
  -- Load even outside tmux, as some keybindings call it.
  {
    "christoomey/vim-tmux-navigator",
  },

  "dense-analysis/ale",

  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
  },

  {
    "ferrine/md-img-paste.vim",
    ft = "markdown",
  },

  "gioele/vim-autoswap",

  -- Syntax highlighting for njk files
  "Glench/Vim-Jinja2-Syntax",

  "preservim/nerdcommenter",

  "tpope/vim-sleuth",

  "wincent/loupe",

  -- Colorschemes
  "joshdick/onedark.vim",
  "morhetz/gruvbox",
}

