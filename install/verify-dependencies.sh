#!/usr/bin/env bash
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

error()   { echo -e "${RED}✗${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }
info()    { echo -e "${BLUE}::${NC} $1"; }

echo "Verifying dependencies..."
echo

# Track missing dependencies
MISSING_REQUIRED=()
MISSING_OPTIONAL=()

# Required dependencies
REQUIRED=(
    "git"
    "brew"
    "fzf"
    "starship"
    "zoxide"
    "eza"
    "mise"
    "antidote"
)

# Optional dependencies
OPTIONAL=(
    "op"
    "orbstack"
    "gh"
)

check_command() {
    local cmd="$1"

    if command -v "$cmd" &> /dev/null; then
        local version=""
        case "$cmd" in
            git)
                version="$(git --version | cut -d' ' -f3)"
                ;;
            brew)
                version="$(brew --version | head -n1 | cut -d' ' -f2)"
                ;;
            fzf)
                version="$(fzf --version | cut -d' ' -f1)"
                ;;
            starship)
                version="$(starship --version 2>/dev/null | head -n1 | awk '{print $2}')"
                ;;
            zoxide)
                version="$(zoxide --version 2>/dev/null | awk '{print $2}')"
                ;;
            eza)
                version="$(eza --version 2>/dev/null | sed -n '2p' | awk '{print $1}' | sed 's/^v//')"
                ;;
            op)
                version="$(op --version 2>/dev/null)"
                ;;
            orbstack)
                version="$(orbstack version 2>/dev/null | head -n1 || echo "installed")"
                ;;
            mise)
                version="$(mise --version 2>/dev/null | head -n1 | awk '{print $1}')"
                ;;
            gh)
                version="$(gh --version | head -n1 | cut -d' ' -f3)"
                ;;
            antidote)
                version="$(antidote --version 2>/dev/null | head -n1 | awk '{print $3}')"
                ;;
        esac

        if [[ -n "$version" ]]; then
            success "$cmd v$version"
        else
            success "$cmd"
        fi
        return 0
    else
        return 1
    fi
}

check_1password_agent() {
    local socket="$HOME/.1password/agent.sock"
    if [[ -S "$socket" ]]; then
        success "1password-agent"
        return 0
    else
        return 1
    fi
}

echo "Required dependencies:"
echo

for cmd in "${REQUIRED[@]}"; do
    if ! check_command "$cmd"; then
        error "$cmd - NOT FOUND"
        MISSING_REQUIRED+=("$cmd")
    fi
done

echo
echo "Optional dependencies:"
echo

# Special handling for 1Password agent (check socket, not just CLI)
if check_1password_agent; then
    # Socket exists
    :
else
    warn "1password-agent - NOT FOUND"
    MISSING_OPTIONAL+=("1password-agent")
fi

# Check optional dependencies
for cmd in "${OPTIONAL[@]}"; do
    if ! check_command "$cmd"; then
        warn "$cmd - NOT FOUND"
        MISSING_OPTIONAL+=("$cmd")
    fi
done

echo

# Report results
if [[ ${#MISSING_REQUIRED[@]} -eq 0 ]]; then
    success "All required dependencies are installed"

    if [[ ${#MISSING_OPTIONAL[@]} -gt 0 ]]; then
        echo
        info "Optional dependencies missing: ${MISSING_OPTIONAL[*]}"
    fi

    exit 0
else
    error "Missing required dependencies: ${MISSING_REQUIRED[*]}"
    exit 1
fi
