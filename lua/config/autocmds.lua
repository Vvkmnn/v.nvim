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

-- Enhanced unified hover system - gentle popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("GentleHover", { clear = true }),
  callback = function()
    -- Skip if in insert mode, popup already exists, or in diff mode
    if vim.fn.mode() == "i" or vim.fn.pumvisible() == 1 or vim.wo.diff then
      return
    end
    
    -- Check if there's already a floating window
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        return
      end
    end
    
    -- Priority 1: Try LSP hover first (most important for variables/symbols)
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local lsp_showed = false
    
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/hover") then
        -- Use a small delay to make it feel gentle
        vim.defer_fn(function()
          if vim.fn.mode() == "n" then -- Still in normal mode
            vim.lsp.buf.hover()
            lsp_showed = true
          end
        end, 100)
        break
      end
    end
    
    -- Priority 2: Show diagnostics if no LSP response after a moment
    if not lsp_showed then
      vim.defer_fn(function()
        if vim.fn.mode() == "n" then
          local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
          if #line_diagnostics > 0 then
            vim.diagnostic.open_float(nil, {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = "rounded",
              source = "never",
              prefix = "",
              scope = "line",
              header = "",
              suffix = "",
              format = function(diagnostic)
                return string.format("%s %s", 
                  diagnostic.severity == vim.diagnostic.severity.ERROR and "❌" or
                  diagnostic.severity == vim.diagnostic.severity.WARN and "⚠️" or
                  diagnostic.severity == vim.diagnostic.severity.HINT and "💡" or "ℹ️",
                  diagnostic.message
                )
              end,
            })
          end
        end
      end, 200)
    end
  end
})

-- Dynamic centered cursor (better performance than fixed scrolloff = 999)
vim.api.nvim_create_autocmd({ "VimResized", "WinEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("DynamicScrolloff", { clear = true }),
  callback = function()
    vim.opt.scrolloff = math.floor(vim.fn.winheight(0) / 2)
  end,
  desc = "Keep cursor centered dynamically (adapts to window height)",
})

-- Commented out - was interfering with tokyonight theme
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   command = [[highlight CursorLine guibg=black ctermbg=115]],
-- })

-- Macros with q dont show up (replacedf with plugin, moves up screen)
-- vim.api.nvim_create_autocmd("RecordingEnter", {
--   callback = function()
--     vim.opt.cmdheight = 1
--   end,
-- })
-- vim.api.nvim_create_autocmd("RecordingLeave", {
--   callback = function()
--     vim.opt.cmdheight = 0
--   end,
-- })

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
vim.api.nvim_create_user_command("ClaudeFeedback", function(opts)
  require("util.functions").ClaudeFeedback(opts.range == 2 and { line1 = opts.line1, line2 = opts.line2 } or nil)
end, {
  desc = "Add tasks/comments to CLAUDE.md for next session",
  range = true,
})

-- Create the ClaudeCleanup command
vim.api.nvim_create_user_command("ClaudeCleanup", function()
  require("util.functions").ClaudeCleanup()
end, {
  desc = "Archive completed tasks and clean CLAUDE.md",
})

-- Clean markdown editing experience - hide inline diagnostics but keep hover
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  callback = function(ev)
    -- Hide all virtual text in markdown files, keep hover functionality
    vim.diagnostic.config({
      virtual_text = false,
    })

    -- Optimize markdown display
    vim.opt_local.conceallevel = 0 -- Show all markup characters (no hiding)
    vim.opt_local.wrap = true      -- Wrap long lines
    vim.opt_local.linebreak = true -- Break at word boundaries

    -- Enable spell checking with Australian English priority
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_au,en_us,en_ca"
  end,
  desc = "Clean markdown display - hide inline diagnostics, keep hover",
})

-- Spell check for LaTeX files (en_au priority)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "latex", "plaintex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_au,en_us,en_ca"
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
  desc = "Enable spell check for LaTeX files (en_au priority)",
})

