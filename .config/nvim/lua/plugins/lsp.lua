return {
  -- Mason: installs the LSP server binaries
  { "williamboman/mason.nvim", config = true },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local servers = { "lua_ls", "pyright", "bashls" }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        -- IMPORTANT: disable automatic_enable if you want full manual control,
        -- otherwise mason-lspconfig will vim.lsp.enable() them for you on 0.11.
        automatic_enable = false,
      })

      -- 1. Global defaults applied to EVERY server (the "*" config)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- 2. Per-server overrides (merged on top of lspconfig's defaults)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },   -- silence 'vim' undefined
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config("pyright", {
        -- example override; defaults are usually fine
      })

      vim.lsp.config("bashls", {})

      -- 3. Enable the servers (this is what replaces .setup())
      vim.lsp.enable(servers)
    end,
  },

  -- Autocompletion (unchanged from before)
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

  -- Formatting (unchanged)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
}
