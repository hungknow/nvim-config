local M = {
  'hrsh7th/nvim-cmp',
  event = { "InsertEnter", "CmdLineEnter" },
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    not vim.snippet and "saadparwaiz1/cmp_luasnip" or nil,
  },
}

return M
