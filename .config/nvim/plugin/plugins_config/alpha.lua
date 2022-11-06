-- alpha config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

-- Configure theme
dashboard = require('alpha.themes.dashboard')
-- Buttons
dashboard.section.buttons.val = {
   dashboard.button( 'e', '  New file' , ':ene <BAR> startinsert <CR>'),
   dashboard.button( 'h', '  Recent files' , ':Telescope oldfiles<CR>'),
   dashboard.button( 'f', '  Files' , ':Telescope find_files<CR>'),
   dashboard.button( 'g', '  Grep text' , ':Telescope live_grep<CR>'),
   dashboard.button( 'n', '  Notes' , ':TeNotes<CR>'),
   dashboard.button( 'c', '  Code' , ':TeCode<CR>'),
   dashboard.button( 'y', '  Dotfiles' , ':TeDotfiles<CR>'),
   dashboard.button( '?', '？ Help' , ':Telescope help_tags<CR>'),
   dashboard.button( 'q', '  Quit NVIM' , ':qa<CR>'),
}
-- Footer
dashboard.section.footer.val = require('alpha.fortune')
-- Colors
dashboard.section.header.opts.hl = 'Function'
dashboard.section.footer.opts.hl = 'Function'

require('alpha').setup(dashboard.config)

-- Hide status line
vim.cmd[[autocmd FileType alpha set laststatus=0 | autocmd BufUnload <buffer> set laststatus=2]]

