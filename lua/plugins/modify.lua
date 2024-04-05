return {
  -- formatter
  -- TODO shfmt doesn't work
  -- {
  --   "stevearc/conform.nvim",
  --   -- lazy = false,
  --   -- NOTE default to lsp for everything
  --   opts = {
  --     -- Define your formatters
  --     -- formatters_by_ft = {},
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       sh = { "shfmt" },
  --       python = { "isort", "black" },
  --       javascript = { { "prettierd", "prettier" } },
  --       css = { "stylelint" },
  --       nix = { { "alejandra" } },
  --       md = { { "mdformat", "autocorrect" } },
  --       yaml = { { "yq" } },
  --       json = { { "yq" } },
  --       tex = { { "latexindent" } },
  --       -- html = { { "djlint" } },
  --       c = { { "astyle" } },
  --       cpp = { { "astyle" } },
  --     },
  --     -- Set up format-on-save
  --     -- Customize formatters
  --     -- format_on_save = { timeout_ms = 0, lsp_fallback = true },
  --     formatters = {
  --       shfmt = {
  --         prepend_args = { "-i", "2", "-ci" },
  --       },
  --     },
  --   },
  -- },

  -- No need to copy this inside `setup()`. Will be used automatically.
  {
    "echasnovski/mini.animate",
    opts = {

      cursor = {
        timing = require("mini.animate").gen_timing.linear({ duration = 7, unit = "total" }),
      },
      scroll = {
        timing = require("mini.animate").gen_timing.linear({ duration = 13, unit = "total" }),
      },
    },
  },
  --
  --
  --   -- Cursor path
  --   -- cursor = {
  --   --   -- Whether to enable this animation
  --   --   enable = true,
  --   --
  --   --   -- Timing of animation (how steps will progress in time)
  --   --   -- timing = --<function: implements linear total 250ms animation duration>,
  --   --
  --   --   -- Path generator for visualized cursor movement
  --   --   path = --<function: implements shortest line path>,
  --   -- },
  --
  --   -- Vertical scroll
  --   scroll = {
  --     -- Whether to enable this animation
  --     -- enable = true,
  --
  --     -- Timing of animation (how steps will progress in time)
  --     timing = 100,
  --
  --     -- Subscroll generator based on total scroll
  --     -- subscroll = --<function: implements equal scroll with at most 60 steps>,
  --   },
  --
  --   -- -- Window resize
  --   -- resize = {
  --   --   -- Whether to enable this animation
  --   --   -- enable = true,
  --   --
  --   --   -- Timing of animation (how steps will progress in time)
  --   --   -- timing = --<function: implements linear total 250ms animation duration>,
  --   --
  --   --   -- Subresize generator for all steps of resize animations
  --   --   -- subresize = --<function: implements equal linear steps>,
  --   -- },
  --   --
  --   -- -- Window open
  --   -- open = {
  --   --   -- Whether to enable this animation
  --   --   -- enable = true,
  --   --
  --   --   -- Timing of animation (how steps will progress in time)
  --   --   -- timing = --<function: implements linear total 250ms animation duration>,
  --   --
  --   --   -- Floating window config generator visualizing specific window
  --   --   -- winconfig = --<function: implements static window for 25 steps>,
  --   --
  --   --   -- 'winblend' (window transparency) generator for floating window
  --   --   -- winblend = --<function: implements equal linear steps from 80 to 100>,
  --   -- },
  --   --
  --   -- -- Window close
  --   -- close = {
  --   --   -- Whether to enable this animation
  --   --   -- enable = true,
  --   --
  --   --   -- Timing of animation (how steps will progress in time)
  --   --   -- timing = --<function: implements linear total 250ms animation duration>,
  --   --
  --   --   -- Floating window config generator visualizing specific window
  --   --   -- winconfig = --<function: implements static window for 25 steps>,
  --   --
  --   --   -- 'winblend' (window transparency) generator for floating window
  --   --   -- winblend = --<function: implements equal linear steps from 80 to 100>,
  --   -- },
  -- },
  -- },

  -- indentscope animation
  {
    "echasnovski/mini.indentscope",
    opts = {
      -- symbol = "▏",
      symbol = " ▏",
      -- symbol = " ▏ ",
      -- draw = { delay =  },
      -- symbol = " |",
      options = {
        -- Type of scope's border: which line(s) with smaller indent to
        -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
        border = "both",

        -- Whether to use cursor column when computing reference indent.
        -- Useful to see incremental scopes with horizontal cursor movements.
        -- indent_at_cursor = false,

        -- Whether to first check input line to be a border of adjacent scope.
        -- Use it if you want to place cursor on function header to get scope of
        -- its body.
        try_as_border = true,
      },

      -- symbol = "╎",
    },
  },

  -- transparent tokyonight
  {
    "tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      -- TODO doesn't do a damn thing
      -- highlights = {
      --   CursorLineNr = {
      --     bg = "#161616",
      --     -- c.bg_highlight,
      --   },
      -- },
      -- on_highlights = function(hl, c)
      -- end,
    },
  },

  -- NOTE starter experiments
  -- {
  --   "echasnovski/mini.starter",
  --   opts = function()
  --     -- local vlogo = require("util.functions").vLogo()
  --
  --     local vlogo = table.concat({
  --       " #################################################### ",
  --       " ######################        ###################### ",
  --       " ################                    ################ ",
  --       " #############                #######   ############# ",
  --       " ###########                #########     ########### ",
  --       " #########                 ########         ######### ",
  --       " ########                  ######            ######## ",
  --       " #######                   ######             ####### ",
  --       " ######            ####### ######              ###### ",
  --       " #####           ######### ######               ##### ",
  --       " #####           #######   ######               ##### ",
  --       " #####            ######    #####               ##### ",
  --       " #####             ######    ####               ##### ",
  --       " #####              ######    ###               ##### ",
  --       " #####               ######    #                ##### ",
  --       " ######               ######                   ###### ",
  --       " #######               #####                  ####### ",
  --       " ########               #####                ######## ",
  --       " ##########              #####             ########## ",
  --       " ############             #####          ############ ",
  --       " ##############               ##       ############## ",
  --       " ##################                ################## ",
  --       " #################################################### ",
  --     }, "\n")
  --
  --     local pad = string.rep(" ", 22)
  --     local new_section = function(name, action, section)
  --       return { name = name, action = action, section = pad .. section }
  --     end
  --
  --     local starter = require("mini.starter")
  --     --stylua: ignore
  --     local config = {
  --       evaluate_single = true,
  --       header = vlogo,
  --       items = {
  --         new_section("Find file", "Telescope find_files", "Telescope"),
  --         new_section("Recent files", "Telescope oldfiles", "Telescope"),
  --         -- new_section("Grep text", "Telescope live_grep", "Telescope"),
  --         -- new_section("Config", "lua require('lazyvim.util').telescope.config_files()()", "Config"),
  --         -- new_section("Extras", "LazyExtras", "Config"),
  --         -- new_section("Lazy", "Lazy", "Config"),
  --         -- new_section("New file", "ene | startinsert", "Built-in"),
  --         -- new_section("Quit", "qa", "Built-in"),
  --         -- new_section("Session restore", [[lua require("persistence").load()]], "Session"),
  --       },
  --       content_hooks = {
  --         starter.gen_hook.adding_bullet(pad .. "░ ", false),
  --         starter.gen_hook.aligning("center", "center"),
  --       },
  --     }
  --     return config
  --   end,

  -- No logo

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   tag = "0.1.5",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "tsakirist/telescope-lazy.nvim",
  --   },
  --   keys = {
  --     -- add a keymap to browse plugin files
  --     -- stylua: ignore
  --     {
  --       "<leader>fp",
  --       function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
  --       desc = "Find Plugin File",
  --     },
  --   },
  --   -- change some options
  --   opts = {
  --     defaults = {
  --       layout_strategy = "horizontal",
  --       layout_config = { prompt_position = "top" },
  --       sorting_strategy = "ascending",
  --       winblend = 0,
  --     },
  --   },
  -- },

  -- add telescope-fzf-native
  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make",
  --     config = function()
  --       require("telescope").load_extension("fzf")
  --     end,
  --   },
  -- },

  -- starter dashboard
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        -- header = { " v ", " v  " },
        -- header = { " ", " ", " ", " ", " ", " ", "v" },
        --
        header = {
          "   ",
          "                              ",
          "                 ####         ",
          "                ###           ",
          "                ###           ",
          "           #### ###           ",
          "            ###  ##           ",
          "             ###  #           ",
          "              ##              ",
          "               ##             ",
          "                ##            ",
          "                              ",
        },

        -- header = { "   ", "   ", "   ", " -_- ", "   " },

        -- header = {
        --   "   ",
        --   "   ",
        --   -- ({ "[ ¬_¬ ]", "[ -_- ]", "◕ᴥ◕", "ツ", "ಠ_ಠ" })[math.random(5)],
        --   -- " ¬_¬        ",
        --   "   ",
        --   "     [ ¬_¬ ]          n[V]im "
        --     -- "    ¬_¬             n[v]im v"
        --     .. vim.version().major
        --     .. "."
        --     .. vim.version().minor
        --     .. "."
        --     .. vim.version().patch
        --     .. "    ",
        --   -- "nvim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
        --   -- "v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
        --   -- " "
        --   --   .. os.getenv("USER")
        --   --   .. "."
        --   --   .. os.getenv("HOST")
        --   --   .. " ",
        --   "   ",
        -- },

        center = {

          {

            desc = "[n]ew               ",
            keymap = "",
            key = "n",
            icon = "  ",
            action = "enew",
          },

          {

            desc = "[q]uit              ",
            keymap = "",
            key = "q",
            icon = "  ",
            action = "exit",
          },

          -- {
          --   desc = "[r]ecents           ",
          --   keymap = "",
          --   key = "r",
          --   icon = "  ",
          --   action = "Telescope oldfiles",
          -- },
          --
          --
          -- {
          --
          --   desc = "[q]uit              ",
          --   keymap = "",
          --   key = "q",
          --   icon = "  ",
          --   action = "exit",
          -- },

          -- {
          --   desc = "[f]ind file         ",
          --   keymap = "",
          --   key = "f",
          --   icon = "  ",
          --   action = "Telescope find_files",
          -- },

          -- {
          --   desc = "[u]pdate plugins    ",
          --   keymap = "",
          --   key = "u",
          --   icon = "  ",
          --   action = "Lazy update",
          -- },
          --
          -- {
          --   desc = "manag[e] extensions ",
          --   keymap = "",
          --   key = "e",
          --   icon = "  ",
          --   action = "Mason",
          -- },

          -- {
          --   desc = "[c]onfig    ",
          --   -- keymap = "",
          --   key = "c",
          --   icon = "  ",
          --   action = "Telescope find_files cwd=~/.config/nvim",
          -- },
        },

        -- center = {
        --   {
        --     desc = "Find File                     ",
        --     keymap = "",
        --     key = "f",
        --     icon = "  ",
        --     action = "Telescope find_files",
        --   },
        --
        --   {
        --     desc = "Browse Files",
        --     keymap = "",
        --     key = ".",
        --     icon = "  ",
        --     action = "Telescope file_browser",
        --   },
        --
        --   {
        --     desc = "New File",
        --     keymap = "",
        --     key = "n",
        --     icon = "  ",
        --     action = "enew",
        --   },
        --
        --   {
        --     desc = "Load Last Session",
        --     keymap = "",
        --     key = "L",
        --     icon = "  ",
        --     action = "SessionLoad",
        --   },
        --
        --   {
        --     desc = "Update Plugins",
        --     keymap = "",
        --     key = "u",
        --     icon = "  ",
        --     action = "Lazy update",
        --   },
        --
        --   {
        --     desc = "Manage Extensions",
        --     keymap = "",
        --     key = "e",
        --     icon = "  ",
        --     action = "Mason",
        --   },
        --
        --   {
        --     desc = "Config",
        --     keymap = "",
        --     key = "s",
        --     icon = "  ",
        --     action = "Telescope find_files cwd=~/.config/nvim",
        --   },
        --   {
        --     desc = "Exit",
        --     keymap = "",
        --     key = "q",
        --     icon = "  ",
        --     action = "exit",
        --   },
        -- },

        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "  " .. stats.loaded .. "/" .. stats.count .. " packages in " .. ms .. "ms" }
          -- return { stats.loaded .. "/" .. stats.count .. "packages         " .. ms .. " ms" }
        end,

        -- footer = function()
        --   return {
        --     "type  :help<Enter>  or  <F1>  for on-line help,  <F2>  news changelog",
        --     "Startup time: " .. require("lazy").stats().startuptime .. " ms",
        --   }
        -- end,
      },
    },
  },

  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = {
  --     logo = {
  --       "            :h-                                  Nhy`               ",
  --       "           -mh.                           h.    `Ndho               ",
  --       "           hmh+                          oNm.   oNdhh               ",
  --       "          `Nmhd`                        /NNmd  /NNhhd               ",
  --       "          -NNhhy                      `hMNmmm`+NNdhhh               ",
  --       "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
  --       "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
  --       "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
  --       "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
  --       " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
  --       " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
  --       " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
  --       " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
  --       "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
  --       "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
  --       "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
  --       "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
  --       "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
  --       "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
  --       "       //+++//++++++////+++///::--                 .::::-------::   ",
  --       "       :/++++///////////++++//////.                -:/:----::../-   ",
  --       "       -/++++//++///+//////////////               .::::---:::-.+`   ",
  --       "       `////////////////////////////:.            --::-----...-/    ",
  --       "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
  --       "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
  --       "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
  --       "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
  --       "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
  --       "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
  --       "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
  --       "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
  --       "                        .-:mNdhh:.......--::::-`                    ",
  --       "                           yNh/..------..`                          ",
  --       "                                                                    ",
  --       "N E O V I M - v ",
  --     },
  --     center = {
  --       {
  --         desc = "Find File                     ",
  --         keymap = "",
  --         key = "f",
  --         icon = "  ",
  --         action = "Telescope find_files",
  --       },
  --       {
  --         desc = "Recents",
  --         keymap = "",
  --         key = "r",
  --         icon = "  ",
  --         action = "Telescope oldfiles",
  --       },
  --
  --       {
  --         desc = "Browse Files",
  --         keymap = "",
  --         key = ".",
  --         icon = "  ",
  --         action = "Telescope file_browser",
  --       },
  --
  --       {
  --         desc = "New File",
  --         keymap = "",
  --         key = "n",
  --         icon = "  ",
  --         action = "enew",
  --       },
  --
  --       {
  --         desc = "Load Last Session",
  --         keymap = "",
  --         key = "L",
  --         icon = "  ",
  --         action = "SessionLoad",
  --       },
  --
  --       {
  --         desc = "Update Plugins",
  --         keymap = "",
  --         key = "u",
  --         icon = "  ",
  --         action = "Lazy update",
  --       },
  --
  --       {
  --         desc = "Manage Extensions",
  --         keymap = "",
  --         key = "e",
  --         icon = "  ",
  --         action = "Mason",
  --       },
  --
  --       {
  --         desc = "Config",
  --         keymap = "",
  --         key = "s",
  --         icon = "  ",
  --         action = "Telescope find_files cwd=~/.config/nvim",
  --       },
  --       {
  --         desc = "Exit",
  --         keymap = "",
  --         key = "q",
  --         icon = "  ",
  --         action = "exit",
  --       },
  --     },
  --     footer = function()
  --       return {
  --         "type  :help<Enter>  or  <F1>  for on-line help,  <F2>  news changelog",
  --         "Startup time: " .. require("lazy").stats().startuptime .. " ms",
  --       }
  --     end,
  --   },
  -- },

  --
  -- opts = function()
  --   local version = vim.version()
  --   local header = {
  --     "            :h-                                  Nhy`               ",
  --     "           -mh.                           h.    `Ndho               ",
  --     "           hmh+                          oNm.   oNdhh               ",
  --     "          `Nmhd`                        /NNmd  /NNhhd               ",
  --     "          -NNhhy                      `hMNmmm`+NNdhhh               ",
  --     "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
  --     "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
  --     "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
  --     "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
  --     " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
  --     " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
  --     " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
  --     " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
  --     "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
  --     "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
  --     "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
  --     "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
  --     "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
  --     "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
  --     "       //+++//++++++////+++///::--                 .::::-------::   ",
  --     "       :/++++///////////++++//////.                -:/:----::../-   ",
  --     "       -/++++//++///+//////////////               .::::---:::-.+`   ",
  --     "       `////////////////////////////:.            --::-----...-/    ",
  --     "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
  --     "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
  --     "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
  --     "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
  --     "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
  --     "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
  --     "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
  --     "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
  --     "                        .-:mNdhh:.......--::::-`                    ",
  --     "                           yNh/..------..`                          ",
  --     "                                                                    ",
  --     "N E O V I M - v " .. version.major .. "." .. version.minor,
  --     "",
  --   }

  -- local center = {
  --   {
  --     desc = "Find File                     ",
  --     keymap = "",
  --     key = "f",
  --     icon = "  ",
  --     action = "Telescope find_files",
  --   },
  --   {
  --     desc = "Recents",
  --     keymap = "",
  --     key = "r",
  --     icon = "  ",
  --     action = "Telescope oldfiles",
  --   },
  --
  --   {
  --     desc = "Browse Files",
  --     keymap = "",
  --     key = ".",
  --     icon = "  ",
  --     action = "Telescope file_browser",
  --   },
  --
  --   {
  --     desc = "New File",
  --     keymap = "",
  --     key = "n",
  --     icon = "  ",
  --     action = "enew",
  --   },
  --
  --   {
  --     desc = "Load Last Session",
  --     keymap = "",
  --     key = "L",
  --     icon = "  ",
  --     action = "SessionLoad",
  --   },
  --
  --   {
  --     desc = "Update Plugins",
  --     keymap = "",
  --     key = "u",
  --     icon = "  ",
  --     action = "Lazy update",
  --   },
  --
  --   {
  --     desc = "Manage Extensions",
  --     keymap = "",
  --     key = "e",
  --     icon = "  ",
  --     action = "Mason",
  --   },
  --
  --   {
  --     desc = "Config",
  --     keymap = "",
  --     key = "s",
  --     icon = "  ",
  --     action = "Telescope find_files cwd=~/.config/nvim",
  --   },
  --   {
  --     desc = "Exit",
  --     keymap = "",
  --     key = "q",
  --     icon = "  ",
  --     action = "exit",
  --   },
  -- }

  -- require("dashboard").setup({
  -- local opts = {
  --   config = {
  --     header = header,
  --     center = center,
  --   footer = function()
  --     return {
  --       "type  :help<Enter>  or  <F1>  for on-line help,  <F2>  news changelog",
  --       "Startup time: " .. require("lazy").stats().startuptime .. " ms",
  --     }
  --   end,
  -- },
  -- }
  -- }
  -- end,
  -- },

  {
    "rcarriga/nvim-notify",
    opts = {
      fps = 120,
      -- render = "compact",
      render = "minimal",
      -- timeout = 0,
      timeout = 30,
      -- stages = "fade",
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        format = {
          cmdline = { title = { "Vim" }, pattern = "^:", icon = ":", lang = "vim" },
          filter = { tile = { "Shell" }, pattern = "^:%s*!", icon = "!", lang = "bash" },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
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
