" Author: Rafael Cavalcanti - rafaelc.org

" Suggested by :help write-filetype-plugin
if exists('b:did_ftplugin')
    finish
  endif
let b:did_ftplugin = 1

" Create a markdown link structure with the URL from clipboard.
nnoremap <Leader>l i [](<C-r>*)<Esc>F[a
vnoremap <Leader>l "ldi[<C-r>l](<C-r>*)

" markdown-preview
nnoremap <F5> :MarkdownPreview<CR>
inoremap <F5> <C-o>:MarkdownPreview<CR>

" md-img-paste
inoremap <buffer><silent> <C-b> <C-o>:call mdip#MarkdownClipboardImage()<CR>
