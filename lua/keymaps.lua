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

