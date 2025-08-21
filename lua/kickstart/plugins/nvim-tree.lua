return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
  vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
  require("nvim-tree").setup {
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local width = 100
            local height = 30
            local api = vim.api
            local screen_w = api.nvim_get_option("columns")
            local screen_h = api.nvim_get_option("lines")
            local col = math.floor((screen_w - width) / 2)
            local row = math.floor((screen_h - height) / 2 - 1)
            return {
              relative = "editor",
              border = "rounded",
              width = width,
              height = height,
              row = row,
              col = col,
            }
          end,
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      end,
    }
  end,
}   