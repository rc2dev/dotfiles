" New files without extension on bin directories
" Also run vim-template.
autocmd BufNewFile */bin/* if expand('%:t') !~ '\.' | set filetype=sh | execute 'Template *.sh' | endif
