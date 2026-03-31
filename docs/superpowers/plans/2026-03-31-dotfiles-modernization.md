# Dotfiles Modernization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure a flat dotfiles repo into a GNU Stow layout, tracking only actively used tools (zsh, nvim/lazyvim, zellij, ghostty, git) with environment-specific values separated into gitignored `.local` files.

**Architecture:** Each tool gets its own Stow package directory mirroring the target path from `$HOME`. Config files are copied from their current locations on disk, cleaned of machine-specific content, and symlinked back via `stow`. Legacy configs (tmux, vim, old init.lua) are deleted.

**Tech Stack:** GNU Stow, zsh, neovim/LazyVim, zellij, ghostty, git

**Spec:** `docs/superpowers/specs/2026-03-31-dotfiles-modernization-design.md`

---

### Task 1: Remove legacy files and create repo scaffolding

**Files:**
- Delete: `.vimrc`, `.tmux.conf`, `.tmux.statusline`, `init.lua` (repo root)
- Create: `.gitignore`, `.stow-local-ignore`

- [ ] **Step 1: Remove legacy files from git**

```bash
cd /Users/ds/dotfiles
git rm .vimrc .tmux.conf .tmux.statusline init.lua .zshrc
```

- [ ] **Step 2: Create `.gitignore`**

Create `/Users/ds/dotfiles/.gitignore`:

```gitignore
# Machine-specific local overrides
.zshrc.local
.gitconfig.local

# Generated/binary files
**/lazy-lock.json
**/vim-zellij-navigator.wasm

# Stow internal
.stow-local-ignore
```

- [ ] **Step 3: Create `.stow-local-ignore`**

Create `/Users/ds/dotfiles/.stow-local-ignore`:

```
README.md
docs
.git
.gitignore
.claude
```

- [ ] **Step 4: Commit**

```bash
git add .gitignore .stow-local-ignore
git commit -m "remove legacy configs, add repo scaffolding

Delete .vimrc, .tmux.conf, .tmux.statusline, and standalone init.lua.
Add .gitignore and .stow-local-ignore for GNU Stow layout."
```

---

### Task 2: Create zsh package