-- Diff window settings (claudecode.nvim and general diff)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(buf)

    if vim.wo.diff then
      -- Only apply to claudecode proposed buffers
      if not bufname:match("%(proposed%)") then
        return
      end

      -- Disable diagnostics in diff view
      vim.diagnostic.enable(false, { bufnr = 0 })

      -- Window settings - minimal appearance with word wrap
      vim.wo.cursorline = true
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = "no"
      vim.wo.statuscolumn = ""
      vim.wo.foldcolumn = "0"
      vim.wo.wrap = true
      vim.wo.linebreak = true
      vim.wo.list = false
      vim.wo.conceallevel = 0

      -- DISABLED: Syntax dimming (2025-01-07)
      -- winhighlight dimmed ALL syntax to gray, making diff hard to read
      -- New approach: Keep syntax colors FULL, use subtle line backgrounds (modify.lua)
      -- Intensity Scaling Design: line bg (whisper) → word bg (speak) → word text (shout)
      -- vim.wo.winhighlight = table.concat({
      --   "Comment:DiffDimmedComment",
      --   "@comment:DiffDimmedComment",
      --   "@keyword:DiffDimmedKeyword",
      --   "Keyword:DiffDimmedKeyword",
      --   "@string:DiffDimmedString",
      --   "String:DiffDimmedString",
      --   "@function:DiffDimmedFunction",
      --   "Function:DiffDimmedFunction",
      --   "@variable:DiffDimmed",
      --   "@parameter:DiffDimmed",
      --   "@property:DiffDimmed",
      --   "Identifier:DiffDimmed",
      --   "Normal:DiffDimmed",
      -- }, ",")

      -- Lock buffer by default - requires explicit unlock with <leader>e
      vim.bo.modifiable = false

      -- Helper: Show reminder when trying to edit
      local function show_unlock_reminder()
        vim.notify("Diff buffer locked. Press <leader>e to unlock editing", vim.log.levels.WARN)
      end

      -- Map common edit keys to show reminder
      local edit_keys = { "i", "I", "a", "A", "o", "O", "s", "S", "c", "C", "d", "x" }
      for _, key in ipairs(edit_keys) do
        vim.keymap.set("n", key, show_unlock_reminder, {
          buffer = 0,
          desc = "Remind about unlock key",
        })
      end

      -- Add unlock keybind (buffer-local)
      vim.keymap.set("n", "<leader>e", function()
        vim.bo.modifiable = true
        -- Clear the reminder mappings so normal editing works
        for _, key in ipairs(edit_keys) do
          pcall(vim.keymap.del, "n", key, { buffer = 0 })
        end
        vim.notify("Diff buffer unlocked - editing enabled", vim.log.levels.INFO)
      end, {
        buffer = 0,
        desc = "Unlock diff buffer for editing",
      })

      -- Add buffer-local diff control keymaps (ensures they work regardless of lazy loading)
      -- These work from EITHER window in the diff view
      local function find_diff_tab_name()
        -- First check current buffer
        local tab_name = vim.b[vim.api.nvim_get_current_buf()].claudecode_diff_tab_name
        if tab_name then return tab_name end
        -- Search other windows in current tab for the proposed buffer
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          tab_name = vim.b[buf].claudecode_diff_tab_name
          if tab_name then return tab_name end
        end
        return nil
      end

      vim.keymap.set("n", "<leader>[", function()
        local tab_name = find_diff_tab_name()
        if tab_name then
          vim.cmd("ClaudeCodeDiffDeny")
        else
          vim.notify("No active diff found", vim.log.levels.WARN)
        end
      end, { buffer = 0, desc = "Reject diff (buffer-local)" })

      vim.keymap.set("n", "<leader>]", function()
        local tab_name = find_diff_tab_name()
        if tab_name then
          vim.cmd("ClaudeCodeDiffAccept")
        else
          vim.notify("No active diff found", vim.log.levels.WARN)
        end
      end, { buffer = 0, desc = "Accept diff (buffer-local)" })

      vim.keymap.set("n", "q", function()
        -- Quick escape: reject diff and close
        local tab_name = find_diff_tab_name()
        if tab_name then
          vim.cmd("ClaudeCodeDiffDeny")
        else
          vim.cmd("close")
        end
      end, { buffer = 0, desc = "Quick reject/close diff" })

      -- Sync all diff windows after they're created (preserve window focus)
      vim.defer_fn(function()
        local current_win = vim.api.nvim_get_current_win()
        vim.cmd("noautocmd windo if &diff | set scrollbind cursorbind wrap linebreak | endif")
        vim.cmd("noautocmd syncbind")
        vim.cmd("wincmd =")
        -- Restore focus to original window
        if vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_set_current_win(current_win)
        end
      end, 50)
    else
      -- Only cleanup claudecode buffers
      if not bufname:match("%(proposed%)") then
        return
      end

      -- Clean up ALL keymaps we created
      local all_keymaps = { "<leader>[", "<leader>]", "<leader>e", "q",
                           "i", "I", "a", "A", "o", "O", "s", "S", "c", "C", "d", "x" }
      for _, key in ipairs(all_keymaps) do
        pcall(vim.keymap.del, "n", key, { buffer = buf })
      end
      vim.bo.modifiable = true
    end
  end,
  desc = "Diff window settings",
})

