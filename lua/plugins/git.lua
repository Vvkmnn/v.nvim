-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		-- Resolve conflicts with cX, jump with ]x
		"akinsho/git-conflict.nvim",
		commit = "2957f74",
		config = function()
			require("git-conflict").setup({
				-- default_mappings = {
				-- 	ours = "co",
				-- 	theirs = "ct",
				-- 	none = "c0",
				-- 	both = "cb",
				-- 	next = "cn",
				-- 	prev = "cp",
				-- },
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			local map = require("helpers.keys").map
			map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
			map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")
		end,
	},
	{
		-- Magit for Vim
		"TimUntersberger/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("neogit").setup({
				use_magit_keybindings = true,
			})

			local map = require("helpers.keys").map
			map("n", "<leader>gg", "<cmd>Neogit<CR>", "Run Neogit")
		end,
	},
}
