" Abbreviations config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Commenting
iab rca [RC added]
iab rcc [RC]
iab rcp Copyright (C) <C-r>=strftime('%Y')<CR> Rafael Cavalcanti <https://rafaelc.org/dev><CR>Licensed under GPLv3<CR>
iab rct Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Portuguese typing
iab dps depois
iab Dps Depois
iab mt muito
iab Mt Muito
iab pq porque
iab Pq Porque
iab q que
iab tb também
iab Tb Também
iab tlvz talvez
iab Tlvz Talvez
iab vc você
iab Vc Você
iab vcs vocês
iab Vcs Vocês

" Command mode
cabbr <expr> %% fnameescape(expand('%:p:h'))

