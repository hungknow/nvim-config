local M = {}
local generic_opts_any = { noremap = true, silent = true }
local generic_opts = { 
  insert_mode = generic_opts_any, 
  normal_mode = generic_opts_any, 
  term_mode = { silent = true },
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  operator_pending_mode = generic_opts_any,
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_pending_mode = "o",
}

local defaults = {
  normal_mode = {
    ["<leader>e"] = "<cmd>NvimTreeToggle<cr>",  
  }
}


function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

function M.load(keymaps)
  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

function M.load_defaults()
  M.load(M.get_defaults())
  hvim.keys = hvim.keys or {}
  for idx, _ in pairs(defaults) do
    if not hvim.keys[idx] then
      hvim.keys[idx] = {}
    end
  end
end

function M.get_defaults()
  return defaults
end

return M
