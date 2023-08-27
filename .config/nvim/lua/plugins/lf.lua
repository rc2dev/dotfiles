-- lf.vim config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  {
    "ptzz/lf.vim",
    init = function ()
      vim.g.lf_map_keys = 0  -- Don't map keys
      vim.g.lf_height = 0.9
      vim.g.lf_width = 0.9
    end,

    dependencies = {
      {
        -- Must be loaded after lf.
        "voldikss/vim-floaterm",
        init = function ()
          vim.g.floaterm_opener = "edit"
        end,
      }
    },
  }
}
