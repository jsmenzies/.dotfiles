export ZSH="/Users/james/.oh-my-zsh"
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

ZSH_DISABLE_COMPFIX=true

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias upgrade='brew upgrade && omz update && rustup update'

source <(fzf --zsh)

[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh
[[ -f $ZDOTDIR/functions.zsh ]] && source $ZDOTDIR/functions.zsh

eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.local/bin:$PATH"

eval "$(zoxide init zsh)"