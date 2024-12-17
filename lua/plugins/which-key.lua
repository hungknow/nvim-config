local M = {
    "folke/which-key.nvim",
    enabled = vim.fn.has("nvim-0.9.4") == 1,
    event = "VeryLazy",
}

M.key = {
    {
        mode = { "n", "v" },
        "<Leader>?",
        function()
            require("which-key").show({ global = true })
        end,
        silent = true,
        desc = "Which-key root"
    }
}


return M
