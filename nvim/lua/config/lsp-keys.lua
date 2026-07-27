vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps on attach",
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition,      "Go to Definition")
    map("gr", vim.lsp.buf.references,      "References")
    map("K",  vim.lsp.buf.hover,           "Hover Docs")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("<leader>rn", vim.lsp.buf.rename,  "Rename")
    map("[d", vim.diagnostic.goto_prev,    "Prev Diagnostic")
    map("]d", vim.diagnostic.goto_next,    "Next Diagnostic")
  end,
})
