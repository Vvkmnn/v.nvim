-- functions
local M = {}


-- 🔍 DEBUG TEST: Hook should show debug output and update left editor!

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

function M.vLogo()
  local vlogo = table.concat({
    " #################################################### ",
    " #################################################### ",
    " ######################        ###################### ",
    " ################                    ################ ",
    " #############                #######   ############# ",
    " ###########                #########     ########### ",
    " #########                 ########         ######### ",
    " ########                  ######            ######## ",
    " #######                   ######             ####### ",
    " ######            ####### ######              ###### ",
    " #####           ######### ######               ##### ",
    " #####           #######   ######               ##### ",
    " #####            ######    #####               ##### ",
    " #####             ######    ####               ##### ",
    " #####              ######    ###               ##### ",
    " #####               ######    #                ##### ",
    " ######               ######                   ###### ",
    " #######               #####                  ####### ",
    " ########               #####                ######## ",
    " ##########              #####             ########## ",
    " ############             #####          ############ ",
    " ##############               ##       ############## ",
    " ##################                ################## ",
    " #################################################### ",
    " #################################################### ",
  }, "\n")

  return vlogo
end

-- ClaudeFeedback: Add tasks/comments to CLAUDE.md for next session
function M.ClaudeFeedback(range)
  -- Get user input
  local feedback = vim.fn.input("Claude Task: ")
  
  if feedback and feedback ~= "" then
    -- Get current file and line info
    local current_file = vim.fn.expand("%:.")
    local line_info = ""
    
    if range then
      -- Visual selection range
      line_info = string.format("%s:L%d-%d", current_file, range.line1, range.line2)
    else
      -- Current line
      local line_num = vim.fn.line(".")
      line_info = string.format("%s:L%d", current_file, line_num)
    end
    
    -- Write to CLAUDE.md in current working directory
    local claude_file = vim.fn.getcwd() .. "/CLAUDE.md"
    local file = io.open(claude_file, "a")
    if file then
      local timestamp = os.date("%Y-%m-%d %H:%M")
      file:write("## Task - " .. timestamp .. " [PENDING]\n")
      file:write(feedback .. "\n")
      file:write("**Location:** " .. line_info .. "\n\n")
      file:close()
      print("\nTask added to CLAUDE.md: " .. feedback .. " (" .. line_info .. ")")
    else
      print("\nError: Could not write to CLAUDE.md")
    end
  end
end

-- ClaudeCleanup: Archive completed tasks and clean CLAUDE.md
function M.ClaudeCleanup()
  local claude_file = vim.fn.getcwd() .. "/CLAUDE.md"
  local archive_file = vim.fn.getcwd() .. "/CLAUDE.archive.md"
  
  -- Read current CLAUDE.md
  local file = io.open(claude_file, "r")
  if not file then
    print("No CLAUDE.md file found")
    return
  end
  
  local content = file:read("*all")
  file:close()
  
  -- Separate completed and pending tasks
  local pending_tasks = {}
  local completed_tasks = {}
  local current_task = ""
  local is_completed = false
  
  for line in content:gmatch("([^\n]*)\n?") do
    if line:match("^## Task .-") then
      if current_task ~= "" then
        if is_completed then
          table.insert(completed_tasks, current_task)
        else
          table.insert(pending_tasks, current_task)
        end
      end
      current_task = line .. "\n"
      is_completed = line:match("%[COMPLETED%]") ~= nil
    else
      current_task = current_task .. line .. "\n"
    end
  end
  
  -- Handle last task
  if current_task ~= "" then
    if is_completed then
      table.insert(completed_tasks, current_task)
    else
      table.insert(pending_tasks, current_task)
    end
  end
  
  -- Write pending tasks back to CLAUDE.md
  local new_file = io.open(claude_file, "w")
  if new_file then
    new_file:write("# Project Tasks\n\n")
    for _, task in ipairs(pending_tasks) do
      new_file:write(task)
    end
    new_file:close()
  end
  
  -- Archive completed tasks
  if #completed_tasks > 0 then
    local archive = io.open(archive_file, "a")
    if archive then
      archive:write("# Archived Tasks - " .. os.date("%Y-%m-%d") .. "\n\n")
      for _, task in ipairs(completed_tasks) do
        archive:write(task)
      end
      archive:write("\n")
      archive:close()
    end
  end
  
  print("Cleaned up " .. #completed_tasks .. " completed tasks, " .. #pending_tasks .. " pending tasks remain")
end


return M
