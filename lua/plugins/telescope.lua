return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- fuzzy finder algorithm which requires local dependencies to be built. only load if `make` is available
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		},
		config = function()

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<c-u>"] = false,
							["<c-d>"] = false,
						},
					},
				},
			})

			-- Enable telescope fzf native, if installed
			-- pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "fzf_native")

			local map = require("helpers.keys").map

			map("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(
					require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
				)
			end, "Search in current buffer")

			-- TODO do you use this enough?
			map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
			map("n", "<leader><c-r>", require("telescope.builtin").oldfiles, "Recently opened")
			map("n", "<leader><c-f>", require("telescope.builtin").find_files, "Files") -- ({ hidden = true}) causes crash
			map("n", "<leader><c-h>", require("telescope.builtin").help_tags, "Help")
			map("n", "<leader><c-w>", require("telescope.builtin").grep_string, "Current word")
			map("n", "<leader><c-g>", require("telescope.builtin").live_grep, "Grep")
			map("n", "<leader><c-d>", require("telescope.builtin").diagnostics, "Diagnostics")

			map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")
		end,
	},
}
