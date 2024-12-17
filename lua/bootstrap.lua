local M = {}

function M:init()
  require("options")
  -- require("config"):init()
  require("lazyinit")
  require("keymaps")

  -- vim.cmd([[colorscheme visual_studio_code]])
  require('vscode').load('dark')
  --
  -- require("hvim.keymappings"):load_defaults()
  -- require("hvim.keymappings"):load(hvim.keys)
end

return M
