local utils = require("utils")

local map_tele = function(mode, key, f, options, buffer)
  local desc = nil
  if type(options) == "table" then
    desc = options.desc
    options.desc = nil
  elseif type(options) == "function" then
    desc = options().desc
  end

  if utils.SWITCH_TELE then
    for _, k in ipairs({ "F", "L", "G" }) do
      key = key:gsub("<leader>" .. k, "<leader>" .. string.lower(k))
    end
    for _, k in ipairs({ "<F1>", "<c-P>", "<c-K>" }) do
      if key == "<leader>" .. k then
        key = k
      end
    end
    -- remap buffers
    if key == "<leader>;" then
      key = "<leader>,"
    end
  end

  local rhs = function()
    local builtin = require("telescope.builtin")
    local extensions = require"telescope".extensions
    local custom = require("plugins.telescope.cmds")
    if custom[f] then
      custom[f](options or {})
    elseif builtin[f] then
      builtin[f](options or {})
    elseif extensions[f] then
      extensions[f][f](options or {})
    end
  end

  local map_options = {
    silent = true,
    buffer = buffer,
    desc   = desc or string.format("Telescope %s", f),
  }

  vim.keymap.set(mode, key, rhs, map_options)
end

map_tele("n", "<leader>bs", "buffers", { desc = "buffers" })
map_tele("n", "<leader><c-P>", "find_files", { desc = "find files" })

-- LSP
map_tele("n", "<leader>Lt", "treesitter", { desc = "treesitter symbols (buffer)" })  
map_tele("n", "<leader>Lr", "lsp_references", { desc = "references [LSP]" })
map_tele("n", "<leader>Ld", "lsp_definitions",
  { telec = "definitionS [LSP]", jump_to_single_result = false })
map_tele("n", "<leader>Ly", "lsp_type_definitions", { desc = "type definitions [LSP]" })
map_tele("n", "<leader>Lm", "lsp_implementations", { desc = "implementations [LSP]" })
map_tele("n", "<leader>Ls", "lsp_document_symbols", { desc = "document symbols [LSP]" })
map_tele("n", "<leader>LS", "lsp_workspace_symbols", { desc = "workspace symbols [LSP]" })
map_tele("n", "<leader>Lg", "diagnostics", { bufnr = 0, desc = "document diagnostics [LSP]" })
map_tele("n", "<leader>LG", "diagnostics", { desc = "workspace diagnostics [LSP]" })

-- Search 
map_tele("n", "<leader>sc", "colorscheme", { desc = "Color scheme [Telescope]" })
map_tele("n", "<leader>sC", "commands", { desc = "Commands [Telescope]" })
map_tele("n", "<leader>sf", "find_files", { desc = "Find files [Telescope]" })
map_tele("n", "<leader>st", "live_grep", { desc = "Live grep [Telescope]" })
map_tele("n", "<leader>sl", "resume", { desc = "Resume last search [Telescope]" })
map_tele("n", "<leader>sk", "keymaps", { desc = "Keymap [Telescope]" })
map_tele("n", "<leader>sr", "registers", { desc = "Register [Telescope]" })
-- map_tele("n", "<leader>sp", "projects", { desc = "Projects [Telescope]" })
--map_tele("n", "<leader>su", "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", { desc = "Colorscheme with Preview" })

