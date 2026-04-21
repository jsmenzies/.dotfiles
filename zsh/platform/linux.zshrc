if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

alias upgrade='sudo apt-get update && sudo apt-get upgrade -y && brew update && brew upgrade && brew cleanup -s && sudo apt-get autoremove -y'
