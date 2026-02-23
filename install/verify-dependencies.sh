#!/usr/bin/env bash
set -e

# Source shared utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

header "Verifying dependencies"

# Track missing dependencies
MISSING_REQUIRED=()
MISSING_OPTIONAL=()

# Check dependencies
check_dependencies() {
    for dep_spec in "${DEPENDENCIES[@]}"; do
        IFS=':' read -r dep dep_type <<< "$dep_spec"
        
        case "$dep_type" in
            special)
                check_special "$dep"
                ;;
            required)
                check_command_dep "$dep" required
                ;;
            optional)
                check_command_dep "$dep" optional
                ;;
        esac
    done
}

# Check a standard command dependency
check_command_dep() {
    local cmd="$1"
    local dep_type="$2"
    
    if command -v "$cmd" &> /dev/null; then
        local version
        version=$(get_version "$cmd")
        
        if [[ -n "$version" ]]; then
            success "$cmd v$version"
        else
            success "$cmd"
        fi
    else
        if [[ "$dep_type" == "required" ]]; then
            error "$cmd - NOT FOUND"
            MISSING_REQUIRED+=("$cmd")
        else
            warn "$cmd - NOT FOUND"
            MISSING_OPTIONAL+=("$cmd")
        fi
    fi
}

# Check special dependencies that aren't simple commands
check_special() {
    local dep="$1"
    
    case "$dep" in
        antidote)
            if brew list antidote &> /dev/null; then
                local version
                version=$(brew info antidote --json 2>/dev/null | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
                if [[ -n "$version" ]]; then
                    success "antidote v$version"
                else
                    success "antidote"
                fi
            else
                error "antidote - NOT FOUND"
                MISSING_REQUIRED+=("antidote")
            fi
            ;;
        1password-agent)
            local socket="$HOME/.1password/agent.sock"
            if [[ -S "$socket" ]]; then
                success "1password-agent"
            else
                warn "1password-agent - NOT FOUND"
                MISSING_OPTIONAL+=("1password-agent")
            fi
            ;;
        gh-dash)
            if gh extension list 2>/dev/null | grep -q "gh-dash"; then
                success "gh-dash"
            else
                warn "gh-dash - NOT FOUND (install: gh extension install dlvhdr/gh-dash)"
                MISSING_OPTIONAL+=("gh-dash")
            fi
            ;;
    esac
}

# Check all dependencies
check_dependencies

echo

# Report results
if [[ ${#MISSING_REQUIRED[@]} -eq 0 ]]; then
    success "All required dependencies are installed"
    
    if [[ ${#MISSING_OPTIONAL[@]} -gt 0 ]]; then
        info "Optional dependencies missing: ${MISSING_OPTIONAL[*]}"
    fi
    
    exit 0
else
    error "Missing required dependencies: ${MISSING_REQUIRED[*]}"
    exit 1
fi
