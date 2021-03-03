" Functionality for taking notes
" Author: Rafael Cavalcanti - rafaelc.org

if ! isdirectory($NOTES)
    finish
endif

let s:notes_dir=resolve($NOTES) " autocmd needs the real path
let s:notes_wildcard=s:notes_dir . '/*.md'
let s:journal_dir=s:notes_dir . '/Eu Inc/Journal'
let s:resources_dir=s:notes_dir . '/../resources'
let s:resources_dir_inline='/resources'

" fzf: Define command to search notes, ordered by modified date
command! -bang -nargs=0 Notes call fzf#run(fzf#wrap({
    \ 'source': 'find -iname "*.md" -printf "%T@:%p\n" | sort -nr | cut -d: -f2- | sed "s#./##"',
    \ 'dir': s:notes_dir,
    \ 'options': ['--prompt', 'Notes/', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']
    \ }))

" fzf: Set keybind to search notes
nnoremap <C-n> :Notes<CR>

" Start a new journal entry
command! -nargs=0 Journal execute 'edit ' . s:journal_dir . '/' . strftime('%Y-%m-%d %H%M%S %z') . '.md'

function NotesCommit()
    " Redirect git commit output, as it prints output if there is nothing to
    " commit, even with -q.
    silent execute "!cd '" . s:notes_dir . "'; git add '%:p' && git add '" . s:resources_dir . "' && git commit -qm 'Auto-commit' >/dev/null 2>&1 && git push -q"
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

" Add command to toggle autocommit
command! -nargs=0 NotesAutoCommitToggle call NotesAutoCommitToggle()

" Copy file to resources and add markdown reference
function NotesInsertFile(src)
    if ! filereadable(a:src)
        echo 'File not found.'
        return
    endif

    let l:basename = fnamemodify(a:src, ":t")
    let l:dest = s:resources_dir . "/" . l:basename

    if filereadable(l:dest)
        echo 'A file with the same name already exists. Aborted.'
        return
    endif

    call system("cp '" . a:src . "' '" .  l:dest . "'")

    execute "normal i[](" . s:resources_dir_inline . "/" . l:basename . ")F]"
    execute "startinsert"
endfunction

" Add command to insert file
command! -nargs=1 -complete=file NotesInsertFile call NotesInsertFile(<f-args>)

augroup notes
    " Use execute so we can use a variable as autocmd's {pat}

    " md-img-paste: Save images to resources folder
    execute 'autocmd BufNewFile,BufRead ' . s:notes_wildcard .
        \ ' let g:mdip_imgdir_absolute = "' . s:resources_dir . '" |'
        \ ' let g:mdip_imgdir_intext = "' . s:resources_dir_inline . '" |'
        \ ' let g:mdip_imgdir = "' . s:resources_dir . '"'

    " Add completion for tags
    execute 'autocmd BufNewFile,BufRead ' . s:notes_wildcard . ' setlocal complete+=k'
    execute 'autocmd BufNewFile,BufRead ' . s:notes_wildcard .
        \ ' setlocal dictionary+=' . s:notes_dir . '/../tags.txt'
    execute 'autocmd BufNewFile,BufRead ' . s:notes_wildcard . ' setlocal iskeyword+=@'

    " Automatically open completion popup for tags
    execute 'autocmd BufNewFile,BufRead ' . s:notes_wildcard . ' inoremap <buffer> @ @<C-x><C-k>'

    " Template for new notes
    execute 'autocmd BufNewFile ' . s:notes_wildcard ' Template *note'

    " Go to last line on opening
    execute 'autocmd BufRead ' . s:notes_wildcard . ' normal G'

    " Auto-commit to git on save
    execute 'autocmd BufWritePost ' . s:notes_wildcard ' if g:notes_autocommit | call NotesCommit() | endif'
augroup END
