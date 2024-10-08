" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Suggested by :help write-filetype-plugin
if exists('b:did_ftplugin')
    finish
  endif
let b:did_ftplugin = 1

" Use 4 spaces
setlocal tabstop=4 shiftwidth=4 expandtab

" Enable folding
setlocal foldenable

" Turn spell check on, except on vimdiff
if ! &diff | setlocal spell | endif

" Center cursor
autocmd InsertLeave,InsertEnter * normal zz

" Create a markdown link structure with the URL from clipboard.
nnoremap <buffer> <leader>ml i[](<C-o>p)<Esc>F[a

" Set Toc shortcut
nnoremap <buffer><silent> <leader>mt :Toc<CR>

" Set pandoc shortcut
nnoremap <buffer><silent> <leader>mp :w<CR>:silent !pandoc --defaults markdown.yml '%' -o '%:r.pdf'<CR>:silent !gio open '%:r.pdf'<CR>

" Use friendlier line navigation
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