-- Perfect scroll synchronization with multiple triggers
-- NOTE (2026-01-05): If j/k scrolling freezes in diff mode, this autocmd may be causing
-- a cascade of syncbind calls. CursorMoved fires on every keypress which can create
-- a feedback loop even with noautocmd. Disable this block if scrolling becomes laggy.
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  group = vim.api.nvim_create_augroup("DiffScrollSync", { clear = true }),
  callback = function()
    if vim.wo.diff and vim.wo.scrollbind then
      vim.cmd("noautocmd syncbind")
    end
  end,
  desc = "Keep diff windows synchronized when scrolling",
})

-- DISABLED: mini.diff unified diff experiment (2025-11-25)
-- Issues discovered:
--   1. BufEnter fires too early, before claudecode.nvim sets buffer variables
--   2. Closing target_win can close entire editor if it's the last window
--   3. mini.diff.enable() fails on claudecode's acwrite scratch buffers
--   4. Conflicts with existing diff autocmd at lines 153-204
-- To revisit: Need to hook into claudecode.nvim's diff completion event,
-- not BufEnter. Or wait for claudecode.nvim Issue #82 (native inline diff).
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("ClaudeCodeUnifiedDiff", { clear = true }),
--   callback = function()
--     local buf = vim.api.nvim_get_current_buf()
--     if not vim.b[buf].claudecode_diff_tab_name then return end
--     if vim.b[buf].claudecode_minidiff_converted then return end
--
--     local target_win = vim.b[buf].claudecode_diff_target_win
--     if not target_win or not vim.api.nvim_win_is_valid(target_win) then return end
--
--     vim.b[buf].claudecode_minidiff_converted = true
--
--     local target_buf = vim.api.nvim_win_get_buf(target_win)
--     local original_lines = vim.api.nvim_buf_get_lines(target_buf, 0, -1, false)
--
--     vim.schedule(function()
--       if not vim.api.nvim_buf_is_valid(buf) then return end
--
--       pcall(vim.cmd, "diffoff!")
--       if vim.api.nvim_win_is_valid(target_win) then
--         pcall(vim.api.nvim_win_close, target_win, true)
--       end
--
--       local ok, minidiff = pcall(require, "mini.diff")
--       if ok and vim.api.nvim_buf_is_valid(buf) then
--         minidiff.enable(buf)
--         minidiff.set_ref_text(buf, original_lines)
--         minidiff.toggle_overlay(buf)
--       end
--     end)
--   end,
--   desc = "Claude Code single-window unified diff via mini.diff",
-- })

