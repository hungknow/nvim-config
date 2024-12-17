local M = {
  "ibhagwan/smartyank.nvim",
  opt = { highlight = { timeout = 1000 } },
  event = "VeryLazy",
  dev = require("utils").is_dev("smartyank.nvim"),
}

return M
