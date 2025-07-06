-- 🚀 RESTART TEST: The left editor should now update to show disable.lua!
-- This file disables plugins to create a vanilla, high-performance experience
-- Claude Code multi-file integration test
-- when running inside the Windsurf IDE.

-- We check for vim.g.vscode, which is set by the Windsurf extension.
if not vim.g.vscode then
  return {}
end
