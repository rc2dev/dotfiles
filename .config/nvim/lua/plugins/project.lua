-- project.nvim config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup()
  end,
}

