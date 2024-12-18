local o = vim.opt
local utils = require("utils")

-- o.mouse = "" -- disable the mouse
o.mouse = "a" -- Allow mouse to be used in nvim
o.mousemodel = extend -- VISUAL BLOCK mode using mouse
o.termguicolors = true -- enable 24bit colors
o.background = "dark" -- use the dark version of colorschemes
o.fileformat = "unix" -- <nl> for EOL

o.number = true -- show absolute line number at the cursor position
o.cursorline = true  -- Show a line where the current cursor is
vim.g._colorcolumn = 100 -- Show mark column
o.colorcolumn = tostring(vim.g._colorcolumn)
o.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time


o.tabstop = 2 -- Tab indentation levels every two columns
o.softtabstop = 2   -- Tab indentation when mixing tabs & spaces
o.shiftwidth       = 2     -- Indent/outdent by two columns
o.expandtab        = true  -- Convert all tabs that are typed into spaces

o.ignorecase       = true                   -- ignore case on search
o.smartcase        = true                   -- case sensitive when search includes uppercase
o.showmatch        = true                   -- highlight matching [{()}]

o.writebackup      = false                  -- do not backup file before write
o.swapfile         = false                  -- no swap file

o.cmdheight = 1 -- More spaces in command line for displaying messages
o.fileencoding = "utf-8" -- the encoding written to a file

-- Map leader to <space>
vim.g.mapleader                 = " "
vim.g.maplocalleader            = "\\" 

-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- MacOS clipboard
if utils.is_darwin() then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
  }
end

if utils.__HAS_NVIM_010 and vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

