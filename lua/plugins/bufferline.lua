-- See current buffers at the top of the editor
return {
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
				-- separator_style = "padded_slant",
		},
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
	},
}
