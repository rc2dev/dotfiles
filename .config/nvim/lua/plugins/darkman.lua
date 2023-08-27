-- darkman.nvim config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  '4e554c4c/darkman.nvim',
  run = 'go build -o bin/darkman.nvim',
  config = function()
    require 'darkman'.setup()
  end,
}
