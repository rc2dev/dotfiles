" Functionality for taking notes
" Author: Rafael Cavalcanti - rafaelc.org

if ! isdirectory($NOTES)
    finish
endif

let g:notes_resources_dir=$NOTES . '/../resources'
let g:notes_resources_dir_inline='resources'

" fzf: Set keybind to search notes
nnoremap <C-n> :Files $NOTES<CR>

augroup note_config
    " md-img-paste: Save images to resources folder
    autocmd BufNewFile,BufRead $NOTES/*.md
        \ let g:mdip_imgdir_absolute = g:notes_resources_dir |
        \ let g:mdip_imgdir_intext = g:notes_resources_dir_inline

    " Template for new notes
    autocmd BufNewFile $NOTES/*.md Template *note

    " Go to last line on opening
    autocmd BufRead $NOTES/*.md normal G

    " Auto-commit to git on save
    " The arrows would stop working on VIM after returning from commiting.
    " We workaround this using a external terminal.
    autocmd BufWritePost $NOTES/*.md silent !$TERMINAL -e bash -c 'cd "%:p:h" && git add -A && EDITOR="vim -M" git commit -qv -em "Auto-commit" && git push -q'
augroup END
