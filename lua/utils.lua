local M = {}

function M.is_root()
  return not M.IS_WINDOWS and uv.getuid() == 0
end

function M.is_dev(path)
  return vim.uv.fs_stat(string.format("%s/%s", vim.fn.expand(DEV_DIR), path)) ~= nil
end

return M
