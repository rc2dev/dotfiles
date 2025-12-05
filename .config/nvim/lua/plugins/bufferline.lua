-- bufferline config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",

  opts = {
    options = {
      right_mouse_command = "",
      middle_mouse_command = "bdelete! %d",
    },
  }
}
