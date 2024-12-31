return {
  "coffebar/neovim-project",
  opts = {
    -- Project directories
    projects = {
      --"~/projects/*",
      --"~/p*cts/*", -- glob pattern is supported
      --"~/projects/repos/*",
      "~/.config/nvim",
      --"~/work/*",
      "~/work/stably/trinity-front-back/*",
      "~/work/hk/*",
    },
    picker = {
      type = "telescope",
    },
    -- Load the most recent session on startup if not in the project directory
    last_session_on_startup = false,
    -- Dashboard mode prevent session autoload on startup
    dashboard_mode = false,
  },
  dependencies = {
    -- optional picker
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    -- optional picker
    -- { "ibhagwan/fzf-lua" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
  init = function()
    vim.keymap.set("n", "<leader>sp", "<cmd>NeovimProjectHistory<cr>", { silent = true, desc = "List old projects [NeoVimProject]" })
    vim.keymap.set("n", "<leader>sP", "<cmd>NeovimProjectDiscover<cr>", { silent = true, desc = "Doscover projects [NeoVimProject]" })
  end
}
