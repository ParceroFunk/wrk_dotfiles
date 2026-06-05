-- Keybindings and mapping
vim.g.mapleader = ','
vim.keymap.set('i', 'jk', '<esc>', {desc = 'Esc key remap'})
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Write keybind'})
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', {desc = 'quit keybind'})

------------------------------------------------------------------------------
-- VIM Options configuration
vim.opt.number = true
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.wrap = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specs from lua/plugins/
require("lazy").setup("plugins")
