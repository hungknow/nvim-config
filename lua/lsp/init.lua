-- local ok, lspconfig = pcall(require, "lspconfig")
-- if not ok then return end
local lspconfig = require"lspconfig"

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = lspconfig.util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local custom_settings = {}

local all_servers = (function()
  -- use map for dedup
  local srv_map = {}
  local srv_tbl = {}
  local srv_iter = function(t)
    for _, s in ipairs(t) do
      if not srv_map[s] then
        srv_map[s] = true
        table.insert(srv_tbl, s)
      end
    end
  end
  -- srv_iter(manually_installed_servers)
  srv_iter(require("mason-lspconfig").get_installed_servers())
  return srv_tbl
end)()

local function make_config(srv)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- enables snippet support
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- enables LSP autocomplete
  local cmp_loaded, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_loaded then
    capabilities = cmp_lsp.default_capabilities()
  end
  return {
    on_attach = require("lsp.on_attach").on_attach,
    capabilities = capabilities,
    root_dir = srv == "lua_ls" and lua_root_dir or nil,
  }
end

local function is_installed(cfg)
  local cmd = cfg.document_config
      and cfg.document_config.default_config
      and cfg.document_config.default_config.cmd
      or nil
  -- server binary is executable within neovim's PATH
  return cmd and cmd[1] and vim.fn.executable(cmd[1]) == 1
end

for _, srv in ipairs(all_servers) do
  local cfg = make_config(srv)
  if custom_settings[srv] then
    cfg = vim.tbl_deep_extend("force", custom_settings[srv], cfg)
  end
  if is_installed(lspconfig[srv])
      -- uncomment when using "typescript-tools.nvim"
      -- and srv ~= "tsserver"
      -- jdtls is configured via 'mfussenegger/nvim-jdtls'
      and srv ~= "jdtls"
  then
    lspconfig[srv].setup(cfg)
  end
end
