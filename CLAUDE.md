# Neovim Configuration (LazyVim)

Neovim 0.11+ with LazyVim on macOS. TokyoNight theme with transparency.

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point, bootstraps lazy.nvim
├── lua/config/
│   ├── lazy.lua               # lazy.nvim bootstrap + LazyVim extras imports
│   ├── options.lua            # Vim options (loaded before lazy.nvim)
│   ├── keymaps.lua            # Custom keybindings (VeryLazy)
│   └── autocmds.lua           # Autocommands (VeryLazy)
├── lua/plugins/
│   ├── custom.lua             # New plugins not part of LazyVim
│   ├── modify.lua             # Override LazyVim plugin defaults + LSP + theme
│   └── disable.lua            # Disable unwanted LazyVim defaults
└── lua/util/
    └── functions.lua          # Shared utility functions
```

## File Conventions

- **custom.lua** -- new plugins only (not in LazyVim)
- **modify.lua** -- override/extend LazyVim defaults (LSP, theme, snacks, completion, etc.)
- **disable.lua** -- `{ "plugin", enabled = false }` entries only
- **lazy.lua** -- LazyVim extras imports (treesitter-context, inc-rename, dap.core, test.core)
- All files have V logo comment headers (22 lines) -- preserve them on edits
- Section headers use `-- title text ----...----` format (~56 chars)
- Each plugin spec has a one-line comment above it: `-- what it does (how to use)`
- No emojis in code files (diagnostic icons use nerdfont glyphs)

## Key Architecture Decisions

- **Theme**: TokyoNight (not Kanagawa) with custom diff/cursor colors in modify.lua
- **File explorer**: oil.nvim is primary (`<leader>e`), neo-tree exists only for ClaudeCodeTreeAdd
- **Notifications**: snacks.notifier (nvim-notify and persistence.nvim both disabled)
- **Session**: persisted.nvim (persistence.nvim disabled), git branch aware
- **Completion**: blink.cmp with super-tab behavior
- **Picker**: fzf-lua (not telescope), set via `vim.g.lazyvim_picker = "fzf"`
- **Formatting**: conform.nvim with stylua, shfmt, prettier
- **Diagnostics**: virtual text disabled, using tiny-inline-diagnostic.nvim instead
- **Cursor animation**: smear-cursor.nvim (beacon.nvim disabled, unmaintained)
- **Markdown**: render-markdown.nvim (markview.nvim disabled, conceallevel=0 conflict)
- **Indent guides**: snacks indent + scope (mini.indentscope disabled)
- **Winbar**: incline.nvim floating filename labels (dropbar.nvim disabled)
- **Statusline**: lualine with smart tilde-relative path + progressive truncation
- **Swap files**: auto-recover from swap (no auto-save plugin, manual save only)
- **Borders**: `vim.o.winborder = "rounded"` globally, noice views overridden to match
- **Providers**: perl/ruby disabled, node/python3 kept

## Common Gotchas (lazy.nvim)

- `config = function() require("x").setup() end` **overrides** `opts = {}` -- use one or the other, not both
- `version = "*"` conflicts with LazyVim's `version = false` global policy -- don't use it
- Short plugin names (e.g., `"lualine.nvim"`) are ambiguous -- always use `"owner/repo"`
- LazyVim extras must be imported in `lazy.lua`, not in plugin files (load order matters)
- Duplicate Lua table keys silently use the last value -- easy to miss

## Testing

### Quick validation (headless, no UI)
```bash
# Syntax + config load check (fastest, use after every edit)
nvim --headless -c 'lua print("Config OK")' -c 'qa' 2>&1

# Check for Lua errors in startup
nvim --headless -c 'messages' -c 'qa' 2>&1

# Verify a specific plugin loads
nvim --headless -c 'lua print(require("snacks") and "snacks OK")' -c 'qa' 2>&1
```

### Interactive testing (tmux, full UI)
Use the `temp-tmux` skill for isolated tmux testing. Key patterns:

```bash
# Setup isolated tmux
tmux -L claude-test kill-server 2>/dev/null
tmux -L claude-test new-session -d -s test -x 160 -y 50

# Launch nvim and wait for plugins
tmux -L claude-test send-keys -t test "nvim ~/.config/nvim/lua/config/options.lua" Enter
sleep 4

# Capture screen
tmux -L claude-test capture-pane -t test -p

# Check :messages for errors
tmux -L claude-test send-keys -t test ":messages" Enter
sleep 1
tmux -L claude-test capture-pane -t test -p

# Check plugin status
tmux -L claude-test send-keys -t test ":Lazy" Enter
sleep 2
tmux -L claude-test capture-pane -t test -p

# Test specific features
tmux -L claude-test send-keys -t test "q"          # close Lazy
tmux -L claude-test send-keys -t test ":IncRename " # test inc-rename
tmux -L claude-test send-keys -t test Escape

# Cleanup (always do this)
tmux -L claude-test send-keys -t test ":qa!" Enter
sleep 1
tmux -L claude-test kill-server
```

### What to verify after changes
- `nvim --headless` -- clean exit, no errors (always)
- `:Lazy` -- all plugins load, no errors (after plugin changes)
- `:Mason` -- LSP servers installed (after LSP changes)
- `:checkhealth` -- no critical warnings (periodically)
- Specific keymaps work (after keymap changes)
- Diff mode: `]c`/`[c` jump hunks, `]x`/`[x` change list (after keymap changes)

## Key Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `,k` / `,o` / `,m` / `,c` | n | Edit keymaps/options/modify/custom |
| `<leader>e` | n | Oil file explorer |
| `<leader>S` | n | Save file |
| `<leader>Q` | n | Quit all (confirms unsaved) |
| `<leader>o` | n | Close all other windows |
| `<leader>gw` | n | Diff windows (windo diffthis) |
| `<leader>gd` | n | Diff off |
| `<leader>gD` | n | Dotfiles in Neogit |
| `<leader>gg` | n | Neogit |
| `<leader>r` | n | Reload config |
| `<leader>rg` | n | Live grep (hidden files) |
| `<leader>cc` | n | Toggle colorizer |
| `<leader>t` | n | Toggle undotree |
| `<C-S>` / `<D-s>` | n,v,i | Save file |
| `]x` / `[x` | n | Next/prev change (edit list) |

## Claude Code Integration

- claudecode.nvim for terminal + diff view (`<leader>aC` toggle, `<leader>\` start)
- Server mode: `nvim --listen /tmp/nvim` (aliased as `vl`)
- `vim.o.winborder = "rounded"` for global float borders (noice views also overridden to match)
- `util/functions.lua` has ClaudeFeedback and ClaudeCleanup helpers

## When Editing This Config

1. Read the file first -- understand existing patterns before changing
2. Run `nvim --headless` after every edit to catch syntax errors
3. Comment out removed code with explanation (don't delete)
4. Keep one-line plugin comments and section headers consistent
5. Preserve V logo headers (22-line blocks at top of each file)
6. No emojis in code files
7. Test keymaps interactively if changed (tmux skill)
