#!/usr/bin/env bash
set -e

# Source shared utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

DRY_RUN=false
[[ "$1" == "--dry-run" || "$1" == "-n" ]] && DRY_RUN=true && warn "Dry run mode"

# Verify XDG directories are set
info "Verifying XDG directories..."
if ! "$SCRIPT_DIR/verify-xdg.sh"; then
    exit 1
fi

header "Installing dotfiles"

# Create all symlinks
DOTFILES_DIR="${DOTFILES_DIR:-$(dirname "$SCRIPT_DIR")}"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
create_symlinks "$DRY_RUN" "$BACKUP_DIR" "$DOTFILES_DIR"


# Verify required dependencies are installed
"$SCRIPT_DIR/verify-dependencies.sh"
