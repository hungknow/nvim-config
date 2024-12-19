return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    opts = { enable = true },
    keys = {
      {
        "[C",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        silent = true,
        desc = "Goto treesitter context"
      },
      {
        "]C",
        function() require("treesitter-context").toggle() end,
        silent = true,
        desc = "Toggle treesitter context"
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = function()
      -- build step is run independent of the condition
      -- make sure we have treesitter before running ':TSUpdate'
      if require("utils").have_compiler() then
        vim.cmd("TSUpdate")
      end
    end,
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "dockerfile",
          "go",
          "javascript",
          "typescript",
          "json",
          "jsonc",
          "jsdoc",
          "lua",
          "python",
          "rust",
          "html",
          "yaml",
          "css",
          "toml",
          "terraform",
          "markdown",
          "markdown_inline",
          "solidity",
          "vimdoc",
          -- for `nvim-treesitter/playground` / `:InspectTree`
          "query",
          "vue",
        },
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<S-Tab>",
            scope_incremental = "<Tab>",
          },
        },
      }

      -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    
      -- Tell treesitter where dotenv parser is located
      -- parser_config.dotenv = {
      --     install_info = {
      --         url = "https://github.com/pnx/tree-sitter-dotenv",
      --         branch = "main",
      --         files = { "src/parser.c", "src/scanner.c" },
      --     },
      --     filetype = "dotenv",
      -- }

      -- Associate .env files as "dotenv"
      -- vim.filetype.add({
      --     pattern = {
      --         ['.env.*'] = 'dotenv',
      --     },
      -- })

    end,

  },
}