-- ============================================================================
-- DISABLED: mini.diff unified single-pane approach (2025-11-25)
-- ============================================================================
-- WHAT IT DOES:
--   Converts claudecode.nvim two-pane diff into single-pane inline overlay
--   using mini.diff. Shows deleted lines as virtual text, jumps to first hunk.
--
-- WHAT WORKS:
--   - Single pane inline view (no split windows)
--   - Jumps to first hunk automatically with goto_hunk("first")
--   - Shows deleted lines as virtual text
--   - Word-level diff highlighting via mini.diff overlay
--
-- WHAT DOESN'T WORK / ISSUES:
--   - Buffer IS modified before accept (by design - shows proposed state)
--   - User sees "modified" indicator during preview (confusing UX)
--   - No native accept/reject - needs custom keymaps to restore original
--   - Closing diff can exit editor if it's the last window
--   - Artifacts remain if user doesn't explicitly accept/reject
--
-- TO FIX (if re-enabling):
--   Need to add buffer-local keymaps for accept/reject:
--   - Accept: vim.cmd("write"), clear ref_text, toggle_overlay off
--   - Reject: restore vim.b.claudecode_original_lines, clear ref_text
--
-- ALTERNATIVES RESEARCHED:
--   - sidekick.nvim (folke): True visual-only preview, no buffer mod
--     but replaces claudecode.nvim entirely
--   - unified.nvim: Git-only, won't work with claudecode buffers
--   - diffview.nvim: Git-only, won't work with claudecode buffers
--
-- DECISION: Use two-pane diff (stable, no buffer mod until accept)
-- ============================================================================
-- vim.api.nvim_create_autocmd("OptionSet", {
--   pattern = "diff",
--   group = vim.api.nvim_create_augroup("ClaudeCodeUnifiedDiff", { clear = true }),
--   callback = function()
--     if not vim.v.option_new or vim.v.option_new == "0" then return end
--
--     local proposed_buf = vim.api.nvim_get_current_buf()
--     local name = vim.api.nvim_buf_get_name(proposed_buf)
--     if not name:match("Claude Code") then return end
--
--     vim.defer_fn(function()
--       if not vim.api.nvim_buf_is_valid(proposed_buf) then return end
--
--       local target_win = vim.b[proposed_buf].claudecode_diff_target_win
--       if not target_win or not vim.api.nvim_win_is_valid(target_win) then return end
--
--       local target_buf = vim.api.nvim_win_get_buf(target_win)
--       local original_lines = vim.api.nvim_buf_get_lines(target_buf, 0, -1, false)
--       local proposed_lines = vim.api.nvim_buf_get_lines(proposed_buf, 0, -1, false)
--
--       pcall(vim.cmd, "diffoff!")
--       vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, proposed_lines)
--
--       local ok, minidiff = pcall(require, "mini.diff")
--       if ok then
--         minidiff.set_ref_text(target_buf, table.concat(original_lines, "\n"))
--         minidiff.toggle_overlay(target_buf)
--       end
--
--       vim.api.nvim_set_current_win(target_win)
--
--       -- Jump to first hunk and center view
--       vim.defer_fn(function()
--         if ok then
--           pcall(minidiff.goto_hunk, "first")
--           vim.cmd("normal! zz")
--         end
--       end, 50)
--       for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
--         if win ~= target_win then
--           local win_buf = vim.api.nvim_win_get_buf(win)
--           if vim.api.nvim_buf_get_name(win_buf):match("Claude Code") then
--             pcall(vim.api.nvim_win_close, win, true)
--           end
--         end
--       end
--     end, 100)
--   end,
--   desc = "Claude Code unified diff via mini.diff overlay",
-- })

-- LSP hover window styling configured globally for unified system
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  focusable = false,
  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  max_width = 80,
  max_height = 20,
})

-- COMMENTED OUT: Previous LSP hover system (replaced with unified hover above)
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp_hover_on_hold", { clear = true }),
--   callback = function(args)
--     local buffer = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     
--     -- Only enable for servers that support hover
--     if client and client.supports_method("textDocument/hover") then
--       local hover_timer = nil
--       
--       vim.api.nvim_create_autocmd("CursorHold", {
--         group = vim.api.nvim_create_augroup("lsp_hover_" .. buffer, { clear = true }),
--         buffer = buffer,
--         callback = function()
--           -- Cancel previous timer
--           if hover_timer then
--             hover_timer:stop()
--             hover_timer = nil
--           end
--           
--           -- Check if we're in insert mode or if a float is already open
--           if vim.fn.mode() == "i" or vim.fn.pumvisible() == 1 then
--             return
--           end
--           
--           -- Check if there's already a floating window
--           for _, win in ipairs(vim.api.nvim_list_wins()) do
--             if vim.api.nvim_win_get_config(win).relative ~= "" then
--               return -- Float window already exists
--             end
--           end
--           
--           -- Debounced hover with 100ms delay
--           hover_timer = vim.defer_fn(function()
--             if vim.fn.mode() == "n" then -- Still in normal mode
--               vim.lsp.buf.hover()
--             end
--           end, 100)
--         end,
--       })
--       
--       -- Clean up timer on cursor move
--       vim.api.nvim_create_autocmd("CursorMoved", {
--         group = vim.api.nvim_create_augroup("hover_cleanup_" .. buffer, { clear = true }),
--         buffer = buffer,
--         callback = function()
--           if hover_timer then
--             hover_timer:stop()
--             hover_timer = nil
--           end
--         end,
--       })
--     end
--   end,
-- })

