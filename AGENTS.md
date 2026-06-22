# AGENTS.md

This file provides instructions for agents working in this repository.

Be consice and clear in your instructions, brevity over lenghty explanations. Use bullet points and code blocks where appropriate. Don't be verbose and conversational. Focus on the essential information and avoid unnecessary detail. Avoid fillers and fluff.

## Tool Preferences

- Use `rg` (ripgrep) instead of `grep` for content searches.
- Use `fd` instead of `find` for file searches.
- On macOS, prefer GNU versions of tools (`gsed`, `gawk`) over the default BSD versions.

## Repository Structure

This repository contains dotfiles for macOS. Configuration is organized into directories, each corresponding to an application or tool. The configurations are managed and deployed using `stow`.

## Installation and Management

The primary tool for managing this repository is the `install.sh` script.

### Stow and Unstow

To symlink the configurations to your home directory, use `stow`. You can stow all configurations at once or one by one.

- **Stow all configurations:**
  ```bash
  ./install.sh stow
  ```

- **Stow a specific configuration (e.g., `nvim`):**
  ```bash
  ./install.sh stow nvim
  ```

To remove the symlinks, use `unstow`.

- **Unstow all configurations:**
  ```bash
  ./install.sh unstow
  ```

- **Unstow a specific configuration (e.g., `nvim`):**
  ```bash
  ./install.sh unstow nvim
  ```

### Homebrew

The repository uses `homebrew` to manage packages. The `homebrew/Brewfile` contains a list of all packages to be installed.

To install all packages from the `Brewfile`, run:

```bash
./install.sh brew
```

This command will also:
1.  Install Homebrew if it's not already present.
2.  Install Xcode command line tools if they are not already present.
3.  Symlink installed JDKs to `/Library/Java/JavaVirtualMachines`.
