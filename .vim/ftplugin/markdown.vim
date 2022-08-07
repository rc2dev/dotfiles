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

" Set makeprg
setlocal makeprg=pandoc\ --pdf-engine=xelatex\ '%'\ $*\ \-o\ '/tmp/vim_pandoc.pdf'

" Set "run" shortcut
nnoremap <silent> <F5> :w<CR>:make<CR>:silent !xdg-open '/tmp/vim_pandoc.pdf' &<CR>

" Create a markdown link structure with the URL from clipboard.
nnoremap <Leader>l i[](<C-r>*)<Esc>F[a
vnoremap <Leader>l "ldi[<C-r>l](<C-r>*)

" md-img-paste
inoremap <buffer><silent> <C-b> <C-o>:call mdip#MarkdownClipboardImage()<CR>
