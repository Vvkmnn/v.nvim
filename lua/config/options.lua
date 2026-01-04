-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Testing: Immediate switch to window 3

-- Only specify options that differ from LazyVim defaults
vim.opt.shiftwidth = 4 -- Use 4 spaces instead of default 2
vim.opt.tabstop = 4 -- Display tabs as 4 spaces instead of default 2
vim.opt.wrap = true -- Enable line wrapping (LazyVim default is false)
-- vim.opt.scrolloff = 999 -- Moved to autocmds.lua for dynamic centering (better performance)
vim.opt.showtabline = 0 -- Never show tab line (LazyVim default is 1)
-- Clean fillchars for better diff display - no unwanted characters
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

-- Best-in-class diffopt (research: vimways.org, neovim docs, community best practices)
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

-- DISABLED: Diff colors now configured in TokyoNight theme (modify.lua)
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0d4a1a", fg = "#7fb069", bold = true })
--     vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#5c1f1f", fg = "#ff6b6b", bold = true })
--     vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1f3a5c", fg = "#74c0fc", bold = true })
--     vim.api.nvim_set_hl(0, "DiffText", { bg = "#5c3317", fg = "#ff8c00", bold = true })
--   end,
-- })

-- NOTE: All diff-related autocmds have been moved to lua/config/autocmds.lua
-- This file should only contain global options (vim.opt, vim.g, etc.)

-- Disable swapfiles - modern workflow with git + frequent saves makes them unnecessary
vim.opt.swapfile = false

-- Performance optimizations beyond LazyVim defaults
vim.opt.updatetime = 800 -- Good balance for gentle hover (was 50ms)
vim.opt.timeoutlen = 300 -- Faster than default 500ms
vim.opt.synmaxcol = 300 -- Limit syntax highlighting for performance

-- Search improvements - case-insensitive by default
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase

-- Auto-reload files when changed externally
vim.opt.autoread = true -- Automatically read files when changed outside

-- Disable concealing (show all markup characters like *, _, `, etc.)
vim.opt.conceallevel = 0 -- 0=show all, 1=hide one char, 2=hide or replace, 3=hide completely
vim.opt.concealcursor = "" -- Show concealed text when cursor is on the line

-- Configure which-key to use helix preset
vim.g.lazyvim_picker = "fzf"
if vim.g.which_key_presets then
  vim.g.which_key_presets = "helix"
end

-- ✨ LARGE FILE PERFORMANCE OPTIMIZATIONS (commented for easy testing):
--[[
-- Auto-optimize for large diffs
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("DiffPerformance", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(buf)
    
    if line_count > 1000 and vim.wo.diff then
      -- Large file optimizations for diff mode
      vim.opt_local.synmaxcol = 200        -- Further limit syntax highlighting
      vim.opt_local.foldmethod = "diff"    -- Use diff folding for large files
      vim.opt_local.lazyredraw = true      -- Delay redraws during diff operations
      vim.opt_local.regexpengine = 1       -- Use older, faster regex engine
    end
  end,
})
--]]

-- Shell file type associations for better LSP support
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

-- Enhanced diff keymaps (research-based best practices)
-- ]c and [c are built-in for diff navigation
vim.keymap.set("n", "<leader>gw", function()
  vim.cmd("windo diffthis")
end, { noremap = true, desc = "Git diff (w)indows" })

vim.keymap.set("n", "<leader>gd", function()
  vim.cmd("windo diffoff")
end, { noremap = true, desc = "Git diff off" })

-- Commented keymaps for reference (research findings):
-- ]c             -- Jump to the next diff (built-in)
-- [c             -- Jump to the previous diff (built-in)
-- do             -- diffget: obtain change from other file (built-in)
-- dp             -- diffput: put change to other file (built-in)