-- Claude Code terminal buffer optimization
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*claudecode*",
  callback = function()
    vim.opt_local.scrollback = 10000 -- High scrollback for unlimited feel
    vim.opt_local.wrap = true        -- Fix text wrapping
    vim.opt_local.linebreak = true   -- Break at word boundaries
  end,
  desc = "Claude Code terminal buffer settings"
})

-- Auto-focus Claude terminal when neovim regains focus (e.g., switching back from another app)
-- Skips auto-focus if diff view is open (claudecode diff approval pending)
vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("ClaudeAutoFocus", { clear = true }),
  callback = function()
    vim.schedule(function()
      -- Skip auto-focus if any window is in diff mode (claudecode diff approval pending)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.wo[win].diff then
          return -- Don't switch focus, diff view is active
        end
      end

      -- Find and focus Claude terminal
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        -- claudecode terminals are named "term://...claude..."
        if vim.bo[buf].buftype == "terminal" and name:lower():match("claude") then
          vim.api.nvim_set_current_win(win)
          vim.cmd("startinsert")
          return
        end
      end
    end)
  end,
  desc = "Auto-focus Claude terminal on FocusGained (skips if diff view open)"
})

-- == Silent Auto-Reload with Three-Way Merge ==
-- Merges external changes while preserving your unsaved edits.
-- Your edits + Claude's edits = both preserved (if on different lines).
-- When both edit the same line: you win, conflict is notified.

local reload_group = vim.api.nvim_create_augroup("SmartAutoReload", { clear = true })

-- Store base content and mtime when buffer is loaded
vim.api.nvim_create_autocmd("BufReadPost", {
  group = reload_group,
  callback = function(ev)
    vim.b[ev.buf].base_lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(ev.buf))
    vim.b[ev.buf].last_mtime = stat and stat.mtime.sec
  end,
})

-- Update base when you save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = reload_group,
  callback = function(ev)
    vim.b[ev.buf].base_lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(ev.buf))
    vim.b[ev.buf].last_mtime = stat and stat.mtime.sec
  end,
})

-- Check if two hunks overlap (conflict)
local function hunks_overlap(h1, h2)
  local s1, e1 = h1[1], h1[1] + math.max(h1[2] - 1, 0)
  local s2, e2 = h2[1], h2[1] + math.max(h2[2] - 1, 0)
  return s1 <= e2 and s2 <= e1
end

