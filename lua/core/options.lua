local opts = {
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	-- termguicolors = false,
	number = true,
	relativenumber = true,
	-- scrolloff = 7, -- +- 7 lines
	autochdir = true,
	-- scrolloff = 999, -- center line
	-- loaded_netrw =1,
	-- loaded_netrwPlugin=1
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

-- Augroup to center cursor
vim.cmd([[
augroup VCenterCursor
  au!
  " au BufEnter,WinEnter,WinNew,VimResized * lua vim.wo.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2)
  au BufEnter,VimResized * lua vim.wo.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2)
augroup END
]])

-- handle WSL (Windows for Linux) clipboard
-- choco install win31yank
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end
