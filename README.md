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
