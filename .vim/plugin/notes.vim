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

function NotesCommit()
    term ++close bash -c "cd '%:p:h' && git add -A && EDITOR='vim -M' git commit -qv -em 'Auto-commit' && git push -q"
endfunction

let g:notes_autocommit = 1
function NotesAutoCommitToggle()
    if g:notes_autocommit
        let g:notes_autocommit = 0
        echo 'Disabled notes auto-commit.'
    else
        let g:notes_autocommit = 1
        echo 'Enabled notes auto-commit.'
        call NotesCommit()
    endif
endfunction

augroup note_config
    " md-img-paste: Save images to resources folder
    autocmd BufNewFile,BufRead $NOTES/*.md
        \ let g:mdip_imgdir_absolute = g:notes_resources_dir |
        \ let g:mdip_imgdir_intext = g:notes_resources_dir_inline

    " Template for new notes
    autocmd BufNewFile $NOTES/*.md Template *note

    " Go to last line on opening
    autocmd BufRead $NOTES/*.md normal G

    " Add keybind for toggling auto-commit
    autocmd BufRead $NOTES/*.md nnoremap <F4> :call NotesAutoCommitToggle()<CR>
    autocmd BufRead $NOTES/*.md inoremap <F4> <C-o>:call NotesAutoCommitToggle()<CR>

    " Auto-commit to git on save
    autocmd BufWritePost $NOTES/*.md if g:notes_autocommit | call NotesCommit() | endif
augroup END
