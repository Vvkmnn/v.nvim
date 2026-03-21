--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                                                                        │
--  │                       ######                                           │
--  │                     ######                                             │
--  │                    #####                                               │
--  │                    #####                                               │
--  │                    #####                                               │
--  │            ######  #####                                               │
--  │          ######    #####         autocmds.lua                          │
--  │        #######     #####         Autocommands (VeryLazy)               │
--  │       ######        ####                                               │
--  │        ######        ###         defaults → lazyvim.config.autocmds    │
--  │          #####        ##                                               │
--  │           #####        #                                               │
--  │            #####                                                       │
--  │             #####                                                      │
--  │              #####                                                     │
--  │               #####                                                    │
--  │                #####                                                   │
--  │                 #####                                                  │
--  │                                                                        │
--  ╰────────────────────────────────────────────────────────────────────────╯

-- NOTE: autocmd template (LazyVim pattern with augroup)
-- vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
--   group = augroup("checktime"),
--   callback = function()
--     if vim.o.buftype ~= "nofile" then
--       vim.cmd("checktime")
--     end
--   end,
-- })

-- gentle hover on cursor hold ---------------------------
-- shows LSP hover after cursor pauses (updatetime=800ms)
-- falls back to diagnostic float if no hover content
-- uses buf_request_all callback to avoid async race condition
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("GentleHover", { clear = true }),
  callback = function()
    if vim.g.gentle_hover_disabled or vim.fn.mode() ~= "n" or vim.fn.pumvisible() == 1 or vim.wo.diff then
      return
    end
    -- skip if an LSP/diagnostic float already exists (ignore notification floats)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        -- only block on hover/diagnostic floats, not notifications or other UI
        if ft == "markdown" or ft == "lspinfo" or ft == "" then
          return
        end
      end
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/hover" })

    if #clients > 0 then
      local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding)
      vim.lsp.buf_request_all(bufnr, "textDocument/hover", params, function(results)
        if vim.fn.mode() ~= "n" then return end
        if not vim.api.nvim_buf_is_valid(bufnr) then return end
        for _, resp in pairs(results) do
          if not resp.error and resp.result and resp.result.contents then
            vim.lsp.buf.hover()
            return
          end
        end
        -- NOTE: no hover content, fall back to diagnostics
        local diags = vim.diagnostic.get(bufnr, { lnum = vim.fn.line(".") - 1 })
        if #diags > 0 then
          vim.diagnostic.open_float({ scope = "line" })
        end
      end)
    else
      -- NOTE: no hover-capable LSP, show diagnostics directly
      local diags = vim.diagnostic.get(bufnr, { lnum = vim.fn.line(".") - 1 })
      if #diags > 0 then
        vim.diagnostic.open_float({ scope = "line" })
      end
    end
  end,
})

-- dynamic centered cursor -------------------------------
-- PERF: better performance than fixed scrolloff = 999
vim.api.nvim_create_autocmd({ "VimResized", "WinEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("DynamicScrolloff", { clear = true }),
  callback = function()
    vim.opt.scrolloff = math.floor(vim.fn.winheight(0) / 2)
  end,
  desc = "Keep cursor centered dynamically (adapts to window height)",
})

-- NOTE: disabled, was interfering with theme overrides
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   command = [[highlight CursorLine guibg=black ctermbg=115]],
-- })

-- NOTE: macros with q disabled (replaced with nvim-recorder plugin, moves up screen)
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

-- neo-tree auto-open ------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- NOTE: only open neo-tree if we opened a file (not a directory)
    local args = vim.fn.argv()
    if #args > 0 then
      local stat = vim.uv.fs_stat(args[1])
      if stat and stat.type == "file" then
        -- NOTE: neo-tree auto-open disabled, only open manually with :Neotree
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

