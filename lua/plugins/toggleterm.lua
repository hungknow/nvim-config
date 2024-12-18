local M = {
  'akinsho/toggleterm.nvim',
  branch = "main",
  opts = {
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
--    autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    persist_size = false,
    start_in_insert = true,
    size = 20,
    -- get_size = function(term)
    --   if term.direction == "horizontal" then
    --     return vim.o.lines * 0.3
    --   elseif term.direction == "vertical" then
    --     return vim.o.columns * 0.3
    --   end
    -- end,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = -30,
    insert_mappings = true,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    shell = nil, -- change the default shell
    float_opts = {
      border = "curved", -- "rounded",
      width = math.floor(vim.o.columns * 0.85),
      height = math.floor(vim.o.lines * 0.8),
      -- winblend = 15,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    },
    highlights = {
      StatusLine   = { link = "StatusLine" },
      StatusLineNC = { link = "StatusLineNC" },
    },
    winbar = {
      enabled = false,
    },
    
  },
  keys = { "<C-\\>" },
  cmd = {
    "ToggleTerm",
    "TermExec",
    "ToggleTermToggleAll",
    "ToggleTermSendCurrentLine",
    "ToggleTermSendVisualLines",
    "ToggleTermSendVisualSelection",
  },
}

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "C-o", [[<C-\><C-n>]], opts)
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction, name = opts.name }
  term:toggle(opts.size, opts.direction)
end

--- Get current buffer size
---@return {width: number, height: number}
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

--- Get the dynamic terminal size in cells
---@param direction number
---@param size number
---@return integer
local function get_dynamic_terminal_size(direction, size)
  size = size or M.opts.size
  if direction ~= "float" and tostring(size):find(".", 1, true) then
    size = math.min(size, 1.0)
    local buf_sizes = get_buf_size()
    local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
    return buf_size * size
  else
    return size
  end
end

function M._exec_toggle(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(opts.size, opts.direction)
end

function M.add_exec(opts)
  -- local binary = opts.cmd:match "(%S+)"
  -- if vim.fn.executable(binary) ~= 1 then
  --   Log:debug("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
  --   return
  -- end

  vim.keymap.set({ "n", "t" }, opts.keymap, function()
    M._exec_toggle { 
      cmd = opts.cmd, 
      count = opts.count, -- ID of the terminal
      direction = opts.direction, 
      size = opts.size(),
      name = opts.label,
    }
  end, { desc = opts.label, noremap = true, silent = true })
end

function M.init()
  local execs = {
      { nil, "t1", "Horizontal Terminal 1", "horizontal"}, --, 0.3 },
      { nil, "t2", "Horizontal Terminal 2", "horizontal"}, --, 0.3 },
      { nil, "t3", "Horizontal Terminal 3", "horizontal", nil },
  } 
  for i, exec in pairs(execs) do
    local direction = exec[4] or M.opts.direction
    
    local opts = {
      cmd = exec[1] or M.opts.shell or vim.o.shell,
      keymap = exec[2],
      label = exec[3],
      -- NOTE: unable to consistently bind id/count <= 9, see #2146
      count = i + 100,
      direction = direction,
      size = function()
        return get_dynamic_terminal_size(direction, exec[5])
      end,
    }

    M.add_exec(opts)
  end
end

function M.config()
  --vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  require("toggleterm").setup(M.opts)
end

return M