**Files:**
- Create: `zsh/.zshrc` (copied from repo's `.zshrc`, then cleaned)
- Create: `zsh/.zimrc` (copied from `~/.zimrc`)

- [ ] **Step 1: Create directory and move zshrc**

```bash
mkdir -p /Users/ds/dotfiles/zsh
```

Copy `~/.zshrc` to `zsh/.zshrc` (the repo copy was removed by `git rm` but the live file at `~/.zshrc` is separate and unaffected).

- [ ] **Step 2: Clean up `zsh/.zshrc`**

Remove these lines:

```
# specific to Arch
alias pacman='sudo pacman'
alias hyprconf='vim ~/.config/hypr/hyprland.conf'
# . "$HOME/.local/bin/env"
```

Add at the end of the file (after the starship eval line):

```zsh

# Machine-specific config (OS aliases, work env, secrets, PATH overrides)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
```

- [ ] **Step 3: Copy zimrc**

Copy `~/.zimrc` to `zsh/.zimrc`. No modifications needed — the file is already portable.

- [ ] **Step 4: Commit**

```bash
git add zsh/
git commit -m "add zsh stow package

Track .zshrc (cleaned of Arch-specific aliases) and .zimrc.
Environment-specific config goes in ~/.zshrc.local."
```

---

### Task 3: Create git package

**Files:**
- Create: `git/.gitconfig` (new, portable subset)
- Create: `git/.config/git/ignore` (copied from `~/.config/git/ignore`)

- [ ] **Step 1: Create directory structure**

```bash
mkdir -p /Users/ds/dotfiles/git/.config/git
```

- [ ] **Step 2: Create `git/.gitconfig`**

Create `/Users/ds/dotfiles/git/.gitconfig`:

```gitconfig
[core]
  editor = nvim -f
[include]
  path = ~/.gitconfig.local
```

Note: `[user]` name/email intentionally omitted — goes in `~/.gitconfig.local` per machine.

- [ ] **Step 3: Copy global gitignore**

Copy `~/.config/git/ignore` to `git/.config/git/ignore`. Preserve existing content:

```
**/.claude/settings.local.json
```

- [ ] **Step 4: Commit**

```bash
git add git/
git commit -m "add git stow package

Track portable .gitconfig (editor, include pattern) and global gitignore.
User identity goes in ~/.gitconfig.local (not tracked)."
```

---

### Task 4: Create nvim package

**Files:**
- Create: `nvim/.config/nvim/init.lua` (cleaned — bootstrap only)
- Create: `nvim/.config/nvim/lazyvim.json` (copied)
- Create: `nvim/.config/nvim/.neoconf.json` (copied)
- Create: `nvim/.config/nvim/stylua.toml` (copied)
- Create: `nvim/.config/nvim/lua/config/lazy.lua` (copied)
- Create: `nvim/.config/nvim/lua/config/autocmds.lua` (copied)
- Create: `nvim/.config/nvim/lua/config/keymaps.lua` (populated with keymaps from init.lua)
- Create: `nvim/.config/nvim/lua/config/options.lua` (populated with clipboard option)
- Create: `nvim/.config/nvim/lua/plugins/zellij-navigation.lua` (copied)

Source: `~/.config/nvim/` (live LazyVim config on disk)

- [ ] **Step 1: Create directory structure**

```bash
mkdir -p /Users/ds/dotfiles/nvim/.config/nvim/lua/config
mkdir -p /Users/ds/dotfiles/nvim/.config/nvim/lua/plugins
```

- [ ] **Step 2: Copy config files from `~/.config/nvim/`**

Copy these files directly (no modifications):
- `~/.config/nvim/lazyvim.json` -> `nvim/.config/nvim/lazyvim.json`
- `~/.config/nvim/.neoconf.json` -> `nvim/.config/nvim/.neoconf.json`
- `~/.config/nvim/stylua.toml` -> `nvim/.config/nvim/stylua.toml`
- `~/.config/nvim/lua/config/lazy.lua` -> `nvim/.config/nvim/lua/config/lazy.lua`
- `~/.config/nvim/lua/config/autocmds.lua` -> `nvim/.config/nvim/lua/config/autocmds.lua`
- `~/.config/nvim/lua/plugins/zellij-navigation.lua` -> `nvim/.config/nvim/lua/plugins/zellij-navigation.lua`

Do NOT copy: `.git/`, `.gitignore`, `lazy-lock.json`, `lua/plugins/example.lua`, `LICENSE`, `README.md`

- [ ] **Step 3: Create cleaned `nvim/.config/nvim/init.lua`**

The current `~/.config/nvim/init.lua` has the LazyVim bootstrap require plus custom keymaps and clipboard settings. Strip it to just the bootstrap:

```lua
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
```

- [ ] **Step 4: Populate `nvim/.config/nvim/lua/config/keymaps.lua`**

Move the custom keymaps from the current `~/.config/nvim/init.lua` into this file. Write:

```lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- gsub string that's under cursor
vim.keymap.set("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/", { noremap = true })

-- space to unhighlight searches
vim.keymap.set("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", { noremap = true, silent = true })

-- Toggle line numbers
vim.keymap.set("n", "<F2>", ":set nonumber!<CR>", { noremap = true })

-- Quick save and quit
vim.keymap.set("n", ",s", ":w<CR>", { noremap = true })
vim.keymap.set("n", ",q", ":wq<CR>", { noremap = true })

-- Edit file in current directory
vim.keymap.set("n", "<Leader>e", ':e <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Vertical split in current directory
vim.keymap.set("n", "<Leader>v", ':vsp <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Horizontal split in current directory
vim.keymap.set("n", "<Leader>p", ':sp <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Yank to system clipboard
vim.keymap.set("", "<Leader>c", '"+y', { noremap = true })
```

- [ ] **Step 5: Populate `nvim/.config/nvim/lua/config/options.lua`**

```lua
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "unnamedplus"
```

- [ ] **Step 6: Commit**

```bash
git add nvim/
git commit -m "add nvim stow package

Absorb LazyVim config from ~/.config/nvim/ (drops its .git history).
Move custom keymaps to lua/config/keymaps.lua and clipboard option
to lua/config/options.lua. Drop example.lua boilerplate."
```

---

### Task 5: Create zellij package

**Files:**
- Create: `zellij/.config/zellij/config.kdl` (copied from `~/.config/zellij/config.kdl`, cleaned)

- [ ] **Step 1: Create directory and copy config**

```bash
mkdir -p /Users/ds/dotfiles/zellij/.config/zellij
```

Copy `~/.config/zellij/config.kdl` to `zellij/.config/zellij/config.kdl`.

- [ ] **Step 2: Clean up config.kdl**

Remove the autogenerated header (first 3 lines of the file):

```
//
// THIS FILE WAS AUTOGENERATED BY ZELLIJ, THE PREVIOUS FILE AT THIS LOCATION WAS COPIED TO: /Users/ds/.config/zellij/config.kdl.bak.1
//
```

Do NOT copy `config.kdl.bak`, `config.kdl.bak.1`, or the `plugins/` directory (contains binary `.wasm` file).

- [ ] **Step 3: Commit**

```bash
git add zellij/
git commit -m "add zellij stow package

Track config.kdl with autogenerated header removed.
vim-zellij-navigator.wasm plugin is gitignored (download manually)."
```

---

### Task 6: Create ghostty package

**Files:**
- Create: `ghostty/.config/ghostty/config` (copied from `~/.config/ghostty/config`)

- [ ] **Step 1: Create directory and copy config**

```bash
mkdir -p /Users/ds/dotfiles/ghostty/.config/ghostty
```

Copy `~/.config/ghostty/config` to `ghostty/.config/ghostty/config`. No modifications needed — the file is already portable:

```
theme = Catppuccin Macchiato
font-family = Droid Sans Mono
font-thicken = true

window-padding-x = 10
window-padding-y = 10
```

- [ ] **Step 2: Commit**

```bash
git add ghostty/
git commit -m "add ghostty stow package"
```

---

### Task 7: Write README

**Files:**
- Create: `README.md`

- [ ] **Step 1: Write README.md**

Create `/Users/ds/dotfiles/README.md`:

```markdown
# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Tools

| Tool | Description |
|---|---|
| [zsh](https://www.zsh.org/) + [zim](https://zimfw.sh/) | Shell and plugin framework |
| [neovim](https://neovim.io/) + [LazyVim](https://www.lazyvim.org/) | Editor |
| [zellij](https://zellij.dev/) | Terminal multiplexer |
| [ghostty](https://ghostty.org/) | Terminal emulator |
| [starship](https://starship.rs/) | Shell prompt |
| [git](https://git-scm.com/) | Version control config |

## Prerequisites

Install the tools:

```bash
brew install neovim zellij ghostty starship zsh stow
```

Install [zim](https://zimfw.sh/):

```bash
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

## Usage

Clone and stow:

```bash
git clone https://github.com/<you>/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow zsh nvim zellij ghostty git
```

This creates symlinks from your home directory into the repo. For example, `stow zsh` symlinks `~/dotfiles/zsh/.zshrc` to `~/.zshrc`.

To remove symlinks for a package:

```bash
stow -D zsh
```

### Existing machine

If config files already exist as real files (not symlinks), remove or back them up before stowing — Stow won't overwrite existing files:

```bash
# back up, then stow
mv ~/.zshrc ~/.zshrc.bak
stow zsh
```

## Post-install setup

### Machine-specific config

Create `~/.zshrc.local` for OS-specific aliases, work env vars, PATH overrides, secrets:

```bash
# Example: macOS
export PATH="/opt/homebrew/bin:$PATH"

# Example: Arch
alias pacman='sudo pacman'
```

Create `~/.gitconfig.local` for your git identity:

```gitconfig
[user]
  name = Your Name
  email = you@example.com
```

### Zellij plugin

Download the vim-zellij-navigator plugin:

```bash
mkdir -p ~/.config/zellij/plugins
curl -L https://github.com/hiasr/vim-zellij-navigator/releases/latest/download/vim-zellij-navigator.wasm \
  -o ~/.config/zellij/plugins/vim-zellij-navigator.wasm
```

## How Stow works

Each top-level directory is a "package" that mirrors the target directory structure from `$HOME`. When you run `stow <package>`, it creates symlinks in `$HOME` pointing to the files in the package directory.

```
dotfiles/zsh/.zshrc  -->  ~/.zshrc (symlink)
dotfiles/nvim/.config/nvim/  -->  ~/.config/nvim (symlink)
```

Stow is declarative and safe — it won't overwrite existing files and will warn about conflicts.
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "add README with setup instructions"
```

---

### Task 8: Migrate this machine (stow all packages)

This task creates the symlinks on the current machine by removing existing real files and running `stow`.

- [ ] **Step 1: Back up and remove existing config files**

These real files will be replaced by symlinks:

```bash
# zsh
mv ~/.zshrc ~/.zshrc.bak
mv ~/.zimrc ~/.zimrc.bak

# git
mv ~/.gitconfig ~/.gitconfig.bak

# nvim (remove the entire directory — stow will create the symlink tree)
mv ~/.config/nvim ~/.config/nvim.bak

# zellij
mv ~/.config/zellij/config.kdl ~/.config/zellij/config.kdl.prestow

# ghostty
mv ~/.config/ghostty/config ~/.config/ghostty/config.bak
```

- [ ] **Step 2: Stow all packages**

```bash
cd /Users/ds/dotfiles
stow zsh nvim zellij ghostty git
```

- [ ] **Step 3: Create `.gitconfig.local` with current identity**

Create `~/.gitconfig.local`:

```gitconfig
[user]
  name = Dennis Shy
  email = dennisyshy@gmail.com
```

- [ ] **Step 4: Verify symlinks**

```bash
ls -la ~/.zshrc ~/.zimrc ~/.gitconfig
ls -la ~/.config/nvim ~/.config/zellij/config.kdl ~/.config/ghostty/config
```

All should be symlinks pointing into `~/dotfiles/`.

- [ ] **Step 5: Verify shell loads correctly**

```bash
zsh -i -c 'echo "shell OK"'
```

- [ ] **Step 6: Clean up backups (optional, manual)**

Once verified, the `.bak` files can be removed. Do not automate this — let the user decide.

- [ ] **Step 7: Commit any final state**

```bash
cd /Users/ds/dotfiles
git status
# If clean, nothing to do. If .gitconfig.local appears, verify it's gitignored.
```
