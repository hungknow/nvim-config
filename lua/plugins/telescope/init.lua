local M = {
  'nvim-telescope/telescope.nvim',
  branch = "0.1.x",
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
}

function M.init()
  require("plugins.telescope.keymaps")
end

function M.config()
  require("plugins.telescope.cmds")
  require("telescope").setup{
  }
end

return M
