-- darkman.nvim config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  '4e554c4c/darkman.nvim',
  build = 'go build -o bin/darkman.nvim',
  config = function()
    require 'darkman'.setup()
  end,

  -- Only load in graphical environments.
  cond = function()
    return os.getenv("DISPLAY") ~= nil
  end,
}
