return {
  {
    "lualine.nvim",
    opts = function()
      return {
        sections = {
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      -- C-p/n to get kill-ring like emacs!
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Yanky Previous Entry" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Yanky Next Entry" },
    },
  },
  -- {
  --   NOTE depended on treesitter textobjects, in the end
  --   "lewis6991/gitsigns.nvim",
  --   event = { "LazyFile", "VeryLazy" },
  --   keys = {
  --     { "]c", ":Gitsigns next_hunk<CR>", desc = "Next Hunk" },
  --     { "[c", ":Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
  --   },
  -- },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = { "LazyFile", "VeryLazy" },
  --   keys = {
  --     { "n", "]c", ":Gitsigns next_hunk<CR>", desc = "Next Hunk" },
  --     { "n", "[c", ":Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
  --   },
  -- },
}
