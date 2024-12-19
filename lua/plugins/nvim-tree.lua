local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { 
      desc = "nvim-tree: " .. desc, 
      buffer = bufnr, 
      noremap = true, 
      silent = true, 
      nowait = true,
    }
  end

  -- Add more key mapping for nvim-tree
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

local M = {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
    opts = {
      view = {
        adaptive_size = true,
        preserve_window_proportions = true,
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },

      -- projects.nvim https://github.com/ahmedkhalf/project.nvim
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },

    },
    -- opts = {
    --   on_attach = my_on_attach,
    -- },
}

M.init = function()
    vim.keymap.set("", "<leader>ee", "<Esc>:NvimTreeToggle<CR>", { silent = true, desc = "nvim-tree on/off" })
    vim.keymap.set("", "<leader>ef", "<Esc>:NvimTreeFindFileToggle<CR>", { silent = true, desc = "nvim-tree current file", })
end

return M
