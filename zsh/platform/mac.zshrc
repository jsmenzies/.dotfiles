if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

alias upgrade >/dev/null 2>&1 && unalias upgrade

upgrade() {
  local failed=0

  if command -v brew >/dev/null 2>&1; then
    echo "==> Homebrew: update"
    brew update || failed=1
    echo "==> Homebrew: upgrade"
    brew upgrade || failed=1
    echo "==> Homebrew: upgrade casks"
    brew upgrade --cask || failed=1
    echo "==> Homebrew: cleanup"
    brew autoremove || failed=1
    brew cleanup || failed=1
  fi

  if command -v mise >/dev/null 2>&1; then
    echo "==> mise: update tools"
    mise up || failed=1
  fi

  if command -v npm >/dev/null 2>&1; then
    echo "==> npm: update global packages"
    npm update -g || failed=1
  fi

  if command -v rustup >/dev/null 2>&1; then
    echo "==> rustup: update"
    rustup update || failed=1
  fi

  if command -v antidote >/dev/null 2>&1; then
    echo "==> antidote: update"
    antidote update || failed=1
  fi

  return $failed
}
