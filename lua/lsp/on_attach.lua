local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts, { silent = true, buffer = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

local on_attach = function(client, bufnr)
  map("n", "K", "<cmd> vim.lsp.buf.hover()<CR>", { desc = "hover information (LSP)" })
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",
    { desc = "goto definition [LSP]" })
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",
    { desc = "goto declaration [LSP]" })
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",
    { desc = "goto reference [LSP]" })
  map("n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>",
    { desc = "goto implementation [LSP]" })
  map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    { desc = "goto type definition [LSP]" })
  map("n", "gA", "<cmd>lua vim.lsp.buf.code_action()<CR>",
    { desc = "code actions [LSP]" })
  map("v", "gA", "<cmd>lua vim.lsp.buf.range_code_action()<CR>",
    { desc = "range code actions [LSP]" })
  -- use our own rename popup implementation
  map("n", "gR", [[<cmd>lua require("lsp.rename").rename()<CR>]],
    { desc = "rename [LSP]" })
  map("n", "<leader>lR", [[<cmd>lua require("lsp.rename").rename()<CR>]],
    { desc = "rename [LSP]" })
  map("n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { desc = "signature help [LSP]" })
  map("n", "<leader>k", [[<cmd>lua require("lsp.handlers").peek_definition()<CR>]],
    { desc = "peek definition [LSP]" })
  map("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, { desc = "toggle inlay hints [LSP]" })

end

return { on_attach = on_attach }