-- claude commands ---------------------------------------
vim.api.nvim_create_user_command("ClaudeFeedback", function(opts)
  require("util.functions").ClaudeFeedback(opts.range == 2 and { line1 = opts.line1, line2 = opts.line2 } or nil)
end, {
  desc = "Add tasks/comments to CLAUDE.md for next session",
  range = true,
})

-- NOTE: archive completed tasks and clean CLAUDE.md
vim.api.nvim_create_user_command("ClaudeCleanup", function()
  require("util.functions").ClaudeCleanup()
end, {
  desc = "Archive completed tasks and clean CLAUDE.md",
})

-- markdown editing --------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  callback = function(ev)
    -- NOTE: hide all virtual text in markdown files, keep hover functionality
    vim.diagnostic.config({
      virtual_text = false,
    })

    -- NOTE: optimize markdown display
    -- vim.opt_local.conceallevel = 0 -- Disabled: blocks render-markdown.nvim tables/headings
    vim.opt_local.wrap = true      -- Wrap long lines
    vim.opt_local.linebreak = true -- Break at word boundaries

    -- NOTE: spell checking with Australian English priority
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_au,en_us,en_ca"
  end,
  desc = "Clean markdown display - hide inline diagnostics, keep hover",
})

-- latex spell check -------------------------------------
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

-- c/c++ development ------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    -- NOTE: clangd handles diagnostics, formatting via conform, DAP via codelldb
    --       these are per-buffer comfort settings only
    vim.opt_local.commentstring = "// %s" -- Modern C/C++ line comments (not /* */)
  end,
  desc = "C/C++ buffer settings",
})

-- ocaml development ------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex" },
  callback = function()
    -- NOTE: OCaml convention is 2-space indent (global default is 4)
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "OCaml 2-space indent (community convention)",
})

-- diff window settings ----------------------------------
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(buf)

    if vim.wo.diff then
      -- NOTE: only apply to claudecode proposed buffers
      if not bufname:match("%(proposed%)") then
        return
      end

      -- NOTE: disable diagnostics in diff view
      vim.diagnostic.enable(false, { bufnr = 0 })

      -- NOTE: minimal appearance with word wrap
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

      -- NOTE: syntax dimming disabled (2025-01-07)
      --       winhighlight dimmed ALL syntax to gray, making diff hard to read
      --       new approach: keep syntax colors full, use subtle line backgrounds (modify.lua)
      --       intensity scaling: line bg (whisper) > word bg (speak) > word text (shout)
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

      -- NOTE: lock buffer by default, requires explicit unlock with <leader>e
      vim.bo.modifiable = false

      -- NOTE: show reminder when trying to edit
      local function show_unlock_reminder()
        vim.notify("Diff buffer locked. Press <leader>e to unlock editing", vim.log.levels.WARN)
      end

      -- NOTE: map common edit keys to show reminder
      local edit_keys = { "i", "I", "a", "A", "o", "O", "s", "S", "c", "C", "d", "x" }
      for _, key in ipairs(edit_keys) do
        vim.keymap.set("n", key, show_unlock_reminder, {
          buffer = 0,
          desc = "Remind about unlock key",
        })
      end

      -- NOTE: unlock keybind (buffer-local)
      vim.keymap.set("n", "<leader>e", function()
        vim.bo.modifiable = true
        -- NOTE: clear the reminder mappings so normal editing works
        for _, key in ipairs(edit_keys) do
          pcall(vim.keymap.del, "n", key, { buffer = 0 })
        end
        vim.notify("Diff buffer unlocked - editing enabled", vim.log.levels.INFO)
      end, {
        buffer = 0,
        desc = "Unlock diff buffer for editing",
      })

      -- NOTE: buffer-local diff control keymaps (ensures they work regardless of lazy loading)
      --       these work from EITHER window in the diff view
      local function find_diff_tab_name()
        -- NOTE: first check current buffer
        local tab_name = vim.b[vim.api.nvim_get_current_buf()].claudecode_diff_tab_name
        if tab_name then return tab_name end
        -- NOTE: search other windows in current tab for the proposed buffer
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
        -- NOTE: quick escape, reject diff and close
        local tab_name = find_diff_tab_name()
        if tab_name then
          vim.cmd("ClaudeCodeDiffDeny")
        else
          vim.cmd("close")
        end
      end, { buffer = 0, desc = "Quick reject/close diff" })

      -- NOTE: sync all diff windows after they're created (preserve window focus)
      vim.defer_fn(function()
        local current_win = vim.api.nvim_get_current_win()
        vim.cmd("noautocmd windo if &diff | set scrollbind cursorbind wrap linebreak | endif")
        vim.cmd("noautocmd syncbind")
        vim.cmd("wincmd =")
        -- NOTE: restore focus to original window
        if vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_set_current_win(current_win)
        end
      end, 50)
    else
      -- NOTE: only cleanup claudecode buffers
      if not bufname:match("%(proposed%)") then
        return
      end

      -- NOTE: clean up ALL keymaps we created
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

