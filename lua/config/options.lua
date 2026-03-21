--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                                                                        │
--  │                       ######                                           │
--  │                     ######                                             │
--  │                    #####                                               │
--  │                    #####                                               │
--  │                    #####                                               │
--  │            ######  #####                                               │
--  │          ######    #####         options.lua                           │
--  │        #######     #####         Vim options, loaded before lazy.nvim  │
--  │       ######        ####                                               │
--  │        ######        ###         defaults → lazyvim.config.options     │
--  │          #####        ##                                               │
--  │           #####        #                                               │
--  │            #####                                                       │
--  │             #####                                                      │
--  │              #####                                                     │
--  │               #####                                                    │
--  │                #####                                                   │
--  │                 #####                                                  │
--  │                                                                        │
--  ╰────────────────────────────────────────────────────────────────────────╯

-- global borders ----------------------------------------
vim.o.winborder = "rounded" -- Rounded borders on all float windows (hover, cmdline, completion)

-- indentation -------------------------------------------
vim.opt.shiftwidth = 4 -- Use 4 spaces instead of default 2
vim.opt.tabstop = 4 -- Display tabs as 4 spaces instead of default 2

-- display -----------------------------------------------
vim.opt.wrap = true -- Enable line wrapping (LazyVim default is false)
-- vim.opt.scrolloff = 999 -- Moved to autocmds.lua for dynamic centering (better performance)
vim.opt.showtabline = 0 -- Never show tab line (LazyVim default is 1)
vim.opt.fillchars = {
  vert = " ", -- Remove vertical separator completely
  horiz = " ", -- Remove horizontal separator completely
  horizup = " ", -- Remove horizontal up separator
  horizdown = " ", -- Remove horizontal down separator
  vertleft = " ", -- Remove vertical left separator
  vertright = " ", -- Remove vertical right separator
  verthoriz = " ", -- Remove vertical horizontal separator
  diff = " ", -- Remove diff deletion dashes/underscores
  fold = " ", -- Clean fold display
  eob = " ", -- Hide end-of-buffer tildes
  foldopen = " ", -- Remove fold open indicators
  foldclose = " ", -- Remove fold close indicators
  foldsep = " ", -- Remove fold separators
}
vim.opt.foldcolumn = "0" -- Remove fold column completely
vim.opt.list = false -- Disable visual tab/space indicators (removes > symbols)

-- diff --------------------------------------------------
vim.opt.diffopt = {
  "internal", -- Use internal xdiff library (same as git, faster)
  "filler", -- Show filler lines for alignment
  "closeoff", -- Turn off diff when window closes
  "hiddenoff", -- Don't diff hidden buffers
  "algorithm:patience", -- Best for code (handles moved blocks better than myers/histogram)
  "linematch:60", -- Smart line matching within hunks (max 60 lines)
  "indent-heuristic", -- Align diffs with code structure
  "vertical", -- Side-by-side view
  "context:3", -- Show 3 lines of context around changes
}

-- NOTE: diff colors configured in theme overrides (modify.lua)
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0d4a1a", fg = "#7fb069", bold = true })
--     vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#5c1f1f", fg = "#ff6b6b", bold = true })
--     vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1f3a5c", fg = "#74c0fc", bold = true })
--     vim.api.nvim_set_hl(0, "DiffText", { bg = "#5c3317", fg = "#ff8c00", bold = true })
--   end,
-- })

-- NOTE: all diff-related autocmds have been moved to lua/config/autocmds.lua

-- swap files --------------------------------------------
-- Primary crash protection (auto-save disabled, too aggressive)
-- Stored in ~/.local/share/nvim/swap/ (XDG default), never in project dirs
-- SwapExists autocmd in autocmds.lua auto-recovers unsaved changes silently
vim.opt.swapfile = true

-- performance -------------------------------------------
vim.opt.updatetime = 800 -- Good balance for gentle hover (was 50ms)
vim.opt.timeoutlen = 300 -- Faster than default 500ms
vim.opt.synmaxcol = 300 -- Limit syntax highlighting for performance

-- PERF: large diff performance (disabled, uncomment to enable)
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("DiffPerformance", { clear = true }),
--   callback = function()
--     local buf = vim.api.nvim_get_current_buf()
--     local line_count = vim.api.nvim_buf_line_count(buf)
--     if line_count > 1000 and vim.wo.diff then
--       vim.opt_local.synmaxcol = 200        -- Further limit syntax highlighting
--       vim.opt_local.foldmethod = "diff"    -- Use diff folding for large files
--       vim.opt_local.lazyredraw = true      -- Delay redraws during diff operations
--       vim.opt_local.regexpengine = 1       -- Use older, faster regex engine
--     end
--   end,
-- })

-- search ------------------------------------------------
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase

-- file behavior -----------------------------------------
vim.opt.autoread = true -- Automatically read files when changed outside

-- concealing --------------------------------------------
vim.opt.conceallevel = 0 -- 0=show all, 1=hide one char, 2=hide or replace, 3=hide completely
vim.opt.concealcursor = "" -- Show concealed text when cursor is on the line

-- picker and which-key ----------------------------------
vim.g.lazyvim_picker = "fzf" -- Use fzf-lua instead of telescope (faster, native fzf)
vim.g.which_key_presets = "helix" -- Helix-style key hints in which-key popup

-- providers ---------------------------------------------
-- NOTE: no modern neovim plugins use perl or ruby providers (vim legacy)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- filetypes ---------------------------------------------
vim.filetype.add({
  extension = {
    zsh = "sh",
    sh = "sh",
  },
  filename = {
    [".zshrc"] = "sh",
    [".zshenv"] = "sh",
    [".rc"] = "sh",
    [".profile"] = "sh",
    [".shell"] = "sh",
    [".alias"] = "sh",
    [".functions"] = "sh",
  },
})
