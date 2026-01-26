#!/usr/bin/env bash
set -e

# Auto-detect dotfiles directory (where this script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$SCRIPT_DIR}"
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

    echo "Installing dotfiles..."
    echo

    # ZSH
    create_symlink "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
    create_symlink "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
    create_symlink "$DOTFILES_DIR/zsh/mac.zshrc" "$HOME/.zshrc"

    # Git
    create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

    # Starship (direct in .config)
    create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

    # Ghostty (in subfolder)
    create_symlink "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

    # OpenCode theme only
    create_symlink "$DOTFILES_DIR/opencode/ghostty.json" "$HOME/.config/opencode/themes/ghostty.json"

    echo
    [[ -d "$BACKUP_DIR" ]] && info "Backups: $BACKUP_DIR"
    echo "Done!"
}

main "$@"
