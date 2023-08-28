-- vim-markdown config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  "preservim/vim-markdown",
  ft = "markdown",

  init = function ()
    vim.g.vim_markdown_toc_autofit = 1
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_auto_insert_bullets = 0
    vim.g.vim_markdown_new_list_item_indent = 0

    -- Try to fix automatic toggling of folding while typing on insert mode
    vim.g.vim_markdown_folding_style_pythonic = 1
  end
}
