return {
	-- MCP server manager
	{
		"ravitemer/mcphub.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		build = "npm install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup()
		end,
	},

	-- Chat and inline assistant
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
		opts = {
			adapters = {
				http = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "ANTHROPIC_API_KEY",
							},
							schema = {
								model = {
									default = "claude-sonnet-4-5-20250929",
								},
							},
						})
					end,

					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							env = {
								api_key = "GEMINI_API_KEY",
							},
							schema = {
								model = {
									default = "gemini-2.5-pro",
								},
							},
						})
					end,

					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "qwen2.5-coder:7b",
								},
							},
						})
					end,
				},
			},

			-- Claude is the default for both chat and inline requests.
			strategies = {
				chat = { adapter = "anthropic" },
				inline = { adapter = "anthropic" },
			},
		},
		keys = {
			{
				"<leader>ac",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "AI Chat",
			},
			{
				"<leader>ai",
				"<cmd>CodeCompanion<cr>",
				mode = { "n", "v" },
				desc = "AI Inline",
			},
			{
				"<leader>aa",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc = "AI Actions",
			},
		},
	},

	-- Cursor-style edit and diff workflow
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- Claude is Avante's default provider.
			provider = "claude",

			providers = {
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-5-20250929",
					api_key_name = "ANTHROPIC_API_KEY",
				},

				gemini = {
					endpoint = "https://generativelanguage.googleapis.com",
					model = "gemini-2.5-pro",
					api_key_name = "GEMINI_API_KEY",
				},

				ollama = {
					endpoint = "http://127.0.0.1:11434",
					model = "qwen2.5-coder:7b",
				},
			},
		},
	},
}
