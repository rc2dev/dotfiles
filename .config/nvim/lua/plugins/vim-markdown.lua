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

    -- Don't set default mappings, as gx stopped working.
    -- We'll define them manually below, excluding gx and ge:
    vim.g.vim_markdown_no_default_key_mappings = 1
    vim.api.nvim_set_keymap("n", "]]", "<Plug>Markdown_MoveToNextHeader", { noremap=true, silent=true })
    vim.api.nvim_set_keymap("n", "[[", "<Plug>Markdown_MoveToPreviousHeader", { noremap=true, silent=true })
    vim.api.nvim_set_keymap("n", "][", "<Plug>Markdown_MoveToNextSiblingHeader", { noremap=true, silent=true })
    vim.api.nvim_set_keymap("n", "[]", "<Plug>Markdown_MoveToPreviousSiblingHeader", { noremap=true, silent=true })
    vim.api.nvim_set_keymap("n", "]u", "<Plug>Markdown_MoveToParentHeader", { noremap=true, silent=true })
    vim.api.nvim_set_keymap("n", "]h", "<Plug>Markdown_MoveToCurHeader", { noremap=true, silent=true })
  end
}
