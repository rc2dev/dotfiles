" Author: Rafael Cavalcanti - rafaelc.org

" Suggested by :help write-filetype-plugin
if exists('b:did_ftplugin')
    finish
  endif
let b:did_ftplugin = 1

" Disable sleuth
let b:sleuth_automatic = 0
" Markor uses 4 spaces, so this makes our life easier.
setlocal tabstop=4 shiftwidth=4 expandtab

" Hide text such as bold, italic
setlocal conceallevel=2

" Set makeprg
setlocal makeprg=pandoc\ --pdf-engine=xelatex\ '%'\ $*\ \-o\ '/tmp/vim_pandoc.pdf'

" Set "run" shortcut
nnoremap <F5> :make<CR>:silent !xdg-open '/tmp/vim_pandoc.pdf' &<CR>

" Create a markdown link structure with the URL from clipboard.
nnoremap <Leader>l i [](<C-r>*)<Esc>F[a
vnoremap <Leader>l "ldi[<C-r>l](<C-r>*)

" md-img-paste
inoremap <buffer><silent> <C-b> <C-o>:call mdip#MarkdownClipboardImage()<CR>