-- diff scroll sync --------------------------------------
-- WARN: if j/k scrolling freezes in diff mode, this autocmd may be causing
--       a cascade of syncbind calls. CursorMoved fires on every keypress which can
--       create a feedback loop even with noautocmd. Disable this block if laggy.
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  group = vim.api.nvim_create_augroup("DiffScrollSync", { clear = true }),
  callback = function()
    if vim.wo.diff and vim.wo.scrollbind then
      vim.cmd("noautocmd syncbind")
    end
  end,
  desc = "Keep diff windows synchronized when scrolling",
})

-- NOTE: mini.diff unified diff experiment disabled (2025-11-25)
-- issues discovered:
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

-- mini.diff unified single-pane --------------------------
-- NOTE: disabled (2025-11-25), two-pane diff is more stable
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

-- NOTE: vim.lsp.handlers[] and vim.lsp.with() deprecated in Neovim 0.11
--       replaced by vim.o.winborder = "rounded" in options.lua (global float borders)
--       focusable/close_events are native defaults in 0.11
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = "rounded",
--   focusable = false,
--   close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--   max_width = 80,
--   max_height = 20,
-- })

-- NOTE: previous LSP hover system (replaced with unified hover above)
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

-- claude terminal optimization --------------------------
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*claudecode*",
  callback = function()
    vim.opt_local.scrollback = 10000 -- High scrollback for unlimited feel
    vim.opt_local.wrap = true        -- Fix text wrapping
    vim.opt_local.linebreak = true   -- Break at word boundaries
  end,
  desc = "Claude Code terminal buffer settings"
})

-- claude auto-focus -------------------------------------
-- NOTE: skips auto-focus if diff view is open (claudecode diff approval pending)
vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("ClaudeAutoFocus", { clear = true }),
  callback = function()
    vim.schedule(function()
      -- NOTE: skip auto-focus if any window is in diff mode (diff approval pending)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.wo[win].diff then
          return -- Don't switch focus, diff view is active
        end
      end

      -- NOTE: find and focus Claude terminal
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        -- NOTE: claudecode terminals are named "term://...claude..."
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

-- silent auto-reload with three-way merge ---------------
-- NOTE: merges external changes while preserving unsaved edits
--       your edits + Claude's edits = both preserved (if on different lines)
--       when both edit the same line: you win, conflict is notified

local reload_group = vim.api.nvim_create_augroup("SmartAutoReload", { clear = true })

-- NOTE: store base content and mtime when buffer is loaded
vim.api.nvim_create_autocmd("BufReadPost", {
  group = reload_group,
  callback = function(ev)
    vim.b[ev.buf].base_lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(ev.buf))
    vim.b[ev.buf].last_mtime = stat and stat.mtime.sec
  end,
})

-- NOTE: update base when you save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = reload_group,
  callback = function(ev)
    vim.b[ev.buf].base_lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
    local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(ev.buf))
    vim.b[ev.buf].last_mtime = stat and stat.mtime.sec
  end,
})

