-- goyo config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  "junegunn/goyo.vim",
  cmd = "Goyo",

  init = function ()
    -- Hide lualine
    vim.cmd [[
      autocmd! User GoyoEnter nested lua require('lualine').hide()
      autocmd! User GoyoLeave nested lua require('lualine').hide({unhide=true})
    ]]
  end,
}
