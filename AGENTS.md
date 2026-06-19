# AGENTS.md — dotfiles

## Structure

GNU Stow-managed dotfiles. Each top-level directory is a Stow package
containing files relative to `$HOME` (`.stowrc` sets `--target=$HOME`).

```
stow --restow --adopt <pkg>   # symlink a package (adopt = overwrite local)
stow --delete <pkg>           # remove symlinks
install.sh stow               # all packages at once
install.sh stow <pkg>         # single package
install.sh unstow             # remove all
install.sh brew               # Homebrew bundle + Xcode CLT + JDK links (macOS)
install.sh apk                # Alpine package install (Linux)
```

Packages: bat, fd, ghostty, git, homebrew, keeb, lazygit, nvim, ssh,
tmux, zsh. macOS-only: finicky, karabiner.

## Theming

`~/.colorscheme` stores the current theme name (just a string). The
`theme` command switches it, updates Ghostty's config via `sed`, and
triggers `killall -USR1 ghostty` to reload.

```
theme <name>   # switches theme + reloads Ghostty
```

Theme completions are generated from `ghostty/.config/ghostty/themes/*`
filenames.

## Platform

### macOS / Apple Silicon

Homebrew at `/opt/homebrew` (see `homebrew/Brewfile`). Uses macOS tools:
`pbcopy`, `reattach-to-user-namespace`, `xcode-select`.

### Alpine Linux (WSL)

- Package manager: `apk` (see `alpine-packages` at repo root)
- Clipboard: `xclip` (Wayland: `wl-clipboard`)
- File watch: `inotify-tools` replaces macOS `fswatch`
- `zoxide` replaces `z`
- Homebrew (Linuxbrew) at `/home/linuxbrew/.linuxbrew` if installed

## Zsh

- `.zprofile` → brew shellenv (multi-path fallback) + pyenv init (guarded)
- `.zshrc` → aliases, exports, prompt, fzf+z/zoxide
- Functions in `.zsh/functions/` autoloaded by name
- Prompt shows vcs_info (git), venv, elapsed time, shell level
- `gsw` — fuzzy git branch switch
- `ts` — tmux session manager (uses `z`/`zoxide` for directory history)

## Neovim

- lazy.nvim plugin manager, spec in `lua/plugins/`
- LSP: lua_ls, pyright, terraformls enabled
- Leader: space, comma enters command mode
- Colorscheme: rose-pine

## Tmux

- Prefix: `C-a`
- Vim-style pane nav (h/j/k/l), resize (H/J/K/L)
- Lazygit popup: `<prefix> g`
- Session chooser: `<prefix> s`
- System clipboard via `reattach-to-user-namespace pbcopy` (macOS) or
  `xclip` (Linux), selected at runtime with `if-shell`
- Base index 1, renumber on delete, focus-events on
- New windows/panes inherit working directory

## Ghostty

- Config at `ghostty/.config/ghostty/config`
- Themes in `ghostty/.config/ghostty/themes/`
- Theme switching via `theme` command (writes to `~/.colorscheme`, updates
  `config`, sends `SIGUSR1` to reload)
- macOS-only application (not stowed on Linux)

## Git

- Work config: `includeIf "gitdir:~/code/work/"` → `~/code/work/.gitconfig`
- Credential: `gh auth git-credential` (via PATH)
- Merge tool: nvim with `Gdiffsplit!`, conflict style `zdiff3`
- Aliases: `git root` (toplevel), `git pushf` (force-with-lease)
- `push.autoSetupRemote = true`, `pull.rebase = true`
- Global gitignore: `.DS_Store`, `.python-version`
