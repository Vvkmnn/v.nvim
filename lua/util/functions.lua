-- functions
local M = {}

function M.OpenDotfilesInNeogit()
  local git_dir = vim.fn.expand("~/.dotfiles")
  local work_tree = vim.fn.expand("~")

  vim.cmd("let $GIT_DIR = '" .. git_dir .. "'")
  vim.cmd("let $GIT_WORK_TREE = '" .. work_tree .. "'")

  require("neogit").open()
end

-- Reload Config + Keymaps
function M.ReloadConfig()
  -- Source init.lua
  vim.cmd("source ~/.config/nvim/init.lua")
  -- source keymaps.lua or any other config file you want to reload
  vim.cmd("source ~/.config/nvim/lua/config/keymaps.lua")

  -- You can add more source commands for other config files if needed
end

return M
