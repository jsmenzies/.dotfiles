if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# pi image paste in WSL: allow passing PI_WSL_CLIPBOARD_IMAGE_PATH to powershell.exe
case ":$WSLENV:" in
  *:PI_WSL_CLIPBOARD_IMAGE_PATH:*) ;;
  *) export WSLENV="PI_WSL_CLIPBOARD_IMAGE_PATH${WSLENV:+:$WSLENV}" ;;
esac

alias upgrade >/dev/null 2>&1 && unalias upgrade

function upgrade {
  local c_reset='\033[0m'
  local c_info='\033[1;36m'
  local c_step='\033[1;34m'
  local c_ok='\033[1;32m'
  local c_err='\033[1;31m'

  _upgrade_step() {
    local icon="$1"
    local label="$2"
    local command="$3"

    printf "%b%s %s%b\n" "$c_step" "$icon" "$label" "$c_reset"
    if eval "$command"; then
      printf "%b✓ %s complete%b\n" "$c_ok" "$label" "$c_reset"
      return 0
    fi

    printf "%b✗ %s failed%b\n" "$c_err" "$label" "$c_reset"
    return 1
  }

  printf "%b🚀 Running upgrade pipeline%b\n" "$c_info" "$c_reset"

  printf "%b🔐 sudo authentication%b\n" "$c_step" "$c_reset"
  if ! sudo -v; then
    printf "%b✗ sudo authentication failed%b\n" "$c_err" "$c_reset"
    return 1
  fi
  printf "%b✓ sudo authentication complete%b\n" "$c_ok" "$c_reset"

  _upgrade_step "📦" "APT packages" "sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y" || return 1
  _upgrade_step "🍺" "Homebrew packages" "brew update && brew upgrade" || return 1
  _upgrade_step "🟢" "npm globals" "npm update -g" || return 1
  _upgrade_step "🧹" "System cleanup" "brew cleanup -s" || return 1

  printf "%b✨ Upgrade finished successfully%b\n" "$c_ok" "$c_reset"
}
