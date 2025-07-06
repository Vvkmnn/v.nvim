-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Only specify options that differ from LazyVim defaults
vim.opt.shiftwidth = 4 -- Use 4 spaces instead of default 2
vim.opt.tabstop = 4 -- Display tabs as 4 spaces instead of default 2
vim.opt.wrap = true -- Enable line wrapping (LazyVim default is false)
vim.opt.scrolloff = 111 -- 111 for middle screen
vim.opt.showtabline = 0 -- Never show tab line (LazyVim default is 1)
vim.opt.fillchars = { vert = " ", eob = " " } -- Remove vertical separators and end-of-buffer tildes
vim.opt.foldcolumn = "0" -- Remove fold column completely

-- Latest beautiful inline character-wise diffs for claudecode.nvim (working!)
-- Neovim 0.11+ supports advanced inline diff highlighting
vim.opt.diffopt = {
  "internal", -- Use internal diff library
  "filler", -- Show filler lines
  "closeoff", -- Close folds in other windows
  "hiddenoff", -- Don't use diff mode for hidden buffers
  "algorithm:patience", -- Better diff algorithm
  "linematch:60", -- Improve line matching within diff hunks
  "iwhite", -- Ignore whitespace changes
}

-- Enhanced diff highlighting that works with claudecode.nvim's diffthis implementation
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Better diff colors for character-level readability
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#003d00", fg = "NONE" }) -- Darker green
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3d0000", fg = "#606060" }) -- Darker red
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#003d3d", fg = "NONE" }) -- Darker cyan
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#7C6F64", fg = "#FFFFFF", bold = true }) -- Bold changed text
  end,
})

-- Enhanced diffthis improvements that work with any plugin using native diff
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.wo.diff then
      -- Better readability and wrapping
      vim.wo.wrap = true -- Word wrap for long lines
      vim.wo.linebreak = true -- Break at word boundaries
      vim.wo.foldcolumn = "0" -- No fold column
      vim.wo.signcolumn = "no" -- No sign column
      vim.wo.number = true -- Line numbers for navigation
      vim.wo.relativenumber = false -- Absolute numbers work better for diffs
      vim.wo.cursorline = true -- Highlight current line
      vim.wo.scrollbind = true -- Sync scrolling between diff windows

      -- Optimize layout when exactly 2 diff windows exist
      vim.schedule(function()
        if vim.fn.winnr("$") == 2 then
          vim.cmd("wincmd =") -- Equal window sizes
          -- Focus slightly more space on the right window (new content)
          vim.cmd("vertical resize +3")
        end
      end)
    end
  end,
})

-- Performance optimizations beyond LazyVim defaults
vim.opt.updatetime = 50 -- Faster than default 200ms
vim.opt.timeoutlen = 300 -- Faster than default 500ms
vim.opt.synmaxcol = 300 -- Limit syntax highlighting for performance

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
