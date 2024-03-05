return {
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
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        -- header = { " v ", " v  " },
        -- header = { " ", " ", " ", " ", " ", " ", "v" },

        header = {
          "   ",
          "   ",
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
          "                              ",
          "   ",
        },

        center = {

          {
            desc = "[f]ind file         ",
            keymap = "",
            key = "f",
            icon = "  ",
            action = "Telescope find_files",
          },

          {

            desc = "[n]ew file          ",
            keymap = "",
            key = "n",
            icon = "  ",
            action = "enew",
          },

          {
            desc = "[u]pdate plugins    ",
            keymap = "",
            key = "u",
            icon = "  ",
            action = "Lazy update",
          },

          -- {
          --   desc = "manag[e] extensions ",
          --   keymap = "",
          --   key = "e",
          --   icon = "  ",
          --   action = "Mason",
          -- },

          {
            desc = "[c]onfig    ",
            keymap = "",
            key = "c",
            icon = "  ",
            action = "Telescope find_files cwd=~/.config/nvim",
          },
          {

            desc = "[q]uit              ",
            keymap = "",
            key = "q",
            icon = "  ",
            action = "exit",
          },
        },

        -- center = {
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
        -- },

        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "" .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
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
      timeout = 0,
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
