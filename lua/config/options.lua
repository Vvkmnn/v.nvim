-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.autowrite = false -- Enable auto write
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.termguicolors = true
-- termguicolors = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
-- scrolloff = 7 -- +- 7 lines
-- scrolloff = 999 -- center line
vim.opt.lazyredraw = true -- redraw after events
-- loaded_netrw =1
-- loaded_netrwPlugin=1
vim.opt.equalalways = true
vim.opt.showtabline = 0

-- Set fillchars to make vertical split less noticeable
vim.o.fillchars = "vert: "

-- Enable line numbers in all windows
vim.wo.number = true

-- vim.opt.cursorline = false -- Enable highlighting of the current line
--

-- vim.cmd.colorscheme("tokyonight")
