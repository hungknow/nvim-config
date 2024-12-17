local o = vim.opt

-- o.mouse = "" -- disable the mouse
o.termguicolors = true -- enable 24bit colors
o.background = "dark" -- use the dark version of colorschemes
o.fileformat = "unix" -- <nl> for EOL

o.number = true -- show absolute line number at the cursor position
o.cursorline = true  -- Show a line where the current cursor is
vim.g._colorcolumn = 100 -- Show mark column
o.colorcolumn = tostring(vim.g._colorcolumn)


o.tabstop = 4 -- Tab indentation levels every two columns
o.softtabstop = 4   -- Tab indentation when mixing tabs & spaces
o.shiftwidth       = 4     -- Indent/outdent by two columns
o.expandtab        = true  -- Convert all tabs that are typed into spaces

o.ignorecase       = true                   -- ignore case on search
o.smartcase        = true                   -- case sensitive when search includes uppercase
o.showmatch        = true                   -- highlight matching [{()}]

o.writebackup      = false                  -- do not backup file before write
o.swapfile         = false                  -- no swap file

-- Map leader to <space>                                                                                                                                                                                                                  
vim.g.mapleader                 = " "                                                                                                                                                                                                     
vim.g.maplocalleader            = " " 
