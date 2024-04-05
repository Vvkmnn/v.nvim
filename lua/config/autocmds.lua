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
