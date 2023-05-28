return {
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		-- config = true,
		-- stylua: ignore
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{ "[t",         function() require("todo-comments").jump_prev() end,
				                                                                     desc =
				"Previous todo comment" },
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc =
			"Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
			{ "<eader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	-- {
	--   "echasnovski/mini.surround",
	--   keys = function(_, keys)
	--     -- Populate the keys based on the user's options
	--     local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
	--     local opts = require("lazy.core.plugin").values(plugin, "opts", false)
	--     local mappings = {
	--       { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
	--       { opts.mappings.delete, desc = "Delete surrounding" },
	--       { opts.mappings.find, desc = "Find right surrounding" },
	--       { opts.mappings.find_left, desc = "Find left surrounding" },
	--       { opts.mappings.highlight, desc = "Highlight surrounding" },
	--       { opts.mappings.replace, desc = "Replace surrounding" },
	--       { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
	--     }
	--     mappings = vim.tbl_filter(function(m)
	--       return m[1] and #m[1] > 0
	--     end, mappings)
	--     return vim.list_extend(mappings, keys)
	--   end,
	--   opts = {
	--     mappings = {
	--       add = "gza", -- Add surrounding in Normal and Visual modes
	--       delete = "gzd", -- Delete surrounding
	--       find = "gzf", -- Find surrounding (to the right)
	--       find_left = "gzF", -- Find surrounding (to the left)
	--       highlight = "gzh", -- Highlight surrounding
	--       replace = "gzr", -- Replace surrounding
	--       update_n_lines = "gzn", -- Update `n_lines`
	--     },
	--   },
	-- }
}
