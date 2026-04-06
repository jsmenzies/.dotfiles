#!/usr/bin/env bash
set -e

# Source shared utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"
source "$SCRIPT_DIR/platform/linux.sh"

DRY_RUN=false
[[ "$1" == "--dry-run" || "$1" == "-n" ]] && DRY_RUN=true && warn "Dry run mode"

BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
run_install "$DRY_RUN" "$BACKUP_DIR"
