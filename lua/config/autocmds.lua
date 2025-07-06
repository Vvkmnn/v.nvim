-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--

-- Example
-- vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
--   group = augroup("checktime"),
--   callback = function()
--     if vim.o.buftype ~= "nofile" then
--       vim.cmd("checktime")
--     end
--   end,
-- })
--

vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[highlight CursorLine guibg=black ctermbg=115]],
})

-- Auto-open neo-tree sidebar when opening files (not directories)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only open neo-tree if we opened a file (not a directory)
    local args = vim.fn.argv()
    if #args > 0 then
      local stat = vim.uv.fs_stat(args[1])
      if stat and stat.type == "file" then
        -- Neo-tree auto-open disabled - only open manually with :Neotree
        -- vim.schedule(function()
        --   vim.cmd("Neotree show")
        --   -- Focus back on the file buffer
        --   vim.cmd("wincmd l")
        -- end)
      end
    end
  end,
  desc = "Open neo-tree sidebar when opening files",
})


-- 🎯 CTRL-H TEST: Should switch to left editor and show autocmds.lua here!

-- Create the ClaudeFeedback command
vim.api.nvim_create_user_command('ClaudeFeedback', function(opts)
  require('util.functions').ClaudeFeedback(opts.range == 2 and {line1 = opts.line1, line2 = opts.line2} or nil)
end, {
  desc = 'Add tasks/comments to CLAUDE.md for next session',
  range = true
})

-- Create the ClaudeCleanup command
vim.api.nvim_create_user_command('ClaudeCleanup', function()
  require('util.functions').ClaudeCleanup()
end, {
  desc = 'Archive completed tasks and clean CLAUDE.md'
})
