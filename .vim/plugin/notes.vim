" Functionality for calling note taking
" Author: Rafael Cavalcanti - rafaelc.org

if ! isdirectory($NOTES)
    finish
endif

let s:notes_dir=resolve($NOTES)
let s:journal_dir=s:notes_dir . '/Journal'

" fzf: Define command to search notes, ordered by modified date
command! -bang -nargs=0 Notes call fzf#run(fzf#wrap({
    \ 'source': 'find -iname "*.md" -printf "%T@:%p\n" | sort -nr | cut -d: -f2- | sed "s#./##"',
    \ 'dir': s:notes_dir,
    \ 'options': ['--prompt', 'Notes/', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']
    \ }))

" fzf: Set keybind to search notes
nnoremap <C-n> :Notes<CR>

" Start a new journal entry
command! -nargs=0 Journal execute 'edit ' .
    \ s:journal_dir . '/' . strftime('%Y-%m') . '/' . strftime('%Y-%m-%d %H%M%S') . '.md'

