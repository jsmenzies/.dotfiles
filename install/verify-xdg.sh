#!/usr/bin/env bash
set -e

# Source shared utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

header "Verifying XDG Base Directory specification"

# Required XDG environment variables
XDG_VARS=(
    "XDG_CONFIG_HOME"
    "XDG_CACHE_HOME"
    "XDG_DATA_HOME"
    "XDG_STATE_HOME"
)

ALL_SET=true

for var in "${XDG_VARS[@]}"; do
    if [[ -z "${!var}" ]]; then
        error "$var is not set"
        ALL_SET=false
    else
        success "$var=${!var}"
    fi
done

echo

if $ALL_SET; then
    success "All XDG directories are properly configured"
    exit 0
else
    error "Some XDG directories are missing"
    warn "Please ensure your shell environment sets these variables before running the install script."
    warn "They should be defined in your .zshenv or equivalent shell configuration file."
    exit 1
fi
