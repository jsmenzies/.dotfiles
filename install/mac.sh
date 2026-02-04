#!/usr/bin/env bash
set -e

# Auto-detect dotfiles directory (parent of where this script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(dirname "$SCRIPT_DIR")}"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}::${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }

create_symlink() {
    local source="$1" target="$2"

    # Already correctly linked
    if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]]; then
        success "Already linked: $target"
        return
    fi

    # Backup existing file (not symlink)
    if [[ -e "$target" && ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
        warn "Backed up: $target"
    fi

    # Remove incorrect symlink
    [[ -L "$target" ]] && rm "$target"

    # Create parent directory
    mkdir -p "$(dirname "$target")"

    # Create symlink
    if $DRY_RUN; then
        info "[dry-run] Would link: $source -> $target"
    else
        ln -s "$source" "$target"
        success "Linked: $target"
    fi
}

main() {
    [[ "$1" == "--dry-run" || "$1" == "-n" ]] && DRY_RUN=true && warn "Dry run mode"

    # Verify XDG directories are set
    info "Verifying XDG directories..."
    if ! "$SCRIPT_DIR/verify-xdg.sh"; then
        exit 1
    fi
    echo

    echo "Installing dotfiles..."
    echo

    # ZSH - minimal .zshenv in home sets ZDOTDIR
    create_symlink "$DOTFILES_DIR/zsh/main.zshenv" "$HOME/.zshenv"

    # ZSH - actual configs in ZDOTDIR (~/.config/zsh)
    create_symlink "$DOTFILES_DIR/zsh/.zshenv" "$XDG_CONFIG_HOME/zsh/.zshenv"
    create_symlink "$DOTFILES_DIR/zsh/.zprofile" "$XDG_CONFIG_HOME/zsh/.zprofile"
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"
    create_symlink "$DOTFILES_DIR/zsh/.zsh_plugins.txt" "$XDG_CONFIG_HOME/zsh/.zsh_plugins.txt"
    create_symlink "$DOTFILES_DIR/zsh/aliases.zsh" "$XDG_CONFIG_HOME/zsh/aliases.zsh"
    create_symlink "$DOTFILES_DIR/zsh/functions.zsh" "$XDG_CONFIG_HOME/zsh/functions.zsh"

    # Git
    create_symlink "$DOTFILES_DIR/git/.gitconfig" "$XDG_CONFIG_HOME/git/config"

    # Starship (direct in .config)
    create_symlink "$DOTFILES_DIR/starship/starship.toml" "$XDG_CONFIG_HOME/starship.toml"

    # Ghostty (in subfolder)
    create_symlink "$DOTFILES_DIR/ghostty/config" "$XDG_CONFIG_HOME/ghostty/config"

    # OpenCode theme only
    create_symlink "$DOTFILES_DIR/opencode/ghostty.json" "$XDG_CONFIG_HOME/opencode/themes/ghostty.json"

    echo
    [[ -d "$BACKUP_DIR" ]] && info "Backups: $BACKUP_DIR"
    echo "Done!"

    # Verify required dependencies are installed
    if ! "$SCRIPT_DIR/verify-dependencies.sh"; then
        exit 1
    fi
    echo
}

main "$@"
