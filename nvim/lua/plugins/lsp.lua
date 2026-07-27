return {
	-- Mason: installs the LSP server binaries
	{ "williamboman/mason.nvim", config = true },

	-- nvim-lspconfig loaded early so LspAttach fires before servers attach
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }

					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
						vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
					vim.keymap.set("n", ",d", vim.diagnostic.open_float,
						vim.tbl_extend("force", opts, { desc = "Show diagnostic float" }))
					vim.keymap.set("n", ",dl", vim.diagnostic.setloclist,
						vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))
					vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
					vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
					vim.keymap.set("n", ",rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
					vim.keymap.set("n", ",ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
				end,
			})

			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local servers = { "lua_ls", "pyright", "bashls", "gopls" }

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = false,
			})

			-- 1. Global defaults applied to EVERY server
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- 2. Per-server overrides
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			vim.lsp.config("pyright", {})
			vim.lsp.config("bashls", {})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})

			-- 3. Enable the servers
			vim.lsp.enable(servers)
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args) require("luasnip").lsp_expand(args.body) end,
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"]    = cmp.mapping.confirm({ select = true }),
					["<Tab>"]   = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				go = { "goimports" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
	},
}
