-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Leader to ,
-- vim.keymap.set("n", ",", "<leader>", { desc = "Leader" })
-- vim.keymap.del("n", "]c")
-- vim.keymap.del("n", "[c")
vim.keymap.set("n", "]c", "g,", { desc = "Next Change" })
vim.keymap.set("n", "[c", "g;", { desc = "Previous Change" })
-- vim.keymap.set("n", "]c", "g,", { desc = "Next Change", noremap = true })
-- vim.keymap.set("n", "[c", "g;", { desc = "Previous Change", noremap = true })

-- Edit Alias
vim.keymap.set("n", ",r", ":vs ~/.github/README.md", { desc = "Edit .dotfiles README" })

vim.keymap.set("n", ",v", ":vs ~/.config/nvim/lua/<CR>", { desc = "Edit Neovim" })
vim.keymap.set("n", ",k", ":vs ~/.config/nvim/lua/config/keymaps.lua<CR>", { desc = "Edit Keymaps" })
vim.keymap.set("n", ",c", ":vs ~/.config/nvim/lua/plugins/custom.lua<CR>", { desc = "Edit Custom Plugins" })
vim.keymap.set("n", ",d", ":vs ~/.config/nvim/lua/plugins/disable.lua<CR>", { desc = "Edit Disabled Plugins" })
vim.keymap.set("n", ",o", ":vs ~/.config/nvim/lua/config/options.lua<CR>", { desc = "Edit Options" })

vim.keymap.set("n", ",s", ":vs ~/.shell<CR>", { desc = "Edit .shell" })
vim.keymap.set("n", ",a", ":vs ~/.alias<CR>", { desc = "Edit .alias" })
vim.keymap.set("n", ",t", ":vs ~/.config/tmux/tmux.conf<CR>", { desc = "Edit Tmux" })

-- TODO binds for only, vimsplit, etc.

-- Escape via jj or jk in insert mode
-- map("i", "jj", "<ESC>")
-- map("i", "jk", "<esc>")

-- Quick access to some common actions
-- map("n", "<leader>fw", "<cmd>w<cr>", "Write")
-- map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
-- map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
-- map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
-- map("n", "<leader>dw", "<cmd>close<cr>", "Window")

-- Diagnostic keymaps
-- map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Easier access to beginning and end of lines
-- map("n", "<M-h>", "^", "Go to beginning of line")
-- map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
-- map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
-- map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
-- map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
-- map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move with shift-arrows
-- map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
-- map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
-- map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
-- map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
-- map("n", "<C-Up>", ":resize +2<CR>")
-- map("n", "<C-Down>", ":resize -2<CR>")
-- map("n", "<C-Left>", ":vertical resize +2<CR>")
-- map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
-- local buffers = require("helpers.buffers")
-- map("n", "<leader>db", buffers.delete_this, "Current buffer")
-- map("n", "<leader>do", buffers.delete_others, "Other buffers")
-- map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Navigate buffers
-- map("n", "<S-l>", ":bnext<CR>")
-- map("n", "<S-h>", ":bprevious<CR>")
-- map("n", "<S-j>", ":bnext<CR>")
-- map("n", "<S-k>", ":bprevious<CR>")

-- Stay in indent mode
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")

-- Switch between light and dark modes
-- map("n", "<leader>ut", function()
--   if vim.o.background == "dark" then
--     vim.o.background = "light"
--   else
--     vim.o.background = "dark"
--   end
-- end, "Toggle between light and dark themes")

-- Clear after search
-- map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

-- Ctrl+S to Save
-- map("n", "<C-S>", ":update!<CR>")
-- map("v", "<C-S>", "<C-C>:update!<CR>")
-- map("i", "<C-S>", "<C-O>:update!<CR>")

-- Ctrl+Q to Quit
vim.keymap.set("n", "<C-Q>", ":exit<CR>,", { desc = "Quit without saving" })
-- vim.keymap.set({ "n", "i" }, "<C-Q>", ":exit<CR>,", { desc = "Quit without saving", expr = true }) -- doesnt work

-- map("n", "<C-Q>", ":exit<CR>")
-- map("v", "<C-Q>", "<C-C>:exit<CR>")
-- map("i", "<C-Q>", "<C-O>:exit<CR>")
-- map("n", "<C-Q>", ":q<CR>")
-- map("v", "<C-Q>", "<C-C>:q<CR>")
-- map("i", "<C-Q>", "<C-O>:q<CR>")

-- Ctrl Arrow Buffer Navigation
-- map('n', '<C-Right>', '<c-w>l')
-- map('n', '<C-Left>', '<c-w>h')
-- map('n', '<C-Up>', '<c-w>k')
-- map('n', '<C-Down>', '<c-w>j')

-- Ctrl HJKL Split Navigation
-- map('n', '<C-H>', '<C-W><C-H>')
-- map('n', '<C-J>', '<C-W><C-J>')
-- map('n', '<C-K>', '<C-W><C-K>')
-- map('n', '<C-L>', '<C-W><C-L>')

-- Sort in Visual Mode
-- map("v", "<Leader>s", ":sort<CR>")

-- Fix for Vim on WSL
-- https://stackoverflow.com/questions/51388353/vim-changes-into-replace-mode-on-startup
-- map("n", "<esc>^[", "<esc>^[")

-- sW for sudo :w
-- TODO fix
-- vim.cmd("command sW execute ':silent w !sudo tee % > /dev/null' | edit!")
