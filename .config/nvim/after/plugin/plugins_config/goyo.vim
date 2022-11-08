" goyo config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Hide lualine
autocmd! User GoyoEnter nested lua require('lualine').hide()
autocmd! User GoyoLeave nested lua require('lualine').hide({unhide=true})
