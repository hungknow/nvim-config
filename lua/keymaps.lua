local map = vim.keymap.set

-- Better window movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal window navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

-- Buffers
map("n", "<leader>bb", "<cmd>bpre<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })

map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- Turn off search matches with double-<Esc>
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { silent = true })

-- Toggle colored column at 81
map("n", "<leader>|", function()
  vim.opt.colorcolumn = #vim.o.colorcolumn > 0 and ""
    or tostring(vim.g._colorcolumn)
  end,
  { silent = true, desc = "toggle color column on/off" })

-- QuickFix
map("n", "[q", "<cmd>cclose<cr>", { silent = true, desc = "Close the QuickFix" })
map("n", "[j", "<cmd>try | cnext | catch | cfirst | catch | endtry<cr>", { silent = true, desc = "Forward QuickFix list" })
map("n", "[k", "<cmd>try | cprevious | catch | clast | catch | endtry<cr>", { silent = true, desc = "Backward QuickFix list" })
map("n", "[J", "<cmd>cnfile<cr>", { silent = true, desc = "Forward file [QuickFix]" })
map("n", "[K", "<cmd>cpfile<cr>", { silent = true, desc = "Backward file [QuickFix]" })
