local M = {
  'nvim-telescope/telescope.nvim',
  branch = "0.1.x",
  --lazy = true,
  dependencies = { 
    'nvim-lua/plenary.nvim',
  },
}

function M.init()
  require("plugins.telescope.keymaps")
end

function M.config()
  require("plugins.telescope.cmds")
  local actions = require("utils.modules").require_on_exported_call "telescope.actions"
  local telescope = require("telescope")

  telescope.setup{
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
      grep_string = {
        only_sort_text = true,
      },
      buffers = {
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      git_files = {
        hidden = true,
        show_untracked = true,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
  }

end

return M
