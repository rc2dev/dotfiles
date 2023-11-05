-- alpha.nvim config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return  {
  "goolord/alpha-nvim",

  config = function()
    --require("alpha").setup(require("alpha.themes.startify").config)
    local alpha = require("alpha")
    local startify = require("alpha.themes.startify")

    -- add l for enter
    startify.config.opts.keymap = {
      press = { '<CR>', 'l' },
    }

    -- Add quick note button
    startify.section.top_buttons.val = {
      startify.button( "n", "  New file" , ":enew<CR>"),
      startify.button( "u", "  Quick Note" , ":e $NOTES/notes/Quick Note.md<CR>"),
    }

    alpha.setup(startify.config)
  end,
}

