local M = {
    "folke/which-key.nvim",
    enabled = vim.fn.has("nvim-0.9.4") == 1,
    event = "VeryLazy",
}

M.key = {
    {
        mode = { "n", "v" },
        "<leader>?",
        function()
            require("which-key").show({ global = true })
        end,
        silent = true,
        desc = "Which-key root"
    }
}

M.config = function()
  local wk = require("which-key")
  -- wk.add({
  --   { "<leader>bb", "<cmd>bpre<cr>", desc = "Previous Buffer" },
  --   { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
  -- })
end


return M
