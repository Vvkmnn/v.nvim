-- Theme configuration
-- This file contains all theme-related settings in one place
return {
  -- Kanagawa theme (primary colorscheme)
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = true, -- Enable for better performance
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Make line numbers and cursor line match
          LineNr = { bg = "none" },
          CursorLineNr = { fg = theme.syn.fun, bg = "none", bold = true },
          SignColumn = { bg = "none" },
          -- CursorLine = { bg = "none", fg = theme.syn.fun }, -- Match cursor line color to line number

          -- Make float windows consistent
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Telescope transparency
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none" },
          TelescopeTitle = { bg = "none" },

          -- Better diff highlighting for character-level changes
          DiffAdd = { bg = theme.diff.add, fg = "none" },
          DiffChange = { bg = theme.diff.change, fg = "none" },
          DiffDelete = { bg = theme.diff.delete, fg = "none" },
          DiffText = { bg = theme.diff.text, fg = "none", bold = true },

          -- Dashboard/Snacks transparency
          SnacksNotifierInfo = { bg = "none" },
          SnacksNotifierWarn = { bg = "none" },
          SnacksNotifierError = { bg = "none" },
          SnacksNotifierDebug = { bg = "none" },
          SnacksNotifierTrace = { bg = "none" },
        }
      end,
      theme = "wave",
      -- background = {
      --   dark = "wave",
      --   light = "lotus",
      -- },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },

  -- Configure LazyVim to use Kanagawa
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },

  -- Custom dashboard configuration
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[

               #######   
             #########   
            ########     
            ######       
            ######       
    ####### ######       
  ######### ######       
  #######   ######       
   ######    #####       
    ######    ####       
     ######    ###       
      ######    #        
       ######            
        #####            
         #####           
          #####          
           #####         
            #####       

                    ]],

          -- [[
          --
          --                ####
          --               ###
          --               ###
          --          #### ###
          --           ###  ##
          --            ###  #
          --             ##
          --              ##
          --               ##
          --
          --         ]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      -- Disable nested indent scope lines - keep only current level
      scope = { enabled = false },
      indent = {
        enabled = true,
        scope = { enabled = false }, -- Disable scope highlighting
      },
    },
  },

  -- TokyoNight theme (backup - commented out)
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = {
  --     style = "night",
  --     transparent = false,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
}
