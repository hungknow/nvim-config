local M = {}

M.__HAS_NVIM_08 = vim.fn.has("nvim-0.8") == 1
M.__HAS_NVIM_010 = vim.fn.has("nvim-0.10") == 1
M.__HAS_NVIM_011 = vim.fn.has("nvim-0.11") == 1
M.IS_WINDOWS = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

function M.is_root()
  return not M.IS_WINDOWS and vim.uv.getuid() == 0
end

function M.is_darwin()
  return vim.uv.os_uname().sysname == "Darwin"
end

function M.is_dev(path)
  return vim.uv.fs_stat(string.format("%s/%s", vim.fn.expand(DEV_DIR), path)) ~= nil
end

function M.have_compiler()
  if vim.fn.executable("cc") == 1 or
      vim.fn.executable("gcc") == 1 or
      vim.fn.executable("clang") == 1 or
      vim.fn.executable("cl") == 1 then
    return true
  end
  return false
end

return M
