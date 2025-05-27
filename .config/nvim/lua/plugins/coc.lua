return {
  "neoclide/coc.nvim",
  branch = "release",

  config = function()
    vim.cmd([[
      " Testing json, git, tsserver, makdownlint
      let g:coc_global_extensions = [ 'coc-json', 'coc-git', 'coc-prettier', '@yaegassy/coc-tailwindcss3', 'coc-tsserver', 'coc-markdownlint', '@yaegassy/coc-astro']
      ]])
  end,
}

