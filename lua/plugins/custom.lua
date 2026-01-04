return {
  -- 🎯 EDIT TRACKING: This change should appear instantly on the left!
  -- Diff test: edited on 2025-11-25 to verify sidekick.nvim diff view.

  -- {
  --   "greggh/claude-code.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- Required for git operations
  --   },
  --   config = function()
  --     require("claude-code").setup({
  --       window = {
  --         split_ratio = 0.42, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
  --         position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
  --         enter_insert = true, -- Whether to enter insert mode when opening Claude Code
  --         -- hide_numbers = true, -- Hide line numbers in the terminal window
  --         -- hide_signcolumn = true, -- Hide the sign column in the terminal window
  --         -- border = "double", -- Use double border style
  --         float = {
  --           width = "40%", -- Width: number of columns or percentage string
  --           height = "80%", -- Height: number of rows or percentage string
  --           row = "50%", -- Row position: number, "center", or percentage string
  --           col = "50%", -- Column position: number, "center", or percentage string
  --           relative = "editor", -- Relative to: "editor" or "cursor"
  --           border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
  --         },
  --       },
  --       scrolling = true,
  --     })
  --   end,
  -- },

  -- Best unified single-view diff experience with proven plugin
  -- {
  --   "lambdalisue/vim-unified-diff",
  --   event = "VeryLazy",
  --   config = function()
  --     -- Auto-enable unified diff for any diffthis usage (including claudecode.nvim)
  --     vim.api.nvim_create_autocmd("OptionSet", {
  --       pattern = "diff",
  --       callback = function()
  --         if vim.wo.diff then
  --           vim.schedule(function()
  --             -- Enable unified diff mode when any diff starts
  --             pcall(function()
  --               vim.cmd("UnifiedDiffUpdate")
  --             end)
  --           end)
  --         end
  --       end,
  --     })
  --   end,
  -- },

  -- One diff view NOTE: Does not work
  -- {
  --   "axkirillov/unified.nvim",
  --   opts = {
  --     -- your configuration comes here
  --   },
  -- },

  -- 3 screens
  -- {
  --   "sindrets/diffview.nvim",
  -- },

  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {}, -- required even with default settings, since it calls `setup()`
  },

  -- Character-level highlighting with native Neovim - WORKING!
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      -- Minimal config to avoid claudecode.nvim conflicts
      signs = {
        add = { text = "+" },
        change = { text = "·" },
        delete = { text = "_" },
      },
      -- Disable features that might conflict with claudecode.nvim
      -- word_diff = false,
      -- attach_to_untracked = false,
    },
  },

  -- {
  --   "jonroosevelt/gemini-cli.nvim",
  --   config = function()
  --     require("gemini").setup()
  --   end,
  -- },

  -- diffchar.vim - Word-level diff highlighting with single color (maximum clarity)
  {
    "rickhowe/diffchar.vim",
    event = "VeryLazy",
    config = function()
      vim.g.DiffUnit = "Word1" -- Word-level (easier to scan than char-by-char)
      vim.g.DiffColors = 0 -- Single DiffText color (maximum clarity)
      vim.g.DiffPairVisible = 0 -- No cursor highlighting on pairs
      vim.g.DiffDelPosVisible = 0 -- Disabled: deletion indicators not helpful
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    -- enabled = false, -- Disabled for sidekick.nvim testing
    opts = {
      terminal = {
        split_width_percentage = 0.42,
        split_side = "left",
        -- provider = "snacks",
        auto_close = true,
      },
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = false,
        keep_terminal_focus = false,
        hide_terminal_in_new_tab = true,
      },
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>aC", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>\\", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude", mode = { "n", "t" } },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      -- Simple diff keybindings (claudecode.nvim handles the logic)
      { "<leader>]", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>[", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject diff" },
      {
        "<leader>|",
        function()
          -- Search current tab first
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.b[buf].claudecode_diff_tab_name then
              vim.api.nvim_set_current_win(win)
              return
            end
          end
          -- Search all tabs
          for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.b[buf].claudecode_diff_tab_name then
                vim.api.nvim_set_current_tabpage(tab)
                vim.api.nvim_set_current_win(win)
                return
              end
            end
          end
          vim.notify("No active diff found", vim.log.levels.WARN)
        end,
        desc = "Go to diff",
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Diff highlighting for Claude diffs
      vim.cmd([[
        highlight! DiffAdd guifg=#a7c957 guibg=#1a2e1a gui=bold
        highlight! DiffDelete guifg=#8a8a8a guibg=#2a1a1a gui=bold
        highlight! DiffChange guifg=#f4a261 guibg=#2a2519 gui=bold
        highlight! DiffText guifg=#ffffff guibg=#3d3520 gui=bold
      ]])
    end,
  },

  -- sidekick.nvim - Alternative AI coding assistant with visual diffs
  -- Shows diffs as extmarks/virtual text without modifying buffer
  -- Hunk-by-hunk navigation, Tab to accept, Esc to clear
  -- {
  --   "folke/sidekick.nvim",
  --   enabled = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     -- Keep the terminal on the right like your previous setup
  --     cli = {
  --       win = {
  --         layout = "right",
  --         split = {
  --           width = 0, -- use default split width (set a number to force)
  --         },
  --       },
  --     },
  --   },
  --   keys = {
  --     { "<leader>a", nil, desc = "AI/Sidekick" },
  --     { "<leader>aS", "<cmd>Sidekick cli toggle name=codex<cr>", desc = "Toggle Sidekick (codex)" },
  --     { "<leader>af", "<cmd>Sidekick cli focus name=codex<cr>", desc = "Focus Sidekick" },
  --     { "<leader>as", "<cmd>Sidekick cli send<cr>", mode = "v", desc = "Send to Sidekick" },
  --     { "<leader>aa", "<cmd>Sidekick nes apply<cr>", desc = "Apply NES edit" },
  --     { "<leader>ad", "<cmd>Sidekick nes clear<cr>", desc = "Clear NES edits" },
  --     { "<leader>an", "<cmd>Sidekick nes jump<cr>", desc = "Jump to NES edit" },
  --   },
  -- },

  -- TODO grapple,
  -- Claude Code test: Auto-opening integration working!
  -- Test 2: Updated hook configuration
  -- Test 3: Jump to last edit location
  -- Test 4: After restart - testing auto-open integration
  -- Test 5: Fixed JSON parsing in hook
  -- Test 6: Manual file opening - SUCCESS! 🎉
  -- Test 7: Jump to last edit location
  -- Test 8: Fixed buffer loading issue

  {
    -- mx              Set mark x
    -- m,              Set the next available alphabetical (lowercase) mark
    -- m;              Toggle the next available mark at the current line
    -- dmx             Delete mark x
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
    -- m:              Preview mark. This will prompt you for a specific mark to
    --                 preview; press <cr> to preview the next mark.
    --
    -- m[0-9]          Add a bookmark from bookmark group[0-9].
    -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- m}              Move to the next bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- m{              Move to the previous bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- dm=             Delete the bookmark under the cursor.
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup()
    end,
    opts = {
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
      },
    },
  },

  -- global marks
  -- {
  --   "theprimeagen/harpoon",
  --   branch = "harpoon2",
  --   dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  --   -- config = function()
  --   --   require("harpoon"):setup()
  --   -- end,
  --   opts = {
  --     menu = {
  --       width = vim.api.nvim_win_get_width(0) - 4,
  --     },
  --     keys = {
  --       {
  --         "<C-e>",
  --         function()
  --           -- basic telescope configuration
  --           local conf = require("telescope.config").values
  --           local function toggle_telescope(harpoon_files)
  --             local file_paths = {}
  --             for _, item in ipairs(harpoon_files.items) do
  --               table.insert(file_paths, item.value)
  --             end
  --
  --             require("telescope.pickers")
  --               .new({}, {
  --                 prompt_title = "Harpoon",
  --                 finder = require("telescope.finders").new_table({
  --                   results = file_paths,
  --                 }),
  --                 previewer = conf.file_previewer({}),
  --                 sorter = conf.generic_sorter({}),
  --               })
  --               :find()
  --           end
  --
  --           toggle_telescope(require("harpoon"):list())
  --         end,
  --         desc = "Open Telescope harpoon window",
  --       },
  --       {
  --         "<leader>A",
  --         function()
  --           require("harpoon"):list():append()
  --         end,
  --         desc = "harpoon file",
  --       },
  --       {
  --         "<leader>a",
  --         function()
  --           local harpoon = require("harpoon")
  --           harpoon.ui:toggle_quick_menu(harpoon:list())
  --         end,
  --         desc = "harpoon quick menu",
  --       },
  --       {
  --         "<leader>1",
  --         function()
  --           require("harpoon"):list():select(1)
  --         end,
  --         desc = "harpoon to file 1",
  --       },
  --       {
  --         "<leader>2",
  --         function()
  --           require("harpoon"):list():select(2)
  --         end,
  --         desc = "harpoon to file 2",
  --       },
  --       {
  --         "<leader>3",
  --         function()
  --           require("harpoon"):list():select(3)
  --         end,
  --         desc = "harpoon to file 3",
  --       },
  --       {
  --         "<leader>4",
  --         function()
  --           require("harpoon"):list():select(4)
  --         end,
  --         desc = "harpoon to file 4",
  --       },
  --       {
  --         "<leader>5",
  --         function()
  --           require("harpoon"):list():select(5)
  --         end,
  --         desc = "harpoon to file 5",
  --       },
  --     },
  --   },
  -- },

  -- jump to edits like buffers
  {
    "bloznelis/before.nvim",
    lazy = true,
    config = function()
      require("before").setup()
    end,
    opts = {
      -- How many edit locations to store in memory (default: 10)
      history_size = 11,
      -- Should it wrap around the ends of the edit history (default: false)
      history_wrap_enabled = true,
    },
    keys = {
      { "[<leader>", "<cmd>lua require('before').jump_to_last_edit()<CR>", desc = "Last edit this Session" },
      { "]<leader>", "<cmd>lua require('before').jump_to_next_edit()<CR>", desc = "Next edit this Session" },
    },
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>t", "<cmd>lua require('undotree').toggle()<cr>" },
    },
    opts = {
      -- float_diff = false,
      -- layout = "left_left_bottom", -- "left_bottom", "left_left_bottom"
      position = "right", -- "right", "bottom"
      -- window = {
      --   winblend = 3000000,
      -- },
    },
  },

  -- file operations (Rename duplicate, etc)
  -- {
  --   "chrisgrieser/nvim-genghis",
  --   dependencies = "stevearc/dressing.nvim",
  --   lazy = true,
  --   -- config = function()
  --   --   require("genghis")
  --   -- end,
  --   -- keys = {
  --   --   { "<leader>yp", require("genghis").copyFilepath, desc = "copyFilepath" },
  --   --   { "<leader>yn", require("genghis").copyFilename, desc = "genghis.copyFilename" },
  --   --   { "<leader>cx", require("genghis").chmodx, desc = "genghis.chmodx" },
  --   --   { "<leader>rf", require("genghis").renameFile, desc = "genghis.renameFile" },
  --   --   { "<leader>mf", require("genghis").moveAndRenameFile, desc = "genghis.moveAndRenameFile" },
  --   --   { "<leader>mc", require("genghis").moveToFolderInCwd, desc = "genghis.moveToFolderInCwd" },
  --   --   { "<leader>nf", require("genghis").createNewFile, desc = "genghis.createNewFile" },
  --   --   { "<leader>yf", require("genghis").duplicateFile, desc = "genghis.duplicateFile" },
  --   --   { "<leader>df", require("genghis").trashFile, desc = "genghis.trashFile" },
  --   --   { "<leader>x", require("genghis").moveSelectionToNewFile, desc = "genghis.moveSelectionToNewFile" },
  --   -- },
  -- },

  -- jump only edits with (C-h/l)
  -- {
  --   "bloznelis/before.nvim",
  --   config = function()
  --     require("before").setup()
  --   end,
  --   keys = {
  --     { before = require("before") },
  --     { "<C-h>", before.jump_to_last_edit, desc = ", before.jump_to_last_edit{}" },
  --     { "<C-l>", before.jump_to_next_edit, desc = ", before.jump_to_next_edit{}" },
  --   },
  -- },

  -- jump list (C-i/o) with context
  {
    "cbochs/portal.nvim",
    lazy = true,
    -- Optional dependencies
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon",
    },
    opts = {
      max_results = 3,
      select_first = true,
      window_options = {
        -- relative = "cursor",
        width = 50,
        -- height = 3,
      },
      escape = {
        ["<esc>"] = true,
        ["<C-c>"] = true,
      },

      -- filter = {
      --   function(v)
      --     return vim.api.nvim_buf_get_option(v.buffer, "modified")
      --   end,
      -- },
    },
    keys = {
      { "<leader><C-o>", "<cmd>Portal jumplist backward<cr>" },
      { "<leader><C-i>", "<cmd>Portal jumplist forward<cr>" },
    },
  },

  -- {
  --   "dzfrias/arena.nvim",
  --   event = "BufWinEnter",
  --   -- Calls `.setup()` automatically
  --   config = true,
  --   keys = {
  --     { "<leader>`", ":ArenaToggle<CR>", desc = "Arena Buffer Switcher" },
  --   },
  -- },

  -- {
  --   "andrewferrier/wrapping.nvim",
  --   config = function()
  --     require("wrapping").setup()
  --   end,
  -- },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   tag = "0.1.5",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   --   "nvim-telescope/telescope-fzf-native.nvim",
  --   --   build = "make",
  --   --   enabled = vim.fn.executable("make") == 1,
  --   --   config = function()
  --   --     Util.on_load("telescope.nvim", function()
  --   --       require("telescope").load_extension("fzf")
  --   --     end)
  --   --   end,
  --   keys = {
  --     {
  --       "<leader>,",
  --       "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
  --       desc = "Switch Buffer",
  --     },
  --     {
  --       "<leader>:",
  --       "<cmd>Telescope command_history<cr>",
  --       desc = "Command History",
  --     },
  --     {
  --       "<leader><space>",
  --       Util.telescope("files"),
  --       desc = "Find Files (root dir)",
  --     },
  --     -- find
  --     { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  --     {
  --       "<leader>fc",
  --       Util.telescope.config_files(),
  --       desc = "Find Config File",
  --     },
  --     {
  --       "<leader>ff",
  --       Util.telescope("files"),
  --       desc = "Find Files (root dir)",
  --     },
  --     {
  --       "<leader>fF",
  --       Util.telescope("files", { cwd = false }),
  --       desc = "Find Files (cwd)",
  --     },
  --     {
  --       "<leader>fg",
  --       "<cmd>Telescope git_files<cr>",
  --       desc = "Find Files (git-files)",
  --     },
  --     { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  --     { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
  --     -- git
  --     { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
  --     { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
  --     -- search
  --     { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
  --     { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  --     { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  --     {
  --       "<leader>sc",
  --       "<cmd>Telescope command_history<cr>",
  --       desc = "Command History",
  --     },
  --     { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  --     {
  --       "<leader>sd",
  --       "<cmd>Telescope diagnostics bufnr=0<cr>",
  --       desc = "Document diagnostics",
  --     },
  --     {
  --       "<leader>sD",
  --       "<cmd>Telescope diagnostics<cr>",
  --       desc = "Workspace diagnostics",
  --     },
  --     {
  --       "<leader>sg",
  --       Util.telescope("live_grep"),
  --       desc = "Grep (root dir)",
  --     },
  --     { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
  --     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  --     {
  --       "<leader>sH",
  --       "<cmd>Telescope highlights<cr>",
  --       desc = "Search Highlight Groups",
  --     },
  --     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  --     { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  --     { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  --     { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  --     { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  --     {
  --       "<leader>sw",
  --       Util.telescope("grep_string", { word_match = "-w" }),
  --       desc = "Word (root dir)",
  --     },
  --     { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
  --     {
  --       "<leader>sw",
  --       Util.telescope("grep_string"),
  --       mode = "v",
  --       desc = "Selection (root dir)",
  --     },
  --     {
  --       "<leader>sW",
  --       Util.telescope("grep_string", { cwd = false }),
  --       mode = "v",
  --       desc = "Selection (cwd)",
  --     },
  --     {
  --       "<leader>uC",
  --       Util.telescope("colorscheme", { enable_preview = true }),
  --       desc = "Colorscheme with preview",
  --     },
  --     {
  --       "<leader>ss",
  --       function()
  --         require("telescope.builtin").lsp_document_symbols({
  --           symbols = require("lazyvim.config").get_kind_filter(),
  --         })
  --       end,
  --       desc = "Goto Symbol",
  --     },
  --     {
  --       "<leader>sS",
  --       function()
  --         require("telescope.builtin").lsp_dynamic_workspace_symbols({
  --           symbols = require("lazyvim.config").get_kind_filter(),
  --         })
  --       end,
  --       desc = "Goto Symbol (Workspace)",
  --     },
  --   },
  --   opts = function()
  --     local actions = require("telescope.actions")
  --
  --     local open_with_trouble = function(...)
  --       return require("trouble.providers.telescope").open_with_trouble(...)
  --     end
  --     local open_selected_with_trouble = function(...)
  --       return require("trouble.providers.telescope").open_selected_with_trouble(...)
  --     end
  --     local find_files_no_ignore = function()
  --       local action_state = require("telescope.actions.state")
  --       local line = action_state.get_current_line()
  --       Util.telescope("find_files", { no_ignore = true, default_text = line })()
  --     end
  --     local find_files_with_hidden = function()
  --       local action_state = require("telescope.actions.state")
  --       local line = action_state.get_current_line()
  --       Util.telescope("find_files", { hidden = true, default_text = line })()
  --     end
  --
  --     return {
  --       defaults = {
  --         prompt_prefix = " ",
  --         selection_caret = " ",
  --         -- open files in the first window that is an actual file.
  --         -- use the current window if no other window is available.
  --         get_selection_window = function()
  --           local wins = vim.api.nvim_list_wins()
  --           table.insert(wins, 1, vim.api.nvim_get_current_win())
  --           for _, win in ipairs(wins) do
  --             local buf = vim.api.nvim_win_get_buf(win)
  --             if vim.bo[buf].buftype == "" then
  --               return win
  --             end
  --           end
  --           return 0
  --         end,
  --         mappings = {
  --           i = {
  --             ["<c-t>"] = open_with_trouble,
  --             ["<a-t>"] = open_selected_with_trouble,
  --             ["<a-i>"] = find_files_no_ignore,
  --             ["<a-h>"] = find_files_with_hidden,
  --             ["<C-Down>"] = actions.cycle_history_next,
  --             ["<C-Up>"] = actions.cycle_history_prev,
  --             ["<C-f>"] = actions.preview_scrolling_down,
  --             ["<C-b>"] = actions.preview_scrolling_up,
  --           },
  --           n = {
  --             ["q"] = actions.close,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- Obsidian notes
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   event = {
  --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --     "BufReadPre ~/Documents/vault/**.md",
  --     "BufNewFile ~/Documents/vault/**.md",
  --     -- "BufNewFile path/to/my-vault/**.md",
  --   },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --     -- see below for full list of optional dependencies 👇
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "vault",
  --         path = "~/Documents/vault/",
  --       },
  --     },
  --     -- notes_subdir = "6 - etc/notes",
  --     -- daily_notes = {
  --     --   folder = "0 - agenda",
  --     -- },
  --     -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  --     completion = {
  --       -- Set to false to disable completion.
  --       nvim_cmp = true,
  --       -- Trigger completion at 2 chars.
  --       min_chars = 2,
  --     },
  --   },
  --
  --   -- see below for full list of options 👇
  -- },

  -- GPT in Neovim
  -- {
  --   "robitx/gp.nvim",
  --   lazy = true,
  --   lazy = true,
  --   keys = {
  --     { "<leader>`", false },
  --     -- { "<leader>`", ":'<,'>GpChatToggle<cr>", desc = "GPT Chat Contextual Toggle" },
  --     -- { mode = { "n", "v" }, "<leader>\\", ":GpChatToggle<cr>", desc = "GPT Chat Contextual Toggle" },
  --     { mode = { "n", "v" }, "<C-g>", ":GpChatToggle<cr>", desc = "GPT Chat Contextual Toggle" },
  --     -- { "<leader>\\\\", ":GpChatRespond<cr>", desc = "GPT Chat Respond" },
  --     { "<leader>Cf", ":GpChatFinder<cr>", desc = "GPT Chat Finder" },
  --     { "<leader>Cp", ":GpChatPaste<cr>", desc = "GPT Chat Paste" },
  --     { "<leader>Cn", ":GpChatNew<cr>", desc = "GPT Chat New" },
  --     { "<leader>Cr", ":GpChatRespond<cr>", desc = "GPT Chat Respond" },
  --     { "<leader>Cc", ":GpContext<cr>", desc = "GPT Context (.gp.md)" },
  --     { "<leader>Cd", ":GpChatDelete<cr>", desc = "GPT Chat Delete" },
  --     { "<leader>Cs", ":GpStop<cr>", desc = "GPT Stop Process" },
  --     -- disable the switch buffer keymap
  --     -- { "n", "<leader>`", vim.NIL },
  --     -- { "n", "<leader>`", ":GpChatFinder<cr>", desc = "Gp Chat Finder" },
  --     -- { "n", "<leader>`", "<cmd>Telescope find_files<cr>", desc = "Open GPT Chat Finder" },
  --   },
  --   config = function()
  --     require("gp").setup({
  --       openai_api_key = {
  --         "cat",
  --         "/Users/v/.openai",
  --       },
  --       -- openai_api_key = {
  --       --   "op",
  --       --   "read",
  --       --   "op://Personal/mhgs4auyjijxtrytbsqw3hucty/Other Fields/credential",
  --       -- },
  --
  --       -- NOTE Switch with GPAgent ChatGPT4 and GPNextAgent
  --       agents = {
  --         {
  --           name = "ChatGPT4",
  --           chat = true,
  --           command = true,
  --           -- string with model name or table with model name and parameters
  --           model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
  --           -- system prompt (use this to specify the persona/role of the AI)
  --           system_prompt = "You are a general AI assistant.\n\n"
  --             .. "The user provided the additional info about how they would like you to respond:\n\n"
  --             .. "- If you're unsure don't guess and say you don't know instead.\n"
  --             .. "- Ask question if you need clarification to provide better answer.\n"
  --             .. "- Think deeply and carefully from first principles step by step.\n"
  --             .. "- Zoom out first to see the big picture and then zoom in to details.\n"
  --             .. "- Use Socratic method to improve your thinking and coding skills.\n"
  --             .. "- Don't hide any code from your output if the answer requires coding.\n"
  --             .. "- Break down the steps where possible, but use as few words are tokens to explain the solution. Be terse.\n"
  --             .. "- Try and use pure solutions that are as short as possible, with clear and beautiful patterns. When coding, use as few libraries, and use only pure or very popular libraries.\n"
  --             .. "-When dealing with anything that is not code, make sure to research the latest information, demonstrate expertise and always reference popular best practices.\n"
  --             .. "- Take a deep breath; You've got this!\n",
  --         },
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   lazy = true,
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

  -- {
  --   "elentok/format-on-save.nvim",
  --   lazy = true,
  --   config = function()
  --     local format_on_save = require("format-on-save")
  --     local formatters = require("format-on-save.formatters")
  --
  --     format_on_save.setup({
  --       exclude_path_patterns = {
  --         "/node_modules/",
  --         ".local/share/nvim/lazy",
  --       },
  --       formatter_by_ft = {
  --         css = formatters.lsp,
  --         html = formatters.lsp,
  --         java = formatters.lsp,
  --         javascript = formatters.lsp,
  --         json = formatters.lsp,
  --         lua = formatters.lsp,
  --         markdown = formatters.prettierd,
  --         openscad = formatters.lsp,
  --         python = formatters.black,
  --         rust = formatters.lsp,
  --         scad = formatters.lsp,
  --         scss = formatters.lsp,
  --         sh = formatters.shfmt,
  --         terraform = formatters.lsp,
  --         typescript = formatters.prettierd,
  --         typescriptreact = formatters.prettierd,
  --         yaml = formatters.lsp,
  --       },
  --     })
  --   end,
  -- },

  -- latex plugins
  -- {
  --   "marioortizmanero/adoc-pdf-live.nvim",
  --   lazy = true,
  --   config = function()
  --     -- require("colorizer").setup({})
  --     require("adoc_pdf_live").setup()
  --   end,
  -- },

  -- tex in vim
  -- {
  --   "lervag/vimtex",
  --   lazy = true,
  --   ft = "tex",
  --   opts = {
  --     "-verbose",
  --     "-file-line-error",
  --     "-synctex=1",
  --     "-interaction=nonstopmode",
  --     "-shell-escape",
  --   },
  --   config = function()
  --     -- vim.g.vimtex_view_method = "skim"
  --     -- vim.g.vimtex_compiler_engine = "lualatex"
  --     vim.g.vimtex_compiler_engine = "xelatex"
  --     vim.g.maplocalleader = ","
  --     vim.g.vimtex_view_general_options = "--synctex=1 @line @pdf @tex"
  --     vim.g.vimtex_quickfix_mode = 0
  --   end,
  -- },

  -- hex color in vim
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
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
    keys = { { "<leader>cc", "<cmd>ColorizerToggle<CR>", desc = "Colorizer Toggle" } },
  },

  -- surround with cs
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    lazy = true,
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
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    opts = {
      -- NOTE moved to keymaps
      -- { require("util.functions").OpenDotfilesInNeogit },
    },
    config = true,
    keys = {
      { "<leader>gG", false },
      { "<leader>gg", ":Neogit<CR>", silent = true, desc = "Open Neogit" },
      {
        "<leader>gd",
        "<cmd>lua require('util.functions').OpenDotfilesInNeogit()<CR>",
        desc = "Open Neogit for dotfiles",
        silent = true,
      },
    },
  },

  -- {
  --   "kdheepak/lazygit.nvim",
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- TODO does not do the ()text (t)ext behavior yet
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {
  --     fast_wrap = {
  --       map = "<C-.>",
  --     },
  --   },
  -- },
  -- {
  --   -- Vimscript to hold window at specific line - usually center
  --   "vim-scripts/scrollfix",
  --   config = function()
  --     vim.g["scrollfix"] = 50
  --   end,
  -- },

  -- Basic file ops
  { "tpope/vim-eunuch", lazy = true },

  -- Detect tabstop and shiftwidth automatically
  { "tpope/vim-sleuth", lazy = true },

  -- {
  --   -- Better buffer closing actions. Available via the buffers helper.
  --   "kazhala/close-buffers.nvim",
  --   opts = {
  --     preserve_window_layout = { "this", "nameless" },
  --   },
  -- },
  {
    -- Move stuff with <M-j> and <M-k> in both normal and visual mode
    "nvim-mini/mini.move",
    lazy = true,
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false, -- Load immediately to replace default file explorer
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      default_file_explorer = true, -- Take over directory buffers (vim ., :e src/, etc)
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["?"] = "actions.show_help",
        ["<C-h>"] = false, -- Disable default to avoid conflict with window navigation
        ["<C-l>"] = false, -- Disable default to avoid conflict with window navigation
      },
      view_options = {
        show_hidden = true, -- Show hidden files
        is_always_hidden = function(name, bufnr)
          return name == ".."
        end,
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
    },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil file explorer" },
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },
  {
    "tpope/vim-repeat",
    lazy = true,
  },
  {
    -- Resolve conflicts with cX, jump with ]x
    "akinsho/git-conflict.nvim",
    lazy = true,
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
    lazy = true,
    config = function()
      require("bufresize").setup()
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- For `nvim-treesitter` users.
    priority = 49,

    -- For blink.cmp's completion
    -- source
    dependencies = {
      "saghen/blink.cmp",
    },
  },

  { "danilamihailov/beacon.nvim" }, -- lazy calls setup() by itself
  -- TODO some error here
  -- {
  --   "danilamihailov/beacon.nvim",
  --   lazy = true,
  --   keys = {
  --     { "n", "n:Beacon<cr>", desc = "Beacon Search Term Next" },
  --     { "N", "N:Beacon<cr>", desc = "Beacon Search Term Prev" },
  --     { "*", "*:Beacon<cr>", desc = "Beacon Cursor Term Next" },
  --     { "#", "#:Beacon<cr>", desc = "Beacon Cursor Term Prev" },
  --   },
  --   config = function()
  --     -- beacon_minimal_jump = 2,
  --     vim.g.beacon_shrink = 0
  --     vim.g.beacon_fade = 1
  --     vim.g.beacon_size = 777
  --
  --     -- color
  --     -- highlight Beacon guibg=white ctermbg=15
  --     -- vim.api.nvim_set_hl(0, "Beacon", { guibg = "white", ctermbg = 15 })
  --     -- vim.cmd([[highlight Beacon guibg=white ctermbg=15]])
  --   end,
  -- },

  -- cursor line mode color
  {
    "mawkler/modicator.nvim",
    lazy = true,
    -- dependencies = "mawkler/onedark.nvim", -- Add your colorscheme plugin here
    -- dependencies = "folke/tokyonight.nvim", -- Using tokyonight for consistency
    dependencies = "folke/tokyonight.nvim",
    config = function()
      require("modicator").setup({
        -- Warn if any required option above is missing. May emit false positives
        -- if some other plugin modifies them, which in that case you can just
        -- ignore. Feel free to remove this line after you've gotten Modicator to
        -- work properly.
        show_warnings = true,
      })
    end,
  },
  -- init = function()
  --   -- These are required for Modicator to work
  --   vim.o.cursorline = true
  --   vim.o.number = true
  --   vim.o.termguicolors = true
  -- end,

  -- customized lua bar
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

  -- Smooth cursor animations (macOS optimized)
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
    },
  },

  -- Beautiful inline diagnostics (replaces virtual text)
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    opts = { preset = "modern" },
  },

  -- Split/join code blocks with Treesitter awareness
  {
    "Wansmer/treesj",
    keys = {
      { "gJ", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    },
    opts = { use_default_keymaps = false },
  },

  -- Interactive text alignment
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Align" },
      { "gA", mode = { "n", "v" }, desc = "Align with preview" },
    },
    opts = {},
  },

  -- IDE-like breadcrumb navigation (clickable, Treesitter-powered)
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Enable additional Snacks modules
  {
    "folke/snacks.nvim",
    opts = {
      dim = { enabled = true },
      zen = { enabled = true },
      words = { enabled = true },
      gitbrowse = { enabled = true },
      scratch = { enabled = true },
    },
  },

  -- Session management with git branch awareness
  {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      autoload = true,
      use_git_branch = true,
    },
  },
}
