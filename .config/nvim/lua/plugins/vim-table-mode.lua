return {
  "dhruvasagar/vim-table-mode",
  ft = "markdown",

  dependencies = {
    "godlygeek/tabular", -- Necessário para :TableFormat funcionar
  },

  init = function ()
    vim.api.nvim_set_keymap("n", "<leader>tf", ":TableFormat<CR>", { noremap=true, silent=true })
  end
}
