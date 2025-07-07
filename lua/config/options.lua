-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Only specify options that differ from LazyVim defaults
vim.opt.shiftwidth = 4 -- Use 4 spaces instead of default 2
vim.opt.tabstop = 4 -- Display tabs as 4 spaces instead of default 2
vim.opt.wrap = true -- Enable line wrapping (LazyVim default is false)
vim.opt.scrolloff = 111 -- 111 for middle screen
vim.opt.showtabline = 0 -- Never show tab line (LazyVim default is 1)
-- Clean fillchars for better diff display - no unwanted characters
vim.opt.fillchars = {
  vert = " ", -- Remove vertical separator completely
  diff = " ", -- Remove diff deletion dashes/underscores
  fold = " ", -- Clean fold display
  eob = " ", -- Hide end-of-buffer tildes
  foldopen = " ", -- Remove fold open indicators
  foldclose = " ", -- Remove fold close indicators
  foldsep = " ", -- Remove fold separators
}
vim.opt.foldcolumn = "0" -- Remove fold column completely

-- Optimized diffthis configuration for claudecode.nvim
vim.opt.diffopt = {
  "internal", -- Use internal diff library (faster, more reliable)
  "filler", -- Show filler lines to keep text aligned
  "closeoff", -- Close folds in other windows when starting diff
  "hiddenoff", -- Don't use diff mode for hidden buffers
  -- "algorithm:patience",   -- Better diff algorithm for code (vs default myers)
  "linematch:60", -- Enhanced line matching within diff hunks
  "iwhite", -- Ignore whitespace changes
  "vertical", -- Default to vertical splits for diffs
  "followwrap", -- Follow the wrap setting from diffopt
  "indent-heuristic", -- Better alignment for indented code
  "context:3", -- Show 3 lines of context (enables vim's built-in diff folding)

  -- ✨ RESEARCH-BASED ENHANCEMENTS (commented for easy testing):
  "algorithm:histogram", -- Alternative to patience, often faster for large files
  -- "inline:char", -- Character-level inline highlighting (Neovim 0.11+)
}

-- Enhanced diff colors for better readability (based on vimdiff best practices)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- High contrast diff colors for maximum readability
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0d4a1a", fg = "#7fb069", bold = true }) -- Bright green addition
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#5c1f1f", fg = "#ff6b6b", bold = true }) -- Bright red deletion
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1f3a5c", fg = "#74c0fc", bold = true }) -- Bright blue change

    -- Enhanced DiffText with bright orange for maximum visibility of exact changes
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#5c3317", fg = "#ff8c00", bold = true }) -- Bright orange highlight

    -- ✨ ADDITIONAL VISUAL ENHANCEMENTS (commented for easy testing):
    --[[
    -- Enhanced fold styling for clean diff view
    vim.api.nvim_set_hl(0, "Folded", { 
      bg = "NONE", 
      fg = "#7c6f64", 
      italic = true 
    })
    
    -- Better cursor line in diff mode
    vim.api.nvim_set_hl(0, "CursorLine", { 
      bg = "#2a2a2a", 
      blend = 20 
    })
    
    -- Clean line number styling for diff
    vim.api.nvim_set_hl(0, "LineNr", { 
      fg = "#7c6f64" 
    })
    vim.api.nvim_set_hl(0, "CursorLineNr", { 
      fg = "#fabd2f", 
      bold = true 
    })
    --]]
  end,
})

-- Enhanced diff window configuration with perfect scroll matching
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("DiffOptimization", { clear = true }),
  callback = function()
    if vim.wo.diff then
      -- Perfect scroll and cursor synchronization
      vim.wo.scrollbind = true -- Sync scrolling between diff windows
      vim.wo.cursorbind = true -- Sync cursor position across windows
      vim.wo.wrap = false -- Disable wrapping for clean line alignment
      vim.wo.scrollopt = "ver,jump,hor" -- Enhanced scroll options

      -- Visual enhancements for clean diff view
      vim.wo.number = true -- Show line numbers for navigation
      vim.wo.relativenumber = false -- Absolute numbers better for diffs
      vim.wo.cursorline = true -- Highlight current line
      vim.wo.foldcolumn = "0" -- Remove fold column
      vim.wo.signcolumn = "no" -- Remove sign column for clean view

      -- Equal window sizing for 2-window diffs
      vim.schedule(function()
        if vim.fn.winnr("$") == 2 then
          vim.cmd("wincmd =")
          -- Perfect equal sizing for line alignment
          vim.cmd("vertical resize")
        end
      end)

      -- ✨ ENHANCED WINDOW MANAGEMENT (commented for easy testing):
      --[[
      -- Perfect window distribution for multiple diff windows
      vim.schedule(function()
        local win_count = vim.fn.winnr("$")
        if win_count >= 2 then
          vim.cmd("wincmd =") -- Equal sizing first
          
          -- Optimize for 2-window diff layout
          if win_count == 2 then
            vim.cmd("vertical resize 50%")
          end
          
          -- Ensure consistent line heights
          for i = 1, win_count do
            vim.fn.win_execute(vim.fn.win_getid(i), "normal! zt")
          end
        end
      end)
      --]]
    end
  end,
})

-- Clean exit from diff mode
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = vim.api.nvim_create_augroup("ClaudeCodeDiffCleanup", { clear = true }),
  callback = function()
    if vim.wo.diff then
      -- Clean up when leaving diff mode
      vim.wo.scrollbind = false
      vim.wo.cursorbind = false
      vim.wo.wrap = false -- Restore original wrap setting
    end
  end,
})

-- Perfect scroll synchronization with multiple triggers
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  group = vim.api.nvim_create_augroup("DiffScrollSync", { clear = true }),
  callback = function()
    if vim.wo.diff and vim.wo.scrollbind then
      vim.cmd("syncbind")
    end
  end,
})

-- ✨ ADVANCED DIFF AUTOCMDS (commented for easy testing):
--[[
-- Mouse wheel fix for diff mode
vim.api.nvim_create_autocmd("WheelPre", {
  group = vim.api.nvim_create_augroup("DiffMouseFix", { clear = true }),
  callback = function()
    if vim.wo.diff and vim.wo.scrollbind then
      vim.schedule(function() vim.cmd("syncbind") end)
    end
  end,
})

-- Fold method optimization for diff mode
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  group = vim.api.nvim_create_augroup("DiffFoldMethod", { clear = true }),
  callback = function()
    if vim.wo.diff then
      vim.wo.foldmethod = "diff"
      vim.wo.foldlevel = 0
    else
      vim.wo.foldmethod = "indent" -- or your preferred default
    end
  end,
})

-- Enhanced visual selection behavior in diff mode  
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "*:v", "*:V", "*:\22" }, -- Enter visual modes
  group = vim.api.nvim_create_augroup("DiffVisualMode", { clear = true }),
  callback = function()
    if vim.wo.diff then
      -- Improve visual selection contrast in diff mode
      vim.opt_local.cursorline = false
    end
  end,
})
--]]

-- Performance optimizations beyond LazyVim defaults
vim.opt.updatetime = 50 -- Faster than default 200ms
vim.opt.timeoutlen = 300 -- Faster than default 500ms
vim.opt.synmaxcol = 300 -- Limit syntax highlighting for performance

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
