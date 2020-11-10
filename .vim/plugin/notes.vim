" Functionality for taking notes
" Author: Rafael Cavalcanti - rafaelc.org

let g:notes_dir=$NOTES
let g:notes_resources_dir=$NOTES . '/_resources'
let g:notes_resources_dir_inline='_resources'

" fzf: Set special keybinds to search notes
command! -bang NFiles call fzf#vim#files(g:notes_dir, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
noremap <C-n> :NFiles<CR>

augroup note_config
	" md-img-paste: Save images to resources folder
	autocmd BufNewFile,BufRead $NOTES/*
		\ let g:mdip_imgdir_absolute = g:notes_resources_dir |
		\ let g:mdip_imgdir = g:notes_resources_dir |
		\ let g:mdip_imgdir_intext = g:notes_resources_dir_inline

	" Template for new notes
	autocmd BufNewFile $NOTES/*.md Template *note

	" Auto-commit to git on save
	autocmd BufWritePost $NOTES/*.md silent !bash -c "cd '%:p:h' && git reset && git add -A && EDITOR='vim -M' git commit -qv -em 'Auto-commit' && git push -q || git reset"
	autocmd BufWritePost $NOTES/*.md redraw!
augroup END
