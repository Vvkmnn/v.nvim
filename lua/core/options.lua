local opts = {
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	-- termguicolors = false,
	number = true,
	relativenumber = true,
	-- scrolloff = 999, -- center editor
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
  au BufEnter,WinEnter,WinNew,VimResized * lua vim.wo.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2)
augroup END
]])

