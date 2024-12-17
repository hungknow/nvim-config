return {
  -- NvimTree
    "nvim-tree/nvim-tree.lua",
    opts = {},
    --config = function()
      -- require("lvim.core.nvimtree").setup()
    --end,
    enabled = true, --lvim.builtin.nvimtree.active,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",

}
