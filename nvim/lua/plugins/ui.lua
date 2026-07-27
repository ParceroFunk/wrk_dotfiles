return {
	-- Icons (needed by tree/telescope)
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- File explorer (Cursor-like sidebar)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
		},
		opts = {
			filesystem = { follow_current_file = { enabled = true } },
		},
	},

	-- Fuzzy finder (≈ Cmd+P / Cmd+Shift+F)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
		},
	},

	-- Syntax highlighting — replaces nvim-treesitter for Neovim 0.12+
	-- Requires: tree-sitter CLI, git, gcc/clang
	{
		"romus204/tree-sitter-manager.nvim",
		lazy = false,
		config = function()
			require("tree-sitter-manager").setup({
				ensure_installed = {
					"bash",
					"dockerfile",
					"gitcommit",
					"go",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"vim",
					"vimdoc",
					"yaml",
				},
				-- auto-install a parser when you open a filetype not yet installed
				auto_install = true,
				-- these ship with Neovim 0.12 core — no need to reinstall them
				noauto_install = { "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" },
				highlight = true,
			})
		end,
	},

	-- A colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
