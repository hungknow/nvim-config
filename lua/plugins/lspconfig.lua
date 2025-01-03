return {
	-- {
	--   "williamboman/mason.nvim",
	--   opts = {},
	--   build = function()
	--     pcall(function()
	--       require("mason-registry").refresh()
	--     end)
	--   end,
	--   cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
	--   event = "User FileOpened",
	--   lazy = true,
	-- },
	-- {
	--   "williamboman/mason-lspconfig.nvim",
	--   cmd = { "LspInstall", "LspUninstall" },
	--   opts = {},
	--   lazy = true,
	--   event = "User FileOpened",
	--   dependencies = {
	--     "williamboman/mason.nvim",
	--   },
	-- },
	-- {
	--   "neovim/nvim-lspconfig",
	--   event = "BufReadPre",
	--   dependencies = {
	--     { "williamboman/mason-lspconfig.nvim" },
	--     { "hrsh7th/cmp-nvim-lsp" },
	--   },
	--   config = function()
	--     require("lsp")
	--   end,
	-- },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		dependencies = {
			-- LSP Support
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" }, -- Required

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lsp = require("lsp-zero")

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			local lspconfig_defaults = require("lspconfig").util.default_config

			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities(),
				-- Reference: https://lsp-zero.netlify.app/docs/guide/quick-recipes.html#enable-folds-with-nvim-ufo
				-- Advertise the "folding capabilities" to the language servers.
				{
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				}
			)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				-- ensure_installed = {
				--   "terraformls", -- terraform language server
				--   "tflint", -- terraform linter
				--   "ts_ls",
				--   "gopls", -- Golang
				-- },
				automatic_installation = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					lua_ls = function()
						local lua_opts = lsp.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
					gopls = function()
						local util = require("lspconfig/util")

						require("lspconfig").gopls.setup({
							capabilities = capabilities,
							cmd = { "gopls" },
							filetypes = { "go", "gomod", "gowork", "gotmpl" },
							root_dir = util.root_pattern("go.work", "go.mod", ".git"),
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
										unusedvariable = false,
									},
									usePlaceholders = true,
									completeUnimported = true,
									staticcheck = true,
									semanticTokens = true,
									["ui.inlayhint.hints"] = {
										compositeLiteralFields = true,
										constantValues = true,
										parameterNames = true,
										functionTypeParameters = true,
									},
								},
							},
						})
					end,
				},
			})

			-- This is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, remap = false }
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					vim.keymap.set(
						"n",
						"K",
						"<cmd>lua vim.lsp.buf.hover()<cr>",
						vim.tbl_deep_extend("force", opts, { desc = "Hover [LSP]" })
					)
					vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					-- vim.keymap.set({'n', 'x'}, 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				end,
			})

			-- local cmp_action = require("lsp-zero").cmp_action()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			require("luasnip.loaders.from_vscode").lazy_load()

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
					["<up>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
					["<down>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-i>"] = cmp.mapping.complete(),
					-- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
					-- ["<C-b>"] = cmp_action.luasnip_jump_backward(),
					-- ["<Tab>"] = cmp_action.luasnip_supertab(),
					-- ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				}),
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "vale" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				go = { "golangcilint" },
				terraform = { "tflint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "bufenter", "insertleave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
			return lint
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		-- opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
					typescript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
					go = { "goimports", "gofmt", stop_after_first = true },
					rust = { "rustfmt", lsp_format = "fallback" },
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>gf", function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range using conform" })
		end,
	},
}
