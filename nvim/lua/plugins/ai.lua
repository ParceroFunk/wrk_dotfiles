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

	-- Chat + inline assistant (Ollama backend)
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
		opts = {
			strategies = {
				chat   = { adapter = "ollama" },
				inline = { adapter = "ollama" },
			},
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = { model = { default = "qwen2.5-coder:7b" } },
					})
				end,
			},
		},
		keys = {
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat" },
			{ "<leader>ai", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" }, desc = "AI Inline" },
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "AI Actions" },
		},
	},

	-- Cursor-style apply-edit UX (optional but recommended)
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
			provider = "ollama",
			providers = {
				ollama = {
					endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
					model = "qwq:32b",
				},
			},
		},
	},
}
