--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                                                                        │
--  │                       ######                                           │
--  │                     ######                                             │
--  │                    #####                                               │
--  │                    #####                                               │
--  │                    #####                                               │
--  │            ######  #####                                               │
--  │          ######    #####         custom.lua                            │
--  │        #######     #####         New plugins not part of LazyVim       │
--  │       ######        ####                                               │
--  │        ######        ###         overrides → modify.lua                │
--  │          #####        ##         disabled  → disable.lua               │
--  │           #####        #                                               │
--  │            #####                                                       │
--  │             #####                                                      │
--  │              #####                                                     │
--  │               #####                                                    │
--  │                #####                                                   │
--  │                 #####                                                  │
--  │                                                                        │
--  ╰────────────────────────────────────────────────────────────────────────╯

return {

  -- claude-code.nvim: alternative claude terminal integration
  -- NOTE: disabled, using coder/claudecode.nvim instead
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

  -- vim-unified-diff: single-pane diff view
  -- NOTE: disabled, does not work reliably with claudecode buffers
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

  -- unified.nvim: single diff view
  -- NOTE: does not work
  -- {
  --   "axkirillov/unified.nvim",
  --   opts = {
  --     -- your configuration comes here
  --   },
  -- },

  -- diffview.nvim: 3-screen diff view
  -- NOTE: disabled, git-only, does not work with claudecode buffers
  -- {
  --   "sindrets/diffview.nvim",
  -- },

  -- nvim-recorder: macro recording with status display (q to record, Q to play)
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- NOTE: optional
    opts = {}, -- NOTE: required even with default settings, calls setup()
  },

  -- gitsigns.nvim: git signs in gutter and hunk navigation (auto)
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      -- NOTE: minimal config to avoid claudecode.nvim conflicts
      signs = {
        add = { text = "+" },
        change = { text = "·" },
        delete = { text = "_" },
      },
      -- NOTE: disable features that might conflict with claudecode.nvim
      -- word_diff = false,
      -- attach_to_untracked = false,
    },
  },

  -- gemini-cli.nvim: gemini terminal integration
  -- NOTE: disabled, using claudecode.nvim instead
  -- {
  --   "jonroosevelt/gemini-cli.nvim",
  --   config = function()
  --     require("gemini").setup()
  --   end,
  -- },

  -- diffchar.vim: word-level diff highlighting with single color (auto in diff mode)
  {
    "rickhowe/diffchar.vim",
    event = "VeryLazy",
    config = function()
      vim.g.DiffUnit = "Word1" -- NOTE: word-level (easier to scan than char-by-char)
      vim.g.DiffColors = 0 -- NOTE: single DiffText color (maximum clarity)
      vim.g.DiffPairVisible = 0 -- NOTE: no cursor highlighting on pairs
      vim.g.DiffDelPosVisible = 0 -- NOTE: deletion indicators not helpful
    end,
  },

  -- claudecode.nvim: AI code editing with Claude terminal and diff view (<leader>aC toggle, <leader>\ start)
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    -- NOTE: enabled = false, -- disabled for sidekick.nvim testing
    opts = {
      terminal = {
        split_width_percentage = 0.44,
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
      -- NOTE: smart continue, tries --continue first, falls back to new session
      {
        "<leader>\\",
        function()
          -- NOTE: try to continue existing session
          local ok = pcall(vim.cmd, "ClaudeCode --continue")
          if not ok then
            -- NOTE: no session to continue, start new
            vim.cmd("ClaudeCode")
          end
        end,
        desc = "Continue/Start Claude",
        mode = { "n", "t" },
      },
      -- NOTE: using \ now, <leader>/ conflicts with LazyVim grep
      -- { "<leader>/", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude", mode = { "n", "t" } },
      -- NOTE: claude-jump, jump to previous Claude marker (toggle: first press = jump, second = return)
      --       cross-ref: tmux version in ~/.config/tmux/claude_jump.sh (prefix b)
      --       searches for user prompts (^> ) OR Claude bullets, skips markdown quote blocks
      {
        "gb",
        function()
          vim.notify("gb triggered", vim.log.levels.INFO) -- TEST: debug trace
          local bufnr = vim.api.nvim_get_current_buf()
          local jumped = vim.b[bufnr].claude_jumped

          if jumped then
            -- NOTE: second press, jump back to bottom and enter insert mode
            vim.notify("gb: returning to bottom", vim.log.levels.INFO) -- TEST: debug trace
            vim.cmd([[normal! G]])
            vim.cmd([[startinsert]])
            vim.b[bufnr].claude_jumped = false
            return
          end

          -- NOTE: check if marker already visible in current window
          local first_visible = vim.fn.line("w0")
          local last_visible = vim.fn.line("w$")
          for lnum = first_visible, last_visible do
            local line = vim.fn.getline(lnum)
            if line:match("^> ") or line:match("^⏺") then
              vim.notify("gb: marker visible at line " .. lnum .. ", skipping", vim.log.levels.INFO) -- TEST: debug trace
              return
            end
          end

          -- NOTE: first press, search for marker
          local current_line = vim.fn.line(".")

          while true do
            -- NOTE: search for user prompt OR Claude bullet
            local found = vim.fn.search([[^\(> \|⏺\)]], "bW")
            if found == 0 then
              vim.fn.cursor(current_line, 1)
              vim.notify("No marker found", vim.log.levels.WARN)
              return
            end

            local line = vim.fn.getline(found)
            -- NOTE: if user prompt, check if isolated (not part of quote block)
            if line:match("^> ") then
              local prev_line = vim.fn.getline(found - 1)
              if found == 1 or not prev_line:match("^>") then
                vim.cmd("normal! zt") -- NOTE: position at top
                vim.b[bufnr].claude_jumped = true
                return
              end
            else
              -- NOTE: Claude bullet, always valid
              vim.cmd("normal! zt") -- NOTE: position at top
              vim.b[bufnr].claude_jumped = true
              return
            end
          end
        end,
        mode = "n",
        desc = "Jump to Claude marker (toggle)",
      },
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
      -- NOTE: simple diff keybindings (claudecode.nvim handles the logic)
      { "<leader>]", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>[", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject diff" },
      {
        "<leader>|",
        function()
          -- NOTE: search current tab first
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.b[buf].claudecode_diff_tab_name then
              vim.api.nvim_set_current_win(win)
              return
            end
          end
          -- NOTE: search all tabs
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

      -- NOTE: hardcoded diff colors disabled (2025-01-07)
      --       active theme handles diff colors now (modify.lua overrides)
      -- vim.cmd([[
      --   highlight! DiffAdd guifg=#a7c957 guibg=#1a2e1a gui=bold
      --   highlight! DiffDelete guifg=#8a8a8a guibg=#2a1a1a gui=bold
      --   highlight! DiffChange guifg=#f4a261 guibg=#2a2519 gui=bold
      --   highlight! DiffText guifg=#ffffff guibg=#3d3520 gui=bold
      -- ]])
    end,
  },

  -- sidekick.nvim: alternative AI coding assistant with visual extmark diffs
  -- NOTE: disabled, using claudecode.nvim instead
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

  -- marks.nvim: visual marks and bookmarks (mx set, m] next, m[ prev, dm= delete, m0-9 bookmarks)
  {
    -- NOTE: mx set, m, next available, m; toggle, dmx delete, dm- line, dm<space> buffer
    --       m] next, m[ prev, m: preview, m0-9 bookmarks, dm0-9 delete group, m}/m{ next/prev bookmark
    "chentoast/marks.nvim",
    opts = {
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- NOTE: set to true to prompt for virtual line annotation when setting a bookmark
        annotate = false,
      },
    },
  },

  -- harpoon: global file marks with quick switching
  -- NOTE: disabled, using marks.nvim instead
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

  -- before.nvim: jump to previous/next edit locations in session ([<leader> / ]<leader>)
  {
    "bloznelis/before.nvim",
    lazy = true,
    opts = {
      -- NOTE: how many edit locations to store in memory (default: 10)
      history_size = 11,
      -- NOTE: wrap around the ends of the edit history (default: false)
      history_wrap_enabled = true,
    },
    keys = {
      { "[<leader>", "<cmd>lua require('before').jump_to_last_edit()<CR>", desc = "Last edit this Session" },
      { "]<leader>", "<cmd>lua require('before').jump_to_next_edit()<CR>", desc = "Next edit this Session" },
    },
  },

  -- undotree: visual undo history tree (<leader>t to toggle)
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>t", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
    },
    opts = {
      -- float_diff = false,
      -- layout = "left_left_bottom", -- "left_bottom", "left_left_bottom"
      position = "right", -- NOTE: options: "right", "bottom"
      -- window = {
      --   winblend = 3000000,
      -- },
    },
  },

  -- nvim-genghis: file operations (rename, duplicate, etc.)
  -- NOTE: disabled, using vim-eunuch instead
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

  -- before.nvim: old config with C-h/l binds
  -- NOTE: disabled, replaced by version above with [<leader>/]<leader>
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

  -- portal.nvim: enhanced jumplist with context preview (<leader><C-o> back, <leader><C-i> forward)
  {
    "cbochs/portal.nvim",
    lazy = true,
    -- NOTE: dependencies removed,grapple.nvim and harpoon are both disabled
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

  -- arena.nvim: buffer switcher popup
  -- NOTE: disabled, using fzf-lua for buffer switching
  -- {
  --   "dzfrias/arena.nvim",
  --   event = "BufWinEnter",
  --   config = true,
  --   keys = {
  --     { "<leader>`", ":ArenaToggle<CR>", desc = "Arena Buffer Switcher" },
  --   },
  -- },

  -- wrapping.nvim: soft/hard wrap toggle
  -- NOTE: disabled, using default vim wrap settings
  -- {
  --   "andrewferrier/wrapping.nvim",
  --   config = function()
  --     require("wrapping").setup()
  --   end,
  -- },

  -- telescope.nvim: fuzzy finder
  -- NOTE: disabled, using fzf-lua instead (faster, native fzf)
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

  -- obsidian.nvim: note-taking with Obsidian vault integration
  -- NOTE: disabled, not using Obsidian currently
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

  -- gp.nvim: GPT chat and completion in Neovim
  -- NOTE: disabled, using claudecode.nvim instead
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

  -- ChatGPT.nvim: OpenAI chat integration
  -- NOTE: disabled, using claudecode.nvim instead
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

  -- format-on-save.nvim: auto-format on save with per-filetype formatters
  -- NOTE: disabled, using conform.nvim instead (LazyVim default)
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

  -- adoc-pdf-live.nvim: asciidoc live PDF preview
  -- NOTE: disabled, using vimtex in modify.lua for LaTeX
  -- {
  --   "marioortizmanero/adoc-pdf-live.nvim",
  --   lazy = true,
  --   config = function()
  --     -- require("colorizer").setup({})
  --     require("adoc_pdf_live").setup()
  --   end,
  -- },

  -- vimtex: LaTeX editing and compilation
  -- NOTE: disabled, using vimtex config in modify.lua instead
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

  -- nvim-colorizer.lua: inline hex/rgb color preview (<leader>cc to toggle)
  {
    "catgoose/nvim-colorizer.lua",
    -- NOTE: replaced norcalli/nvim-colorizer.lua (archived 2021) with maintained catgoose fork
    lazy = true,
    opts = {},
    keys = { { "<leader>cc", "<cmd>ColorizerToggle<CR>", desc = "Colorizer Toggle" } },
  },

  -- nvim-surround: surround text with brackets/quotes/tags (ys add, ds delete, cs change)
  {
    "kylechui/nvim-surround",
    -- NOTE: version removed, LazyVim sets version=false globally (latest commit)
    event = "VeryLazy",
    opts = {},
    -- NOTE: ysiw) = (word), ys$" = "to eol", ds] = remove [], dst = remove tags
    --       cs'" = change quotes, csth1<CR> = change to <h1>, dsf = remove function call
  },

  -- neogit: magit-like git interface (<leader>gg open, <leader>gD dotfiles)
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- NOTE: required
      "sindrets/diffview.nvim", -- NOTE: optional, diff integration

      -- NOTE: only one of these is needed, not both
      "nvim-telescope/telescope.nvim", -- NOTE: optional
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
        "<leader>gD",
        "<cmd>lua require('util.functions').OpenDotfilesInNeogit()<CR>",
        desc = "Open Neogit for dotfiles (capital D, <leader>gd = diff-off)",
        silent = true,
      },
    },
  },

  -- lazygit.nvim: lazygit integration
  -- NOTE: disabled, using neogit instead
  -- {
  --   "kdheepak/lazygit.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },

  -- nvim-autopairs: auto-close brackets and quotes
  -- TODO: does not do the ()text (t)ext behavior yet
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {
  --     fast_wrap = {
  --       map = "<C-.>",
  --     },
  --   },
  -- },

  -- scrollfix: vimscript to hold window at specific line (usually center)
  -- NOTE: disabled, using dynamic scrolloff in autocmds.lua instead
  -- {
  --   "vim-scripts/scrollfix",
  --   config = function()
  --     vim.g["scrollfix"] = 50
  --   end,
  -- },

  -- vim-eunuch: unix file commands (:Rename, :Delete, :Move, :Chmod, :Mkdir)
  { "tpope/vim-eunuch", cmd = { "Rename", "Delete", "Move", "Chmod", "Mkdir", "SudoWrite" } },

  -- vim-sleuth: auto-detect indentation (tabstop/shiftwidth) on file open
  { "tpope/vim-sleuth", event = "BufReadPre" },

  -- close-buffers.nvim: better buffer closing actions
  -- NOTE: disabled, using default LazyVim buffer management
  -- {
  --   "kazhala/close-buffers.nvim",
  --   opts = {
  --     preserve_window_layout = { "this", "nameless" },
  --   },
  -- },

  -- mini.move: move lines/selections with <M-j>/<M-k> in normal and visual mode
  {
    "nvim-mini/mini.move",
    lazy = true,
    config = function()
      require("mini.move").setup()
    end,
  },

  -- oil.nvim: file explorer as editable buffer (<leader>e open, - parent dir)
  {
    "stevearc/oil.nvim",
    lazy = false, -- NOTE: load immediately to replace default file explorer
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      default_file_explorer = true, -- NOTE: take over directory buffers (vim ., :e src/, etc)
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["?"] = "actions.show_help",
        ["<C-h>"] = false, -- NOTE: disable default to avoid conflict with window navigation
        ["<C-l>"] = false, -- NOTE: disable default to avoid conflict with window navigation
      },
      view_options = {
        show_hidden = true, -- NOTE: show dotfiles and hidden files
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

  -- vim-repeat: extend . repeat to plugin mappings (auto)
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- git-conflict.nvim: git merge conflict resolution (co ours, ct theirs, cb both, ]x next, [x prev)
  {
    "akinsho/git-conflict.nvim",
    -- NOTE: commit pin removed, was stale, using latest
    event = "BufReadPre",
    opts = {},
  },

  -- bufresize.nvim: preserve window proportions on terminal resize (auto)
  {
    "kwkarlwang/bufresize.nvim",
    event = "VimResized",
    opts = {},
  },

  -- markview.nvim: enhanced markdown rendering with treesitter (auto on markdown files)
  -- NOTE: disabled, conflicts with render-markdown.nvim (modify.lua),
  --       render-markdown works better with conceallevel=0 via anti_conceal
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   priority = 49,
  --   dependencies = {
  --     "saghen/blink.cmp",
  --   },
  -- },

  -- beacon.nvim: cursor position flash on jump/search (n/N/*/# triggers)
  -- NOTE: disabled, unmaintained since 2023, smear-cursor.nvim replaces it
  -- { "danilamihailov/beacon.nvim" },

  -- modicator.nvim: cursorline color changes with vim mode (auto, reflects insert/normal/visual)
  {
    "mawkler/modicator.nvim",
    event = "VeryLazy",
    config = function()
      local colors = require("kanagawa.colors").setup({ theme = "wave" })
      local cursorline = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
      local modicator = require("modicator")

      -- NOTE: modicator rewrites CursorLineNr on every ModeChanged event.
      --       With lualine integration enabled it was pulling non-Kanagawa mode colors,
      --       so the active line number briefly turned gold and then snapped back to blue.
      --       Pin all modes to one Kanagawa accent and reuse CursorLine's background.
      modicator.setup({
        show_warnings = true,
        highlights = {
          defaults = {
            fg = colors.palette.carpYellow,
            bold = true,
          },
          use_cursorline_background = true,
        },
        integration = {
          lualine = {
            enabled = false,
          },
        },
      })

      for _, mode in ipairs(modicator.modes) do
        vim.api.nvim_set_hl(0, mode .. "Mode", {
          fg = colors.palette.carpYellow,
          bg = cursorline.bg,
          bold = true,
        })
      end
    end,
  },

  -- barbar.nvim: customized tab/buffer bar
  -- NOTE: disabled, using showtabline=0 instead (no tab bar)
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
  -- }

  -- smear-cursor.nvim: smooth cursor animations (macOS optimized, auto)
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
    },
  },

  -- tiny-inline-diagnostic.nvim: beautiful inline diagnostics (replaces virtual text, auto on LspAttach)
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    opts = { preset = "modern" },
  },

  -- treesj: split/join code blocks with treesitter awareness (gJ to toggle)
  {
    "Wansmer/treesj",
    keys = {
      { "gJ", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    },
    opts = { use_default_keymaps = false },
  },

  -- mini.align: interactive text alignment (ga align, gA align with preview)
  {
    "nvim-mini/mini.align",
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Align" },
      { "gA", mode = { "n", "v" }, desc = "Align with preview" },
    },
    opts = {},
  },

  -- dropbar.nvim: IDE-like breadcrumb navigation (clickable, treesitter-powered)
  -- NOTE: disabled, replaced by incline.nvim floating labels + navic in statusline
  -- {
  --   "Bekaboo/dropbar.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  -- incline.nvim: floating filename label per window (icon + filename only)
  -- NOTE: always visible, highlights set in modify.lua theme overrides
  -- NOTE: full path shown in statusline only, incline is just a quick label
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      hide = {
        cursorline = "focused_win",
        only_win = false,
      },
      ignore = {
        filetypes = { "neo-tree", "dashboard", "alpha", "help", "noice" },
      },
      window = {
        padding = { left = 1, right = 1 },
        margin = { horizontal = 1, vertical = 1 },
        placement = { horizontal = "right", vertical = "top" },
      },
      render = function(props)
        local buf = props.buf
        local fullname = vim.api.nvim_buf_get_name(buf)
        local filename = vim.fn.fnamemodify(fullname, ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

        -- diagnostics
        local diag = {}
        for _, d in ipairs({
          { "Error", " " },
          { "Warn", " " },
          { "Info", " " },
          { "Hint", " " },
        }) do
          local n = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity[d[1]:upper()] })
          if n > 0 then
            table.insert(diag, { d[2] .. n .. " ", group = "DiagnosticSign" .. d[1] })
          end
        end
        if #diag > 0 then
          table.insert(diag, { "┊ " })
        end

        -- git diff
        local git = {}
        local signs = vim.b[buf].gitsigns_status_dict
        if signs then
          for _, g in ipairs({
            { "added", " ", "GitSignsAdd" },
            { "changed", " ", "GitSignsChange" },
            { "removed", " ", "GitSignsDelete" },
          }) do
            if tonumber(signs[g[1]]) and signs[g[1]] > 0 then
              table.insert(git, { g[2] .. signs[g[1]] .. " ", group = g[3] })
            end
          end
          if #git > 0 then
            table.insert(git, { "┊ " })
          end
        end

        return {
          { diag },
          { git },
          { (ft_icon or "") .. " ", guifg = ft_color },
          { filename .. " ", gui = "bold" },
        }
      end,
    },
  },

  -- snacks.nvim: additional modules (dim, zen, gitbrowse, scratch)
  -- NOTE: disabled, merged into single snacks block in modify.lua
  -- {
  --   "folke/snacks.nvim",
  --   opts = {
  --     dim = { enabled = true },
  --     zen = { enabled = true },
  --     words = { enabled = true },
  --     gitbrowse = { enabled = true },
  --     scratch = { enabled = true },
  --   },
  -- },

  -- ocaml.nvim: advanced OCaml beyond LSP (type search, .ml/.mli switch, interface gen)
  -- NOTE: built by Tarides (ocaml-lsp maintainers), requires ocamllsp from opam
  {
    "tarides/ocaml.nvim",
    ft = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex" },
    config = function()
      require("ocaml").setup()
    end,
  },

  -- persisted.nvim: session management with git branch awareness (auto on start)
  {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      autoload = true,
      use_git_branch = true,
    },
  },

  -- auto-save.nvim: automatic buffer saving
  -- NOTE: disabled, too aggressive (saves after every edit). Using swap files for crash
  --       protection instead (swapfile=true in options.lua, auto-recover in autocmds.lua)
  --       Manual save: Ctrl+S / Cmd+S / <leader>S
  -- {
  --   "okuuva/auto-save.nvim",
  --   event = { "InsertLeave", "TextChanged" },
  --   opts = {},
  -- },

  -- mason-tool-installer: auto-update all Mason packages daily on startup (silent)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      auto_update = true,
      run_on_start = true,
      debounce_hours = 24,
    },
  },
}
