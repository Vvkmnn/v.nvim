return {
  {
    -- Vimscript to hold window at specific line - usually center
    "vim-scripts/scrollfix",
    config = function()
      vim.g["scrollfix"] = 50
    end,
  },
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  -- "tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
  {
    -- Better buffer closing actions. Available via the buffers helper.
    "kazhala/close-buffers.nvim",
    opts = {
      preserve_window_layout = { "this", "nameless" },
    },
  },
  {
    -- Move stuff with <M-j> and <M-k> in both normal and visual mode
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      keymaps = {
        ["?"] = "actions.show_help",
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- config = function()
    -- 	require("oil").setup({})
    -- end,
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
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
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end,
  },
  {
    "danilamihailov/beacon.nvim",
    event = "VeryLazy",
    keys = {
      { "n", "n:Beacon<cr>", desc = "Beacon Search Term Next" },
      { "N", "n:Beacon<cr>", desc = "Beacon Search Term Prev" },
      { "*", "*:Beacon<cr>", desc = "Beacon Cursor Term Next" },
      { "#", "#:Beacon<cr>", desc = "Beacon Cursor Term Prev" },
    },
    config = function()
      -- beacon_minimal_jump = 2,
      vim.g.beacon_shrink = 0
      vim.g.beacon_fade = 1
      vim.g.beacon_size = 777
    end,
  },
  {
    "mawkler/modicator.nvim",
    event = "VeryLazy",
    dependencies = "mawkler/onedark.nvim", -- Add your colorscheme plugin here
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
  },
  -- {
  --   "romgrk/barbar.nvim",
  --   dependencies = {},
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --   end,
  --   opts = {
  --     vim.cmd([[hi BufferTabpageFill guibg=red]]),
  --     -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
  --     -- animation = true,
  --     -- insert_at_start = true,
  --     -- …etc.
  --   },
  -- },
  --   --
  --   -- {
  --   --   "lewis6991/gitsigns.nvim",
  --   -- },
  -- }
}
