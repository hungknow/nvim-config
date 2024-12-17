local M = {
    "nvim-tree/nvim-tree.lua",
    opts = {},
    --config = function()
      -- require("lvim.core.nvimtree").setup()
    --end,
    enabled = true, --lvim.builtin.nvimtree.active,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
}

M.init = function()
    vim.keymap.set("", "<leader>ee", "<Esc>:NvimTreeToggle<CR>", { silent = true, desc = "nvim-tree on/off" })
    vim.keymap.set("", "<leader>ef", "<Esc>:NvimTreeFindFileToggle<CR>", { silent = true, desc = "nvim-tree current file", })
end


return M
