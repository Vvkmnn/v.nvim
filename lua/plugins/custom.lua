return {
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre path/to/my-vault/**.md",
      "BufNewFile path/to/my-vault/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "vault",
          path = "~/Documents/vault/",
        },
      },
      -- notes_subdir = "6 - etc/notes",
      -- daily_notes = {
      --   folder = "0 - agenda",
      -- },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
    },

    -- see below for full list of options 👇
  },
  {
    "robitx/gp.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("gp").setup({
        openai_api_key = {
          "cat",
          "/Users/v/.openai",
        },
        -- openai_api_key = {
        --   "op",
        --   "read",
        --   "op://Personal/mhgs4auyjijxtrytbsqw3hucty/Other Fields/credential",
        -- },
        agents = {
          {
            name = "ChatGPT4",
            chat = true,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
              .. "The user provided the additional info about how they would like you to respond:\n\n"
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. "- Ask question if you need clarification to provide better answer.\n"
              .. "- Think deeply and carefully from first principles step by step.\n"
              .. "- Zoom out first to see the big picture and then zoom in to details.\n"
              .. "- Use Socratic method to improve your thinking and coding skills.\n"
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
        },
      })
    end,
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = 'op read --no-newline "op://Personal/mhgs4auyjijxtrytbsqw3hucty/Other Fields/credential"',
  --       -- api_host_cmd = "api.openai.com",
  --       -- submit = "<leader>/",
  --       -- openai_params = {
  --       --   model = "gpt-4-0125-preview",
  --       -- },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  {
    "elentok/format-on-save.nvim",
    event = "VeryLazy",
    config = function()
      local format_on_save = require("format-on-save")
      local formatters = require("format-on-save.formatters")

      format_on_save.setup({
        exclude_path_patterns = {
          "/node_modules/",
          ".local/share/nvim/lazy",
        },
        formatter_by_ft = {
          css = formatters.lsp,
          html = formatters.lsp,
          java = formatters.lsp,
          javascript = formatters.lsp,
          json = formatters.lsp,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          openscad = formatters.lsp,
          python = formatters.black,
          rust = formatters.lsp,
          scad = formatters.lsp,
          scss = formatters.lsp,
          sh = formatters.shfmt,
          terraform = formatters.lsp,
          typescript = formatters.prettierd,
          typescriptreact = formatters.prettierd,
          yaml = formatters.lsp,
        },
      })
    end,
  },
  {
    "marioortizmanero/adoc-pdf-live.nvim",
    event = "VeryLazy",
    config = function()
      -- require("colorizer").setup({})
      require("adoc_pdf_live").setup()
    end,
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_engine = "lualatex"
      -- vim.g.vimtex_compiler_engine = "xelatex"
      vim.g.maplocalleader = ","
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      -- require("colorizer").setup({})
      require("colorizer").setup()

      --
      -- surround_words             ysiw)           (surround_words)
      -- *make strings               ys$"            "make strings"
      -- [delete ar*ound me!]        ds]             delete around me!
      -- remove <b>HTML t*ags</b>    dst             remove HTML tags
      -- 'change quot*es'            cs'"            "change quotes"
      -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
      -- delete(functi*on calls)     dsf             function calls
      --
      --
      -- Configuration here, or leave empty to use defaults
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
      --
      -- surround_words             ysiw)           (surround_words)
      -- *make strings               ys$"            "make strings"
      -- [delete ar*ound me!]        ds]             delete around me!
      -- remove <b>HTML t*ags</b>    dst             remove HTML tags
      -- 'change quot*es'            cs'"            "change quotes"
      -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
      -- delete(functi*on calls)     dsf             function calls
      --
      --
      -- Configuration here, or leave empty to use defaults
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- TODO does not do the ()text (t)ext behavior yet
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {
        map = "<C-.>",
      },
    },
  },
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
      { "N", "N:Beacon<cr>", desc = "Beacon Search Term Prev" },
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
