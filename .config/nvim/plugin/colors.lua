-- Colors config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

vim.cmd [[
  " Uncomment this for transparency
  " Only apply on dark themes. Don't do it on gvim as it will get messed up.
  autocmd ColorScheme * if ! has('gui_running') && &bg == "dark" | hi Normal guibg=NONE ctermbg=NONE | endif
]]

-- Use truecolors
vim.opt.termguicolors = true

vim.cmd [[
  " We won't have the theme on first run
  try
    colorscheme gruvbox
  catch /^Vim\%((\a\+)\)\=:E185/
  endtry
]]

-- Let darkman handle background if loaded
if type(vim.g.DarkmanSetup) == nil then
  vim.opt.bg = dark
end
