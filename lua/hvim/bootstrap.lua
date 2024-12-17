local M = {}

function M:init()
  require("hvim.options")
  require("hvim.config"):init()
  require("hvim.lazyinit")
  -- require("hvim.keymappings"):load_defaults()
  -- require("hvim.keymappings"):load(hvim.keys)
end

return M
