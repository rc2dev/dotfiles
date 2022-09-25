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

" Create a markdown link structure with the URL from clipboard.
inoremap <F4> [](<C-r>*)<Esc>F[a
nnoremap <F4> i[](<C-r>*)<Esc>F[a
vnoremap <F4> "ldi[<C-r>l](<C-r>*)

" Set makeprg
setlocal makeprg=pandoc\ --pdf-engine=xelatex\ '%'\ $*\ \-o\ '%:r.pdf'

" Set "run" shortcut
nnoremap <silent> <F5> :w<CR>:make<CR>:silent !xdg-open '%:r.pdf' &<CR>

" Use friendlier line navigation
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" md-img-paste
nnoremap <buffer><silent> <leader>im :call mdip#MarkdownClipboardImage()<CR>
