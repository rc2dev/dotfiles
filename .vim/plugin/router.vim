" rooter config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

let g:rooter_silent_chdir = 1

" Identify NOTES root when .git is not synced, using .stfolder (other elements
" are from default value).
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.stfolder']

