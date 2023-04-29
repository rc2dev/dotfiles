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
inoremap <F4> [](<C-o>p)<Esc>F[a
nnoremap <F4> i[](<C-o>p)<Esc>F[a
vnoremap <F4> "ldi[<C-r>l](<C-o>p)

" Set pandoc shortcut
nnoremap <buffer><silent> <leader>mp :w<CR>:silent !pandoc --defaults markdown.yml '%' -o '%:r.pdf'<CR>:silent !gio open '%:r.pdf'<CR>

" Set browser shortcut
nnoremap <buffer><silent> <leader>mw :w<CR>:silent !$BROWSER '%' &<CR>

" Use friendlier line navigation
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" md-img-paste
nnoremap <buffer><silent> <leader>mi :call mdip#MarkdownClipboardImage()<CR>