-- NOTE: check if two hunks overlap (conflict)
local function hunks_overlap(h1, h2)
  local s1, e1 = h1[1], h1[1] + math.max(h1[2] - 1, 0)
  local s2, e2 = h2[1], h2[1] + math.max(h2[2] - 1, 0)
  return s1 <= e2 and s2 <= e1
end

-- NOTE: check for external changes and merge
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = reload_group,
  callback = function(ev)
    local buf = ev.buf
    if vim.bo[buf].buftype ~= "" then return end

    local fname = vim.api.nvim_buf_get_name(buf)
    if fname == "" then return end

    local stat = vim.uv.fs_stat(fname)
    if not stat then return end

    -- NOTE: check mtime
    local disk_mtime = stat.mtime.sec
    if vim.b[buf].last_mtime == disk_mtime then return end
    vim.b[buf].last_mtime = disk_mtime

    local base = vim.b[buf].base_lines
    local disk_lines = vim.fn.readfile(fname)
    if not base or not disk_lines then return end

    local base_text = table.concat(base, "\n")
    local disk_text = table.concat(disk_lines, "\n")
    if base_text == disk_text then return end

    -- NOTE: compute user's changes (base > buffer)
    local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local buf_text = table.concat(buf_lines, "\n")
    local user_hunks = vim.diff(base_text, buf_text, { result_type = "indices" }) or {}

    -- NOTE: compute Claude's changes (base > disk)
    local claude_hunks = vim.diff(base_text, disk_text, { result_type = "indices" }) or {}
    if #claude_hunks == 0 then return end

    -- NOTE: apply Claude's changes, skipping conflicts (user wins)
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

    -- NOTE: update base to new disk content
    vim.b[buf].base_lines = disk_lines

    -- NOTE: notify
    local msg = "Merged: " .. vim.fn.fnamemodify(fname, ":t")
    if skipped > 0 then
      msg = msg .. " (" .. skipped .. " conflict" .. (skipped > 1 and "s" or "") .. " - yours kept)"
    end
    vim.notify(msg, skipped > 0 and vim.log.levels.WARN or vim.log.levels.INFO)
  end,
  desc = "Silent auto-reload with three-way merge (user wins conflicts)"
})

-- smart auto-reload with conflict detection ----------------
-- NOTE: disabled, uncomment to enable (replaces the three-way merge above)
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
--             "CONFLICT DETECTED\n\n" ..
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

-- silent swap handling with auto-recover -------------------
-- NOTE: never shows E325 prompt, never requires user decision
--       dead process + swap newer than file > auto-recover (crash protection)
--       dead process + swap older than file > delete stale swap
--       alive process > just edit (another nvim has the file)
-- v:swapchoice options: 'o'=readonly, 'e'=edit, 'r'=recover, 'd'=delete, 'q'=quit
vim.api.nvim_create_autocmd("SwapExists", {
  group = vim.api.nvim_create_augroup("SmartSwapfile", { clear = true }),
  callback = function()
    local info = vim.fn.swapinfo(vim.v.swapname)
    local pid = info.pid or 0

    local process_running = false
    if pid > 0 then
      process_running = vim.fn.system("kill -0 " .. pid .. " 2>/dev/null; echo $?"):gsub("%s+", "") == "0"
    end

    if process_running then
      vim.v.swapchoice = "e"
    else
      -- check if swap has unsaved changes worth recovering
      local swap_mtime = vim.fn.getftime(vim.v.swapname)
      local file_mtime = vim.fn.getftime(vim.fn.expand("<afile>"))
      if swap_mtime > file_mtime then
        vim.v.swapchoice = "r"
        vim.schedule(function()
          vim.notify("Recovered unsaved changes from swap file", vim.log.levels.WARN)
        end)
      else
        vim.v.swapchoice = "d"
      end
    end
  end,
  desc = "Silent swap handling with auto-recover",
})
