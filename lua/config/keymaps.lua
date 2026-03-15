--  ╭────────────────────────────────────────────────────────────────────────╮
--  │                                                                        │
--  │                       ######                                           │
--  │                     ######                                             │
--  │                    #####                                               │
--  │                    #####                                               │
--  │                    #####                                               │
--  │            ######  #####                                               │
--  │          ######    #####         keymaps.lua                           │
--  │        #######     #####         Custom keybindings (VeryLazy)          │
--  │       ######        ####                                               │
--  │        ######        ###         defaults → lazyvim.config.keymaps     │
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

-- change list navigation --------------------------------
-- NOTE: ]x/[x for change list (g, and g; also work natively)
--       ]c/[c freed for native diff hunk navigation (used in claudecode diffs)
vim.keymap.set("n", "]x", "g,", { desc = "Next change (edit list)" })
vim.keymap.set("n", "[x", "g;", { desc = "Previous change (edit list)" })

-- edit shortcuts ----------------------------------------
vim.keymap.set("n", ",r", ":e ~/.github/README.md<CR>", { silent = true, desc = "Edit .dotfiles README" })
vim.keymap.set("n", ",v", ":e ~/.config/nvim/lua/<CR>", { silent = true, desc = "Edit Neovim" })
vim.keymap.set("n", ",k", ":e ~/.config/nvim/lua/config/keymaps.lua<CR>", { silent = true, desc = "Edit Keymaps" })
vim.keymap.set(
  "n",
  ",c",
  ":e ~/.config/nvim/lua/plugins/custom.lua<CR>",
  { silent = true, desc = "Edit Custom Plugins" }
)
vim.keymap.set(
  "n",
  ",m",
  ":e ~/.config/nvim/lua/plugins/modify.lua<CR>",
  { silent = true, desc = "Edit Modified Plugins" }
)
vim.keymap.set(
  "n",
  ",d",
  ":e ~/.config/nvim/lua/plugins/disable.lua<CR>",
  { silent = true, desc = "Edit Disabled Plugins" }
)
vim.keymap.set("n", ",o", ":e ~/.config/nvim/lua/config/options.lua<CR>", { silent = true, desc = "Edit Options" })
vim.keymap.set("n", ",s", ":e ~/.shell<CR>", { silent = true, desc = "Edit .shell" })
vim.keymap.set("n", ",a", ":e ~/.alias<CR>", { silent = true, desc = "Edit .alias" })
vim.keymap.set("n", ",t", ":e ~/.config/tmux/tmux.conf<CR>", { silent = true, desc = "Edit Tmux" })
vim.keymap.set("n", ",w", ":e ~/.config/wezterm/wezterm.lua<CR>", { silent = true, desc = "Edit Wezterm" })
vim.keymap.set("n", ",y", ":e ~/.yabairc<CR>", { silent = true, desc = "Edit yabai service" })
vim.keymap.set("n", ",sk", ":e ~/.skhdrc<CR>", { silent = true, desc = "Edit skhd service" })

-- diagnostics and debugging -----------------------------
vim.keymap.set("n", "<leader>xm", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(current_buf)
  if buf_name:match("messages") then
    vim.cmd("close")
  else
    vim.cmd("messages")
  end
end, { desc = "Toggle Vim messages (errors)" })
vim.keymap.set("n", "<leader>xh", ":checkhealth<CR>", { desc = "Check Neovim health" })

-- config reload -----------------------------------------
-- NOTE: sources init.lua + keymaps + custom packages via util.functions
vim.keymap.set(
  "n",
  "<leader>r",
  "<cmd>lua require('util.functions').ReloadConfig()<CR>",
  { desc = "Reload Neovim config, keymaps, and custom packages" }
)

-- window navigation -------------------------------------
-- NOTE: extended to visual mode for cross-window comparisons in diff
vim.keymap.set({ "n", "v", "x" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set({ "n", "v", "x" }, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set({ "n", "v", "x" }, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set({ "n", "v", "x" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- save --------------------------------------------------
vim.keymap.set({ "n", "v", "i" }, "<C-S>", "<cmd>update<CR>", { desc = "Save file" })
vim.keymap.set({ "n", "v", "i" }, "<D-s>", "<cmd>update<CR>", { desc = "Save file (GUI)" })
-- NOTE: CSI u encoding (\x1b[115;9u where 115='s', 9=Super modifier)
--       allows Ghostty/Kitty/WezTerm to send Cmd+S without terminal config
vim.keymap.set({ "n", "v", "i" }, "\x1b[115;9u", "<cmd>update<CR>", { desc = "Save file (terminal Cmd+S)" })
-- NOTE: <leader>w freed for LazyVim window prefix
vim.keymap.set("n", "<leader>S", ":update<CR>", { desc = "Save file" })

-- quit --------------------------------------------------
vim.keymap.set("n", "<C-Q>", ":q<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>Q", ":confirm qa<CR>", { desc = "Quit all (confirms unsaved)" })

-- search ------------------------------------------------
-- NOTE: custom ripgrep including hidden files (dotfiles, .env, etc.)
vim.keymap.set("n", "<leader>rg", function()
  require("fzf-lua").live_grep({
    cmd = "rg --column --line-number --no-heading --color=always --smart-case --hidden --follow --iglob !.git/",
  })
end, { desc = "Live grep (include hidden files)" })

-- diff mode ---------------------------------------------
vim.keymap.set("n", "<leader>gw", function()
  vim.cmd("windo diffthis")
end, { noremap = true, desc = "Git diff (w)indows" })
vim.keymap.set("n", "<leader>gd", function()
  vim.cmd("windo diffoff")
end, { noremap = true, desc = "Git diff off" })

-- ui toggles --------------------------------------------
vim.keymap.set("n", "<leader>uH", function()
  vim.g.gentle_hover_disabled = not vim.g.gentle_hover_disabled
  vim.notify("GentleHover " .. (vim.g.gentle_hover_disabled and "disabled" or "enabled"), vim.log.levels.INFO)
end, { desc = "Toggle GentleHover (session)" })

-- windows -----------------------------------------------
vim.keymap.set("n", "<leader>o", ":only<CR>", { desc = "Only window" })
-- NOTE: <leader>aD removed, replaced by <leader>| in claudecode.nvim keys table (custom.lua)

vim.keymap.set("n", "<leader>ww", function()
  require("fzf-lua").tabs()
end, { desc = "Pick window/tab (fzf)" })

-- TODO: yank-with-path for Claude context (uncomment to enable)
--       visual select code, press <leader>yp to copy with file:line info
-- vim.keymap.set("v", "<leader>yp", function()
--   local start_line = vim.fn.line("'<")
--   local end_line = vim.fn.line("'>")
--   local file = vim.fn.expand("%:.")
--   vim.cmd('normal! "vy')
--   local content = vim.fn.getreg("v")
--   local result = string.format("```%s:%d-%d\n%s\n```", file, start_line, end_line, content)
--   vim.fn.setreg("+", result)
--   vim.notify("Yanked with path: " .. file)
-- end, { desc = "Yank with file path for Claude" })
