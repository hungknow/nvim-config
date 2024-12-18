if not pcall(require, "lspconfig") then
  return
end

local M = {}

local _winopts = { border = "rounded" }
local _float_win = nil

function M.preview_location(loc, _, _)
  -- location may be LocationLink or Location
  local uri = loc.targetUri or loc.uri
  if uri == nil then return end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end
  local range = loc.targetRange or loc.range
  local before, after = math.min(5, range.start.line), 10
  local lines = vim.api.nvim_buf_get_lines(bufnr,
    (range.start.line - before),
    -- end is reserved, can't use 'range.end'
    (range["end"].line + after + 1),
    false)
  -- empty lines at the start don't count
  for _, l in ipairs(lines) do
    if #l > 0 then break end
    before = before - 1
  end
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local buf, win = vim.lsp.util.open_floating_preview(lines, ft, {})
  vim.api.nvim_win_set_config(win, _winopts)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", ft)
  vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NormalFloat,FloatBorder:FloatBorder")
  vim.api.nvim_win_set_option(win, "cursorline", true)
  -- partial data, numbers make no sense
  vim.api.nvim_win_set_option(win, "number", false)
  vim.api.nvim_win_set_cursor(win, { before + 1, 1 })
  local pos = range.start.line == range["end"].line and
      { before + 1, range.start.character + 1, range["end"].character - range.start.character } or
      { before + 1 }
  vim.api.nvim_win_call(win, function()
    vim.fn.matchaddpos("IncSearch", { pos })
  end)
  return buf, win
end



return M