-- Check for external changes and merge
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = reload_group,
  callback = function(ev)
    local buf = ev.buf
    if vim.bo[buf].buftype ~= "" then return end

    local fname = vim.api.nvim_buf_get_name(buf)
    if fname == "" then return end

    local stat = vim.uv.fs_stat(fname)
    if not stat then return end

    -- Check mtime
    local disk_mtime = stat.mtime.sec
    if vim.b[buf].last_mtime == disk_mtime then return end
    vim.b[buf].last_mtime = disk_mtime

    local base = vim.b[buf].base_lines
    local disk_lines = vim.fn.readfile(fname)
    if not base or not disk_lines then return end

    local base_text = table.concat(base, "\n")
    local disk_text = table.concat(disk_lines, "\n")
    if base_text == disk_text then return end

    -- Compute user's changes (base → buffer)
    local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local buf_text = table.concat(buf_lines, "\n")
    local user_hunks = vim.diff(base_text, buf_text, { result_type = "indices" }) or {}

    -- Compute Claude's changes (base → disk)
    local claude_hunks = vim.diff(base_text, disk_text, { result_type = "indices" }) or {}
    if #claude_hunks == 0 then return end

    -- Apply Claude's changes, skipping conflicts (user wins)
    local applied, skipped = 0, 0
    for i = #claude_hunks, 1, -1 do
      local ch = claude_hunks[i]
      local conflict = false

      for _, uh in ipairs(user_hunks) do
        if hunks_overlap(ch, uh) then
          conflict = true
          skipped = skipped + 1
          break
        end
      end

      if not conflict then
        local new_lines = {}
        for j = ch[3], ch[3] + ch[4] - 1 do
          new_lines[#new_lines + 1] = disk_lines[j] or ""
        end
        vim.api.nvim_buf_set_lines(buf, ch[1] - 1, ch[1] - 1 + ch[2], false, new_lines)
        applied = applied + 1
      end
    end

    -- Update base to new disk content
    vim.b[buf].base_lines = disk_lines

    -- Notify
    local msg = "Merged: " .. vim.fn.fnamemodify(fname, ":t")
    if skipped > 0 then
      msg = msg .. " (" .. skipped .. " conflict" .. (skipped > 1 and "s" or "") .. " - yours kept)"
    end
    vim.notify(msg, skipped > 0 and vim.log.levels.WARN or vim.log.levels.INFO)
  end,
  desc = "Silent auto-reload with three-way merge (user wins conflicts)"
})

-- ============================================================================
-- SMART AUTO-RELOAD WITH CONFLICT DETECTION (DISABLED - uncomment to enable)
-- ============================================================================
-- This version shows a merge dialog when you have unsaved changes AND the
-- file was modified externally. Gives options to: reload, keep, diff, or backup.
--
-- To enable: uncomment the code below and comment out the simple auto-reload above
--
-- -- Track original file state when opening
-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--   group = vim.api.nvim_create_augroup("SmartReload", { clear = true }),
--   callback = function(ev)
--     local buf = ev.buf
--     -- Store SHA256 hash of original content for change detection
--     local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--     vim.b[buf].original_hash = vim.fn.sha256(table.concat(lines, "\n"))
--   end,
--   desc = "Store original content hash for conflict detection"
-- })
--
-- -- Continuously check for external file changes
-- vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
--   group = vim.api.nvim_create_augroup("AutoReload", { clear = true }),
--   callback = function(ev)
--     local buf = ev.buf
--
--     -- Skip special buffers (terminals, quickfix, help, etc.)
--     if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable then
--       return
--     end
--
--     -- Skip if file doesn't exist on disk
--     local fname = vim.api.nvim_buf_get_name(buf)
--     if fname == "" or not vim.uv.fs_stat(fname) then
--       return
--     end
--
--     -- Detect if we have local unsaved changes
--     local has_local_changes = vim.bo[buf].modified
--
--     -- Check if file timestamp changed on disk
--     -- If no local changes, this will auto-reload silently
--     -- If local changes exist, FileChangedShell event will fire
--     vim.cmd("silent! checktime " .. buf)
--
--     -- If we have local changes AND file changed externally, handle conflict
--     if has_local_changes then
--       -- This autocmd only runs if checktime detected external changes
--       vim.api.nvim_create_autocmd("FileChangedShell", {
--         buffer = buf,
--         once = true, -- Only fire once per conflict
--         callback = function()
--           -- Present merge/conflict resolution options
--           local choice = vim.fn.confirm(
--             "⚠️  CONFLICT DETECTED ⚠️\n\n" ..
--             "File changed externally AND you have unsaved changes!\n" ..
--             "File: " .. vim.fn.fnamemodify(fname, ":~:.") .. "\n\n" ..
--             "What would you like to do?",
--             "&Reload (lose your changes)\n" ..
--             "&Keep your version\n" ..
--             "&Diff/Merge (recommended)\n" ..
--             "&Save yours first, then reload",
--             3 -- Default to option 3 (Diff/Merge)
--           )
--
--           if choice == 1 then
--             -- Option 1: Reload external version (discard local changes)
--             vim.cmd("edit!")
--             vim.notify("✓ Reloaded external version (your changes discarded)", vim.log.levels.WARN)
--
--           elseif choice == 2 then
--             -- Option 2: Keep local version (ignore external changes)
--             vim.notify("✓ Keeping your version. Remember to save!", vim.log.levels.INFO)
--
--           elseif choice == 3 then
--             -- Option 3: Open side-by-side diff for manual merge
--
--             -- Save current buffer content to temp file
--             local temp_your_version = vim.fn.tempname()
--             local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--             vim.fn.writefile(current_lines, temp_your_version)
--
--             -- Reload external version into current buffer
--             vim.cmd("edit!")
--
--             -- Open vertical split with your version on the right
--             vim.cmd("vsplit " .. temp_your_version)
--             vim.cmd("diffthis") -- Enable diff mode on your version (right)
--             vim.cmd("wincmd p") -- Switch back to external version (left)
--             vim.cmd("diffthis") -- Enable diff mode on external version (left)
--
--             -- Show helpful instructions
--             vim.notify(
--               "📊 DIFF MODE\n\n" ..
--               "LEFT:  External version (LLM/disk)\n" ..
--               "RIGHT: Your version (unsaved)\n\n" ..
--               "Commands:\n" ..
--               "  do  - Get change from other window\n" ..
--               "  dp  - Put change to other window\n" ..
--               "  ]c  - Next change\n" ..
--               "  [c  - Previous change\n" ..
--               "  :diffoff | wincmd o  - Exit diff mode",
--               vim.log.levels.INFO
--             )
--
--           elseif choice == 4 then
--             -- Option 4: Backup your version with timestamp, then reload external
--             local backup = fname .. ".yours." .. os.date("%Y%m%d_%H%M%S")
--             vim.cmd("write " .. backup)
--             vim.cmd("edit!")
--             vim.notify(
--               "✓ Backed up your version to:\n  " .. backup .. "\n" ..
--               "✓ Reloaded external version",
--               vim.log.levels.INFO
--             )
--           end
--
--           return true -- Prevent default FileChangedShell warning
--         end,
--       })
--     end
--   end,
--   desc = "Smart auto-reload: silent if no changes, merge dialog if conflict"
-- })
--
-- -- Update hash after saving (reset baseline for future conflict detection)
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = vim.api.nvim_create_augroup("UpdateHash", { clear = true }),
--   callback = function(ev)
--     local buf = ev.buf
--     local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--     vim.b[buf].original_hash = vim.fn.sha256(table.concat(lines, "\n"))
--   end,
--   desc = "Update content hash after save (reset conflict detection baseline)"
-- })

