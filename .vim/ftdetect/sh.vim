" Files without extension on bin directories
autocmd BufNewFile */bin/* if expand('%:t') !~ '\.' | set filetype=sh | endif
