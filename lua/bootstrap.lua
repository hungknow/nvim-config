local M = {}

function M:init()
  require("options")
  -- require("config"):init()
  require("lazyinit")
  require("keymaps")

  -- vim.cmd([[colorscheme visual_studio_code]])
  require('vscode').load('dark')

  -- neovim has very simple detection logic with .tf files to 
  -- distinguish between tinyfugue (tf) files and terraform files.
  vim.filetype.add({
    extension = {
      tf = "terraform"
    }
  })

  --
  -- require("hvim.keymappings"):load_defaults()
  -- require("hvim.keymappings"):load(hvim.keys)
end

return M
