return {
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	-- keys = {
	-- 	-- 	{
	-- 	-- 		"<leader>un",
	-- 	-- 		function()
	-- 	-- 			require("notify").dismiss({ silent = true, pending = true })
	-- 	-- 		end,
	-- 	-- 		desc = "Dismiss all Notifications",
	-- 	-- 	},
	-- 	-- },
	-- 	opts = {
	-- 		timeout = 3000,
	-- 		max_height = function()
	-- 			return math.floor(vim.o.lines * 0.75)
	-- 		end,
	-- 		max_width = function()
	-- 			return math.floor(vim.o.columns * 0.75)
	-- 		end,
	-- 	},
	-- 	-- init = function()
	-- 	-- 	-- when noice is not enabled, install notify on VeryLazy
	-- 	-- 	local Util = require("lazyvim.util")
	-- 	-- 	if not Util.has("noice.nvim") then
	-- 	-- 		Util.on_very_lazy(function()
	-- 	-- 			vim.notify = require("notify")
	-- 	-- 		end)
	-- 	-- 	end
	-- 	-- end,
	-- },
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({})
		end,
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	config = function()
	-- 		require("nvim-tree").setup({
	-- 			sort_by = "case_sensitive",
	-- 			-- view = { width = 30, },
	-- 			-- renderer = { group_empty = true, },
	-- 			filters = { dotfiles = true },
	--
	-- 			update_cwd = true,
	-- 			update_focused_file = {
	-- 				enable = true,
	-- 				update_cwd = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"prichrd/netrw.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		-- config = true,
		-- stylua: ignore
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{
				"[t",
				function() require("todo-comments").jump_prev() end,
				desc =
				"Previous todo comment"
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
			{
				"<leader>xT",
				"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
				desc =
				"Todo/Fix/Fixme (Trouble)"
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>",                         desc = "Todo" },
			{ "<eader>sT",  "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
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
