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
  -- {
  --   "echasnovski/mini.animate",
  --   opts = {
  --
  --     cursor = {
  --       timing = require("mini.animate").gen_timing.linear({ duration = 7, unit = "total" }),
  --     },
  --     scroll = {
  --       timing = require("mini.animate").gen_timing.linear({ duration = 13, unit = "total" }),
  --     },
  --   },
  -- },
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

  -- indentscope animation - DISABLED
  -- {
  --   "echasnovski/mini.indentscope",
  --   opts = {
  --     -- symbol = "▏",
  --     symbol = " ▏",
  --     -- symbol = " ▏ ",
  --     -- draw = { delay =  },
  --     -- symbol = " |",
  --     options = {
  --       -- Type of scope's border: which line(s) with smaller indent to
  --       -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
  --       border = "both",
  --
  --       -- Whether to use cursor column when computing reference indent.
  --       -- Useful to see incremental scopes with horizontal cursor movements.
  --       -- indent_at_cursor = false,
  --
  --       -- Whether to first check input line to be a border of adjacent scope.
  --       -- Use it if you want to place cursor on function header to get scope of
  --       -- its body.
  --       try_as_border = true,
  --     },
  --
  --     -- symbol = "╎",
  --   },
  -- },

  -- Kanagawa theme configuration moved to theme.lua for better organization

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

  -- AI:
  -- AI
  -- NOTE:
  -- TODO:
  -- AI:
  -- CLAUDE:
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {

      keywords = {
        AI = {
          icon = "󰚩", -- icon used for the sign, and in search results
          color = "hint", -- can be a hex color, or a named color (see below)
          alt = { "CLAUDE", "GEMINI", "CHATGPT" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
      },
    },
  },

  -- NOTE: Enhanced LSP configuration for better development experience
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} }, -- LSP progress indicators
    },
    opts = {
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },

      servers = {
        -- AI: Disable deprecated servers for better performance
        ruff_lsp = false, -- Use ruff instead

        -- NOTE: TypeScript with enhanced inlay hints
        tsserver = {
          root_dir = function()
            return vim.fn.getcwd() -- Use current working directory
          end,
          single_file_support = true, -- Support single TypeScript files
          settings = {
            completions = {
              completeFunctionCalls = true, -- Complete function calls with parentheses
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", -- Show parameter names
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true, -- Show parameter types
                includeInlayVariableTypeHints = true, -- Show variable types
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true, -- Show return types
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        -- AI: Modern Python linting with Ruff
        ruff = {
          cmd = { "ruff-lsp" }, -- Use ruff-lsp for fast Python linting
          filetypes = { "python" },
          init_options = {
            settings = {
              args = {}, -- Add custom ruff arguments here
            },
          },
        },

        -- NOTE: Enhanced TailwindCSS support for modern web development
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte",
            "vue",
          },
          init_options = {
            userLanguages = {
              html = "html",
              css = "css",
              scss = "css",
              javascript = "javascript",
              typescript = "typescript",
              svelte = "svelte",
              vue = "vue",
            },
          },
        },
      },
      -- AI: Enhanced LSP keymaps and functionality
      on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable LSP completion

        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        -- NOTE: Essential LSP navigation keymaps
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- Go to declaration
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to definition
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Show hover info
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- Go to implementation
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- Show signature
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- Show references

        -- AI: Workspace and refactoring operations
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts) -- Rename symbol
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts) -- Code actions
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts) -- Format code

        -- NOTE: TypeScript specific enhancements
        if client.name == "tsserver" or client.name == "ts_ls" then
          vim.keymap.set("n", "<leader>co", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.organizeImports.ts" } }, -- Organize imports
            })
          end, bufopts)
        end
      end,
    },
  },

  -- AI: Enhanced completion with emoji support
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" }) -- Add emoji completion source
    end,
  },

  -- ============================================================================
  -- THEME CONFIGURATION - Let LazyVim handle tokyonight defaults
  -- ============================================================================

  -- Commented out custom theme configs - LazyVim handles tokyonight by default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- Complete transparency configuration
        hl.Normal = { bg = "none" }
        hl.NormalFloat = { bg = "none" }
        
        -- Telescope transparency
        hl.TelescopeNormal = { bg = "none" }
        hl.TelescopeBorder = { bg = "none" }
        hl.TelescopePromptNormal = { bg = "none" }
        hl.TelescopeResultsNormal = { bg = "none" }
        hl.TelescopePreviewNormal = { bg = "none" }
        
        -- File tree transparency
        hl.NeoTreeNormal = { bg = "none" }
        hl.NeoTreeNormalNC = { bg = "none" }
        
        -- Keep important UI elements visible
        hl.Pmenu = { bg = c.bg_popup }
        hl.PmenuSel = { bg = c.bg_highlight }
      end,
    },
  },

  -- Snacks.nvim - minimal configuration to avoid conflicts
  {
    "folke/snacks.nvim",
    opts = {
      -- Keep only essential modules enabled
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      words = { enabled = true },

      -- Disable potentially conflicting modules
      dashboard = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      scope = { enabled = false },
      indent = { enabled = false },
      explorer = { enabled = false },
      image = { enabled = false },
      picker = { enabled = false },
      statuscolumn = { enabled = false },
      lazygit = { enabled = false },
    },
  },

  -- Theme section cleaned - LazyVim handles tokyonight defaults automatically

  -- ============================================================================
  -- END THEME CONFIGURATION
  -- ============================================================================

  -- Removed duplicate LazyVim config - colorscheme set above
  -- UI configuration moved to theme.lua

  -- Native character-level diff is configured in options.lua with diffopt

  -- Neo-tree sidebar for ClaudeCodeTreeAdd - minimal config (DISABLED), oil.nvim remains default
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true, -- Close if it's the last window
      popup_border_style = "rounded",
      filesystem = {
        hijack_netrw_behavior = "disabled", -- Keep oil.nvim as default
        follow_current_file = { enabled = true },
        group_empty_dirs = true, -- Cleaner view
      },
      window = {
        width = 21,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          with_markers = false, -- Remove indent markers
        },
      },
      -- Remove all borders and separators for seamless look
      popup_border_style = "none",
      use_default_mappings = false,
      window_border_style = "none",
    },
  },

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
    "lualine.nvim",
    opts = function()
      return {
        sections = {
          lualine_y = {},
          lualine_z = {
            { require("recorder").recordingStatus },
          },
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
