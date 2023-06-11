-- Miscelaneous fun stuff
return {
	{
		-- light statusline
		"nvim-lualine/lualine.nvim",
		config = function()
			-- local colorscheme = require("helpers.colorscheme")
			-- local lualine_theme = colorscheme == "default" and "auto" or colorscheme
			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = lualine_theme,
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.register({
				["<leader>"] = {
					f = { name = "File" },
					d = { name = "Delete/Close" },
					q = { name = "Quit" },
					s = { name = "Search" },
					l = { name = "LSP" },
					u = { name = "UI" },
					b = { name = "Debugging" },
					g = { name = "Git" },
				},
			})
		end,
	},

	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "v3.*",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	opts = {
	-- 			-- separator_style = "padded_slant",
	-- 	},
	-- config = function()
	-- 	require("bufferline").setup({
	-- 		separator_style = "padded_slant"
	-- 		-- vim.cmd([[
	-- 		-- 	augroup MyColors
	-- 		-- 	autocmd!
	-- 		--
	-- 		-- 	autocmd ColorScheme * highlight BufferLineFill guibg=#191724
	-- 		--
	-- 		-- 	autocmd ColorScheme * highlight BufferLineSeparator guifg=#191724
	-- 		--
	-- 		-- 	autocmd ColorScheme * highlight BufferLineSeparatorSelected guifg=#191724
	-- 		--
	-- 		-- 	augroup END
	-- 		-- 	]])
	-- 	})
	-- end
	-- },
	-- Comment with haste
}
