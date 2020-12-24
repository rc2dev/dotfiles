" Functionality for taking notes
" Author: Rafael Cavalcanti - rafaelc.org

if ! isdirectory($NOTES)
    finish
endif

let g:notes_resources_dir=$NOTES . '/../resources'
let g:notes_resources_dir_inline='resources'

" fzf: Define command to search notes, ordered by modified date
command! -bang -nargs=0 Notes call fzf#run(fzf#wrap({
    \ 'source': 'find -iname "*.md" -printf "%T@:%p\n" | sort -nr | cut -d: -f2- | sed "s#./##"',
    \ 'dir': '$NOTES',
    \ 'options': ['--prompt', 'Notes/', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']
    \ }))

" fzf: Set keybind to search notes
nnoremap <C-n> :Notes<CR>

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
    autocmd BufWritePost $NOTES/*.md term ++close bash -c "cd '%:p:h' && git add -A && EDITOR='vim -M' git commit -qv -em 'Auto-commit' && git push -q"
augroup END
