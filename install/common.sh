#!/usr/bin/env bash
# Shared utilities for dotfiles install scripts

# Auto-detect script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Message functions
error()   { echo -e "${RED}✗${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }
info()    { echo -e "${BLUE}::${NC} $1"; }
header()  { echo; echo -e "${BLUE}$1${NC}"; echo; }

# Dependencies: "name:type"
# type: required, optional, special
DEPENDENCIES=(
    "git:required"
    "brew:required"
    "fzf:required"
    "starship:required"
    "zoxide:required"
    "eza:required"
    "mise:required"
    "antidote:special"
    "op:optional"
    "orbstack:optional"
    "gh:optional"
    "gh-dash:special"
    "1password-agent:special"
)

# Symlink configuration: source_path -> target_path
# Paths are relative to DOTFILES_DIR and use $HOME or $XDG_CONFIG_HOME
SYNLINKS=(
    "zsh/main.zshenv:$HOME/.zshenv"
    "zsh/.zshenv:$XDG_CONFIG_HOME/zsh/.zshenv"
    "zsh/.zprofile:$XDG_CONFIG_HOME/zsh/.zprofile"
    "zsh/.zshrc:$XDG_CONFIG_HOME/zsh/.zshrc"
    "zsh/.zsh_plugins.txt:$XDG_CONFIG_HOME/zsh/.zsh_plugins.txt"
    "zsh/aliases.zsh:$XDG_CONFIG_HOME/zsh/aliases.zsh"
    "zsh/functions.zsh:$XDG_CONFIG_HOME/zsh/functions.zsh"
    "git/.gitconfig:$XDG_CONFIG_HOME/git/config"
    "starship/starship.toml:$XDG_CONFIG_HOME/starship.toml"
    "ghostty/config:$XDG_CONFIG_HOME/ghostty/config"
    "opencode/ghostty.json:$XDG_CONFIG_HOME/opencode/themes/ghostty.json"
    "gh-dash/config.yml:$XDG_CONFIG_HOME/gh-dash/config.yml"
)

# Get version for a command
# Each command has different output format, handled individually
get_version() {
    local cmd="$1"
    local version=""
    
    case "$cmd" in
        git)
            version=$(git --version 2>/dev/null | cut -d' ' -f3)
            ;;
        brew)
            version=$(brew --version 2>/dev/null | head -n1 | cut -d' ' -f2)
            ;;
        fzf)
            version=$(fzf --version 2>/dev/null | cut -d' ' -f1)
            ;;
        starship)
            version=$(starship --version 2>/dev/null | head -n1 | awk '{print $2}')
            ;;
        zoxide)
            version=$(zoxide --version 2>/dev/null | awk '{print $2}')
            ;;
        eza)
            version=$(eza --version 2>/dev/null | sed -n '2p' | awk '{print $1}' | sed 's/^v//')
            ;;
        op)
            version=$(op --version 2>/dev/null)
            ;;
        orbstack)
            version=$(orbstack version 2>/dev/null | head -n1)
            ;;
        mise)
            version=$(mise --version 2>/dev/null | head -n1 | awk '{print $1}')
            ;;
        gh)
            version=$(gh --version 2>/dev/null | head -n1 | cut -d' ' -f3)
            ;;
    esac
    
    echo "$version"
}

# Create symlinks based on SYNLINKS configuration
create_symlinks() {
    local dry_run="${1:-false}"
    local backup_dir="${2:-$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)}"
    local dotfiles_dir="${3:-$(dirname "$SCRIPT_DIR")}"

    for link in "${SYNLINKS[@]}"; do
        IFS=':' read -r source target <<< "$link"
        local source_path="$dotfiles_dir/$source"
        
        # Create parent directory
        mkdir -p "$(dirname "$target")"
        
        # Already correctly linked
        if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source_path" ]]; then
            success "Already linked: $target"
            continue
        fi
        
        # Backup existing file (not symlink)
        if [[ -e "$target" && ! -L "$target" ]]; then
            mkdir -p "$backup_dir"
            mv "$target" "$backup_dir/"
            warn "Backed up: $target"
        fi
        
        # Remove incorrect symlink
        [[ -L "$target" ]] && rm "$target"
        
        # Create symlink
        if [[ "$dry_run" == "true" ]]; then
            info "[dry-run] Would link: $source_path -> $target"
        else
            ln -s "$source_path" "$target"
            success "Linked: $target"
        fi
    done
    
    if [[ -d "$backup_dir" ]]; then
        info "Backups: $backup_dir"
    fi
}
