local M = {}

function M:init()
  hvim = vim.deepcopy(require "hvim.config.defaults")
end

return M