-- ============================================================================
-- OPTION 5: SMART SWAPFILE HANDLING (Currently disabled - swapfiles are off)
-- ============================================================================
-- If you re-enable swapfiles (vim.opt.swapfile = true in options.lua), uncomment
-- this autocmd to get the best of both worlds:
--   - Crash recovery preserved for active sessions
--   - Auto-deletes stale swaps from dead processes (no more W325 warnings)
--
-- Also add to options.lua:
--   vim.opt.swapfile = true
--   vim.opt.directory = vim.fn.stdpath("state") .. "/swap//"
--
-- v:swapchoice options: 'o'=readonly, 'e'=edit, 'r'=recover, 'd'=delete, 'q'=quit
--
-- vim.api.nvim_create_autocmd("SwapExists", {
--   group = vim.api.nvim_create_augroup("SmartSwapfile", { clear = true }),
--   callback = function()
--     local info = vim.fn.swapinfo(vim.v.swapname)
--     local pid = info.pid or 0
--
--     -- Check if the process that created the swap is still running
--     local process_running = false
--     if pid > 0 then
--       -- kill -0 doesn't kill, just checks if process exists
--       process_running = vim.fn.system("kill -0 " .. pid .. " 2>/dev/null; echo $?"):gsub("%s+", "") == "0"
--     end
--
--     if process_running then
--       -- Process alive: show prompt (you're editing same file in another nvim)
--       vim.v.swapchoice = ""
--     else
--       -- Process dead: auto-delete the stale swap silently
--       vim.v.swapchoice = "d"
--     end
--   end,
--   desc = "Auto-delete stale swap files from dead processes",
-- })
