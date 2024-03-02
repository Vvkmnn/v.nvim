-- functions
function OpenDotfilesInNeogit()
  local git_dir = vim.fn.expand("~/.dotfiles")
  local work_tree = vim.fn.expand("~")

  vim.cmd("let $GIT_DIR = '" .. git_dir .. "'")
  vim.cmd("let $GIT_WORK_TREE = '" .. work_tree .. "'")

  require("neogit").open()
end
