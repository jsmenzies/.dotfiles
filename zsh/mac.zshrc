# zmodload zsh/zprof

export ZSH="/Users/james/.oh-my-zsh"
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Add brew completions
fpath+=("/opt/homebrew/share/zsh/site-functions")

# Only run full compinit once per day
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    z
)

source $ZSH/oh-my-zsh.sh

alias upgrade='brew upgrade && omz update && rustup update'

source <(fzf --zsh)

[[ -f $HOME/.dotfiles/zsh/aliases.zsh ]] && source $HOME/.dotfiles/zsh/aliases.zsh
[[ -f $HOME/.dotfiles/zsh/functions.zsh ]] && source $HOME/.dotfiles/zsh/functions.zsh

eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.local/bin:$PATH"

# zprof