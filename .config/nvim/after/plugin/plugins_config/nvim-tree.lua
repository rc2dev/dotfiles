-- lualine config
-- Author: Rafael Cavalcanti <https://rafaelc.org/dev>

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")


local function down_and_preview(node)
  local api = require("nvim-tree.api")

  api.node.navigate.sibling.next()
  api.node.open.preview()
end

local function up_and_preview(node)
  local api = require("nvim-tree.api")

  api.node.navigate.sibling.prev()
  api.node.open.preview()
end

local function collapse_all()
    require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
      require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)

    else
      require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
      require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)

    else
      require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
end

require("nvim-tree").setup({
  view = {
    mappings = {
      list = {
        -- hjkl navigation (<https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#h-j-k-l-style-navigation-and-editing>)
        { key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all },

        -- remove <BS> (defined above as h)
        { key = "<BS>", action = "" },

        -- preview files while navigating
        { key = "J", action = "down_and_preview", action_cb = down_and_preview },
        { key = "K", action = "up_and_preview", action_cb = up_and_preview },

        -- move system_open from s to o
        { key = "o", action = "system_open" },
        { key = "s", action = "" },

        -- move preview from Tab to p
        { key = "p", action = "preview" },
        { key = "<Tab>", action = "" },

        -- swap d and D
        { key = "d", action = "trash" },
        { key = "D", action = "remove" },
      },
    },
  },
})

