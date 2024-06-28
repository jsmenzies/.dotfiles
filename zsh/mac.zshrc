export ZSH="/Users/james/.oh-my-zsh"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    z
)

source $ZSH/oh-my-zsh.sh

alias upgrade='brew upgrade && omz update && rustup update'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f $HOME/.dotfiles/zsh/aliases.zsh ]] && source $HOME/.dotfiles/zsh/aliases.zsh
[[ -f $HOME/.dotfiles/zsh/functions.zsh ]] && source $HOME/.dotfiles/zsh/functions.zsh

eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
eval "$(/opt/homebrew/bin/mise activate zsh)"
