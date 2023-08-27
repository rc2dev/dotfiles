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
      startify.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
      startify.button( "n", "  Quick Note" , ":e $NOTES/notes/Quick Note.md<CR>"),
    }

    -- disable MRU
    startify.section.mru.val = { { type = "padding", val = 0 } }

    alpha.setup(startify.config)
  end
}
