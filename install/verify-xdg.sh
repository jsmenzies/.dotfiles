#!/usr/bin/env bash
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

error()   { echo -e "${RED}✗${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }

echo "Verifying XDG Base Directory specification..."
echo

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
    echo
    warn "Please ensure your shell environment sets these variables before running the install script."
    warn "They should be defined in your .zshenv or equivalent shell configuration file."
    exit 1
fi
