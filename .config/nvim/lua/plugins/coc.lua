return {
  "neoclide/coc.nvim",
  branch = "release",

  -- Configuration based on documentation from coc.nvim
  -- (<https://github.com/neoclide/coc.nvim#example-vim-configuration>)
  config = function()
    vim.cmd([[
      " Testing json, git, tsserver, makdownlint, pyright
      let g:coc_global_extensions = [
      \ '@yaegassy/coc-astro',
      \ '@yaegassy/coc-tailwindcss3',
      \ 'coc-git',
      \ 'coc-json',
      \ 'coc-markdownlint',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-tsserver',
      \ ]

      " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
      " delays and poor user experience
      set updatetime=300

      " Always show the signcolumn, otherwise it would shift the text each time
      " diagnostics appear/become resolved
      set signcolumn=yes
      ]])

    -- Mappings
    vim.cmd([[
      " Use tab to accept selected completion.
      " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
      " other plugin before putting this into your config
      inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#confirm() :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()

      " Make <CR> to accept selected completion item or notify coc.nvim to format
      " <C-g>u breaks current undo, please make your own choice
      inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Use <c-space> to trigger completion
      if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
      else
        inoremap <silent><expr> <c-@> coc#refresh()
      endif

      " Use `[g` and `]g` to navigate diagnostics
      " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
      nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
      nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

      " GoTo code navigation
      nmap <silent><nowait> gd <Plug>(coc-definition)
      nmap <silent><nowait> gy <Plug>(coc-type-definition)
      nmap <silent><nowait> gi <Plug>(coc-implementation)
      nmap <silent><nowait> gr <Plug>(coc-references)

      " Use K to show documentation in preview window
      nnoremap <silent> K :call ShowDocumentation()<CR>

      function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
        else
          call feedkeys('K', 'in')
        endif
      endfunction

      " Highlight the symbol and its references when holding the cursor
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Symbol renaming
      nmap <leader>rn <Plug>(coc-rename)

      " Formatting selected code
      xmap <leader>fc <Plug>(coc-format-selected)
      nmap <leader>fc <Plug>(coc-format-selected)

      augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s)
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      augroup end

      " Applying code actions to the selected code block
      " Example: `<leader>aap` for current paragraph
      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)

      " Remap keys for applying code actions at the cursor position
      nmap <leader>ac  <Plug>(coc-codeaction-cursor)
      " Remap keys for apply code actions affect whole buffer
      nmap <leader>as  <Plug>(coc-codeaction-source)
      " Apply the most preferred quickfix action to fix diagnostic on the current line
      nmap <leader>qf  <Plug>(coc-fix-current)

      " Remap keys for applying refactor code actions
      nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
      xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
      nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

      " Run the Code Lens action on the current line
      nmap <leader>cl  <Plug>(coc-codelens-action)
      " Create command for Prettier
      command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

      " Add `:Format` command to format current buffer
      command! -nargs=0 Format :call CocActionAsync('format')

      " Add `:Fold` command to fold current buffer
      command! -nargs=? Fold :call CocAction('fold', <f-args>)

      " Add `:OR` command for organize imports of the current buffer
      command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
    ]])
  end,
}
