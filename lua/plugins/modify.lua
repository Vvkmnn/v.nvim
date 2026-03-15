--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                                                                        │
--  │                       ######                                           │
--  │                     ######                                             │
--  │                    #####                                               │
--  │                    #####                                               │
--  │                    #####                                               │
--  │            ######  #####                                               │
--  │          ######    #####         modify.lua                            │
--  │        #######     #####         Override LazyVim plugin defaults       │
--  │       ######        ####                                               │
--  │        ######        ###         new plugins → custom.lua              │
--  │          #####        ##         disabled    → disable.lua             │
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
  -- nvim-notify: persistent error logging and enhanced notifications
  -- NOTE: disabled, using snacks.notifier instead
  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     timeout = false, -- Never auto-dismiss notifications
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --     stages = "static", -- No animations, keep them visible
  --     render = "compact",
  --     background_colour = "#000000", -- Use hex color instead of highlight group
  --     fps = 30,
  --     level = 2,
  --     minimum_width = 50,
  --     icons = {
  --       ERROR = "",
  --       WARN = "",
  --       INFO = "",
  --       DEBUG = "",
  --       TRACE = "✎",
  --     },
  --   },
  --   config = function(_, opts)
  --     local notify = require("notify")
  --     notify.setup(opts)
  --     vim.notify = notify
  --
  --     -- Create persistent error buffer for startup issues
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       callback = function()
  --         local error_buf = vim.api.nvim_create_buf(false, true)
  --         vim.api.nvim_buf_set_name(error_buf, "Startup Errors")
  --         vim.api.nvim_buf_set_option(error_buf, "buftype", "nofile")
  --         vim.api.nvim_buf_set_option(error_buf, "swapfile", false)
  --         vim.api.nvim_buf_set_option(error_buf, "modifiable", false)
  --
  --         -- Store error buffer globally for error logging
  --         vim.g.startup_error_buf = error_buf
  --       end,
  --     })
  --   end,
  --   keys = {
  --     {
  --       "<leader>nd",
  --       function()
  --         require("notify").dismiss({ silent = true, pending = true })
  --       end,
  --       desc = "Dismiss notifications",
  --     },
  --     { "<leader>nh", ":Notifications<cr>", desc = "Show notification history" },
  --     {
  --       "<leader>ne",
  --       function()
  --         if vim.g.startup_error_buf then
  --           vim.cmd("split | buffer " .. vim.g.startup_error_buf)
  --         end
  --       end,
  --       desc = "Show startup errors",
  --     },
  --   },
  -- },

  -- conform.nvim: old formatter config
  -- NOTE: disabled, replaced by active conform block in lazyvim extras section below
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

  -- mini.animate: cursor and scroll animations
  -- NOTE: disabled, smear-cursor.nvim replaces cursor animation
  -- {
  --   "nvim-mini/mini.animate",
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

  -- mini.indentscope: animated indent scope lines
  -- NOTE: disabled, snacks.nvim indent + scope replaces it
  -- {
  --   "nvim-mini/mini.indentscope",
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

  -- mini.starter: custom dashboard
  -- NOTE: disabled, using LazyVim default dashboard
  -- {
  --   "nvim-mini/mini.starter",
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

  -- todo-comments.nvim: highlight and search TODO/FIXME/HACK/AI comments (:TodoTrouble, <leader>st)
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

  -- WARN: Mason v2 race condition (LazyVim #6039), if you add a new LSP server to the
  -- servers table below, run :MasonInstall <server> BEFORE restarting nvim. The race occurs
  -- when mason-lspconfig and LazyVim's ensure_installed both try to install the same
  -- uninstalled package simultaneously. Pre-installing avoids the assert crash.

  -- nvim-lspconfig: LSP server configs for lua_ls, ruff, ts_ls, tailwindcss, harper (auto on file open)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} }, -- LSP progress indicators
    },
    opts = {
      -- NOTE: configure diagnostics (LazyVim standard approach)
      diagnostics = {
        virtual_text = false, -- Completely disable inline diagnostic text
        signs = {
          text = {
            -- NOTE: originals were ❌ ⚠️ 💡 ℹ️ (emoji versions)
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.HINT] = "󰌶",
            [vim.diagnostic.severity.INFO] = "󰋽",
          },
        },
        underline = false, -- Disable underlines
        update_in_insert = false, -- Don't update during insert mode
        severity_sort = true, -- Sort by severity
        float = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "never", -- Hide the "Diagnostics:" header
          prefix = "", -- Remove prefix spacing
          scope = "cursor", -- Only show diagnostics for current cursor position
          header = "", -- Remove header
        },
      },
      -- NOTE: builtin LSP inlay hints (requires server support)
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- NOTE: LSP code lenses (actionable annotations above functions: references, run test, etc.)
      codelens = {
        enabled = true,
      },

      servers = {
        -- NOTE: lua_ls optimized for Neovim development
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  "${3rd}/luv/library",
                  "${3rd}/busted/library",
                },
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim", "Snacks", "LazyVim" },
              },
              hint = {
                enable = true,
                setType = true,
                paramType = true,
                arrayIndex = "Disable",
              },
            },
          },
        },

        -- NOTE: ruff, modern fast replacement for pylint/flake8
        ruff = {
          cmd = { "ruff", "server" },
          filetypes = { "python" },
          single_file_support = true,
          init_options = {
            settings = {
              lineLength = 100,
              lint = { select = { "E", "F", "W", "I", "UP", "B", "SIM" } },
            },
          },
        },

        -- NOTE: ts_ls with enhanced inlay hints
        ts_ls = {
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

        -- NOTE: tailwindcss for modern web development
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

        -- NOTE: harper-ls replaces ltex (~5MB Rust vs ~200MB Java), fixes Mason v2 install race
        harper_ls = {
          filetypes = { "markdown", "tex", "latex", "plaintex", "gitcommit" },
          settings = {
            ["harper-ls"] = {
              dialect = "Australian",
            },
          },
        },
      },

      -- NOTE: handlers table and vim.lsp.with() deprecated in Neovim 0.11
      --       replaced by vim.o.winborder = "rounded" in options.lua (global float borders)
      -- handlers = {
      --   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --     border = "rounded",
      --     max_width = math.floor(vim.o.columns * 0.6),
      --     max_height = math.floor(vim.o.lines * 0.4),
      --     focusable = false,
      --     close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
      --   }),
      -- },

      -- NOTE: on_attach is silently ignored by LazyVim (uses vim.lsp.config() internally)
      --       all keymaps below are now provided natively by Neovim 0.11:
      --       gd, gD, gi, gr, K, KK (focus hover), grn, gra, grr
      --       <leader>ca, <leader>cr, <leader>cf provided by LazyVim
      --       <C-k> signature help conflicted with window navigation
      -- on_attach = function(client, bufnr)
      --   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      --   local bufopts = { noremap = true, silent = true, buffer = bufnr }
      --   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      --   vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      --   vim.keymap.set("n", "K", function()
      --     local winid = nil
      --     for _, win in ipairs(vim.api.nvim_list_wins()) do
      --       local config = vim.api.nvim_win_get_config(win)
      --       if config.relative ~= "" then winid = win; break end
      --     end
      --     if winid then vim.api.nvim_set_current_win(winid)
      --     else vim.lsp.buf.hover() end
      --   end, bufopts)
      --   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      --   vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
      --   vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      --   vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
      --   vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
      --   vim.keymap.set("n", "<space>wl", function()
      --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --   end, bufopts)
      --   vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      --   vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
      --   vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
      --   vim.keymap.set("n", "<space>f", function()
      --     vim.lsp.buf.format({ async = true })
      --   end, bufopts)
      --   if client.name == "tsserver" or client.name == "ts_ls" then
      --     vim.keymap.set("n", "<leader>co", function()
      --       vim.lsp.buf.code_action({
      --         apply = true,
      --         context = { only = { "source.organizeImports.ts" } },
      --       })
      --     end, bufopts)
      --   end
      -- end,
    },
  },

  -- blink.cmp: completion engine with super-tab behavior (<Tab> to accept/navigate)
  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = "super-tab" }, -- <Tab> smart accept/navigate
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
      },
    },
  },

  -- fzf-lua: fuzzy finder with glob patterns and resume (auto, extends LazyVim fzf)
  {
    "ibhagwan/fzf-lua",
    opts = {
      grep = {
        rg_glob = true, -- Enable *.js patterns
        resume = true, -- Resume searches
      },
      files = {
        resume = true, -- Resume file searches
      },
    },
  },

  -- vimtex: LaTeX editing with concealing disabled (auto on .tex files)
  {
    "lervag/vimtex",
    opts = function()
      vim.g.vimtex_syntax_conceal_disable = 1 -- Disable all VimTeX concealing
    end,
  },

  -- theme ------------------------------------------------

  -- LazyVim: base config, set tokyonight as default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- tokyonight.nvim: theme with transparency, custom diff and cursor colors
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
        floats = "transparent", -- consistent with editor, borders provide visual separation
      },
      on_highlights = function(hl, c)
        -- NOTE: full transparency (terminal bg shows through everywhere)
        hl.Normal = { bg = "none" }
        hl.NormalFloat = { bg = "none" }
        -- NOTE: visible border color on transparent floats
        hl.FloatBorder = { fg = c.border_highlight, bg = "none" }
        hl.FloatTitle = { fg = c.border_highlight, bg = "none" }

        -- NOTE: orange cursorline customization matching line numbers
        hl.CursorLine = {
          bg = "#2A1F0A", -- Dark version of e0af68
          blend = 20,
        }
        hl.CursorLineNr = {
          fg = "#e0af68", -- Tokyo Night yellow-orange (matches line numbers)
          bold = true,
        }

        -- NOTE: telescope transparency
        hl.TelescopeNormal = { bg = "none" }
        hl.TelescopeBorder = { bg = "none" }
        hl.TelescopePromptNormal = { bg = "none" }
        hl.TelescopeResultsNormal = { bg = "none" }
        hl.TelescopePreviewNormal = { bg = "none" }

        -- NOTE: incline.nvim floating labels (raised surface on transparent bg)
        hl.InclineNormal = { bg = c.bg_highlight, fg = c.fg }
        hl.InclineNormalNC = { bg = c.bg_highlight, fg = c.dark5 }

        -- NOTE: file tree transparency
        hl.NeoTreeNormal = { bg = "none" }
        hl.NeoTreeNormalNC = { bg = "none" }

        -- NOTE: keep important UI elements visible
        hl.Pmenu = { bg = c.bg_popup }
        hl.PmenuSel = { bg = c.bg_highlight }

        -- NOTE: diff colors derived from TokyoNight palette (2025-01-07)
        --       syntax highlighting stays full color (no dimming via winhighlight)
        --       DiffDimmed* groups removed (winhighlight disabled in autocmds.lua)

        -- NOTE: added lines, soft forest green (derived from theme green #9ece6a)
        hl.DiffAdd = { bg = "#1e2e1a" }

        -- NOTE: deleted lines, soft burgundy rose (derived from theme red #f7768e)
        hl.DiffDelete = { bg = "#2e1a1e" }

        -- NOTE: changed lines, warm amber glow (derived from theme yellow #e0af68)
        hl.DiffChange = { bg = "#2e2618" }

        -- NOTE: word-level changes, theme yellow text
        hl.DiffText = { bg = "#3d3520", fg = "#e0af68" }
      end,
    },
  },

  -- snacks.nvim: swiss-army-knife utilities (auto, merged from modify.lua + custom.lua)
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      words = { enabled = true },
      notifier = { enabled = true },
      input = { enabled = true },
      dim = { enabled = true },
      zen = { enabled = true },
      gitbrowse = { enabled = true },
      scratch = { enabled = true },
      indent = { enabled = true },
      scope = { enabled = true },
      -- NOTE: disabled (using alternatives or not needed)
      dashboard = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      explorer = { enabled = false },
      image = { enabled = false },
      picker = { enabled = false },
      statuscolumn = { enabled = false },
      lazygit = { enabled = false },
    },
  },

  -- neo-tree.nvim: sidebar file explorer for ClaudeCodeTreeAdd (auto, oil.nvim is primary)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true, -- Close if it's the last window
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
      -- NOTE: remove all borders and separators for seamless look
      popup_border_style = "none",
      use_default_mappings = false,
      window_border_style = "none",
    },
  },

  -- nvim-notify: notification renderer (auto)
  -- NOTE: disabled, snacks.notifier replaces it (enabled in snacks block above)
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },

  -- noice.nvim: enhanced command line UI with icons for vim/shell/search (auto)
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        format = {
          cmdline = { title = { "Vim" }, pattern = "^:", icon = ":", lang = "vim" },
          filter = { title = { "Shell" }, pattern = "^:%s*!", icon = "!", lang = "bash" },
        },
      },
      -- NOTE: override noice default borders to match winborder = "rounded"
      views = {
        cmdline_popup = { border = { style = "rounded", padding = { 0, 1 } } },
        cmdline_input = { border = { style = "rounded", padding = { 0, 1 } } },
        hover = { border = { style = "rounded", padding = { 0, 2 } } },
        popup = { border = { style = "rounded" } },
      },
      -- NOTE: adds rounded borders to LSP hover docs and signature help
      presets = { lsp_doc_border = true },
    },
  },

  -- lualine.nvim: statusline with smart path, code context, and recorder (auto)
  -- NOTE: navic code context added to lualine_c by lazyvim editor.navic extra
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}

      -- smart path: shows tilde-relative path (~/.config/nvim/...), truncates on narrow windows
      local function smart_path()
        local path = vim.fn.expand("%:~")
        if path == "" then
          return "[No Name]"
        end
        local win_width = vim.api.nvim_win_get_width(0)
        local max_len = math.max(20, math.floor(win_width * 0.4))
        if #path <= max_len then
          return path
        end
        local parts = vim.split(path, "/")
        if #parts <= 1 then
          return path
        end
        -- try: first/…/parent/file
        if #parts >= 4 then
          local try = parts[1] .. "/…/" .. parts[#parts - 1] .. "/" .. parts[#parts]
          if #try <= max_len then
            return try
          end
        end
        -- try: …/parent/file
        if #parts >= 3 then
          local try = "…/" .. parts[#parts - 1] .. "/" .. parts[#parts]
          if #try <= max_len then
            return try
          end
        end
        -- fallback: …/file
        return "…/" .. parts[#parts]
      end

      -- replace LazyVim's pretty_path (4th component in lualine_c) with smart_path
      -- move filetype icon from lualine_c into lualine_b (gets its own chevron section)
      if opts.sections.lualine_c then
        if opts.sections.lualine_c[4] then
          opts.sections.lualine_c[4] = {
            smart_path,
            color = function()
              if vim.bo.modified then
                return { fg = Snacks.util.color("MatchParen"), gui = "italic,bold" }
              end
            end,
          }
        end
        table.remove(opts.sections.lualine_c, 3)
      end
      opts.sections.lualine_b = opts.sections.lualine_b or {}
      table.insert(opts.sections.lualine_b, { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } })

      opts.sections.lualine_y = {}
      opts.sections.lualine_z = {
        {
          function()
            return require("recorder").recordingStatus()
          end,
        },
      }
    end,
  },

  -- bufferline.nvim: tab bar
  -- NOTE: disabled, using showtabline=0 instead
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  -- yanky.nvim: clipboard history ring (<C-p> prev, <C-n> next after paste)
  {
    "gbprod/yanky.nvim",
    keys = {
      -- NOTE: C-p/n to get kill-ring like emacs
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Yanky Previous Entry" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Yanky Next Entry" },
    },
  },

  -- render-markdown.nvim: markdown table/heading rendering (auto on markdown files)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      pipe_table = {
        preset = "round", -- Rounded corners (╭╮╰╯)
        cell = "raw", -- Only replace pipes; avoids concealed text width bugs
        style = "full", -- Top + bottom borders
        padding = 2, -- More breathing room
        min_width = 0,
        border_virtual = true, -- Use virtual lines for borders (avoids empty line issues)
      },
      anti_conceal = { enabled = true }, -- Show raw syntax on cursor line
    },
  },

  -- gitsigns.nvim: custom hunk navigation
  -- NOTE: disabled, depended on treesitter textobjects, ]c/[c now freed for native diff
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = { "LazyFile", "VeryLazy" },
  --   keys = {
  --     { "]c", ":Gitsigns next_hunk<CR>", desc = "Next Hunk" },
  --     { "[c", ":Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
  --   },
  -- },

  -- mini.diff: override for claudecode unified inline diff
  -- NOTE: disabled, buffer modification before accept causes artifacts (see autocmds.lua)
  -- {
  --   "echasnovski/mini.diff",
  --   opts = function()
  --     return {
  --       source = require("mini.diff").gen_source.none(),
  --     }
  --   end,
  -- },

  -- lazyvim extras ----------------------------------------
  -- NOTE: extras imports (treesitter-context, inc-rename, dap.core, test.core) are in lazy.lua
  -- to satisfy LazyVim's required load order: lazyvim.plugins -> extras -> user plugins

  -- conform.nvim: auto-format on save with stylua, shfmt, prettier
  -- NOTE: formatters installed via Mason
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },

  -- persistence.nvim: LazyVim default session manager
  -- NOTE: disabled, using persisted.nvim in custom.lua instead (has git branch awareness)
  { "folke/persistence.nvim", enabled = false },

  -- hawtkeys.nvim: one-time keymap audit tool (:Hawtkeys, :HawtkeysDupes)
  {
    "tris203/hawtkeys.nvim",
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
    opts = {},
  },
}
