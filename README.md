# Dotfiles

Personal configuration files for my Linux setup.

## Contents

Configuration files for:
- Shells (bash/zsh)
- Terminal emulators (Ghostty, WezTerm, Alacritty)
- Development tools (neovim, git)
- Window managers (Hyprland, i3)
- etc

## Installation

Clone the repository to your home directory:

```bash
git clone https://github.com/Seblerr/dotfiles.git
cd dotfiles
```

Use GNU Stow to create symlinks for the configurations you want:

```bash
stow <directory>  # e.g., stow neovim, stow zsh
```

## Structure

Dotfiles are organized by application. Check individual files for specific configuration details and requirements.
