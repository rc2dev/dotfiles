-- vim-template config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  'aperezdc/vim-template',

  init = function ()
    vim.g.templates_directory = {'$HOME/.config/nvim/templates'}

    -- Replace colon as Android 11 doesn't like them.
    vim.g.templates_name_prefix = '.vim-template_'

    vim.g.templates_no_builtin_templates = 1

    vim.cmd [[
    " Only remove last extension
    function GetFileNoExt()
      return expand('%:t:r')
    endfunction

    function GetFullDate()
      return strftime('%Y-%m-%d %T %z')
    endfunction
    ]]

    vim.g.templates_user_variables = {
       {'FILE1', 'GetFileNoExt'},
       {'FDATE1', 'GetFullDate'}
     }
  end,
}
